import 'package:aitek_task/feature/authentication/partner_service/presentation/cubit/partner_login_cubit.dart';
import 'package:aitek_task/feature/authentication/peanut_service/presentation/cubit/peanut_login_cubit.dart';
import 'package:aitek_task/feature/partner_signal_archive/presentation/cubit/partner_signal_archive_cubit.dart';
import 'package:aitek_task/feature/partner_signal_archive/presentation/partner_signal_archive_screen.dart';
import 'package:aitek_task/feature/promo_materials/presentation/cubit/promo_materials_cubit.dart';
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

  Future<_StartupDestination> _startupDestination() async {
    final cache = sl<ICacheRepository>();

    final partnerLoginId = await cache.fetchPartnerLoginID();
    final partnerToken = await cache.fetchPartnerToken();
    final hasPartnerSession =
        int.tryParse(partnerLoginId ?? '') != null &&
        partnerToken != null &&
        partnerToken.trim().isNotEmpty;

    if (hasPartnerSession) {
      return _StartupDestination.partnerSignals;
    }

    final peanutLoginId = await cache.fetchLoginID();
    final peanutToken = await cache.fetchToken();
    final hasPeanutSession =
        int.tryParse(peanutLoginId ?? '') != null &&
        peanutToken != null &&
        peanutToken.trim().isNotEmpty;

    if (hasPeanutSession) {
      return _StartupDestination.peanutProfile;
    }

    return _StartupDestination.landing;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PeanutServiceLoginCubit()),
        BlocProvider(create: (context) => PartnerLoginCubit()),
        BlocProvider(create: (context) => PartnerSignalArchiveCubit()),
        BlocProvider(create: (context) => PromoMaterialsCubit()),
        BlocProvider(create: (context) => UserProfileCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        home: FutureBuilder<_StartupDestination>(
          future: _startupDestination(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            switch (snapshot.data) {
              case _StartupDestination.partnerSignals:
                return const PartnerSignalArchiveScreen();
              case _StartupDestination.peanutProfile:
                return const UserProfileScreen();
              case _StartupDestination.landing:
              case null:
                return const LandingScreen();
            }
          },
        ),
      ),
    );
  }
}

enum _StartupDestination { landing, peanutProfile, partnerSignals }
