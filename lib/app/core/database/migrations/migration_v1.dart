import 'package:flutter_hands_on_todo_list_provider/app/core/database/migrations/migration.dart';
import 'package:sqflite_common/sqlite_api.dart';

class MigrationV1 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute('''
      create table todo(
        id Integer primary key autoincrement,
        descricao varchar(500) not null,
        data_hota datetime,
        finalizado integer
      )
    ''');
  }

  @override
  void update(Batch batch) {}
}