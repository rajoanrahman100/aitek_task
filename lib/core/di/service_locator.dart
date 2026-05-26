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
import 'package:aitek_task/feature/user_profile/data/data_sources/user_profile_remote_data_source.dart';
import 'package:aitek_task/feature/user_profile/data/data_sources/user_profile_remote_data_source_impl.dart';
import 'package:aitek_task/feature/user_profile/data/repositories/user_profile_repository_impl.dart';
import 'package:aitek_task/feature/user_profile/domain/repositories/user_profile_repository.dart';
import 'package:aitek_task/feature/user_profile/domain/usecases/get_account_information_use_case.dart';
import 'package:aitek_task/feature/user_profile/domain/usecases/get_last_four_phone_number_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton<ICacheRepository>(
    () => CacheRepositoryImpl(sharedPreference: sl()),
  );
  sl.registerLazySingleton<DioClient>(() => DioClient());

  //Api Services
  sl.registerLazySingleton<PeanutAuthRemoteDataSource>(
    () => PeanutAuthRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<PartnerAuthRemoteDataSource>(
    () => PartnerAuthRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<UserProfileRemoteDataSource>(
    () => UserProfileRemoteDataSourceImpl(),
  );

  //Repositories
  sl.registerLazySingleton<PeanutAuthRepository>(
    () => PeanutAuthRepositoryImpl(),
  );
  sl.registerLazySingleton<PartnerAuthRepository>(
    () => PartnerAuthRepositoryImpl(),
  );
  sl.registerLazySingleton<UserProfileRepository>(
    () => UserProfileRepositoryImpl(),
  );

  //Use Cases
  sl.registerLazySingleton<PeanutServiceLoginUseCase>(
    () => PeanutServiceLoginUseCase(),
  );
  sl.registerLazySingleton<PartnerLoginUseCase>(() => PartnerLoginUseCase());
  sl.registerLazySingleton<GetAccountInformationUseCase>(
    () => GetAccountInformationUseCase(),
  );
  sl.registerLazySingleton<GetLastFourPhoneNumberUseCase>(
    () => GetLastFourPhoneNumberUseCase(),
  );
}
