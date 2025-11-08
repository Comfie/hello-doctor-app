import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../config/theme/light_theme_colors.dart';
import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'About Hello Doctor',
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildAppLogoSection(),
            SizedBox(height: 24.h),
            _buildDescriptionCard(),
            SizedBox(height: 20.h),
            _buildFeaturesSection(),
            SizedBox(height: 20.h),
            _buildContactSection(),
            SizedBox(height: 20.h),
            _buildQuickLinksSection(),
            SizedBox(height: 20.h),
            _buildDeveloperInfo(),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildAppLogoSection() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  LightThemeColors.primaryColor,
                  LightThemeColors.primaryLight,
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.medical_services,
              size: 60.sp,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            controller.appName,
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: LightThemeColors.primaryColor,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Version ${controller.appVersion} (${controller.buildNumber})',
            style: TextStyle(
              fontSize: 14.sp,
              color: LightThemeColors.bodySmallTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 24.sp,
                color: LightThemeColors.primaryColor,
              ),
              SizedBox(width: 8.w),
              Text(
                'About the App',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: LightThemeColors.bodyTextColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            controller.appDescription,
            style: TextStyle(
              fontSize: 14.sp,
              color: LightThemeColors.bodySmallTextColor,
              height: 1.5,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.star_outline,
                size: 24.sp,
                color: LightThemeColors.accentColor,
              ),
              SizedBox(width: 8.w),
              Text(
                'Key Features',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: LightThemeColors.bodyTextColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...controller.features.map((feature) => _buildFeatureItem(
                feature['title']!,
                feature['description']!,
              )),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String title, String description) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 2.h),
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              color: LightThemeColors.accentColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check,
              size: 16.sp,
              color: LightThemeColors.accentColor,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: LightThemeColors.bodyTextColor,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: LightThemeColors.bodySmallTextColor,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.contact_support_outlined,
                size: 24.sp,
                color: LightThemeColors.primaryColor,
              ),
              SizedBox(width: 8.w),
              Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: LightThemeColors.bodyTextColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildContactItem(Icons.email_outlined, 'Email', controller.supportEmail),
          SizedBox(height: 12.h),
          _buildContactItem(Icons.phone_outlined, 'Phone', controller.supportPhone),
          SizedBox(height: 12.h),
          _buildContactItem(Icons.language, 'Website', controller.website),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: controller.contactSupport,
              icon: Icon(Icons.mail_outline, size: 20.sp),
              label: const Text('Contact Support'),
              style: ElevatedButton.styleFrom(
                backgroundColor: LightThemeColors.primaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: LightThemeColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            icon,
            size: 20.sp,
            color: LightThemeColors.primaryColor,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: LightThemeColors.bodySmallTextColor,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: LightThemeColors.bodyTextColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickLinksSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.link,
                size: 24.sp,
                color: LightThemeColors.primaryColor,
              ),
              SizedBox(width: 8.w),
              Text(
                'Quick Links',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: LightThemeColors.bodyTextColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildLinkTile(
            Icons.description_outlined,
            'Terms of Service',
            'Read our terms and conditions',
            controller.navigateToTerms,
          ),
          SizedBox(height: 8.h),
          _buildLinkTile(
            Icons.privacy_tip_outlined,
            'Privacy Policy',
            'Learn how we protect your data',
            controller.navigateToPrivacy,
          ),
        ],
      ),
    );
  }

  Widget _buildLinkTile(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          border: Border.all(
            color: LightThemeColors.dividerColor,
          ),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24.sp,
              color: LightThemeColors.primaryColor,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: LightThemeColors.bodyTextColor,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: LightThemeColors.bodySmallTextColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: LightThemeColors.iconColorLight,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeveloperInfo() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            LightThemeColors.primaryColor,
            LightThemeColors.primaryLight,
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: LightThemeColors.primaryColor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.business,
            size: 40.sp,
            color: Colors.white,
          ),
          SizedBox(height: 12.h),
          Text(
            controller.companyName,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            controller.companyAddress,
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          Text(
            'Made with ❤️ for better healthcare',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.white.withOpacity(0.8),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
