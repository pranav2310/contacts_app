# IOCL-Contacts

## Features
  - Employee Information Lookup: Search for Employees using there Employee ID and find there contact Information, Department and Current Location.
  - QR Code Generation: Instantly Generates Contacts QR Card for easy share.
  - Save Contacts: (Android/iOS) Save employee info directly to your device’s contact list.
  - Copy to Clipboard: (Web) Copy contact info with a single click.
  - Share Contact: (Android/iOS) Share contact details via other apps.
  - Fallback Demo Data: Displays demo profile if the API call fails or CORS blocks the request.
  - Responsive UI: Clean, modern, and interactive design for all screen sizes.

## Getting Started
  ### Prerequisites
  - Flutter SDK
  - Android Studio
  ### Instalation
  - Clone The Repository
    ```bash
    git clone https://github.com/pranav2310/IOCL-Contacts.git
    cd IOCL-Contacts
  - Install Dependencies
    ```bash
    flutter pub get
  - Run the App
    ```bash
    flutter run
  - Building APK
    ```bash
    flutter build apk --release
##Configuration
- App Icon: Set using flutter_launcher_icons.
- Assets: Profile fallback images and logos must be listed in `pubspec.yaml` under `assets:`.

##Tech Stack
- Flutter (UI, cross-platform)
- flutter_contacts (contact saving)
- qr_flutter (QR code generation)
- share_plus (sharing on mobile)
- http (API calls)
- xml (optional, for XML API responses)

##Troubleshooting
- CORS Errors (Web): Demo data is shown if the API cannot be fetched due to CORS restrictions.
- App Icon Not Updating: Run `flutter pub run flutter_launcher_icons` and do a full rebuild.

## Screenshots
  <!-- Add screenshots here if available --> 
  <p align="center"> 
    <h3>IOS App</h3>
    <span>Start Screen</span>
    <img src="/assets/screenshots/IOSAppStartScreen.png" width="250"/>
    <span>Input</span>
    <img src="/assets/screenshots/IOSAppInput.png" width="250"/> 
    <span>Enter Valid Employee ID</span>
    <img src="/assets/screenshots/IOSAppInvalidInput.png" width="250"/> 
    <span>Employee Profile</span>
    <img src="/assets/screenshots/IOSAppEmployeeProfile.png" width="250"/> 
    <span>QR Pop Up Display</span>
    <img src="/assets/screenshots/IOSAppQRDisplay.png" width="250"/> 
    <span>Sharing Contact via other apps</span>
    <img src="/assets/screenshots/IOSAppContactSharing.png" width="250"/> 
    <span>Saving Contact to Current Device</span>
    <img src="/assets/screenshots/IOSAppContactSave.png" width="250"/> 
    <img src="/assets/screenshots/IOSAppContactSaved.png" width="250"/> 
    <h3>Web App</h3>
    <span>Start Screen</span>
    <img src="/assets/screenshots/WebAppStartScreen.png" width="250"/> 
    <span>Demo Data (CORS Error / Error in Fetching Data)</span>
    <img src="/assets/screenshots/WebAppDemoData.png" width="250"/> 
    <span>QR Code for the Contact</span>
    <img src="/assets/screenshots/WebAppQRCode.png" width="250"/> 
    <span>Contact Copied to clipboard</span>
    <img src="/assets/screenshots/WebAppCopiedtoClipboard.png" width="250"/> 
  </p>
