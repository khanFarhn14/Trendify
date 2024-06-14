import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage{
  
  // Keys
  static const String _userLoggedInKey = "USERLOGGEDINKEY";
  static const String _userNameKey = "USERNAMEKEY";

  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn)async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(_userLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> cacheUserName(String userName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(_userNameKey, userName);
  }

  // Get User Logged in Status
  static Future<bool?> getUserLoggedInStatus()async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(_userLoggedInKey);
  }

  static Future<String?> getCacheUserName()async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(_userNameKey);
  }
}