// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $SleepEntriesTable extends SleepEntries
    with TableInfo<$SleepEntriesTable, SleepEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SleepEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _bedtimeMeta = const VerificationMeta(
    'bedtime',
  );
  @override
  late final GeneratedColumn<DateTime> bedtime = GeneratedColumn<DateTime>(
    'bedtime',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wakeTimeMeta = const VerificationMeta(
    'wakeTime',
  );
  @override
  late final GeneratedColumn<DateTime> wakeTime = GeneratedColumn<DateTime>(
    'wake_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deepMinutesMeta = const VerificationMeta(
    'deepMinutes',
  );
  @override
  late final GeneratedColumn<int> deepMinutes = GeneratedColumn<int>(
    'deep_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remMinutesMeta = const VerificationMeta(
    'remMinutes',
  );
  @override
  late final GeneratedColumn<int> remMinutes = GeneratedColumn<int>(
    'rem_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lightMinutesMeta = const VerificationMeta(
    'lightMinutes',
  );
  @override
  late final GeneratedColumn<int> lightMinutes = GeneratedColumn<int>(
    'light_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _restingHeartRateMeta = const VerificationMeta(
    'restingHeartRate',
  );
  @override
  late final GeneratedColumn<int> restingHeartRate = GeneratedColumn<int>(
    'resting_heart_rate',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hrvMsMeta = const VerificationMeta('hrvMs');
  @override
  late final GeneratedColumn<int> hrvMs = GeneratedColumn<int>(
    'hrv_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _moodMeta = const VerificationMeta('mood');
  @override
  late final GeneratedColumn<int> mood = GeneratedColumn<int>(
    'mood',
    aliasedName,
    true,
    type: DriftSqlType.int,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bedtime,
    wakeTime,
    deepMinutes,
    remMinutes,
    lightMinutes,
    restingHeartRate,
    hrvMs,
    mood,
    source,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sleep_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<SleepEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('bedtime')) {
      context.handle(
        _bedtimeMeta,
        bedtime.isAcceptableOrUnknown(data['bedtime']!, _bedtimeMeta),
      );
    } else if (isInserting) {
      context.missing(_bedtimeMeta);
    }
    if (data.containsKey('wake_time')) {
      context.handle(
        _wakeTimeMeta,
        wakeTime.isAcceptableOrUnknown(data['wake_time']!, _wakeTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_wakeTimeMeta);
    }
    if (data.containsKey('deep_minutes')) {
      context.handle(
        _deepMinutesMeta,
        deepMinutes.isAcceptableOrUnknown(
          data['deep_minutes']!,
          _deepMinutesMeta,
        ),
      );
    }
    if (data.containsKey('rem_minutes')) {
      context.handle(
        _remMinutesMeta,
        remMinutes.isAcceptableOrUnknown(data['rem_minutes']!, _remMinutesMeta),
      );
    }
    if (data.containsKey('light_minutes')) {
      context.handle(
        _lightMinutesMeta,
        lightMinutes.isAcceptableOrUnknown(
          data['light_minutes']!,
          _lightMinutesMeta,
        ),
      );
    }
    if (data.containsKey('resting_heart_rate')) {
      context.handle(
        _restingHeartRateMeta,
        restingHeartRate.isAcceptableOrUnknown(
          data['resting_heart_rate']!,
          _restingHeartRateMeta,
        ),
      );
    }
    if (data.containsKey('hrv_ms')) {
      context.handle(
        _hrvMsMeta,
        hrvMs.isAcceptableOrUnknown(data['hrv_ms']!, _hrvMsMeta),
      );
    }
    if (data.containsKey('mood')) {
      context.handle(
        _moodMeta,
        mood.isAcceptableOrUnknown(data['mood']!, _moodMeta),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SleepEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SleepEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      bedtime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}bedtime'],
      )!,
      wakeTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}wake_time'],
      )!,
      deepMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deep_minutes'],
      ),
      remMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rem_minutes'],
      ),
      lightMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}light_minutes'],
      ),
      restingHeartRate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}resting_heart_rate'],
      ),
      hrvMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hrv_ms'],
      ),
      mood: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mood'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
    );
  }

  @override
  $SleepEntriesTable createAlias(String alias) {
    return $SleepEntriesTable(attachedDatabase, alias);
  }
}

class SleepEntry extends DataClass implements Insertable<SleepEntry> {
  final int id;
  final DateTime bedtime;
  final DateTime wakeTime;
  final int? deepMinutes;
  final int? remMinutes;
  final int? lightMinutes;
  final int? restingHeartRate;
  final int? hrvMs;

  /// Morning check-in, 1 (drained) to 5 (fresh).
  final int? mood;

  /// 'manual' or 'health_connect'.
  final String source;
  const SleepEntry({
    required this.id,
    required this.bedtime,
    required this.wakeTime,
    this.deepMinutes,
    this.remMinutes,
    this.lightMinutes,
    this.restingHeartRate,
    this.hrvMs,
    this.mood,
    required this.source,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['bedtime'] = Variable<DateTime>(bedtime);
    map['wake_time'] = Variable<DateTime>(wakeTime);
    if (!nullToAbsent || deepMinutes != null) {
      map['deep_minutes'] = Variable<int>(deepMinutes);
    }
    if (!nullToAbsent || remMinutes != null) {
      map['rem_minutes'] = Variable<int>(remMinutes);
    }
    if (!nullToAbsent || lightMinutes != null) {
      map['light_minutes'] = Variable<int>(lightMinutes);
    }
    if (!nullToAbsent || restingHeartRate != null) {
      map['resting_heart_rate'] = Variable<int>(restingHeartRate);
    }
    if (!nullToAbsent || hrvMs != null) {
      map['hrv_ms'] = Variable<int>(hrvMs);
    }
    if (!nullToAbsent || mood != null) {
      map['mood'] = Variable<int>(mood);
    }
    map['source'] = Variable<String>(source);
    return map;
  }

  SleepEntriesCompanion toCompanion(bool nullToAbsent) {
    return SleepEntriesCompanion(
      id: Value(id),
      bedtime: Value(bedtime),
      wakeTime: Value(wakeTime),
      deepMinutes: deepMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(deepMinutes),
      remMinutes: remMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(remMinutes),
      lightMinutes: lightMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(lightMinutes),
      restingHeartRate: restingHeartRate == null && nullToAbsent
          ? const Value.absent()
          : Value(restingHeartRate),
      hrvMs: hrvMs == null && nullToAbsent
          ? const Value.absent()
          : Value(hrvMs),
      mood: mood == null && nullToAbsent ? const Value.absent() : Value(mood),
      source: Value(source),
    );
  }

  factory SleepEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SleepEntry(
      id: serializer.fromJson<int>(json['id']),
      bedtime: serializer.fromJson<DateTime>(json['bedtime']),
      wakeTime: serializer.fromJson<DateTime>(json['wakeTime']),
      deepMinutes: serializer.fromJson<int?>(json['deepMinutes']),
      remMinutes: serializer.fromJson<int?>(json['remMinutes']),
      lightMinutes: serializer.fromJson<int?>(json['lightMinutes']),
      restingHeartRate: serializer.fromJson<int?>(json['restingHeartRate']),
      hrvMs: serializer.fromJson<int?>(json['hrvMs']),
      mood: serializer.fromJson<int?>(json['mood']),
      source: serializer.fromJson<String>(json['source']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bedtime': serializer.toJson<DateTime>(bedtime),
      'wakeTime': serializer.toJson<DateTime>(wakeTime),
      'deepMinutes': serializer.toJson<int?>(deepMinutes),
      'remMinutes': serializer.toJson<int?>(remMinutes),
      'lightMinutes': serializer.toJson<int?>(lightMinutes),
      'restingHeartRate': serializer.toJson<int?>(restingHeartRate),
      'hrvMs': serializer.toJson<int?>(hrvMs),
      'mood': serializer.toJson<int?>(mood),
      'source': serializer.toJson<String>(source),
    };
  }

  SleepEntry copyWith({
    int? id,
    DateTime? bedtime,
    DateTime? wakeTime,
    Value<int?> deepMinutes = const Value.absent(),
    Value<int?> remMinutes = const Value.absent(),
    Value<int?> lightMinutes = const Value.absent(),
    Value<int?> restingHeartRate = const Value.absent(),
    Value<int?> hrvMs = const Value.absent(),
    Value<int?> mood = const Value.absent(),
    String? source,
  }) => SleepEntry(
    id: id ?? this.id,
    bedtime: bedtime ?? this.bedtime,
    wakeTime: wakeTime ?? this.wakeTime,
    deepMinutes: deepMinutes.present ? deepMinutes.value : this.deepMinutes,
    remMinutes: remMinutes.present ? remMinutes.value : this.remMinutes,
    lightMinutes: lightMinutes.present ? lightMinutes.value : this.lightMinutes,
    restingHeartRate: restingHeartRate.present
        ? restingHeartRate.value
        : this.restingHeartRate,
    hrvMs: hrvMs.present ? hrvMs.value : this.hrvMs,
    mood: mood.present ? mood.value : this.mood,
    source: source ?? this.source,
  );
  SleepEntry copyWithCompanion(SleepEntriesCompanion data) {
    return SleepEntry(
      id: data.id.present ? data.id.value : this.id,
      bedtime: data.bedtime.present ? data.bedtime.value : this.bedtime,
      wakeTime: data.wakeTime.present ? data.wakeTime.value : this.wakeTime,
      deepMinutes: data.deepMinutes.present
          ? data.deepMinutes.value
          : this.deepMinutes,
      remMinutes: data.remMinutes.present
          ? data.remMinutes.value
          : this.remMinutes,
      lightMinutes: data.lightMinutes.present
          ? data.lightMinutes.value
          : this.lightMinutes,
      restingHeartRate: data.restingHeartRate.present
          ? data.restingHeartRate.value
          : this.restingHeartRate,
      hrvMs: data.hrvMs.present ? data.hrvMs.value : this.hrvMs,
      mood: data.mood.present ? data.mood.value : this.mood,
      source: data.source.present ? data.source.value : this.source,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SleepEntry(')
          ..write('id: $id, ')
          ..write('bedtime: $bedtime, ')
          ..write('wakeTime: $wakeTime, ')
          ..write('deepMinutes: $deepMinutes, ')
          ..write('remMinutes: $remMinutes, ')
          ..write('lightMinutes: $lightMinutes, ')
          ..write('restingHeartRate: $restingHeartRate, ')
          ..write('hrvMs: $hrvMs, ')
          ..write('mood: $mood, ')
          ..write('source: $source')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    bedtime,
    wakeTime,
    deepMinutes,
    remMinutes,
    lightMinutes,
    restingHeartRate,
    hrvMs,
    mood,
    source,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SleepEntry &&
          other.id == this.id &&
          other.bedtime == this.bedtime &&
          other.wakeTime == this.wakeTime &&
          other.deepMinutes == this.deepMinutes &&
          other.remMinutes == this.remMinutes &&
          other.lightMinutes == this.lightMinutes &&
          other.restingHeartRate == this.restingHeartRate &&
          other.hrvMs == this.hrvMs &&
          other.mood == this.mood &&
          other.source == this.source);
}

class SleepEntriesCompanion extends UpdateCompanion<SleepEntry> {
  final Value<int> id;
  final Value<DateTime> bedtime;
  final Value<DateTime> wakeTime;
  final Value<int?> deepMinutes;
  final Value<int?> remMinutes;
  final Value<int?> lightMinutes;
  final Value<int?> restingHeartRate;
  final Value<int?> hrvMs;
  final Value<int?> mood;
  final Value<String> source;
  const SleepEntriesCompanion({
    this.id = const Value.absent(),
    this.bedtime = const Value.absent(),
    this.wakeTime = const Value.absent(),
    this.deepMinutes = const Value.absent(),
    this.remMinutes = const Value.absent(),
    this.lightMinutes = const Value.absent(),
    this.restingHeartRate = const Value.absent(),
    this.hrvMs = const Value.absent(),
    this.mood = const Value.absent(),
    this.source = const Value.absent(),
  });
  SleepEntriesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime bedtime,
    required DateTime wakeTime,
    this.deepMinutes = const Value.absent(),
    this.remMinutes = const Value.absent(),
    this.lightMinutes = const Value.absent(),
    this.restingHeartRate = const Value.absent(),
    this.hrvMs = const Value.absent(),
    this.mood = const Value.absent(),
    this.source = const Value.absent(),
  }) : bedtime = Value(bedtime),
       wakeTime = Value(wakeTime);
  static Insertable<SleepEntry> custom({
    Expression<int>? id,
    Expression<DateTime>? bedtime,
    Expression<DateTime>? wakeTime,
    Expression<int>? deepMinutes,
    Expression<int>? remMinutes,
    Expression<int>? lightMinutes,
    Expression<int>? restingHeartRate,
    Expression<int>? hrvMs,
    Expression<int>? mood,
    Expression<String>? source,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bedtime != null) 'bedtime': bedtime,
      if (wakeTime != null) 'wake_time': wakeTime,
      if (deepMinutes != null) 'deep_minutes': deepMinutes,
      if (remMinutes != null) 'rem_minutes': remMinutes,
      if (lightMinutes != null) 'light_minutes': lightMinutes,
      if (restingHeartRate != null) 'resting_heart_rate': restingHeartRate,
      if (hrvMs != null) 'hrv_ms': hrvMs,
      if (mood != null) 'mood': mood,
      if (source != null) 'source': source,
    });
  }

  SleepEntriesCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? bedtime,
    Value<DateTime>? wakeTime,
    Value<int?>? deepMinutes,
    Value<int?>? remMinutes,
    Value<int?>? lightMinutes,
    Value<int?>? restingHeartRate,
    Value<int?>? hrvMs,
    Value<int?>? mood,
    Value<String>? source,
  }) {
    return SleepEntriesCompanion(
      id: id ?? this.id,
      bedtime: bedtime ?? this.bedtime,
      wakeTime: wakeTime ?? this.wakeTime,
      deepMinutes: deepMinutes ?? this.deepMinutes,
      remMinutes: remMinutes ?? this.remMinutes,
      lightMinutes: lightMinutes ?? this.lightMinutes,
      restingHeartRate: restingHeartRate ?? this.restingHeartRate,
      hrvMs: hrvMs ?? this.hrvMs,
      mood: mood ?? this.mood,
      source: source ?? this.source,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bedtime.present) {
      map['bedtime'] = Variable<DateTime>(bedtime.value);
    }
    if (wakeTime.present) {
      map['wake_time'] = Variable<DateTime>(wakeTime.value);
    }
    if (deepMinutes.present) {
      map['deep_minutes'] = Variable<int>(deepMinutes.value);
    }
    if (remMinutes.present) {
      map['rem_minutes'] = Variable<int>(remMinutes.value);
    }
    if (lightMinutes.present) {
      map['light_minutes'] = Variable<int>(lightMinutes.value);
    }
    if (restingHeartRate.present) {
      map['resting_heart_rate'] = Variable<int>(restingHeartRate.value);
    }
    if (hrvMs.present) {
      map['hrv_ms'] = Variable<int>(hrvMs.value);
    }
    if (mood.present) {
      map['mood'] = Variable<int>(mood.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SleepEntriesCompanion(')
          ..write('id: $id, ')
          ..write('bedtime: $bedtime, ')
          ..write('wakeTime: $wakeTime, ')
          ..write('deepMinutes: $deepMinutes, ')
          ..write('remMinutes: $remMinutes, ')
          ..write('lightMinutes: $lightMinutes, ')
          ..write('restingHeartRate: $restingHeartRate, ')
          ..write('hrvMs: $hrvMs, ')
          ..write('mood: $mood, ')
          ..write('source: $source')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, SettingsRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _userNameMeta = const VerificationMeta(
    'userName',
  );
  @override
  late final GeneratedColumn<String> userName = GeneratedColumn<String>(
    'user_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Chauka'),
  );
  static const VerificationMeta _sleepGoalMinutesMeta = const VerificationMeta(
    'sleepGoalMinutes',
  );
  @override
  late final GeneratedColumn<int> sleepGoalMinutes = GeneratedColumn<int>(
    'sleep_goal_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(480),
  );
  static const VerificationMeta _bedtimeGoalMinutesMeta =
      const VerificationMeta('bedtimeGoalMinutes');
  @override
  late final GeneratedColumn<int> bedtimeGoalMinutes = GeneratedColumn<int>(
    'bedtime_goal_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1365),
  );
  static const VerificationMeta _bedtimeReminderMeta = const VerificationMeta(
    'bedtimeReminder',
  );
  @override
  late final GeneratedColumn<bool> bedtimeReminder = GeneratedColumn<bool>(
    'bedtime_reminder',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("bedtime_reminder" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userName,
    sleepGoalMinutes,
    bedtimeGoalMinutes,
    bedtimeReminder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<SettingsRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_name')) {
      context.handle(
        _userNameMeta,
        userName.isAcceptableOrUnknown(data['user_name']!, _userNameMeta),
      );
    }
    if (data.containsKey('sleep_goal_minutes')) {
      context.handle(
        _sleepGoalMinutesMeta,
        sleepGoalMinutes.isAcceptableOrUnknown(
          data['sleep_goal_minutes']!,
          _sleepGoalMinutesMeta,
        ),
      );
    }
    if (data.containsKey('bedtime_goal_minutes')) {
      context.handle(
        _bedtimeGoalMinutesMeta,
        bedtimeGoalMinutes.isAcceptableOrUnknown(
          data['bedtime_goal_minutes']!,
          _bedtimeGoalMinutesMeta,
        ),
      );
    }
    if (data.containsKey('bedtime_reminder')) {
      context.handle(
        _bedtimeReminderMeta,
        bedtimeReminder.isAcceptableOrUnknown(
          data['bedtime_reminder']!,
          _bedtimeReminderMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SettingsRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingsRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_name'],
      )!,
      sleepGoalMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sleep_goal_minutes'],
      )!,
      bedtimeGoalMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bedtime_goal_minutes'],
      )!,
      bedtimeReminder: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}bedtime_reminder'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class SettingsRow extends DataClass implements Insertable<SettingsRow> {
  final int id;
  final String userName;

  /// Sleep goal in minutes (480 = 8 hours).
  final int sleepGoalMinutes;

  /// Bedtime goal as minutes after midnight (1365 = 10:45 PM).
  final int bedtimeGoalMinutes;
  final bool bedtimeReminder;
  const SettingsRow({
    required this.id,
    required this.userName,
    required this.sleepGoalMinutes,
    required this.bedtimeGoalMinutes,
    required this.bedtimeReminder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_name'] = Variable<String>(userName);
    map['sleep_goal_minutes'] = Variable<int>(sleepGoalMinutes);
    map['bedtime_goal_minutes'] = Variable<int>(bedtimeGoalMinutes);
    map['bedtime_reminder'] = Variable<bool>(bedtimeReminder);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      userName: Value(userName),
      sleepGoalMinutes: Value(sleepGoalMinutes),
      bedtimeGoalMinutes: Value(bedtimeGoalMinutes),
      bedtimeReminder: Value(bedtimeReminder),
    );
  }

  factory SettingsRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingsRow(
      id: serializer.fromJson<int>(json['id']),
      userName: serializer.fromJson<String>(json['userName']),
      sleepGoalMinutes: serializer.fromJson<int>(json['sleepGoalMinutes']),
      bedtimeGoalMinutes: serializer.fromJson<int>(json['bedtimeGoalMinutes']),
      bedtimeReminder: serializer.fromJson<bool>(json['bedtimeReminder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userName': serializer.toJson<String>(userName),
      'sleepGoalMinutes': serializer.toJson<int>(sleepGoalMinutes),
      'bedtimeGoalMinutes': serializer.toJson<int>(bedtimeGoalMinutes),
      'bedtimeReminder': serializer.toJson<bool>(bedtimeReminder),
    };
  }

  SettingsRow copyWith({
    int? id,
    String? userName,
    int? sleepGoalMinutes,
    int? bedtimeGoalMinutes,
    bool? bedtimeReminder,
  }) => SettingsRow(
    id: id ?? this.id,
    userName: userName ?? this.userName,
    sleepGoalMinutes: sleepGoalMinutes ?? this.sleepGoalMinutes,
    bedtimeGoalMinutes: bedtimeGoalMinutes ?? this.bedtimeGoalMinutes,
    bedtimeReminder: bedtimeReminder ?? this.bedtimeReminder,
  );
  SettingsRow copyWithCompanion(AppSettingsCompanion data) {
    return SettingsRow(
      id: data.id.present ? data.id.value : this.id,
      userName: data.userName.present ? data.userName.value : this.userName,
      sleepGoalMinutes: data.sleepGoalMinutes.present
          ? data.sleepGoalMinutes.value
          : this.sleepGoalMinutes,
      bedtimeGoalMinutes: data.bedtimeGoalMinutes.present
          ? data.bedtimeGoalMinutes.value
          : this.bedtimeGoalMinutes,
      bedtimeReminder: data.bedtimeReminder.present
          ? data.bedtimeReminder.value
          : this.bedtimeReminder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingsRow(')
          ..write('id: $id, ')
          ..write('userName: $userName, ')
          ..write('sleepGoalMinutes: $sleepGoalMinutes, ')
          ..write('bedtimeGoalMinutes: $bedtimeGoalMinutes, ')
          ..write('bedtimeReminder: $bedtimeReminder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userName,
    sleepGoalMinutes,
    bedtimeGoalMinutes,
    bedtimeReminder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingsRow &&
          other.id == this.id &&
          other.userName == this.userName &&
          other.sleepGoalMinutes == this.sleepGoalMinutes &&
          other.bedtimeGoalMinutes == this.bedtimeGoalMinutes &&
          other.bedtimeReminder == this.bedtimeReminder);
}

class AppSettingsCompanion extends UpdateCompanion<SettingsRow> {
  final Value<int> id;
  final Value<String> userName;
  final Value<int> sleepGoalMinutes;
  final Value<int> bedtimeGoalMinutes;
  final Value<bool> bedtimeReminder;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.userName = const Value.absent(),
    this.sleepGoalMinutes = const Value.absent(),
    this.bedtimeGoalMinutes = const Value.absent(),
    this.bedtimeReminder = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.userName = const Value.absent(),
    this.sleepGoalMinutes = const Value.absent(),
    this.bedtimeGoalMinutes = const Value.absent(),
    this.bedtimeReminder = const Value.absent(),
  });
  static Insertable<SettingsRow> custom({
    Expression<int>? id,
    Expression<String>? userName,
    Expression<int>? sleepGoalMinutes,
    Expression<int>? bedtimeGoalMinutes,
    Expression<bool>? bedtimeReminder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userName != null) 'user_name': userName,
      if (sleepGoalMinutes != null) 'sleep_goal_minutes': sleepGoalMinutes,
      if (bedtimeGoalMinutes != null)
        'bedtime_goal_minutes': bedtimeGoalMinutes,
      if (bedtimeReminder != null) 'bedtime_reminder': bedtimeReminder,
    });
  }

  AppSettingsCompanion copyWith({
    Value<int>? id,
    Value<String>? userName,
    Value<int>? sleepGoalMinutes,
    Value<int>? bedtimeGoalMinutes,
    Value<bool>? bedtimeReminder,
  }) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      sleepGoalMinutes: sleepGoalMinutes ?? this.sleepGoalMinutes,
      bedtimeGoalMinutes: bedtimeGoalMinutes ?? this.bedtimeGoalMinutes,
      bedtimeReminder: bedtimeReminder ?? this.bedtimeReminder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userName.present) {
      map['user_name'] = Variable<String>(userName.value);
    }
    if (sleepGoalMinutes.present) {
      map['sleep_goal_minutes'] = Variable<int>(sleepGoalMinutes.value);
    }
    if (bedtimeGoalMinutes.present) {
      map['bedtime_goal_minutes'] = Variable<int>(bedtimeGoalMinutes.value);
    }
    if (bedtimeReminder.present) {
      map['bedtime_reminder'] = Variable<bool>(bedtimeReminder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('userName: $userName, ')
          ..write('sleepGoalMinutes: $sleepGoalMinutes, ')
          ..write('bedtimeGoalMinutes: $bedtimeGoalMinutes, ')
          ..write('bedtimeReminder: $bedtimeReminder')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SleepEntriesTable sleepEntries = $SleepEntriesTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    sleepEntries,
    appSettings,
  ];
}

typedef $$SleepEntriesTableCreateCompanionBuilder =
    SleepEntriesCompanion Function({
      Value<int> id,
      required DateTime bedtime,
      required DateTime wakeTime,
      Value<int?> deepMinutes,
      Value<int?> remMinutes,
      Value<int?> lightMinutes,
      Value<int?> restingHeartRate,
      Value<int?> hrvMs,
      Value<int?> mood,
      Value<String> source,
    });
typedef $$SleepEntriesTableUpdateCompanionBuilder =
    SleepEntriesCompanion Function({
      Value<int> id,
      Value<DateTime> bedtime,
      Value<DateTime> wakeTime,
      Value<int?> deepMinutes,
      Value<int?> remMinutes,
      Value<int?> lightMinutes,
      Value<int?> restingHeartRate,
      Value<int?> hrvMs,
      Value<int?> mood,
      Value<String> source,
    });

class $$SleepEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $SleepEntriesTable> {
  $$SleepEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get bedtime => $composableBuilder(
    column: $table.bedtime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get wakeTime => $composableBuilder(
    column: $table.wakeTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deepMinutes => $composableBuilder(
    column: $table.deepMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get remMinutes => $composableBuilder(
    column: $table.remMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lightMinutes => $composableBuilder(
    column: $table.lightMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get restingHeartRate => $composableBuilder(
    column: $table.restingHeartRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hrvMs => $composableBuilder(
    column: $table.hrvMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get mood => $composableBuilder(
    column: $table.mood,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SleepEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $SleepEntriesTable> {
  $$SleepEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get bedtime => $composableBuilder(
    column: $table.bedtime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get wakeTime => $composableBuilder(
    column: $table.wakeTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deepMinutes => $composableBuilder(
    column: $table.deepMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get remMinutes => $composableBuilder(
    column: $table.remMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lightMinutes => $composableBuilder(
    column: $table.lightMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get restingHeartRate => $composableBuilder(
    column: $table.restingHeartRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hrvMs => $composableBuilder(
    column: $table.hrvMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mood => $composableBuilder(
    column: $table.mood,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SleepEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SleepEntriesTable> {
  $$SleepEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get bedtime =>
      $composableBuilder(column: $table.bedtime, builder: (column) => column);

  GeneratedColumn<DateTime> get wakeTime =>
      $composableBuilder(column: $table.wakeTime, builder: (column) => column);

  GeneratedColumn<int> get deepMinutes => $composableBuilder(
    column: $table.deepMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get remMinutes => $composableBuilder(
    column: $table.remMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lightMinutes => $composableBuilder(
    column: $table.lightMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get restingHeartRate => $composableBuilder(
    column: $table.restingHeartRate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get hrvMs =>
      $composableBuilder(column: $table.hrvMs, builder: (column) => column);

  GeneratedColumn<int> get mood =>
      $composableBuilder(column: $table.mood, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);
}

class $$SleepEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SleepEntriesTable,
          SleepEntry,
          $$SleepEntriesTableFilterComposer,
          $$SleepEntriesTableOrderingComposer,
          $$SleepEntriesTableAnnotationComposer,
          $$SleepEntriesTableCreateCompanionBuilder,
          $$SleepEntriesTableUpdateCompanionBuilder,
          (
            SleepEntry,
            BaseReferences<_$AppDatabase, $SleepEntriesTable, SleepEntry>,
          ),
          SleepEntry,
          PrefetchHooks Function()
        > {
  $$SleepEntriesTableTableManager(_$AppDatabase db, $SleepEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SleepEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SleepEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SleepEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> bedtime = const Value.absent(),
                Value<DateTime> wakeTime = const Value.absent(),
                Value<int?> deepMinutes = const Value.absent(),
                Value<int?> remMinutes = const Value.absent(),
                Value<int?> lightMinutes = const Value.absent(),
                Value<int?> restingHeartRate = const Value.absent(),
                Value<int?> hrvMs = const Value.absent(),
                Value<int?> mood = const Value.absent(),
                Value<String> source = const Value.absent(),
              }) => SleepEntriesCompanion(
                id: id,
                bedtime: bedtime,
                wakeTime: wakeTime,
                deepMinutes: deepMinutes,
                remMinutes: remMinutes,
                lightMinutes: lightMinutes,
                restingHeartRate: restingHeartRate,
                hrvMs: hrvMs,
                mood: mood,
                source: source,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime bedtime,
                required DateTime wakeTime,
                Value<int?> deepMinutes = const Value.absent(),
                Value<int?> remMinutes = const Value.absent(),
                Value<int?> lightMinutes = const Value.absent(),
                Value<int?> restingHeartRate = const Value.absent(),
                Value<int?> hrvMs = const Value.absent(),
                Value<int?> mood = const Value.absent(),
                Value<String> source = const Value.absent(),
              }) => SleepEntriesCompanion.insert(
                id: id,
                bedtime: bedtime,
                wakeTime: wakeTime,
                deepMinutes: deepMinutes,
                remMinutes: remMinutes,
                lightMinutes: lightMinutes,
                restingHeartRate: restingHeartRate,
                hrvMs: hrvMs,
                mood: mood,
                source: source,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SleepEntriesTable, SleepEntry>(table),
                  BaseReferences<_$AppDatabase, $SleepEntriesTable, SleepEntry>(
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

typedef $$SleepEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SleepEntriesTable,
      SleepEntry,
      $$SleepEntriesTableFilterComposer,
      $$SleepEntriesTableOrderingComposer,
      $$SleepEntriesTableAnnotationComposer,
      $$SleepEntriesTableCreateCompanionBuilder,
      $$SleepEntriesTableUpdateCompanionBuilder,
      (
        SleepEntry,
        BaseReferences<_$AppDatabase, $SleepEntriesTable, SleepEntry>,
      ),
      SleepEntry,
      PrefetchHooks Function()
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<String> userName,
      Value<int> sleepGoalMinutes,
      Value<int> bedtimeGoalMinutes,
      Value<bool> bedtimeReminder,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<String> userName,
      Value<int> sleepGoalMinutes,
      Value<int> bedtimeGoalMinutes,
      Value<bool> bedtimeReminder,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userName => $composableBuilder(
    column: $table.userName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sleepGoalMinutes => $composableBuilder(
    column: $table.sleepGoalMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bedtimeGoalMinutes => $composableBuilder(
    column: $table.bedtimeGoalMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get bedtimeReminder => $composableBuilder(
    column: $table.bedtimeReminder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userName => $composableBuilder(
    column: $table.userName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sleepGoalMinutes => $composableBuilder(
    column: $table.sleepGoalMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bedtimeGoalMinutes => $composableBuilder(
    column: $table.bedtimeGoalMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get bedtimeReminder => $composableBuilder(
    column: $table.bedtimeReminder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userName =>
      $composableBuilder(column: $table.userName, builder: (column) => column);

  GeneratedColumn<int> get sleepGoalMinutes => $composableBuilder(
    column: $table.sleepGoalMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get bedtimeGoalMinutes => $composableBuilder(
    column: $table.bedtimeGoalMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get bedtimeReminder => $composableBuilder(
    column: $table.bedtimeReminder,
    builder: (column) => column,
  );
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          SettingsRow,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            SettingsRow,
            BaseReferences<_$AppDatabase, $AppSettingsTable, SettingsRow>,
          ),
          SettingsRow,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userName = const Value.absent(),
                Value<int> sleepGoalMinutes = const Value.absent(),
                Value<int> bedtimeGoalMinutes = const Value.absent(),
                Value<bool> bedtimeReminder = const Value.absent(),
              }) => AppSettingsCompanion(
                id: id,
                userName: userName,
                sleepGoalMinutes: sleepGoalMinutes,
                bedtimeGoalMinutes: bedtimeGoalMinutes,
                bedtimeReminder: bedtimeReminder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userName = const Value.absent(),
                Value<int> sleepGoalMinutes = const Value.absent(),
                Value<int> bedtimeGoalMinutes = const Value.absent(),
                Value<bool> bedtimeReminder = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                id: id,
                userName: userName,
                sleepGoalMinutes: sleepGoalMinutes,
                bedtimeGoalMinutes: bedtimeGoalMinutes,
                bedtimeReminder: bedtimeReminder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppSettingsTable, SettingsRow>(table),
                  BaseReferences<_$AppDatabase, $AppSettingsTable, SettingsRow>(
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

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      SettingsRow,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        SettingsRow,
        BaseReferences<_$AppDatabase, $AppSettingsTable, SettingsRow>,
      ),
      SettingsRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SleepEntriesTableTableManager get sleepEntries =>
      $$SleepEntriesTableTableManager(_db, _db.sleepEntries);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
}
