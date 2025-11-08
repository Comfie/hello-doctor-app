# Hello Doctor - Mobile Healthcare Application

<img src="preview_images/app_icon.png" width="120" height="120">

A comprehensive Flutter mobile application for healthcare management, enabling users to manage prescriptions, beneficiaries, payments, and medical records with a modern, user-friendly interface.

## Table of Contents
- [Features](#features)
- [Screenshots](#screenshots)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Running the App](#running-the-app)
- [Building for Production](#building-for-production)
- [API Integration](#api-integration)
- [App Features Guide](#app-features-guide)
- [Theme & Localization](#theme--localization)
- [Testing](#testing)
- [Troubleshooting](#troubleshooting)

## Features

### 🔐 Authentication & Authorization
- **User Registration**: Complete registration with personal details, ID verification, and secure password setup
- **Secure Login**: JWT-based authentication with token refresh mechanism
- **Password Management**: Change password functionality with strength validation
- **Secure Token Storage**: Flutter Secure Storage for sensitive authentication tokens
- **Auto Session Management**: Automatic token refresh and session expiry handling

### 👥 Beneficiary Management
- **Add Beneficiaries**: Register family members or dependents
- **Manage Beneficiaries**: View, edit, and delete beneficiary information
- **Relationship Tracking**: Define relationships (spouse, child, parent, etc.)
- **Medical Information**: Store beneficiary medical details and ID numbers

### 💊 Prescription Management
- **Upload Prescriptions**: Scan and upload prescription images (up to 25MB)
- **View Prescription History**: Browse all uploaded prescriptions
- **Prescription Details**: View detailed prescription information including:
  - Prescription images
  - Doctor information
  - Medication details
  - Prescription date and status
- **Track Status**: Monitor prescription processing status

### 💳 Payment Processing
- **Secure Payments**: Process payments for prescriptions and medical services
- **Payment History**: View complete payment transaction history
- **Payment Status Tracking**: Real-time payment status updates
- **Transaction Details**: Detailed payment information including:
  - Transaction ID
  - Amount
  - Date and time
  - Payment method
  - Status (pending, completed, failed)

### 👤 Profile Management
- **View Profile**: Display user information and medical records
- **Edit Profile**: Update personal information (name, phone, address)
- **Change Password**: Secure password change with validation
- **Profile Picture**: Avatar with user initials

### ⚙️ Settings & Preferences
- **Theme Selection**: Choose between Light, Dark, or System theme
- **Language Support**: Multi-language support (English/Arabic)
- **Notification Settings**: Manage push notification preferences
- **App Preferences**: Customize app behavior

### 📱 Modern UI/UX
- **Material Design 3**: Clean, modern interface following Material Design guidelines
- **Dark Mode**: Full dark mode support with smooth transitions
- **Responsive Design**: Adapts to different screen sizes using flutter_screenutil
- **Smooth Animations**: Polished animations and transitions
- **Custom Components**: Reusable UI components and widgets

### 🔔 Notifications
- **Push Notifications**: Firebase Cloud Messaging integration
- **Local Notifications**: In-app notifications using Awesome Notifications
- **Notification History**: View all notifications

### 📄 Information Pages
- **About**: App information and version details
- **Terms of Service**: Legal terms and conditions
- **Privacy Policy**: Data privacy and security information

## Screenshots

*Coming soon - Add your app screenshots here*

## Tech Stack

### Core Framework
- **Flutter SDK**: >=3.3.4 <4.0.0
- **Dart**: Modern, type-safe programming language

### State Management & Architecture
- **GetX** (^4.6.6): State management, dependency injection, and routing
- **GetX Pattern**: Clean architecture with separation of concerns

### UI & Styling
- **flutter_screenutil** (^5.9.3): Responsive UI design
- **Material Design 3**: Latest Material Design guidelines
- **Custom Themes**: Dynamic light/dark theme support
- **flutter_svg**: SVG vector graphics support

### Networking & API
- **Dio** (^5.4.3+1): HTTP client for API requests
- **pretty_dio_logger** (^1.3.1): API request/response logging
- **http_mock_adapter** (^0.6.1): API mocking for testing

### Data Persistence
- **Hive** (^2.2.3): Fast, lightweight local database
- **hive_flutter** (^1.1.0): Hive integration for Flutter
- **shared_preferences** (^2.2.3): Simple key-value storage
- **flutter_secure_storage**: Secure token storage

### Firebase Integration
- **firebase_core** (^3.0.0): Firebase initialization
- **firebase_messaging** (^15.0.0): Push notifications

### Notifications
- **awesome_notifications** (^0.9.3+1): Rich local and push notifications

### Utilities
- **logger** (^2.3.0): Enhanced logging capabilities
- **cupertino_icons** (^1.0.8): iOS-style icons

### Development Tools
- **flutter_launcher_icons**: Custom app icon generation
- **change_app_package_name**: Package name modification
- **rename_app** (1.4.0): App name modification
- **flutter_lints**: Code quality and linting
- **mockito**: Mocking for unit tests
- **build_runner**: Code generation
- **hive_generator**: Hive model generation

## Project Structure

```
lib/
├── app/
│   ├── components/              # Reusable UI components
│   │   ├── app_drawer.dart     # Navigation drawer
│   │   └── custom_snackbar.dart # Custom snackbar widget
│   │
│   ├── data/                   # Data layer
│   │   ├── local/              # Local storage
│   │   │   ├── my_hive.dart    # Hive database helper
│   │   │   └── my_shared_pref.dart # SharedPreferences helper
│   │   │
│   │   └── models/             # Data models
│   │       ├── auth_model.dart
│   │       ├── beneficiary_model.dart
│   │       ├── payment_model.dart
│   │       ├── prescription_model.dart
│   │       └── user_model.dart
│   │
│   ├── modules/                # Feature modules
│   │   ├── splash/            # Splash screen
│   │   ├── auth/              # Authentication (login/register)
│   │   ├── dashboard/         # Home dashboard
│   │   ├── beneficiary/       # Beneficiary management
│   │   ├── prescription/      # Prescription management
│   │   ├── payment/           # Payment processing
│   │   ├── profile/           # User profile
│   │   ├── settings/          # App settings
│   │   └── about/             # About, Terms, Privacy
│   │
│   ├── routes/                 # Navigation routes
│   │   ├── app_pages.dart     # Route definitions
│   │   └── app_routes.dart    # Route names
│   │
│   └── services/              # Business logic services
│       ├── auth_service.dart
│       ├── beneficiary_service.dart
│       ├── payment_service.dart
│       ├── prescription_service.dart
│       ├── base_client.dart   # HTTP client wrapper
│       ├── api_call_status.dart
│       └── api_exceptions.dart
│
├── config/                     # App configuration
│   ├── theme/                 # Theme configuration
│   │   ├── light_theme_colors.dart
│   │   ├── dark_theme_colors.dart
│   │   ├── my_theme.dart
│   │   ├── my_styles.dart
│   │   └── my_fonts.dart
│   │
│   └── translations/          # Localization
│       ├── localization_service.dart
│       ├── strings_enum.dart
│       ├── en_US/
│       └── ar_AR/
│
├── utils/                      # Utilities and helpers
│   ├── constants.dart         # App constants
│   ├── awesome_notifications_helper.dart
│   └── fcm_helper.dart
│
└── main.dart                  # App entry point
```

### Module Structure (GetX Pattern)

Each module follows this structure:
```
module_name/
├── bindings/           # Dependency injection
├── controllers/        # Business logic (GetX Controllers)
└── views/             # UI screens
```

## Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK**: 3.3.4 or higher
  ```bash
  flutter --version
  ```

- **Dart SDK**: Included with Flutter

- **Android Studio** or **Xcode** (for iOS development)

- **Git**: For version control

- **Backend API**: The app requires a backend API server (see [API Integration](#api-integration))

## Installation

### 1. Clone the Repository

```bash
git clone <your-repository-url>
cd hello-doctor-app
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Generate Required Files

```bash
# Generate Hive adapters
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### 4. Verify Installation

```bash
flutter doctor
```

Fix any issues reported by `flutter doctor`.

## Configuration

### 1. Configure App Identity

#### Change App Name
```bash
flutter pub run rename_app:main all="Your App Name"
```

#### Change Package Name
```bash
flutter pub run change_app_package_name:main com.yourcompany.yourapp
```

#### Change App Icon
1. Replace `assets/images/app_icon.png` with your icon (1024x1024 recommended)
2. Run:
```bash
flutter pub run flutter_launcher_icons:main
```

### 2. Configure API Backend

Edit `lib/utils/constants.dart`:

```dart
class Constants {
  // For Android Emulator
  static const String baseUrl = 'http://10.0.2.2:5000/api/v1';

  // For iOS Simulator
  // static const String baseUrl = 'http://localhost:5000/api/v1';

  // For Production
  // static const String baseUrl = 'https://your-api-domain.com/api/v1';
}
```

**Important**:
- Android Emulator uses `10.0.2.2` to access host machine's localhost
- iOS Simulator can use `localhost` directly
- Physical devices require your computer's IP address or production URL

### 3. Configure Firebase (Optional for Push Notifications)

1. Install Firebase CLI:
```bash
curl -sL https://firebase.tools | bash
```

2. Login to Firebase:
```bash
firebase login
```

3. Install FlutterFire CLI:
```bash
dart pub global activate flutterfire_cli
```

4. Configure Firebase:
```bash
flutterfire configure --project=your-firebase-project-id
```

This will automatically:
- Create Firebase configuration files
- Set up iOS and Android apps
- Configure Firebase Messaging

**Note**: Firebase is optional. The app can work without FCM by commenting out Firebase initialization in `main.dart`.

### 4. Configure Screen Size

Edit `lib/main.dart` to match your design artboard size:

```dart
ScreenUtilInit(
  designSize: const Size(375, 812), // Your design dimensions (width, height)
  minTextAdapt: true,
  splitScreenMode: true,
  child: MyApp(),
)
```

Common sizes:
- iPhone X/11/12: 375 x 812
- iPhone 8: 375 x 667
- Android (common): 360 x 640

## Running the App

### Development Mode

#### Android
```bash
flutter run
```

#### iOS
```bash
# Make sure you're on macOS and have Xcode installed
flutter run -d ios
```

#### Specific Device
```bash
# List available devices
flutter devices

# Run on specific device
flutter run -d <device-id>
```

### Debug Mode with Hot Reload

```bash
flutter run --debug
```

Press `r` for hot reload, `R` for hot restart.

### Profile Mode (Performance Testing)

```bash
flutter run --profile
```

## Building for Production

### Android APK

```bash
# Build APK
flutter build apk --release

# Build split APKs per ABI (smaller size)
flutter build apk --split-per-abi --release

# Output: build/app/outputs/flutter-apk/app-release.apk
```

### Android App Bundle (for Google Play)

```bash
flutter build appbundle --release

# Output: build/app/outputs/bundle/release/app-release.aab
```

### iOS

```bash
# Make sure you have a valid provisioning profile
flutter build ios --release

# Then open Xcode to archive and upload
open ios/Runner.xcworkspace
```

## API Integration

### Backend Requirements

The app expects a REST API with the following endpoints:

#### Authentication
- `POST /api/v1/authentication/login` - User login
- `POST /api/v1/authentication/create` - User registration
- `POST /api/v1/authentication/refresh-token` - Refresh JWT token
- `GET /api/v1/authentication/get-user-by-id/:id` - Get user details
- `PUT /api/v1/authentication/update-user` - Update user profile

#### Beneficiaries
- `GET /api/v1/beneficiary/get-all-beneficiaries` - List all beneficiaries
- `GET /api/v1/beneficiary/get-beneficiary/:id` - Get beneficiary details
- `POST /api/v1/beneficiary/create` - Create beneficiary
- `PUT /api/v1/beneficiary/update-beneficiary` - Update beneficiary
- `DELETE /api/v1/beneficiary/delete-beneficiary/:id` - Delete beneficiary

#### Prescriptions
- `POST /api/v1/prescription/upload-file` - Upload prescription (multipart/form-data)
- `GET /api/v1/prescription/:id` - Get prescription details
- `GET /api/v1/prescription/get-all-prescriptions` - List prescriptions

#### Payments
- `POST /api/v1/payment/initiate` - Initiate payment
- `GET /api/v1/payment/:id/status` - Check payment status
- `GET /api/v1/payment/history` - Get payment history

### Authentication Flow

The app uses JWT-based authentication:

1. User logs in with email/password
2. Backend returns JWT token, refresh token, and expiry time
3. App stores tokens securely using Flutter Secure Storage
4. All API requests include `Authorization: Bearer <token>` header
5. Token auto-refreshes before expiry

### API Response Format

Expected response format:
```json
{
  "isSuccess": true,
  "message": "Success message",
  "value": {
    // Response data
  }
}
```

## App Features Guide

### First Time Setup

1. **Launch App**: Opens to splash screen
2. **Login/Register**:
   - New users: Tap "Register" and fill in required details
   - Existing users: Enter email and password
3. **Dashboard**: Main screen with quick action cards

### Using the Dashboard

The dashboard provides quick access to:
- **Upload Prescription**: Scan and upload prescriptions
- **Manage Beneficiaries**: Add/edit family members
- **View Prescriptions**: Access prescription history
- **Payment History**: View transaction records
- **Profile**: Manage your account

### Managing Beneficiaries

1. Navigate to **Beneficiaries** from drawer or dashboard
2. Tap **+** to add a new beneficiary
3. Fill in:
   - First Name, Last Name
   - ID Number
   - Date of Birth
   - Gender
   - Relationship
4. Save beneficiary

### Uploading Prescriptions

1. Tap **Upload Prescription** on dashboard
2. Select beneficiary (or self)
3. Choose image source (camera/gallery)
4. Add optional notes
5. Upload (max 25MB)
6. Track status in Prescription List

### Making Payments

1. View prescription details
2. Tap **Make Payment**
3. Review payment details
4. Confirm payment
5. Track in Payment History

### Profile Management

- **View Profile**: See all your information
- **Edit Profile**: Update name, phone, address
- **Change Password**: Secure password update with validation

### Settings & Preferences

**Theme Options**:
- **Light**: Light color scheme
- **Dark**: Dark color scheme
- **System**: Follow device settings

**Language Options**:
- English
- Arabic (RTL support)

## Theme & Localization

### Changing Theme

Programmatically:
```dart
// Toggle theme
MyTheme.changeTheme();

// Check current theme
bool isLight = MyTheme.getThemeIsLight();
```

User Interface:
- Navigate to **Settings**
- Tap on **Theme** card
- Select: System / Light / Dark

### Dark Mode Features

The app includes comprehensive dark mode support:
- All screens adapt to selected theme
- Smooth theme transitions
- System theme integration
- Persistent theme preference

### Adding Translations

1. Add keys to `lib/config/translations/strings_enum.dart`:
```dart
class Strings {
  static const String hello = 'hello';
  static const String welcome = 'welcome';
}
```

2. Add translations in `lib/config/translations/en_US/en_us_translation.dart`:
```dart
const Map<String, String> enUs = {
  Strings.hello: 'Hello',
  Strings.welcome: 'Welcome',
};
```

3. Add Arabic in `lib/config/translations/ar_AR/ar_ar_translation.dart`:
```dart
final Map<String, String> arAR = {
  Strings.hello: 'مرحباً',
  Strings.welcome: 'أهلاً',
};
```

4. Use in code:
```dart
Text(Strings.hello.tr)
```

### Changing Language

```dart
LocalizationService.updateLanguage('en');
// or
LocalizationService.updateLanguage('ar');
```

## Testing

### Run All Tests

```bash
flutter test
```

### Unit Tests

```bash
flutter test test/unit/
```

### Integration Tests

```bash
flutter test integration_test/
```

### Test Coverage

```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

## Troubleshooting

### Common Issues

#### 1. White Screen on Startup

**Problem**: App shows white screen after splash

**Solution**:
- Check backend API is running
- Verify API URL in `constants.dart`
- Check network permissions in `AndroidManifest.xml`

#### 2. Android Network Permission

**Problem**: API calls fail on Android

**Solution**: Add to `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.INTERNET" />
```

#### 3. iOS API Calls Fail

**Problem**: API requests blocked on iOS

**Solution**: Add to `ios/Runner/Info.plist`:
```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

**Note**: For production, use HTTPS instead of allowing arbitrary loads.

#### 4. Build Runner Conflicts

**Problem**: Build runner generation fails

**Solution**:
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

#### 5. Firebase Configuration Issues

**Problem**: Firebase errors on startup

**Solution**:
- Ensure `firebase_options.dart` exists
- Run `flutterfire configure` again
- Or comment out Firebase initialization in `main.dart` if not needed

#### 6. Gradle Build Fails

**Problem**: Android build fails with Gradle errors

**Solution**:
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

#### 7. CocoaPods Issues (iOS)

**Problem**: iOS build fails with pod errors

**Solution**:
```bash
cd ios
pod deintegrate
pod install
cd ..
flutter clean
flutter pub get
```

## Responsive Design

The app uses `flutter_screenutil` for responsive layouts:

```dart
// Width
Container(width: 200.w)  // Adapts to screen width

// Height
Container(height: 100.h)  // Adapts to screen height

// Font Size
Text('Hello', style: TextStyle(fontSize: 16.sp))

// Radius
BorderRadius.circular(12.r)
```

## Safe API Calls

The app uses a wrapper for safe API calls with automatic error handling:

```dart
await BaseClient.safeApiCall(
  Constants.loginUrl,
  RequestType.post,
  data: {'email': email, 'password': password},
  onLoading: () {
    apiCallStatus = ApiCallStatus.loading;
    update();
  },
  onSuccess: (response) {
    // Handle success
    apiCallStatus = ApiCallStatus.success;
    update();
  },
  onError: (error) {
    // Handle error
    BaseClient.handleApiError(error);
    apiCallStatus = ApiCallStatus.error;
    update();
  },
);
```

## State Management with GetX

### Controllers

```dart
class MyController extends GetxController {
  // Observable variables
  final count = 0.obs;

  // Methods
  void increment() => count.value++;

  @override
  void onInit() {
    super.onInit();
    // Initialize
  }
}
```

### Views

```dart
class MyView extends GetView<MyController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Text('${controller.count}'));
  }
}
```

### Navigation

```dart
// Navigate to named route
Get.toNamed(Routes.DASHBOARD);

// Navigate and clear stack
Get.offAllNamed(Routes.LOGIN);

// Go back
Get.back();

// Pass arguments
Get.toNamed(Routes.DETAILS, arguments: {'id': 123});
```

## Custom Snackbars

```dart
// Success message
CustomSnackBar.showCustomSnackBar(
  title: 'Success',
  message: 'Operation completed successfully',
);

// Error message
CustomSnackBar.showCustomErrorSnackBar(
  title: 'Error',
  message: 'Something went wrong',
);

// Toast
CustomSnackBar.showCustomToast(
  message: 'Item added to cart',
);
```

## Data Persistence

### Secure Storage (Tokens)

```dart
// Store token
await MySecureStorage.setToken(token);

// Get token
String? token = await MySecureStorage.getToken();

// Delete token
await MySecureStorage.deleteToken();
```

### SharedPreferences (Settings)

```dart
// Store theme preference
MySharedPref.setThemeIsLight(true);

// Get theme preference
bool isLight = MySharedPref.getThemeIsLight();

// Store language
MySharedPref.setCurrentLanguage('en');
```

### Hive (Local Database)

```dart
// Open box
await MyHive.init();

// Store data
await MyHive.put('key', value);

// Get data
var data = MyHive.get('key');

// Delete data
await MyHive.delete('key');
```

## Performance Optimization

### Best Practices Implemented

1. **Image Optimization**: Cached network images
2. **List Performance**: ListView.builder for long lists
3. **State Management**: GetX for efficient rebuilds
4. **Code Splitting**: Lazy loading of routes
5. **Responsive Design**: Proper use of screenutil
6. **API Caching**: Token refresh mechanism
7. **Memory Management**: Proper controller disposal

## Security Features

1. **Secure Token Storage**: Flutter Secure Storage for JWT tokens
2. **Password Validation**: Minimum 8 characters with strength checker
3. **JWT Authentication**: Token-based auth with auto-refresh
4. **Secure API Calls**: HTTPS in production
5. **Input Validation**: Form validation on all inputs
6. **Error Handling**: Safe error messages without exposing sensitive data

## Version History

### v1.0.0 (Current)
- Initial release
- Complete authentication system
- Beneficiary management
- Prescription upload and management
- Payment processing
- Profile management
- Settings and preferences
- Full dark mode support
- Multi-language support (EN/AR)
- Firebase integration

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is proprietary and confidential.

## Support & Contact

For support or questions:
- Email: support@hellodoctor.com
- Website: https://hellodoctor.com
- Documentation: https://docs.hellodoctor.com

## Acknowledgments

Built with:
- Flutter & Dart
- GetX State Management
- Firebase
- Hive Database
- Material Design 3

---

**Made with ❤️ using Flutter**
