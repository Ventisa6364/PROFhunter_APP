import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/presentation/pages/vacancy/vacancy_model.dart';
import 'package:profhunterapp/presentation/pages/vacancy/vacancy_page.dart';
import 'package:profhunteruikit/uikit.dart';

class VacancyWidget extends StatelessWidget {
  const VacancyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);
    return GestureDetector(
      onTap: _getVacancy,
      child: Container(
        padding: .all(16.r),
        decoration: BoxDecoration(
          color: theme.palette.block,
          borderRadius: .circular(28.r),
          border: Border.all(color: theme.palette.border, width: 0.5.r),
        ),
        child: Column(
          spacing: 8.h,
          crossAxisAlignment: .start,
          children: [
            Row(
              spacing: 16.w,
              children: [
                Icon(Icons.work_history_outlined, color: theme.palette.icon),
                Text(
                  'Вакансия',
                  style: CustomStyles.nunitoMedium16.copyWith(
                    color: theme.palette.text,
                  ),
                ),
              ],
            ),
            Divider(height: 1.h, thickness: 1.r, color: theme.palette.border),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  VacancyModel.name,
                  style: CustomStyles.nunitoBold32.copyWith(
                    color: theme.palette.text,
                  ),
                ),
                Icon(Icons.keyboard_arrow_right_outlined, color: theme.palette.icon),
              ],
            ),
            Row(
              spacing: 8.w,
              children: [
                Text(
                  VacancyModel.salary,
                  style: CustomStyles.nunitoMedium22.copyWith(
                    color: theme.palette.text,
                  ),
                ),
                Text(
                  '•',
                  style: CustomStyles.nunitoMedium22.copyWith(
                    color: theme.palette.text,
                  ),
                ),
                Text(
                  VacancyModel.employmentType,
                  style: CustomStyles.nunitoMedium22.copyWith(
                    color: theme.palette.text,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            _VacancyRow(label: VacancyModel.conditions[0]),
            _VacancyRow(label: VacancyModel.duties[0]),
            _VacancyRow(label: VacancyModel.requirements[0]),
          ],
        ),
      ),
    );
  }

  void _getVacancy() => Get.to(VacancyPage());
}

class _VacancyRow extends StatelessWidget {
  final String label;

  const _VacancyRow({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);
    return Row(
      spacing: 12.w,
      children: [
        Icon(Icons.check_circle_rounded, color: theme.palette.icon),
        Text(
          label,
          style: CustomStyles.nunitoMedium16.copyWith(
            color: theme.palette.text,
          ),
        ),
      ],
    );
  }
}
