import 'package:path_provider/path_provider.dart';

class PathProviderUtil {
  PathProviderUtil._();

  static Future<String?> getDownloadDirectoryPath() async {
    try {
      final directory = await getDownloadsDirectory();
      return directory?.path;
    } catch (e) {
      return null;
    }
  }
}
