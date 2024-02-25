
import 'dart:async';
import 'dart:typed_data';

import 'package:floor/floor.dart';
import 'package:meme_generator/features/data/data_sources/local/DAO/template_dao.dart';
import 'package:meme_generator/features/data/data_sources/local/type_converter.dart';
import 'package:meme_generator/features/data/models/template.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';
@TypeConverters([StringListConverter])
@Database(version: 1, entities: [TemplateModel])
abstract class AppDatabase extends FloorDatabase {
  TemplateDao get templateDao;
}
