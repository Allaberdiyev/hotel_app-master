import 'package:flutter/material.dart';
import 'package:hotel_app/core/providers/providers.dart';
import 'package:hotel_app/core/router/router.dart';
import 'package:hotel_app/core/router/routes.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    MultiProvider(
      providers: Providers.providers,
      child: EasyLocalization(
        supportedLocales: [Locale("en"), Locale("ru"), Locale("uz")],
        path: "translations",
        fallbackLocale: Locale("uz"),
        startLocale: Locale('uz'),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(
          builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
            TargetPlatform.values,
            value: (_) => FadeForwardsPageTransitionsBuilder(),
          ),
        ),
      ),
      initialRoute: AppRoutes.login,
      routes: AppRouter.appRoutes,
    );
  }
}
