import '../constants/api_constants.dart';

class ImageHelper {
  static String getFullImageUrl(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      return '';
    }
    if (imagePath.startsWith('http')) {
      return imagePath;
    }
    return ApiConstants.imageBaseUrl + imagePath;
  }
}