import 'package:aitek_task/core/theme/colors.dart';
import 'package:aitek_task/core/theme/style.dart';
import 'package:aitek_task/core/utils/app_navigation.dart';
import 'package:aitek_task/core/widgets/custom_button.dart';
import 'package:aitek_task/core/widgets/responsive_content.dart';
import 'package:aitek_task/feature/authentication/partner_service/presentation/screens/partner_service_login_screen.dart';
import 'package:aitek_task/feature/authentication/peanut_service/presentation/screens/peanut_service_login_screen.dart';
import 'package:aitek_task/feature/search_placeholder/presentation/screens/search_place_holder_new_screen.dart';
import 'package:aitek_task/feature/promo_materials/presentation/screens/promo_materials_screen.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: ResponsiveContent(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 54,
                  height: 54,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.shield_outlined,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Text(
                'Choose your service',
                style: kBoldTextStyle.copyWith(fontSize: 28, height: 1.15),
              ),
              const SizedBox(height: 10),
              Text(
                'Select the cabinet service you want to authorize with.',
                style: kRegularTextStyle.copyWith(
                  color: Colors.black54,
                  fontSize: 15,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 34),
              _ServiceOption(
                icon: Icons.business_center_outlined,
                title: 'Partner Service',
                subtitle: 'Continue with Partner cabinet credentials',
                onTap: () {
                  AppNavigator.push(context, const PartnerServiceLoginScreen());
                },
              ),
              const SizedBox(height: 14),
              _ServiceOption(
                icon: Icons.account_balance_wallet_outlined,
                title: 'Peanut Service',
                subtitle: 'Continue with Peanut account credentials',
                onTap: () {
                  AppNavigator.push(context, const PeanutServiceLoginScreen());
                },
              ),
              const SizedBox(height: 14),
              _ServiceOption(
                icon: Icons.campaign_outlined,
                title: 'Promo Materials',
                subtitle: 'Browse company promo creatives and links',
                onTap: () {
                  AppNavigator.push(context, const PromoMaterialsScreen());
                },
              ),
              const SizedBox(height: 14),
              _ServiceOption(
                icon: Icons.search_rounded,
                title: 'Search UI Preview',
                subtitle: 'Open the refreshed SearchPlaceHolderNew page',
                onTap: () {
                  AppNavigator.push(
                    context,
                    const SearchPlaceHolderNewScreen(),
                  );
                },
              ),
              const SizedBox(height: 24),
              Text(
                'Authorization is handled securely through the selected backend service.',
                style: kRegularTextStyle.copyWith(
                  color: Colors.black45,
                  fontSize: 12,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ServiceOption extends StatelessWidget {
  const _ServiceOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F2F5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: AppColor.primary, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: kSemiBoldTextStyle.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: kRegularTextStyle.copyWith(
                        color: Colors.black54,
                        fontSize: 12,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          CustomButton(
            title: title,
            textColor: Colors.white,
            height: 46,
            borderRadius: 10,
            onPress: onTap,
          ),
        ],
      ),
    );
  }
}
