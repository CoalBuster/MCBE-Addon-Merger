import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logger/logger.dart';

import 'controller/merge_controller.dart';
import 'controller/pack_controller.dart';
import 'controller/addon_controller.dart';
import 'layout/compare_selection_layout.dart';
import 'layout/comparer_layout.dart';
import 'layout/main_layout.dart';
import 'layout/pack_detail_layout.dart';
import 'layout/pack_element_layout.dart';
import 'repository/addon_picker.dart';
import 'settings/settings_controller.dart';

class AddonMergerApp extends StatelessWidget {
  final AddonController addonController;
  final AddonPicker addonPicker;
  final Logger logger;
  final MergeController mergeController;
  final PackController packController;
  final SettingsController settingsController;

  const AddonMergerApp({
    required this.addonController,
    required this.addonPicker,
    required this.logger,
    required this.mergeController,
    required this.packController,
    required this.settingsController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          restorationScopeId: 'app',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
          ],
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,
          routes: {
            ComparerLayout.routeName: (context) => ComparerLayout(
                  mergeController: mergeController,
                  packController: packController,
                ),
            CompareSelectionLayout.routeName: (context) =>
                CompareSelectionLayout(
                  addonPicker: addonPicker,
                  mergeController: mergeController,
                ),
            MainLayout.routeName: (context) => MainLayout(
                  addonController: addonController,
                  addonPicker: addonPicker,
                  logger: logger,
                  mergeController: mergeController,
                  packController: packController,
                ),
            PackDetailLayout.routeName: (context) => PackDetailLayout(
                  logger: logger,
                  packController: packController,
                ),
            PackElementLayout.routeName: (context) => PackElementLayout(
                  packController: packController,
                ),
          },
          // onGenerateRoute: (RouteSettings routeSettings) {
          //   switch (routeSettings.name) {
          //     case AddonLayout.routeName:
          //       addonController.loadAsync();
          //       return MaterialPageRoute<Pack>(
          //         settings: routeSettings,
          //         builder: (BuildContext context) => AddonLayout(
          //           addonController: addonController,
          //         ),
          //       );
          //     default:
          //       return null;
          //   }
          // },
        );
      },
    );
  }
}
