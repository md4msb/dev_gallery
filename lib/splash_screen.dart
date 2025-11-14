import 'package:dev_gallery/core/configs/router/router_names.dart';
import 'package:dev_gallery/core/configs/theme/app_typography.dart';
import 'package:dev_gallery/core/extentions/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fadeCtrl = useAnimationController(
      duration: const Duration(milliseconds: 900),
    );

    final slideCtrl = useAnimationController(
      duration: const Duration(milliseconds: 900),
    );

    final fadeAnim = CurvedAnimation(parent: fadeCtrl, curve: Curves.easeOut);

    final slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: slideCtrl, curve: Curves.easeOut));

    useEffect(() {
      fadeCtrl.forward();
      slideCtrl.forward();
      Future.delayed(const Duration(seconds: 3)).then((_) {
        if (!context.mounted) return;
        context.goNamed(RouteNames.home);
      });
      return null;
    }, []);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF5A4FF3), Color(0xFFB05CBD), Color(0xFFEE5D92)],
          ),
        ),
        child: Center(
          child: SlideTransition(
            position: slideAnim,
            child: FadeTransition(
              opacity: fadeAnim,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.faded(0.12),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: const Icon(
                      Icons.code,
                      color: Colors.white,
                      size: 64,
                    ),
                  ),

                  const Gap(24),

                  // Title
                  Text(
                    "DevGallery",
                    style: AppTypography.heading.copyWith(
                      color: Colors.white,
                      fontSize: 26,
                    ),
                  ),

                  const Gap(4),

                  // Subtitle
                  Text(
                    "Discover GitHub Talent",
                    style: AppTypography.body.copyWith(color: Colors.white70),
                  ),

                  const Gap(32),

                  // Loader animation
                  SpinKitThreeBounce(color: Colors.white, size: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
