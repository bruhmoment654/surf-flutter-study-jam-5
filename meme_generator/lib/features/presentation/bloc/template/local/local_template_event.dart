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

class RemoveTemplates extends LocalTemplateEvent {
  const RemoveTemplates(Template template) : super(template: template);
}

class SaveTemplates extends LocalTemplateEvent {
  const SaveTemplates(Template template) : super(template: template);
}
