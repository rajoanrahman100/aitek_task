import 'package:aitek_task/feature/partner_signal_archive/data/models/trading_signal_request_model.dart';
import 'package:equatable/equatable.dart';

abstract class PartnerSignalArchiveState extends Equatable {
  const PartnerSignalArchiveState();

  @override
  List<Object?> get props => [];
}

class PartnerSignalArchiveInitial extends PartnerSignalArchiveState {}

class PartnerSignalArchiveLoading extends PartnerSignalArchiveState {}

class PartnerSignalArchiveSuccess extends PartnerSignalArchiveState {
  const PartnerSignalArchiveSuccess(this.signals);

  final List<TradingSignalModel> signals;

  @override
  List<Object?> get props => [signals];
}

class PartnerSignalArchiveFailure extends PartnerSignalArchiveState {
  const PartnerSignalArchiveFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
