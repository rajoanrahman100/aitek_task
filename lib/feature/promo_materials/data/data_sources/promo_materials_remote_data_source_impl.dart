import 'package:aitek_task/core/di/service_locator.dart';
import 'package:aitek_task/core/network/api_endpoints.dart';
import 'package:aitek_task/core/network/dio_client.dart';
import 'package:aitek_task/core/utils/logger.dart';
import 'package:aitek_task/feature/promo_materials/data/data_sources/promo_materials_remote_data_source.dart';
import 'package:aitek_task/feature/promo_materials/data/models/promo_material_error_model.dart';
import 'package:aitek_task/feature/promo_materials/data/models/promo_material_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class PromoMaterialsRemoteDataSourceImpl extends PromoMaterialsRemoteDataSource {
  @override
  Future<Either<PromoMaterialErrorModel, List<PromoMaterialModel>>> getPromoMaterials() async {
    try {
      final response = await sl<DioClient>().post(
        ApiEndpoints.promoSoapUrl,
        data: _soapEnvelope,
        options: Options(
          responseType: ResponseType.plain,
          headers: const {'Content-Type': 'text/xml; charset=utf-8', 'SOAPAction': '"http://tempuri.org/ICabinetMicroService/GetCCPromo"'},
        ),
      );

      final materials = PromoMaterialsParser.parse(response.data.toString());
      return Right(materials);
    } on NetworkException catch (e) {
      logger.w('Network error in GetCCPromo: ${e.message}\nResponse Data: ${e.responseData}');
      return Left(PromoMaterialErrorModel(message: e.message));
    } catch (e, stackTrace) {
      logger.e('Unexpected exception in GetCCPromo', error: e, stackTrace: stackTrace);
      return Left(PromoMaterialErrorModel(message: e.toString()));
    }
  }

  static const _soapEnvelope = '''
<?xml version="1.0" encoding="utf-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
  <soapenv:Header/>
  <soapenv:Body>
    <tem:GetCCPromo>
      <tem:lang>en</tem:lang>
    </tem:GetCCPromo>
  </soapenv:Body>
</soapenv:Envelope>
''';
}
