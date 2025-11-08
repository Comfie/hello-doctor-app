# Hello Doctor Mobile App - Setup Guide

## Overview

A modern, professional Flutter mobile application for the Hello Doctor healthcare platform. Built with GetX for state management and featuring a beautiful medical-themed UI.

## Features Implemented

✅ **Authentication System**
- Login with JWT token management
- User registration with comprehensive form
- Token refresh logic
- Secure token storage with flutter_secure_storage
- Splash screen with authentication check

✅ **Dashboard**
- Welcome card with user information
- Quick action cards for main features
- Statistics display (beneficiaries, prescriptions)
- Logout functionality
- Pull-to-refresh

✅ **Beneficiary Management**
- View all beneficiaries
- Add new beneficiary with full form
- Edit beneficiary details
- Delete beneficiary with confirmation
- Empty states and loading indicators

✅ **Prescription Management**
- Upload prescription with multiple images
- View all prescriptions with status badges
- Prescription details with image gallery
- Status history timeline
- Payment integration for pending prescriptions

✅ **Payment Integration**
- PayFast WebView integration
- Payment status polling
- Payment history with pagination
- Retry failed payments
- Transaction details

## Prerequisites

- Flutter SDK (3.3.4 or higher)
- Dart SDK (>=3.3.4 <4.0.0)
- Android Studio / Xcode for mobile development
- Hello Doctor API backend running

## Installation Steps

### 1. Install Dependencies

```bash
cd /home/user/hello-doctor-app
flutter pub get
```

### 2. Generate Model Adapters

Run build_runner to generate Hive adapters and JSON serialization:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

This will generate:
- `lib/app/data/models/auth_model.g.dart`

### 3. Configure API Base URL

Edit `lib/utils/constants.dart` and update the baseUrl:

**For Android Emulator:**
```dart
static const String baseUrl = 'http://10.0.2.2:5000/api/v1';
```

**For iOS Simulator:**
```dart
static const String baseUrl = 'http://localhost:5000/api/v1';
```

**For Production:**
```dart
static const String baseUrl = 'https://your-api-domain.com/api/v1';
```

### 4. Platform-Specific Configuration

#### Android

Add permissions to `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
```

#### iOS

Add permissions to `ios/Runner/Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>We need camera access to capture prescription images</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>We need gallery access to select prescription images</string>
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

### 5. Run the App

```bash
# For Android
flutter run

# For iOS
flutter run -d ios

# For specific device
flutter devices
flutter run -d <device-id>
```

## Project Structure

```
lib/
├── app/
│   ├── components/              # Reusable UI widgets
│   │   ├── api_error_widget.dart
│   │   ├── custom_loading_overlay.dart
│   │   ├── custom_snackbar.dart
│   │   └── my_widgets_animator.dart
│   ├── data/
│   │   ├── local/              # Local storage
│   │   │   ├── my_hive.dart
│   │   │   └── my_shared_pref.dart
│   │   └── models/             # Data models
│   │       ├── auth_model.dart
│   │       ├── beneficiary_model.dart
│   │       ├── payment_model.dart
│   │       ├── prescription_model.dart
│   │       └── user_model.dart
│   ├── modules/                # App screens (GetX modules)
│   │   ├── auth/
│   │   │   ├── bindings/
│   │   │   ├── controllers/
│   │   │   └── views/
│   │   ├── beneficiary/
│   │   ├── dashboard/
│   │   ├── payment/
│   │   ├── prescription/
│   │   └── splash/
│   ├── routes/                 # Navigation
│   │   ├── app_pages.dart
│   │   └── app_routes.dart
│   └── services/               # API services
│       ├── api_call_status.dart
│       ├── api_exceptions.dart
│       ├── auth_service.dart
│       ├── base_client.dart
│       ├── beneficiary_service.dart
│       ├── payment_service.dart
│       └── prescription_service.dart
├── config/
│   ├── theme/                  # App theming
│   │   ├── dark_theme_colors.dart
│   │   ├── light_theme_colors.dart
│   │   ├── my_fonts.dart
│   │   ├── my_styles.dart
│   │   └── my_theme.dart
│   └── translations/           # Localization
├── utils/                      # Utilities and constants
│   ├── awesome_notifications_helper.dart
│   ├── constants.dart
│   └── fcm_helper.dart
└── main.dart                   # App entry point
```

## App Flow

1. **Splash Screen** → Checks authentication
2. **Login/Register** → User authentication
3. **Dashboard** → Main hub with quick actions
4. **Beneficiaries** → Manage family members
5. **Prescriptions** → Upload and track prescriptions
6. **Payment** → Complete prescription payments via PayFast
7. **Payment History** → View all transactions

## API Services

### AuthService
- Login
- Register
- Token refresh
- Get user profile
- Update profile
- Logout

### BeneficiaryService
- Get all beneficiaries
- Create beneficiary
- Update beneficiary
- Delete beneficiary

### PrescriptionService
- Upload prescription with files
- Get prescription details
- Get all prescriptions

### PaymentService
- Initiate payment
- Get payment status
- Get payment history
- Poll payment status

## Theme

The app uses a professional medical theme:

**Light Mode:**
- Primary: Deep Professional Blue (#0D47A1)
- Accent: Fresh Medical Green (#00C853)
- Background: Soft Grey (#F5F7FA)

**Dark Mode:**
- Primary: Light Blue (#64B5F6)
- Accent: Light Green (#69F0AE)
- Background: Dark Grey (#121212)

## Testing

### Test User Registration
1. Open app → Click "Don't have an account? Register"
2. Fill in all required fields
3. Submit registration
4. Login with credentials

### Test Prescription Upload
1. Login → Dashboard
2. Click "Upload Prescription"
3. Select beneficiary
4. Pick images from gallery/camera
5. Set dates and notes
6. Upload

### Test Payment Flow
1. Upload prescription
2. Wait for status to become "Payment Pending"
3. View prescription details
4. Click "Make Payment"
5. Complete payment in PayFast WebView
6. Payment status will be polled automatically

## Troubleshooting

### Build Runner Errors
```bash
flutter clean
flutter pub get
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

### Network Errors
- Check API baseUrl in constants.dart
- Ensure API backend is running
- For Android emulator, use 10.0.2.2 instead of localhost
- Check internet permissions in AndroidManifest.xml

### Image Picker Not Working
- Check camera/gallery permissions
- For iOS, ensure Info.plist has usage descriptions
- For Android, ensure permissions in AndroidManifest.xml

## Environment Configuration

Create a `.env` file for different environments (optional):

```env
API_BASE_URL=http://10.0.2.2:5000/api/v1
PAYFAST_SANDBOX=true
```

## Build for Release

### Android
```bash
flutter build apk --release
# Or for app bundle
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## Next Steps

1. Connect to your Hello Doctor API backend
2. Test all features with real data
3. Configure Firebase for push notifications
4. Add analytics
5. Perform security audit
6. Submit to app stores

## Support

For issues or questions:
1. Check IMPLEMENTATION_GUIDE.md for detailed implementation info
2. Review API documentation in FLUTTER_API_GUIDE.md
3. Check code examples in FLUTTER_CODE_EXAMPLES.md

## License

Copyright © 2025 Hello Doctor. All rights reserved.
