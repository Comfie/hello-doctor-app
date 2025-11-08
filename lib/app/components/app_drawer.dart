import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../routes/app_pages.dart';
import '../services/auth_service.dart';
import '../../config/theme/light_theme_colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final user = authService.currentUser.value;

    return Drawer(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            // User Profile Header with Gradient
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    LightThemeColors.primaryColor,
                    LightThemeColors.primaryLight,
                  ],
                ),
              ),
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 20.h,
                bottom: 20.h,
                left: 20.w,
                right: 20.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Avatar
                  Container(
                    width: 70.w,
                    height: 70.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 3.w,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        user != null
                            ? '${user.firstName[0]}${user.lastName[0]}'
                            : 'HD',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: LightThemeColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // User Name
                  Text(
                    user?.fullName ?? 'Hello Doctor User',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),

                  // User Email
                  Text(
                    user?.email ?? 'user@hellodoctor.com',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // View Profile Button
                  GestureDetector(
                    onTap: () {
                      Get.back(); // Close drawer
                      Get.toNamed(Routes.PROFILE);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.person,
                            size: 16.sp,
                            color: Colors.white,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'View Profile',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Menu Items
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                children: [
                  _DrawerMenuItem(
                    icon: Icons.dashboard_rounded,
                    title: 'Dashboard',
                    color: LightThemeColors.primaryColor,
                    onTap: () {
                      Get.back();
                      Get.offAllNamed(Routes.DASHBOARD);
                    },
                  ),
                  _DrawerMenuItem(
                    icon: Icons.people_rounded,
                    title: 'Beneficiaries',
                    color: LightThemeColors.primaryColor,
                    onTap: () {
                      Get.back();
                      Get.toNamed(Routes.BENEFICIARIES);
                    },
                  ),
                  _DrawerMenuItem(
                    icon: Icons.receipt_long_rounded,
                    title: 'Prescriptions',
                    color: Colors.orange,
                    onTap: () {
                      Get.back();
                      Get.toNamed(Routes.PRESCRIPTION_LIST);
                    },
                  ),
                  _DrawerMenuItem(
                    icon: Icons.payment_rounded,
                    title: 'Payment History',
                    color: Colors.purple,
                    onTap: () {
                      Get.back();
                      Get.toNamed(Routes.PAYMENT_HISTORY);
                    },
                  ),

                  Divider(height: 24.h, thickness: 1),

                  // Settings & Info Section
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, top: 8.h, bottom: 8.h),
                    child: Text(
                      'SETTINGS & INFO',
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: LightThemeColors.bodySmallTextColor,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  _DrawerMenuItem(
                    icon: Icons.settings_rounded,
                    title: 'Settings',
                    color: Colors.grey.shade700,
                    onTap: () {
                      Get.back();
                      Get.toNamed(Routes.SETTINGS);
                    },
                  ),
                  _DrawerMenuItem(
                    icon: Icons.info_rounded,
                    title: 'About Hello Doctor',
                    color: LightThemeColors.infoColor,
                    onTap: () {
                      Get.back();
                      Get.toNamed(Routes.ABOUT);
                    },
                  ),
                  _DrawerMenuItem(
                    icon: Icons.description_rounded,
                    title: 'Terms of Service',
                    color: Colors.blueGrey,
                    onTap: () {
                      Get.back();
                      Get.toNamed(Routes.TERMS);
                    },
                  ),
                  _DrawerMenuItem(
                    icon: Icons.privacy_tip_rounded,
                    title: 'Privacy Policy',
                    color: Colors.blueGrey,
                    onTap: () {
                      Get.back();
                      Get.toNamed(Routes.PRIVACY);
                    },
                  ),

                  Divider(height: 24.h, thickness: 1),

                  // Logout
                  _DrawerMenuItem(
                    icon: Icons.logout_rounded,
                    title: 'Logout',
                    color: LightThemeColors.errorColor,
                    onTap: () async {
                      Get.back(); // Close drawer

                      // Show confirmation dialog
                      final confirm = await Get.dialog<bool>(
                        AlertDialog(
                          title: const Text('Logout'),
                          content: const Text('Are you sure you want to logout?'),
                          actions: [
                            TextButton(
                              onPressed: () => Get.back(result: false),
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () => Get.back(result: true),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: LightThemeColors.errorColor,
                              ),
                              child: const Text('Logout'),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        await authService.logout();
                        Get.offAllNamed(Routes.LOGIN);
                      }
                    },
                  ),
                ],
              ),
            ),

            // App Version Footer
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: LightThemeColors.dividerColor,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.local_hospital_rounded,
                    size: 16.sp,
                    color: LightThemeColors.primaryColor,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Hello Doctor v1.0.0',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: LightThemeColors.bodySmallTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _DrawerMenuItem({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(
          icon,
          color: color,
          size: 22.sp,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
          color: LightThemeColors.bodyTextColor,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: LightThemeColors.iconColorLight,
        size: 20.sp,
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
      dense: false,
    );
  }
}
