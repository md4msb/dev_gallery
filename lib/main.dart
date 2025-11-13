import 'package:dev_gallery/features/developers/data/models/developer_model.dart';
import 'package:dev_gallery/injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/configs/router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DeveloperModelAdapter());
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Dev Gallery',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
