// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TemplateDao? _templateDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `template` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `id` INTEGER, `img` BLOB, `uriToImage` TEXT, `textList` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TemplateDao get templateDao {
    return _templateDaoInstance ??= _$TemplateDao(database, changeListener);
  }
}

class _$TemplateDao extends TemplateDao {
  _$TemplateDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _templateModelInsertionAdapter = InsertionAdapter(
            database,
            'template',
            (TemplateModel item) => <String, Object?>{
                  'id': item.id,
                  'id': item.id,
                  'img': item.img,
                  'uriToImage': item.uriToImage,
                  'textList': _stringListConverter.encode(item.textList)
                }),
        _templateModelUpdateAdapter = UpdateAdapter(
            database,
            'template',
            ['id'],
            (TemplateModel item) => <String, Object?>{
                  'id': item.id,
                  'id': item.id,
                  'img': item.img,
                  'uriToImage': item.uriToImage,
                  'textList': _stringListConverter.encode(item.textList)
                }),
        _templateModelDeletionAdapter = DeletionAdapter(
            database,
            'template',
            ['id'],
            (TemplateModel item) => <String, Object?>{
                  'id': item.id,
                  'id': item.id,
                  'img': item.img,
                  'uriToImage': item.uriToImage,
                  'textList': _stringListConverter.encode(item.textList)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TemplateModel> _templateModelInsertionAdapter;

  final UpdateAdapter<TemplateModel> _templateModelUpdateAdapter;

  final DeletionAdapter<TemplateModel> _templateModelDeletionAdapter;

  @override
  Future<List<TemplateModel>> getTemplates() async {
    return _queryAdapter.queryList('select * from template',
        mapper: (Map<String, Object?> row) => TemplateModel(
            id: row['id'] as int?,
            uriToImage: row['uriToImage'] as String?,
            imageBytes: row['img'] as Uint8List?,
            textList: _stringListConverter.decode(row['textList'] as String)));
  }

  @override
  Future<void> insertTemplate(TemplateModel template) async {
    await _templateModelInsertionAdapter.insert(
        template, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateTemplate(TemplateModel template) async {
    await _templateModelUpdateAdapter.update(
        template, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteTemplate(TemplateModel template) async {
    await _templateModelDeletionAdapter.delete(template);
  }
}

// ignore_for_file: unused_element
final _stringListConverter = StringListConverter();
