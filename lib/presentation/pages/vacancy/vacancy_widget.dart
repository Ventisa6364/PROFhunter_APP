import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/presentation/pages/vacancy/vacancy_model.dart';
import 'package:profhunterapp/presentation/pages/vacancy/vacancy_page.dart';
import 'package:profhunteruikit/uikit.dart';

class VacancyWidget extends StatelessWidget {
  final VacancyModel vacancy;

  const VacancyWidget({super.key, required this.vacancy});

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
                Expanded(
                  child: Text(
                    vacancy.name,
                    style: CustomStyles.nunitoBold32.copyWith(
                      color: theme.palette.text,
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: theme.palette.icon,
                ),
              ],
            ),
            Row(
              spacing: 4.w,
              children: [
                Text(
                  vacancy.salary,
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
                Expanded(
                  child: Text(
                    vacancy.employmentType,
                    overflow: TextOverflow.ellipsis,
                    style: CustomStyles.nunitoMedium22.copyWith(
                      color: theme.palette.text,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            _VacancyRow(label: vacancy.conditions[0]),
            _VacancyRow(label: vacancy.duties[0]),
            _VacancyRow(label: vacancy.requirements[0]),
          ],
        ),
      ),
    );
  }

  void _getVacancy() => Get.to(VacancyPage(vacancy: vacancy));
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
        Expanded(
          child: Text(
            label,
            style: CustomStyles.nunitoMedium16.copyWith(
              color: theme.palette.text,
            ),
          ),
        ),
      ],
    );
  }
}
