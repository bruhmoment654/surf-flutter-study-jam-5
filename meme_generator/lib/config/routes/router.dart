import 'package:go_router/go_router.dart';
import 'package:meme_generator/features/domain/entities/template.dart';
import 'package:meme_generator/features/presentation/pages/create_template/edit_template_page.dart';
import 'package:meme_generator/features/presentation/pages/templates/templates_page.dart';

final router = GoRouter(routes: [
  GoRoute(
      name: 'templates',
      path: '/',
      builder: (context, state) => const TemplatesPage()),
  GoRoute(
      name: 'create',
      path: '/create',
      builder: (context, state) => const EditTemplatePage()),
  GoRoute(
      name: 'edit',
      path: '/edit',
      builder: (context, state) => EditTemplatePage(
            initialTemplate: state.extra as Template,
          ))
]);
