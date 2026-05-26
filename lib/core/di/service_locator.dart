import 'package:aitek_task/core/network/dio_client.dart';
import 'package:aitek_task/core/repositories/cache_repository_impl.dart';
import 'package:aitek_task/core/repositories/i_cache_repository.dart';
import 'package:aitek_task/feature/authentication/partner_service/data/data_sources/partner_auth_remote_data_source.dart';
import 'package:aitek_task/feature/authentication/partner_service/data/data_sources/partner_auth_remote_data_source_impl.dart';
import 'package:aitek_task/feature/authentication/partner_service/data/repositories/partner_auth_repository_impl.dart';
import 'package:aitek_task/feature/authentication/partner_service/domain/repositories/partner_auth_repository.dart';
import 'package:aitek_task/feature/authentication/partner_service/domain/usecases/partner_login_use_case.dart';
import 'package:aitek_task/feature/authentication/peanut_service/data/data_sources/peanut_auth_remote_data_source.dart';
import 'package:aitek_task/feature/authentication/peanut_service/data/data_sources/peanut_auth_remote_data_source_impl.dart';
import 'package:aitek_task/feature/authentication/peanut_service/data/repositories/peanut_auth_repository_impl.dart';
import 'package:aitek_task/feature/authentication/peanut_service/domain/repositories/peanut_auth_repository.dart';
import 'package:aitek_task/feature/authentication/peanut_service/domain/usecases/peanut_login_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton<ICacheRepository>(() => CacheRepositoryImpl(sharedPreference: sl()));
  sl.registerLazySingleton<DioClient>(() => DioClient());

  //Api Services
  sl.registerLazySingleton<PeanutAuthRemoteDataSource>(() => PeanutAuthRemoteDataSourceImpl());
  sl.registerLazySingleton<PartnerAuthRemoteDataSource>(() => PartnerAuthRemoteDataSourceImpl());

  //Repositories
  sl.registerLazySingleton<PeanutAuthRepository>(() => PeanutAuthRepositoryImpl());
  sl.registerLazySingleton<PartnerAuthRepository>(() => PartnerAuthRepositoryImpl());

  //Use Cases
  sl.registerLazySingleton<PeanutServiceLoginUseCase>(() => PeanutServiceLoginUseCase());
  sl.registerLazySingleton<PartnerLoginUseCase>(() => PartnerLoginUseCase());
}
