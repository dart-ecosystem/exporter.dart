import 'dart:async';

import 'package:build/build.dart';
import 'package:exporter/src/annotation/export.dart';
import 'package:exporter/src/builder/object/exporter_cache_object.dart';
import 'package:source_gen/source_gen.dart';
import 'package:path/path.dart' as p;

class ExporterCollector extends Builder {
  static TypeChecker exporterTypeChecker = TypeChecker.fromRuntime(Export);

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    String path;
    final List<String> classNames = [];

    final String uri = buildStep.inputId.uri.toString();
    final String schema = buildStep.inputId.uri.scheme;
    if (schema == "asset") {
      path = uri.replaceFirst(RegExp(r"asset:\w+/"), "");
      path = p.relative(path, from: "lib/generated/exporter/");
    } else if (schema == "package") {
      path = uri;
    }

    if (!path.startsWith("lib")) {
      return;
    }

    LibraryReader libraryReader = LibraryReader(await buildStep.inputLibrary);
    for (var annotatedElement in libraryReader.annotatedWith(exporterTypeChecker)) {
      classNames.add(annotatedElement.element.name);
    }

    if (classNames.isEmpty) {
      return;
    }

    var obj = ExporterCacheObject(path: path, classNames: classNames);
    AssetId outputId = buildStep.inputId.changeExtension(".exporter.json");
    await buildStep.writeAsString(outputId, obj.toString());
  }

  @override
  Map<String, List<String>> get buildExtensions => {
        ".dart": [".exporter.json"],
      };
}
