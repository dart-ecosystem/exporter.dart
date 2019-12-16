import 'dart:async';

import 'package:build/build.dart';
import 'package:exporter/src/builder/exporter_cache.dart';
import 'package:exporter/src/builder/util/TemplateUtils.dart';
import 'package:matchable_builder/matchable_builder.dart';

class ExporterCombiner extends MatchableCombiningBuilder {
  ExporterCombiner(BuilderOptions options) : super(options);

  @override
  Map<String, List<String>> get buildExtensions => {
        "exporter.locator": ["exporter.dart"],
      };

  @override
  Map<String, CacheResolver> get resolveCaches => {
        "**/*.exporter.json": ExporterCache.fromJson,
      };

  @override
  FutureOr<void> generate(Map<String, List<Object>> resolvedCaches, BuildStep buildStep) async {
    List<ExporterCache> exporterAssetCaches =
        List<ExporterCache>.from(resolvedCaches["**/*.exporter.json"]);
    // write to file
    String content = TemplateUtils.generateString(exporterAssetCaches);
    AssetId outputId = buildStep.inputId.changeExtension(".dart");
    await buildStep.writeAsString(outputId, content);
  }
}
