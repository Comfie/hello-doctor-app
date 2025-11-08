import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:hello_doctor_app/utils/awesome_notifications_helper.dart';
import 'package:logger/logger.dart';

import 'app/data/local/my_hive.dart';
import 'app/data/local/my_shared_pref.dart';
import 'app/data/models/user_model.dart';
import 'app/routes/app_pages.dart';
import 'config/theme/my_theme.dart';
import 'config/translations/localization_service.dart';
// import 'utils/fcm_helper.dart'; // Uncomment if you configure Firebase

Future<void> main() async {
  // wait for bindings
  WidgetsFlutterBinding.ensureInitialized();

  // initialize local db (hive) and register our custom adapters
  await MyHive.init(
      registerAdapters: (hive) {
        hive.registerAdapter(UserModelAdapter());
        // hive.registerAdapter(AuthUserAdapter()); // Uncomment after running build_runner
      }
  );

  // Initialize Auth Service
  // await Get.putAsync(() async => AuthService()..init());

  // init shared preference
  await MySharedPref.init();

  // NOTE: Firebase/FCM is OPTIONAL - only needed for push notifications
  // To enable Firebase:
  // 1. Configure Firebase for your project (run: flutterfire configure)
  // 2. Uncomment the import and lines below
  // await FcmHelper.initFcm();

  // Initialize local notifications (optional - for in-app notifications)
  try {
    await AwesomeNotificationsHelper.init();
  } catch (e) {
    // If notifications fail, continue anyway - not critical for core functionality
    Logger().w('Failed to initialize notifications: $e');
  }

  runApp(
    ScreenUtilInit(
      // todo add your (Xd / Figma) artboard size
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      rebuildFactor: (old, data) => true,
      builder: (context, widget) {
        return GetMaterialApp(
              title: "Hello Doctor",
              useInheritedMediaQuery: true,
              debugShowCheckedModeBanner: false,
              // Theme configuration
              theme: MyTheme.getThemeData(isLight: true),
              darkTheme: MyTheme.getThemeData(isLight: false),
              themeMode: MySharedPref.getThemeIsLight() ? ThemeMode.light : ThemeMode.dark,
              builder: (context,widget) {
                return MediaQuery(
                  // prevent font from scalling (some people use big/small device fonts)
                  // but we want our app font to still the same and dont get affected
                  data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
                  child: widget!,
                );
              },
              initialRoute: AppPages.INITIAL, // first screen to show when app is running
              getPages: AppPages.routes, // app screens
              locale: MySharedPref.getCurrentLocal(), // app language
              translations: LocalizationService.getInstance(), // localization services in app (controller app language)
            );
      },
    ),
  );
}
