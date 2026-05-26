import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract final class ApiEndpoints {
  static final peanutBaseUrl = dotenv.env['PEANUT_BASE_URL'] ?? '';
  static final partnerBaseUrl = dotenv.env['PARTNER_BASE_URL'] ?? '';

  static const isAccountCredentialsCorrect = 'ClientCabinetBasic/IsAccountCredentialsCorrect';
  static const getLastFourPhoneNumber = 'ClientCabinetBasic/GetLastFourNumbersPhone';
  static const getAccountInformation = 'ClientCabinetBasic/GetAccountInformation';
  static const requestMobileCabinetApiToken = 'Authentication/RequestMoblieCabinetApiToken';
}
