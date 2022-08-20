import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'src/app.dart';
import 'src/controller/addon_controller.dart';
import 'src/controller/element_controller.dart';
import 'src/controller/merge_controller.dart';
import 'src/controller/pack_controller.dart';
import 'src/repository/addon_picker.dart';
import 'src/repository/addon_repository.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  final logger = Logger(
    filter: ProductionFilter(),
    printer: SimplePrinter(printTime: true),
    level: Level.verbose,
  );

  final addonPicker = AddonPicker(
    logger: logger,
  );

  final addonRepository = AddonRepository(
    logger: logger,
  );

  final mergeController = MergeController(
    addonRepository: addonRepository,
    logger: logger,
  );

  final packController = PackController(
    addonRepository: addonRepository,
  );

  final elementController = PackElementController(
    addonRepository: addonRepository,
  );

  final packPickerController = AddonController(
    addonPicker: addonPicker,
    addonRepository: addonRepository,
    logger: logger,
  );

  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();

  runApp(AddonMergerApp(
    addonController: packPickerController,
    addonPicker: addonPicker,
    elementController: elementController,
    logger: logger,
    mergeController: mergeController,
    packController: packController,
    settingsController: settingsController,
  ));
}
