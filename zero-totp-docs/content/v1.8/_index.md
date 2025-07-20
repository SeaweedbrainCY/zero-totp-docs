---
date: 2025-07-09T21:22:19+00:00

title: 'Zero-TOTP Documentation'
layout: hextra-home
---

{{< hextra/hero-badge >}}
  <div class="hx:w-2 hx:h-2 hx:rounded-full hx:bg-primary-400"></div>
  <span>Free, open source, self-hosted</span>
  {{< icon name="arrow-circle-right" attributes="height=14" >}}
{{< /hextra/hero-badge >}}

<div class="hx:mt-6 hx:mb-6">
{{< hextra/hero-headline >}}
  Store your TOTP codes  &nbsp;<br class="hx:sm:block hx:hidden" />in a safe place
{{< /hextra/hero-headline >}}
</div>

<div class="hx:mb-12">
{{< hextra/hero-subtitle >}}
  Zero-TOTP is a 100% open-source, self-hostable and 
 &nbsp;<br class="hx:sm:block hx:hidden" />a Zero-Knowledge Infrastructure platform for storing TOTP codes.
{{< /hextra/hero-subtitle >}}
</div>
&nbsp;<br class="hx:sm:block hx:hidden" 
<div class="hx:mb-6">
{{< hextra/hero-button text="Get Started" link="./latest/self-host" >}}
</div>
&nbsp;<br class="hx:sm:block hx:hidden" >
<div class="hx:mt-6"></div>

{{< hextra/feature-grid >}}
  {{< hextra/feature-card
    title="Zero-Knowledge Encryption"
    subtitle="Zero-Knowledge Encryption ensures that TOTP codes are always encrypted client-side, meaning that even the server cannot access the user's TOTP codes. This provides the highest level of security and privacy for users. No one but the user can access their TOTP codes."
    class="hx:aspect-auto hx:md:aspect-[1.1/1] hx:max-md:min-h-[340px]"
    imageClass="hx:top-[40%] hx:left-[24px] hx:w-[180%] hx:sm:w-[110%] hx:dark:opacity-80"
    style="background: radial-gradient(ellipse at 50% 80%,rgba(194,97,254,0.15),hsla(0,0%,100%,0));"
  >}}
  {{< hextra/feature-card
    title="Self-Hosted and Free"
    subtitle="Zero-TOTP is self-hostable and free to use. Users can host their own instance of Zero-TOTP on their own server or use a hosted version. This gives users full control over their TOTP codes and ensures that they are not stored on third-party servers."
    class="hx:aspect-auto hx:md:aspect-[1.1/1] hx:max-lg:min-h-[340px]"
    imageClass="hx:top-[40%] hx:left-[36px] hx:w-[180%] hx:sm:w-[110%] hx:dark:opacity-80"
    style="background: radial-gradient(ellipse at 50% 80%,rgba(142,53,74,0.15),hsla(0,0%,100%,0));"
  >}}
  {{< hextra/feature-card
    title="A rescue platform as failover"
    subtitle="rescue.zero-totp.com is a failover platform that allows users to access their TOTP codes in case they lose access to their primary Zero-TOTP instance from a backup file. It provides a secure and encrypted way to retrieve TOTP codes when needed."
    class="hx:aspect-auto hx:md:aspect-[1.1/1] hx:max-md:min-h-[340px]"
    imageClass="hx:top-[40%] hx:left-[36px] hx:w-[110%] hx:sm:w-[110%] hx:dark:opacity-80"
    style="background: radial-gradient(ellipse at 50% 80%,rgba(221,210,59,0.15),hsla(0,0%,100%,0));"
  >}}
  {{< hextra/feature-card
    title="Automatic backups to external cloud storage"
    subtitle="Users can set up automatic backups to Google Drive to always have a secure, encrypted copy of their TOTP codes. This ensures that even if the user loses access to their device, they can still recover their codes."
  >}}
  {{< hextra/feature-card
    title="Fully encrypted and secure"
    subtitle="Based on AES-256 encryption and strong key derivation client-side, Zero-TOTP ensures that your TOTP codes are stored securely and can only be accessed by the user."
  >}}
  {{< hextra/feature-card
    title="100% open-source"
    subtitle="Zero-TOTP is 100% open-source, self-hostable and free to use. The source code is available on GitHub for anyone to review, contribute or host it themselves."
  >}}
  {{< hextra/feature-card
    title="And Much More..."
    icon="sparkles"
    subtitle="Zero-TOTP is packed with amazing security features and a lot are coming soon! If you like the project, please leave a star on GitHub and consider contributing to the project. Your support helps us to keep improving Zero-TOTP and adding new features."
  >}}
{{< /hextra/feature-grid >}}