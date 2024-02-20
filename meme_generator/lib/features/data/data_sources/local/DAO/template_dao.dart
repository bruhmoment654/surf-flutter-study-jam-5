import 'package:floor/floor.dart';
import 'package:meme_generator/features/data/models/template.dart';

@dao
abstract class TemplateDao {
  @Insert()
  Future<void> insertTemplate(TemplateModel template);

  @delete
  Future<void> deleteTemplate(TemplateModel template);

  @Query('select * from template')
  Future<List<TemplateModel>> getTemplates();
}
