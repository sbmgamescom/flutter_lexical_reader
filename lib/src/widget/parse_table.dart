part of '../parser.dart';

class _ParseTable extends StatelessWidget {
  const _ParseTable({
    required this.child,
  });
  final Map<String, dynamic> child;

  @override
  Widget build(BuildContext context) {
    List<TableRow> tableRows = (child['children'] ?? []).map<TableRow>(
      (row) {
        if (row['type'] == 'tablerow') {
          List<Widget> rowCells = (row['children'] ?? []).map<Widget>(
            (cell) {
              if (cell['type'] == 'tablecell') {
                return Column(
                  children: parseJsonChildrenWidget(cell['children'] ?? []),
                );
              }
              return const SizedBox.shrink();
            },
          ).toList();
          return TableRow(children: rowCells);
        }
        return const TableRow(children: []);
      },
    ).toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Table(
        children: tableRows,
        border: TableBorder.all(color: Colors.black54),
      ),
    );
  }
}
