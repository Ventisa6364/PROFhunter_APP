import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/presentation/controllers/response_controller.dart';
import 'package:profhunterapp/presentation/pages/profile/profile_other_user.dart';
import 'package:profhunteruikit/uikit.dart';

class CompanyResponsesScreen extends GetView<ResponseController> {
  const CompanyResponsesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = CustomTheme.of(context);

    return Scaffold(
      backgroundColor: theme.palette.background,
      appBar: CustomAppBarWidget(
        title: 'Отклики',
        iconBtn: Icons.arrow_back_rounded,
        onPressed: Get.back,
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (controller.errorMessage.value.isNotEmpty) {
            return ResponsesErrorState(
              error: controller.errorMessage.value,
              onRetry: controller.fetchResponsesForCompany,
            );
          }

          if (controller.responsesCompany.isEmpty) {
            return const ResponsesEmptyState();
          }

          return RefreshIndicator(
            onRefresh: controller.fetchResponsesForCompany,
            child: ListView.separated(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
              itemCount: controller.responsesCompany.length,
              separatorBuilder: (_, _) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final response = controller.responsesCompany[index];

                return CompanyResponseCard(
                  vacancyTitle: response.vacancyTitle,
                  candidateName: response.candidateName,
                  candidateEmail: response.candidateEmail,
                  created: response.created,
                  onTap: () {
                    Get.to(() => OtherProfileScreen(otherUser: response.candidateId,));
                  },
                );
              },
            ),
          );
        }),
      ),
    );
  }
}