part of '../parser.dart';

WrapAlignment _wrapFromString(String? format) {
  switch (format) {
    case 'center':
      return WrapAlignment.center;
    case 'left':
      return WrapAlignment.start;
    case 'right':
      return WrapAlignment.end;
    default:
      return WrapAlignment.start;
  }
}

CrossAxisAlignment _crossFromString(String? format) {
  switch (format) {
    case 'center':
      return CrossAxisAlignment.center;
    case 'left':
      return CrossAxisAlignment.start;
    case 'right':
      return CrossAxisAlignment.end;
    default:
      return CrossAxisAlignment.start;
  }
}
