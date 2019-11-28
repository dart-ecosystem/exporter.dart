import 'dart:async';
import 'dart:convert';

import 'package:build/build.dart';
import 'package:exporter/src/builder/object/exporter_cache_object.dart';
import 'package:exporter/src/builder/util/TemplateUtils.dart';
import 'package:glob/glob.dart';

class ExporterCombiner extends Builder {
  @override
  FutureOr<void> build(BuildStep buildStep) async {
    // prepare sources
    final List<AssetId> exporterAssetIds =
        await buildStep.findAssets(Glob("**/*.exporter.json")).toList();

    final List<ExporterCacheObject> exporterAssetCaches = [];

    // deserialize
    for (var assetId in exporterAssetIds) {
      var code = json.decode(await buildStep.readAsString(assetId));
      exporterAssetCaches.add(ExporterCacheObject.fromJson(code));
    }

    // write to file
    String content = TemplateUtils.generateString(exporterAssetCaches);
    String package = buildStep.inputId.package;
    AssetId outputId = AssetId(package, "lib/generated/exporter.dart");
    await buildStep.writeAsString(outputId, content);
  }

  @override
  Map<String, List<String>> get buildExtensions => {
        "main.dart": ["/generated/exporter.dart"],
      };
}
