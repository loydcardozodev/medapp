// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'medical_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MedicalRecord {

 String get id; String get appointmentId; String get customerId; String get doctorId; String get diagnosis; List<String> get prescriptions; String get doctorNotes; DateTime get createdAt;
/// Create a copy of MedicalRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MedicalRecordCopyWith<MedicalRecord> get copyWith => _$MedicalRecordCopyWithImpl<MedicalRecord>(this as MedicalRecord, _$identity);

  /// Serializes this MedicalRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MedicalRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.appointmentId, appointmentId) || other.appointmentId == appointmentId)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.doctorId, doctorId) || other.doctorId == doctorId)&&(identical(other.diagnosis, diagnosis) || other.diagnosis == diagnosis)&&const DeepCollectionEquality().equals(other.prescriptions, prescriptions)&&(identical(other.doctorNotes, doctorNotes) || other.doctorNotes == doctorNotes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,appointmentId,customerId,doctorId,diagnosis,const DeepCollectionEquality().hash(prescriptions),doctorNotes,createdAt);

@override
String toString() {
  return 'MedicalRecord(id: $id, appointmentId: $appointmentId, customerId: $customerId, doctorId: $doctorId, diagnosis: $diagnosis, prescriptions: $prescriptions, doctorNotes: $doctorNotes, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $MedicalRecordCopyWith<$Res>  {
  factory $MedicalRecordCopyWith(MedicalRecord value, $Res Function(MedicalRecord) _then) = _$MedicalRecordCopyWithImpl;
@useResult
$Res call({
 String id, String appointmentId, String customerId, String doctorId, String diagnosis, List<String> prescriptions, String doctorNotes, DateTime createdAt
});




}
/// @nodoc
class _$MedicalRecordCopyWithImpl<$Res>
    implements $MedicalRecordCopyWith<$Res> {
  _$MedicalRecordCopyWithImpl(this._self, this._then);

  final MedicalRecord _self;
  final $Res Function(MedicalRecord) _then;

/// Create a copy of MedicalRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? appointmentId = null,Object? customerId = null,Object? doctorId = null,Object? diagnosis = null,Object? prescriptions = null,Object? doctorNotes = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,appointmentId: null == appointmentId ? _self.appointmentId : appointmentId // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,doctorId: null == doctorId ? _self.doctorId : doctorId // ignore: cast_nullable_to_non_nullable
as String,diagnosis: null == diagnosis ? _self.diagnosis : diagnosis // ignore: cast_nullable_to_non_nullable
as String,prescriptions: null == prescriptions ? _self.prescriptions : prescriptions // ignore: cast_nullable_to_non_nullable
as List<String>,doctorNotes: null == doctorNotes ? _self.doctorNotes : doctorNotes // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [MedicalRecord].
extension MedicalRecordPatterns on MedicalRecord {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MedicalRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MedicalRecord() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MedicalRecord value)  $default,){
final _that = this;
switch (_that) {
case _MedicalRecord():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MedicalRecord value)?  $default,){
final _that = this;
switch (_that) {
case _MedicalRecord() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String appointmentId,  String customerId,  String doctorId,  String diagnosis,  List<String> prescriptions,  String doctorNotes,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MedicalRecord() when $default != null:
return $default(_that.id,_that.appointmentId,_that.customerId,_that.doctorId,_that.diagnosis,_that.prescriptions,_that.doctorNotes,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String appointmentId,  String customerId,  String doctorId,  String diagnosis,  List<String> prescriptions,  String doctorNotes,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _MedicalRecord():
return $default(_that.id,_that.appointmentId,_that.customerId,_that.doctorId,_that.diagnosis,_that.prescriptions,_that.doctorNotes,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String appointmentId,  String customerId,  String doctorId,  String diagnosis,  List<String> prescriptions,  String doctorNotes,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _MedicalRecord() when $default != null:
return $default(_that.id,_that.appointmentId,_that.customerId,_that.doctorId,_that.diagnosis,_that.prescriptions,_that.doctorNotes,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MedicalRecord implements MedicalRecord {
  const _MedicalRecord({required this.id, required this.appointmentId, required this.customerId, required this.doctorId, required this.diagnosis, required final  List<String> prescriptions, required this.doctorNotes, required this.createdAt}): _prescriptions = prescriptions;
  factory _MedicalRecord.fromJson(Map<String, dynamic> json) => _$MedicalRecordFromJson(json);

@override final  String id;
@override final  String appointmentId;
@override final  String customerId;
@override final  String doctorId;
@override final  String diagnosis;
 final  List<String> _prescriptions;
@override List<String> get prescriptions {
  if (_prescriptions is EqualUnmodifiableListView) return _prescriptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_prescriptions);
}

@override final  String doctorNotes;
@override final  DateTime createdAt;

/// Create a copy of MedicalRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MedicalRecordCopyWith<_MedicalRecord> get copyWith => __$MedicalRecordCopyWithImpl<_MedicalRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MedicalRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MedicalRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.appointmentId, appointmentId) || other.appointmentId == appointmentId)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.doctorId, doctorId) || other.doctorId == doctorId)&&(identical(other.diagnosis, diagnosis) || other.diagnosis == diagnosis)&&const DeepCollectionEquality().equals(other._prescriptions, _prescriptions)&&(identical(other.doctorNotes, doctorNotes) || other.doctorNotes == doctorNotes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,appointmentId,customerId,doctorId,diagnosis,const DeepCollectionEquality().hash(_prescriptions),doctorNotes,createdAt);

@override
String toString() {
  return 'MedicalRecord(id: $id, appointmentId: $appointmentId, customerId: $customerId, doctorId: $doctorId, diagnosis: $diagnosis, prescriptions: $prescriptions, doctorNotes: $doctorNotes, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$MedicalRecordCopyWith<$Res> implements $MedicalRecordCopyWith<$Res> {
  factory _$MedicalRecordCopyWith(_MedicalRecord value, $Res Function(_MedicalRecord) _then) = __$MedicalRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, String appointmentId, String customerId, String doctorId, String diagnosis, List<String> prescriptions, String doctorNotes, DateTime createdAt
});




}
/// @nodoc
class __$MedicalRecordCopyWithImpl<$Res>
    implements _$MedicalRecordCopyWith<$Res> {
  __$MedicalRecordCopyWithImpl(this._self, this._then);

  final _MedicalRecord _self;
  final $Res Function(_MedicalRecord) _then;

/// Create a copy of MedicalRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? appointmentId = null,Object? customerId = null,Object? doctorId = null,Object? diagnosis = null,Object? prescriptions = null,Object? doctorNotes = null,Object? createdAt = null,}) {
  return _then(_MedicalRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,appointmentId: null == appointmentId ? _self.appointmentId : appointmentId // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,doctorId: null == doctorId ? _self.doctorId : doctorId // ignore: cast_nullable_to_non_nullable
as String,diagnosis: null == diagnosis ? _self.diagnosis : diagnosis // ignore: cast_nullable_to_non_nullable
as String,prescriptions: null == prescriptions ? _self._prescriptions : prescriptions // ignore: cast_nullable_to_non_nullable
as List<String>,doctorNotes: null == doctorNotes ? _self.doctorNotes : doctorNotes // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
