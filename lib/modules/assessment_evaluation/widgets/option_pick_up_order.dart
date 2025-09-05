import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../constants/pickup_constants.dart';
import '../data/pickup_data.dart';
import '../domain/pickup_models.dart';
import '../controllers/assessment_evaluation_controller.dart';
import 'pickup_components.dart';

class OptionPickUpOrder extends StatefulWidget {
  const OptionPickUpOrder({Key? key}) : super(key: key);

  @override
  State<OptionPickUpOrder> createState() => _OptionPickUpOrderState();
}

class _OptionPickUpOrderState extends State<OptionPickUpOrder>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  ScrollController? _topRowScrollController;
  Timer? _autoScrollTimer;

  late final List<TabData> _tabsData;

  @override
  void initState() {
    super.initState();
    _tabsData = PickupData.getTabsData();
    _initializeAnimations();

    // Set phương thức mặc định (tab đầu tiên)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        final controller = Get.find<AssessmentEvaluationController>();
        controller.setPickupMethod(_selectedIndex);
      } catch (e) {
        // Controller chưa được khởi tạo, bỏ qua
      }
    });
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: PickupConstants.animationDuration,
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTabBar(
          tabs: _tabsData,
          selectedIndex: _selectedIndex,
          onTabSelected: _handleTabSelection,
        ),
        TabContent(
          selectedIndex: _selectedIndex,
          tabData: _tabsData[_selectedIndex],
          buildTimeSlot: _buildTimeSlot,
          onProcessStepsTap: _showProcessInfoBottomSheet,
          buildAutoScrollRow: _buildAutoScrollRow,
        ),
      ],
    );
  }

  void _handleTabSelection(int index) {
    if (index != _selectedIndex) {
      _stopAutoScroll();
      setState(() {
        _selectedIndex = index;
      });
      _animationController.reset();
      _animationController.forward();

      // Thông báo cho controller về phương thức đã chọn
      try {
        final controller = Get.find<AssessmentEvaluationController>();
        controller.setPickupMethod(index);
      } catch (e) {
        // Controller chưa được khởi tạo, bỏ qua
      }

      if (index == 2) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _startAutoScroll();
        });
      }
    }
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    if (_topRowScrollController?.hasClients != true) return;

    _autoScrollTimer = Timer.periodic(PickupConstants.scrollDuration, (_) {
      if (_topRowScrollController?.hasClients != true) return;

      final controller = _topRowScrollController!;
      final maxOffset = controller.position.maxScrollExtent;
      final currentOffset = controller.offset;

      if (currentOffset - PickupConstants.scrollStep <= 0) {
        controller.jumpTo(maxOffset);
      } else {
        controller.jumpTo(currentOffset - PickupConstants.scrollStep);
      }
    });
  }

  void _stopAutoScroll() {
    _autoScrollTimer?.cancel();
  }

  Widget _buildAutoScrollRow(List<String> texts) {
    _topRowScrollController ??= ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_selectedIndex == 2) {
        _startAutoScroll();
      }
    });

    return SingleChildScrollView(
      controller: _topRowScrollController,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      child: Row(
        children: [
          ...List.generate(
            texts.length * PickupConstants.textRepeatCount,
            (index) => [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Text(
                  texts[index % texts.length],
                  style: AppTypography.s12.regular.copyWith(
                    color: AppColors.neutral03,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (index < (texts.length * PickupConstants.textRepeatCount) - 1)
                Container(
                  width: 1.w,
                  height: 20.h,
                  color: AppColors.neutral06,
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
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

  Widget _buildTimeSlot(String time, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color:
            isSelected ? AppColors.primary01.withOpacity(0.1) : AppColors.white,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: isSelected ? AppColors.primary01 : AppColors.neutral06,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isSelected
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked,
            size: 16.sp,
            color: isSelected ? AppColors.primary01 : AppColors.neutral03,
          ),
          SizedBox(width: 8.w),
          Text(
            time,
            style: AppTypography.s12.regular.copyWith(
              color: isSelected ? AppColors.primary01 : AppColors.neutral01,
            ),
          ),
        ],
      ),
    );
  }

  void _showProcessInfoBottomSheet() {
    final currentTab = _tabsData[_selectedIndex];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder:
          (context) => ProcessInfoBottomSheet(
            title: currentTab.bottomSheetTitle,
            subTitle: currentTab.bottomSheetSubTitle,
            processInfo: currentTab.processInfo,
          ),
    );
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _topRowScrollController?.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
