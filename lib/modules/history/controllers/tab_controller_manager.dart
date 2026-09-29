import 'package:expense_manager/modules/history/controllers/history_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabControllerManager extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      final historyController = Get.find<HistoryController>();
      historyController.tabIndex = tabController.index;
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}