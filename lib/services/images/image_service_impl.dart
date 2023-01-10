import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:grateful_notes/core/network/response_model.dart';
import 'package:grateful_notes/services/images/image_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class ImageServiceImpl extends ImageService {
  final ImagePicker _picker = ImagePicker();
  final CloudinaryPublic _cloudinary =
      CloudinaryPublic('afroify', 'grateful_notes', cache: true);

  @override
  Future<List<XFile>> getImagesFromDevice() {
    return _picker.pickMultiImage();
  }

  @override
  Future<ResponseModel> uploadToDB(images) async {
    List<String> imageUrls = [];
    Logger().i("message");

    await _cloudinary
        .uploadFiles(images.map((e) => CloudinaryFile.fromFile(e)).toList())
        .then((value) =>
            imageUrls.addAll(value.map((e) => e.secureUrl).toList()));

    return ResponseModel(data: {'images': imageUrls}, success: true, code: 200);
  }

  @override
  Future<void> shareScreenshot(ScreenshotController ssc) async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    String fileName =
        "Happy Notes ${DateTime.now().microsecondsSinceEpoch}.png";
    String path = directory;
    await ssc
        .captureAndSave(path, pixelRatio: 6.4, fileName: fileName)
        .then((value) => Share.shareXFiles([XFile(value!)]));
  }
}
