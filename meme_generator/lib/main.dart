import 'package:flutter/material.dart';
import 'package:meme_generator/config/routes/router.dart';
import 'package:meme_generator/config/themes/app_theme.dart';
import 'package:meme_generator/features/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

/// App,s main widget.
class MyApp extends StatelessWidget {
  /// Constructor for [MyApp].
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: appTheme(),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
