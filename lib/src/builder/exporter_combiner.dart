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
    AssetId outputId = buildStep.inputId.changeExtension(".dart");
    await buildStep.writeAsString(outputId, content);
  }

  @override
  Map<String, List<String>> get buildExtensions => {
        "exporter.locator": ["exporter.dart"],
      };
}
