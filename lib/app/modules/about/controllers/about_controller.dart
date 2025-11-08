import 'package:get/get.dart';

class AboutController extends GetxController {
  // App information
  final String appName = 'Hello Doctor';
  final String appVersion = '1.0.0';
  final String buildNumber = '1';

  // Contact information
  final String supportEmail = 'support@hellodoctor.com';
  final String supportPhone = '+1 (800) 123-4567';
  final String website = 'www.hellodoctor.com';

  // Developer information
  final String companyName = 'Hello Doctor Inc.';
  final String companyAddress = '123 Healthcare St, Medical City, HC 12345';

  // App description
  final String appDescription =
      'Hello Doctor is your comprehensive healthcare companion, designed to make managing prescriptions, '
      'beneficiaries, and medical payments simple and secure. Access your healthcare services anytime, anywhere.';

  // Features list
  final List<Map<String, String>> features = [
    {
      'title': 'Digital Prescriptions',
      'description': 'Upload and manage your medical prescriptions digitally',
    },
    {
      'title': 'Beneficiary Management',
      'description': 'Add and manage beneficiaries for family healthcare',
    },
    {
      'title': 'Secure Payments',
      'description': 'Safe and secure payment processing for medical services',
    },
    {
      'title': 'Payment History',
      'description': 'Track all your medical payment transactions',
    },
    {
      'title': '24/7 Access',
      'description': 'Access your healthcare information anytime',
    },
    {
      'title': 'Multi-language Support',
      'description': 'Available in English and Arabic',
    },
  ];

  // Social media links (can be updated with actual links)
  final Map<String, String> socialLinks = {
    'facebook': 'https://facebook.com/hellodoctor',
    'twitter': 'https://twitter.com/hellodoctor',
    'instagram': 'https://instagram.com/hellodoctor',
    'linkedin': 'https://linkedin.com/company/hellodoctor',
  };

  // Navigate to Terms of Service
  void navigateToTerms() {
    Get.toNamed('/terms');
  }

  // Navigate to Privacy Policy
  void navigateToPrivacy() {
    Get.toNamed('/privacy');
  }

  // Contact support via email
  void contactSupport() {
    // In a real app, this would launch email client
    Get.snackbar(
      'Contact Support',
      'Email: $supportEmail\nPhone: $supportPhone',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 4),
    );
  }
}
