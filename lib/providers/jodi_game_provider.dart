import 'package:flutter/material.dart';

class JodiGameChangeNotifier extends ChangeNotifier {
  final List<TextEditingController> textEditingControllers =
      List.generate(100, (_) => TextEditingController());

  List<FocusNode> focusNodes = List.generate(100, (index) => FocusNode());

  final ValueNotifier<List<Map<String, dynamic>>> containsValue =
      ValueNotifier([]);
  final ValueNotifier<num> totalAmount = ValueNotifier(0);

  void updateList(int index, String value) {
    int newValue = int.tryParse(value) ?? 0;
    containsValue.value =
        containsValue.value.where((e) => e['index'] != index).toList();

    if (newValue >= 10 && newValue <= 10000) {
      containsValue.value = [
        ...containsValue.value,
        {'index': index, 'value': newValue}
      ];
    }

    calculateTotal();
  }

  void calculateTotal() {
    totalAmount.value =
        containsValue.value.fold(0, (sum, item) => sum + item['value']);
  }

  void resetControllers() {
    for (var controller in textEditingControllers) {
      controller.clear();
    }
    totalAmount.value = 0;
    containsValue.value = [];
    notifyListeners();
  }

  @override
  void dispose() {
    for (var controller in textEditingControllers) {
      controller.dispose();
      controller.clear();
    }
    for (var node in focusNodes) {
      node.dispose();
    }

    containsValue.dispose();
    totalAmount.dispose();
    super.dispose();
  }
}
