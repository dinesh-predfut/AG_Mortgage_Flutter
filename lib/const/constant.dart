import 'package:shared_preferences/shared_preferences.dart';

class Params {
  static String userToken = "null";
  static String userId = "null";
  static String refreshToken = "null";
  static String phoneNumber = "null";

  static String tokenExpiry = "null";
}

class SetSharedPref {
  setData(
      {required String token,
      required String userId,
      required String phoneNumber}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("token", token);
    // pref.setString("refreshToken", refreshToken);
    pref.setString("phoneNumber", phoneNumber);
    pref.setString("userId", userId);

    Params.userToken = token;
    // Params.refreshToken = refreshToken;
    Params.phoneNumber = phoneNumber;
    Params.userId = userId;
  }

  Future getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Params.userToken = pref.getString("token") ?? "null";
    Params.refreshToken = pref.getString("refreshToken") ?? "null";
    Params.phoneNumber = pref.getString("phoneNumber") ?? "null";
    Params.userId = pref.getString("userId") ?? "null";
  }

  clearData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();

    Params.userToken = "null";
    Params.refreshToken = "null";
    Params.phoneNumber = "null";
    Params.userId = "null";
    Params.tokenExpiry = "null";
  }
}
