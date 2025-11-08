import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../components/my_widgets_animator.dart';
import '../../../data/models/beneficiary_model.dart';
import '../../../../config/theme/light_theme_colors.dart';
import '../controllers/beneficiary_controller.dart';

class BeneficiaryListView extends GetView<BeneficiaryController> {
  const BeneficiaryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Beneficiaries',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: Obx(() => MyWidgetsAnimator(
            apiCallStatus: controller.apiCallStatus.value,
            loadingWidget: () => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: () => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 60.sp,
                    color: LightThemeColors.errorColor,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Failed to load beneficiaries',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: LightThemeColors.bodyTextColor,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton.icon(
                    onPressed: controller.loadBeneficiaries,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            ),
            emptyWidget: () => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people_outline,
                    size: 80.sp,
                    color: LightThemeColors.bodySmallTextColor,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'No Beneficiaries',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: LightThemeColors.bodyTextColor,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Add your first beneficiary to get started',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: LightThemeColors.bodySmallTextColor,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  ElevatedButton.icon(
                    onPressed: controller.goToAddBeneficiary,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Beneficiary'),
                  ),
                ],
              ),
            ),
            successWidget: () => RefreshIndicator(
              onRefresh: controller.refreshBeneficiaries,
              child: ListView.builder(
                padding: EdgeInsets.all(16.w),
                itemCount: controller.beneficiaries.length,
                itemBuilder: (context, index) {
                  final beneficiary = controller.beneficiaries[index];
                  return _buildBeneficiaryCard(beneficiary);
                },
              ),
            ),
          )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: controller.goToAddBeneficiary,
        icon: const Icon(Icons.add),
        label: const Text('Add'),
        backgroundColor: LightThemeColors.primaryColor,
      ),
    );
  }

  Widget _buildBeneficiaryCard(Beneficiary beneficiary) {
    return Dismissible(
      key: Key(beneficiary.id.toString()),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        // Show confirmation before dismissing
        await controller.deleteBeneficiary(beneficiary.id);
        // Return false because we handle removal manually in controller
        return false;
      },
      background: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: LightThemeColors.errorColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.delete,
              color: Colors.white,
              size: 28.sp,
            ),
            SizedBox(height: 4.h),
            Text(
              'Delete',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      child: Card(
        margin: EdgeInsets.only(bottom: 12.h),
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: InkWell(
          onTap: () => controller.goToBeneficiaryDetails(beneficiary),
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                // Avatar
                Container(
                  width: 56.w,
                  height: 56.w,
                  decoration: BoxDecoration(
                    color: _getGenderColor(beneficiary.gender).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getGenderIcon(beneficiary.gender),
                    size: 28.sp,
                    color: _getGenderColor(beneficiary.gender),
                  ),
                ),
                SizedBox(width: 16.w),
                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        beneficiary.fullName,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: LightThemeColors.bodyTextColor,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            size: 14.sp,
                            color: LightThemeColors.bodySmallTextColor,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            beneficiary.relationship,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: LightThemeColors.bodySmallTextColor,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Icon(
                            Icons.cake,
                            size: 14.sp,
                            color: LightThemeColors.bodySmallTextColor,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '${beneficiary.age} years',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: LightThemeColors.bodySmallTextColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      if (beneficiary.email != null || beneficiary.phoneNumber != null)
                        Row(
                          children: [
                            if (beneficiary.phoneNumber != null) ...[
                              Icon(
                                Icons.phone,
                                size: 14.sp,
                                color: LightThemeColors.bodySmallTextColor,
                              ),
                              SizedBox(width: 4.w),
                              Flexible(
                                child: Text(
                                  beneficiary.phoneNumber!,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: LightThemeColors.bodySmallTextColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ],
                        ),
                    ],
                  ),
                ),
                // Arrow
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16.sp,
                  color: LightThemeColors.bodySmallTextColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getGenderColor(String gender) {
    switch (gender.toLowerCase()) {
      case 'male':
        return const Color(0xFF2196F3);
      case 'female':
        return const Color(0xFFE91E63);
      default:
        return LightThemeColors.primaryColor;
    }
  }

  IconData _getGenderIcon(String gender) {
    switch (gender.toLowerCase()) {
      case 'male':
        return Icons.male;
      case 'female':
        return Icons.female;
      default:
        return Icons.person;
    }
  }
}
