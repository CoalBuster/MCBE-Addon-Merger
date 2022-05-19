import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logger/logger.dart';
import 'package:mcbe_addon_merger/src/controller/merge_controller.dart';
import 'package:mcbe_addon_merger/src/layout/comparer_layout.dart';
import 'package:mcbe_addon_merger/src/layout/pack_picker_layout.dart';

import 'controller/addon_controller.dart';
import 'controller/pack_controller.dart';
import 'layout/merger_layout.dart';
import 'layout/pack_detail_layout.dart';
import 'layout/pack_element_layout.dart';
import 'layout/pack_explorer_layout.dart';
import 'model/pack.dart';
import 'settings/settings_controller.dart';

class AddonMergerApp extends StatelessWidget {
  final AddonController addonController;
  final Logger logger;
  final MergeController mergeController;
  final PackController packController;
  final SettingsController settingsController;

  const AddonMergerApp({
    required this.addonController,
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
          onGenerateRoute: (RouteSettings routeSettings) {
            switch (routeSettings.name) {
              case ComparerLayout.routeName:
                final args = routeSettings.arguments as List<String>;
                mergeController.loadBasePackByPathAsync(args[0]);
                mergeController.loadComparePackByPathAsync(args[1]);
                return MaterialPageRoute<void>(
                  settings: routeSettings,
                  builder: (BuildContext context) => ComparerLayout(
                    logger: logger,
                    mergeController: mergeController,
                  ),
                );
              case PackDetailLayout.routeName:
                return MaterialPageRoute<void>(
                  settings: routeSettings,
                  builder: (BuildContext context) => PackDetailLayout(
                    logger: logger,
                    packController: packController,
                  ),
                );
              case PackExplorerLayout.routeName:
                return MaterialPageRoute<void>(
                  settings: routeSettings,
                  builder: (BuildContext context) => PackExplorerLayout(
                    addonController: addonController,
                    packController: packController,
                  ),
                );
              case PackElementLayout.routeName:
                final args = routeSettings.arguments as List<String?>;
                return MaterialPageRoute<void>(
                  settings: routeSettings,
                  builder: (BuildContext context) => PackElementLayout(
                    element: packController.packContent!.element(args[0]!),
                    path: args[0],
                    name: args[1],
                  ),
                );
              case PackPickerLayout.routeName:
                return MaterialPageRoute<List<Pack>>(
                  settings: routeSettings,
                  builder: (BuildContext context) => PackPickerLayout(
                    addonController: addonController,
                    packCount: routeSettings.arguments as int? ?? 1,
                  ),
                );
              case MergerLayout.routeName:
              default:
                return MaterialPageRoute<void>(
                  settings: routeSettings,
                  builder: (BuildContext context) => MergerLayout(
                    addonController: addonController,
                    logger: logger,
                  ),
                );
            }
          },
        );
      },
    );
  }
}
