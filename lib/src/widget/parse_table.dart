part of '../parser.dart';

class _ParseTable extends StatelessWidget {
  const _ParseTable({
    required this.child,
  });
  final Map<String, dynamic> child;

  List<TableRow> _buildTableRows(List<dynamic> childrenData) {
    return childrenData
        .where((row) => row['type'] == 'tablerow')
        .map<TableRow>(_buildTableRow)
        .toList();
  }

  TableRow _buildTableRow(dynamic row) {
    List<Widget> rowCells = (row['children'] as List? ?? [])
        .where((cell) => cell['type'] == 'tablecell')
        .map<Widget>(_buildTableCell)
        .toList();

    return TableRow(children: rowCells);
  }

  Widget _buildTableCell(dynamic cell) {
    return Column(
      children: parseJsonChildrenWidget(cell['children'] ?? []),
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = PropsInheritedWidget.of(context)?.tablePadding ??
        const EdgeInsets.all(2.0);
    return Padding(
      padding: padding,
      child: Table(
        children: _buildTableRows(child['children'] as List? ?? []),
        border: TableBorder.all(color: Colors.black54),
      ),
    );
  }
}
