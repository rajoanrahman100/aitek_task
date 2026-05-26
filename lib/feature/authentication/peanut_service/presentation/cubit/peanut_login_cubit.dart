import 'package:aitek_task/core/di/service_locator.dart';
import 'package:aitek_task/feature/authentication/peanut_service/domain/entities/login_request_params.dart';
import 'package:aitek_task/feature/authentication/peanut_service/domain/usecases/peanut_login_use_case.dart';
import 'package:aitek_task/feature/authentication/peanut_service/presentation/cubit/peanut_login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeanutServiceLoginCubit extends Cubit<PeanutLoginState> {
  PeanutServiceLoginCubit() : super(PeanutLoginInitial());

  Future<void> login(int login, String password, BuildContext context) async {
    emit(PeanutLoginLoading());

    final result = await sl<PeanutServiceLoginUseCase>().call(
      params: LoginReqParams(login: login, password: password),
    );

    result.fold(
      (failure) {
        String errorMessage = failure.title ?? 'Authentication failed';
        if (failure.errors?.login != null &&
            failure.errors!.login!.isNotEmpty) {
          errorMessage = failure.errors!.login!.join(', ');
        }
        emit(PeanutLoginFailure(errorMessage));
      },
      (success) {
        if (success.result != true) {
          emit(const PeanutLoginFailure('Invalid login ID or password'));
          return;
        }

        emit(PeanutLoginSuccess(success));
      },
    );
  }
}
