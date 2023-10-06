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
        .map<Widget>((cell) => _BuildTableCell(cell))
        .toList();

    return TableRow(
      children: rowCells,
    );
  }

  @override
  Widget build(BuildContext context) {
    final tablePadding = PropsInheritedWidget.of(context)?.tablePadding ??
        const EdgeInsets.all(2.0);
    return Padding(
      padding: tablePadding,
      child: Table(
        children: _buildTableRows(child['children'] as List? ?? []),
        border: TableBorder.all(color: Colors.black54),
      ),
    );
  }
}

class _BuildTableCell extends StatelessWidget {
  const _BuildTableCell(this.cell);

  final dynamic cell;

  @override
  Widget build(BuildContext context) {
    final tableCellPadding =
        PropsInheritedWidget.of(context)?.tableCellPadding ??
            const EdgeInsets.all(8.0);
    return Padding(
      padding: tableCellPadding,
      child: Column(
        children: parseJsonChildrenWidget(cell['children'] ?? []),
      ),
    );
  }
}
