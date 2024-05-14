enum DateDownloadDataType { none, creditItem, credit }

extension DateDownloadDataTypeExtension on DateDownloadDataType {
  String get japanName {
    switch (this) {
      case DateDownloadDataType.none:
        return '';

      case DateDownloadDataType.creditItem:
        return 'creditItem';

      case DateDownloadDataType.credit:
        return 'credit';
    }
  }
}
