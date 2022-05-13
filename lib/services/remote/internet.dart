import 'package:connectivity_plus/connectivity_plus.dart';

class Internet {
  static Future<bool> checkConnectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    //if return true then internet is connected
    return connectivityResult == ConnectivityResult.none ? false : true;
  }
}
