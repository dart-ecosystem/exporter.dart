import 'package:build/build.dart';
import 'package:exporter/exporter.dart';
import 'package:exporter/src/builder/exporter_collector.dart';
import 'package:exporter/src/builder/exporter_combiner.dart';

Builder exporterCollector(BuilderOptions options) => ExporterCollector(options);
Builder exporterCombiner(BuilderOptions options) => ExporterCombiner();
