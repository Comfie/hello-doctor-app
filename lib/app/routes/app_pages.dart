import 'package:get/get.dart';

import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/auth/views/register_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/beneficiary/bindings/beneficiary_binding.dart';
import '../modules/beneficiary/bindings/add_beneficiary_binding.dart';
import '../modules/beneficiary/views/beneficiary_list_view.dart';
import '../modules/beneficiary/views/add_beneficiary_view.dart';
import '../modules/prescription/bindings/prescription_binding.dart';
import '../modules/prescription/bindings/upload_prescription_binding.dart';
import '../modules/prescription/bindings/prescription_details_binding.dart';
import '../modules/prescription/views/prescription_list_view.dart';
import '../modules/prescription/views/upload_prescription_view.dart';
import '../modules/prescription/views/prescription_details_view.dart';
import '../modules/payment/bindings/payment_binding.dart';
import '../modules/payment/bindings/payment_history_binding.dart';
import '../modules/payment/views/payment_view.dart';
import '../modules/payment/views/payment_history_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/bindings/edit_profile_binding.dart';
import '../modules/profile/bindings/change_password_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/profile/views/edit_profile_view.dart';
import '../modules/profile/views/change_password_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/about/bindings/about_binding.dart';
import '../modules/about/views/about_view.dart';
import '../modules/about/views/terms_view.dart';
import '../modules/about/views/privacy_policy_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.BENEFICIARIES,
      page: () => const BeneficiaryListView(),
      binding: BeneficiaryBinding(),
    ),
    GetPage(
      name: _Paths.ADD_BENEFICIARY,
      page: () => const AddBeneficiaryView(),
      binding: AddBeneficiaryBinding(),
    ),
    GetPage(
      name: _Paths.PRESCRIPTION_LIST,
      page: () => const PrescriptionListView(),
      binding: PrescriptionBinding(),
    ),
    GetPage(
      name: _Paths.UPLOAD_PRESCRIPTION,
      page: () => const UploadPrescriptionView(),
      binding: UploadPrescriptionBinding(),
    ),
    GetPage(
      name: _Paths.PRESCRIPTION_DETAILS,
      page: () => const PrescriptionDetailsView(),
      binding: PrescriptionDetailsBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT,
      page: () => const PaymentView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_HISTORY,
      page: () => const PaymentHistoryView(),
      binding: PaymentHistoryBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT,
      page: () => const AboutView(),
      binding: AboutBinding(),
    ),
    GetPage(
      name: _Paths.TERMS,
      page: () => const TermsView(),
      binding: AboutBinding(),
    ),
    GetPage(
      name: _Paths.PRIVACY,
      page: () => const PrivacyPolicyView(),
      binding: AboutBinding(),
    ),
  ];
}
