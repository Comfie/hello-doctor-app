# Firebase Setup Guide (Optional)

Firebase and Firebase Cloud Messaging (FCM) are **OPTIONAL** for the Hello Doctor app. The app will work perfectly without it.

## Why Firebase?

Firebase is only needed if you want:
- **Push Notifications** - Send notifications to users when prescriptions are approved, payments are completed, etc.
- **Analytics** - Track user behavior and app usage
- **Crashlytics** - Monitor app crashes in production

## Current Status

🟢 **Firebase is currently DISABLED** to allow the app to run immediately without configuration.

The app includes all the Firebase dependencies, but the initialization is commented out in `main.dart`.

## How to Enable Firebase (When You're Ready)

### Step 1: Install Firebase CLI Tools

```bash
# Install Firebase CLI
npm install -g firebase-tools

# Install FlutterFire CLI
dart pub global activate flutterfire_cli
```

### Step 2: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add Project"
3. Enter project name: "Hello Doctor"
4. Follow the setup wizard
5. Enable Google Analytics (optional)

### Step 3: Configure Firebase for Flutter

```bash
# Login to Firebase
firebase login

# Configure FlutterFire (automatically configures Android & iOS)
flutterfire configure
```

This will:
- Create `firebase_options.dart` file
- Configure Android (`android/app/google-services.json`)
- Configure iOS (`ios/Runner/GoogleService-Info.plist`)

### Step 4: Enable Cloud Messaging

1. In Firebase Console, go to your project
2. Navigate to **Build → Cloud Messaging**
3. Enable Cloud Messaging API
4. For iOS:
   - Upload APNs authentication key or certificate
   - [Follow iOS FCM Setup Guide](https://firebase.google.com/docs/cloud-messaging/ios/client)

### Step 5: Update Your Code

#### 1. Import Firebase Options

In `lib/main.dart`, update the import:

```dart
import 'utils/fcm_helper.dart';  // Uncomment this line
import 'firebase_options.dart';  // Add this line (created by flutterfire)
```

#### 2. Enable FCM Initialization

In `lib/main.dart`, uncomment the FCM initialization:

```dart
// FROM:
// await FcmHelper.initFcm();

// TO:
await FcmHelper.initFcm();
```

#### 3. Update FcmHelper

In `lib/utils/fcm_helper.dart`, uncomment the options:

```dart
// FROM:
await Firebase.initializeApp(
  // TODO: uncomment this line if you connected to firebase via cli
  //options: DefaultFirebaseOptions.currentPlatform,
);

// TO:
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

### Step 6: Add Google Services Plugin (Android)

The plugin is already added in `android/build.gradle`, but ensure `google-services.json` is in place:

```bash
# Verify the file exists
ls android/app/google-services.json
```

At the end of `android/app/build.gradle`, add:

```gradle
apply plugin: 'com.google.gms.google-services'
```

### Step 7: Configure iOS (if targeting iOS)

1. Open `ios/Runner.xcworkspace` in Xcode
2. Add `GoogleService-Info.plist` to Runner folder
3. Update `ios/Runner/Info.plist` (already has notification permissions)

### Step 8: Test Push Notifications

#### Test from Firebase Console:

1. Go to Firebase Console → Cloud Messaging
2. Click "Send your first message"
3. Enter title and message
4. Select your app
5. Click "Send test message"
6. Enter your FCM token (check app logs)

#### Get FCM Token:

The token is automatically generated and saved. To view it:

```dart
// In fcm_helper.dart, the token is stored here:
String? token = MySharedPref.getFcmToken();
print('FCM Token: $token');
```

## Sending Notifications from Backend

Once Firebase is configured, you can send notifications from your Hello Doctor API:

### HTTP Request to FCM:

```http
POST https://fcm.googleapis.com/fcm/send
Content-Type: application/json
Authorization: key=YOUR_SERVER_KEY

{
  "to": "USER_FCM_TOKEN",
  "notification": {
    "title": "Prescription Approved",
    "body": "Your prescription has been approved and is ready for payment"
  },
  "data": {
    "prescriptionId": "123",
    "route": "/prescription-details"
  }
}
```

Get your server key from: Firebase Console → Project Settings → Cloud Messaging → Server Key

### Integration with Hello Doctor API:

In your backend, when prescription status changes:

```csharp
// Example in your C# backend
public async Task SendPrescriptionNotification(string userId, int prescriptionId)
{
    var fcmToken = await _userRepository.GetFcmToken(userId);

    var message = new
    {
        to = fcmToken,
        notification = new
        {
            title = "Prescription Update",
            body = "Your prescription status has been updated"
        },
        data = new
        {
            prescriptionId = prescriptionId,
            route = "/prescription-details"
        }
    };

    await SendToFcm(message);
}
```

## Notification Types for Hello Doctor

Here are recommended notification triggers:

1. **Prescription Submitted**
   - Title: "Prescription Received"
   - Body: "We've received your prescription and will review it shortly"

2. **Prescription Approved**
   - Title: "Prescription Approved"
   - Body: "Your prescription is approved. Complete payment to proceed"

3. **Payment Required**
   - Title: "Payment Pending"
   - Body: "Complete your prescription payment of R150.00"

4. **Payment Successful**
   - Title: "Payment Confirmed"
   - Body: "Your payment is confirmed. Prescription is being processed"

5. **Prescription Ready**
   - Title: "Prescription Ready"
   - Body: "Your prescription is ready for collection/delivery"

6. **Prescription Rejected**
   - Title: "Prescription Issue"
   - Body: "We need more information about your prescription"

## Testing Without Firebase

For development, you can test the app completely without Firebase:
- All API calls work normally
- Authentication works with JWT tokens
- File uploads work
- Payments work via PayFast
- Only push notifications won't work (but you can use local notifications)

## Removing Firebase Completely (Optional)

If you decide you don't need Firebase at all, you can remove the dependencies:

### 1. Remove from pubspec.yaml:

```yaml
# Remove these lines:
firebase_core: ^3.8.1
firebase_messaging: ^15.1.4
```

### 2. Remove Files:

```bash
rm lib/utils/fcm_helper.dart
rm firebase_options.dart
```

### 3. Run:

```bash
flutter pub get
flutter clean
```

## Support

For Firebase-specific issues:
- [Firebase Documentation](https://firebase.google.com/docs/flutter/setup)
- [FCM Flutter Setup](https://firebase.google.com/docs/cloud-messaging/flutter/client)
- [FlutterFire GitHub](https://github.com/firebase/flutterfire)

---

**Remember:** Firebase is completely optional. The Hello Doctor app works great without it! Add it later when you're ready to implement push notifications.
