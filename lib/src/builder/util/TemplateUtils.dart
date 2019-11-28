import 'package:exporter/src/builder/object/exporter_cache_object.dart';

class TemplateUtils {
  static String generateString(List<ExporterCacheObject> cacheList) {
    return cacheList.map((e) => "export \"${e.path}\" show ${e.classNames.join(", ")};").join("\n");
  }
}
