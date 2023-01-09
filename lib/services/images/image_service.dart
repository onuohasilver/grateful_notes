import 'package:grateful_notes/core/network/response_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';

abstract class ImageService {
  Future<List<XFile>> getImagesFromDevice();

  Future<ResponseModel> uploadToDB(List<String> images);

  Future<void> shareScreenshot(ScreenshotController ssc);
}
