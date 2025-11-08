import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../config/theme/light_theme_colors.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightThemeColors.primaryColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              LightThemeColors.primaryColor,
              LightThemeColors.primaryDark,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo section
            Icon(
              Icons.local_hospital_rounded,
              size: 120.sp,
              color: Colors.white,
            ),
            SizedBox(height: 24.h),

            // App name
            Text(
              'Hello Doctor',
              style: TextStyle(
                fontSize: 36.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(height: 8.h),

            // Tagline
            Text(
              'Your Health, Our Priority',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white.withOpacity(0.9),
                fontWeight: FontWeight.w400,
              ),
            ),

            SizedBox(height: 60.h),

            // Loading indicator
            SizedBox(
              width: 40.w,
              height: 40.w,
              child: CircularProgressIndicator(
                strokeWidth: 3.w,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),

            SizedBox(height: 80.h),

            // Version
            Text(
              'Version 1.0.0',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
