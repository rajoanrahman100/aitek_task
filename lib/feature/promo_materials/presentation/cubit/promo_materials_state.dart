import 'package:aitek_task/feature/promo_materials/data/models/promo_material_model.dart';
import 'package:equatable/equatable.dart';

abstract class PromoMaterialsState extends Equatable {
  const PromoMaterialsState();

  @override
  List<Object?> get props => [];
}

class PromoMaterialsInitial extends PromoMaterialsState {}

class PromoMaterialsLoading extends PromoMaterialsState {}

class PromoMaterialsSuccess extends PromoMaterialsState {
  const PromoMaterialsSuccess(this.materials);

  final List<PromoMaterialModel> materials;

  @override
  List<Object?> get props => [materials];
}

class PromoMaterialsFailure extends PromoMaterialsState {
  const PromoMaterialsFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
