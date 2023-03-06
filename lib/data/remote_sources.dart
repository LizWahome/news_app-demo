import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

abstract class RemoteSources {
  Future<http.Response> get(String url);
}

class RemoteSourceImpl implements RemoteSources {
  RemoteSourceImpl();
  @override
  Future<http.Response> get(String url) async {
    try {
      final res = await http.get(Uri.parse(url));
      return res;
    } on SocketException {
      toast("Please connect to the internet");
      throw ("Please connect to the internet");
    } catch (e) {
      throw ("$e");
    }
  } 
}
