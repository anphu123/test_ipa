import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/assets/assets.gen.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../domain/pickup_models.dart';
import 'at_home_content_widget.dart';
import 'shipping_badge.dart';
import 'shipping_content_widget.dart';
import 'store_content_widget.dart';

class CustomTabBar extends StatelessWidget {
  final List<TabData> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const CustomTabBar({
    Key? key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      decoration: BoxDecoration(
        color: AppColors.neutral07,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
        ),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = index == selectedIndex;
          return Expanded(
            child: InkWell(
              onTap: () => onTabSelected(index),
              child: Container(
                decoration: BoxDecoration(
                  image:
                      isSelected
                          ? DecorationImage(
                            image: AssetImage(Assets.images.bgSelecttab.path),
                            fit: BoxFit.fill,
                          )
                          : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      tabs[index].title,
                      textAlign: TextAlign.center,
                      style: AppTypography.s12.copyWith(
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                        color:
                            isSelected
                                ? AppColors.neutral01
                                : AppColors.neutral03,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      height: 3.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? AppColors.primary01
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class TabContent extends StatelessWidget {
  final int selectedIndex;
  final TabData tabData;
  final Widget Function(String, bool) buildTimeSlot;
  final VoidCallback onProcessStepsTap;
  final Widget Function(List<String>) buildAutoScrollRow;

  const TabContent({
    Key? key,
    required this.selectedIndex,
    required this.tabData,
    required this.buildTimeSlot,
    required this.onProcessStepsTap,
    required this.buildAutoScrollRow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //     margin: EdgeInsets.only(top: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShippingBadge(),
          SizedBox(height: 16.h),
          ProcessSteps(
            tabData: tabData,
            selectedIndex: selectedIndex,
            onTap: onProcessStepsTap,
            buildAutoScrollRow: buildAutoScrollRow,
          ),
          SizedBox(height: 16.h),
          if (selectedIndex == 0)
            StoreContentWidget(buildTimeSlot: buildTimeSlot),
          if (selectedIndex == 1)
            AtHomeContentWidget(buildTimeSlot: buildTimeSlot),
          if (selectedIndex == 2) ShippingContentWidget(),
        ],
      ),
    );
  }
}

class ProcessSteps extends StatelessWidget {
  final TabData tabData;
  final int selectedIndex;
  final VoidCallback onTap;
  final Widget Function(List<String>) buildAutoScrollRow;

  const ProcessSteps({
    Key? key,
    required this.tabData,
    required this.selectedIndex,
    required this.onTap,
    required this.buildAutoScrollRow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          TopRow(
            texts: tabData.topRowTexts,
            selectedIndex: selectedIndex,
            buildAutoScrollRow: buildAutoScrollRow,
          ),
          SizedBox(height: 16.h),
          BottomRow(steps: tabData.steps),
        ],
      ),
    );
  }
}

class TopRow extends StatelessWidget {
  final List<String> texts;
  final int selectedIndex;
  final Widget Function(List<String>) buildAutoScrollRow;

  const TopRow({
    Key? key,
    required this.texts,
    required this.selectedIndex,
    required this.buildAutoScrollRow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.AB02,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.r),
          topRight: Radius.circular(8.r),
        ),
      ),
      child:
          selectedIndex == 2
              ? buildAutoScrollRow(texts)
              : Row(
                children: [
                  ...List.generate(
                    texts.length,
                    (index) => [
                      Expanded(
                        child: Text(
                          texts[index],
                          style: AppTypography.s12.regular.copyWith(
                            color: AppColors.neutral03,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (index < texts.length - 1)
                        Container(
                          width: 1.w,
                          height: 20.h,
                          color: AppColors.neutral06,
                        ),
                    ],
                  ).expand((x) => x),
                  SizedBox(width: 8.w),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16.sp,
                    color: AppColors.neutral04,
                  ),
                ],
              ),
    );
  }
}

class BottomRow extends StatelessWidget {
  final List<ProcessStep> steps;

  const BottomRow({Key? key, required this.steps}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(steps.length, (index) {
        final step = steps[index];
        return Expanded(
          child: Column(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(step.icon, size: 20.sp, color: AppColors.neutral03),
              ),
              SizedBox(height: 8.h),
              Text(
                step.title,
                style: AppTypography.s10.regular.copyWith(
                  color: AppColors.neutral03,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ],
          ),
        );
      }),
    );
  }
}

class ProcessInfoBottomSheet extends StatelessWidget {
  final String title;
  final String subTitle;
  final List<ProcessInfo> processInfo;

  const ProcessInfoBottomSheet({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.processInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      child: Column(
        children: [
          BottomSheetHeader(title: title, subTitle: subTitle),
          BottomSheetContent(processInfo: processInfo),
          BottomSheetActionButton(),
        ],
      ),
    );
  }
}

class BottomSheetHeader extends StatelessWidget {
  final String title;
  final String subTitle;

  const BottomSheetHeader({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 24.w),
              Text(title, style: AppTypography.s16.bold),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.close, size: 24.sp),
              ),
            ],
          ),
        ),
        Text(
          subTitle,
          style: AppTypography.s12.regular.copyWith(color: AppColors.neutral03),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}

class BottomSheetContent extends StatelessWidget {
  final List<ProcessInfo> processInfo;

  const BottomSheetContent({Key? key, required this.processInfo})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: processInfo.length,
        itemBuilder: (context, index) {
          final info = processInfo[index];
          return Container(
            margin: EdgeInsets.only(bottom: 16.h),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.neutral08,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 4.h, right: 12.w),
                  child: Icon(
                    Icons.check,
                    size: 16.sp,
                    color: AppColors.primary01,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(info.title, style: AppTypography.s14.medium),
                      SizedBox(height: 4.h),
                      Text(
                        info.description,
                        style: AppTypography.s12.regular.copyWith(
                          color: AppColors.neutral03,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class BottomSheetActionButton extends StatelessWidget {
  const BottomSheetActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary01,
            padding: EdgeInsets.symmetric(vertical: 12.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: Text(
            'Đồng ý',
            style: AppTypography.s16.medium.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
