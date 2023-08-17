import 'package:asyncstate/observers/async_navigator_observer.dart';
import 'package:asyncstate/widget/async_state_builder.dart';
import 'package:dw_barbershop/src/features/auth/login/login_page.dart';
import 'package:dw_barbershop/src/features/core/ui/barbershop_theme.dart';
import 'package:dw_barbershop/src/features/core/ui/widgets/barbershop_loader.dart';
import 'package:dw_barbershop/src/features/splash/splash_page.dart';
import 'package:flutter/material.dart';

class BarbershopApp extends StatelessWidget {
  const BarbershopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      customLoader: const BarbershopLoader(),
      builder: (asyncNavigatorObserver) {
        return MaterialApp(
          title: 'DW Barberhop',
          navigatorObservers: [asyncNavigatorObserver],
          theme: BarbershopTheme.themeData,
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (_) => const SplashPage(),
            '/auth/login': (_) => const LoginPage(),
          },
        );
      },
    );
  }
}
