import 'package:intl/intl.dart';

abstract class DateFormattrer {
  static DateFormat onlyYearMonthDay = DateFormat('yyyy/MM/dd');
  static DateFormat onlyTime = DateFormat('Hm');
}
