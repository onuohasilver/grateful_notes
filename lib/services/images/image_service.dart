import 'package:image_picker/image_picker.dart';

abstract class ImageService {
  Future<List<XFile>> getImagesFromDevice();

  Future<List<String>> uploadToDB(List<String> images);
}
