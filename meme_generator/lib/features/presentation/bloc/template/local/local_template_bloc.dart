import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meme_generator/features/domain/usecases/delete_template.dart';
import 'package:meme_generator/features/domain/usecases/save_template.dart';
import 'package:meme_generator/features/presentation/bloc/template/local/local_template_event.dart';
import 'package:meme_generator/features/presentation/bloc/template/local/local_template_state.dart';

import '../../../../domain/usecases/get_templates.dart';

class LocalTemplateBloc extends Bloc<LocalTemplateEvent, LocalTemplatesState> {
  final GetTemplatesUseCase _getSavedTemplateUseCase;

  final SaveTemplateUseCase _saveTemplateUseCase;

  final RemoveTemplateUseCase _removeTemplateUseCase;

  LocalTemplateBloc(this._saveTemplateUseCase, this._getSavedTemplateUseCase, this._removeTemplateUseCase)
      : super(const LocalTemplatesLoading()) {
    on<GetSavedTemplates>(onGetSavedTemplates);
    on<SaveTemplate>(onSaveTemplate);
    on<RemoveTemplate>(onRemoveTemplate);
  }

  void onGetSavedTemplates(
      GetSavedTemplates event, Emitter<LocalTemplatesState> emit) async {
    final templates = await _getSavedTemplateUseCase();
    emit(LocalTemplatesDone(templates));
  }

  void onRemoveTemplate(
      RemoveTemplate event, Emitter<LocalTemplatesState> emit) async {
    await _removeTemplateUseCase(params: event.template);
    final templates = await _getSavedTemplateUseCase();
    emit(LocalTemplatesDone(templates));
  }

  void onSaveTemplate(
      SaveTemplate saveTemplate, Emitter<LocalTemplatesState> emit) async {
    await _saveTemplateUseCase(params: saveTemplate.template);
    final templates = await _getSavedTemplateUseCase();
    emit(LocalTemplatesDone(templates));
  }
}
