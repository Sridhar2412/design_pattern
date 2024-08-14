import 'package:design_pattern/abstract%20factory/custom_widget.dart';
import 'package:flutter/material.dart';

class FactorySelection extends StatefulWidget {
  const FactorySelection({
    super.key,
    required this.widgetsFactoryList,
    required this.selectedIndex,
    required this.onChanged,
  });
  final List<IWidgetsFactory> widgetsFactoryList;
  final int selectedIndex;
  final Function(int?)? onChanged;
  @override
  State<FactorySelection> createState() => _FactorySelectionState();
}

class _FactorySelectionState extends State<FactorySelection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          widget.widgetsFactoryList.length,
          (index) => Row(
                children: [
                  Radio(
                    groupValue: widget.selectedIndex,
                    value: index,
                    onChanged: widget.onChanged,
                  ),
                  Text(widget.widgetsFactoryList[index].getTitle()),
                ],
              )),
    );
  }
}
