import 'package:grateful_notes/core/network/api.dart';
import 'package:grateful_notes/core/network/network_core.dart';
import 'package:grateful_notes/core/network/response_model.dart';
import 'package:grateful_notes/services/config/config_service.dart';

class ConfigServiceImpl extends ConfigService {
  final NetworkImpl network = NetworkImpl();
  @override
  Future<ResponseModel> getConfigData() async {
    return await network.get(path: UrlPath(Api().config, "imagedata"));
  }
}
