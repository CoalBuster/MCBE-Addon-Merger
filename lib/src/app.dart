import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logger/logger.dart';

import 'controller/addon_controller.dart';
import 'controller/pack_controller.dart';
import 'layout/merger_layout.dart';
import 'layout/pack_detail_layout.dart';
import 'layout/pack_element_layout.dart';
import 'layout/pack_explorer_layout.dart';
import 'settings/settings_controller.dart';

class AddonMergerApp extends StatelessWidget {
  final AddonController addonController;
  final Logger logger;
  final PackController packController;
  final SettingsController settingsController;

  const AddonMergerApp({
    required this.addonController,
    required this.logger,
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
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case PackDetailLayout.routeName:
                    return PackDetailLayout(
                      logger: logger,
                      packController: packController,
                    );
                  case PackExplorerLayout.routeName:
                    return PackExplorerLayout(
                      addonController: addonController,
                      packController: packController,
                    );
                  case PackElementLayout.routeName:
                    final args = routeSettings.arguments as List<String?>;
                    return PackElementLayout(
                      element: packController.packContent!.element(args[0]!),
                      path: args[0],
                      name: args[1],
                    );
                  case MergerLayout.routeName:
                  default:
                    return MergerLayout(
                      addonController: addonController,
                      logger: logger,
                    );
                }
              },
            );
          },
        );
      },
    );
  }
}
