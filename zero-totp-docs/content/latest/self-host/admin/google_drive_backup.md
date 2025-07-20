---
date: 2025-07-20T14:38:28Z

title: Enable Google Drive automatic backups for users
linkTitle : 'Google Drive backups'
weight: 5
cascade:
  type: docs
---

Zero-TOTP offers a very important feature to ensure the availability of your users' data: **automatic backups to Google Drive**. This feature allows users to automatically backup their data to their Google Drive account, ensuring that they can restore their data in case of loss, corruption or downtime. 

By default, this feature is disabled since it requires this tenant of Zero-TOTP to be authorized by the user to access their Google Drive account (via OAuth2).

## How to enable Google Drive backups
### 1 - Create an Oauth consent screen 
**Recommended : [Google documentation](https://developers.google.com/identity/protocols/oauth2) {{<icon "external-link">}}**
To enable Google Drive backups, you first need to create an OAuth consent screen. This screen is necessary for users to authorize your application to access their Google Drive account. Follow these steps:
1. Go to the [Google Cloud Console](https://console.cloud.google.com/).
2. Create a new project or select an existing one.
3. Navigate to the **APIs & Services** section.
4. Click on **OAuth consent screen** in the left sidebar.
5. Select the **External** user type.
6. Fill in the required fields such as **App name**, **User support email**, and **Developer contact information**.

### 2 - Register your application on Google Cloud
**Recommended : [Google documentation](https://developers.google.com/identity/protocols/oauth2) {{<icon "external-link">}}**


To enable Google Drive backups, you need to register your application on Google Cloud and obtain the necessary credentials. Follow these steps:
1. Go to the [Google Cloud Console](https://console.cloud.google.com/).
2. Select the project you created in the previous step.
3. Navigate to the **APIs & Services** section.
4. Click on **Credentials** in the left sidebar.
5. Click on **Create credentials** and select **OAuth client ID**.
6. Configure the consent screen by providing the necessary information (application name, support email, etc.).
7. Select **Web application** as the application type.
8. Add the following authorized Javascript origins:
   ```
   https://<your-domain>
   ```
   Replace `<your-domain>` with your actual domain name.
9. Add the following redirect URI:
   ```
   https://<your-domain>/api/v1/google-drive/oauth/callback
   ```
   Replace `<your-domain>` with your actual domain name.
9. Click on **Create** to generate your OAuth client ID and secret.
10. Download the JSON file containing your credentials. This file will be used to configure Zero-TOTP.

### 3 - Configure Google Drive access
1. Go to the [Google Cloud Console](https://console.cloud.google.com/).
2. Select the project you created in the previous step.
3. Navigate to the **APIs & Services** section.
4. Click on **Library** in the left sidebar.
5. Search for **Google Drive API** and click on it.
6. Click on the **Enable** button to enable the Google Drive API for your project.
7. Go back to **APIs & Services** and click on **Oauth Consent Screen** in the left sidebar.
8. Click on **Data Access** in the left sidebar.
9. Click on **Add or remove scopes**.
10. Add the following scopes:
    ```
    .../auth/drive.appdata
    .../auth/drive.file
    ```
11. Click on **Update** to save the changes.
12. Publish your OAuth consent screen by clicking on the **Publish App** button. You will need to fill in some additional information such as the application homepage, privacy policy URL, and terms of service URL. Google will review your application before it can be published. This process may take some time, so be patient. In the meantime, you can test the Google Drive backups feature in development mode. In development mode, only whitelisted users can use the Oauth consent screen. You can add users to the whitelist by going to the **OAuth consent screen** page in the Google Cloud Console and clicking on the **Test users** tab. Add the email addresses of the users you want to whitelist.

### 4 - Configure Zero-TOTP
1. Upload the JSON file containing your credentials to the Zero-TOTP server host. 
2. Mount the file into the Zero-TOTP API container. You can choose the path you want. The most convenient way is to use the already mounted `/api/config/` directory. 
3. Edit the `config.yml` file of your Zero-TOTP instance and configure the following fields : 
```yaml  {filename="config.yml (partial)"}
# [...]

features:
  google_drive_backup:
    enabled: true
    client_secret_file_path: "/api/config/your_client_secret_file.json" # Path to the JSON file containing your credentials

# [...]
```


