import 'package:aitek_task/core/repositories/i_cache_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../local/shared_prefs_manager.dart';

class SharedPrefValue {
  static const String kUserToken = 'userToken';
  static const String kUserLoginID = 'userLoginID';
}

class CacheRepositoryImpl implements ICacheRepository {
  final SharedPreferences sharedPreference;

  CacheRepositoryImpl({required this.sharedPreference});

  @override
  Future<String?> fetchToken() async {
    // TODO: implement fetchToken
    return await SharedPref.read(SharedPrefValue.kUserToken);
  }

  @override
  Future<void> saveToken(String token) async {
    // TODO: implement saveToken
    await SharedPref.write(SharedPrefValue.kUserToken, token);
  }

  @override
  Future<String?> fetchLoginID() async {
    // TODO: implement fetchLoginID
    return await SharedPref.read(SharedPrefValue.kUserLoginID);
  }

  @override
  Future<void> saveLoginID(String loginID) async {
    // TODO: implement saveLoginID
    await SharedPref.write(SharedPrefValue.kUserLoginID, loginID);
  }

  @override
  Future<void> clearSession() async {
    await SharedPref.remove(SharedPrefValue.kUserToken);
    await SharedPref.remove(SharedPrefValue.kUserLoginID);
  }
}
