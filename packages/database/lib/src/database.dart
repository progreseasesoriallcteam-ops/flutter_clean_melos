import 'dart:io' show File;

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/user_profile_table.dart';

part 'database.g.dart';

@DriftDatabase(tables: [UserProfiles])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<UserProfile>> getAllProfiles() => select(userProfiles).get();
  Future<void> upsertProfile(UserProfilesCompanion profile) =>
      into(userProfiles).insertOnConflictUpdate(profile);
  Future<void> deleteProfile(String id) =>
      (delete(userProfiles)..where((t) => t.id.equals(id))).go();
  Future<UserProfile?> getProfile(String id) =>
      (select(userProfiles)..where((t) => t.id.equals(id))).getSingleOrNull();
}

QueryExecutor _openConnection() {
  if (kIsWeb) {
    return NativeDatabase.memory();
  }
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app.db'));
    return NativeDatabase(file);
  });
}
