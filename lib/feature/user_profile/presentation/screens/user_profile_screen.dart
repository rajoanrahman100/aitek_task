import 'package:aitek_task/core/theme/colors.dart';
import 'package:aitek_task/core/theme/style.dart';
import 'package:aitek_task/core/widgets/custom_button.dart';
import 'package:aitek_task/feature/user_profile/data/models/user_information_response_model.dart';
import 'package:aitek_task/feature/user_profile/presentation/cubit/user_profile_cubit.dart';
import 'package:aitek_task/feature/user_profile/presentation/cubit/user_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserProfileCubit>().getAccountInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text('User Profile'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: SafeArea(
        child: BlocBuilder<UserProfileCubit, UserProfileState>(
          builder: (context, state) {
            if (state is UserProfileLoading || state is UserProfileInitial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is UserProfileFailure) {
              return _FailureView(message: state.message);
            }

            if (state is UserProfileSuccess) {
              return _ProfileContent(
                userInformation: state.userInformation,
                lastFourPhoneNumber: state.lastFourPhoneNumber,
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _FailureView extends StatelessWidget {
  const _FailureView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 54, color: Colors.redAccent),
          const SizedBox(height: 14),
          Text(
            message,
            textAlign: TextAlign.center,
            style: kMediumTextStyle.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 20),
          CustomButton(
            title: 'Try Again',
            textColor: Colors.white,
            onPress: () {
              context.read<UserProfileCubit>().getAccountInformation();
            },
          ),
        ],
      ),
    );
  }
}

class _ProfileContent extends StatelessWidget {
  const _ProfileContent({
    required this.userInformation,
    required this.lastFourPhoneNumber,
  });

  final UserInformationResponseModel userInformation;
  final String lastFourPhoneNumber;

  @override
  Widget build(BuildContext context) {
    final profileItems = <_ProfileItem>[
      _ProfileItem('Phone', lastFourPhoneNumber),
      _ProfileItem('Country', userInformation.country),
      _ProfileItem('City', userInformation.city),
      _ProfileItem('Address', userInformation.address),
      _ProfileItem('Zip Code', userInformation.zipCode),
      _ProfileItem('Balance', userInformation.balance?.toString()),
      _ProfileItem('Equity', userInformation.equity?.toString()),
      _ProfileItem('Free Margin', userInformation.freeMargin?.toString()),
      _ProfileItem('Currency', userInformation.currency?.toString()),
      _ProfileItem('Leverage', userInformation.leverage?.toString()),
      _ProfileItem(
        'Current Trades',
        userInformation.currentTradesCount?.toString(),
      ),
      _ProfileItem(
        'Current Volume',
        userInformation.currentTradesVolume?.toString(),
      ),
      _ProfileItem(
        'Total Trades',
        userInformation.totalTradesCount?.toString(),
      ),
      _ProfileItem(
        'Total Volume',
        userInformation.totalTradesVolume?.toString(),
      ),
      _ProfileItem('Open Trades', _formatBool(userInformation.isAnyOpenTrades)),
      _ProfileItem('Swap Free', _formatBool(userInformation.isSwapFree)),
      _ProfileItem('Type', userInformation.type?.toString()),
      _ProfileItem(
        'Verification Level',
        userInformation.verificationLevel?.toString(),
      ),
    ];

    return RefreshIndicator(
      onRefresh: () {
        return context.read<UserProfileCubit>().getAccountInformation();
      },
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColor.primary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userInformation.name?.trim().isNotEmpty == true
                            ? userInformation.name!
                            : 'Peanut Account',
                        style: kSemiBoldTextStyle.copyWith(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        userInformation.country ?? 'Profile information',
                        style: kRegularTextStyle.copyWith(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          ...profileItems.map((item) => _InfoTile(item: item)),
        ],
      ),
    );
  }

  static String? _formatBool(bool? value) {
    if (value == null) return null;
    return value ? 'Yes' : 'No';
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.item});

  final _ProfileItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              item.label,
              style: kRegularTextStyle.copyWith(color: Colors.black54),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              item.value?.trim().isNotEmpty == true ? item.value! : '-',
              textAlign: TextAlign.right,
              style: kMediumTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileItem {
  const _ProfileItem(this.label, this.value);

  final String label;
  final String? value;
}
