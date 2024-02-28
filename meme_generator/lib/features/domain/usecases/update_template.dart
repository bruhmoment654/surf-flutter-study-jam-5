import 'package:meme_generator/core/usecase/usecase.dart';
import 'package:meme_generator/features/domain/entities/template.dart';
import 'package:meme_generator/features/domain/repositories/template_repository.dart';

class UpdateTemplateUseCase extends UseCase<void, Template> {
  final TemplateRepository _templateRepository;

  UpdateTemplateUseCase(this._templateRepository);

  @override
  Future<void> call({Template? params}) {
    return _templateRepository.updateTemplate(params!);
  }
}
