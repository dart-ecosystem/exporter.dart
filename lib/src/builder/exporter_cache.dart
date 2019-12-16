import 'package:matchable_builder/matchable_builder.dart';

class ExporterCache extends Cache {
  final String path;
  final List<String> classNames;

  ExporterCache({
    this.path,
    this.classNames,
  });

  static ExporterCache fromJson(Map json) {
    return ExporterCache(
      path: json["path"],
      classNames: (json["classNames"] as List).cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "path": path,
      "classNames": classNames,
    };
  }
}
