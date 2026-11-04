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
  static const VerificationMeta _awakeMinutesMeta = const VerificationMeta(
    'awakeMinutes',
  );
  @override
  late final GeneratedColumn<int> awakeMinutes = GeneratedColumn<int>(
    'awake_minutes',
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
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isNapMeta = const VerificationMeta('isNap');
  @override
  late final GeneratedColumn<bool> isNap = GeneratedColumn<bool>(
    'is_nap',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_nap" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _externalIdMeta = const VerificationMeta(
    'externalId',
  );
  @override
  late final GeneratedColumn<String> externalId = GeneratedColumn<String>(
    'external_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bedtime,
    wakeTime,
    deepMinutes,
    remMinutes,
    lightMinutes,
    awakeMinutes,
    restingHeartRate,
    hrvMs,
    mood,
    source,
    tags,
    note,
    isNap,
    externalId,
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
    if (data.containsKey('awake_minutes')) {
      context.handle(
        _awakeMinutesMeta,
        awakeMinutes.isAcceptableOrUnknown(
          data['awake_minutes']!,
          _awakeMinutesMeta,
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
    if (data.containsKey('tags')) {
      context.handle(
        _tagsMeta,
        tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('is_nap')) {
      context.handle(
        _isNapMeta,
        isNap.isAcceptableOrUnknown(data['is_nap']!, _isNapMeta),
      );
    }
    if (data.containsKey('external_id')) {
      context.handle(
        _externalIdMeta,
        externalId.isAcceptableOrUnknown(data['external_id']!, _externalIdMeta),
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
      awakeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}awake_minutes'],
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
      tags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      isNap: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_nap'],
      )!,
      externalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}external_id'],
      ),
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

  /// v2: minutes awake during the session (from a watch).
  final int? awakeMinutes;
  final int? restingHeartRate;
  final int? hrvMs;

  /// Morning check-in, 1 (drained) to 5 (fresh).
  final int? mood;

  /// 'manual' or 'health_connect'.
  final String source;

  /// v2: habit tag keys joined with commas, e.g. "caffeine,screens".
  final String tags;

  /// v2: free-text note.
  final String? note;

  /// v2: true for a daytime nap.
  final bool isNap;

  /// v2: Health Connect session id (avoids duplicate imports).
  final String? externalId;
  const SleepEntry({
    required this.id,
    required this.bedtime,
    required this.wakeTime,
    this.deepMinutes,
    this.remMinutes,
    this.lightMinutes,
    this.awakeMinutes,
    this.restingHeartRate,
    this.hrvMs,
    this.mood,
    required this.source,
    required this.tags,
    this.note,
    required this.isNap,
    this.externalId,
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
    if (!nullToAbsent || awakeMinutes != null) {
      map['awake_minutes'] = Variable<int>(awakeMinutes);
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
    map['tags'] = Variable<String>(tags);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['is_nap'] = Variable<bool>(isNap);
    if (!nullToAbsent || externalId != null) {
      map['external_id'] = Variable<String>(externalId);
    }
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
      awakeMinutes: awakeMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(awakeMinutes),
      restingHeartRate: restingHeartRate == null && nullToAbsent
          ? const Value.absent()
          : Value(restingHeartRate),
      hrvMs: hrvMs == null && nullToAbsent
          ? const Value.absent()
          : Value(hrvMs),
      mood: mood == null && nullToAbsent ? const Value.absent() : Value(mood),
      source: Value(source),
      tags: Value(tags),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      isNap: Value(isNap),
      externalId: externalId == null && nullToAbsent
          ? const Value.absent()
          : Value(externalId),
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
      awakeMinutes: serializer.fromJson<int?>(json['awakeMinutes']),
      restingHeartRate: serializer.fromJson<int?>(json['restingHeartRate']),
      hrvMs: serializer.fromJson<int?>(json['hrvMs']),
      mood: serializer.fromJson<int?>(json['mood']),
      source: serializer.fromJson<String>(json['source']),
      tags: serializer.fromJson<String>(json['tags']),
      note: serializer.fromJson<String?>(json['note']),
      isNap: serializer.fromJson<bool>(json['isNap']),
      externalId: serializer.fromJson<String?>(json['externalId']),
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
      'awakeMinutes': serializer.toJson<int?>(awakeMinutes),
      'restingHeartRate': serializer.toJson<int?>(restingHeartRate),
      'hrvMs': serializer.toJson<int?>(hrvMs),
      'mood': serializer.toJson<int?>(mood),
      'source': serializer.toJson<String>(source),
      'tags': serializer.toJson<String>(tags),
      'note': serializer.toJson<String?>(note),
      'isNap': serializer.toJson<bool>(isNap),
      'externalId': serializer.toJson<String?>(externalId),
    };
  }

  SleepEntry copyWith({
    int? id,
    DateTime? bedtime,
    DateTime? wakeTime,
    Value<int?> deepMinutes = const Value.absent(),
    Value<int?> remMinutes = const Value.absent(),
    Value<int?> lightMinutes = const Value.absent(),
    Value<int?> awakeMinutes = const Value.absent(),
    Value<int?> restingHeartRate = const Value.absent(),
    Value<int?> hrvMs = const Value.absent(),
    Value<int?> mood = const Value.absent(),
    String? source,
    String? tags,
    Value<String?> note = const Value.absent(),
    bool? isNap,
    Value<String?> externalId = const Value.absent(),
  }) => SleepEntry(
    id: id ?? this.id,
    bedtime: bedtime ?? this.bedtime,
    wakeTime: wakeTime ?? this.wakeTime,
    deepMinutes: deepMinutes.present ? deepMinutes.value : this.deepMinutes,
    remMinutes: remMinutes.present ? remMinutes.value : this.remMinutes,
    lightMinutes: lightMinutes.present ? lightMinutes.value : this.lightMinutes,
    awakeMinutes: awakeMinutes.present ? awakeMinutes.value : this.awakeMinutes,
    restingHeartRate: restingHeartRate.present
        ? restingHeartRate.value
        : this.restingHeartRate,
    hrvMs: hrvMs.present ? hrvMs.value : this.hrvMs,
    mood: mood.present ? mood.value : this.mood,
    source: source ?? this.source,
    tags: tags ?? this.tags,
    note: note.present ? note.value : this.note,
    isNap: isNap ?? this.isNap,
    externalId: externalId.present ? externalId.value : this.externalId,
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
      awakeMinutes: data.awakeMinutes.present
          ? data.awakeMinutes.value
          : this.awakeMinutes,
      restingHeartRate: data.restingHeartRate.present
          ? data.restingHeartRate.value
          : this.restingHeartRate,
      hrvMs: data.hrvMs.present ? data.hrvMs.value : this.hrvMs,
      mood: data.mood.present ? data.mood.value : this.mood,
      source: data.source.present ? data.source.value : this.source,
      tags: data.tags.present ? data.tags.value : this.tags,
      note: data.note.present ? data.note.value : this.note,
      isNap: data.isNap.present ? data.isNap.value : this.isNap,
      externalId: data.externalId.present
          ? data.externalId.value
          : this.externalId,
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
          ..write('awakeMinutes: $awakeMinutes, ')
          ..write('restingHeartRate: $restingHeartRate, ')
          ..write('hrvMs: $hrvMs, ')
          ..write('mood: $mood, ')
          ..write('source: $source, ')
          ..write('tags: $tags, ')
          ..write('note: $note, ')
          ..write('isNap: $isNap, ')
          ..write('externalId: $externalId')
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
    awakeMinutes,
    restingHeartRate,
    hrvMs,
    mood,
    source,
    tags,
    note,
    isNap,
    externalId,
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
          other.awakeMinutes == this.awakeMinutes &&
          other.restingHeartRate == this.restingHeartRate &&
          other.hrvMs == this.hrvMs &&
          other.mood == this.mood &&
          other.source == this.source &&
          other.tags == this.tags &&
          other.note == this.note &&
          other.isNap == this.isNap &&
          other.externalId == this.externalId);
}

class SleepEntriesCompanion extends UpdateCompanion<SleepEntry> {
  final Value<int> id;
  final Value<DateTime> bedtime;
  final Value<DateTime> wakeTime;
  final Value<int?> deepMinutes;
  final Value<int?> remMinutes;
  final Value<int?> lightMinutes;
  final Value<int?> awakeMinutes;
  final Value<int?> restingHeartRate;
  final Value<int?> hrvMs;
  final Value<int?> mood;
  final Value<String> source;
  final Value<String> tags;
  final Value<String?> note;
  final Value<bool> isNap;
  final Value<String?> externalId;
  const SleepEntriesCompanion({
    this.id = const Value.absent(),
    this.bedtime = const Value.absent(),
    this.wakeTime = const Value.absent(),
    this.deepMinutes = const Value.absent(),
    this.remMinutes = const Value.absent(),
    this.lightMinutes = const Value.absent(),
    this.awakeMinutes = const Value.absent(),
    this.restingHeartRate = const Value.absent(),
    this.hrvMs = const Value.absent(),
    this.mood = const Value.absent(),
    this.source = const Value.absent(),
    this.tags = const Value.absent(),
    this.note = const Value.absent(),
    this.isNap = const Value.absent(),
    this.externalId = const Value.absent(),
  });
  SleepEntriesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime bedtime,
    required DateTime wakeTime,
    this.deepMinutes = const Value.absent(),
    this.remMinutes = const Value.absent(),
    this.lightMinutes = const Value.absent(),
    this.awakeMinutes = const Value.absent(),
    this.restingHeartRate = const Value.absent(),
    this.hrvMs = const Value.absent(),
    this.mood = const Value.absent(),
    this.source = const Value.absent(),
    this.tags = const Value.absent(),
    this.note = const Value.absent(),
    this.isNap = const Value.absent(),
    this.externalId = const Value.absent(),
  }) : bedtime = Value(bedtime),
       wakeTime = Value(wakeTime);
  static Insertable<SleepEntry> custom({
    Expression<int>? id,
    Expression<DateTime>? bedtime,
    Expression<DateTime>? wakeTime,
    Expression<int>? deepMinutes,
    Expression<int>? remMinutes,
    Expression<int>? lightMinutes,
    Expression<int>? awakeMinutes,
    Expression<int>? restingHeartRate,
    Expression<int>? hrvMs,
    Expression<int>? mood,
    Expression<String>? source,
    Expression<String>? tags,
    Expression<String>? note,
    Expression<bool>? isNap,
    Expression<String>? externalId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bedtime != null) 'bedtime': bedtime,
      if (wakeTime != null) 'wake_time': wakeTime,
      if (deepMinutes != null) 'deep_minutes': deepMinutes,
      if (remMinutes != null) 'rem_minutes': remMinutes,
      if (lightMinutes != null) 'light_minutes': lightMinutes,
      if (awakeMinutes != null) 'awake_minutes': awakeMinutes,
      if (restingHeartRate != null) 'resting_heart_rate': restingHeartRate,
      if (hrvMs != null) 'hrv_ms': hrvMs,
      if (mood != null) 'mood': mood,
      if (source != null) 'source': source,
      if (tags != null) 'tags': tags,
      if (note != null) 'note': note,
      if (isNap != null) 'is_nap': isNap,
      if (externalId != null) 'external_id': externalId,
    });
  }

  SleepEntriesCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? bedtime,
    Value<DateTime>? wakeTime,
    Value<int?>? deepMinutes,
    Value<int?>? remMinutes,
    Value<int?>? lightMinutes,
    Value<int?>? awakeMinutes,
    Value<int?>? restingHeartRate,
    Value<int?>? hrvMs,
    Value<int?>? mood,
    Value<String>? source,
    Value<String>? tags,
    Value<String?>? note,
    Value<bool>? isNap,
    Value<String?>? externalId,
  }) {
    return SleepEntriesCompanion(
      id: id ?? this.id,
      bedtime: bedtime ?? this.bedtime,
      wakeTime: wakeTime ?? this.wakeTime,
      deepMinutes: deepMinutes ?? this.deepMinutes,
      remMinutes: remMinutes ?? this.remMinutes,
      lightMinutes: lightMinutes ?? this.lightMinutes,
      awakeMinutes: awakeMinutes ?? this.awakeMinutes,
      restingHeartRate: restingHeartRate ?? this.restingHeartRate,
      hrvMs: hrvMs ?? this.hrvMs,
      mood: mood ?? this.mood,
      source: source ?? this.source,
      tags: tags ?? this.tags,
      note: note ?? this.note,
      isNap: isNap ?? this.isNap,
      externalId: externalId ?? this.externalId,
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
    if (awakeMinutes.present) {
      map['awake_minutes'] = Variable<int>(awakeMinutes.value);
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
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (isNap.present) {
      map['is_nap'] = Variable<bool>(isNap.value);
    }
    if (externalId.present) {
      map['external_id'] = Variable<String>(externalId.value);
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
          ..write('awakeMinutes: $awakeMinutes, ')
          ..write('restingHeartRate: $restingHeartRate, ')
          ..write('hrvMs: $hrvMs, ')
          ..write('mood: $mood, ')
          ..write('source: $source, ')
          ..write('tags: $tags, ')
          ..write('note: $note, ')
          ..write('isNap: $isNap, ')
          ..write('externalId: $externalId')
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
  static const VerificationMeta _wakeGoalMinutesMeta = const VerificationMeta(
    'wakeGoalMinutes',
  );
  @override
  late final GeneratedColumn<int> wakeGoalMinutes = GeneratedColumn<int>(
    'wake_goal_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(420),
  );
  static const VerificationMeta _windDownMinutesMeta = const VerificationMeta(
    'windDownMinutes',
  );
  @override
  late final GeneratedColumn<int> windDownMinutes = GeneratedColumn<int>(
    'wind_down_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(30),
  );
  static const VerificationMeta _morningReminderMeta = const VerificationMeta(
    'morningReminder',
  );
  @override
  late final GeneratedColumn<bool> morningReminder = GeneratedColumn<bool>(
    'morning_reminder',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("morning_reminder" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _onboardingDoneMeta = const VerificationMeta(
    'onboardingDone',
  );
  @override
  late final GeneratedColumn<bool> onboardingDone = GeneratedColumn<bool>(
    'onboarding_done',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("onboarding_done" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _themeModeMeta = const VerificationMeta(
    'themeMode',
  );
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('system'),
  );
  static const VerificationMeta _healthConnectEnabledMeta =
      const VerificationMeta('healthConnectEnabled');
  @override
  late final GeneratedColumn<bool> healthConnectEnabled = GeneratedColumn<bool>(
    'health_connect_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("health_connect_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastHealthSyncMeta = const VerificationMeta(
    'lastHealthSync',
  );
  @override
  late final GeneratedColumn<DateTime> lastHealthSync =
      GeneratedColumn<DateTime>(
        'last_health_sync',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastBackupAtMeta = const VerificationMeta(
    'lastBackupAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastBackupAt = GeneratedColumn<DateTime>(
    'last_backup_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userName,
    sleepGoalMinutes,
    bedtimeGoalMinutes,
    bedtimeReminder,
    wakeGoalMinutes,
    windDownMinutes,
    morningReminder,
    onboardingDone,
    themeMode,
    healthConnectEnabled,
    lastHealthSync,
    lastBackupAt,
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
    if (data.containsKey('wake_goal_minutes')) {
      context.handle(
        _wakeGoalMinutesMeta,
        wakeGoalMinutes.isAcceptableOrUnknown(
          data['wake_goal_minutes']!,
          _wakeGoalMinutesMeta,
        ),
      );
    }
    if (data.containsKey('wind_down_minutes')) {
      context.handle(
        _windDownMinutesMeta,
        windDownMinutes.isAcceptableOrUnknown(
          data['wind_down_minutes']!,
          _windDownMinutesMeta,
        ),
      );
    }
    if (data.containsKey('morning_reminder')) {
      context.handle(
        _morningReminderMeta,
        morningReminder.isAcceptableOrUnknown(
          data['morning_reminder']!,
          _morningReminderMeta,
        ),
      );
    }
    if (data.containsKey('onboarding_done')) {
      context.handle(
        _onboardingDoneMeta,
        onboardingDone.isAcceptableOrUnknown(
          data['onboarding_done']!,
          _onboardingDoneMeta,
        ),
      );
    }
    if (data.containsKey('theme_mode')) {
      context.handle(
        _themeModeMeta,
        themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta),
      );
    }
    if (data.containsKey('health_connect_enabled')) {
      context.handle(
        _healthConnectEnabledMeta,
        healthConnectEnabled.isAcceptableOrUnknown(
          data['health_connect_enabled']!,
          _healthConnectEnabledMeta,
        ),
      );
    }
    if (data.containsKey('last_health_sync')) {
      context.handle(
        _lastHealthSyncMeta,
        lastHealthSync.isAcceptableOrUnknown(
          data['last_health_sync']!,
          _lastHealthSyncMeta,
        ),
      );
    }
    if (data.containsKey('last_backup_at')) {
      context.handle(
        _lastBackupAtMeta,
        lastBackupAt.isAcceptableOrUnknown(
          data['last_backup_at']!,
          _lastBackupAtMeta,
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
      wakeGoalMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wake_goal_minutes'],
      )!,
      windDownMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wind_down_minutes'],
      )!,
      morningReminder: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}morning_reminder'],
      )!,
      onboardingDone: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}onboarding_done'],
      )!,
      themeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_mode'],
      )!,
      healthConnectEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}health_connect_enabled'],
      )!,
      lastHealthSync: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_health_sync'],
      ),
      lastBackupAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_backup_at'],
      ),
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

  /// v2: wake-up goal, minutes after midnight (420 = 7:00 AM).
  final int wakeGoalMinutes;

  /// v2: how many minutes before bedtime the wind-down reminder fires.
  final int windDownMinutes;

  /// v2: "How did you sleep?" reminder in the morning.
  final bool morningReminder;

  /// v2: false until the user finishes onboarding.
  final bool onboardingDone;

  /// v2: 'system', 'light' or 'dark'.
  final String themeMode;

  /// v2: user connected Health Connect.
  final bool healthConnectEnabled;

  /// v2: last successful Health Connect import.
  final DateTime? lastHealthSync;

  /// v2: last successful cloud backup.
  final DateTime? lastBackupAt;
  const SettingsRow({
    required this.id,
    required this.userName,
    required this.sleepGoalMinutes,
    required this.bedtimeGoalMinutes,
    required this.bedtimeReminder,
    required this.wakeGoalMinutes,
    required this.windDownMinutes,
    required this.morningReminder,
    required this.onboardingDone,
    required this.themeMode,
    required this.healthConnectEnabled,
    this.lastHealthSync,
    this.lastBackupAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_name'] = Variable<String>(userName);
    map['sleep_goal_minutes'] = Variable<int>(sleepGoalMinutes);
    map['bedtime_goal_minutes'] = Variable<int>(bedtimeGoalMinutes);
    map['bedtime_reminder'] = Variable<bool>(bedtimeReminder);
    map['wake_goal_minutes'] = Variable<int>(wakeGoalMinutes);
    map['wind_down_minutes'] = Variable<int>(windDownMinutes);
    map['morning_reminder'] = Variable<bool>(morningReminder);
    map['onboarding_done'] = Variable<bool>(onboardingDone);
    map['theme_mode'] = Variable<String>(themeMode);
    map['health_connect_enabled'] = Variable<bool>(healthConnectEnabled);
    if (!nullToAbsent || lastHealthSync != null) {
      map['last_health_sync'] = Variable<DateTime>(lastHealthSync);
    }
    if (!nullToAbsent || lastBackupAt != null) {
      map['last_backup_at'] = Variable<DateTime>(lastBackupAt);
    }
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      userName: Value(userName),
      sleepGoalMinutes: Value(sleepGoalMinutes),
      bedtimeGoalMinutes: Value(bedtimeGoalMinutes),
      bedtimeReminder: Value(bedtimeReminder),
      wakeGoalMinutes: Value(wakeGoalMinutes),
      windDownMinutes: Value(windDownMinutes),
      morningReminder: Value(morningReminder),
      onboardingDone: Value(onboardingDone),
      themeMode: Value(themeMode),
      healthConnectEnabled: Value(healthConnectEnabled),
      lastHealthSync: lastHealthSync == null && nullToAbsent
          ? const Value.absent()
          : Value(lastHealthSync),
      lastBackupAt: lastBackupAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastBackupAt),
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
      wakeGoalMinutes: serializer.fromJson<int>(json['wakeGoalMinutes']),
      windDownMinutes: serializer.fromJson<int>(json['windDownMinutes']),
      morningReminder: serializer.fromJson<bool>(json['morningReminder']),
      onboardingDone: serializer.fromJson<bool>(json['onboardingDone']),
      themeMode: serializer.fromJson<String>(json['themeMode']),
      healthConnectEnabled: serializer.fromJson<bool>(
        json['healthConnectEnabled'],
      ),
      lastHealthSync: serializer.fromJson<DateTime?>(json['lastHealthSync']),
      lastBackupAt: serializer.fromJson<DateTime?>(json['lastBackupAt']),
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
      'wakeGoalMinutes': serializer.toJson<int>(wakeGoalMinutes),
      'windDownMinutes': serializer.toJson<int>(windDownMinutes),
      'morningReminder': serializer.toJson<bool>(morningReminder),
      'onboardingDone': serializer.toJson<bool>(onboardingDone),
      'themeMode': serializer.toJson<String>(themeMode),
      'healthConnectEnabled': serializer.toJson<bool>(healthConnectEnabled),
      'lastHealthSync': serializer.toJson<DateTime?>(lastHealthSync),
      'lastBackupAt': serializer.toJson<DateTime?>(lastBackupAt),
    };
  }

  SettingsRow copyWith({
    int? id,
    String? userName,
    int? sleepGoalMinutes,
    int? bedtimeGoalMinutes,
    bool? bedtimeReminder,
    int? wakeGoalMinutes,
    int? windDownMinutes,
    bool? morningReminder,
    bool? onboardingDone,
    String? themeMode,
    bool? healthConnectEnabled,
    Value<DateTime?> lastHealthSync = const Value.absent(),
    Value<DateTime?> lastBackupAt = const Value.absent(),
  }) => SettingsRow(
    id: id ?? this.id,
    userName: userName ?? this.userName,
    sleepGoalMinutes: sleepGoalMinutes ?? this.sleepGoalMinutes,
    bedtimeGoalMinutes: bedtimeGoalMinutes ?? this.bedtimeGoalMinutes,
    bedtimeReminder: bedtimeReminder ?? this.bedtimeReminder,
    wakeGoalMinutes: wakeGoalMinutes ?? this.wakeGoalMinutes,
    windDownMinutes: windDownMinutes ?? this.windDownMinutes,
    morningReminder: morningReminder ?? this.morningReminder,
    onboardingDone: onboardingDone ?? this.onboardingDone,
    themeMode: themeMode ?? this.themeMode,
    healthConnectEnabled: healthConnectEnabled ?? this.healthConnectEnabled,
    lastHealthSync: lastHealthSync.present
        ? lastHealthSync.value
        : this.lastHealthSync,
    lastBackupAt: lastBackupAt.present ? lastBackupAt.value : this.lastBackupAt,
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
      wakeGoalMinutes: data.wakeGoalMinutes.present
          ? data.wakeGoalMinutes.value
          : this.wakeGoalMinutes,
      windDownMinutes: data.windDownMinutes.present
          ? data.windDownMinutes.value
          : this.windDownMinutes,
      morningReminder: data.morningReminder.present
          ? data.morningReminder.value
          : this.morningReminder,
      onboardingDone: data.onboardingDone.present
          ? data.onboardingDone.value
          : this.onboardingDone,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      healthConnectEnabled: data.healthConnectEnabled.present
          ? data.healthConnectEnabled.value
          : this.healthConnectEnabled,
      lastHealthSync: data.lastHealthSync.present
          ? data.lastHealthSync.value
          : this.lastHealthSync,
      lastBackupAt: data.lastBackupAt.present
          ? data.lastBackupAt.value
          : this.lastBackupAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingsRow(')
          ..write('id: $id, ')
          ..write('userName: $userName, ')
          ..write('sleepGoalMinutes: $sleepGoalMinutes, ')
          ..write('bedtimeGoalMinutes: $bedtimeGoalMinutes, ')
          ..write('bedtimeReminder: $bedtimeReminder, ')
          ..write('wakeGoalMinutes: $wakeGoalMinutes, ')
          ..write('windDownMinutes: $windDownMinutes, ')
          ..write('morningReminder: $morningReminder, ')
          ..write('onboardingDone: $onboardingDone, ')
          ..write('themeMode: $themeMode, ')
          ..write('healthConnectEnabled: $healthConnectEnabled, ')
          ..write('lastHealthSync: $lastHealthSync, ')
          ..write('lastBackupAt: $lastBackupAt')
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
    wakeGoalMinutes,
    windDownMinutes,
    morningReminder,
    onboardingDone,
    themeMode,
    healthConnectEnabled,
    lastHealthSync,
    lastBackupAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingsRow &&
          other.id == this.id &&
          other.userName == this.userName &&
          other.sleepGoalMinutes == this.sleepGoalMinutes &&
          other.bedtimeGoalMinutes == this.bedtimeGoalMinutes &&
          other.bedtimeReminder == this.bedtimeReminder &&
          other.wakeGoalMinutes == this.wakeGoalMinutes &&
          other.windDownMinutes == this.windDownMinutes &&
          other.morningReminder == this.morningReminder &&
          other.onboardingDone == this.onboardingDone &&
          other.themeMode == this.themeMode &&
          other.healthConnectEnabled == this.healthConnectEnabled &&
          other.lastHealthSync == this.lastHealthSync &&
          other.lastBackupAt == this.lastBackupAt);
}

class AppSettingsCompanion extends UpdateCompanion<SettingsRow> {
  final Value<int> id;
  final Value<String> userName;
  final Value<int> sleepGoalMinutes;
  final Value<int> bedtimeGoalMinutes;
  final Value<bool> bedtimeReminder;
  final Value<int> wakeGoalMinutes;
  final Value<int> windDownMinutes;
  final Value<bool> morningReminder;
  final Value<bool> onboardingDone;
  final Value<String> themeMode;
  final Value<bool> healthConnectEnabled;
  final Value<DateTime?> lastHealthSync;
  final Value<DateTime?> lastBackupAt;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.userName = const Value.absent(),
    this.sleepGoalMinutes = const Value.absent(),
    this.bedtimeGoalMinutes = const Value.absent(),
    this.bedtimeReminder = const Value.absent(),
    this.wakeGoalMinutes = const Value.absent(),
    this.windDownMinutes = const Value.absent(),
    this.morningReminder = const Value.absent(),
    this.onboardingDone = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.healthConnectEnabled = const Value.absent(),
    this.lastHealthSync = const Value.absent(),
    this.lastBackupAt = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.userName = const Value.absent(),
    this.sleepGoalMinutes = const Value.absent(),
    this.bedtimeGoalMinutes = const Value.absent(),
    this.bedtimeReminder = const Value.absent(),
    this.wakeGoalMinutes = const Value.absent(),
    this.windDownMinutes = const Value.absent(),
    this.morningReminder = const Value.absent(),
    this.onboardingDone = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.healthConnectEnabled = const Value.absent(),
    this.lastHealthSync = const Value.absent(),
    this.lastBackupAt = const Value.absent(),
  });
  static Insertable<SettingsRow> custom({
    Expression<int>? id,
    Expression<String>? userName,
    Expression<int>? sleepGoalMinutes,
    Expression<int>? bedtimeGoalMinutes,
    Expression<bool>? bedtimeReminder,
    Expression<int>? wakeGoalMinutes,
    Expression<int>? windDownMinutes,
    Expression<bool>? morningReminder,
    Expression<bool>? onboardingDone,
    Expression<String>? themeMode,
    Expression<bool>? healthConnectEnabled,
    Expression<DateTime>? lastHealthSync,
    Expression<DateTime>? lastBackupAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userName != null) 'user_name': userName,
      if (sleepGoalMinutes != null) 'sleep_goal_minutes': sleepGoalMinutes,
      if (bedtimeGoalMinutes != null)
        'bedtime_goal_minutes': bedtimeGoalMinutes,
      if (bedtimeReminder != null) 'bedtime_reminder': bedtimeReminder,
      if (wakeGoalMinutes != null) 'wake_goal_minutes': wakeGoalMinutes,
      if (windDownMinutes != null) 'wind_down_minutes': windDownMinutes,
      if (morningReminder != null) 'morning_reminder': morningReminder,
      if (onboardingDone != null) 'onboarding_done': onboardingDone,
      if (themeMode != null) 'theme_mode': themeMode,
      if (healthConnectEnabled != null)
        'health_connect_enabled': healthConnectEnabled,
      if (lastHealthSync != null) 'last_health_sync': lastHealthSync,
      if (lastBackupAt != null) 'last_backup_at': lastBackupAt,
    });
  }

  AppSettingsCompanion copyWith({
    Value<int>? id,
    Value<String>? userName,
    Value<int>? sleepGoalMinutes,
    Value<int>? bedtimeGoalMinutes,
    Value<bool>? bedtimeReminder,
    Value<int>? wakeGoalMinutes,
    Value<int>? windDownMinutes,
    Value<bool>? morningReminder,
    Value<bool>? onboardingDone,
    Value<String>? themeMode,
    Value<bool>? healthConnectEnabled,
    Value<DateTime?>? lastHealthSync,
    Value<DateTime?>? lastBackupAt,
  }) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      sleepGoalMinutes: sleepGoalMinutes ?? this.sleepGoalMinutes,
      bedtimeGoalMinutes: bedtimeGoalMinutes ?? this.bedtimeGoalMinutes,
      bedtimeReminder: bedtimeReminder ?? this.bedtimeReminder,
      wakeGoalMinutes: wakeGoalMinutes ?? this.wakeGoalMinutes,
      windDownMinutes: windDownMinutes ?? this.windDownMinutes,
      morningReminder: morningReminder ?? this.morningReminder,
      onboardingDone: onboardingDone ?? this.onboardingDone,
      themeMode: themeMode ?? this.themeMode,
      healthConnectEnabled: healthConnectEnabled ?? this.healthConnectEnabled,
      lastHealthSync: lastHealthSync ?? this.lastHealthSync,
      lastBackupAt: lastBackupAt ?? this.lastBackupAt,
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
    if (wakeGoalMinutes.present) {
      map['wake_goal_minutes'] = Variable<int>(wakeGoalMinutes.value);
    }
    if (windDownMinutes.present) {
      map['wind_down_minutes'] = Variable<int>(windDownMinutes.value);
    }
    if (morningReminder.present) {
      map['morning_reminder'] = Variable<bool>(morningReminder.value);
    }
    if (onboardingDone.present) {
      map['onboarding_done'] = Variable<bool>(onboardingDone.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (healthConnectEnabled.present) {
      map['health_connect_enabled'] = Variable<bool>(
        healthConnectEnabled.value,
      );
    }
    if (lastHealthSync.present) {
      map['last_health_sync'] = Variable<DateTime>(lastHealthSync.value);
    }
    if (lastBackupAt.present) {
      map['last_backup_at'] = Variable<DateTime>(lastBackupAt.value);
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
          ..write('bedtimeReminder: $bedtimeReminder, ')
          ..write('wakeGoalMinutes: $wakeGoalMinutes, ')
          ..write('windDownMinutes: $windDownMinutes, ')
          ..write('morningReminder: $morningReminder, ')
          ..write('onboardingDone: $onboardingDone, ')
          ..write('themeMode: $themeMode, ')
          ..write('healthConnectEnabled: $healthConnectEnabled, ')
          ..write('lastHealthSync: $lastHealthSync, ')
          ..write('lastBackupAt: $lastBackupAt')
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
      Value<int?> awakeMinutes,
      Value<int?> restingHeartRate,
      Value<int?> hrvMs,
      Value<int?> mood,
      Value<String> source,
      Value<String> tags,
      Value<String?> note,
      Value<bool> isNap,
      Value<String?> externalId,
    });
typedef $$SleepEntriesTableUpdateCompanionBuilder =
    SleepEntriesCompanion Function({
      Value<int> id,
      Value<DateTime> bedtime,
      Value<DateTime> wakeTime,
      Value<int?> deepMinutes,
      Value<int?> remMinutes,
      Value<int?> lightMinutes,
      Value<int?> awakeMinutes,
      Value<int?> restingHeartRate,
      Value<int?> hrvMs,
      Value<int?> mood,
      Value<String> source,
      Value<String> tags,
      Value<String?> note,
      Value<bool> isNap,
      Value<String?> externalId,
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

  ColumnFilters<int> get awakeMinutes => $composableBuilder(
    column: $table.awakeMinutes,
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

  ColumnFilters<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isNap => $composableBuilder(
    column: $table.isNap,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get externalId => $composableBuilder(
    column: $table.externalId,
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

  ColumnOrderings<int> get awakeMinutes => $composableBuilder(
    column: $table.awakeMinutes,
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

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isNap => $composableBuilder(
    column: $table.isNap,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get externalId => $composableBuilder(
    column: $table.externalId,
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

  GeneratedColumn<int> get awakeMinutes => $composableBuilder(
    column: $table.awakeMinutes,
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

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<bool> get isNap =>
      $composableBuilder(column: $table.isNap, builder: (column) => column);

  GeneratedColumn<String> get externalId => $composableBuilder(
    column: $table.externalId,
    builder: (column) => column,
  );
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
                Value<int?> awakeMinutes = const Value.absent(),
                Value<int?> restingHeartRate = const Value.absent(),
                Value<int?> hrvMs = const Value.absent(),
                Value<int?> mood = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String> tags = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<bool> isNap = const Value.absent(),
                Value<String?> externalId = const Value.absent(),
              }) => SleepEntriesCompanion(
                id: id,
                bedtime: bedtime,
                wakeTime: wakeTime,
                deepMinutes: deepMinutes,
                remMinutes: remMinutes,
                lightMinutes: lightMinutes,
                awakeMinutes: awakeMinutes,
                restingHeartRate: restingHeartRate,
                hrvMs: hrvMs,
                mood: mood,
                source: source,
                tags: tags,
                note: note,
                isNap: isNap,
                externalId: externalId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime bedtime,
                required DateTime wakeTime,
                Value<int?> deepMinutes = const Value.absent(),
                Value<int?> remMinutes = const Value.absent(),
                Value<int?> lightMinutes = const Value.absent(),
                Value<int?> awakeMinutes = const Value.absent(),
                Value<int?> restingHeartRate = const Value.absent(),
                Value<int?> hrvMs = const Value.absent(),
                Value<int?> mood = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String> tags = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<bool> isNap = const Value.absent(),
                Value<String?> externalId = const Value.absent(),
              }) => SleepEntriesCompanion.insert(
                id: id,
                bedtime: bedtime,
                wakeTime: wakeTime,
                deepMinutes: deepMinutes,
                remMinutes: remMinutes,
                lightMinutes: lightMinutes,
                awakeMinutes: awakeMinutes,
                restingHeartRate: restingHeartRate,
                hrvMs: hrvMs,
                mood: mood,
                source: source,
                tags: tags,
                note: note,
                isNap: isNap,
                externalId: externalId,
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
      Value<int> wakeGoalMinutes,
      Value<int> windDownMinutes,
      Value<bool> morningReminder,
      Value<bool> onboardingDone,
      Value<String> themeMode,
      Value<bool> healthConnectEnabled,
      Value<DateTime?> lastHealthSync,
      Value<DateTime?> lastBackupAt,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<String> userName,
      Value<int> sleepGoalMinutes,
      Value<int> bedtimeGoalMinutes,
      Value<bool> bedtimeReminder,
      Value<int> wakeGoalMinutes,
      Value<int> windDownMinutes,
      Value<bool> morningReminder,
      Value<bool> onboardingDone,
      Value<String> themeMode,
      Value<bool> healthConnectEnabled,
      Value<DateTime?> lastHealthSync,
      Value<DateTime?> lastBackupAt,
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

  ColumnFilters<int> get wakeGoalMinutes => $composableBuilder(
    column: $table.wakeGoalMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get windDownMinutes => $composableBuilder(
    column: $table.windDownMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get morningReminder => $composableBuilder(
    column: $table.morningReminder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get onboardingDone => $composableBuilder(
    column: $table.onboardingDone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get healthConnectEnabled => $composableBuilder(
    column: $table.healthConnectEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastHealthSync => $composableBuilder(
    column: $table.lastHealthSync,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastBackupAt => $composableBuilder(
    column: $table.lastBackupAt,
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

  ColumnOrderings<int> get wakeGoalMinutes => $composableBuilder(
    column: $table.wakeGoalMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get windDownMinutes => $composableBuilder(
    column: $table.windDownMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get morningReminder => $composableBuilder(
    column: $table.morningReminder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get onboardingDone => $composableBuilder(
    column: $table.onboardingDone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get healthConnectEnabled => $composableBuilder(
    column: $table.healthConnectEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastHealthSync => $composableBuilder(
    column: $table.lastHealthSync,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastBackupAt => $composableBuilder(
    column: $table.lastBackupAt,
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

  GeneratedColumn<int> get wakeGoalMinutes => $composableBuilder(
    column: $table.wakeGoalMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get windDownMinutes => $composableBuilder(
    column: $table.windDownMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get morningReminder => $composableBuilder(
    column: $table.morningReminder,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get onboardingDone => $composableBuilder(
    column: $table.onboardingDone,
    builder: (column) => column,
  );

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<bool> get healthConnectEnabled => $composableBuilder(
    column: $table.healthConnectEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastHealthSync => $composableBuilder(
    column: $table.lastHealthSync,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastBackupAt => $composableBuilder(
    column: $table.lastBackupAt,
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
                Value<int> wakeGoalMinutes = const Value.absent(),
                Value<int> windDownMinutes = const Value.absent(),
                Value<bool> morningReminder = const Value.absent(),
                Value<bool> onboardingDone = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<bool> healthConnectEnabled = const Value.absent(),
                Value<DateTime?> lastHealthSync = const Value.absent(),
                Value<DateTime?> lastBackupAt = const Value.absent(),
              }) => AppSettingsCompanion(
                id: id,
                userName: userName,
                sleepGoalMinutes: sleepGoalMinutes,
                bedtimeGoalMinutes: bedtimeGoalMinutes,
                bedtimeReminder: bedtimeReminder,
                wakeGoalMinutes: wakeGoalMinutes,
                windDownMinutes: windDownMinutes,
                morningReminder: morningReminder,
                onboardingDone: onboardingDone,
                themeMode: themeMode,
                healthConnectEnabled: healthConnectEnabled,
                lastHealthSync: lastHealthSync,
                lastBackupAt: lastBackupAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userName = const Value.absent(),
                Value<int> sleepGoalMinutes = const Value.absent(),
                Value<int> bedtimeGoalMinutes = const Value.absent(),
                Value<bool> bedtimeReminder = const Value.absent(),
                Value<int> wakeGoalMinutes = const Value.absent(),
                Value<int> windDownMinutes = const Value.absent(),
                Value<bool> morningReminder = const Value.absent(),
                Value<bool> onboardingDone = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<bool> healthConnectEnabled = const Value.absent(),
                Value<DateTime?> lastHealthSync = const Value.absent(),
                Value<DateTime?> lastBackupAt = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                id: id,
                userName: userName,
                sleepGoalMinutes: sleepGoalMinutes,
                bedtimeGoalMinutes: bedtimeGoalMinutes,
                bedtimeReminder: bedtimeReminder,
                wakeGoalMinutes: wakeGoalMinutes,
                windDownMinutes: windDownMinutes,
                morningReminder: morningReminder,
                onboardingDone: onboardingDone,
                themeMode: themeMode,
                healthConnectEnabled: healthConnectEnabled,
                lastHealthSync: lastHealthSync,
                lastBackupAt: lastBackupAt,
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
