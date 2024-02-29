import 'package:meme_generator/core/usecase/usecase.dart';
import 'package:meme_generator/features/domain/repositories/template_repository.dart';

import '../entities/template.dart';

class RemoveTemplatesUseCase extends UseCase<void, List<Template>> {
  final TemplateRepository _templateRepository;

  RemoveTemplatesUseCase(this._templateRepository);

  @override
  Future<void> call({List<Template>? params}) {
    return _templateRepository.deleteTemplates(params!);
  }
}
