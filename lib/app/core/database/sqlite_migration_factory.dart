import 'package:flutter_hands_on_todo_list_provider/app/core/database/migrations/migration.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/database/migrations/migration_v1.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/database/migrations/migration_v2.dart';
import 'package:flutter_hands_on_todo_list_provider/app/core/database/migrations/migration_v3.dart';

//construção da interface
class SqliteMigrationFactory {
  //metodos que retornarão uma lista
  List<Migration> getCreateMigration() => [
        MigrationV1(),
        MigrationV2(),
        MigrationV3(),
      ];
  List<Migration> getUpgradeMigration(int version) {
    var migrations = <Migration>[];
    //versão atual do sistema = 3
    //se versão = 1, ADD v2 e v3
    if (version == 1) {
      migrations.add(MigrationV2());
      migrations.add(MigrationV3());
    }
    //versão atual do sistema = 3
    //se versão = 2, ADD v3
    if (version == 2) {
      migrations.add(MigrationV3());
    }
    return migrations;
  }
}
