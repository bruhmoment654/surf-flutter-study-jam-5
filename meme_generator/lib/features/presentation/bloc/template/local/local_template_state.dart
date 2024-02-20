import 'package:equatable/equatable.dart';
import 'package:meme_generator/features/domain/entities/template.dart';

sealed class LocalTemplatesState extends Equatable {
  final List<Template>? templates;

  const LocalTemplatesState({this.templates});

  @override
  List<Object> get props => [templates!];
}

class LocalTemplatesLoading extends LocalTemplatesState {
  const LocalTemplatesLoading();
}

class LocalTemplatesDone extends LocalTemplatesState {
  const LocalTemplatesDone(List<Template> templates)
      : super(templates: templates);
}
