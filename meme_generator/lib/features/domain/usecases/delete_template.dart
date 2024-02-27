import 'package:meme_generator/core/usecase/usecase.dart';
import 'package:meme_generator/features/domain/repositories/template_repository.dart';

import '../entities/template.dart';

class RemoveTemplateUseCase extends UseCase<void, Template>{

  final TemplateRepository _templateRepository;

  RemoveTemplateUseCase(this._templateRepository);

  @override
  Future<void> call({Template? params}) {
  return _templateRepository.deleteTemplate(params!);
  }



}