import 'package:dev_gallery/core/configs/router/router_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      Future.delayed(const Duration(seconds: 2)).then((_) {
        if (!context.mounted) return;
        context.goNamed(RouteNames.home);
      });
      return null;
    }, []);

    return Scaffold(body: Center(child: Text("Splash screen")));
  }
}
