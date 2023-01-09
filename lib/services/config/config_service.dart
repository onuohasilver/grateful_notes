import 'package:grateful_notes/core/network/response_model.dart';

abstract class ConfigService {
  Future<ResponseModel> getConfigData();
}
