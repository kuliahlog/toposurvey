// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProjectsTable extends Projects with TableInfo<$ProjectsTable, Project> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _originLatMeta = const VerificationMeta(
    'originLat',
  );
  @override
  late final GeneratedColumn<double> originLat = GeneratedColumn<double>(
    'origin_lat',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _originLonMeta = const VerificationMeta(
    'originLon',
  );
  @override
  late final GeneratedColumn<double> originLon = GeneratedColumn<double>(
    'origin_lon',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _originEllipHMeta = const VerificationMeta(
    'originEllipH',
  );
  @override
  late final GeneratedColumn<double> originEllipH = GeneratedColumn<double>(
    'origin_ellip_h',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _datumModeMeta = const VerificationMeta(
    'datumMode',
  );
  @override
  late final GeneratedColumn<String> datumMode = GeneratedColumn<String>(
    'datum_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('local'),
  );
  static const VerificationMeta _benchmarkHeightMeta = const VerificationMeta(
    'benchmarkHeight',
  );
  @override
  late final GeneratedColumn<double> benchmarkHeight = GeneratedColumn<double>(
    'benchmark_height',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _basePressureHpaMeta = const VerificationMeta(
    'basePressureHpa',
  );
  @override
  late final GeneratedColumn<double> basePressureHpa = GeneratedColumn<double>(
    'base_pressure_hpa',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    originLat,
    originLon,
    originEllipH,
    datumMode,
    benchmarkHeight,
    basePressureHpa,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'projects';
  @override
  VerificationContext validateIntegrity(
    Insertable<Project> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('origin_lat')) {
      context.handle(
        _originLatMeta,
        originLat.isAcceptableOrUnknown(data['origin_lat']!, _originLatMeta),
      );
    }
    if (data.containsKey('origin_lon')) {
      context.handle(
        _originLonMeta,
        originLon.isAcceptableOrUnknown(data['origin_lon']!, _originLonMeta),
      );
    }
    if (data.containsKey('origin_ellip_h')) {
      context.handle(
        _originEllipHMeta,
        originEllipH.isAcceptableOrUnknown(
          data['origin_ellip_h']!,
          _originEllipHMeta,
        ),
      );
    }
    if (data.containsKey('datum_mode')) {
      context.handle(
        _datumModeMeta,
        datumMode.isAcceptableOrUnknown(data['datum_mode']!, _datumModeMeta),
      );
    }
    if (data.containsKey('benchmark_height')) {
      context.handle(
        _benchmarkHeightMeta,
        benchmarkHeight.isAcceptableOrUnknown(
          data['benchmark_height']!,
          _benchmarkHeightMeta,
        ),
      );
    }
    if (data.containsKey('base_pressure_hpa')) {
      context.handle(
        _basePressureHpaMeta,
        basePressureHpa.isAcceptableOrUnknown(
          data['base_pressure_hpa']!,
          _basePressureHpaMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Project map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Project(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      originLat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}origin_lat'],
      ),
      originLon: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}origin_lon'],
      ),
      originEllipH: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}origin_ellip_h'],
      ),
      datumMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}datum_mode'],
      )!,
      benchmarkHeight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}benchmark_height'],
      ),
      basePressureHpa: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}base_pressure_hpa'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ProjectsTable createAlias(String alias) {
    return $ProjectsTable(attachedDatabase, alias);
  }
}

class Project extends DataClass implements Insertable<Project> {
  final String id;
  final String name;
  final String? description;
  final double? originLat;
  final double? originLon;
  final double? originEllipH;
  final String datumMode;
  final double? benchmarkHeight;
  final double? basePressureHpa;
  final DateTime createdAt;
  const Project({
    required this.id,
    required this.name,
    this.description,
    this.originLat,
    this.originLon,
    this.originEllipH,
    required this.datumMode,
    this.benchmarkHeight,
    this.basePressureHpa,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || originLat != null) {
      map['origin_lat'] = Variable<double>(originLat);
    }
    if (!nullToAbsent || originLon != null) {
      map['origin_lon'] = Variable<double>(originLon);
    }
    if (!nullToAbsent || originEllipH != null) {
      map['origin_ellip_h'] = Variable<double>(originEllipH);
    }
    map['datum_mode'] = Variable<String>(datumMode);
    if (!nullToAbsent || benchmarkHeight != null) {
      map['benchmark_height'] = Variable<double>(benchmarkHeight);
    }
    if (!nullToAbsent || basePressureHpa != null) {
      map['base_pressure_hpa'] = Variable<double>(basePressureHpa);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ProjectsCompanion toCompanion(bool nullToAbsent) {
    return ProjectsCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      originLat: originLat == null && nullToAbsent
          ? const Value.absent()
          : Value(originLat),
      originLon: originLon == null && nullToAbsent
          ? const Value.absent()
          : Value(originLon),
      originEllipH: originEllipH == null && nullToAbsent
          ? const Value.absent()
          : Value(originEllipH),
      datumMode: Value(datumMode),
      benchmarkHeight: benchmarkHeight == null && nullToAbsent
          ? const Value.absent()
          : Value(benchmarkHeight),
      basePressureHpa: basePressureHpa == null && nullToAbsent
          ? const Value.absent()
          : Value(basePressureHpa),
      createdAt: Value(createdAt),
    );
  }

  factory Project.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Project(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      originLat: serializer.fromJson<double?>(json['originLat']),
      originLon: serializer.fromJson<double?>(json['originLon']),
      originEllipH: serializer.fromJson<double?>(json['originEllipH']),
      datumMode: serializer.fromJson<String>(json['datumMode']),
      benchmarkHeight: serializer.fromJson<double?>(json['benchmarkHeight']),
      basePressureHpa: serializer.fromJson<double?>(json['basePressureHpa']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'originLat': serializer.toJson<double?>(originLat),
      'originLon': serializer.toJson<double?>(originLon),
      'originEllipH': serializer.toJson<double?>(originEllipH),
      'datumMode': serializer.toJson<String>(datumMode),
      'benchmarkHeight': serializer.toJson<double?>(benchmarkHeight),
      'basePressureHpa': serializer.toJson<double?>(basePressureHpa),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Project copyWith({
    String? id,
    String? name,
    Value<String?> description = const Value.absent(),
    Value<double?> originLat = const Value.absent(),
    Value<double?> originLon = const Value.absent(),
    Value<double?> originEllipH = const Value.absent(),
    String? datumMode,
    Value<double?> benchmarkHeight = const Value.absent(),
    Value<double?> basePressureHpa = const Value.absent(),
    DateTime? createdAt,
  }) => Project(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    originLat: originLat.present ? originLat.value : this.originLat,
    originLon: originLon.present ? originLon.value : this.originLon,
    originEllipH: originEllipH.present ? originEllipH.value : this.originEllipH,
    datumMode: datumMode ?? this.datumMode,
    benchmarkHeight: benchmarkHeight.present
        ? benchmarkHeight.value
        : this.benchmarkHeight,
    basePressureHpa: basePressureHpa.present
        ? basePressureHpa.value
        : this.basePressureHpa,
    createdAt: createdAt ?? this.createdAt,
  );
  Project copyWithCompanion(ProjectsCompanion data) {
    return Project(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      originLat: data.originLat.present ? data.originLat.value : this.originLat,
      originLon: data.originLon.present ? data.originLon.value : this.originLon,
      originEllipH: data.originEllipH.present
          ? data.originEllipH.value
          : this.originEllipH,
      datumMode: data.datumMode.present ? data.datumMode.value : this.datumMode,
      benchmarkHeight: data.benchmarkHeight.present
          ? data.benchmarkHeight.value
          : this.benchmarkHeight,
      basePressureHpa: data.basePressureHpa.present
          ? data.basePressureHpa.value
          : this.basePressureHpa,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Project(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('originLat: $originLat, ')
          ..write('originLon: $originLon, ')
          ..write('originEllipH: $originEllipH, ')
          ..write('datumMode: $datumMode, ')
          ..write('benchmarkHeight: $benchmarkHeight, ')
          ..write('basePressureHpa: $basePressureHpa, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    originLat,
    originLon,
    originEllipH,
    datumMode,
    benchmarkHeight,
    basePressureHpa,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Project &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.originLat == this.originLat &&
          other.originLon == this.originLon &&
          other.originEllipH == this.originEllipH &&
          other.datumMode == this.datumMode &&
          other.benchmarkHeight == this.benchmarkHeight &&
          other.basePressureHpa == this.basePressureHpa &&
          other.createdAt == this.createdAt);
}

class ProjectsCompanion extends UpdateCompanion<Project> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<double?> originLat;
  final Value<double?> originLon;
  final Value<double?> originEllipH;
  final Value<String> datumMode;
  final Value<double?> benchmarkHeight;
  final Value<double?> basePressureHpa;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ProjectsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.originLat = const Value.absent(),
    this.originLon = const Value.absent(),
    this.originEllipH = const Value.absent(),
    this.datumMode = const Value.absent(),
    this.benchmarkHeight = const Value.absent(),
    this.basePressureHpa = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProjectsCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    this.originLat = const Value.absent(),
    this.originLon = const Value.absent(),
    this.originEllipH = const Value.absent(),
    this.datumMode = const Value.absent(),
    this.benchmarkHeight = const Value.absent(),
    this.basePressureHpa = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       createdAt = Value(createdAt);
  static Insertable<Project> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<double>? originLat,
    Expression<double>? originLon,
    Expression<double>? originEllipH,
    Expression<String>? datumMode,
    Expression<double>? benchmarkHeight,
    Expression<double>? basePressureHpa,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (originLat != null) 'origin_lat': originLat,
      if (originLon != null) 'origin_lon': originLon,
      if (originEllipH != null) 'origin_ellip_h': originEllipH,
      if (datumMode != null) 'datum_mode': datumMode,
      if (benchmarkHeight != null) 'benchmark_height': benchmarkHeight,
      if (basePressureHpa != null) 'base_pressure_hpa': basePressureHpa,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProjectsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<double?>? originLat,
    Value<double?>? originLon,
    Value<double?>? originEllipH,
    Value<String>? datumMode,
    Value<double?>? benchmarkHeight,
    Value<double?>? basePressureHpa,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ProjectsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      originLat: originLat ?? this.originLat,
      originLon: originLon ?? this.originLon,
      originEllipH: originEllipH ?? this.originEllipH,
      datumMode: datumMode ?? this.datumMode,
      benchmarkHeight: benchmarkHeight ?? this.benchmarkHeight,
      basePressureHpa: basePressureHpa ?? this.basePressureHpa,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (originLat.present) {
      map['origin_lat'] = Variable<double>(originLat.value);
    }
    if (originLon.present) {
      map['origin_lon'] = Variable<double>(originLon.value);
    }
    if (originEllipH.present) {
      map['origin_ellip_h'] = Variable<double>(originEllipH.value);
    }
    if (datumMode.present) {
      map['datum_mode'] = Variable<String>(datumMode.value);
    }
    if (benchmarkHeight.present) {
      map['benchmark_height'] = Variable<double>(benchmarkHeight.value);
    }
    if (basePressureHpa.present) {
      map['base_pressure_hpa'] = Variable<double>(basePressureHpa.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('originLat: $originLat, ')
          ..write('originLon: $originLon, ')
          ..write('originEllipH: $originEllipH, ')
          ..write('datumMode: $datumMode, ')
          ..write('benchmarkHeight: $benchmarkHeight, ')
          ..write('basePressureHpa: $basePressureHpa, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SessionsTable extends Sessions with TableInfo<$SessionsTable, Session> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumn<String> mode = GeneratedColumn<String>(
    'mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _masterDeviceIdMeta = const VerificationMeta(
    'masterDeviceId',
  );
  @override
  late final GeneratedColumn<String> masterDeviceId = GeneratedColumn<String>(
    'master_device_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    projectId,
    mode,
    code,
    masterDeviceId,
    startedAt,
    endedAt,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Session> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('mode')) {
      context.handle(
        _modeMeta,
        mode.isAcceptableOrUnknown(data['mode']!, _modeMeta),
      );
    } else if (isInserting) {
      context.missing(_modeMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('master_device_id')) {
      context.handle(
        _masterDeviceIdMeta,
        masterDeviceId.isAcceptableOrUnknown(
          data['master_device_id']!,
          _masterDeviceIdMeta,
        ),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Session map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Session(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      )!,
      mode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mode'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      masterDeviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}master_device_id'],
      ),
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $SessionsTable createAlias(String alias) {
    return $SessionsTable(attachedDatabase, alias);
  }
}

class Session extends DataClass implements Insertable<Session> {
  final String id;
  final String projectId;
  final String mode;
  final String code;
  final String? masterDeviceId;
  final DateTime startedAt;
  final DateTime? endedAt;
  final String status;
  const Session({
    required this.id,
    required this.projectId,
    required this.mode,
    required this.code,
    this.masterDeviceId,
    required this.startedAt,
    this.endedAt,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['project_id'] = Variable<String>(projectId);
    map['mode'] = Variable<String>(mode);
    map['code'] = Variable<String>(code);
    if (!nullToAbsent || masterDeviceId != null) {
      map['master_device_id'] = Variable<String>(masterDeviceId);
    }
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    map['status'] = Variable<String>(status);
    return map;
  }

  SessionsCompanion toCompanion(bool nullToAbsent) {
    return SessionsCompanion(
      id: Value(id),
      projectId: Value(projectId),
      mode: Value(mode),
      code: Value(code),
      masterDeviceId: masterDeviceId == null && nullToAbsent
          ? const Value.absent()
          : Value(masterDeviceId),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      status: Value(status),
    );
  }

  factory Session.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Session(
      id: serializer.fromJson<String>(json['id']),
      projectId: serializer.fromJson<String>(json['projectId']),
      mode: serializer.fromJson<String>(json['mode']),
      code: serializer.fromJson<String>(json['code']),
      masterDeviceId: serializer.fromJson<String?>(json['masterDeviceId']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'projectId': serializer.toJson<String>(projectId),
      'mode': serializer.toJson<String>(mode),
      'code': serializer.toJson<String>(code),
      'masterDeviceId': serializer.toJson<String?>(masterDeviceId),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
      'status': serializer.toJson<String>(status),
    };
  }

  Session copyWith({
    String? id,
    String? projectId,
    String? mode,
    String? code,
    Value<String?> masterDeviceId = const Value.absent(),
    DateTime? startedAt,
    Value<DateTime?> endedAt = const Value.absent(),
    String? status,
  }) => Session(
    id: id ?? this.id,
    projectId: projectId ?? this.projectId,
    mode: mode ?? this.mode,
    code: code ?? this.code,
    masterDeviceId: masterDeviceId.present
        ? masterDeviceId.value
        : this.masterDeviceId,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
    status: status ?? this.status,
  );
  Session copyWithCompanion(SessionsCompanion data) {
    return Session(
      id: data.id.present ? data.id.value : this.id,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      mode: data.mode.present ? data.mode.value : this.mode,
      code: data.code.present ? data.code.value : this.code,
      masterDeviceId: data.masterDeviceId.present
          ? data.masterDeviceId.value
          : this.masterDeviceId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Session(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('mode: $mode, ')
          ..write('code: $code, ')
          ..write('masterDeviceId: $masterDeviceId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    projectId,
    mode,
    code,
    masterDeviceId,
    startedAt,
    endedAt,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Session &&
          other.id == this.id &&
          other.projectId == this.projectId &&
          other.mode == this.mode &&
          other.code == this.code &&
          other.masterDeviceId == this.masterDeviceId &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.status == this.status);
}

class SessionsCompanion extends UpdateCompanion<Session> {
  final Value<String> id;
  final Value<String> projectId;
  final Value<String> mode;
  final Value<String> code;
  final Value<String?> masterDeviceId;
  final Value<DateTime> startedAt;
  final Value<DateTime?> endedAt;
  final Value<String> status;
  final Value<int> rowid;
  const SessionsCompanion({
    this.id = const Value.absent(),
    this.projectId = const Value.absent(),
    this.mode = const Value.absent(),
    this.code = const Value.absent(),
    this.masterDeviceId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SessionsCompanion.insert({
    required String id,
    required String projectId,
    required String mode,
    required String code,
    this.masterDeviceId = const Value.absent(),
    required DateTime startedAt,
    this.endedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       projectId = Value(projectId),
       mode = Value(mode),
       code = Value(code),
       startedAt = Value(startedAt);
  static Insertable<Session> custom({
    Expression<String>? id,
    Expression<String>? projectId,
    Expression<String>? mode,
    Expression<String>? code,
    Expression<String>? masterDeviceId,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectId != null) 'project_id': projectId,
      if (mode != null) 'mode': mode,
      if (code != null) 'code': code,
      if (masterDeviceId != null) 'master_device_id': masterDeviceId,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SessionsCompanion copyWith({
    Value<String>? id,
    Value<String>? projectId,
    Value<String>? mode,
    Value<String>? code,
    Value<String?>? masterDeviceId,
    Value<DateTime>? startedAt,
    Value<DateTime?>? endedAt,
    Value<String>? status,
    Value<int>? rowid,
  }) {
    return SessionsCompanion(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      mode: mode ?? this.mode,
      code: code ?? this.code,
      masterDeviceId: masterDeviceId ?? this.masterDeviceId,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (mode.present) {
      map['mode'] = Variable<String>(mode.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (masterDeviceId.present) {
      map['master_device_id'] = Variable<String>(masterDeviceId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionsCompanion(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('mode: $mode, ')
          ..write('code: $code, ')
          ..write('masterDeviceId: $masterDeviceId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DevicesTable extends Devices with TableInfo<$DevicesTable, Device> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DevicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shortIdMeta = const VerificationMeta(
    'shortId',
  );
  @override
  late final GeneratedColumn<int> shortId = GeneratedColumn<int>(
    'short_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hasBarometerMeta = const VerificationMeta(
    'hasBarometer',
  );
  @override
  late final GeneratedColumn<bool> hasBarometer = GeneratedColumn<bool>(
    'has_barometer',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_barometer" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _rssiAt1mMeta = const VerificationMeta(
    'rssiAt1m',
  );
  @override
  late final GeneratedColumn<double> rssiAt1m = GeneratedColumn<double>(
    'rssi_at1m',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pathLossNMeta = const VerificationMeta(
    'pathLossN',
  );
  @override
  late final GeneratedColumn<double> pathLossN = GeneratedColumn<double>(
    'path_loss_n',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastSeenAtMeta = const VerificationMeta(
    'lastSeenAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSeenAt = GeneratedColumn<DateTime>(
    'last_seen_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    shortId,
    role,
    name,
    hasBarometer,
    rssiAt1m,
    pathLossN,
    lastSeenAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'devices';
  @override
  VerificationContext validateIntegrity(
    Insertable<Device> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('short_id')) {
      context.handle(
        _shortIdMeta,
        shortId.isAcceptableOrUnknown(data['short_id']!, _shortIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shortIdMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('has_barometer')) {
      context.handle(
        _hasBarometerMeta,
        hasBarometer.isAcceptableOrUnknown(
          data['has_barometer']!,
          _hasBarometerMeta,
        ),
      );
    }
    if (data.containsKey('rssi_at1m')) {
      context.handle(
        _rssiAt1mMeta,
        rssiAt1m.isAcceptableOrUnknown(data['rssi_at1m']!, _rssiAt1mMeta),
      );
    }
    if (data.containsKey('path_loss_n')) {
      context.handle(
        _pathLossNMeta,
        pathLossN.isAcceptableOrUnknown(data['path_loss_n']!, _pathLossNMeta),
      );
    }
    if (data.containsKey('last_seen_at')) {
      context.handle(
        _lastSeenAtMeta,
        lastSeenAt.isAcceptableOrUnknown(
          data['last_seen_at']!,
          _lastSeenAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Device map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Device(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      shortId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}short_id'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      hasBarometer: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_barometer'],
      )!,
      rssiAt1m: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rssi_at1m'],
      ),
      pathLossN: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}path_loss_n'],
      ),
      lastSeenAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_seen_at'],
      ),
    );
  }

  @override
  $DevicesTable createAlias(String alias) {
    return $DevicesTable(attachedDatabase, alias);
  }
}

class Device extends DataClass implements Insertable<Device> {
  final String id;
  final String sessionId;
  final int shortId;
  final String role;
  final String name;
  final bool hasBarometer;
  final double? rssiAt1m;
  final double? pathLossN;
  final DateTime? lastSeenAt;
  const Device({
    required this.id,
    required this.sessionId,
    required this.shortId,
    required this.role,
    required this.name,
    required this.hasBarometer,
    this.rssiAt1m,
    this.pathLossN,
    this.lastSeenAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['short_id'] = Variable<int>(shortId);
    map['role'] = Variable<String>(role);
    map['name'] = Variable<String>(name);
    map['has_barometer'] = Variable<bool>(hasBarometer);
    if (!nullToAbsent || rssiAt1m != null) {
      map['rssi_at1m'] = Variable<double>(rssiAt1m);
    }
    if (!nullToAbsent || pathLossN != null) {
      map['path_loss_n'] = Variable<double>(pathLossN);
    }
    if (!nullToAbsent || lastSeenAt != null) {
      map['last_seen_at'] = Variable<DateTime>(lastSeenAt);
    }
    return map;
  }

  DevicesCompanion toCompanion(bool nullToAbsent) {
    return DevicesCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      shortId: Value(shortId),
      role: Value(role),
      name: Value(name),
      hasBarometer: Value(hasBarometer),
      rssiAt1m: rssiAt1m == null && nullToAbsent
          ? const Value.absent()
          : Value(rssiAt1m),
      pathLossN: pathLossN == null && nullToAbsent
          ? const Value.absent()
          : Value(pathLossN),
      lastSeenAt: lastSeenAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSeenAt),
    );
  }

  factory Device.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Device(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      shortId: serializer.fromJson<int>(json['shortId']),
      role: serializer.fromJson<String>(json['role']),
      name: serializer.fromJson<String>(json['name']),
      hasBarometer: serializer.fromJson<bool>(json['hasBarometer']),
      rssiAt1m: serializer.fromJson<double?>(json['rssiAt1m']),
      pathLossN: serializer.fromJson<double?>(json['pathLossN']),
      lastSeenAt: serializer.fromJson<DateTime?>(json['lastSeenAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'shortId': serializer.toJson<int>(shortId),
      'role': serializer.toJson<String>(role),
      'name': serializer.toJson<String>(name),
      'hasBarometer': serializer.toJson<bool>(hasBarometer),
      'rssiAt1m': serializer.toJson<double?>(rssiAt1m),
      'pathLossN': serializer.toJson<double?>(pathLossN),
      'lastSeenAt': serializer.toJson<DateTime?>(lastSeenAt),
    };
  }

  Device copyWith({
    String? id,
    String? sessionId,
    int? shortId,
    String? role,
    String? name,
    bool? hasBarometer,
    Value<double?> rssiAt1m = const Value.absent(),
    Value<double?> pathLossN = const Value.absent(),
    Value<DateTime?> lastSeenAt = const Value.absent(),
  }) => Device(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    shortId: shortId ?? this.shortId,
    role: role ?? this.role,
    name: name ?? this.name,
    hasBarometer: hasBarometer ?? this.hasBarometer,
    rssiAt1m: rssiAt1m.present ? rssiAt1m.value : this.rssiAt1m,
    pathLossN: pathLossN.present ? pathLossN.value : this.pathLossN,
    lastSeenAt: lastSeenAt.present ? lastSeenAt.value : this.lastSeenAt,
  );
  Device copyWithCompanion(DevicesCompanion data) {
    return Device(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      shortId: data.shortId.present ? data.shortId.value : this.shortId,
      role: data.role.present ? data.role.value : this.role,
      name: data.name.present ? data.name.value : this.name,
      hasBarometer: data.hasBarometer.present
          ? data.hasBarometer.value
          : this.hasBarometer,
      rssiAt1m: data.rssiAt1m.present ? data.rssiAt1m.value : this.rssiAt1m,
      pathLossN: data.pathLossN.present ? data.pathLossN.value : this.pathLossN,
      lastSeenAt: data.lastSeenAt.present
          ? data.lastSeenAt.value
          : this.lastSeenAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Device(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('shortId: $shortId, ')
          ..write('role: $role, ')
          ..write('name: $name, ')
          ..write('hasBarometer: $hasBarometer, ')
          ..write('rssiAt1m: $rssiAt1m, ')
          ..write('pathLossN: $pathLossN, ')
          ..write('lastSeenAt: $lastSeenAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionId,
    shortId,
    role,
    name,
    hasBarometer,
    rssiAt1m,
    pathLossN,
    lastSeenAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Device &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.shortId == this.shortId &&
          other.role == this.role &&
          other.name == this.name &&
          other.hasBarometer == this.hasBarometer &&
          other.rssiAt1m == this.rssiAt1m &&
          other.pathLossN == this.pathLossN &&
          other.lastSeenAt == this.lastSeenAt);
}

class DevicesCompanion extends UpdateCompanion<Device> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<int> shortId;
  final Value<String> role;
  final Value<String> name;
  final Value<bool> hasBarometer;
  final Value<double?> rssiAt1m;
  final Value<double?> pathLossN;
  final Value<DateTime?> lastSeenAt;
  final Value<int> rowid;
  const DevicesCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.shortId = const Value.absent(),
    this.role = const Value.absent(),
    this.name = const Value.absent(),
    this.hasBarometer = const Value.absent(),
    this.rssiAt1m = const Value.absent(),
    this.pathLossN = const Value.absent(),
    this.lastSeenAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DevicesCompanion.insert({
    required String id,
    required String sessionId,
    required int shortId,
    required String role,
    required String name,
    this.hasBarometer = const Value.absent(),
    this.rssiAt1m = const Value.absent(),
    this.pathLossN = const Value.absent(),
    this.lastSeenAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sessionId = Value(sessionId),
       shortId = Value(shortId),
       role = Value(role),
       name = Value(name);
  static Insertable<Device> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<int>? shortId,
    Expression<String>? role,
    Expression<String>? name,
    Expression<bool>? hasBarometer,
    Expression<double>? rssiAt1m,
    Expression<double>? pathLossN,
    Expression<DateTime>? lastSeenAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (shortId != null) 'short_id': shortId,
      if (role != null) 'role': role,
      if (name != null) 'name': name,
      if (hasBarometer != null) 'has_barometer': hasBarometer,
      if (rssiAt1m != null) 'rssi_at1m': rssiAt1m,
      if (pathLossN != null) 'path_loss_n': pathLossN,
      if (lastSeenAt != null) 'last_seen_at': lastSeenAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DevicesCompanion copyWith({
    Value<String>? id,
    Value<String>? sessionId,
    Value<int>? shortId,
    Value<String>? role,
    Value<String>? name,
    Value<bool>? hasBarometer,
    Value<double?>? rssiAt1m,
    Value<double?>? pathLossN,
    Value<DateTime?>? lastSeenAt,
    Value<int>? rowid,
  }) {
    return DevicesCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      shortId: shortId ?? this.shortId,
      role: role ?? this.role,
      name: name ?? this.name,
      hasBarometer: hasBarometer ?? this.hasBarometer,
      rssiAt1m: rssiAt1m ?? this.rssiAt1m,
      pathLossN: pathLossN ?? this.pathLossN,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (shortId.present) {
      map['short_id'] = Variable<int>(shortId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (hasBarometer.present) {
      map['has_barometer'] = Variable<bool>(hasBarometer.value);
    }
    if (rssiAt1m.present) {
      map['rssi_at1m'] = Variable<double>(rssiAt1m.value);
    }
    if (pathLossN.present) {
      map['path_loss_n'] = Variable<double>(pathLossN.value);
    }
    if (lastSeenAt.present) {
      map['last_seen_at'] = Variable<DateTime>(lastSeenAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DevicesCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('shortId: $shortId, ')
          ..write('role: $role, ')
          ..write('name: $name, ')
          ..write('hasBarometer: $hasBarometer, ')
          ..write('rssiAt1m: $rssiAt1m, ')
          ..write('pathLossN: $pathLossN, ')
          ..write('lastSeenAt: $lastSeenAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EpochsTable extends Epochs with TableInfo<$EpochsTable, Epoch> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EpochsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _indexMeta = const VerificationMeta('index');
  @override
  late final GeneratedColumn<int> index = GeneratedColumn<int>(
    'index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    index,
    startedAt,
    endedAt,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'epochs';
  @override
  VerificationContext validateIntegrity(
    Insertable<Epoch> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('index')) {
      context.handle(
        _indexMeta,
        index.isAcceptableOrUnknown(data['index']!, _indexMeta),
      );
    } else if (isInserting) {
      context.missing(_indexMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Epoch map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Epoch(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      index: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}index'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $EpochsTable createAlias(String alias) {
    return $EpochsTable(attachedDatabase, alias);
  }
}

class Epoch extends DataClass implements Insertable<Epoch> {
  final String id;
  final String sessionId;
  final int index;
  final DateTime startedAt;
  final DateTime? endedAt;
  final String status;
  const Epoch({
    required this.id,
    required this.sessionId,
    required this.index,
    required this.startedAt,
    this.endedAt,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['index'] = Variable<int>(index);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    map['status'] = Variable<String>(status);
    return map;
  }

  EpochsCompanion toCompanion(bool nullToAbsent) {
    return EpochsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      index: Value(index),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      status: Value(status),
    );
  }

  factory Epoch.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Epoch(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      index: serializer.fromJson<int>(json['index']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'index': serializer.toJson<int>(index),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
      'status': serializer.toJson<String>(status),
    };
  }

  Epoch copyWith({
    String? id,
    String? sessionId,
    int? index,
    DateTime? startedAt,
    Value<DateTime?> endedAt = const Value.absent(),
    String? status,
  }) => Epoch(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    index: index ?? this.index,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
    status: status ?? this.status,
  );
  Epoch copyWithCompanion(EpochsCompanion data) {
    return Epoch(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      index: data.index.present ? data.index.value : this.index,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Epoch(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('index: $index, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, sessionId, index, startedAt, endedAt, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Epoch &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.index == this.index &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.status == this.status);
}

class EpochsCompanion extends UpdateCompanion<Epoch> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<int> index;
  final Value<DateTime> startedAt;
  final Value<DateTime?> endedAt;
  final Value<String> status;
  final Value<int> rowid;
  const EpochsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.index = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EpochsCompanion.insert({
    required String id,
    required String sessionId,
    required int index,
    required DateTime startedAt,
    this.endedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sessionId = Value(sessionId),
       index = Value(index),
       startedAt = Value(startedAt);
  static Insertable<Epoch> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<int>? index,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (index != null) 'index': index,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EpochsCompanion copyWith({
    Value<String>? id,
    Value<String>? sessionId,
    Value<int>? index,
    Value<DateTime>? startedAt,
    Value<DateTime?>? endedAt,
    Value<String>? status,
    Value<int>? rowid,
  }) {
    return EpochsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      index: index ?? this.index,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (index.present) {
      map['index'] = Variable<int>(index.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EpochsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('index: $index, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GnssObservationsTable extends GnssObservations
    with TableInfo<$GnssObservationsTable, GnssObservation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GnssObservationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _epochIdMeta = const VerificationMeta(
    'epochId',
  );
  @override
  late final GeneratedColumn<String> epochId = GeneratedColumn<String>(
    'epoch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double> lat = GeneratedColumn<double>(
    'lat',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lonMeta = const VerificationMeta('lon');
  @override
  late final GeneratedColumn<double> lon = GeneratedColumn<double>(
    'lon',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ellipHMeta = const VerificationMeta('ellipH');
  @override
  late final GeneratedColumn<double> ellipH = GeneratedColumn<double>(
    'ellip_h',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accuracyHMeta = const VerificationMeta(
    'accuracyH',
  );
  @override
  late final GeneratedColumn<double> accuracyH = GeneratedColumn<double>(
    'accuracy_h',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accuracyVMeta = const VerificationMeta(
    'accuracyV',
  );
  @override
  late final GeneratedColumn<double> accuracyV = GeneratedColumn<double>(
    'accuracy_v',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _satellitesMeta = const VerificationMeta(
    'satellites',
  );
  @override
  late final GeneratedColumn<int> satellites = GeneratedColumn<int>(
    'satellites',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sampleCountMeta = const VerificationMeta(
    'sampleCount',
  );
  @override
  late final GeneratedColumn<int> sampleCount = GeneratedColumn<int>(
    'sample_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stdLatMeta = const VerificationMeta('stdLat');
  @override
  late final GeneratedColumn<double> stdLat = GeneratedColumn<double>(
    'std_lat',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stdLonMeta = const VerificationMeta('stdLon');
  @override
  late final GeneratedColumn<double> stdLon = GeneratedColumn<double>(
    'std_lon',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stdAltMeta = const VerificationMeta('stdAlt');
  @override
  late final GeneratedColumn<double> stdAlt = GeneratedColumn<double>(
    'std_alt',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    epochId,
    deviceId,
    lat,
    lon,
    ellipH,
    accuracyH,
    accuracyV,
    satellites,
    sampleCount,
    stdLat,
    stdLon,
    stdAlt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gnss_observations';
  @override
  VerificationContext validateIntegrity(
    Insertable<GnssObservation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('epoch_id')) {
      context.handle(
        _epochIdMeta,
        epochId.isAcceptableOrUnknown(data['epoch_id']!, _epochIdMeta),
      );
    } else if (isInserting) {
      context.missing(_epochIdMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('lat')) {
      context.handle(
        _latMeta,
        lat.isAcceptableOrUnknown(data['lat']!, _latMeta),
      );
    } else if (isInserting) {
      context.missing(_latMeta);
    }
    if (data.containsKey('lon')) {
      context.handle(
        _lonMeta,
        lon.isAcceptableOrUnknown(data['lon']!, _lonMeta),
      );
    } else if (isInserting) {
      context.missing(_lonMeta);
    }
    if (data.containsKey('ellip_h')) {
      context.handle(
        _ellipHMeta,
        ellipH.isAcceptableOrUnknown(data['ellip_h']!, _ellipHMeta),
      );
    } else if (isInserting) {
      context.missing(_ellipHMeta);
    }
    if (data.containsKey('accuracy_h')) {
      context.handle(
        _accuracyHMeta,
        accuracyH.isAcceptableOrUnknown(data['accuracy_h']!, _accuracyHMeta),
      );
    } else if (isInserting) {
      context.missing(_accuracyHMeta);
    }
    if (data.containsKey('accuracy_v')) {
      context.handle(
        _accuracyVMeta,
        accuracyV.isAcceptableOrUnknown(data['accuracy_v']!, _accuracyVMeta),
      );
    }
    if (data.containsKey('satellites')) {
      context.handle(
        _satellitesMeta,
        satellites.isAcceptableOrUnknown(data['satellites']!, _satellitesMeta),
      );
    }
    if (data.containsKey('sample_count')) {
      context.handle(
        _sampleCountMeta,
        sampleCount.isAcceptableOrUnknown(
          data['sample_count']!,
          _sampleCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sampleCountMeta);
    }
    if (data.containsKey('std_lat')) {
      context.handle(
        _stdLatMeta,
        stdLat.isAcceptableOrUnknown(data['std_lat']!, _stdLatMeta),
      );
    } else if (isInserting) {
      context.missing(_stdLatMeta);
    }
    if (data.containsKey('std_lon')) {
      context.handle(
        _stdLonMeta,
        stdLon.isAcceptableOrUnknown(data['std_lon']!, _stdLonMeta),
      );
    } else if (isInserting) {
      context.missing(_stdLonMeta);
    }
    if (data.containsKey('std_alt')) {
      context.handle(
        _stdAltMeta,
        stdAlt.isAcceptableOrUnknown(data['std_alt']!, _stdAltMeta),
      );
    } else if (isInserting) {
      context.missing(_stdAltMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GnssObservation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GnssObservation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      epochId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}epoch_id'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      lat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lat'],
      )!,
      lon: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lon'],
      )!,
      ellipH: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ellip_h'],
      )!,
      accuracyH: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}accuracy_h'],
      )!,
      accuracyV: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}accuracy_v'],
      ),
      satellites: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}satellites'],
      ),
      sampleCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sample_count'],
      )!,
      stdLat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}std_lat'],
      )!,
      stdLon: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}std_lon'],
      )!,
      stdAlt: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}std_alt'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $GnssObservationsTable createAlias(String alias) {
    return $GnssObservationsTable(attachedDatabase, alias);
  }
}

class GnssObservation extends DataClass implements Insertable<GnssObservation> {
  final String id;
  final String epochId;
  final String deviceId;
  final double lat;
  final double lon;
  final double ellipH;
  final double accuracyH;
  final double? accuracyV;
  final int? satellites;
  final int sampleCount;
  final double stdLat;
  final double stdLon;
  final double stdAlt;
  final DateTime createdAt;
  const GnssObservation({
    required this.id,
    required this.epochId,
    required this.deviceId,
    required this.lat,
    required this.lon,
    required this.ellipH,
    required this.accuracyH,
    this.accuracyV,
    this.satellites,
    required this.sampleCount,
    required this.stdLat,
    required this.stdLon,
    required this.stdAlt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['epoch_id'] = Variable<String>(epochId);
    map['device_id'] = Variable<String>(deviceId);
    map['lat'] = Variable<double>(lat);
    map['lon'] = Variable<double>(lon);
    map['ellip_h'] = Variable<double>(ellipH);
    map['accuracy_h'] = Variable<double>(accuracyH);
    if (!nullToAbsent || accuracyV != null) {
      map['accuracy_v'] = Variable<double>(accuracyV);
    }
    if (!nullToAbsent || satellites != null) {
      map['satellites'] = Variable<int>(satellites);
    }
    map['sample_count'] = Variable<int>(sampleCount);
    map['std_lat'] = Variable<double>(stdLat);
    map['std_lon'] = Variable<double>(stdLon);
    map['std_alt'] = Variable<double>(stdAlt);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  GnssObservationsCompanion toCompanion(bool nullToAbsent) {
    return GnssObservationsCompanion(
      id: Value(id),
      epochId: Value(epochId),
      deviceId: Value(deviceId),
      lat: Value(lat),
      lon: Value(lon),
      ellipH: Value(ellipH),
      accuracyH: Value(accuracyH),
      accuracyV: accuracyV == null && nullToAbsent
          ? const Value.absent()
          : Value(accuracyV),
      satellites: satellites == null && nullToAbsent
          ? const Value.absent()
          : Value(satellites),
      sampleCount: Value(sampleCount),
      stdLat: Value(stdLat),
      stdLon: Value(stdLon),
      stdAlt: Value(stdAlt),
      createdAt: Value(createdAt),
    );
  }

  factory GnssObservation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GnssObservation(
      id: serializer.fromJson<String>(json['id']),
      epochId: serializer.fromJson<String>(json['epochId']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      lat: serializer.fromJson<double>(json['lat']),
      lon: serializer.fromJson<double>(json['lon']),
      ellipH: serializer.fromJson<double>(json['ellipH']),
      accuracyH: serializer.fromJson<double>(json['accuracyH']),
      accuracyV: serializer.fromJson<double?>(json['accuracyV']),
      satellites: serializer.fromJson<int?>(json['satellites']),
      sampleCount: serializer.fromJson<int>(json['sampleCount']),
      stdLat: serializer.fromJson<double>(json['stdLat']),
      stdLon: serializer.fromJson<double>(json['stdLon']),
      stdAlt: serializer.fromJson<double>(json['stdAlt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'epochId': serializer.toJson<String>(epochId),
      'deviceId': serializer.toJson<String>(deviceId),
      'lat': serializer.toJson<double>(lat),
      'lon': serializer.toJson<double>(lon),
      'ellipH': serializer.toJson<double>(ellipH),
      'accuracyH': serializer.toJson<double>(accuracyH),
      'accuracyV': serializer.toJson<double?>(accuracyV),
      'satellites': serializer.toJson<int?>(satellites),
      'sampleCount': serializer.toJson<int>(sampleCount),
      'stdLat': serializer.toJson<double>(stdLat),
      'stdLon': serializer.toJson<double>(stdLon),
      'stdAlt': serializer.toJson<double>(stdAlt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  GnssObservation copyWith({
    String? id,
    String? epochId,
    String? deviceId,
    double? lat,
    double? lon,
    double? ellipH,
    double? accuracyH,
    Value<double?> accuracyV = const Value.absent(),
    Value<int?> satellites = const Value.absent(),
    int? sampleCount,
    double? stdLat,
    double? stdLon,
    double? stdAlt,
    DateTime? createdAt,
  }) => GnssObservation(
    id: id ?? this.id,
    epochId: epochId ?? this.epochId,
    deviceId: deviceId ?? this.deviceId,
    lat: lat ?? this.lat,
    lon: lon ?? this.lon,
    ellipH: ellipH ?? this.ellipH,
    accuracyH: accuracyH ?? this.accuracyH,
    accuracyV: accuracyV.present ? accuracyV.value : this.accuracyV,
    satellites: satellites.present ? satellites.value : this.satellites,
    sampleCount: sampleCount ?? this.sampleCount,
    stdLat: stdLat ?? this.stdLat,
    stdLon: stdLon ?? this.stdLon,
    stdAlt: stdAlt ?? this.stdAlt,
    createdAt: createdAt ?? this.createdAt,
  );
  GnssObservation copyWithCompanion(GnssObservationsCompanion data) {
    return GnssObservation(
      id: data.id.present ? data.id.value : this.id,
      epochId: data.epochId.present ? data.epochId.value : this.epochId,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      lat: data.lat.present ? data.lat.value : this.lat,
      lon: data.lon.present ? data.lon.value : this.lon,
      ellipH: data.ellipH.present ? data.ellipH.value : this.ellipH,
      accuracyH: data.accuracyH.present ? data.accuracyH.value : this.accuracyH,
      accuracyV: data.accuracyV.present ? data.accuracyV.value : this.accuracyV,
      satellites: data.satellites.present
          ? data.satellites.value
          : this.satellites,
      sampleCount: data.sampleCount.present
          ? data.sampleCount.value
          : this.sampleCount,
      stdLat: data.stdLat.present ? data.stdLat.value : this.stdLat,
      stdLon: data.stdLon.present ? data.stdLon.value : this.stdLon,
      stdAlt: data.stdAlt.present ? data.stdAlt.value : this.stdAlt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GnssObservation(')
          ..write('id: $id, ')
          ..write('epochId: $epochId, ')
          ..write('deviceId: $deviceId, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('ellipH: $ellipH, ')
          ..write('accuracyH: $accuracyH, ')
          ..write('accuracyV: $accuracyV, ')
          ..write('satellites: $satellites, ')
          ..write('sampleCount: $sampleCount, ')
          ..write('stdLat: $stdLat, ')
          ..write('stdLon: $stdLon, ')
          ..write('stdAlt: $stdAlt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    epochId,
    deviceId,
    lat,
    lon,
    ellipH,
    accuracyH,
    accuracyV,
    satellites,
    sampleCount,
    stdLat,
    stdLon,
    stdAlt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GnssObservation &&
          other.id == this.id &&
          other.epochId == this.epochId &&
          other.deviceId == this.deviceId &&
          other.lat == this.lat &&
          other.lon == this.lon &&
          other.ellipH == this.ellipH &&
          other.accuracyH == this.accuracyH &&
          other.accuracyV == this.accuracyV &&
          other.satellites == this.satellites &&
          other.sampleCount == this.sampleCount &&
          other.stdLat == this.stdLat &&
          other.stdLon == this.stdLon &&
          other.stdAlt == this.stdAlt &&
          other.createdAt == this.createdAt);
}

class GnssObservationsCompanion extends UpdateCompanion<GnssObservation> {
  final Value<String> id;
  final Value<String> epochId;
  final Value<String> deviceId;
  final Value<double> lat;
  final Value<double> lon;
  final Value<double> ellipH;
  final Value<double> accuracyH;
  final Value<double?> accuracyV;
  final Value<int?> satellites;
  final Value<int> sampleCount;
  final Value<double> stdLat;
  final Value<double> stdLon;
  final Value<double> stdAlt;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const GnssObservationsCompanion({
    this.id = const Value.absent(),
    this.epochId = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.lat = const Value.absent(),
    this.lon = const Value.absent(),
    this.ellipH = const Value.absent(),
    this.accuracyH = const Value.absent(),
    this.accuracyV = const Value.absent(),
    this.satellites = const Value.absent(),
    this.sampleCount = const Value.absent(),
    this.stdLat = const Value.absent(),
    this.stdLon = const Value.absent(),
    this.stdAlt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GnssObservationsCompanion.insert({
    required String id,
    required String epochId,
    required String deviceId,
    required double lat,
    required double lon,
    required double ellipH,
    required double accuracyH,
    this.accuracyV = const Value.absent(),
    this.satellites = const Value.absent(),
    required int sampleCount,
    required double stdLat,
    required double stdLon,
    required double stdAlt,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       epochId = Value(epochId),
       deviceId = Value(deviceId),
       lat = Value(lat),
       lon = Value(lon),
       ellipH = Value(ellipH),
       accuracyH = Value(accuracyH),
       sampleCount = Value(sampleCount),
       stdLat = Value(stdLat),
       stdLon = Value(stdLon),
       stdAlt = Value(stdAlt),
       createdAt = Value(createdAt);
  static Insertable<GnssObservation> custom({
    Expression<String>? id,
    Expression<String>? epochId,
    Expression<String>? deviceId,
    Expression<double>? lat,
    Expression<double>? lon,
    Expression<double>? ellipH,
    Expression<double>? accuracyH,
    Expression<double>? accuracyV,
    Expression<int>? satellites,
    Expression<int>? sampleCount,
    Expression<double>? stdLat,
    Expression<double>? stdLon,
    Expression<double>? stdAlt,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (epochId != null) 'epoch_id': epochId,
      if (deviceId != null) 'device_id': deviceId,
      if (lat != null) 'lat': lat,
      if (lon != null) 'lon': lon,
      if (ellipH != null) 'ellip_h': ellipH,
      if (accuracyH != null) 'accuracy_h': accuracyH,
      if (accuracyV != null) 'accuracy_v': accuracyV,
      if (satellites != null) 'satellites': satellites,
      if (sampleCount != null) 'sample_count': sampleCount,
      if (stdLat != null) 'std_lat': stdLat,
      if (stdLon != null) 'std_lon': stdLon,
      if (stdAlt != null) 'std_alt': stdAlt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GnssObservationsCompanion copyWith({
    Value<String>? id,
    Value<String>? epochId,
    Value<String>? deviceId,
    Value<double>? lat,
    Value<double>? lon,
    Value<double>? ellipH,
    Value<double>? accuracyH,
    Value<double?>? accuracyV,
    Value<int?>? satellites,
    Value<int>? sampleCount,
    Value<double>? stdLat,
    Value<double>? stdLon,
    Value<double>? stdAlt,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return GnssObservationsCompanion(
      id: id ?? this.id,
      epochId: epochId ?? this.epochId,
      deviceId: deviceId ?? this.deviceId,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      ellipH: ellipH ?? this.ellipH,
      accuracyH: accuracyH ?? this.accuracyH,
      accuracyV: accuracyV ?? this.accuracyV,
      satellites: satellites ?? this.satellites,
      sampleCount: sampleCount ?? this.sampleCount,
      stdLat: stdLat ?? this.stdLat,
      stdLon: stdLon ?? this.stdLon,
      stdAlt: stdAlt ?? this.stdAlt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (epochId.present) {
      map['epoch_id'] = Variable<String>(epochId.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lon.present) {
      map['lon'] = Variable<double>(lon.value);
    }
    if (ellipH.present) {
      map['ellip_h'] = Variable<double>(ellipH.value);
    }
    if (accuracyH.present) {
      map['accuracy_h'] = Variable<double>(accuracyH.value);
    }
    if (accuracyV.present) {
      map['accuracy_v'] = Variable<double>(accuracyV.value);
    }
    if (satellites.present) {
      map['satellites'] = Variable<int>(satellites.value);
    }
    if (sampleCount.present) {
      map['sample_count'] = Variable<int>(sampleCount.value);
    }
    if (stdLat.present) {
      map['std_lat'] = Variable<double>(stdLat.value);
    }
    if (stdLon.present) {
      map['std_lon'] = Variable<double>(stdLon.value);
    }
    if (stdAlt.present) {
      map['std_alt'] = Variable<double>(stdAlt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GnssObservationsCompanion(')
          ..write('id: $id, ')
          ..write('epochId: $epochId, ')
          ..write('deviceId: $deviceId, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('ellipH: $ellipH, ')
          ..write('accuracyH: $accuracyH, ')
          ..write('accuracyV: $accuracyV, ')
          ..write('satellites: $satellites, ')
          ..write('sampleCount: $sampleCount, ')
          ..write('stdLat: $stdLat, ')
          ..write('stdLon: $stdLon, ')
          ..write('stdAlt: $stdAlt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BaroObservationsTable extends BaroObservations
    with TableInfo<$BaroObservationsTable, BaroObservation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BaroObservationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _epochIdMeta = const VerificationMeta(
    'epochId',
  );
  @override
  late final GeneratedColumn<String> epochId = GeneratedColumn<String>(
    'epoch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pressureHpaMeta = const VerificationMeta(
    'pressureHpa',
  );
  @override
  late final GeneratedColumn<double> pressureHpa = GeneratedColumn<double>(
    'pressure_hpa',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _relativeHeightMMeta = const VerificationMeta(
    'relativeHeightM',
  );
  @override
  late final GeneratedColumn<double> relativeHeightM = GeneratedColumn<double>(
    'relative_height_m',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _basePressureHpaMeta = const VerificationMeta(
    'basePressureHpa',
  );
  @override
  late final GeneratedColumn<double> basePressureHpa = GeneratedColumn<double>(
    'base_pressure_hpa',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    epochId,
    deviceId,
    pressureHpa,
    relativeHeightM,
    basePressureHpa,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'baro_observations';
  @override
  VerificationContext validateIntegrity(
    Insertable<BaroObservation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('epoch_id')) {
      context.handle(
        _epochIdMeta,
        epochId.isAcceptableOrUnknown(data['epoch_id']!, _epochIdMeta),
      );
    } else if (isInserting) {
      context.missing(_epochIdMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('pressure_hpa')) {
      context.handle(
        _pressureHpaMeta,
        pressureHpa.isAcceptableOrUnknown(
          data['pressure_hpa']!,
          _pressureHpaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pressureHpaMeta);
    }
    if (data.containsKey('relative_height_m')) {
      context.handle(
        _relativeHeightMMeta,
        relativeHeightM.isAcceptableOrUnknown(
          data['relative_height_m']!,
          _relativeHeightMMeta,
        ),
      );
    }
    if (data.containsKey('base_pressure_hpa')) {
      context.handle(
        _basePressureHpaMeta,
        basePressureHpa.isAcceptableOrUnknown(
          data['base_pressure_hpa']!,
          _basePressureHpaMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BaroObservation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BaroObservation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      epochId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}epoch_id'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      pressureHpa: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pressure_hpa'],
      )!,
      relativeHeightM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}relative_height_m'],
      ),
      basePressureHpa: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}base_pressure_hpa'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $BaroObservationsTable createAlias(String alias) {
    return $BaroObservationsTable(attachedDatabase, alias);
  }
}

class BaroObservation extends DataClass implements Insertable<BaroObservation> {
  final String id;
  final String epochId;
  final String deviceId;
  final double pressureHpa;
  final double? relativeHeightM;
  final double? basePressureHpa;
  final DateTime createdAt;
  const BaroObservation({
    required this.id,
    required this.epochId,
    required this.deviceId,
    required this.pressureHpa,
    this.relativeHeightM,
    this.basePressureHpa,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['epoch_id'] = Variable<String>(epochId);
    map['device_id'] = Variable<String>(deviceId);
    map['pressure_hpa'] = Variable<double>(pressureHpa);
    if (!nullToAbsent || relativeHeightM != null) {
      map['relative_height_m'] = Variable<double>(relativeHeightM);
    }
    if (!nullToAbsent || basePressureHpa != null) {
      map['base_pressure_hpa'] = Variable<double>(basePressureHpa);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BaroObservationsCompanion toCompanion(bool nullToAbsent) {
    return BaroObservationsCompanion(
      id: Value(id),
      epochId: Value(epochId),
      deviceId: Value(deviceId),
      pressureHpa: Value(pressureHpa),
      relativeHeightM: relativeHeightM == null && nullToAbsent
          ? const Value.absent()
          : Value(relativeHeightM),
      basePressureHpa: basePressureHpa == null && nullToAbsent
          ? const Value.absent()
          : Value(basePressureHpa),
      createdAt: Value(createdAt),
    );
  }

  factory BaroObservation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BaroObservation(
      id: serializer.fromJson<String>(json['id']),
      epochId: serializer.fromJson<String>(json['epochId']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      pressureHpa: serializer.fromJson<double>(json['pressureHpa']),
      relativeHeightM: serializer.fromJson<double?>(json['relativeHeightM']),
      basePressureHpa: serializer.fromJson<double?>(json['basePressureHpa']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'epochId': serializer.toJson<String>(epochId),
      'deviceId': serializer.toJson<String>(deviceId),
      'pressureHpa': serializer.toJson<double>(pressureHpa),
      'relativeHeightM': serializer.toJson<double?>(relativeHeightM),
      'basePressureHpa': serializer.toJson<double?>(basePressureHpa),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  BaroObservation copyWith({
    String? id,
    String? epochId,
    String? deviceId,
    double? pressureHpa,
    Value<double?> relativeHeightM = const Value.absent(),
    Value<double?> basePressureHpa = const Value.absent(),
    DateTime? createdAt,
  }) => BaroObservation(
    id: id ?? this.id,
    epochId: epochId ?? this.epochId,
    deviceId: deviceId ?? this.deviceId,
    pressureHpa: pressureHpa ?? this.pressureHpa,
    relativeHeightM: relativeHeightM.present
        ? relativeHeightM.value
        : this.relativeHeightM,
    basePressureHpa: basePressureHpa.present
        ? basePressureHpa.value
        : this.basePressureHpa,
    createdAt: createdAt ?? this.createdAt,
  );
  BaroObservation copyWithCompanion(BaroObservationsCompanion data) {
    return BaroObservation(
      id: data.id.present ? data.id.value : this.id,
      epochId: data.epochId.present ? data.epochId.value : this.epochId,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      pressureHpa: data.pressureHpa.present
          ? data.pressureHpa.value
          : this.pressureHpa,
      relativeHeightM: data.relativeHeightM.present
          ? data.relativeHeightM.value
          : this.relativeHeightM,
      basePressureHpa: data.basePressureHpa.present
          ? data.basePressureHpa.value
          : this.basePressureHpa,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BaroObservation(')
          ..write('id: $id, ')
          ..write('epochId: $epochId, ')
          ..write('deviceId: $deviceId, ')
          ..write('pressureHpa: $pressureHpa, ')
          ..write('relativeHeightM: $relativeHeightM, ')
          ..write('basePressureHpa: $basePressureHpa, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    epochId,
    deviceId,
    pressureHpa,
    relativeHeightM,
    basePressureHpa,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BaroObservation &&
          other.id == this.id &&
          other.epochId == this.epochId &&
          other.deviceId == this.deviceId &&
          other.pressureHpa == this.pressureHpa &&
          other.relativeHeightM == this.relativeHeightM &&
          other.basePressureHpa == this.basePressureHpa &&
          other.createdAt == this.createdAt);
}

class BaroObservationsCompanion extends UpdateCompanion<BaroObservation> {
  final Value<String> id;
  final Value<String> epochId;
  final Value<String> deviceId;
  final Value<double> pressureHpa;
  final Value<double?> relativeHeightM;
  final Value<double?> basePressureHpa;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const BaroObservationsCompanion({
    this.id = const Value.absent(),
    this.epochId = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.pressureHpa = const Value.absent(),
    this.relativeHeightM = const Value.absent(),
    this.basePressureHpa = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BaroObservationsCompanion.insert({
    required String id,
    required String epochId,
    required String deviceId,
    required double pressureHpa,
    this.relativeHeightM = const Value.absent(),
    this.basePressureHpa = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       epochId = Value(epochId),
       deviceId = Value(deviceId),
       pressureHpa = Value(pressureHpa),
       createdAt = Value(createdAt);
  static Insertable<BaroObservation> custom({
    Expression<String>? id,
    Expression<String>? epochId,
    Expression<String>? deviceId,
    Expression<double>? pressureHpa,
    Expression<double>? relativeHeightM,
    Expression<double>? basePressureHpa,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (epochId != null) 'epoch_id': epochId,
      if (deviceId != null) 'device_id': deviceId,
      if (pressureHpa != null) 'pressure_hpa': pressureHpa,
      if (relativeHeightM != null) 'relative_height_m': relativeHeightM,
      if (basePressureHpa != null) 'base_pressure_hpa': basePressureHpa,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BaroObservationsCompanion copyWith({
    Value<String>? id,
    Value<String>? epochId,
    Value<String>? deviceId,
    Value<double>? pressureHpa,
    Value<double?>? relativeHeightM,
    Value<double?>? basePressureHpa,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return BaroObservationsCompanion(
      id: id ?? this.id,
      epochId: epochId ?? this.epochId,
      deviceId: deviceId ?? this.deviceId,
      pressureHpa: pressureHpa ?? this.pressureHpa,
      relativeHeightM: relativeHeightM ?? this.relativeHeightM,
      basePressureHpa: basePressureHpa ?? this.basePressureHpa,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (epochId.present) {
      map['epoch_id'] = Variable<String>(epochId.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (pressureHpa.present) {
      map['pressure_hpa'] = Variable<double>(pressureHpa.value);
    }
    if (relativeHeightM.present) {
      map['relative_height_m'] = Variable<double>(relativeHeightM.value);
    }
    if (basePressureHpa.present) {
      map['base_pressure_hpa'] = Variable<double>(basePressureHpa.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BaroObservationsCompanion(')
          ..write('id: $id, ')
          ..write('epochId: $epochId, ')
          ..write('deviceId: $deviceId, ')
          ..write('pressureHpa: $pressureHpa, ')
          ..write('relativeHeightM: $relativeHeightM, ')
          ..write('basePressureHpa: $basePressureHpa, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BleMeasurementsTable extends BleMeasurements
    with TableInfo<$BleMeasurementsTable, BleMeasurement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BleMeasurementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _epochIdMeta = const VerificationMeta(
    'epochId',
  );
  @override
  late final GeneratedColumn<String> epochId = GeneratedColumn<String>(
    'epoch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _observerDeviceIdMeta = const VerificationMeta(
    'observerDeviceId',
  );
  @override
  late final GeneratedColumn<String> observerDeviceId = GeneratedColumn<String>(
    'observer_device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _peerShortIdMeta = const VerificationMeta(
    'peerShortId',
  );
  @override
  late final GeneratedColumn<int> peerShortId = GeneratedColumn<int>(
    'peer_short_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rssiSamplesJsonMeta = const VerificationMeta(
    'rssiSamplesJson',
  );
  @override
  late final GeneratedColumn<String> rssiSamplesJson = GeneratedColumn<String>(
    'rssi_samples_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rssiFilteredMeta = const VerificationMeta(
    'rssiFiltered',
  );
  @override
  late final GeneratedColumn<double> rssiFiltered = GeneratedColumn<double>(
    'rssi_filtered',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _distanceMMeta = const VerificationMeta(
    'distanceM',
  );
  @override
  late final GeneratedColumn<double> distanceM = GeneratedColumn<double>(
    'distance_m',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _distanceSigmaMeta = const VerificationMeta(
    'distanceSigma',
  );
  @override
  late final GeneratedColumn<double> distanceSigma = GeneratedColumn<double>(
    'distance_sigma',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    epochId,
    observerDeviceId,
    peerShortId,
    rssiSamplesJson,
    rssiFiltered,
    distanceM,
    distanceSigma,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ble_measurements';
  @override
  VerificationContext validateIntegrity(
    Insertable<BleMeasurement> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('epoch_id')) {
      context.handle(
        _epochIdMeta,
        epochId.isAcceptableOrUnknown(data['epoch_id']!, _epochIdMeta),
      );
    } else if (isInserting) {
      context.missing(_epochIdMeta);
    }
    if (data.containsKey('observer_device_id')) {
      context.handle(
        _observerDeviceIdMeta,
        observerDeviceId.isAcceptableOrUnknown(
          data['observer_device_id']!,
          _observerDeviceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_observerDeviceIdMeta);
    }
    if (data.containsKey('peer_short_id')) {
      context.handle(
        _peerShortIdMeta,
        peerShortId.isAcceptableOrUnknown(
          data['peer_short_id']!,
          _peerShortIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_peerShortIdMeta);
    }
    if (data.containsKey('rssi_samples_json')) {
      context.handle(
        _rssiSamplesJsonMeta,
        rssiSamplesJson.isAcceptableOrUnknown(
          data['rssi_samples_json']!,
          _rssiSamplesJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_rssiSamplesJsonMeta);
    }
    if (data.containsKey('rssi_filtered')) {
      context.handle(
        _rssiFilteredMeta,
        rssiFiltered.isAcceptableOrUnknown(
          data['rssi_filtered']!,
          _rssiFilteredMeta,
        ),
      );
    }
    if (data.containsKey('distance_m')) {
      context.handle(
        _distanceMMeta,
        distanceM.isAcceptableOrUnknown(data['distance_m']!, _distanceMMeta),
      );
    }
    if (data.containsKey('distance_sigma')) {
      context.handle(
        _distanceSigmaMeta,
        distanceSigma.isAcceptableOrUnknown(
          data['distance_sigma']!,
          _distanceSigmaMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BleMeasurement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BleMeasurement(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      epochId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}epoch_id'],
      )!,
      observerDeviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}observer_device_id'],
      )!,
      peerShortId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}peer_short_id'],
      )!,
      rssiSamplesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rssi_samples_json'],
      )!,
      rssiFiltered: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rssi_filtered'],
      ),
      distanceM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}distance_m'],
      ),
      distanceSigma: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}distance_sigma'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $BleMeasurementsTable createAlias(String alias) {
    return $BleMeasurementsTable(attachedDatabase, alias);
  }
}

class BleMeasurement extends DataClass implements Insertable<BleMeasurement> {
  final String id;
  final String epochId;
  final String observerDeviceId;
  final int peerShortId;
  final String rssiSamplesJson;
  final double? rssiFiltered;
  final double? distanceM;
  final double? distanceSigma;
  final DateTime createdAt;
  const BleMeasurement({
    required this.id,
    required this.epochId,
    required this.observerDeviceId,
    required this.peerShortId,
    required this.rssiSamplesJson,
    this.rssiFiltered,
    this.distanceM,
    this.distanceSigma,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['epoch_id'] = Variable<String>(epochId);
    map['observer_device_id'] = Variable<String>(observerDeviceId);
    map['peer_short_id'] = Variable<int>(peerShortId);
    map['rssi_samples_json'] = Variable<String>(rssiSamplesJson);
    if (!nullToAbsent || rssiFiltered != null) {
      map['rssi_filtered'] = Variable<double>(rssiFiltered);
    }
    if (!nullToAbsent || distanceM != null) {
      map['distance_m'] = Variable<double>(distanceM);
    }
    if (!nullToAbsent || distanceSigma != null) {
      map['distance_sigma'] = Variable<double>(distanceSigma);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BleMeasurementsCompanion toCompanion(bool nullToAbsent) {
    return BleMeasurementsCompanion(
      id: Value(id),
      epochId: Value(epochId),
      observerDeviceId: Value(observerDeviceId),
      peerShortId: Value(peerShortId),
      rssiSamplesJson: Value(rssiSamplesJson),
      rssiFiltered: rssiFiltered == null && nullToAbsent
          ? const Value.absent()
          : Value(rssiFiltered),
      distanceM: distanceM == null && nullToAbsent
          ? const Value.absent()
          : Value(distanceM),
      distanceSigma: distanceSigma == null && nullToAbsent
          ? const Value.absent()
          : Value(distanceSigma),
      createdAt: Value(createdAt),
    );
  }

  factory BleMeasurement.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BleMeasurement(
      id: serializer.fromJson<String>(json['id']),
      epochId: serializer.fromJson<String>(json['epochId']),
      observerDeviceId: serializer.fromJson<String>(json['observerDeviceId']),
      peerShortId: serializer.fromJson<int>(json['peerShortId']),
      rssiSamplesJson: serializer.fromJson<String>(json['rssiSamplesJson']),
      rssiFiltered: serializer.fromJson<double?>(json['rssiFiltered']),
      distanceM: serializer.fromJson<double?>(json['distanceM']),
      distanceSigma: serializer.fromJson<double?>(json['distanceSigma']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'epochId': serializer.toJson<String>(epochId),
      'observerDeviceId': serializer.toJson<String>(observerDeviceId),
      'peerShortId': serializer.toJson<int>(peerShortId),
      'rssiSamplesJson': serializer.toJson<String>(rssiSamplesJson),
      'rssiFiltered': serializer.toJson<double?>(rssiFiltered),
      'distanceM': serializer.toJson<double?>(distanceM),
      'distanceSigma': serializer.toJson<double?>(distanceSigma),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  BleMeasurement copyWith({
    String? id,
    String? epochId,
    String? observerDeviceId,
    int? peerShortId,
    String? rssiSamplesJson,
    Value<double?> rssiFiltered = const Value.absent(),
    Value<double?> distanceM = const Value.absent(),
    Value<double?> distanceSigma = const Value.absent(),
    DateTime? createdAt,
  }) => BleMeasurement(
    id: id ?? this.id,
    epochId: epochId ?? this.epochId,
    observerDeviceId: observerDeviceId ?? this.observerDeviceId,
    peerShortId: peerShortId ?? this.peerShortId,
    rssiSamplesJson: rssiSamplesJson ?? this.rssiSamplesJson,
    rssiFiltered: rssiFiltered.present ? rssiFiltered.value : this.rssiFiltered,
    distanceM: distanceM.present ? distanceM.value : this.distanceM,
    distanceSigma: distanceSigma.present
        ? distanceSigma.value
        : this.distanceSigma,
    createdAt: createdAt ?? this.createdAt,
  );
  BleMeasurement copyWithCompanion(BleMeasurementsCompanion data) {
    return BleMeasurement(
      id: data.id.present ? data.id.value : this.id,
      epochId: data.epochId.present ? data.epochId.value : this.epochId,
      observerDeviceId: data.observerDeviceId.present
          ? data.observerDeviceId.value
          : this.observerDeviceId,
      peerShortId: data.peerShortId.present
          ? data.peerShortId.value
          : this.peerShortId,
      rssiSamplesJson: data.rssiSamplesJson.present
          ? data.rssiSamplesJson.value
          : this.rssiSamplesJson,
      rssiFiltered: data.rssiFiltered.present
          ? data.rssiFiltered.value
          : this.rssiFiltered,
      distanceM: data.distanceM.present ? data.distanceM.value : this.distanceM,
      distanceSigma: data.distanceSigma.present
          ? data.distanceSigma.value
          : this.distanceSigma,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BleMeasurement(')
          ..write('id: $id, ')
          ..write('epochId: $epochId, ')
          ..write('observerDeviceId: $observerDeviceId, ')
          ..write('peerShortId: $peerShortId, ')
          ..write('rssiSamplesJson: $rssiSamplesJson, ')
          ..write('rssiFiltered: $rssiFiltered, ')
          ..write('distanceM: $distanceM, ')
          ..write('distanceSigma: $distanceSigma, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    epochId,
    observerDeviceId,
    peerShortId,
    rssiSamplesJson,
    rssiFiltered,
    distanceM,
    distanceSigma,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BleMeasurement &&
          other.id == this.id &&
          other.epochId == this.epochId &&
          other.observerDeviceId == this.observerDeviceId &&
          other.peerShortId == this.peerShortId &&
          other.rssiSamplesJson == this.rssiSamplesJson &&
          other.rssiFiltered == this.rssiFiltered &&
          other.distanceM == this.distanceM &&
          other.distanceSigma == this.distanceSigma &&
          other.createdAt == this.createdAt);
}

class BleMeasurementsCompanion extends UpdateCompanion<BleMeasurement> {
  final Value<String> id;
  final Value<String> epochId;
  final Value<String> observerDeviceId;
  final Value<int> peerShortId;
  final Value<String> rssiSamplesJson;
  final Value<double?> rssiFiltered;
  final Value<double?> distanceM;
  final Value<double?> distanceSigma;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const BleMeasurementsCompanion({
    this.id = const Value.absent(),
    this.epochId = const Value.absent(),
    this.observerDeviceId = const Value.absent(),
    this.peerShortId = const Value.absent(),
    this.rssiSamplesJson = const Value.absent(),
    this.rssiFiltered = const Value.absent(),
    this.distanceM = const Value.absent(),
    this.distanceSigma = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BleMeasurementsCompanion.insert({
    required String id,
    required String epochId,
    required String observerDeviceId,
    required int peerShortId,
    required String rssiSamplesJson,
    this.rssiFiltered = const Value.absent(),
    this.distanceM = const Value.absent(),
    this.distanceSigma = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       epochId = Value(epochId),
       observerDeviceId = Value(observerDeviceId),
       peerShortId = Value(peerShortId),
       rssiSamplesJson = Value(rssiSamplesJson),
       createdAt = Value(createdAt);
  static Insertable<BleMeasurement> custom({
    Expression<String>? id,
    Expression<String>? epochId,
    Expression<String>? observerDeviceId,
    Expression<int>? peerShortId,
    Expression<String>? rssiSamplesJson,
    Expression<double>? rssiFiltered,
    Expression<double>? distanceM,
    Expression<double>? distanceSigma,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (epochId != null) 'epoch_id': epochId,
      if (observerDeviceId != null) 'observer_device_id': observerDeviceId,
      if (peerShortId != null) 'peer_short_id': peerShortId,
      if (rssiSamplesJson != null) 'rssi_samples_json': rssiSamplesJson,
      if (rssiFiltered != null) 'rssi_filtered': rssiFiltered,
      if (distanceM != null) 'distance_m': distanceM,
      if (distanceSigma != null) 'distance_sigma': distanceSigma,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BleMeasurementsCompanion copyWith({
    Value<String>? id,
    Value<String>? epochId,
    Value<String>? observerDeviceId,
    Value<int>? peerShortId,
    Value<String>? rssiSamplesJson,
    Value<double?>? rssiFiltered,
    Value<double?>? distanceM,
    Value<double?>? distanceSigma,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return BleMeasurementsCompanion(
      id: id ?? this.id,
      epochId: epochId ?? this.epochId,
      observerDeviceId: observerDeviceId ?? this.observerDeviceId,
      peerShortId: peerShortId ?? this.peerShortId,
      rssiSamplesJson: rssiSamplesJson ?? this.rssiSamplesJson,
      rssiFiltered: rssiFiltered ?? this.rssiFiltered,
      distanceM: distanceM ?? this.distanceM,
      distanceSigma: distanceSigma ?? this.distanceSigma,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (epochId.present) {
      map['epoch_id'] = Variable<String>(epochId.value);
    }
    if (observerDeviceId.present) {
      map['observer_device_id'] = Variable<String>(observerDeviceId.value);
    }
    if (peerShortId.present) {
      map['peer_short_id'] = Variable<int>(peerShortId.value);
    }
    if (rssiSamplesJson.present) {
      map['rssi_samples_json'] = Variable<String>(rssiSamplesJson.value);
    }
    if (rssiFiltered.present) {
      map['rssi_filtered'] = Variable<double>(rssiFiltered.value);
    }
    if (distanceM.present) {
      map['distance_m'] = Variable<double>(distanceM.value);
    }
    if (distanceSigma.present) {
      map['distance_sigma'] = Variable<double>(distanceSigma.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BleMeasurementsCompanion(')
          ..write('id: $id, ')
          ..write('epochId: $epochId, ')
          ..write('observerDeviceId: $observerDeviceId, ')
          ..write('peerShortId: $peerShortId, ')
          ..write('rssiSamplesJson: $rssiSamplesJson, ')
          ..write('rssiFiltered: $rssiFiltered, ')
          ..write('distanceM: $distanceM, ')
          ..write('distanceSigma: $distanceSigma, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AnchorsTable extends Anchors with TableInfo<$AnchorsTable, Anchor> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AnchorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double> lat = GeneratedColumn<double>(
    'lat',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lonMeta = const VerificationMeta('lon');
  @override
  late final GeneratedColumn<double> lon = GeneratedColumn<double>(
    'lon',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ellipHMeta = const VerificationMeta('ellipH');
  @override
  late final GeneratedColumn<double> ellipH = GeneratedColumn<double>(
    'ellip_h',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orthoHMeta = const VerificationMeta('orthoH');
  @override
  late final GeneratedColumn<double> orthoH = GeneratedColumn<double>(
    'ortho_h',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accuracyHMeta = const VerificationMeta(
    'accuracyH',
  );
  @override
  late final GeneratedColumn<double> accuracyH = GeneratedColumn<double>(
    'accuracy_h',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accuracyVMeta = const VerificationMeta(
    'accuracyV',
  );
  @override
  late final GeneratedColumn<double> accuracyV = GeneratedColumn<double>(
    'accuracy_v',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('manual'),
  );
  static const VerificationMeta _isFixedMeta = const VerificationMeta(
    'isFixed',
  );
  @override
  late final GeneratedColumn<bool> isFixed = GeneratedColumn<bool>(
    'is_fixed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_fixed" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    deviceId,
    label,
    lat,
    lon,
    ellipH,
    orthoH,
    accuracyH,
    accuracyV,
    source,
    isFixed,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'anchors';
  @override
  VerificationContext validateIntegrity(
    Insertable<Anchor> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('lat')) {
      context.handle(
        _latMeta,
        lat.isAcceptableOrUnknown(data['lat']!, _latMeta),
      );
    } else if (isInserting) {
      context.missing(_latMeta);
    }
    if (data.containsKey('lon')) {
      context.handle(
        _lonMeta,
        lon.isAcceptableOrUnknown(data['lon']!, _lonMeta),
      );
    } else if (isInserting) {
      context.missing(_lonMeta);
    }
    if (data.containsKey('ellip_h')) {
      context.handle(
        _ellipHMeta,
        ellipH.isAcceptableOrUnknown(data['ellip_h']!, _ellipHMeta),
      );
    } else if (isInserting) {
      context.missing(_ellipHMeta);
    }
    if (data.containsKey('ortho_h')) {
      context.handle(
        _orthoHMeta,
        orthoH.isAcceptableOrUnknown(data['ortho_h']!, _orthoHMeta),
      );
    }
    if (data.containsKey('accuracy_h')) {
      context.handle(
        _accuracyHMeta,
        accuracyH.isAcceptableOrUnknown(data['accuracy_h']!, _accuracyHMeta),
      );
    }
    if (data.containsKey('accuracy_v')) {
      context.handle(
        _accuracyVMeta,
        accuracyV.isAcceptableOrUnknown(data['accuracy_v']!, _accuracyVMeta),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('is_fixed')) {
      context.handle(
        _isFixedMeta,
        isFixed.isAcceptableOrUnknown(data['is_fixed']!, _isFixedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Anchor map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Anchor(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      ),
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      lat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lat'],
      )!,
      lon: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lon'],
      )!,
      ellipH: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ellip_h'],
      )!,
      orthoH: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ortho_h'],
      ),
      accuracyH: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}accuracy_h'],
      ),
      accuracyV: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}accuracy_v'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      isFixed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_fixed'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AnchorsTable createAlias(String alias) {
    return $AnchorsTable(attachedDatabase, alias);
  }
}

class Anchor extends DataClass implements Insertable<Anchor> {
  final String id;
  final String sessionId;
  final String? deviceId;
  final String label;
  final double lat;
  final double lon;
  final double ellipH;
  final double? orthoH;
  final double? accuracyH;
  final double? accuracyV;
  final String source;
  final bool isFixed;
  final DateTime createdAt;
  const Anchor({
    required this.id,
    required this.sessionId,
    this.deviceId,
    required this.label,
    required this.lat,
    required this.lon,
    required this.ellipH,
    this.orthoH,
    this.accuracyH,
    this.accuracyV,
    required this.source,
    required this.isFixed,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    if (!nullToAbsent || deviceId != null) {
      map['device_id'] = Variable<String>(deviceId);
    }
    map['label'] = Variable<String>(label);
    map['lat'] = Variable<double>(lat);
    map['lon'] = Variable<double>(lon);
    map['ellip_h'] = Variable<double>(ellipH);
    if (!nullToAbsent || orthoH != null) {
      map['ortho_h'] = Variable<double>(orthoH);
    }
    if (!nullToAbsent || accuracyH != null) {
      map['accuracy_h'] = Variable<double>(accuracyH);
    }
    if (!nullToAbsent || accuracyV != null) {
      map['accuracy_v'] = Variable<double>(accuracyV);
    }
    map['source'] = Variable<String>(source);
    map['is_fixed'] = Variable<bool>(isFixed);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AnchorsCompanion toCompanion(bool nullToAbsent) {
    return AnchorsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      deviceId: deviceId == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceId),
      label: Value(label),
      lat: Value(lat),
      lon: Value(lon),
      ellipH: Value(ellipH),
      orthoH: orthoH == null && nullToAbsent
          ? const Value.absent()
          : Value(orthoH),
      accuracyH: accuracyH == null && nullToAbsent
          ? const Value.absent()
          : Value(accuracyH),
      accuracyV: accuracyV == null && nullToAbsent
          ? const Value.absent()
          : Value(accuracyV),
      source: Value(source),
      isFixed: Value(isFixed),
      createdAt: Value(createdAt),
    );
  }

  factory Anchor.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Anchor(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      deviceId: serializer.fromJson<String?>(json['deviceId']),
      label: serializer.fromJson<String>(json['label']),
      lat: serializer.fromJson<double>(json['lat']),
      lon: serializer.fromJson<double>(json['lon']),
      ellipH: serializer.fromJson<double>(json['ellipH']),
      orthoH: serializer.fromJson<double?>(json['orthoH']),
      accuracyH: serializer.fromJson<double?>(json['accuracyH']),
      accuracyV: serializer.fromJson<double?>(json['accuracyV']),
      source: serializer.fromJson<String>(json['source']),
      isFixed: serializer.fromJson<bool>(json['isFixed']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'deviceId': serializer.toJson<String?>(deviceId),
      'label': serializer.toJson<String>(label),
      'lat': serializer.toJson<double>(lat),
      'lon': serializer.toJson<double>(lon),
      'ellipH': serializer.toJson<double>(ellipH),
      'orthoH': serializer.toJson<double?>(orthoH),
      'accuracyH': serializer.toJson<double?>(accuracyH),
      'accuracyV': serializer.toJson<double?>(accuracyV),
      'source': serializer.toJson<String>(source),
      'isFixed': serializer.toJson<bool>(isFixed),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Anchor copyWith({
    String? id,
    String? sessionId,
    Value<String?> deviceId = const Value.absent(),
    String? label,
    double? lat,
    double? lon,
    double? ellipH,
    Value<double?> orthoH = const Value.absent(),
    Value<double?> accuracyH = const Value.absent(),
    Value<double?> accuracyV = const Value.absent(),
    String? source,
    bool? isFixed,
    DateTime? createdAt,
  }) => Anchor(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    deviceId: deviceId.present ? deviceId.value : this.deviceId,
    label: label ?? this.label,
    lat: lat ?? this.lat,
    lon: lon ?? this.lon,
    ellipH: ellipH ?? this.ellipH,
    orthoH: orthoH.present ? orthoH.value : this.orthoH,
    accuracyH: accuracyH.present ? accuracyH.value : this.accuracyH,
    accuracyV: accuracyV.present ? accuracyV.value : this.accuracyV,
    source: source ?? this.source,
    isFixed: isFixed ?? this.isFixed,
    createdAt: createdAt ?? this.createdAt,
  );
  Anchor copyWithCompanion(AnchorsCompanion data) {
    return Anchor(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      label: data.label.present ? data.label.value : this.label,
      lat: data.lat.present ? data.lat.value : this.lat,
      lon: data.lon.present ? data.lon.value : this.lon,
      ellipH: data.ellipH.present ? data.ellipH.value : this.ellipH,
      orthoH: data.orthoH.present ? data.orthoH.value : this.orthoH,
      accuracyH: data.accuracyH.present ? data.accuracyH.value : this.accuracyH,
      accuracyV: data.accuracyV.present ? data.accuracyV.value : this.accuracyV,
      source: data.source.present ? data.source.value : this.source,
      isFixed: data.isFixed.present ? data.isFixed.value : this.isFixed,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Anchor(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('deviceId: $deviceId, ')
          ..write('label: $label, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('ellipH: $ellipH, ')
          ..write('orthoH: $orthoH, ')
          ..write('accuracyH: $accuracyH, ')
          ..write('accuracyV: $accuracyV, ')
          ..write('source: $source, ')
          ..write('isFixed: $isFixed, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionId,
    deviceId,
    label,
    lat,
    lon,
    ellipH,
    orthoH,
    accuracyH,
    accuracyV,
    source,
    isFixed,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Anchor &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.deviceId == this.deviceId &&
          other.label == this.label &&
          other.lat == this.lat &&
          other.lon == this.lon &&
          other.ellipH == this.ellipH &&
          other.orthoH == this.orthoH &&
          other.accuracyH == this.accuracyH &&
          other.accuracyV == this.accuracyV &&
          other.source == this.source &&
          other.isFixed == this.isFixed &&
          other.createdAt == this.createdAt);
}

class AnchorsCompanion extends UpdateCompanion<Anchor> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<String?> deviceId;
  final Value<String> label;
  final Value<double> lat;
  final Value<double> lon;
  final Value<double> ellipH;
  final Value<double?> orthoH;
  final Value<double?> accuracyH;
  final Value<double?> accuracyV;
  final Value<String> source;
  final Value<bool> isFixed;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const AnchorsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.label = const Value.absent(),
    this.lat = const Value.absent(),
    this.lon = const Value.absent(),
    this.ellipH = const Value.absent(),
    this.orthoH = const Value.absent(),
    this.accuracyH = const Value.absent(),
    this.accuracyV = const Value.absent(),
    this.source = const Value.absent(),
    this.isFixed = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AnchorsCompanion.insert({
    required String id,
    required String sessionId,
    this.deviceId = const Value.absent(),
    required String label,
    required double lat,
    required double lon,
    required double ellipH,
    this.orthoH = const Value.absent(),
    this.accuracyH = const Value.absent(),
    this.accuracyV = const Value.absent(),
    this.source = const Value.absent(),
    this.isFixed = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sessionId = Value(sessionId),
       label = Value(label),
       lat = Value(lat),
       lon = Value(lon),
       ellipH = Value(ellipH),
       createdAt = Value(createdAt);
  static Insertable<Anchor> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<String>? deviceId,
    Expression<String>? label,
    Expression<double>? lat,
    Expression<double>? lon,
    Expression<double>? ellipH,
    Expression<double>? orthoH,
    Expression<double>? accuracyH,
    Expression<double>? accuracyV,
    Expression<String>? source,
    Expression<bool>? isFixed,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (deviceId != null) 'device_id': deviceId,
      if (label != null) 'label': label,
      if (lat != null) 'lat': lat,
      if (lon != null) 'lon': lon,
      if (ellipH != null) 'ellip_h': ellipH,
      if (orthoH != null) 'ortho_h': orthoH,
      if (accuracyH != null) 'accuracy_h': accuracyH,
      if (accuracyV != null) 'accuracy_v': accuracyV,
      if (source != null) 'source': source,
      if (isFixed != null) 'is_fixed': isFixed,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AnchorsCompanion copyWith({
    Value<String>? id,
    Value<String>? sessionId,
    Value<String?>? deviceId,
    Value<String>? label,
    Value<double>? lat,
    Value<double>? lon,
    Value<double>? ellipH,
    Value<double?>? orthoH,
    Value<double?>? accuracyH,
    Value<double?>? accuracyV,
    Value<String>? source,
    Value<bool>? isFixed,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return AnchorsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      deviceId: deviceId ?? this.deviceId,
      label: label ?? this.label,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      ellipH: ellipH ?? this.ellipH,
      orthoH: orthoH ?? this.orthoH,
      accuracyH: accuracyH ?? this.accuracyH,
      accuracyV: accuracyV ?? this.accuracyV,
      source: source ?? this.source,
      isFixed: isFixed ?? this.isFixed,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lon.present) {
      map['lon'] = Variable<double>(lon.value);
    }
    if (ellipH.present) {
      map['ellip_h'] = Variable<double>(ellipH.value);
    }
    if (orthoH.present) {
      map['ortho_h'] = Variable<double>(orthoH.value);
    }
    if (accuracyH.present) {
      map['accuracy_h'] = Variable<double>(accuracyH.value);
    }
    if (accuracyV.present) {
      map['accuracy_v'] = Variable<double>(accuracyV.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (isFixed.present) {
      map['is_fixed'] = Variable<bool>(isFixed.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AnchorsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('deviceId: $deviceId, ')
          ..write('label: $label, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('ellipH: $ellipH, ')
          ..write('orthoH: $orthoH, ')
          ..write('accuracyH: $accuracyH, ')
          ..write('accuracyV: $accuracyV, ')
          ..write('source: $source, ')
          ..write('isFixed: $isFixed, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SurveyPointsTable extends SurveyPoints
    with TableInfo<$SurveyPointsTable, SurveyPoint> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SurveyPointsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _epochIdMeta = const VerificationMeta(
    'epochId',
  );
  @override
  late final GeneratedColumn<String> epochId = GeneratedColumn<String>(
    'epoch_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _layerMeta = const VerificationMeta('layer');
  @override
  late final GeneratedColumn<String> layer = GeneratedColumn<String>(
    'layer',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('tanah'),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double> lat = GeneratedColumn<double>(
    'lat',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lonMeta = const VerificationMeta('lon');
  @override
  late final GeneratedColumn<double> lon = GeneratedColumn<double>(
    'lon',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orthoHMeta = const VerificationMeta('orthoH');
  @override
  late final GeneratedColumn<double> orthoH = GeneratedColumn<double>(
    'ortho_h',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accuracyHMeta = const VerificationMeta(
    'accuracyH',
  );
  @override
  late final GeneratedColumn<double> accuracyH = GeneratedColumn<double>(
    'accuracy_h',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accuracyVMeta = const VerificationMeta(
    'accuracyV',
  );
  @override
  late final GeneratedColumn<double> accuracyV = GeneratedColumn<double>(
    'accuracy_v',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
    'method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qualityMeta = const VerificationMeta(
    'quality',
  );
  @override
  late final GeneratedColumn<String> quality = GeneratedColumn<String>(
    'quality',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  static const VerificationMeta _poleHeightMeta = const VerificationMeta(
    'poleHeight',
  );
  @override
  late final GeneratedColumn<double> poleHeight = GeneratedColumn<double>(
    'pole_height',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    projectId,
    sessionId,
    epochId,
    code,
    layer,
    description,
    lat,
    lon,
    orthoH,
    accuracyH,
    accuracyV,
    method,
    quality,
    status,
    poleHeight,
    photoPath,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'survey_points';
  @override
  VerificationContext validateIntegrity(
    Insertable<SurveyPoint> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('epoch_id')) {
      context.handle(
        _epochIdMeta,
        epochId.isAcceptableOrUnknown(data['epoch_id']!, _epochIdMeta),
      );
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('layer')) {
      context.handle(
        _layerMeta,
        layer.isAcceptableOrUnknown(data['layer']!, _layerMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('lat')) {
      context.handle(
        _latMeta,
        lat.isAcceptableOrUnknown(data['lat']!, _latMeta),
      );
    } else if (isInserting) {
      context.missing(_latMeta);
    }
    if (data.containsKey('lon')) {
      context.handle(
        _lonMeta,
        lon.isAcceptableOrUnknown(data['lon']!, _lonMeta),
      );
    } else if (isInserting) {
      context.missing(_lonMeta);
    }
    if (data.containsKey('ortho_h')) {
      context.handle(
        _orthoHMeta,
        orthoH.isAcceptableOrUnknown(data['ortho_h']!, _orthoHMeta),
      );
    } else if (isInserting) {
      context.missing(_orthoHMeta);
    }
    if (data.containsKey('accuracy_h')) {
      context.handle(
        _accuracyHMeta,
        accuracyH.isAcceptableOrUnknown(data['accuracy_h']!, _accuracyHMeta),
      );
    } else if (isInserting) {
      context.missing(_accuracyHMeta);
    }
    if (data.containsKey('accuracy_v')) {
      context.handle(
        _accuracyVMeta,
        accuracyV.isAcceptableOrUnknown(data['accuracy_v']!, _accuracyVMeta),
      );
    }
    if (data.containsKey('method')) {
      context.handle(
        _methodMeta,
        method.isAcceptableOrUnknown(data['method']!, _methodMeta),
      );
    } else if (isInserting) {
      context.missing(_methodMeta);
    }
    if (data.containsKey('quality')) {
      context.handle(
        _qualityMeta,
        quality.isAcceptableOrUnknown(data['quality']!, _qualityMeta),
      );
    } else if (isInserting) {
      context.missing(_qualityMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('pole_height')) {
      context.handle(
        _poleHeightMeta,
        poleHeight.isAcceptableOrUnknown(data['pole_height']!, _poleHeightMeta),
      );
    } else if (isInserting) {
      context.missing(_poleHeightMeta);
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SurveyPoint map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SurveyPoint(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      epochId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}epoch_id'],
      ),
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      layer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}layer'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      lat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lat'],
      )!,
      lon: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lon'],
      )!,
      orthoH: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ortho_h'],
      )!,
      accuracyH: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}accuracy_h'],
      )!,
      accuracyV: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}accuracy_v'],
      ),
      method: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}method'],
      )!,
      quality: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quality'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      poleHeight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pole_height'],
      )!,
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SurveyPointsTable createAlias(String alias) {
    return $SurveyPointsTable(attachedDatabase, alias);
  }
}

class SurveyPoint extends DataClass implements Insertable<SurveyPoint> {
  final String id;
  final String projectId;
  final String sessionId;
  final String? epochId;
  final String code;
  final String layer;
  final String? description;
  final double lat;
  final double lon;
  final double orthoH;
  final double accuracyH;
  final double? accuracyV;
  final String method;
  final String quality;
  final String status;
  final double poleHeight;
  final String? photoPath;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SurveyPoint({
    required this.id,
    required this.projectId,
    required this.sessionId,
    this.epochId,
    required this.code,
    required this.layer,
    this.description,
    required this.lat,
    required this.lon,
    required this.orthoH,
    required this.accuracyH,
    this.accuracyV,
    required this.method,
    required this.quality,
    required this.status,
    required this.poleHeight,
    this.photoPath,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['project_id'] = Variable<String>(projectId);
    map['session_id'] = Variable<String>(sessionId);
    if (!nullToAbsent || epochId != null) {
      map['epoch_id'] = Variable<String>(epochId);
    }
    map['code'] = Variable<String>(code);
    map['layer'] = Variable<String>(layer);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['lat'] = Variable<double>(lat);
    map['lon'] = Variable<double>(lon);
    map['ortho_h'] = Variable<double>(orthoH);
    map['accuracy_h'] = Variable<double>(accuracyH);
    if (!nullToAbsent || accuracyV != null) {
      map['accuracy_v'] = Variable<double>(accuracyV);
    }
    map['method'] = Variable<String>(method);
    map['quality'] = Variable<String>(quality);
    map['status'] = Variable<String>(status);
    map['pole_height'] = Variable<double>(poleHeight);
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SurveyPointsCompanion toCompanion(bool nullToAbsent) {
    return SurveyPointsCompanion(
      id: Value(id),
      projectId: Value(projectId),
      sessionId: Value(sessionId),
      epochId: epochId == null && nullToAbsent
          ? const Value.absent()
          : Value(epochId),
      code: Value(code),
      layer: Value(layer),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      lat: Value(lat),
      lon: Value(lon),
      orthoH: Value(orthoH),
      accuracyH: Value(accuracyH),
      accuracyV: accuracyV == null && nullToAbsent
          ? const Value.absent()
          : Value(accuracyV),
      method: Value(method),
      quality: Value(quality),
      status: Value(status),
      poleHeight: Value(poleHeight),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SurveyPoint.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SurveyPoint(
      id: serializer.fromJson<String>(json['id']),
      projectId: serializer.fromJson<String>(json['projectId']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      epochId: serializer.fromJson<String?>(json['epochId']),
      code: serializer.fromJson<String>(json['code']),
      layer: serializer.fromJson<String>(json['layer']),
      description: serializer.fromJson<String?>(json['description']),
      lat: serializer.fromJson<double>(json['lat']),
      lon: serializer.fromJson<double>(json['lon']),
      orthoH: serializer.fromJson<double>(json['orthoH']),
      accuracyH: serializer.fromJson<double>(json['accuracyH']),
      accuracyV: serializer.fromJson<double?>(json['accuracyV']),
      method: serializer.fromJson<String>(json['method']),
      quality: serializer.fromJson<String>(json['quality']),
      status: serializer.fromJson<String>(json['status']),
      poleHeight: serializer.fromJson<double>(json['poleHeight']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'projectId': serializer.toJson<String>(projectId),
      'sessionId': serializer.toJson<String>(sessionId),
      'epochId': serializer.toJson<String?>(epochId),
      'code': serializer.toJson<String>(code),
      'layer': serializer.toJson<String>(layer),
      'description': serializer.toJson<String?>(description),
      'lat': serializer.toJson<double>(lat),
      'lon': serializer.toJson<double>(lon),
      'orthoH': serializer.toJson<double>(orthoH),
      'accuracyH': serializer.toJson<double>(accuracyH),
      'accuracyV': serializer.toJson<double?>(accuracyV),
      'method': serializer.toJson<String>(method),
      'quality': serializer.toJson<String>(quality),
      'status': serializer.toJson<String>(status),
      'poleHeight': serializer.toJson<double>(poleHeight),
      'photoPath': serializer.toJson<String?>(photoPath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SurveyPoint copyWith({
    String? id,
    String? projectId,
    String? sessionId,
    Value<String?> epochId = const Value.absent(),
    String? code,
    String? layer,
    Value<String?> description = const Value.absent(),
    double? lat,
    double? lon,
    double? orthoH,
    double? accuracyH,
    Value<double?> accuracyV = const Value.absent(),
    String? method,
    String? quality,
    String? status,
    double? poleHeight,
    Value<String?> photoPath = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => SurveyPoint(
    id: id ?? this.id,
    projectId: projectId ?? this.projectId,
    sessionId: sessionId ?? this.sessionId,
    epochId: epochId.present ? epochId.value : this.epochId,
    code: code ?? this.code,
    layer: layer ?? this.layer,
    description: description.present ? description.value : this.description,
    lat: lat ?? this.lat,
    lon: lon ?? this.lon,
    orthoH: orthoH ?? this.orthoH,
    accuracyH: accuracyH ?? this.accuracyH,
    accuracyV: accuracyV.present ? accuracyV.value : this.accuracyV,
    method: method ?? this.method,
    quality: quality ?? this.quality,
    status: status ?? this.status,
    poleHeight: poleHeight ?? this.poleHeight,
    photoPath: photoPath.present ? photoPath.value : this.photoPath,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SurveyPoint copyWithCompanion(SurveyPointsCompanion data) {
    return SurveyPoint(
      id: data.id.present ? data.id.value : this.id,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      epochId: data.epochId.present ? data.epochId.value : this.epochId,
      code: data.code.present ? data.code.value : this.code,
      layer: data.layer.present ? data.layer.value : this.layer,
      description: data.description.present
          ? data.description.value
          : this.description,
      lat: data.lat.present ? data.lat.value : this.lat,
      lon: data.lon.present ? data.lon.value : this.lon,
      orthoH: data.orthoH.present ? data.orthoH.value : this.orthoH,
      accuracyH: data.accuracyH.present ? data.accuracyH.value : this.accuracyH,
      accuracyV: data.accuracyV.present ? data.accuracyV.value : this.accuracyV,
      method: data.method.present ? data.method.value : this.method,
      quality: data.quality.present ? data.quality.value : this.quality,
      status: data.status.present ? data.status.value : this.status,
      poleHeight: data.poleHeight.present
          ? data.poleHeight.value
          : this.poleHeight,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SurveyPoint(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('sessionId: $sessionId, ')
          ..write('epochId: $epochId, ')
          ..write('code: $code, ')
          ..write('layer: $layer, ')
          ..write('description: $description, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('orthoH: $orthoH, ')
          ..write('accuracyH: $accuracyH, ')
          ..write('accuracyV: $accuracyV, ')
          ..write('method: $method, ')
          ..write('quality: $quality, ')
          ..write('status: $status, ')
          ..write('poleHeight: $poleHeight, ')
          ..write('photoPath: $photoPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    projectId,
    sessionId,
    epochId,
    code,
    layer,
    description,
    lat,
    lon,
    orthoH,
    accuracyH,
    accuracyV,
    method,
    quality,
    status,
    poleHeight,
    photoPath,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SurveyPoint &&
          other.id == this.id &&
          other.projectId == this.projectId &&
          other.sessionId == this.sessionId &&
          other.epochId == this.epochId &&
          other.code == this.code &&
          other.layer == this.layer &&
          other.description == this.description &&
          other.lat == this.lat &&
          other.lon == this.lon &&
          other.orthoH == this.orthoH &&
          other.accuracyH == this.accuracyH &&
          other.accuracyV == this.accuracyV &&
          other.method == this.method &&
          other.quality == this.quality &&
          other.status == this.status &&
          other.poleHeight == this.poleHeight &&
          other.photoPath == this.photoPath &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SurveyPointsCompanion extends UpdateCompanion<SurveyPoint> {
  final Value<String> id;
  final Value<String> projectId;
  final Value<String> sessionId;
  final Value<String?> epochId;
  final Value<String> code;
  final Value<String> layer;
  final Value<String?> description;
  final Value<double> lat;
  final Value<double> lon;
  final Value<double> orthoH;
  final Value<double> accuracyH;
  final Value<double?> accuracyV;
  final Value<String> method;
  final Value<String> quality;
  final Value<String> status;
  final Value<double> poleHeight;
  final Value<String?> photoPath;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SurveyPointsCompanion({
    this.id = const Value.absent(),
    this.projectId = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.epochId = const Value.absent(),
    this.code = const Value.absent(),
    this.layer = const Value.absent(),
    this.description = const Value.absent(),
    this.lat = const Value.absent(),
    this.lon = const Value.absent(),
    this.orthoH = const Value.absent(),
    this.accuracyH = const Value.absent(),
    this.accuracyV = const Value.absent(),
    this.method = const Value.absent(),
    this.quality = const Value.absent(),
    this.status = const Value.absent(),
    this.poleHeight = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SurveyPointsCompanion.insert({
    required String id,
    required String projectId,
    required String sessionId,
    this.epochId = const Value.absent(),
    required String code,
    this.layer = const Value.absent(),
    this.description = const Value.absent(),
    required double lat,
    required double lon,
    required double orthoH,
    required double accuracyH,
    this.accuracyV = const Value.absent(),
    required String method,
    required String quality,
    this.status = const Value.absent(),
    required double poleHeight,
    this.photoPath = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       projectId = Value(projectId),
       sessionId = Value(sessionId),
       code = Value(code),
       lat = Value(lat),
       lon = Value(lon),
       orthoH = Value(orthoH),
       accuracyH = Value(accuracyH),
       method = Value(method),
       quality = Value(quality),
       poleHeight = Value(poleHeight),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<SurveyPoint> custom({
    Expression<String>? id,
    Expression<String>? projectId,
    Expression<String>? sessionId,
    Expression<String>? epochId,
    Expression<String>? code,
    Expression<String>? layer,
    Expression<String>? description,
    Expression<double>? lat,
    Expression<double>? lon,
    Expression<double>? orthoH,
    Expression<double>? accuracyH,
    Expression<double>? accuracyV,
    Expression<String>? method,
    Expression<String>? quality,
    Expression<String>? status,
    Expression<double>? poleHeight,
    Expression<String>? photoPath,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectId != null) 'project_id': projectId,
      if (sessionId != null) 'session_id': sessionId,
      if (epochId != null) 'epoch_id': epochId,
      if (code != null) 'code': code,
      if (layer != null) 'layer': layer,
      if (description != null) 'description': description,
      if (lat != null) 'lat': lat,
      if (lon != null) 'lon': lon,
      if (orthoH != null) 'ortho_h': orthoH,
      if (accuracyH != null) 'accuracy_h': accuracyH,
      if (accuracyV != null) 'accuracy_v': accuracyV,
      if (method != null) 'method': method,
      if (quality != null) 'quality': quality,
      if (status != null) 'status': status,
      if (poleHeight != null) 'pole_height': poleHeight,
      if (photoPath != null) 'photo_path': photoPath,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SurveyPointsCompanion copyWith({
    Value<String>? id,
    Value<String>? projectId,
    Value<String>? sessionId,
    Value<String?>? epochId,
    Value<String>? code,
    Value<String>? layer,
    Value<String?>? description,
    Value<double>? lat,
    Value<double>? lon,
    Value<double>? orthoH,
    Value<double>? accuracyH,
    Value<double?>? accuracyV,
    Value<String>? method,
    Value<String>? quality,
    Value<String>? status,
    Value<double>? poleHeight,
    Value<String?>? photoPath,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SurveyPointsCompanion(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      sessionId: sessionId ?? this.sessionId,
      epochId: epochId ?? this.epochId,
      code: code ?? this.code,
      layer: layer ?? this.layer,
      description: description ?? this.description,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      orthoH: orthoH ?? this.orthoH,
      accuracyH: accuracyH ?? this.accuracyH,
      accuracyV: accuracyV ?? this.accuracyV,
      method: method ?? this.method,
      quality: quality ?? this.quality,
      status: status ?? this.status,
      poleHeight: poleHeight ?? this.poleHeight,
      photoPath: photoPath ?? this.photoPath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (epochId.present) {
      map['epoch_id'] = Variable<String>(epochId.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (layer.present) {
      map['layer'] = Variable<String>(layer.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lon.present) {
      map['lon'] = Variable<double>(lon.value);
    }
    if (orthoH.present) {
      map['ortho_h'] = Variable<double>(orthoH.value);
    }
    if (accuracyH.present) {
      map['accuracy_h'] = Variable<double>(accuracyH.value);
    }
    if (accuracyV.present) {
      map['accuracy_v'] = Variable<double>(accuracyV.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (quality.present) {
      map['quality'] = Variable<String>(quality.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (poleHeight.present) {
      map['pole_height'] = Variable<double>(poleHeight.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SurveyPointsCompanion(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('sessionId: $sessionId, ')
          ..write('epochId: $epochId, ')
          ..write('code: $code, ')
          ..write('layer: $layer, ')
          ..write('description: $description, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('orthoH: $orthoH, ')
          ..write('accuracyH: $accuracyH, ')
          ..write('accuracyV: $accuracyV, ')
          ..write('method: $method, ')
          ..write('quality: $quality, ')
          ..write('status: $status, ')
          ..write('poleHeight: $poleHeight, ')
          ..write('photoPath: $photoPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DiagnosticLogsTable extends DiagnosticLogs
    with TableInfo<$DiagnosticLogsTable, DiagnosticLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DiagnosticLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageMeta = const VerificationMeta(
    'message',
  );
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
    'message',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    deviceId,
    category,
    message,
    payloadJson,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'diagnostic_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<DiagnosticLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('message')) {
      context.handle(
        _messageMeta,
        message.isAcceptableOrUnknown(data['message']!, _messageMeta),
      );
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DiagnosticLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DiagnosticLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      ),
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      message: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $DiagnosticLogsTable createAlias(String alias) {
    return $DiagnosticLogsTable(attachedDatabase, alias);
  }
}

class DiagnosticLog extends DataClass implements Insertable<DiagnosticLog> {
  final String id;
  final String? sessionId;
  final String? deviceId;
  final String category;
  final String message;
  final String? payloadJson;
  final DateTime createdAt;
  const DiagnosticLog({
    required this.id,
    this.sessionId,
    this.deviceId,
    required this.category,
    required this.message,
    this.payloadJson,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || sessionId != null) {
      map['session_id'] = Variable<String>(sessionId);
    }
    if (!nullToAbsent || deviceId != null) {
      map['device_id'] = Variable<String>(deviceId);
    }
    map['category'] = Variable<String>(category);
    map['message'] = Variable<String>(message);
    if (!nullToAbsent || payloadJson != null) {
      map['payload_json'] = Variable<String>(payloadJson);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DiagnosticLogsCompanion toCompanion(bool nullToAbsent) {
    return DiagnosticLogsCompanion(
      id: Value(id),
      sessionId: sessionId == null && nullToAbsent
          ? const Value.absent()
          : Value(sessionId),
      deviceId: deviceId == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceId),
      category: Value(category),
      message: Value(message),
      payloadJson: payloadJson == null && nullToAbsent
          ? const Value.absent()
          : Value(payloadJson),
      createdAt: Value(createdAt),
    );
  }

  factory DiagnosticLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DiagnosticLog(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String?>(json['sessionId']),
      deviceId: serializer.fromJson<String?>(json['deviceId']),
      category: serializer.fromJson<String>(json['category']),
      message: serializer.fromJson<String>(json['message']),
      payloadJson: serializer.fromJson<String?>(json['payloadJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String?>(sessionId),
      'deviceId': serializer.toJson<String?>(deviceId),
      'category': serializer.toJson<String>(category),
      'message': serializer.toJson<String>(message),
      'payloadJson': serializer.toJson<String?>(payloadJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DiagnosticLog copyWith({
    String? id,
    Value<String?> sessionId = const Value.absent(),
    Value<String?> deviceId = const Value.absent(),
    String? category,
    String? message,
    Value<String?> payloadJson = const Value.absent(),
    DateTime? createdAt,
  }) => DiagnosticLog(
    id: id ?? this.id,
    sessionId: sessionId.present ? sessionId.value : this.sessionId,
    deviceId: deviceId.present ? deviceId.value : this.deviceId,
    category: category ?? this.category,
    message: message ?? this.message,
    payloadJson: payloadJson.present ? payloadJson.value : this.payloadJson,
    createdAt: createdAt ?? this.createdAt,
  );
  DiagnosticLog copyWithCompanion(DiagnosticLogsCompanion data) {
    return DiagnosticLog(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      category: data.category.present ? data.category.value : this.category,
      message: data.message.present ? data.message.value : this.message,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DiagnosticLog(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('deviceId: $deviceId, ')
          ..write('category: $category, ')
          ..write('message: $message, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionId,
    deviceId,
    category,
    message,
    payloadJson,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DiagnosticLog &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.deviceId == this.deviceId &&
          other.category == this.category &&
          other.message == this.message &&
          other.payloadJson == this.payloadJson &&
          other.createdAt == this.createdAt);
}

class DiagnosticLogsCompanion extends UpdateCompanion<DiagnosticLog> {
  final Value<String> id;
  final Value<String?> sessionId;
  final Value<String?> deviceId;
  final Value<String> category;
  final Value<String> message;
  final Value<String?> payloadJson;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const DiagnosticLogsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.category = const Value.absent(),
    this.message = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DiagnosticLogsCompanion.insert({
    required String id,
    this.sessionId = const Value.absent(),
    this.deviceId = const Value.absent(),
    required String category,
    required String message,
    this.payloadJson = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       category = Value(category),
       message = Value(message),
       createdAt = Value(createdAt);
  static Insertable<DiagnosticLog> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<String>? deviceId,
    Expression<String>? category,
    Expression<String>? message,
    Expression<String>? payloadJson,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (deviceId != null) 'device_id': deviceId,
      if (category != null) 'category': category,
      if (message != null) 'message': message,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DiagnosticLogsCompanion copyWith({
    Value<String>? id,
    Value<String?>? sessionId,
    Value<String?>? deviceId,
    Value<String>? category,
    Value<String>? message,
    Value<String?>? payloadJson,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return DiagnosticLogsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      deviceId: deviceId ?? this.deviceId,
      category: category ?? this.category,
      message: message ?? this.message,
      payloadJson: payloadJson ?? this.payloadJson,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiagnosticLogsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('deviceId: $deviceId, ')
          ..write('category: $category, ')
          ..write('message: $message, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProjectsTable projects = $ProjectsTable(this);
  late final $SessionsTable sessions = $SessionsTable(this);
  late final $DevicesTable devices = $DevicesTable(this);
  late final $EpochsTable epochs = $EpochsTable(this);
  late final $GnssObservationsTable gnssObservations = $GnssObservationsTable(
    this,
  );
  late final $BaroObservationsTable baroObservations = $BaroObservationsTable(
    this,
  );
  late final $BleMeasurementsTable bleMeasurements = $BleMeasurementsTable(
    this,
  );
  late final $AnchorsTable anchors = $AnchorsTable(this);
  late final $SurveyPointsTable surveyPoints = $SurveyPointsTable(this);
  late final $DiagnosticLogsTable diagnosticLogs = $DiagnosticLogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    projects,
    sessions,
    devices,
    epochs,
    gnssObservations,
    baroObservations,
    bleMeasurements,
    anchors,
    surveyPoints,
    diagnosticLogs,
  ];
}

typedef $$ProjectsTableCreateCompanionBuilder = ProjectsCompanion Function({
  required String id,
  required String name,
  Value<String?> description,
  Value<double?> originLat,
  Value<double?> originLon,
  Value<double?> originEllipH,
  Value<String> datumMode,
  Value<double?> benchmarkHeight,
  Value<double?> basePressureHpa,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$ProjectsTableUpdateCompanionBuilder = ProjectsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> description,
  Value<double?> originLat,
  Value<double?> originLon,
  Value<double?> originEllipH,
  Value<String> datumMode,
  Value<double?> benchmarkHeight,
  Value<double?> basePressureHpa,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$ProjectsTableFilterComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get originLat => $composableBuilder(
    column: $table.originLat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get originLon => $composableBuilder(
    column: $table.originLon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get originEllipH => $composableBuilder(
    column: $table.originEllipH,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get datumMode => $composableBuilder(
    column: $table.datumMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get benchmarkHeight => $composableBuilder(
    column: $table.benchmarkHeight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get basePressureHpa => $composableBuilder(
    column: $table.basePressureHpa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProjectsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get originLat => $composableBuilder(
    column: $table.originLat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get originLon => $composableBuilder(
    column: $table.originLon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get originEllipH => $composableBuilder(
    column: $table.originEllipH,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get datumMode => $composableBuilder(
    column: $table.datumMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get benchmarkHeight => $composableBuilder(
    column: $table.benchmarkHeight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get basePressureHpa => $composableBuilder(
    column: $table.basePressureHpa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProjectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get originLat =>
      $composableBuilder(column: $table.originLat, builder: (column) => column);

  GeneratedColumn<double> get originLon =>
      $composableBuilder(column: $table.originLon, builder: (column) => column);

  GeneratedColumn<double> get originEllipH => $composableBuilder(
    column: $table.originEllipH,
    builder: (column) => column,
  );

  GeneratedColumn<String> get datumMode =>
      $composableBuilder(column: $table.datumMode, builder: (column) => column);

  GeneratedColumn<double> get benchmarkHeight => $composableBuilder(
    column: $table.benchmarkHeight,
    builder: (column) => column,
  );

  GeneratedColumn<double> get basePressureHpa => $composableBuilder(
    column: $table.basePressureHpa,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ProjectsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProjectsTable,
          Project,
          $$ProjectsTableFilterComposer,
          $$ProjectsTableOrderingComposer,
          $$ProjectsTableAnnotationComposer,
          $$ProjectsTableCreateCompanionBuilder,
          $$ProjectsTableUpdateCompanionBuilder,
          (Project, BaseReferences<_$AppDatabase, $ProjectsTable, Project>),
          Project,
          PrefetchHooks Function()
        > {
  $$ProjectsTableTableManager(_$AppDatabase db, $ProjectsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<double?> originLat = const Value.absent(),
                Value<double?> originLon = const Value.absent(),
                Value<double?> originEllipH = const Value.absent(),
                Value<String> datumMode = const Value.absent(),
                Value<double?> benchmarkHeight = const Value.absent(),
                Value<double?> basePressureHpa = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProjectsCompanion(
                id: id,
                name: name,
                description: description,
                originLat: originLat,
                originLon: originLon,
                originEllipH: originEllipH,
                datumMode: datumMode,
                benchmarkHeight: benchmarkHeight,
                basePressureHpa: basePressureHpa,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> description = const Value.absent(),
                Value<double?> originLat = const Value.absent(),
                Value<double?> originLon = const Value.absent(),
                Value<double?> originEllipH = const Value.absent(),
                Value<String> datumMode = const Value.absent(),
                Value<double?> benchmarkHeight = const Value.absent(),
                Value<double?> basePressureHpa = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => ProjectsCompanion.insert(
                id: id,
                name: name,
                description: description,
                originLat: originLat,
                originLon: originLon,
                originEllipH: originEllipH,
                datumMode: datumMode,
                benchmarkHeight: benchmarkHeight,
                basePressureHpa: basePressureHpa,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProjectsTable, Project>(table),
                  BaseReferences<_$AppDatabase, $ProjectsTable, Project>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProjectsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProjectsTable,
      Project,
      $$ProjectsTableFilterComposer,
      $$ProjectsTableOrderingComposer,
      $$ProjectsTableAnnotationComposer,
      $$ProjectsTableCreateCompanionBuilder,
      $$ProjectsTableUpdateCompanionBuilder,
      (Project, BaseReferences<_$AppDatabase, $ProjectsTable, Project>),
      Project,
      PrefetchHooks Function()
    >;
typedef $$SessionsTableCreateCompanionBuilder = SessionsCompanion Function({
  required String id,
  required String projectId,
  required String mode,
  required String code,
  Value<String?> masterDeviceId,
  required DateTime startedAt,
  Value<DateTime?> endedAt,
  Value<String> status,
  Value<int> rowid,
});
typedef $$SessionsTableUpdateCompanionBuilder = SessionsCompanion Function({
  Value<String> id,
  Value<String> projectId,
  Value<String> mode,
  Value<String> code,
  Value<String?> masterDeviceId,
  Value<DateTime> startedAt,
  Value<DateTime?> endedAt,
  Value<String> status,
  Value<int> rowid,
});

class $$SessionsTableFilterComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get projectId => $composableBuilder(
    column: $table.projectId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get masterDeviceId => $composableBuilder(
    column: $table.masterDeviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get projectId => $composableBuilder(
    column: $table.projectId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get masterDeviceId => $composableBuilder(
    column: $table.masterDeviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get projectId =>
      $composableBuilder(column: $table.projectId, builder: (column) => column);

  GeneratedColumn<String> get mode =>
      $composableBuilder(column: $table.mode, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get masterDeviceId => $composableBuilder(
    column: $table.masterDeviceId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$SessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SessionsTable,
          Session,
          $$SessionsTableFilterComposer,
          $$SessionsTableOrderingComposer,
          $$SessionsTableAnnotationComposer,
          $$SessionsTableCreateCompanionBuilder,
          $$SessionsTableUpdateCompanionBuilder,
          (Session, BaseReferences<_$AppDatabase, $SessionsTable, Session>),
          Session,
          PrefetchHooks Function()
        > {
  $$SessionsTableTableManager(_$AppDatabase db, $SessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> projectId = const Value.absent(),
                Value<String> mode = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String?> masterDeviceId = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SessionsCompanion(
                id: id,
                projectId: projectId,
                mode: mode,
                code: code,
                masterDeviceId: masterDeviceId,
                startedAt: startedAt,
                endedAt: endedAt,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String projectId,
                required String mode,
                required String code,
                Value<String?> masterDeviceId = const Value.absent(),
                required DateTime startedAt,
                Value<DateTime?> endedAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SessionsCompanion.insert(
                id: id,
                projectId: projectId,
                mode: mode,
                code: code,
                masterDeviceId: masterDeviceId,
                startedAt: startedAt,
                endedAt: endedAt,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SessionsTable, Session>(table),
                  BaseReferences<_$AppDatabase, $SessionsTable, Session>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SessionsTable,
      Session,
      $$SessionsTableFilterComposer,
      $$SessionsTableOrderingComposer,
      $$SessionsTableAnnotationComposer,
      $$SessionsTableCreateCompanionBuilder,
      $$SessionsTableUpdateCompanionBuilder,
      (Session, BaseReferences<_$AppDatabase, $SessionsTable, Session>),
      Session,
      PrefetchHooks Function()
    >;
typedef $$DevicesTableCreateCompanionBuilder = DevicesCompanion Function({
  required String id,
  required String sessionId,
  required int shortId,
  required String role,
  required String name,
  Value<bool> hasBarometer,
  Value<double?> rssiAt1m,
  Value<double?> pathLossN,
  Value<DateTime?> lastSeenAt,
  Value<int> rowid,
});
typedef $$DevicesTableUpdateCompanionBuilder = DevicesCompanion Function({
  Value<String> id,
  Value<String> sessionId,
  Value<int> shortId,
  Value<String> role,
  Value<String> name,
  Value<bool> hasBarometer,
  Value<double?> rssiAt1m,
  Value<double?> pathLossN,
  Value<DateTime?> lastSeenAt,
  Value<int> rowid,
});

class $$DevicesTableFilterComposer
    extends Composer<_$AppDatabase, $DevicesTable> {
  $$DevicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get shortId => $composableBuilder(
    column: $table.shortId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasBarometer => $composableBuilder(
    column: $table.hasBarometer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rssiAt1m => $composableBuilder(
    column: $table.rssiAt1m,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pathLossN => $composableBuilder(
    column: $table.pathLossN,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSeenAt => $composableBuilder(
    column: $table.lastSeenAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DevicesTableOrderingComposer
    extends Composer<_$AppDatabase, $DevicesTable> {
  $$DevicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get shortId => $composableBuilder(
    column: $table.shortId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasBarometer => $composableBuilder(
    column: $table.hasBarometer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rssiAt1m => $composableBuilder(
    column: $table.rssiAt1m,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pathLossN => $composableBuilder(
    column: $table.pathLossN,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSeenAt => $composableBuilder(
    column: $table.lastSeenAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DevicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DevicesTable> {
  $$DevicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<int> get shortId =>
      $composableBuilder(column: $table.shortId, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get hasBarometer => $composableBuilder(
    column: $table.hasBarometer,
    builder: (column) => column,
  );

  GeneratedColumn<double> get rssiAt1m =>
      $composableBuilder(column: $table.rssiAt1m, builder: (column) => column);

  GeneratedColumn<double> get pathLossN =>
      $composableBuilder(column: $table.pathLossN, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSeenAt => $composableBuilder(
    column: $table.lastSeenAt,
    builder: (column) => column,
  );
}

class $$DevicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DevicesTable,
          Device,
          $$DevicesTableFilterComposer,
          $$DevicesTableOrderingComposer,
          $$DevicesTableAnnotationComposer,
          $$DevicesTableCreateCompanionBuilder,
          $$DevicesTableUpdateCompanionBuilder,
          (Device, BaseReferences<_$AppDatabase, $DevicesTable, Device>),
          Device,
          PrefetchHooks Function()
        > {
  $$DevicesTableTableManager(_$AppDatabase db, $DevicesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DevicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DevicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DevicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<int> shortId = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> hasBarometer = const Value.absent(),
                Value<double?> rssiAt1m = const Value.absent(),
                Value<double?> pathLossN = const Value.absent(),
                Value<DateTime?> lastSeenAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DevicesCompanion(
                id: id,
                sessionId: sessionId,
                shortId: shortId,
                role: role,
                name: name,
                hasBarometer: hasBarometer,
                rssiAt1m: rssiAt1m,
                pathLossN: pathLossN,
                lastSeenAt: lastSeenAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sessionId,
                required int shortId,
                required String role,
                required String name,
                Value<bool> hasBarometer = const Value.absent(),
                Value<double?> rssiAt1m = const Value.absent(),
                Value<double?> pathLossN = const Value.absent(),
                Value<DateTime?> lastSeenAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DevicesCompanion.insert(
                id: id,
                sessionId: sessionId,
                shortId: shortId,
                role: role,
                name: name,
                hasBarometer: hasBarometer,
                rssiAt1m: rssiAt1m,
                pathLossN: pathLossN,
                lastSeenAt: lastSeenAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DevicesTable, Device>(table),
                  BaseReferences<_$AppDatabase, $DevicesTable, Device>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DevicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DevicesTable,
      Device,
      $$DevicesTableFilterComposer,
      $$DevicesTableOrderingComposer,
      $$DevicesTableAnnotationComposer,
      $$DevicesTableCreateCompanionBuilder,
      $$DevicesTableUpdateCompanionBuilder,
      (Device, BaseReferences<_$AppDatabase, $DevicesTable, Device>),
      Device,
      PrefetchHooks Function()
    >;
typedef $$EpochsTableCreateCompanionBuilder = EpochsCompanion Function({
  required String id,
  required String sessionId,
  required int index,
  required DateTime startedAt,
  Value<DateTime?> endedAt,
  Value<String> status,
  Value<int> rowid,
});
typedef $$EpochsTableUpdateCompanionBuilder = EpochsCompanion Function({
  Value<String> id,
  Value<String> sessionId,
  Value<int> index,
  Value<DateTime> startedAt,
  Value<DateTime?> endedAt,
  Value<String> status,
  Value<int> rowid,
});

class $$EpochsTableFilterComposer
    extends Composer<_$AppDatabase, $EpochsTable> {
  $$EpochsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get index => $composableBuilder(
    column: $table.index,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EpochsTableOrderingComposer
    extends Composer<_$AppDatabase, $EpochsTable> {
  $$EpochsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get index => $composableBuilder(
    column: $table.index,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EpochsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EpochsTable> {
  $$EpochsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<int> get index =>
      $composableBuilder(column: $table.index, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$EpochsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EpochsTable,
          Epoch,
          $$EpochsTableFilterComposer,
          $$EpochsTableOrderingComposer,
          $$EpochsTableAnnotationComposer,
          $$EpochsTableCreateCompanionBuilder,
          $$EpochsTableUpdateCompanionBuilder,
          (Epoch, BaseReferences<_$AppDatabase, $EpochsTable, Epoch>),
          Epoch,
          PrefetchHooks Function()
        > {
  $$EpochsTableTableManager(_$AppDatabase db, $EpochsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EpochsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EpochsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EpochsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<int> index = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EpochsCompanion(
                id: id,
                sessionId: sessionId,
                index: index,
                startedAt: startedAt,
                endedAt: endedAt,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sessionId,
                required int index,
                required DateTime startedAt,
                Value<DateTime?> endedAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EpochsCompanion.insert(
                id: id,
                sessionId: sessionId,
                index: index,
                startedAt: startedAt,
                endedAt: endedAt,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EpochsTable, Epoch>(table),
                  BaseReferences<_$AppDatabase, $EpochsTable, Epoch>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EpochsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EpochsTable,
      Epoch,
      $$EpochsTableFilterComposer,
      $$EpochsTableOrderingComposer,
      $$EpochsTableAnnotationComposer,
      $$EpochsTableCreateCompanionBuilder,
      $$EpochsTableUpdateCompanionBuilder,
      (Epoch, BaseReferences<_$AppDatabase, $EpochsTable, Epoch>),
      Epoch,
      PrefetchHooks Function()
    >;
typedef $$GnssObservationsTableCreateCompanionBuilder =
    GnssObservationsCompanion Function({
      required String id,
      required String epochId,
      required String deviceId,
      required double lat,
      required double lon,
      required double ellipH,
      required double accuracyH,
      Value<double?> accuracyV,
      Value<int?> satellites,
      required int sampleCount,
      required double stdLat,
      required double stdLon,
      required double stdAlt,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$GnssObservationsTableUpdateCompanionBuilder =
    GnssObservationsCompanion Function({
      Value<String> id,
      Value<String> epochId,
      Value<String> deviceId,
      Value<double> lat,
      Value<double> lon,
      Value<double> ellipH,
      Value<double> accuracyH,
      Value<double?> accuracyV,
      Value<int?> satellites,
      Value<int> sampleCount,
      Value<double> stdLat,
      Value<double> stdLon,
      Value<double> stdAlt,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$GnssObservationsTableFilterComposer
    extends Composer<_$AppDatabase, $GnssObservationsTable> {
  $$GnssObservationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get epochId => $composableBuilder(
    column: $table.epochId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lon => $composableBuilder(
    column: $table.lon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get ellipH => $composableBuilder(
    column: $table.ellipH,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get accuracyH => $composableBuilder(
    column: $table.accuracyH,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get accuracyV => $composableBuilder(
    column: $table.accuracyV,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get satellites => $composableBuilder(
    column: $table.satellites,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sampleCount => $composableBuilder(
    column: $table.sampleCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get stdLat => $composableBuilder(
    column: $table.stdLat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get stdLon => $composableBuilder(
    column: $table.stdLon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get stdAlt => $composableBuilder(
    column: $table.stdAlt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GnssObservationsTableOrderingComposer
    extends Composer<_$AppDatabase, $GnssObservationsTable> {
  $$GnssObservationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get epochId => $composableBuilder(
    column: $table.epochId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lon => $composableBuilder(
    column: $table.lon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get ellipH => $composableBuilder(
    column: $table.ellipH,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get accuracyH => $composableBuilder(
    column: $table.accuracyH,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get accuracyV => $composableBuilder(
    column: $table.accuracyV,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get satellites => $composableBuilder(
    column: $table.satellites,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sampleCount => $composableBuilder(
    column: $table.sampleCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get stdLat => $composableBuilder(
    column: $table.stdLat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get stdLon => $composableBuilder(
    column: $table.stdLon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get stdAlt => $composableBuilder(
    column: $table.stdAlt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GnssObservationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GnssObservationsTable> {
  $$GnssObservationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get epochId =>
      $composableBuilder(column: $table.epochId, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<double> get lat =>
      $composableBuilder(column: $table.lat, builder: (column) => column);

  GeneratedColumn<double> get lon =>
      $composableBuilder(column: $table.lon, builder: (column) => column);

  GeneratedColumn<double> get ellipH =>
      $composableBuilder(column: $table.ellipH, builder: (column) => column);

  GeneratedColumn<double> get accuracyH =>
      $composableBuilder(column: $table.accuracyH, builder: (column) => column);

  GeneratedColumn<double> get accuracyV =>
      $composableBuilder(column: $table.accuracyV, builder: (column) => column);

  GeneratedColumn<int> get satellites => $composableBuilder(
    column: $table.satellites,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sampleCount => $composableBuilder(
    column: $table.sampleCount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get stdLat =>
      $composableBuilder(column: $table.stdLat, builder: (column) => column);

  GeneratedColumn<double> get stdLon =>
      $composableBuilder(column: $table.stdLon, builder: (column) => column);

  GeneratedColumn<double> get stdAlt =>
      $composableBuilder(column: $table.stdAlt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$GnssObservationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GnssObservationsTable,
          GnssObservation,
          $$GnssObservationsTableFilterComposer,
          $$GnssObservationsTableOrderingComposer,
          $$GnssObservationsTableAnnotationComposer,
          $$GnssObservationsTableCreateCompanionBuilder,
          $$GnssObservationsTableUpdateCompanionBuilder,
          (
            GnssObservation,
            BaseReferences<
              _$AppDatabase,
              $GnssObservationsTable,
              GnssObservation
            >,
          ),
          GnssObservation,
          PrefetchHooks Function()
        > {
  $$GnssObservationsTableTableManager(
    _$AppDatabase db,
    $GnssObservationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GnssObservationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GnssObservationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GnssObservationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> epochId = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<double> lat = const Value.absent(),
                Value<double> lon = const Value.absent(),
                Value<double> ellipH = const Value.absent(),
                Value<double> accuracyH = const Value.absent(),
                Value<double?> accuracyV = const Value.absent(),
                Value<int?> satellites = const Value.absent(),
                Value<int> sampleCount = const Value.absent(),
                Value<double> stdLat = const Value.absent(),
                Value<double> stdLon = const Value.absent(),
                Value<double> stdAlt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GnssObservationsCompanion(
                id: id,
                epochId: epochId,
                deviceId: deviceId,
                lat: lat,
                lon: lon,
                ellipH: ellipH,
                accuracyH: accuracyH,
                accuracyV: accuracyV,
                satellites: satellites,
                sampleCount: sampleCount,
                stdLat: stdLat,
                stdLon: stdLon,
                stdAlt: stdAlt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String epochId,
                required String deviceId,
                required double lat,
                required double lon,
                required double ellipH,
                required double accuracyH,
                Value<double?> accuracyV = const Value.absent(),
                Value<int?> satellites = const Value.absent(),
                required int sampleCount,
                required double stdLat,
                required double stdLon,
                required double stdAlt,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => GnssObservationsCompanion.insert(
                id: id,
                epochId: epochId,
                deviceId: deviceId,
                lat: lat,
                lon: lon,
                ellipH: ellipH,
                accuracyH: accuracyH,
                accuracyV: accuracyV,
                satellites: satellites,
                sampleCount: sampleCount,
                stdLat: stdLat,
                stdLon: stdLon,
                stdAlt: stdAlt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GnssObservationsTable, GnssObservation>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $GnssObservationsTable,
                    GnssObservation
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GnssObservationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GnssObservationsTable,
      GnssObservation,
      $$GnssObservationsTableFilterComposer,
      $$GnssObservationsTableOrderingComposer,
      $$GnssObservationsTableAnnotationComposer,
      $$GnssObservationsTableCreateCompanionBuilder,
      $$GnssObservationsTableUpdateCompanionBuilder,
      (
        GnssObservation,
        BaseReferences<_$AppDatabase, $GnssObservationsTable, GnssObservation>,
      ),
      GnssObservation,
      PrefetchHooks Function()
    >;
typedef $$BaroObservationsTableCreateCompanionBuilder =
    BaroObservationsCompanion Function({
      required String id,
      required String epochId,
      required String deviceId,
      required double pressureHpa,
      Value<double?> relativeHeightM,
      Value<double?> basePressureHpa,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$BaroObservationsTableUpdateCompanionBuilder =
    BaroObservationsCompanion Function({
      Value<String> id,
      Value<String> epochId,
      Value<String> deviceId,
      Value<double> pressureHpa,
      Value<double?> relativeHeightM,
      Value<double?> basePressureHpa,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$BaroObservationsTableFilterComposer
    extends Composer<_$AppDatabase, $BaroObservationsTable> {
  $$BaroObservationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get epochId => $composableBuilder(
    column: $table.epochId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pressureHpa => $composableBuilder(
    column: $table.pressureHpa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get relativeHeightM => $composableBuilder(
    column: $table.relativeHeightM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get basePressureHpa => $composableBuilder(
    column: $table.basePressureHpa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BaroObservationsTableOrderingComposer
    extends Composer<_$AppDatabase, $BaroObservationsTable> {
  $$BaroObservationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get epochId => $composableBuilder(
    column: $table.epochId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pressureHpa => $composableBuilder(
    column: $table.pressureHpa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get relativeHeightM => $composableBuilder(
    column: $table.relativeHeightM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get basePressureHpa => $composableBuilder(
    column: $table.basePressureHpa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BaroObservationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BaroObservationsTable> {
  $$BaroObservationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get epochId =>
      $composableBuilder(column: $table.epochId, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<double> get pressureHpa => $composableBuilder(
    column: $table.pressureHpa,
    builder: (column) => column,
  );

  GeneratedColumn<double> get relativeHeightM => $composableBuilder(
    column: $table.relativeHeightM,
    builder: (column) => column,
  );

  GeneratedColumn<double> get basePressureHpa => $composableBuilder(
    column: $table.basePressureHpa,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$BaroObservationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BaroObservationsTable,
          BaroObservation,
          $$BaroObservationsTableFilterComposer,
          $$BaroObservationsTableOrderingComposer,
          $$BaroObservationsTableAnnotationComposer,
          $$BaroObservationsTableCreateCompanionBuilder,
          $$BaroObservationsTableUpdateCompanionBuilder,
          (
            BaroObservation,
            BaseReferences<
              _$AppDatabase,
              $BaroObservationsTable,
              BaroObservation
            >,
          ),
          BaroObservation,
          PrefetchHooks Function()
        > {
  $$BaroObservationsTableTableManager(
    _$AppDatabase db,
    $BaroObservationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BaroObservationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BaroObservationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BaroObservationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> epochId = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<double> pressureHpa = const Value.absent(),
                Value<double?> relativeHeightM = const Value.absent(),
                Value<double?> basePressureHpa = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BaroObservationsCompanion(
                id: id,
                epochId: epochId,
                deviceId: deviceId,
                pressureHpa: pressureHpa,
                relativeHeightM: relativeHeightM,
                basePressureHpa: basePressureHpa,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String epochId,
                required String deviceId,
                required double pressureHpa,
                Value<double?> relativeHeightM = const Value.absent(),
                Value<double?> basePressureHpa = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => BaroObservationsCompanion.insert(
                id: id,
                epochId: epochId,
                deviceId: deviceId,
                pressureHpa: pressureHpa,
                relativeHeightM: relativeHeightM,
                basePressureHpa: basePressureHpa,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BaroObservationsTable, BaroObservation>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $BaroObservationsTable,
                    BaroObservation
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BaroObservationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BaroObservationsTable,
      BaroObservation,
      $$BaroObservationsTableFilterComposer,
      $$BaroObservationsTableOrderingComposer,
      $$BaroObservationsTableAnnotationComposer,
      $$BaroObservationsTableCreateCompanionBuilder,
      $$BaroObservationsTableUpdateCompanionBuilder,
      (
        BaroObservation,
        BaseReferences<_$AppDatabase, $BaroObservationsTable, BaroObservation>,
      ),
      BaroObservation,
      PrefetchHooks Function()
    >;
typedef $$BleMeasurementsTableCreateCompanionBuilder =
    BleMeasurementsCompanion Function({
      required String id,
      required String epochId,
      required String observerDeviceId,
      required int peerShortId,
      required String rssiSamplesJson,
      Value<double?> rssiFiltered,
      Value<double?> distanceM,
      Value<double?> distanceSigma,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$BleMeasurementsTableUpdateCompanionBuilder =
    BleMeasurementsCompanion Function({
      Value<String> id,
      Value<String> epochId,
      Value<String> observerDeviceId,
      Value<int> peerShortId,
      Value<String> rssiSamplesJson,
      Value<double?> rssiFiltered,
      Value<double?> distanceM,
      Value<double?> distanceSigma,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$BleMeasurementsTableFilterComposer
    extends Composer<_$AppDatabase, $BleMeasurementsTable> {
  $$BleMeasurementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get epochId => $composableBuilder(
    column: $table.epochId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get observerDeviceId => $composableBuilder(
    column: $table.observerDeviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get peerShortId => $composableBuilder(
    column: $table.peerShortId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rssiSamplesJson => $composableBuilder(
    column: $table.rssiSamplesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rssiFiltered => $composableBuilder(
    column: $table.rssiFiltered,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get distanceM => $composableBuilder(
    column: $table.distanceM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get distanceSigma => $composableBuilder(
    column: $table.distanceSigma,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BleMeasurementsTableOrderingComposer
    extends Composer<_$AppDatabase, $BleMeasurementsTable> {
  $$BleMeasurementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get epochId => $composableBuilder(
    column: $table.epochId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get observerDeviceId => $composableBuilder(
    column: $table.observerDeviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get peerShortId => $composableBuilder(
    column: $table.peerShortId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rssiSamplesJson => $composableBuilder(
    column: $table.rssiSamplesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rssiFiltered => $composableBuilder(
    column: $table.rssiFiltered,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get distanceM => $composableBuilder(
    column: $table.distanceM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get distanceSigma => $composableBuilder(
    column: $table.distanceSigma,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BleMeasurementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BleMeasurementsTable> {
  $$BleMeasurementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get epochId =>
      $composableBuilder(column: $table.epochId, builder: (column) => column);

  GeneratedColumn<String> get observerDeviceId => $composableBuilder(
    column: $table.observerDeviceId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get peerShortId => $composableBuilder(
    column: $table.peerShortId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rssiSamplesJson => $composableBuilder(
    column: $table.rssiSamplesJson,
    builder: (column) => column,
  );

  GeneratedColumn<double> get rssiFiltered => $composableBuilder(
    column: $table.rssiFiltered,
    builder: (column) => column,
  );

  GeneratedColumn<double> get distanceM =>
      $composableBuilder(column: $table.distanceM, builder: (column) => column);

  GeneratedColumn<double> get distanceSigma => $composableBuilder(
    column: $table.distanceSigma,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$BleMeasurementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BleMeasurementsTable,
          BleMeasurement,
          $$BleMeasurementsTableFilterComposer,
          $$BleMeasurementsTableOrderingComposer,
          $$BleMeasurementsTableAnnotationComposer,
          $$BleMeasurementsTableCreateCompanionBuilder,
          $$BleMeasurementsTableUpdateCompanionBuilder,
          (
            BleMeasurement,
            BaseReferences<
              _$AppDatabase,
              $BleMeasurementsTable,
              BleMeasurement
            >,
          ),
          BleMeasurement,
          PrefetchHooks Function()
        > {
  $$BleMeasurementsTableTableManager(
    _$AppDatabase db,
    $BleMeasurementsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BleMeasurementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BleMeasurementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BleMeasurementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> epochId = const Value.absent(),
                Value<String> observerDeviceId = const Value.absent(),
                Value<int> peerShortId = const Value.absent(),
                Value<String> rssiSamplesJson = const Value.absent(),
                Value<double?> rssiFiltered = const Value.absent(),
                Value<double?> distanceM = const Value.absent(),
                Value<double?> distanceSigma = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BleMeasurementsCompanion(
                id: id,
                epochId: epochId,
                observerDeviceId: observerDeviceId,
                peerShortId: peerShortId,
                rssiSamplesJson: rssiSamplesJson,
                rssiFiltered: rssiFiltered,
                distanceM: distanceM,
                distanceSigma: distanceSigma,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String epochId,
                required String observerDeviceId,
                required int peerShortId,
                required String rssiSamplesJson,
                Value<double?> rssiFiltered = const Value.absent(),
                Value<double?> distanceM = const Value.absent(),
                Value<double?> distanceSigma = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => BleMeasurementsCompanion.insert(
                id: id,
                epochId: epochId,
                observerDeviceId: observerDeviceId,
                peerShortId: peerShortId,
                rssiSamplesJson: rssiSamplesJson,
                rssiFiltered: rssiFiltered,
                distanceM: distanceM,
                distanceSigma: distanceSigma,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BleMeasurementsTable, BleMeasurement>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $BleMeasurementsTable,
                    BleMeasurement
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BleMeasurementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BleMeasurementsTable,
      BleMeasurement,
      $$BleMeasurementsTableFilterComposer,
      $$BleMeasurementsTableOrderingComposer,
      $$BleMeasurementsTableAnnotationComposer,
      $$BleMeasurementsTableCreateCompanionBuilder,
      $$BleMeasurementsTableUpdateCompanionBuilder,
      (
        BleMeasurement,
        BaseReferences<_$AppDatabase, $BleMeasurementsTable, BleMeasurement>,
      ),
      BleMeasurement,
      PrefetchHooks Function()
    >;
typedef $$AnchorsTableCreateCompanionBuilder = AnchorsCompanion Function({
  required String id,
  required String sessionId,
  Value<String?> deviceId,
  required String label,
  required double lat,
  required double lon,
  required double ellipH,
  Value<double?> orthoH,
  Value<double?> accuracyH,
  Value<double?> accuracyV,
  Value<String> source,
  Value<bool> isFixed,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$AnchorsTableUpdateCompanionBuilder = AnchorsCompanion Function({
  Value<String> id,
  Value<String> sessionId,
  Value<String?> deviceId,
  Value<String> label,
  Value<double> lat,
  Value<double> lon,
  Value<double> ellipH,
  Value<double?> orthoH,
  Value<double?> accuracyH,
  Value<double?> accuracyV,
  Value<String> source,
  Value<bool> isFixed,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$AnchorsTableFilterComposer
    extends Composer<_$AppDatabase, $AnchorsTable> {
  $$AnchorsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lon => $composableBuilder(
    column: $table.lon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get ellipH => $composableBuilder(
    column: $table.ellipH,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get orthoH => $composableBuilder(
    column: $table.orthoH,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get accuracyH => $composableBuilder(
    column: $table.accuracyH,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get accuracyV => $composableBuilder(
    column: $table.accuracyV,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFixed => $composableBuilder(
    column: $table.isFixed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AnchorsTableOrderingComposer
    extends Composer<_$AppDatabase, $AnchorsTable> {
  $$AnchorsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lon => $composableBuilder(
    column: $table.lon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get ellipH => $composableBuilder(
    column: $table.ellipH,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get orthoH => $composableBuilder(
    column: $table.orthoH,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get accuracyH => $composableBuilder(
    column: $table.accuracyH,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get accuracyV => $composableBuilder(
    column: $table.accuracyV,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFixed => $composableBuilder(
    column: $table.isFixed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AnchorsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AnchorsTable> {
  $$AnchorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<double> get lat =>
      $composableBuilder(column: $table.lat, builder: (column) => column);

  GeneratedColumn<double> get lon =>
      $composableBuilder(column: $table.lon, builder: (column) => column);

  GeneratedColumn<double> get ellipH =>
      $composableBuilder(column: $table.ellipH, builder: (column) => column);

  GeneratedColumn<double> get orthoH =>
      $composableBuilder(column: $table.orthoH, builder: (column) => column);

  GeneratedColumn<double> get accuracyH =>
      $composableBuilder(column: $table.accuracyH, builder: (column) => column);

  GeneratedColumn<double> get accuracyV =>
      $composableBuilder(column: $table.accuracyV, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<bool> get isFixed =>
      $composableBuilder(column: $table.isFixed, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AnchorsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AnchorsTable,
          Anchor,
          $$AnchorsTableFilterComposer,
          $$AnchorsTableOrderingComposer,
          $$AnchorsTableAnnotationComposer,
          $$AnchorsTableCreateCompanionBuilder,
          $$AnchorsTableUpdateCompanionBuilder,
          (Anchor, BaseReferences<_$AppDatabase, $AnchorsTable, Anchor>),
          Anchor,
          PrefetchHooks Function()
        > {
  $$AnchorsTableTableManager(_$AppDatabase db, $AnchorsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AnchorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AnchorsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AnchorsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<String?> deviceId = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<double> lat = const Value.absent(),
                Value<double> lon = const Value.absent(),
                Value<double> ellipH = const Value.absent(),
                Value<double?> orthoH = const Value.absent(),
                Value<double?> accuracyH = const Value.absent(),
                Value<double?> accuracyV = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<bool> isFixed = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AnchorsCompanion(
                id: id,
                sessionId: sessionId,
                deviceId: deviceId,
                label: label,
                lat: lat,
                lon: lon,
                ellipH: ellipH,
                orthoH: orthoH,
                accuracyH: accuracyH,
                accuracyV: accuracyV,
                source: source,
                isFixed: isFixed,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sessionId,
                Value<String?> deviceId = const Value.absent(),
                required String label,
                required double lat,
                required double lon,
                required double ellipH,
                Value<double?> orthoH = const Value.absent(),
                Value<double?> accuracyH = const Value.absent(),
                Value<double?> accuracyV = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<bool> isFixed = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => AnchorsCompanion.insert(
                id: id,
                sessionId: sessionId,
                deviceId: deviceId,
                label: label,
                lat: lat,
                lon: lon,
                ellipH: ellipH,
                orthoH: orthoH,
                accuracyH: accuracyH,
                accuracyV: accuracyV,
                source: source,
                isFixed: isFixed,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AnchorsTable, Anchor>(table),
                  BaseReferences<_$AppDatabase, $AnchorsTable, Anchor>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AnchorsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AnchorsTable,
      Anchor,
      $$AnchorsTableFilterComposer,
      $$AnchorsTableOrderingComposer,
      $$AnchorsTableAnnotationComposer,
      $$AnchorsTableCreateCompanionBuilder,
      $$AnchorsTableUpdateCompanionBuilder,
      (Anchor, BaseReferences<_$AppDatabase, $AnchorsTable, Anchor>),
      Anchor,
      PrefetchHooks Function()
    >;
typedef $$SurveyPointsTableCreateCompanionBuilder =
    SurveyPointsCompanion Function({
      required String id,
      required String projectId,
      required String sessionId,
      Value<String?> epochId,
      required String code,
      Value<String> layer,
      Value<String?> description,
      required double lat,
      required double lon,
      required double orthoH,
      required double accuracyH,
      Value<double?> accuracyV,
      required String method,
      required String quality,
      Value<String> status,
      required double poleHeight,
      Value<String?> photoPath,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$SurveyPointsTableUpdateCompanionBuilder =
    SurveyPointsCompanion Function({
      Value<String> id,
      Value<String> projectId,
      Value<String> sessionId,
      Value<String?> epochId,
      Value<String> code,
      Value<String> layer,
      Value<String?> description,
      Value<double> lat,
      Value<double> lon,
      Value<double> orthoH,
      Value<double> accuracyH,
      Value<double?> accuracyV,
      Value<String> method,
      Value<String> quality,
      Value<String> status,
      Value<double> poleHeight,
      Value<String?> photoPath,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$SurveyPointsTableFilterComposer
    extends Composer<_$AppDatabase, $SurveyPointsTable> {
  $$SurveyPointsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get projectId => $composableBuilder(
    column: $table.projectId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get epochId => $composableBuilder(
    column: $table.epochId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get layer => $composableBuilder(
    column: $table.layer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lon => $composableBuilder(
    column: $table.lon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get orthoH => $composableBuilder(
    column: $table.orthoH,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get accuracyH => $composableBuilder(
    column: $table.accuracyH,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get accuracyV => $composableBuilder(
    column: $table.accuracyV,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get quality => $composableBuilder(
    column: $table.quality,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get poleHeight => $composableBuilder(
    column: $table.poleHeight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SurveyPointsTableOrderingComposer
    extends Composer<_$AppDatabase, $SurveyPointsTable> {
  $$SurveyPointsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get projectId => $composableBuilder(
    column: $table.projectId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get epochId => $composableBuilder(
    column: $table.epochId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get layer => $composableBuilder(
    column: $table.layer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lon => $composableBuilder(
    column: $table.lon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get orthoH => $composableBuilder(
    column: $table.orthoH,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get accuracyH => $composableBuilder(
    column: $table.accuracyH,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get accuracyV => $composableBuilder(
    column: $table.accuracyV,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quality => $composableBuilder(
    column: $table.quality,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get poleHeight => $composableBuilder(
    column: $table.poleHeight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SurveyPointsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SurveyPointsTable> {
  $$SurveyPointsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get projectId =>
      $composableBuilder(column: $table.projectId, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<String> get epochId =>
      $composableBuilder(column: $table.epochId, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get layer =>
      $composableBuilder(column: $table.layer, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get lat =>
      $composableBuilder(column: $table.lat, builder: (column) => column);

  GeneratedColumn<double> get lon =>
      $composableBuilder(column: $table.lon, builder: (column) => column);

  GeneratedColumn<double> get orthoH =>
      $composableBuilder(column: $table.orthoH, builder: (column) => column);

  GeneratedColumn<double> get accuracyH =>
      $composableBuilder(column: $table.accuracyH, builder: (column) => column);

  GeneratedColumn<double> get accuracyV =>
      $composableBuilder(column: $table.accuracyV, builder: (column) => column);

  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<String> get quality =>
      $composableBuilder(column: $table.quality, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<double> get poleHeight => $composableBuilder(
    column: $table.poleHeight,
    builder: (column) => column,
  );

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SurveyPointsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SurveyPointsTable,
          SurveyPoint,
          $$SurveyPointsTableFilterComposer,
          $$SurveyPointsTableOrderingComposer,
          $$SurveyPointsTableAnnotationComposer,
          $$SurveyPointsTableCreateCompanionBuilder,
          $$SurveyPointsTableUpdateCompanionBuilder,
          (
            SurveyPoint,
            BaseReferences<_$AppDatabase, $SurveyPointsTable, SurveyPoint>,
          ),
          SurveyPoint,
          PrefetchHooks Function()
        > {
  $$SurveyPointsTableTableManager(_$AppDatabase db, $SurveyPointsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SurveyPointsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SurveyPointsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SurveyPointsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> projectId = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<String?> epochId = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> layer = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<double> lat = const Value.absent(),
                Value<double> lon = const Value.absent(),
                Value<double> orthoH = const Value.absent(),
                Value<double> accuracyH = const Value.absent(),
                Value<double?> accuracyV = const Value.absent(),
                Value<String> method = const Value.absent(),
                Value<String> quality = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<double> poleHeight = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SurveyPointsCompanion(
                id: id,
                projectId: projectId,
                sessionId: sessionId,
                epochId: epochId,
                code: code,
                layer: layer,
                description: description,
                lat: lat,
                lon: lon,
                orthoH: orthoH,
                accuracyH: accuracyH,
                accuracyV: accuracyV,
                method: method,
                quality: quality,
                status: status,
                poleHeight: poleHeight,
                photoPath: photoPath,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String projectId,
                required String sessionId,
                Value<String?> epochId = const Value.absent(),
                required String code,
                Value<String> layer = const Value.absent(),
                Value<String?> description = const Value.absent(),
                required double lat,
                required double lon,
                required double orthoH,
                required double accuracyH,
                Value<double?> accuracyV = const Value.absent(),
                required String method,
                required String quality,
                Value<String> status = const Value.absent(),
                required double poleHeight,
                Value<String?> photoPath = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => SurveyPointsCompanion.insert(
                id: id,
                projectId: projectId,
                sessionId: sessionId,
                epochId: epochId,
                code: code,
                layer: layer,
                description: description,
                lat: lat,
                lon: lon,
                orthoH: orthoH,
                accuracyH: accuracyH,
                accuracyV: accuracyV,
                method: method,
                quality: quality,
                status: status,
                poleHeight: poleHeight,
                photoPath: photoPath,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SurveyPointsTable, SurveyPoint>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $SurveyPointsTable,
                    SurveyPoint
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SurveyPointsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SurveyPointsTable,
      SurveyPoint,
      $$SurveyPointsTableFilterComposer,
      $$SurveyPointsTableOrderingComposer,
      $$SurveyPointsTableAnnotationComposer,
      $$SurveyPointsTableCreateCompanionBuilder,
      $$SurveyPointsTableUpdateCompanionBuilder,
      (
        SurveyPoint,
        BaseReferences<_$AppDatabase, $SurveyPointsTable, SurveyPoint>,
      ),
      SurveyPoint,
      PrefetchHooks Function()
    >;
typedef $$DiagnosticLogsTableCreateCompanionBuilder =
    DiagnosticLogsCompanion Function({
      required String id,
      Value<String?> sessionId,
      Value<String?> deviceId,
      required String category,
      required String message,
      Value<String?> payloadJson,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$DiagnosticLogsTableUpdateCompanionBuilder =
    DiagnosticLogsCompanion Function({
      Value<String> id,
      Value<String?> sessionId,
      Value<String?> deviceId,
      Value<String> category,
      Value<String> message,
      Value<String?> payloadJson,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$DiagnosticLogsTableFilterComposer
    extends Composer<_$AppDatabase, $DiagnosticLogsTable> {
  $$DiagnosticLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DiagnosticLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $DiagnosticLogsTable> {
  $$DiagnosticLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DiagnosticLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DiagnosticLogsTable> {
  $$DiagnosticLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$DiagnosticLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DiagnosticLogsTable,
          DiagnosticLog,
          $$DiagnosticLogsTableFilterComposer,
          $$DiagnosticLogsTableOrderingComposer,
          $$DiagnosticLogsTableAnnotationComposer,
          $$DiagnosticLogsTableCreateCompanionBuilder,
          $$DiagnosticLogsTableUpdateCompanionBuilder,
          (
            DiagnosticLog,
            BaseReferences<_$AppDatabase, $DiagnosticLogsTable, DiagnosticLog>,
          ),
          DiagnosticLog,
          PrefetchHooks Function()
        > {
  $$DiagnosticLogsTableTableManager(
    _$AppDatabase db,
    $DiagnosticLogsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DiagnosticLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DiagnosticLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DiagnosticLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> sessionId = const Value.absent(),
                Value<String?> deviceId = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> message = const Value.absent(),
                Value<String?> payloadJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DiagnosticLogsCompanion(
                id: id,
                sessionId: sessionId,
                deviceId: deviceId,
                category: category,
                message: message,
                payloadJson: payloadJson,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> sessionId = const Value.absent(),
                Value<String?> deviceId = const Value.absent(),
                required String category,
                required String message,
                Value<String?> payloadJson = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => DiagnosticLogsCompanion.insert(
                id: id,
                sessionId: sessionId,
                deviceId: deviceId,
                category: category,
                message: message,
                payloadJson: payloadJson,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DiagnosticLogsTable, DiagnosticLog>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $DiagnosticLogsTable,
                    DiagnosticLog
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DiagnosticLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DiagnosticLogsTable,
      DiagnosticLog,
      $$DiagnosticLogsTableFilterComposer,
      $$DiagnosticLogsTableOrderingComposer,
      $$DiagnosticLogsTableAnnotationComposer,
      $$DiagnosticLogsTableCreateCompanionBuilder,
      $$DiagnosticLogsTableUpdateCompanionBuilder,
      (
        DiagnosticLog,
        BaseReferences<_$AppDatabase, $DiagnosticLogsTable, DiagnosticLog>,
      ),
      DiagnosticLog,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProjectsTableTableManager get projects =>
      $$ProjectsTableTableManager(_db, _db.projects);
  $$SessionsTableTableManager get sessions =>
      $$SessionsTableTableManager(_db, _db.sessions);
  $$DevicesTableTableManager get devices =>
      $$DevicesTableTableManager(_db, _db.devices);
  $$EpochsTableTableManager get epochs =>
      $$EpochsTableTableManager(_db, _db.epochs);
  $$GnssObservationsTableTableManager get gnssObservations =>
      $$GnssObservationsTableTableManager(_db, _db.gnssObservations);
  $$BaroObservationsTableTableManager get baroObservations =>
      $$BaroObservationsTableTableManager(_db, _db.baroObservations);
  $$BleMeasurementsTableTableManager get bleMeasurements =>
      $$BleMeasurementsTableTableManager(_db, _db.bleMeasurements);
  $$AnchorsTableTableManager get anchors =>
      $$AnchorsTableTableManager(_db, _db.anchors);
  $$SurveyPointsTableTableManager get surveyPoints =>
      $$SurveyPointsTableTableManager(_db, _db.surveyPoints);
  $$DiagnosticLogsTableTableManager get diagnosticLogs =>
      $$DiagnosticLogsTableTableManager(_db, _db.diagnosticLogs);
}
