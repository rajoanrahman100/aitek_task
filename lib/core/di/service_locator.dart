import 'package:aitek_task/core/repositories/cache_repository_impl.dart';
import 'package:aitek_task/core/repositories/i_cache_repository.dart';
import 'package:aitek_task/feature/authentication/peanut_service/data/data_source/auth_api_service.dart';
import 'package:aitek_task/feature/authentication/peanut_service/data/repositories/auth_repository_impl.dart';
import 'package:aitek_task/feature/authentication/peanut_service/domain/usecases/authentication_usecases.dart';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../feature/authentication/peanut_service/domain/repositories/auth_repository.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton<ICacheRepository>(() => CacheRepositoryImpl(sharedPreference: sl()));

  //Api Services
  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());
  sl.registerSingleton<AuthApiServiceImpl>(AuthApiServiceImpl());

  //Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());


  //Use Cases
  sl.registerSingleton<PeanutServiceLoginUseCase>(PeanutServiceLoginUseCase());
}
