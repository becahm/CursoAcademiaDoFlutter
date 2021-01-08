import 'package:sqflite/sqlite_api.dart';

void createV2(Batch batch) {
  batch.execute('create table teste ( id Integer)');
}

void updateV2(Batch batch) {
  batch.execute('create table teste ( id Integer)');
}
