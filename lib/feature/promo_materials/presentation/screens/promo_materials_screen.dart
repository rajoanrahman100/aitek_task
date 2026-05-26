import 'package:aitek_task/core/theme/colors.dart';
import 'package:aitek_task/core/theme/style.dart';
import 'package:aitek_task/core/widgets/custom_button.dart';
import 'package:aitek_task/feature/promo_materials/data/models/promo_material_model.dart';
import 'package:aitek_task/feature/promo_materials/presentation/cubit/promo_materials_cubit.dart';
import 'package:aitek_task/feature/promo_materials/presentation/cubit/promo_materials_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class PromoMaterialsScreen extends StatefulWidget {
  const PromoMaterialsScreen({super.key});

  @override
  State<PromoMaterialsScreen> createState() => _PromoMaterialsScreenState();
}

class _PromoMaterialsScreenState extends State<PromoMaterialsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PromoMaterialsCubit>().getPromoMaterials();
  }

  Future<void> _openLink(String? url) async {
    if (url == null || url.trim().isEmpty) return;

    final uri = Uri.tryParse(url.trim());
    if (uri == null) return;

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text('Promo Materials'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: SafeArea(
        child: BlocBuilder<PromoMaterialsCubit, PromoMaterialsState>(
          builder: (context, state) {
            if (state is PromoMaterialsLoading ||
                state is PromoMaterialsInitial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is PromoMaterialsFailure) {
              return _FailureView(message: state.message);
            }

            if (state is PromoMaterialsSuccess) {
              if (state.materials.isEmpty) {
                return const _EmptyView();
              }

              return RefreshIndicator(
                onRefresh: () {
                  return context
                      .read<PromoMaterialsCubit>()
                      .getPromoMaterials();
                },
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
                  itemCount: state.materials.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final material = state.materials[index];
                    return _PromoCard(
                      material: material,
                      onOpen: () => _openLink(material.linkUrl),
                    );
                  },
                ),
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
          const Icon(Icons.error_outline, color: Colors.redAccent, size: 54),
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
              context.read<PromoMaterialsCubit>().getPromoMaterials();
            },
          ),
        ],
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No promo materials found.',
        style: kRegularTextStyle.copyWith(color: Colors.black54),
      ),
    );
  }
}

class _PromoCard extends StatelessWidget {
  const _PromoCard({required this.material, required this.onOpen});

  final PromoMaterialModel material;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (material.imageUrl?.trim().isNotEmpty == true)
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                material.imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) {
                  return const _ImageFallback();
                },
              ),
            )
          else
            const _ImageFallback(),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (material.type?.trim().isNotEmpty == true) ...[
                  Text(
                    material.type!,
                    style: kMediumTextStyle.copyWith(
                      color: AppColor.primary,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 6),
                ],
                Text(
                  material.title?.trim().isNotEmpty == true
                      ? material.title!
                      : 'Promo Material',
                  style: kSemiBoldTextStyle.copyWith(fontSize: 16),
                ),
                if (material.description?.trim().isNotEmpty == true) ...[
                  const SizedBox(height: 8),
                  Text(
                    material.description!,
                    style: kRegularTextStyle.copyWith(
                      color: Colors.black54,
                      height: 1.35,
                    ),
                  ),
                ],
                const SizedBox(height: 14),
                CustomButton(
                  title: 'Open Link',
                  textColor: Colors.white,
                  height: 44,
                  borderRadius: 10,
                  onPress: material.linkUrl?.trim().isNotEmpty == true
                      ? onOpen
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageFallback extends StatelessWidget {
  const _ImageFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      color: const Color(0xFFEDEFF3),
      child: const Icon(Icons.campaign_outlined, size: 40),
    );
  }
}
