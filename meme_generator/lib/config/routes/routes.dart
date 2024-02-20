import 'package:flutter/material.dart';
import 'package:meme_generator/features/domain/entities/template.dart';
import 'package:meme_generator/features/presentation/pages/create_template/create_template_page.dart';
import 'package:meme_generator/features/presentation/pages/home/demotivator_page.dart';
import 'package:meme_generator/features/presentation/pages/templates/templates_page.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/demotivator':
        return _materialRoute(
            DemotivatorPage(template: settings.arguments as Template));
      case '/templates':
        return _materialRoute(const TemplatesPage());
      case '/create':
        return _materialRoute(const CreateTemplatePage());
      default:
        return _materialRoute(const TemplatesPage());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
