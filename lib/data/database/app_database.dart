import 'package:drift/drift.dart';

part 'app_database.g.dart';

class Projects extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  RealColumn get originLat => real().nullable()();
  RealColumn get originLon => real().nullable()();
  RealColumn get originEllipH => real().nullable()();
  TextColumn get datumMode => text().withDefault(const Constant('local'))();
  RealColumn get benchmarkHeight => real().nullable()();
  RealColumn get basePressureHpa => real().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class Sessions extends Table {
  TextColumn get id => text()();
  TextColumn get projectId => text()();
  TextColumn get mode => text()();
  TextColumn get code => text()();
  TextColumn get masterDeviceId => text().nullable()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime().nullable()();
  TextColumn get status => text().withDefault(const Constant('active'))();

  @override
  Set<Column> get primaryKey => {id};
}

class Devices extends Table {
  TextColumn get id => text()();
  TextColumn get sessionId => text()();
  IntColumn get shortId => integer()();
  TextColumn get role => text()();
  TextColumn get name => text()();
  BoolColumn get hasBarometer => boolean().withDefault(const Constant(false))();
  RealColumn get rssiAt1m => real().nullable()();
  RealColumn get pathLossN => real().nullable()();
  DateTimeColumn get lastSeenAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Epochs extends Table {
  TextColumn get id => text()();
  TextColumn get sessionId => text()();
  IntColumn get index => integer()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime().nullable()();
  TextColumn get status => text().withDefault(const Constant('active'))();

  @override
  Set<Column> get primaryKey => {id};
}

class GnssObservations extends Table {
  TextColumn get id => text()();
  TextColumn get epochId => text()();
  TextColumn get deviceId => text()();
  RealColumn get lat => real()();
  RealColumn get lon => real()();
  RealColumn get ellipH => real()();
  RealColumn get accuracyH => real()();
  RealColumn get accuracyV => real().nullable()();
  IntColumn get satellites => integer().nullable()();
  IntColumn get sampleCount => integer()();
  RealColumn get stdLat => real()();
  RealColumn get stdLon => real()();
  RealColumn get stdAlt => real()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class BaroObservations extends Table {
  TextColumn get id => text()();
  TextColumn get epochId => text()();
  TextColumn get deviceId => text()();
  RealColumn get pressureHpa => real()();
  RealColumn get relativeHeightM => real().nullable()();
  RealColumn get basePressureHpa => real().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class BleMeasurements extends Table {
  TextColumn get id => text()();
  TextColumn get epochId => text()();
  TextColumn get observerDeviceId => text()();
  IntColumn get peerShortId => integer()();
  TextColumn get rssiSamplesJson => text()();
  RealColumn get rssiFiltered => real().nullable()();
  RealColumn get distanceM => real().nullable()();
  RealColumn get distanceSigma => real().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class Anchors extends Table {
  TextColumn get id => text()();
  TextColumn get sessionId => text()();
  TextColumn get deviceId => text().nullable()();
  TextColumn get label => text()();
  RealColumn get lat => real()();
  RealColumn get lon => real()();
  RealColumn get ellipH => real()();
  RealColumn get orthoH => real().nullable()();
  RealColumn get accuracyH => real().nullable()();
  RealColumn get accuracyV => real().nullable()();
  TextColumn get source => text().withDefault(const Constant('manual'))();
  BoolColumn get isFixed => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class SurveyPoints extends Table {
  TextColumn get id => text()();
  TextColumn get projectId => text()();
  TextColumn get sessionId => text()();
  TextColumn get epochId => text().nullable()();
  TextColumn get code => text()();
  TextColumn get layer => text().withDefault(const Constant('tanah'))();
  TextColumn get description => text().nullable()();
  RealColumn get lat => real()();
  RealColumn get lon => real()();
  RealColumn get orthoH => real()();
  RealColumn get accuracyH => real()();
  RealColumn get accuracyV => real().nullable()();
  TextColumn get method => text()();
  TextColumn get quality => text()();
  TextColumn get status => text().withDefault(const Constant('active'))();
  RealColumn get poleHeight => real()();
  TextColumn get photoPath => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class DiagnosticLogs extends Table {
  TextColumn get id => text()();
  TextColumn get sessionId => text().nullable()();
  TextColumn get deviceId => text().nullable()();
  TextColumn get category => text()();
  TextColumn get message => text()();
  TextColumn get payloadJson => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    Projects,
    Sessions,
    Devices,
    Epochs,
    GnssObservations,
    BaroObservations,
    BleMeasurements,
    Anchors,
    SurveyPoints,
    DiagnosticLogs,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
  );
}
