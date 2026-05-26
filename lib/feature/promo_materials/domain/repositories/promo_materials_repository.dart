import 'package:aitek_task/feature/promo_materials/data/models/promo_material_error_model.dart';
import 'package:aitek_task/feature/promo_materials/data/models/promo_material_model.dart';
import 'package:dartz/dartz.dart';

abstract class PromoMaterialsRepository {
  Future<Either<PromoMaterialErrorModel, List<PromoMaterialModel>>>
  getPromoMaterials();
}
