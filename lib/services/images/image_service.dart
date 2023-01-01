import 'package:grateful_notes/core/network/response_model.dart';
import 'package:image_picker/image_picker.dart';

abstract class ImageService {
  Future<List<XFile>> getImagesFromDevice();

  Future<ResponseModel> uploadToDB(List<String> images);
}
