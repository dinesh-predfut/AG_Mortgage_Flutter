// controller_manager.dart
import 'package:flutter/material.dart';

class ControllerManager {
  static final ControllerManager _instance = ControllerManager._internal();
  factory ControllerManager() => _instance;
  ControllerManager._internal();

  final List<TextEditingController> _controllers = [];

  void registerController(TextEditingController controller) {
    _controllers.add(controller);
  }

  void clearAll() {
    for (var controller in _controllers) {
      controller.clear();
    }
  }

  void disposeAll() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    _controllers.clear();
  }
}
