import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config/theme/light_theme_colors.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Privacy Policy',
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
            color: Theme.of(context).cardColor,
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
                '1. Introduction',
                'Hello Doctor ("we," "our," or "us") is committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application. Please read this privacy policy carefully. If you do not agree with the terms of this privacy policy, please do not access the application.',
              ),
              _buildSection(
                '2. Information We Collect',
                'We collect several types of information from and about users of our application, including:\n\n'
                '• Personal Information: Name, email address, phone number, date of birth, and other identifiers\n'
                '• Medical Information: Prescription details, beneficiary information, medical history\n'
                '• Payment Information: Payment transaction details (processed securely through third-party payment processors)\n'
                '• Device Information: Mobile device ID, operating system, app version\n'
                '• Usage Data: App usage patterns, features accessed, interaction data\n'
                '• Location Data: Approximate location (with your permission)',
              ),
              _buildSection(
                '3. How We Collect Information',
                'We collect information through:\n\n'
                '• Direct Interactions: When you register, upload prescriptions, add beneficiaries, or make payments\n'
                '• Automated Technologies: Through cookies, device identifiers, and usage analytics\n'
                '• Third Parties: From healthcare providers, payment processors, and service partners\n'
                '• User Communications: When you contact our support team',
              ),
              _buildSection(
                '4. How We Use Your Information',
                'We use the information we collect to:\n\n'
                '• Provide and maintain our services\n'
                '• Process your prescriptions and manage beneficiaries\n'
                '• Handle payment transactions securely\n'
                '• Send you notifications about prescription status and important updates\n'
                '• Improve our app functionality and user experience\n'
                '• Detect, prevent, and address technical issues and fraud\n'
                '• Comply with legal obligations and healthcare regulations\n'
                '• Communicate with you about services and support',
              ),
              _buildSection(
                '5. Medical Information Protection',
                'We take special care with your medical information:\n\n'
                '• All medical data is encrypted both in transit and at rest\n'
                '• Access to medical information is restricted to authorized personnel only\n'
                '• We comply with applicable healthcare privacy laws and regulations\n'
                '• Prescription images are stored securely and deleted after processing\n'
                '• We never sell your medical information to third parties\n'
                '• Medical data is segregated from other application data',
              ),
              _buildSection(
                '6. Information Sharing and Disclosure',
                'We may share your information with:\n\n'
                '• Healthcare Providers: To process prescriptions and provide medical services\n'
                '• Payment Processors: To handle payment transactions securely\n'
                '• Service Providers: Third parties who assist in operating our app\n'
                '• Legal Requirements: When required by law or to protect rights and safety\n'
                '• Business Transfers: In connection with merger, sale, or acquisition\n\n'
                'We do NOT:\n'
                '• Sell your personal information to advertisers\n'
                '• Share medical information without your consent\n'
                '• Use your data for purposes unrelated to healthcare services',
              ),
              _buildSection(
                '7. Data Security',
                'We implement appropriate technical and organizational measures to protect your information:\n\n'
                '• End-to-end encryption for sensitive data\n'
                '• Secure servers with regular security audits\n'
                '• Access controls and authentication mechanisms\n'
                '• Regular security updates and patches\n'
                '• Employee training on data protection\n'
                '• Incident response and breach notification procedures',
              ),
              _buildSection(
                '8. Your Privacy Rights',
                'You have the right to:\n\n'
                '• Access: Request copies of your personal information\n'
                '• Correction: Request correction of inaccurate information\n'
                '• Deletion: Request deletion of your personal information\n'
                '• Portability: Receive your data in a portable format\n'
                '• Restriction: Request restriction of processing\n'
                '• Objection: Object to processing of your information\n'
                '• Withdraw Consent: Withdraw consent at any time\n\n'
                'To exercise these rights, contact us at privacy@hellodoctor.com',
              ),
              _buildSection(
                '9. Data Retention',
                'We retain your information for as long as necessary to:\n\n'
                '• Provide our services to you\n'
                '• Comply with legal and regulatory requirements\n'
                '• Resolve disputes and enforce agreements\n'
                '• Maintain business records\n\n'
                'Medical records are retained according to applicable healthcare regulations. When data is no longer needed, we securely delete or anonymize it.',
              ),
              _buildSection(
                '10. Children\'s Privacy',
                'Hello Doctor is not intended for children under 13 years of age. We do not knowingly collect personal information from children under 13. If you believe we have collected information from a child under 13, please contact us immediately, and we will take steps to delete such information.',
              ),
              _buildSection(
                '11. International Data Transfers',
                'Your information may be transferred to and processed in countries other than your country of residence. We ensure appropriate safeguards are in place to protect your information in accordance with this Privacy Policy and applicable data protection laws.',
              ),
              _buildSection(
                '12. Cookies and Tracking Technologies',
                'We use cookies and similar tracking technologies to:\n\n'
                '• Remember your preferences and settings\n'
                '• Understand app usage and improve functionality\n'
                '• Provide personalized experiences\n'
                '• Analyze performance and troubleshoot issues\n\n'
                'You can control cookies through your device settings, though some features may not function properly if cookies are disabled.',
              ),
              _buildSection(
                '13. Third-Party Services',
                'Our app may contain links to third-party services. We are not responsible for the privacy practices of these third parties. We encourage you to read their privacy policies before providing any information to them.',
              ),
              _buildSection(
                '14. Push Notifications',
                'We may send you push notifications about:\n\n'
                '• Prescription status updates\n'
                '• Payment confirmations\n'
                '• Important account notifications\n'
                '• Service updates\n\n'
                'You can opt-out of push notifications through your device settings at any time.',
              ),
              _buildSection(
                '15. Changes to Privacy Policy',
                'We may update this Privacy Policy from time to time. We will notify you of any changes by:\n\n'
                '• Posting the new Privacy Policy in the app\n'
                '• Sending you an email notification\n'
                '• Displaying an in-app notification\n\n'
                'Changes become effective when posted. Your continued use of the app after changes constitutes acceptance of the updated policy.',
              ),
              _buildSection(
                '16. Contact Us',
                'If you have questions or concerns about this Privacy Policy, please contact us:\n\n'
                'Privacy Team\n'
                'Email: privacy@hellodoctor.com\n'
                'Phone: +1 (800) 123-4567\n'
                'Address: 123 Healthcare St, Medical City, HC 12345\n\n'
                'Data Protection Officer: dpo@hellodoctor.com',
              ),
              _buildSection(
                '17. Regulatory Compliance',
                'Hello Doctor complies with applicable healthcare privacy regulations including but not limited to HIPAA, GDPR, and local data protection laws. We maintain appropriate documentation and procedures to ensure ongoing compliance with these regulations.',
              ),
              SizedBox(height: 24.h),
              _buildLastUpdated(),
              SizedBox(height: 16.h),
              _buildConsentStatement(),
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
                color: LightThemeColors.accentColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.privacy_tip,
                size: 32.sp,
                color: LightThemeColors.accentColor,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                'Privacy Policy',
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
            color: LightThemeColors.successColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: LightThemeColors.successColor.withOpacity(0.3),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.shield_outlined,
                size: 20.sp,
                color: LightThemeColors.successColor,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Your privacy and data security are our top priorities.',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
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
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            content,
            style: TextStyle(
              fontSize: 14.sp,
              color: Theme.of(context).textTheme.bodySmall?.color,
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
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.calendar_today,
            size: 16.sp,
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
          SizedBox(width: 8.w),
          Text(
            'Last updated: November 8, 2025',
            style: TextStyle(
              fontSize: 13.sp,
              color: Theme.of(context).textTheme.bodySmall?.color,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConsentStatement() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            LightThemeColors.primaryColor.withOpacity(0.1),
            LightThemeColors.accentColor.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: LightThemeColors.primaryColor.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 20.sp,
                color: LightThemeColors.primaryColor,
              ),
              SizedBox(width: 8.w),
              Text(
                'Your Consent',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: LightThemeColors.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'By using Hello Doctor, you consent to this Privacy Policy and agree to its terms. If you do not agree with this policy, please discontinue use of the application.',
            style: TextStyle(
              fontSize: 13.sp,
              color: Theme.of(context).textTheme.bodyLarge?.color,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
