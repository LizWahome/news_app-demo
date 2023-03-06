import 'package:get/get.dart';

extension Responses on Response {
  bool get ok => statusCode! ~/ 100 == 2;
}
