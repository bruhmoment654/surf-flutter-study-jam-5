import 'package:equatable/equatable.dart';
import 'package:meme_generator/features/domain/entities/template.dart';

sealed class LocalTemplateEvent extends Equatable {
  final Template? template;

  const LocalTemplateEvent({this.template});

  @override
  List<Object> get props => [template!];
}

class GetSavedTemplates extends LocalTemplateEvent {
  const GetSavedTemplates();
}

class RemoveTemplate extends LocalTemplateEvent {
  const RemoveTemplate(Template template) : super(template: template);
}

class SaveTemplate extends LocalTemplateEvent {
  const SaveTemplate(Template template) : super(template: template);
}
