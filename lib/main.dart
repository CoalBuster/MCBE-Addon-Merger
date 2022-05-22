import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'src/app.dart';
import 'src/controller/pack_picker_controller.dart';
import 'src/controller/merge_controller.dart';
import 'src/controller/pack_controller.dart';
import 'src/repository/addon_repository.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  final logger = Logger(
    filter: ProductionFilter(),
    printer: SimplePrinter(printTime: true),
    level: Level.verbose,
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

  final packPickerController = PackPickerController(
    addonRepository: addonRepository,
    logger: logger,
  );

  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();

  runApp(AddonMergerApp(
    logger: logger,
    mergeController: mergeController,
    packController: packController,
    packPickerController: packPickerController,
    settingsController: settingsController,
  ));
}
