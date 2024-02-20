import 'package:meme_generator/features/data/data_sources/local/app_database.dart';
import 'package:meme_generator/features/data/models/template.dart';
import 'package:meme_generator/features/domain/entities/template.dart';
import 'package:meme_generator/features/domain/repositories/template_repository.dart';

class TemplateRepositoryImpl extends TemplateRepository {
  final AppDatabase _appDatabase;

  TemplateRepositoryImpl(this._appDatabase);

  @override
  Future<void> deleteTemplate(Template template) async {
    _appDatabase.templateDao.deleteTemplate(TemplateModel.fromEntity(template));
  }

  @override
  Future<List<Template>> getSavedTemplates() async{
    return await _appDatabase.templateDao.getTemplates();
  }

  @override
  Future<void> saveTemplate(Template template) {
return _appDatabase.templateDao.insertTemplate(TemplateModel.fromEntity(template));
  }
}
