# Hello Doctor Mobile App - Implementation Guide

## Completed Tasks

✅ Updated dependencies in pubspec.yaml
✅ Created data models (AuthUser, Beneficiary, Prescription, Payment)
✅ Implemented API service layer (AuthService, BeneficiaryService, PrescriptionService, PaymentService)
✅ Updated theme with modern medical colors
✅ Added user data storage to SharedPreferences

## Next Steps to Complete the App

### 1. Generate Model Adapters

Run this command to generate Hive adapters for AuthUser model:

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### 2. Create the Screens

The app needs the following screens (create them in lib/app/modules/):

#### A. Splash Screen (splash/)
- Show app logo
- Check authentication status
- Navigate to login or dashboard

#### B. Auth Screens (auth/)
- Login screen with email/password
- Register screen with full user details
- Password validation
- Handle API errors

#### C. Dashboard Screen (dashboard/)
- Welcome message with user name
- Quick actions cards:
  - View Beneficiaries
  - Upload Prescription
  - View Prescriptions
  - Payment History
- Stats overview

#### D. Beneficiary Screens (beneficiary/)
- List all beneficiaries
- Add new beneficiary form
- Edit beneficiary
- Delete beneficiary with confirmation

#### E. Prescription Screens (prescription/)
- List prescriptions with status badges
- Upload prescription with image picker
- View prescription details
- Payment button if status is PaymentPending

#### F. Payment Screens (payment/)
- Payment WebView for PayFast
- Payment status polling
- Payment history list

### 3. Update App Routes

Update `lib/app/routes/app_routes.dart` and `lib/app/routes/app_pages.dart` with all routes:

- /splash
- /login
- /register
- /dashboard
- /beneficiaries
- /add-beneficiary
- /prescriptions
- /upload-prescription
- /payment
- /payment-history

### 4. Main.dart Updates

Update the initialRoute to start with splash screen:
```dart
static const INITIAL = Routes.SPLASH;
```

Initialize Auth Service in main():
```dart
await AuthService().init();
```

### 5. API Configuration

Update the baseUrl in `lib/utils/constants.dart`:
- For Android Emulator: `http://10.0.2.2:5000/api/v1`
- For iOS Simulator: `http://localhost:5000/api/v1`
- For Production: `https://your-domain.com/api/v1`

### 6. UI Components to Create

Create reusable widgets in `lib/app/components/`:
- custom_button.dart - Styled buttons
- custom_text_field.dart - Styled input fields
- status_badge.dart - For prescription statuses
- beneficiary_card.dart - For beneficiary list items
- prescription_card.dart - For prescription list items
- loading_widget.dart - Custom loading indicator

### 7. Screen Implementation Template

Each screen should follow this GetX pattern:

```dart
// Controller
class SomeController extends GetxController {
  final apiCallStatus = ApiCallStatus.holding.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() async {
    // API calls here
  }
}

// Binding
class SomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SomeController>(() => SomeController());
  }
}

// View
class SomeView extends GetView<SomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Title')),
      body: Obx(() => MyWidgetsAnimator(
        apiCallStatus: controller.apiCallStatus.value,
        loadingWidget: () => Center(child: CircularProgressIndicator()),
        errorWidget: () => Center(child: Text('Error')),
        successWidget: () => /* Your content */,
      )),
    );
  }
}
```

### 8. Testing

1. Test authentication flow
2. Test beneficiary CRUD operations
3. Test prescription upload
4. Test payment integration (use PayFast sandbox)
5. Test all navigation flows

### 9. Key Features to Implement

- JWT token refresh logic (check before each API call)
- Logout functionality
- Profile edit screen
- Pull to refresh on list screens
- Image picker for prescriptions
- Form validation
- Error handling with user-friendly messages
- Loading states
- Empty states for lists

### 10. Android/iOS Configuration

#### Android (android/app/src/main/AndroidManifest.xml)
```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
```

#### iOS (ios/Runner/Info.plist)
```xml
<key>NSCameraUsageDescription</key>
<string>Need camera access to capture prescriptions</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Need gallery access to select prescription images</string>
```

## Architecture Overview

```
lib/
├── app/
│   ├── components/          # Reusable widgets
│   ├── data/
│   │   ├── local/          # SharedPreferences, Hive
│   │   └── models/         # Data models
│   ├── modules/            # App screens (GetX modules)
│   │   ├── splash/
│   │   ├── auth/
│   │   ├── dashboard/
│   │   ├── beneficiary/
│   │   ├── prescription/
│   │   └── payment/
│   ├── routes/             # App navigation
│   └── services/           # API services
├── config/
│   ├── theme/              # App theme and colors
│   └── translations/       # Localization
└── utils/                  # Constants, helpers

```

## Design Guidelines

- Use MaterialYou/Material3 components
- Consistent padding: 16.w horizontal, 20.h vertical
- Card elevation: 2
- Border radius: 12.r
- Status badges with colored backgrounds
- Loading shimmer effects for list items
- Bottom navigation for main sections
- FAB for primary actions (upload prescription)

## Color Usage

- Primary Blue: Authentication, headers, primary actions
- Success Green: Approved, completed states
- Warning Orange: Pending states
- Error Red: Rejected, failed states
- Info Blue: Informational items

Remember to use `.w`, `.h`, `.sp`, and `.r` from flutter_screenutil for responsive design!
