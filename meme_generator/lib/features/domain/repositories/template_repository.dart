import '../entities/template.dart';

abstract class TemplateRepository {
  Future<List<Template>> getSavedTemplates();

  Future<void> saveTemplate(Template template);

  Future<void> deleteTemplate(Template template);
}
