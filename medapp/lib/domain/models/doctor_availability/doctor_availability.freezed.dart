// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'doctor_availability.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DoctorAvailability {

 String get id; String get doctorId; DateTime get date; List<String> get slots;
/// Create a copy of DoctorAvailability
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DoctorAvailabilityCopyWith<DoctorAvailability> get copyWith => _$DoctorAvailabilityCopyWithImpl<DoctorAvailability>(this as DoctorAvailability, _$identity);

  /// Serializes this DoctorAvailability to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DoctorAvailability&&(identical(other.id, id) || other.id == id)&&(identical(other.doctorId, doctorId) || other.doctorId == doctorId)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.slots, slots));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,doctorId,date,const DeepCollectionEquality().hash(slots));

@override
String toString() {
  return 'DoctorAvailability(id: $id, doctorId: $doctorId, date: $date, slots: $slots)';
}


}

/// @nodoc
abstract mixin class $DoctorAvailabilityCopyWith<$Res>  {
  factory $DoctorAvailabilityCopyWith(DoctorAvailability value, $Res Function(DoctorAvailability) _then) = _$DoctorAvailabilityCopyWithImpl;
@useResult
$Res call({
 String id, String doctorId, DateTime date, List<String> slots
});




}
/// @nodoc
class _$DoctorAvailabilityCopyWithImpl<$Res>
    implements $DoctorAvailabilityCopyWith<$Res> {
  _$DoctorAvailabilityCopyWithImpl(this._self, this._then);

  final DoctorAvailability _self;
  final $Res Function(DoctorAvailability) _then;

/// Create a copy of DoctorAvailability
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? doctorId = null,Object? date = null,Object? slots = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,doctorId: null == doctorId ? _self.doctorId : doctorId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,slots: null == slots ? _self.slots : slots // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [DoctorAvailability].
extension DoctorAvailabilityPatterns on DoctorAvailability {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DoctorAvailability value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DoctorAvailability() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DoctorAvailability value)  $default,){
final _that = this;
switch (_that) {
case _DoctorAvailability():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DoctorAvailability value)?  $default,){
final _that = this;
switch (_that) {
case _DoctorAvailability() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String doctorId,  DateTime date,  List<String> slots)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DoctorAvailability() when $default != null:
return $default(_that.id,_that.doctorId,_that.date,_that.slots);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String doctorId,  DateTime date,  List<String> slots)  $default,) {final _that = this;
switch (_that) {
case _DoctorAvailability():
return $default(_that.id,_that.doctorId,_that.date,_that.slots);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String doctorId,  DateTime date,  List<String> slots)?  $default,) {final _that = this;
switch (_that) {
case _DoctorAvailability() when $default != null:
return $default(_that.id,_that.doctorId,_that.date,_that.slots);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DoctorAvailability implements DoctorAvailability {
  const _DoctorAvailability({required this.id, required this.doctorId, required this.date, required final  List<String> slots}): _slots = slots;
  factory _DoctorAvailability.fromJson(Map<String, dynamic> json) => _$DoctorAvailabilityFromJson(json);

@override final  String id;
@override final  String doctorId;
@override final  DateTime date;
 final  List<String> _slots;
@override List<String> get slots {
  if (_slots is EqualUnmodifiableListView) return _slots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_slots);
}


/// Create a copy of DoctorAvailability
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DoctorAvailabilityCopyWith<_DoctorAvailability> get copyWith => __$DoctorAvailabilityCopyWithImpl<_DoctorAvailability>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DoctorAvailabilityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DoctorAvailability&&(identical(other.id, id) || other.id == id)&&(identical(other.doctorId, doctorId) || other.doctorId == doctorId)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other._slots, _slots));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,doctorId,date,const DeepCollectionEquality().hash(_slots));

@override
String toString() {
  return 'DoctorAvailability(id: $id, doctorId: $doctorId, date: $date, slots: $slots)';
}


}

/// @nodoc
abstract mixin class _$DoctorAvailabilityCopyWith<$Res> implements $DoctorAvailabilityCopyWith<$Res> {
  factory _$DoctorAvailabilityCopyWith(_DoctorAvailability value, $Res Function(_DoctorAvailability) _then) = __$DoctorAvailabilityCopyWithImpl;
@override @useResult
$Res call({
 String id, String doctorId, DateTime date, List<String> slots
});




}
/// @nodoc
class __$DoctorAvailabilityCopyWithImpl<$Res>
    implements _$DoctorAvailabilityCopyWith<$Res> {
  __$DoctorAvailabilityCopyWithImpl(this._self, this._then);

  final _DoctorAvailability _self;
  final $Res Function(_DoctorAvailability) _then;

/// Create a copy of DoctorAvailability
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? doctorId = null,Object? date = null,Object? slots = null,}) {
  return _then(_DoctorAvailability(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,doctorId: null == doctorId ? _self.doctorId : doctorId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,slots: null == slots ? _self._slots : slots // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
