import 'package:exporter/src/builder/exporter_cache.dart';

class TemplateUtils {
  static String generateString(List<ExporterCache> cacheList) {
    return cacheList
        .where((e) => e.classNames.isNotEmpty)
        .map((e) => "export \"${e.path}\" show ${e.classNames.join(", ")};")
        .join("\n");
  }
}
