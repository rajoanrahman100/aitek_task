import 'package:aitek_task/core/di/service_locator.dart';
import 'package:aitek_task/feature/promo_materials/domain/usecases/get_promo_materials_use_case.dart';
import 'package:aitek_task/feature/promo_materials/presentation/cubit/promo_materials_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PromoMaterialsCubit extends Cubit<PromoMaterialsState> {
  PromoMaterialsCubit() : super(PromoMaterialsInitial());

  Future<void> getPromoMaterials() async {
    emit(PromoMaterialsLoading());

    final result = await sl<GetPromoMaterialsUseCase>().call();

    result.fold(
      (failure) {
        emit(PromoMaterialsFailure(failure.message ?? 'Unable to load promos'));
      },
      (materials) {
        emit(PromoMaterialsSuccess(materials));
      },
    );
  }
}
