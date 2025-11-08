import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../config/theme/light_theme_colors.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightThemeColors.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('App Preferences'),
            SizedBox(height: 12.h),
            _buildPreferencesSection(),
            SizedBox(height: 24.h),
            _buildSectionTitle('Account'),
            SizedBox(height: 12.h),
            _buildAccountSection(),
            SizedBox(height: 24.h),
            _buildSectionTitle('Information'),
            SizedBox(height: 12.h),
            _buildInformationSection(),
            SizedBox(height: 24.h),
            _buildVersionInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: LightThemeColors.bodySmallTextColor,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildPreferencesSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Obx(() => _buildSettingsTile(
                icon: Icons.brightness_6,
                iconColor: LightThemeColors.primaryColor,
                title: 'Theme',
                subtitle: controller.getThemeModeName(controller.currentThemeMode.value),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16.sp,
                  color: LightThemeColors.iconColorLight,
                ),
                onTap: () => _showThemeDialog(),
              )),
          _buildDivider(),
          Obx(() => _buildSettingsTile(
                icon: Icons.language,
                iconColor: LightThemeColors.accentColor,
                title: 'Language',
                subtitle: controller.getLanguageName(controller.currentLanguage.value),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16.sp,
                  color: LightThemeColors.iconColorLight,
                ),
                onTap: () => _showLanguageDialog(),
              )),
        ],
      ),
    );
  }

  Widget _buildAccountSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSettingsTile(
            icon: Icons.person_outline,
            iconColor: const Color(0xFF2196F3),
            title: 'Edit Profile',
            subtitle: 'Update your personal information',
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: LightThemeColors.iconColorLight,
            ),
            onTap: controller.navigateToEditProfile,
          ),
          _buildDivider(),
          _buildSettingsTile(
            icon: Icons.lock_outline,
            iconColor: const Color(0xFFFF9800),
            title: 'Change Password',
            subtitle: 'Update your account password',
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: LightThemeColors.iconColorLight,
            ),
            onTap: controller.navigateToChangePassword,
          ),
        ],
      ),
    );
  }

  Widget _buildInformationSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSettingsTile(
            icon: Icons.info_outline,
            iconColor: const Color(0xFF9C27B0),
            title: 'About Hello Doctor',
            subtitle: 'App information and features',
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: LightThemeColors.iconColorLight,
            ),
            onTap: controller.navigateToAbout,
          ),
          _buildDivider(),
          _buildSettingsTile(
            icon: Icons.description_outlined,
            iconColor: const Color(0xFF00BCD4),
            title: 'Terms of Service',
            subtitle: 'Read our terms and conditions',
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: LightThemeColors.iconColorLight,
            ),
            onTap: controller.navigateToTerms,
          ),
          _buildDivider(),
          _buildSettingsTile(
            icon: Icons.privacy_tip_outlined,
            iconColor: const Color(0xFF4CAF50),
            title: 'Privacy Policy',
            subtitle: 'Learn how we protect your data',
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: LightThemeColors.iconColorLight,
            ),
            onTap: controller.navigateToPrivacy,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required Widget trailing,
    required VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      leading: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(
          icon,
          size: 24.sp,
          color: iconColor,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: LightThemeColors.bodyTextColor,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 13.sp,
          color: LightThemeColors.bodySmallTextColor,
        ),
      ),
      trailing: trailing,
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 68.w,
      color: LightThemeColors.dividerColor,
    );
  }

  Widget _buildVersionInfo() {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.info_outline,
              size: 18.sp,
              color: LightThemeColors.iconColorLight,
            ),
            SizedBox(width: 8.w),
            Text(
              'Version ${controller.appVersion} (${controller.buildNumber})',
              style: TextStyle(
                fontSize: 13.sp,
                color: LightThemeColors.bodySmallTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showThemeDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Theme',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: LightThemeColors.bodyTextColor,
                ),
              ),
              SizedBox(height: 20.h),
              Obx(() => _buildThemeOption(
                'system',
                'System Default',
                'Follows device theme',
                Icons.phone_android,
              )),
              SizedBox(height: 12.h),
              Obx(() => _buildThemeOption(
                'light',
                'Light Mode',
                'Always use light theme',
                Icons.light_mode,
              )),
              SizedBox(height: 12.h),
              Obx(() => _buildThemeOption(
                'dark',
                'Dark Mode',
                'Always use dark theme',
                Icons.dark_mode,
              )),
              SizedBox(height: 16.h),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: LightThemeColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeOption(String mode, String name, String description, IconData icon) {
    final isSelected = controller.currentThemeMode.value == mode;

    return InkWell(
      onTap: () {
        controller.changeThemeMode(mode);
        Get.back();
      },
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected
              ? LightThemeColors.primaryColor.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected
                ? LightThemeColors.primaryColor
                : LightThemeColors.dividerColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? LightThemeColors.primaryColor
                  : LightThemeColors.iconColorLight,
              size: 24.sp,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: isSelected
                          ? LightThemeColors.primaryColor
                          : LightThemeColors.bodyTextColor,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: LightThemeColors.bodySmallTextColor,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: LightThemeColors.primaryColor,
                size: 22.sp,
              ),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Language',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: LightThemeColors.bodyTextColor,
                ),
              ),
              SizedBox(height: 20.h),
              Obx(() => _buildLanguageOption('en', 'English', '🇬🇧')),
              SizedBox(height: 12.h),
              Obx(() => _buildLanguageOption('ar', 'العربية', '🇸🇦')),
              SizedBox(height: 16.h),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: LightThemeColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String code, String name, String flag) {
    final isSelected = controller.currentLanguage.value == code;

    return InkWell(
      onTap: () {
        controller.changeLanguage(code);
        Get.back();
      },
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected
              ? LightThemeColors.primaryColor.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected
                ? LightThemeColors.primaryColor
                : LightThemeColors.dividerColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(
              flag,
              style: TextStyle(fontSize: 24.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected
                      ? LightThemeColors.primaryColor
                      : LightThemeColors.bodyTextColor,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: LightThemeColors.primaryColor,
                size: 22.sp,
              ),
          ],
        ),
      ),
    );
  }
}
