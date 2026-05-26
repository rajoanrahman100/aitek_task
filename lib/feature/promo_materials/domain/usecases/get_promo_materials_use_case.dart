import 'package:aitek_task/core/di/service_locator.dart';
import 'package:aitek_task/core/di/use_case.dart';
import 'package:aitek_task/feature/promo_materials/data/models/promo_material_error_model.dart';
import 'package:aitek_task/feature/promo_materials/data/models/promo_material_model.dart';
import 'package:aitek_task/feature/promo_materials/domain/repositories/promo_materials_repository.dart';
import 'package:dartz/dartz.dart';

class GetPromoMaterialsUseCase
    extends
        UseCase<
          Either<PromoMaterialErrorModel, List<PromoMaterialModel>>,
          void
        > {
  @override
  Future<Either<PromoMaterialErrorModel, List<PromoMaterialModel>>> call({
    void params,
  }) async {
    return await sl<PromoMaterialsRepository>().getPromoMaterials();
  }
}
