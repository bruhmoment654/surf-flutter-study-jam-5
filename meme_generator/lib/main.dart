import 'package:flutter/material.dart';
import 'package:meme_generator/config/themes/app_theme.dart';
import 'package:meme_generator/features/injection_container.dart';
import 'package:meme_generator/features/presentation/pages/create_template/create_template_page.dart';
import 'package:meme_generator/features/presentation/pages/templates/templates_page.dart';

import 'config/routes/routes.dart';

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
    return MaterialApp(
      theme: appTheme(),
      home: const TemplatesPage(),
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      debugShowCheckedModeBanner: false,
    );
  }
}
