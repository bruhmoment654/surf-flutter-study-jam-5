import 'package:meme_generator/core/usecase/usecase.dart';
import 'package:meme_generator/features/domain/entities/template.dart';
import 'package:meme_generator/features/domain/repositories/template_repository.dart';

class GetTemplatesUseCase extends UseCase<List<Template>,void> {

  final TemplateRepository _templateRepository;


  GetTemplatesUseCase(this._templateRepository);

  @override
  Future<List<Template>> call({void params}) {
   return _templateRepository.getSavedTemplates();
  }

}
