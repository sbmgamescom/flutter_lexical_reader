import 'package:flutter/material.dart';

class ExpandedOptions {}

class ExpandableListView extends StatefulWidget {
  final List<Widget> children;

  const ExpandableListView({
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  State<ExpandableListView> createState() => _ExpandableListViewState();
}

class _ExpandableListViewState extends State<ExpandableListView>
    with TickerProviderStateMixin {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
            child: ConstrainedBox(
              constraints: _isExpanded
                  ? const BoxConstraints()
                  : const BoxConstraints(maxHeight: 200),
              child: SingleChildScrollView(
                // Отключает скроллинг внутри SingleChildScrollView
                physics: _isExpanded
                    ? const ScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                child: Column(
                  children: widget.children,
                ),
              ),
            ),
          ),
        ),
        Row(
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Text(_isExpanded ? 'Скрыть' : 'Показать'),
            ),
          ],
        ),
      ],
    );
  }
}
