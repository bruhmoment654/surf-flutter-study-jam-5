import 'package:get_it/get_it.dart';
import 'package:meme_generator/features/data/repository/template_repository.dart';
import 'package:meme_generator/features/domain/repositories/template_repository.dart';
import 'package:meme_generator/features/domain/usecases/remove_template.dart';
import 'package:meme_generator/features/domain/usecases/remove_templates.dart';
import 'package:meme_generator/features/domain/usecases/get_templates.dart';
import 'package:meme_generator/features/domain/usecases/save_template.dart';
import 'package:meme_generator/features/domain/usecases/update_template.dart';
import 'package:meme_generator/features/presentation/bloc/template/local/local_template_bloc.dart';

import 'data/data_sources/local/app_database.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  final db = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(db);

  sl.registerSingleton<TemplateRepository>(TemplateRepositoryImpl(sl()));
  sl.registerSingleton<GetTemplatesUseCase>(GetTemplatesUseCase(sl()));
  sl.registerSingleton<SaveTemplateUseCase>(SaveTemplateUseCase(sl()));
  sl.registerSingleton<RemoveTemplateUseCase>(RemoveTemplateUseCase(sl()));
  sl.registerSingleton<RemoveTemplatesUseCase>(RemoveTemplatesUseCase(sl()));
  sl.registerSingleton<UpdateTemplateUseCase>(UpdateTemplateUseCase(sl()));

  sl.registerFactory<LocalTemplateBloc>(
      () => LocalTemplateBloc(sl(), sl(), sl(), sl(), sl()));
}
