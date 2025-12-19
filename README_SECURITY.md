# Security Setup Guide

This document provides instructions on how to properly set up API keys and sensitive configuration files without committing them to the repository.

## ⚠️ Important Security Notice

Never commit sensitive API keys, credentials, or configuration files to version control. This repository has been configured to ignore sensitive files, but you must set them up locally.

## Required API Keys

This application requires the following API keys:

1. **Firebase API Key** (for authentication and Firestore)
2. **Google Maps API Key** (for location services)

## Setup Instructions

### 1. Firebase Configuration

#### For Android:

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project (or create a new one)
3. Navigate to Project Settings > Your Apps > Android
4. Download the `google-services.json` file
5. Place it in `android/app/google-services.json`
6. This file is automatically ignored by git

#### For iOS:

1. In the same Firebase Console project settings
2. Navigate to Project Settings > Your Apps > iOS
3. Download the `GoogleService-Info.plist` file
4. Place it in `ios/Runner/GoogleService-Info.plist`
5. This file is automatically ignored by git

### 2. Google Maps API Key

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select an existing one
3. Enable the following APIs:
   - Maps SDK for Android
   - Maps SDK for iOS
   - Places API
   - Geocoding API
4. Go to Credentials and create an API key
5. Restrict the API key:
   - For Android: Add your app's package name and SHA-1 certificate fingerprint
   - For iOS: Add your app's bundle identifier

#### Android Setup:

Edit `android/app/src/main/AndroidManifest.xml` and replace the placeholder:

```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_ACTUAL_GOOGLE_MAPS_API_KEY"/>
```

#### iOS Setup:

Edit `ios/Runner/AppDelegate.swift` and add:

```swift
import GoogleMaps

GMSServices.provideAPIKey("YOUR_ACTUAL_GOOGLE_MAPS_API_KEY")
```

## Environment Variables (Optional)

For additional security, you can use environment variables:

1. Create a `.env` file in the root directory (already ignored by git)
2. Add your keys:
   ```
   GOOGLE_MAPS_API_KEY=your_actual_key_here
   ```
3. Use a package like `flutter_dotenv` to load these values

## Best Practices

1. **Never commit real API keys** to version control
2. **Use different API keys** for development and production
3. **Restrict API keys** in the respective consoles to specific apps and IP addresses
4. **Rotate keys regularly** if you suspect they may have been exposed
5. **Use Firebase App Check** to protect your backend resources from abuse
6. **Enable billing alerts** in Google Cloud Console to monitor API usage

## What if I Accidentally Committed Keys?

If you accidentally committed API keys:

1. **Immediately revoke/delete the exposed keys** in Firebase Console and Google Cloud Console
2. **Generate new keys** and configure them locally
3. **Remove the keys from git history** using tools like `git filter-branch` or `BFG Repo-Cleaner`
4. **Force push** the cleaned history (⚠️ coordinate with your team first)
5. **Monitor your Firebase and Google Cloud usage** for any unauthorized activity

## Password Storage

This application uses Firebase Authentication for password management. Passwords are:

- **Never stored in Firestore** or any database
- Handled securely by Firebase Authentication
- Hashed and salted automatically by Firebase
- Never exposed in plain text

The `database.dart` service only stores non-sensitive user profile information (name, email, etc.).

## Questions or Issues?

If you have questions about security setup, please:

1. Check the [Firebase Documentation](https://firebase.google.com/docs)
2. Check the [Google Maps Platform Documentation](https://developers.google.com/maps/documentation)
3. Open an issue in this repository (without posting any actual keys!)

## Checklist

Before running the app, ensure:

- [ ] `android/app/google-services.json` is in place with your Firebase config
- [ ] `ios/Runner/GoogleService-Info.plist` is in place with your Firebase config
- [ ] Google Maps API key is configured in `AndroidManifest.xml`
- [ ] Google Maps API key is configured in iOS `AppDelegate.swift`
- [ ] All API keys are restricted in their respective consoles
- [ ] `.gitignore` is properly configured (already done in this repo)
- [ ] You've tested the app with your actual keys

---

**Remember: Security is everyone's responsibility!** 🔒