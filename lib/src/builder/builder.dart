import 'package:build/build.dart';
import 'package:exporter/src/builder/exporter_collector.dart';
import 'package:exporter/src/builder/exporter_combiner.dart';

Builder exporterCollector(BuilderOptions options) => ExporterCollector();
Builder exporterCombiner(BuilderOptions options) => ExporterCombiner();
