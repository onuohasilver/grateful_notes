import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:grateful_notes/services/images/image_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class ImageServiceImpl extends ImageService {
  final ImagePicker _picker = ImagePicker();
  final CloudinaryPublic _cloudinary =
      CloudinaryPublic('afroify', 'grateful_notes', cache: true);

  @override
  Future<List<XFile>> getImagesFromDevice() {
    return _picker.pickMultiImage();
  }

  @override
  Future<List<String>> uploadToDB(images) async {
    List<String> imageUrls = [];
    for (var element in images) {
      Logger().i(element);
      await _cloudinary
          .uploadFile(CloudinaryFile.fromFile(element))
          .then((value) => imageUrls.add(value.secureUrl));
    }
    return imageUrls;
  }
}
