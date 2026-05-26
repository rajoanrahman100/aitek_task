import 'package:aitek_task/core/di/service_locator.dart';
import 'package:aitek_task/core/repositories/i_cache_repository.dart';
import 'package:aitek_task/feature/authentication/partner_service/domain/entities/partner_login_request_params.dart';
import 'package:aitek_task/feature/authentication/partner_service/domain/usecases/partner_login_use_case.dart';
import 'package:aitek_task/feature/authentication/partner_service/presentation/cubit/partner_login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PartnerLoginCubit extends Cubit<PartnerLoginState> {
  PartnerLoginCubit() : super(PartnerLoginInitial());

  Future<void> login(int login, String password) async {
    emit(PartnerLoginLoading());

    final result = await sl<PartnerLoginUseCase>().call(
      params: PartnerLoginRequestParams(login: login, password: password),
    );

    result.fold(
      (failure) {
        emit(PartnerLoginFailure(failure.message ?? 'Authentication failed'));
      },
      (success) async {
        if (!success.hasToken) {
          emit(const PartnerLoginFailure('Authentication failed'));
          return;
        }

        await sl<ICacheRepository>().savePartnerLoginID(login.toString());
        await sl<ICacheRepository>().savePartnerToken(success.token!.trim());

        emit(PartnerLoginSuccess(success));
      },
    );
  }
}
