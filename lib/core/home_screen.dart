import 'package:aitek_task/core/di/service_locator.dart';
import 'package:aitek_task/core/repositories/i_cache_repository.dart';
import 'package:aitek_task/core/utils/logger.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _getUserToken() async {
    String? token = await sl<ICacheRepository>().fetchToken();
    if (token != null) {
      logger.i("User Token $token");
    }
  }

  Future<void> _getUserLoginID() async {
    String? token = await sl<ICacheRepository>().fetchLoginID();
    if (token != null) {
      logger.i("User loginID $token");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserToken();
    _getUserLoginID();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
