import 'package:file_share_application_frontend/global/Providers/AppSettingsNotifier.dart';
import 'package:file_share_application_frontend/global/models/app_settings.dart';
import 'package:file_share_application_frontend/ui/appbar/appBar.dart';
import 'package:file_share_application_frontend/ui/appbar/app_bar_drawer.dart';
import 'package:file_share_application_frontend/ui/home/home_view.dart';
import 'package:file_share_application_frontend/ui/onboarding/profile_setup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'core/Language/generated/app_localizations.dart';
import 'core/notifications/notification_service.dart';
import 'global/Providers/app_providers.dart';
import 'global/models/app_colors.dart';
import 'global/models/app_dependencies.dart';
import 'global/models/app_theme.dart';
import 'package:flutter/rendering.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // debugPaintSizeEnabled = true;

  // 1. Initialize all dependencies
  final dependencies = await AppDependencies.initialize();

  // 2. Handle failure gracefully
  if (dependencies == null) {
    runApp(const InitializationErrorApp());
    return;
  }

  // 3. Run the app with the clean provider list
  runApp(
    MultiProvider(
      providers: AppProviders.getProviders(dependencies),
      child: const MyApp(),
    ),
  );
}

// ----------------------------------------------------
// A simple fallback app to show if the database fails
// ----------------------------------------------------
class InitializationErrorApp extends StatelessWidget {
  const InitializationErrorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.error_outline, color: Colors.red, size: 60),
              SizedBox(height: 16),
              Text(
                "Failed to initialize app data.\nPlease restart the app.",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appSettingsNotifier = context.watch<AppSettingsNotifier>();
    final appSettings = appSettingsNotifier.appSettings;

    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: appSettings.currentTheme,
      themeAnimationDuration: const Duration(milliseconds: 400),
      themeAnimationCurve: Curves.fastOutSlowIn,
      scaffoldMessengerKey: NotificationService.scaffoldMessengerKey,
      navigatorKey: NotificationService.navigatorKey,
      // themeMode: ThemeMode.light,
      localizationsDelegates: [
        AppLocalizations.delegate, // Add this line
        ...GlobalMaterialLocalizations.delegates,
      ],
      locale: Locale(appSettings.currentLanguage),
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        // 1. 🟢 Allows the body gradient to bleed all the way to the top of the screen
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,

        appBar: !appSettings.isFirstTime ? Appbar() : null,
        drawer: AppBarDrawer(),
        // appBar: Appbar(),

        // 3. 🟢 Use a full-screen Container as the body to house the decoration
        // body: Builder(
        //   builder: (innerContext) {
        //     return Container(
        //       width: double.infinity,
        //       height: double.infinity,
        //       decoration: BoxDecoration(
        //         // 4. 🟢 Pass your custom theme gradient safely here
        //         gradient: innerContext.colors.bgPage,
        //       ),
        //       child: const SafeArea(
        //         // SafeArea pushes content down so it doesn't clip under the transparent AppBar
        //         child: ProfileSetupView(),
        //       ),
        //     );
        //   },
        // ),
        // body: Builder(
        //   builder: (innerContext) {
        //     return Container(
        //       // width: double.infinity,
        //       // height: double.infinity,
        //       decoration: BoxDecoration(
        //         // 4. 🟢 Pass your custom theme gradient safely here
        //         gradient: innerContext.colors.bgPage,
        //       ),
        //       child: SingleChildScrollView(
        //         padding: const EdgeInsets.all(
        //           16.0,
        //         ), // Adds padding around the child
        //         child: ProfileSetupView(),
        //       ),
        //     );
        //   },
        // ),
        body: Builder(
          builder: (innerContext) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  // 🟢 Forces the container background to match the exact full height of the viewport
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  decoration: BoxDecoration(
                    // 🟢 Changed from gradient to color to match the 'Color' property type
                    gradient: innerContext.colors.bgPage,
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: SafeArea(
                    child: appSettings.isFirstTime
                        ? ProfileSetupView()
                        : HomeView(),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
