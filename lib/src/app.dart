import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logger/logger.dart';

import 'controller/pack_picker_controller.dart';
import 'controller/merge_controller.dart';
import 'controller/pack_controller.dart';
import 'layout/compare_selection_layout.dart';
import 'layout/comparer_layout.dart';
import 'layout/merger_layout.dart';
import 'layout/pack_detail_layout.dart';
import 'layout/pack_element_layout.dart';
import 'layout/pack_picker_layout.dart';
import 'model/pack.dart';
import 'settings/settings_controller.dart';

class AddonMergerApp extends StatelessWidget {
  final Logger logger;
  final MergeController mergeController;
  final PackController packController;
  final PackPickerController packPickerController;
  final SettingsController settingsController;

  const AddonMergerApp({
    required this.logger,
    required this.mergeController,
    required this.packController,
    required this.packPickerController,
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
                  mergeController: mergeController,
                ),
            MergerLayout.routeName: (context) => MergerLayout(
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
          onGenerateRoute: (RouteSettings routeSettings) {
            switch (routeSettings.name) {
              // case PackElementLayout.routeName:
              //   final args = routeSettings.arguments as List<String?>;
              //   return MaterialPageRoute<void>(
              //     settings: routeSettings,
              //     builder: (BuildContext context) => PackElementLayout(
              //       element: packController.packContent!.element(args[0]!),
              //       path: args[0],
              //       name: args[1],
              //     ),
              //   );
              case PackPickerLayout.routeName:
                packPickerController.loadAsync();
                return MaterialPageRoute<Pack>(
                  settings: routeSettings,
                  builder: (BuildContext context) => PackPickerLayout(
                    packPickerController: packPickerController,
                  ),
                );
              default:
                return null;
            }
          },
        );
      },
    );
  }
}
