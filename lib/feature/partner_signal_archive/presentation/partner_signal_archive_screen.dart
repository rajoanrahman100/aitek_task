import 'package:aitek_task/core/theme/colors.dart';
import 'package:aitek_task/core/theme/style.dart';
import 'package:aitek_task/core/widgets/custom_button.dart';
import 'package:aitek_task/feature/partner_signal_archive/data/models/trading_signal_request_model.dart';
import 'package:aitek_task/feature/partner_signal_archive/presentation/cubit/partner_signal_archive_cubit.dart';
import 'package:aitek_task/feature/partner_signal_archive/presentation/cubit/partner_signal_archive_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PartnerSignalArchiveScreen extends StatefulWidget {
  const PartnerSignalArchiveScreen({super.key});

  @override
  State<PartnerSignalArchiveScreen> createState() => _PartnerSignalArchiveScreenState();
}

class _PartnerSignalArchiveScreenState extends State<PartnerSignalArchiveScreen> {
  static const _availablePairs = <String>['GBPJPY', 'EURJPY', 'EURUSD', 'GBPUSD', 'USDJPY', 'AUDUSD', 'USDCAD'];

  final Set<String> _selectedPairs = {'GBPJPY', 'EURJPY'};
  DateTimeRange _dateRange = DateTimeRange(start: DateTime.now().subtract(const Duration(days: 30)), end: DateTime.now());

  Future<void> _pickDateRange() async {
    final range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
      initialDateRange: _dateRange,
    );

    if (range == null) return;

    setState(() => _dateRange = range);
  }

  void _loadSignals() {
    context.read<PartnerSignalArchiveCubit>().loadSignals(
      pairs: _selectedPairs.toList(),
      from: _dateRange.start,
      to: DateTime(_dateRange.end.year, _dateRange.end.month, _dateRange.end.day, 23, 59, 59),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(title: const Text('Signal Archive'), backgroundColor: Colors.white, surfaceTintColor: Colors.white),
      body: SafeArea(
        child: BlocConsumer<PartnerSignalArchiveCubit, PartnerSignalArchiveState>(
          listener: (context, state) {
            if (state is PartnerSignalArchiveFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            final isLoading = state is PartnerSignalArchiveLoading;

            return Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                    children: [
                      Text('Trading signals', style: kBoldTextStyle.copyWith(fontSize: 24)),
                      const SizedBox(height: 8),
                      Text(
                        'Select pairs and a date range to load Partner signal history.',
                        style: kRegularTextStyle.copyWith(color: Colors.black54, height: 1.35),
                      ),
                      const SizedBox(height: 22),
                      Text('Currency pairs', style: kMediumTextStyle),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _availablePairs.map((pair) {
                          final selected = _selectedPairs.contains(pair);
                          return FilterChip(
                            label: Text(pair),
                            selected: selected,
                            onSelected: isLoading
                                ? null
                                : (value) {
                                    setState(() {
                                      if (value) {
                                        _selectedPairs.add(pair);
                                      } else {
                                        _selectedPairs.remove(pair);
                                      }
                                    });
                                  },
                            selectedColor: AppColor.primary.withValues(alpha: 0.14),
                            checkmarkColor: AppColor.primary,
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 22),
                      Text('Date range', style: kMediumTextStyle),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: isLoading ? null : _pickDateRange,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.date_range_outlined, size: 20),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text('${_formatDate(_dateRange.start)} - ${_formatDate(_dateRange.end)}', style: kRegularTextStyle),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),
                      _SignalStateView(state: state),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                  child: CustomButton(
                    title: 'Load Signals',
                    textColor: Colors.white,
                    onPress: isLoading ? null : _loadSignals,
                    child: isLoading
                        ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : null,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

class _SignalStateView extends StatelessWidget {
  const _SignalStateView({required this.state});

  final PartnerSignalArchiveState state;

  @override
  Widget build(BuildContext context) {
    if (state is PartnerSignalArchiveInitial) {
      return _EmptyMessage(icon: Icons.timeline_outlined, message: 'No signals loaded yet.');
    }

    if (state is PartnerSignalArchiveLoading) {
      return const Padding(
        padding: EdgeInsets.only(top: 32),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state is PartnerSignalArchiveFailure) {
      final failure = state as PartnerSignalArchiveFailure;
      return _EmptyMessage(icon: Icons.error_outline, message: failure.message);
    }

    if (state is PartnerSignalArchiveSuccess) {
      final success = state as PartnerSignalArchiveSuccess;
      if (success.signals.isEmpty) {
        return _EmptyMessage(icon: Icons.search_off_outlined, message: 'No signals found for this selection.');
      }

      return Column(children: success.signals.map((signal) => _SignalCard(signal: signal)).toList());
    }

    return const SizedBox.shrink();
  }
}

class _EmptyMessage extends StatelessWidget {
  const _EmptyMessage({required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 34, color: Colors.black38),
          const SizedBox(height: 10),
          Text(
            message,
            textAlign: TextAlign.center,
            style: kRegularTextStyle.copyWith(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class _SignalCard extends StatelessWidget {
  const _SignalCard({required this.signal});

  final TradingSignalModel signal;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(signal.pair ?? 'Unknown Pair', style: kSemiBoldTextStyle.copyWith(fontSize: 16))),
              Text(_commandLabel(signal.cmd), style: kMediumTextStyle.copyWith(color: AppColor.primary)),
            ],
          ),
          if (signal.comment?.trim().isNotEmpty == true) ...[
            const SizedBox(height: 8),
            Text(signal.comment!, style: kRegularTextStyle.copyWith(color: Colors.black54)),
          ],
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _Metric(label: 'Price', value: signal.price?.toString()),
              _Metric(label: 'SL', value: signal.sl?.toString()),
              _Metric(label: 'TP', value: signal.tp?.toString()),
              _Metric(label: 'Period', value: signal.period),
            ],
          ),
        ],
      ),
    );
  }

  String _commandLabel(int? cmd) {
    switch (cmd) {
      case 0:
        return 'Buy';
      case 1:
        return 'Sell';
      default:
        return cmd == null ? '-' : 'Cmd $cmd';
    }
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});

  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(color: const Color(0xFFF0F2F5), borderRadius: BorderRadius.circular(8)),
      child: Text('$label: ${value?.trim().isNotEmpty == true ? value : '-'}', style: kRegularTextStyle.copyWith(fontSize: 12)),
    );
  }
}
