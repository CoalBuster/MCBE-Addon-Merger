import 'package:file_picker/file_picker.dart';
import 'package:logger/logger.dart';

class AddonPickerResult {
  final List<int> data;

  /// Otherwise, this is a Pack
  final bool isAddon;

  AddonPickerResult(this.isAddon, this.data);
}

class AddonPicker {
  final Logger logger;

  AddonPicker({
    required this.logger,
  });

  Future<AddonPickerResult?> pickFileAsync() async {
    logger.i('Picking addon or pack..');
    final result = await FilePicker.platform.pickFiles(
      dialogTitle: 'Select Addon or Pack',
      allowMultiple: false,
      type: FileType.any,
      withData: true,
      withReadStream: false,
    );

    if (result == null || !result.isSinglePick) {
      logger.w('No Addon or Pack picked');
      return null;
    }

    final data = result.files.single.bytes!;
    return AddonPickerResult(result.files.single.extension == 'mcaddon', data);
  }

  Future<List<int>?> pickAddonFileAsync() async {
    logger.i('Picking addon..');
    final result = await FilePicker.platform.pickFiles(
      dialogTitle: 'Select Addon',
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['mcaddon'],
      withData: true,
      withReadStream: false,
    );

    if (result == null || !result.isSinglePick) {
      logger.w('No Addon picked');
      return null;
    }

    final data = result.files.single.bytes!;
    return data;
  }

  Future<List<int>?> pickPackFileAsync() async {
    logger.i('Picking pack..');
    final result = await FilePicker.platform.pickFiles(
      dialogTitle: 'Select Pack',
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['mcpack'],
      withData: true,
      withReadStream: false,
    );

    if (result == null || !result.isSinglePick) {
      logger.w('No Pack picked');
      return null;
    }

    final data = result.files.single.bytes!;
    return data;
  }
}
