import 'package:flutter/material.dart';

class TabData {
  final String title;
  //final IconData icon;
  final List<String> topRowTexts;
  final List<ProcessStep> steps;
  final List<ProcessInfo> processInfo;
  final String bottomSheetTitle;
  final String bottomSheetSubTitle;

  TabData({
    required this.title,
    //required this.icon,
    required this.topRowTexts,
    required this.steps,
    required this.processInfo,
    required this.bottomSheetTitle,
    required this.bottomSheetSubTitle,
  });
}

class ProcessStep {
  final IconData icon;
  final String title;

  ProcessStep({required this.icon, required this.title});
}

class ProcessInfo {
  final String title;
  final String description;

  ProcessInfo({required this.title, required this.description});
}