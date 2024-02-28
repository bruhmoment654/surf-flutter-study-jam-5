import 'package:floor/floor.dart';
import 'package:meme_generator/features/data/models/template.dart';

@dao
abstract class TemplateDao {
  @insert
  Future<void> insertTemplate(TemplateModel template);

  @delete
  Future<void> deleteTemplate(TemplateModel template);

  @update
  Future<void> updateTemplate(TemplateModel template);

  @Query('select * from template')
  Future<List<TemplateModel>> getTemplates();
}
