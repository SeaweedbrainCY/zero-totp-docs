---
date: 2026-01-20T17:57:30+00:00
title: "v1.12 : Session Management Changes in Zero-TOTP"
linkTitle: "v1.12 Session management"
description: ""
draft: false
cascade:
  type: blog
---

Zero-TOTP v1.12 introduces important change regarding the session management. Self-hoster should review those modification before upgrading.

<!--more-->

## TL;DR

* Refresh tokens are now **renewable**
* A new **session** concept enforces a **hard re-login deadline**
* `session_validity` defines **when re-authentication becomes mandatory**
* `refresh_token_validity` defines **maximum inactivity time**
* Default values allow users to stay logged in longer → **self-hosters should review them**
* Security remains strong, but **defaults now favor usability**

---

> ⚠️ **Important notice for self-hosted instances**  
> This release introduces a **significant change to the default session behavior** of Zero-TOTP.  
> While it greatly improves user experience, it also **changes the effective authentication lifetime by default**.  
> Self-hosters **must review and adjust their configuration** if the new defaults do not align with their security requirements.

---

## High-level overview

Until now, Zero-TOTP enforced periodic re-authentication through **non-extendable refresh tokens**.  
This guaranteed a hard upper bound on how long a user could stay logged in, but it also meant frequent re-logins, even for active users.

With this update, Zero-TOTP introduces the concept of **sessions** as a first-class security object.

The result:
- Users can stay logged in **much longer without friction**
- Administrators gain **much finer control** over authentication behavior
- A **hard re-authentication deadline** is still enforced, regardless of token renewal

This strikes a better balance between **usability** and **security**, but it also means that **default behavior has changed**.

---

## How sessions worked before

Previously, Zero-TOTP relied on two tokens:

- **Session token**
  - Short-lived
  - Used for authentication
- **Refresh token**
  - Longer-lived
  - Used to renew the session token
  - **Expiration not extenable**

Once the refresh token expired, the user **had to re-authenticate**, regardless of activity.

Configuration was controlled by:

```yaml
api:
  session_token_validity: <duration>
  refresh_token_validity: <duration>
````

This meant:

* The **maximum login duration** was equal to `refresh_token_validity`
* Active users were still forced to log back in periodically

---

## What has changed

### 1. Refresh tokens are now extendable

Refresh tokens are no longer single-use.

* When a session token is renewed:
  * A **new refresh token** is issued
  * Its validity duration is reset
* As long as the user remains active, refresh tokens can be continuously renewed

This removes unnecessary re-logins for active users.

---

### 2. Introduction of sessions

Session tokens and refresh tokens now belong to a **session**.

A session:

* Has its **own expiration**
* **Cannot be extended**
* Represents the **absolute maximum authentication lifetime**

Once a session expires, the user **must re-authenticate**, no matter what.

A new configuration parameter is introduced:

```yaml
api:
  session_validity: <duration>
```

---

## Understanding the new model

You now have **three independent time boundaries**:

| Component     | Purpose                                   |
| ------------- | ----------------------------------------- |
| Session token | Short-lived authentication token          |
| Refresh token | Renewable token, expires after inactivity |
| Session       | Non-extendable authentication lifetime    |

### Practical behavior

Let:

* `x` = `refresh_token_validity`
* `y` = `session_validity`

Then:

* If a user **uses Zero-TOTP at least once every `x`**, they stay logged in
* Regardless of activity, they **must re-authenticate after `y`**
* If a user is inactive for `x`, they must re-authenticate **even if `y` is not reached**

This provides **very fine-grained control** over authentication behavior.

---

## Security implications for self-hosters

🚨 **This is the most important part of this announcement**

Because refresh tokens are now extendable:

* The **effective login duration is longer by default**
* Users can remain authenticated for the entire `session_validity`

This is **not a security issue**, but it **does change the default security posture**.

### What you should do

If you self-host Zero-TOTP:

* **Review your `api.session_validity`**
* Reduce it if the default duration is too permissive for your environment
* Treat it as the new **mandatory re-login deadline**

In short:

> **`session_validity` now defines when re-authentication is unavoidable.**



---

## Default and recommended values

This section describes the default values shipped with Zero-TOTP and the recommended ranges for each parameter.
Self-hosters should tune these values according to their **security posture**, **user behavior**, and **threat model**.

---

### Session token validity

- **Default value:** 10 minutes (600 seconds)
- **Recommended range:** 5 to 15 minutes (300–900 seconds)

The session token (access token) is used to authenticate API requests and is intentionally short-lived.
Its primary purpose is to limit the impact of token leakage.

**Recommendations:**

* Shorter durations increase security
* Longer durations reduce token refresh frequency
* The default value provides a good balance between security and performance for most deployments

---

### Refresh token validity

- **Default value:** 1 day (86,400 seconds)
- **Recommended range:** 1 to 7 days (86,400–604,800 seconds)

The refresh token defines the **maximum inactivity window**.
If a user does not use Zero-TOTP for longer than this duration, they must re-authenticate, even if the session is still valid.

**Recommendations:**

* Treat this value as an inactivity timeout
* Lower values are recommended for high-security environments
* Higher values improve usability for infrequent users

---

### Session validity

- **Default value:** 7 days (604,800 seconds)
- **Recommended range:** 24 hours to 30 days (86,400–2,592,000 seconds)

Session validity defines the **absolute maximum authentication lifetime**.
Once this duration is reached, the user must log in again, regardless of token renewal or activity.

This value **cannot be extended** and acts as a hard re-authentication deadline.

**⚠️ Security considerations:**

* This parameter now determines how long a user can stay logged in without re-authenticating
* Increasing it improves user experience but extends authentication lifetime
* This is the **most critical value to review when self-hosting Zero-TOTP**

---

### Summary of responsibilities

* Session token validity controls **short-term exposure**
* Refresh token validity controls **maximum inactivity**
* Session validity controls **mandatory re-authentication**

Together, these parameters provide fine-grained control over authentication behavior while preserving strong security guarantees.


---

## Zero-Knowledge reminder

Zero-TOTP uses **Zero-Knowledge Encryption**.

This means:

* Even with a valid session, the user may still be prompted for their password
* This is **not re-authentication**
* It is only required to **decrypt the vault locally**

Authentication state and vault decryption are intentionally separate.

---

## What’s next

In upcoming versions:

* Users will be able to **view active sessions**
* Revoke sessions individually
* Better understand where and how they are logged in

Additional security mechanisms have also been introduced around session handling.
For technical details, see **PR #364**.

---

## Configuration reference

For full configuration details and examples, refer to the documentation:

➡️ **[Configuration reference](https://docs.zero-totp.com/latest/self-host/customization/)**

---

## Summary

* Refresh tokens are now extendable
* Sessions introduce a hard, non-extendable authentication limit
* `api.session_validity` is now **critical**
* Default behavior favors usability, but **self-hosters must review it**
* Security guarantees remain strong and explicit

If you self-host Zero-TOTP, **please review your configuration after upgrading**.
