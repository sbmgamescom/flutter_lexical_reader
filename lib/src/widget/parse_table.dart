part of '../parser.dart';

class ParseTable extends StatelessWidget {
  const ParseTable({
    super.key,
    required this.child,
  });
  final Map<String, dynamic> child;

  List<TableRow> _buildTableRows(List<dynamic> childrenData) {
    final temp = childrenData
        .where((row) => row['type'] == 'tablerow')
        .map<TableRow>((tableRow) => _buildTableRow(tableRow))
        .toList();
    return temp;
  }

  TableRow _buildTableRow(dynamic row) {
    List<Widget> rowCells = (row['children'] ?? [])
        .where((cell) => cell['type'] == 'tablecell')
        .map<Widget>((cell) => _BuildTableCell(cell))
        .toList();

    if (rowCells.isEmpty) {
      rowCells.add(const SizedBox());
    }

    return TableRow(
      children: rowCells,
    );
  }

  @override
  Widget build(BuildContext context) {
    final tablePadding = _PropsInheritedWidget.of(context)?.tablePadding ??
        const EdgeInsets.all(2.0);

    return Padding(
      padding: tablePadding,
      child: Table(
        children: _buildTableRows(child['children']),
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
        _PropsInheritedWidget.of(context)?.tableCellPadding ??
            const EdgeInsets.all(8.0);
    return Padding(
      padding: tableCellPadding,
      child: Column(
        children: parseJsonChildrenWidget(cell['children'] ?? []),
      ),
    );
  }
}
      // .map<TableRow>((tableRow) => _buildTableRow(tableRow))