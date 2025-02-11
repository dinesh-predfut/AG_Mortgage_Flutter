import 'package:shared_preferences/shared_preferences.dart';

class Params {
  static String userToken = "null";
  static int userId = 0;
  static String refreshToken = "null";
  static String phoneNumber = "null";
  static String tokenExpiry = "null";
}

class SetSharedPref {
  Future<void> setData({
    required String token,
    required int userId,
    required String phoneNumber,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("token", token);
    await pref.setString("phoneNumber", phoneNumber);
    await pref.setInt("userId", userId); 

    print("Saving userId: $userId");

    Params.userToken = token;
    Params.phoneNumber = phoneNumber;
    Params.userId = userId; 
  }

  Future<void> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Params.userToken = pref.getString("token") ?? "null";
    Params.refreshToken = pref.getString("refreshToken") ?? "null";
    Params.phoneNumber = pref.getString("phoneNumber") ?? "null";
    Params.userId = pref.getInt("userId") ?? 0; 

    print("Retrieved userId: ${Params.userId}"); 
  }

  Future<void> clearData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();

    Params.userToken = "null";
    Params.refreshToken = "null";
    Params.phoneNumber = "null";
    Params.userId = 0;
    Params.tokenExpiry = "null";
    
    print("Data cleared, userId is now ${Params.userId}"); // Debugging log
  }
}
