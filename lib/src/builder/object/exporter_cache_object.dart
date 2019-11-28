import 'dart:convert';

class ExporterCacheObject {
  String path;
  List<String> classNames;

  ExporterCacheObject({
    this.path,
    this.classNames,
  });

  ExporterCacheObject.fromJson(Map json) {
    this.path = json["path"];
    this.classNames = (json["classNames"] as List).cast<String>();
  }

  Map toJson() {
    return {
      "path": path,
      "classNames": classNames,
    };
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}
