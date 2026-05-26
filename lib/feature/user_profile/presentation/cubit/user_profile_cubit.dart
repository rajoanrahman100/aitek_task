import 'package:aitek_task/core/di/service_locator.dart';
import 'package:aitek_task/core/repositories/i_cache_repository.dart';
import 'package:aitek_task/feature/user_profile/domain/entities/user_information_request_params.dart';
import 'package:aitek_task/feature/user_profile/domain/usecases/get_account_information_use_case.dart';
import 'package:aitek_task/feature/user_profile/presentation/cubit/user_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit() : super(UserProfileInitial());

  Future<void> getAccountInformation() async {
    emit(UserProfileLoading());

    final loginId = await sl<ICacheRepository>().fetchLoginID();
    final token = await sl<ICacheRepository>().fetchToken();
    final login = int.tryParse(loginId ?? '');

    if (login == null || token == null || token.trim().isEmpty) {
      emit(const UserProfileFailure('Authorization information was not found'));
      return;
    }

    final result = await sl<GetAccountInformationUseCase>().call(
      params: UserInformationRequestParams(login: login, token: token),
    );

    result.fold(
      (failure) {
        emit(UserProfileFailure(failure.message ?? 'Unable to load profile'));
      },
      (success) {
        emit(UserProfileSuccess(success));
      },
    );
  }
}
