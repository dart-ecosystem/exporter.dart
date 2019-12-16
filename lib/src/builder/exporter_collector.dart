import 'dart:async';

import 'package:build/build.dart';
import 'package:exporter/src/annotation/export.dart';
import 'package:exporter/src/builder/exporter_cache.dart';
import 'package:matchable_builder/matchable_builder.dart';

class ExporterCollector extends MatchableBuilder {
  @override
  Matcher get matcher => Matcher.and([
        ElementAnnotationMatcher<Export>(),
        FileSchemaMatcher("package"),
      ]);

  @override
  Map<String, List<String>> get buildExtensions => {
        ".dart": [".exporter.json"],
      };

  ExporterCollector(BuilderOptions options) : super(options);

  @override
  FutureOr<void> generate(List<Element> elements, BuildStep buildStep) async {
    if (elements.isEmpty) {
      return;
    }
    String path = buildStep.inputId.uri.toString();
    final List<String> classNames = elements.map((e) => e.name).toList();
    var obj = ExporterCache(path: path, classNames: classNames);
    AssetId outputId = buildStep.inputId.changeExtension(".exporter.json");
    await buildStep.writeAsString(outputId, obj.toString());
  }
}
