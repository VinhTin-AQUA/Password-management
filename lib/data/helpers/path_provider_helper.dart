import 'package:path_provider/path_provider.dart';

class PathProviderHelper {
  PathProviderHelper._();

  static Future<String?> getDownloadDirectoryPath() async {
    final directory = await getDownloadsDirectory();
    return directory?.path;
  }
}
