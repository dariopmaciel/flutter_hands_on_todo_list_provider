// ignore_for_file: constant_identifier_names

import 'package:flutter_hands_on_todo_list_provider/app/core/database/sqlite_migration_factory.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

class SqliteConnectionFactory {
  static const _VERSION = 1;
  static const _DATABASE_NAME = 'TODO_LIST_PROVIDER';

//O Padrão Singleton tem como definição garantir que uma classe tenha apenas uma instância de si mesma e que forneça um ponto global de acesso a ela. Ou seja, uma classe gerencia a própria instância dela além de evitar que qualquer outra classe crie uma instância dela.
  static SqliteConnectionFactory? _instance;

//criação de atributo
  Database? _db;
  // criação de variavel
  final _lock = Lock();

  SqliteConnectionFactory._();
//Casa vez que o desenvolvedor criar uma instancia nova, verifica se dentro da classe já não tem uma instancia criada, seja tiver, será retornada ela, se já tiver uma instancia é criada e a partir de então n~so será criada nenhuma outra
  factory SqliteConnectionFactory() {
    if (_instance == null) {
      //SE A INSTANCIA FOR NULA, SERÁ CHAMADO O CONSTRUTOR PRIVADO
      _instance = SqliteConnectionFactory._();
    }
    return _instance!;
  }

  //abertura de database
  Future<Database> openConnection() async {
    var databasePath = await getDatabasesPath();
    // ignore: non_constant_identifier_names
    var databasePathFinal = join(databasePath, _DATABASE_NAME);
    if (_db == null) {
      await _lock.synchronized(() async {
        if (_db == null) {
          _db = await openDatabase(
            databasePathFinal,
            version: _VERSION,
            onConfigure: _onConfigure,
            onCreate: _onCreate,
            onUpgrade: _onUpgrade,
            onDowngrade: _onDowngrade,
          );
        }
      });
    }
    return _db!;
  }

  void closeConection() {
    _db?.close();
    _db = null;
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> _onCreate(Database db, int version) async {
    final batch = db.batch();

    final migrations = SqliteMigrationFactory().getCreateMigration();
    for (var migration in migrations) {
      migration.create(batch);
    }
    batch.commit();
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int version) async {
    final batch = db.batch();

    final migrations = SqliteMigrationFactory().getUpgradeMigration(oldVersion);
    for (var migration in migrations) {
      migration.update(batch);
    }
    batch.commit();
  }

  Future<void> _onDowngrade(Database db, int oldVersion, int version) async {}
}
