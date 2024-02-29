import 'package:equatable/equatable.dart';
import 'package:meme_generator/features/domain/entities/template.dart';

sealed class LocalTemplateEvent extends Equatable {
  final Template? template;
  final List<Template>? templates;

  const LocalTemplateEvent({this.template, this.templates});

  @override
  List<Object> get props => [template!];
}

class GetSavedTemplates extends LocalTemplateEvent {
  const GetSavedTemplates();
}

class RemoveTemplate extends LocalTemplateEvent {
  const RemoveTemplate(Template template) : super(template: template);
}

class RemoveTemplates extends LocalTemplateEvent {
  const RemoveTemplates(List<Template> templates) : super(templates: templates);
}

class SaveTemplate extends LocalTemplateEvent {
  const SaveTemplate(Template template) : super(template: template);
}

class UpdateTemplate extends LocalTemplateEvent {
  const UpdateTemplate(Template template) : super(template: template);
}
