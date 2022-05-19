import 'patch.dart';

class PackDifference {
  final String filename;
  final dynamic packElement;
  final List<Patch>? patches;

  PackDifference({
    required this.filename,
    this.packElement,
    this.patches,
  });
}
