import 'package:meme_generator/features/domain/entities/template.dart';
import 'package:meme_generator/features/domain/repositories/template_repository.dart';

import '../../../core/usecase/usecase.dart';

class SaveTemplateUseCase implements UseCase<void, Template> {
  final TemplateRepository _templateRepository;

  SaveTemplateUseCase(this._templateRepository);

  @override
  Future<void> call({Template? params}) {
    return _templateRepository.saveTemplate(params!);
  }
}
