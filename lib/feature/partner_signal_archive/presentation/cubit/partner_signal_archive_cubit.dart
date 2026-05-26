import 'package:aitek_task/core/di/service_locator.dart';
import 'package:aitek_task/core/repositories/i_cache_repository.dart';
import 'package:aitek_task/feature/partner_signal_archive/domain/entities/trading_signal_request_params.dart';
import 'package:aitek_task/feature/partner_signal_archive/domain/usecases/get_analytic_signals_use_case.dart';
import 'package:aitek_task/feature/partner_signal_archive/presentation/cubit/partner_signal_archive_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PartnerSignalArchiveCubit extends Cubit<PartnerSignalArchiveState> {
  PartnerSignalArchiveCubit() : super(PartnerSignalArchiveInitial());

  Future<void> loadSignals({required List<String> pairs, required DateTime from, required DateTime to}) async {
    if (pairs.isEmpty) {
      emit(const PartnerSignalArchiveFailure('Select at least one pair'));
      return;
    }

    emit(PartnerSignalArchiveLoading());

    final loginId = await sl<ICacheRepository>().fetchPartnerLoginID();
    final token = await sl<ICacheRepository>().fetchPartnerToken();
    final login = int.tryParse(loginId ?? '');

    if (login == null || token == null || token.trim().isEmpty) {
      emit(const PartnerSignalArchiveFailure('Partner session was not found'));
      return;
    }

    final result = await sl<GetAnalyticSignalsUseCase>().call(
      params: TradingSignalRequestParams(login: login, partnerToken: token, pairs: pairs, from: from, to: to),
    );

    result.fold(
      (failure) {
        emit(PartnerSignalArchiveFailure(failure.message ?? 'Unable to load trading signals'));
      },
      (signals) {
        emit(PartnerSignalArchiveSuccess(signals));
      },
    );
  }
}
