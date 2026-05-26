import 'package:aitek_task/core/repositories/i_cache_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../local/shared_prefs_manager.dart';

class SharedPrefValue {
  static const String kUserToken = 'userToken';
  static const String kUserLoginID = 'userLoginID';
  static const String kPartnerToken = 'partnerToken';
  static const String kPartnerLoginID = 'partnerLoginID';
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

  @override
  Future<String?> fetchPartnerLoginID() async {
    return await SharedPref.read(SharedPrefValue.kPartnerLoginID);
  }

  @override
  Future<String?> fetchPartnerToken() async {
    return await SharedPref.read(SharedPrefValue.kPartnerToken);
  }

  @override
  Future<void> savePartnerLoginID(String loginID) async {
    await SharedPref.write(SharedPrefValue.kPartnerLoginID, loginID);
  }

  @override
  Future<void> savePartnerToken(String token) async {
    await SharedPref.write(SharedPrefValue.kPartnerToken, token);
  }

  @override
  Future<void> clearPartnerSession() async {
    await SharedPref.remove(SharedPrefValue.kPartnerToken);
    await SharedPref.remove(SharedPrefValue.kPartnerLoginID);
  }
}
