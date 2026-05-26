import 'package:aitek_task/core/di/service_locator.dart';
import 'package:aitek_task/feature/promo_materials/data/data_sources/promo_materials_remote_data_source.dart';
import 'package:aitek_task/feature/promo_materials/data/models/promo_material_error_model.dart';
import 'package:aitek_task/feature/promo_materials/data/models/promo_material_model.dart';
import 'package:aitek_task/feature/promo_materials/domain/repositories/promo_materials_repository.dart';
import 'package:dartz/dartz.dart';

class PromoMaterialsRepositoryImpl extends PromoMaterialsRepository {
  @override
  Future<Either<PromoMaterialErrorModel, List<PromoMaterialModel>>>
  getPromoMaterials() async {
    return await sl<PromoMaterialsRemoteDataSource>().getPromoMaterials();
  }
}
