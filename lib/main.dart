import 'package:aitek_task/feature/authentication/partner_service/presentation/cubit/partner_login_cubit.dart';
import 'package:aitek_task/feature/authentication/peanut_service/presentation/cubit/peanut_login_cubit.dart';
import 'package:aitek_task/feature/user_profile/presentation/cubit/user_profile_cubit.dart';
import 'package:aitek_task/feature/user_profile/presentation/screens/user_profile_screen.dart';
import 'package:aitek_task/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/di/service_locator.dart';
import 'core/repositories/i_cache_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'env');
  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> _hasPeanutSession() async {
    final loginId = await sl<ICacheRepository>().fetchLoginID();
    final token = await sl<ICacheRepository>().fetchToken();

    return int.tryParse(loginId ?? '') != null &&
        token != null &&
        token.trim().isNotEmpty;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PeanutServiceLoginCubit()),
        BlocProvider(create: (context) => PartnerLoginCubit()),
        BlocProvider(create: (context) => UserProfileCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        home: FutureBuilder<bool>(
          future: _hasPeanutSession(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (snapshot.data == true) {
              return const UserProfileScreen();
            }

            return const LandingScreen();
          },
        ),
      ),
    );
  }
}
