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

    return TableRow(
      children: rowCells,
    );
  }

  @override
  Widget build(BuildContext context) {
    final tablePadding = _PropsInheritedWidget.of(context)?.tablePadding ??
        const EdgeInsets.all(2.0);
    final rows = _buildTableRows(child['children']);
    final maxCells =
        rows.map((row) => row.children.length).reduce((a, b) => a > b ? a : b);

    // Ensure all rows have the same number of cells
    final normalizedRows = rows.map((row) {
      final cells = row.children;
      if (cells.length < maxCells) {
        final diff = maxCells - cells.length;
        cells.addAll(List.generate(diff, (_) => const SizedBox()));
      }
      return TableRow(children: cells);
    }).toList();

    return Padding(
      padding: tablePadding,
      child: Table(
        children: normalizedRows,
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
