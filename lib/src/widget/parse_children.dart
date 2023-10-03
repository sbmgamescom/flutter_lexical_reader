// part of '../parser.dart';

// class _ParseQuote extends StatelessWidget {
//   const _ParseQuote({
//     required this.child,
//   });
//   final Map<String, dynamic> child;

//   @override
//   Widget build(BuildContext context) {
//     return children.map<Widget>(
//       (child) {
//         switch (child['type']) {
//           case 'heading':
//             return _ParseParagraph(child: child);
//           case 'paragraph':
//             return _ParseParagraph(child: child);
//           case 'text':
//             return _ParseText(
//                 child: child,
//                 textStyle: textStyle ?? const TextStyle(fontSize: 14));
//           case 'quote':
//             return _ParseParagraph(child: child);
//           case 'image':
//             return _ParseImage(child: child);
//           case 'equation':
//             return _ParseEquation(child: child);
//           case 'table':
//             return _ParseTable(child: child);
//           case 'list':
//             return _ParseList(child: child);
//           case 'listitem':
//             return _ParseListItem(child: child);
//           default:
//             return const SizedBox.shrink();
//         }
//       },
//     ).toList();
//   }
// }
