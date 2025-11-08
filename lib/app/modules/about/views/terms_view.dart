import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config/theme/light_theme_colors.dart';

class TermsView extends StatelessWidget {
  const TermsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Terms of Service',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Container(
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
              _buildHeader(),
              SizedBox(height: 24.h),
              _buildSection(
                '1. Acceptance of Terms',
                'By accessing and using Hello Doctor mobile application, you accept and agree to be bound by the terms and provision of this agreement. If you do not agree to abide by the above, please do not use this service.',
              ),
              _buildSection(
                '2. Use License',
                'Permission is granted to temporarily download one copy of Hello Doctor application for personal, non-commercial transitory viewing only. This is the grant of a license, not a transfer of title, and under this license you may not:\n\n'
                '• Modify or copy the materials\n'
                '• Use the materials for any commercial purpose\n'
                '• Attempt to decompile or reverse engineer any software contained in Hello Doctor\n'
                '• Remove any copyright or other proprietary notations from the materials\n'
                '• Transfer the materials to another person or "mirror" the materials on any other server',
              ),
              _buildSection(
                '3. Medical Services',
                'Hello Doctor provides a platform for managing medical prescriptions, beneficiaries, and healthcare payments. The app does not provide medical advice, diagnosis, or treatment. Always seek the advice of your physician or other qualified health provider with any questions you may have regarding a medical condition.',
              ),
              _buildSection(
                '4. User Responsibilities',
                'You are responsible for:\n\n'
                '• Maintaining the confidentiality of your account and password\n'
                '• All activities that occur under your account\n'
                '• Ensuring the accuracy of information you provide\n'
                '• Compliance with all applicable laws and regulations\n'
                '• Protecting your prescription and medical information',
              ),
              _buildSection(
                '5. Prescription Management',
                'When uploading prescriptions to Hello Doctor:\n\n'
                '• Ensure all prescription images are clear and legible\n'
                '• Verify prescription details are accurate\n'
                '• Upload only valid prescriptions from licensed healthcare providers\n'
                '• Do not share prescription information with unauthorized parties\n'
                '• Understand that final prescription validation is done by healthcare professionals',
              ),
              _buildSection(
                '6. Payment Terms',
                'All payments made through Hello Doctor are:\n\n'
                '• Processed securely through authorized payment gateways\n'
                '• Subject to verification and approval\n'
                '• Non-refundable except as required by applicable law\n'
                '• Your responsibility to ensure sufficient funds\n'
                '• Recorded in your payment history for your records',
              ),
              _buildSection(
                '7. Privacy and Data Protection',
                'Your privacy is important to us. Please review our Privacy Policy to understand how we collect, use, and protect your personal and medical information. By using Hello Doctor, you consent to our data practices as described in the Privacy Policy.',
              ),
              _buildSection(
                '8. Beneficiary Management',
                'When adding beneficiaries:\n\n'
                '• Ensure you have legal authority to manage their healthcare\n'
                '• Provide accurate beneficiary information\n'
                '• Respect beneficiary privacy and confidentiality\n'
                '• Update beneficiary information as needed\n'
                '• Understand your responsibilities as a beneficiary manager',
              ),
              _buildSection(
                '9. Service Availability',
                'Hello Doctor strives to provide continuous service, but we do not guarantee that:\n\n'
                '• The service will be uninterrupted or error-free\n'
                '• Defects will be corrected immediately\n'
                '• The service will be available at all times\n'
                '• The service will be free from viruses or harmful components',
              ),
              _buildSection(
                '10. Limitation of Liability',
                'Hello Doctor shall not be liable for any indirect, incidental, special, consequential or punitive damages, including without limitation, loss of profits, data, use, goodwill, or other intangible losses resulting from your use of or inability to use the service.',
              ),
              _buildSection(
                '11. Account Termination',
                'We reserve the right to terminate or suspend your account and access to the service immediately, without prior notice or liability, for any reason whatsoever, including without limitation if you breach the Terms of Service.',
              ),
              _buildSection(
                '12. Changes to Terms',
                'We reserve the right to modify or replace these Terms at any time. If a revision is material, we will provide at least 30 days notice prior to any new terms taking effect. What constitutes a material change will be determined at our sole discretion.',
              ),
              _buildSection(
                '13. Governing Law',
                'These Terms shall be governed and construed in accordance with applicable healthcare regulations and data protection laws, without regard to its conflict of law provisions.',
              ),
              _buildSection(
                '14. Contact Information',
                'If you have any questions about these Terms of Service, please contact us at:\n\n'
                'Email: legal@hellodoctor.com\n'
                'Phone: +1 (800) 123-4567\n'
                'Address: 123 Healthcare St, Medical City, HC 12345',
              ),
              SizedBox(height: 24.h),
              _buildLastUpdated(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: LightThemeColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.description,
                size: 32.sp,
                color: LightThemeColors.primaryColor,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                'Terms of Service',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: LightThemeColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: LightThemeColors.infoColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: LightThemeColors.infoColor.withOpacity(0.3),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 20.sp,
                color: LightThemeColors.infoColor,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Please read these terms carefully before using Hello Doctor.',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: LightThemeColors.bodyTextColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: LightThemeColors.bodyTextColor,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            content,
            style: TextStyle(
              fontSize: 14.sp,
              color: LightThemeColors.bodySmallTextColor,
              height: 1.6,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _buildLastUpdated() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: LightThemeColors.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.calendar_today,
            size: 16.sp,
            color: LightThemeColors.bodySmallTextColor,
          ),
          SizedBox(width: 8.w),
          Text(
            'Last updated: November 8, 2025',
            style: TextStyle(
              fontSize: 13.sp,
              color: LightThemeColors.bodySmallTextColor,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
