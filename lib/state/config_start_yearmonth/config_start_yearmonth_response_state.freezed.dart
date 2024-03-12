// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'config_start_yearmonth_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ConfigStartYearmonthResponseState {
  List<int> get startYears => throw _privateConstructorUsedError;
  List<int> get startMonths => throw _privateConstructorUsedError;
  int get selectedStartYear => throw _privateConstructorUsedError;
  int get selectedStartMonth => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ConfigStartYearmonthResponseStateCopyWith<ConfigStartYearmonthResponseState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfigStartYearmonthResponseStateCopyWith<$Res> {
  factory $ConfigStartYearmonthResponseStateCopyWith(
          ConfigStartYearmonthResponseState value,
          $Res Function(ConfigStartYearmonthResponseState) then) =
      _$ConfigStartYearmonthResponseStateCopyWithImpl<$Res,
          ConfigStartYearmonthResponseState>;
  @useResult
  $Res call(
      {List<int> startYears,
      List<int> startMonths,
      int selectedStartYear,
      int selectedStartMonth});
}

/// @nodoc
class _$ConfigStartYearmonthResponseStateCopyWithImpl<$Res,
        $Val extends ConfigStartYearmonthResponseState>
    implements $ConfigStartYearmonthResponseStateCopyWith<$Res> {
  _$ConfigStartYearmonthResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startYears = null,
    Object? startMonths = null,
    Object? selectedStartYear = null,
    Object? selectedStartMonth = null,
  }) {
    return _then(_value.copyWith(
      startYears: null == startYears
          ? _value.startYears
          : startYears // ignore: cast_nullable_to_non_nullable
              as List<int>,
      startMonths: null == startMonths
          ? _value.startMonths
          : startMonths // ignore: cast_nullable_to_non_nullable
              as List<int>,
      selectedStartYear: null == selectedStartYear
          ? _value.selectedStartYear
          : selectedStartYear // ignore: cast_nullable_to_non_nullable
              as int,
      selectedStartMonth: null == selectedStartMonth
          ? _value.selectedStartMonth
          : selectedStartMonth // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConfigStartYearmonthResponseStateImplCopyWith<$Res>
    implements $ConfigStartYearmonthResponseStateCopyWith<$Res> {
  factory _$$ConfigStartYearmonthResponseStateImplCopyWith(
          _$ConfigStartYearmonthResponseStateImpl value,
          $Res Function(_$ConfigStartYearmonthResponseStateImpl) then) =
      __$$ConfigStartYearmonthResponseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<int> startYears,
      List<int> startMonths,
      int selectedStartYear,
      int selectedStartMonth});
}

/// @nodoc
class __$$ConfigStartYearmonthResponseStateImplCopyWithImpl<$Res>
    extends _$ConfigStartYearmonthResponseStateCopyWithImpl<$Res,
        _$ConfigStartYearmonthResponseStateImpl>
    implements _$$ConfigStartYearmonthResponseStateImplCopyWith<$Res> {
  __$$ConfigStartYearmonthResponseStateImplCopyWithImpl(
      _$ConfigStartYearmonthResponseStateImpl _value,
      $Res Function(_$ConfigStartYearmonthResponseStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startYears = null,
    Object? startMonths = null,
    Object? selectedStartYear = null,
    Object? selectedStartMonth = null,
  }) {
    return _then(_$ConfigStartYearmonthResponseStateImpl(
      startYears: null == startYears
          ? _value._startYears
          : startYears // ignore: cast_nullable_to_non_nullable
              as List<int>,
      startMonths: null == startMonths
          ? _value._startMonths
          : startMonths // ignore: cast_nullable_to_non_nullable
              as List<int>,
      selectedStartYear: null == selectedStartYear
          ? _value.selectedStartYear
          : selectedStartYear // ignore: cast_nullable_to_non_nullable
              as int,
      selectedStartMonth: null == selectedStartMonth
          ? _value.selectedStartMonth
          : selectedStartMonth // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ConfigStartYearmonthResponseStateImpl
    implements _ConfigStartYearmonthResponseState {
  const _$ConfigStartYearmonthResponseStateImpl(
      {final List<int> startYears = const [],
      final List<int> startMonths = const [],
      this.selectedStartYear = -1,
      this.selectedStartMonth = -1})
      : _startYears = startYears,
        _startMonths = startMonths;

  final List<int> _startYears;
  @override
  @JsonKey()
  List<int> get startYears {
    if (_startYears is EqualUnmodifiableListView) return _startYears;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_startYears);
  }

  final List<int> _startMonths;
  @override
  @JsonKey()
  List<int> get startMonths {
    if (_startMonths is EqualUnmodifiableListView) return _startMonths;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_startMonths);
  }

  @override
  @JsonKey()
  final int selectedStartYear;
  @override
  @JsonKey()
  final int selectedStartMonth;

  @override
  String toString() {
    return 'ConfigStartYearmonthResponseState(startYears: $startYears, startMonths: $startMonths, selectedStartYear: $selectedStartYear, selectedStartMonth: $selectedStartMonth)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfigStartYearmonthResponseStateImpl &&
            const DeepCollectionEquality()
                .equals(other._startYears, _startYears) &&
            const DeepCollectionEquality()
                .equals(other._startMonths, _startMonths) &&
            (identical(other.selectedStartYear, selectedStartYear) ||
                other.selectedStartYear == selectedStartYear) &&
            (identical(other.selectedStartMonth, selectedStartMonth) ||
                other.selectedStartMonth == selectedStartMonth));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_startYears),
      const DeepCollectionEquality().hash(_startMonths),
      selectedStartYear,
      selectedStartMonth);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfigStartYearmonthResponseStateImplCopyWith<
          _$ConfigStartYearmonthResponseStateImpl>
      get copyWith => __$$ConfigStartYearmonthResponseStateImplCopyWithImpl<
          _$ConfigStartYearmonthResponseStateImpl>(this, _$identity);
}

abstract class _ConfigStartYearmonthResponseState
    implements ConfigStartYearmonthResponseState {
  const factory _ConfigStartYearmonthResponseState(
      {final List<int> startYears,
      final List<int> startMonths,
      final int selectedStartYear,
      final int selectedStartMonth}) = _$ConfigStartYearmonthResponseStateImpl;

  @override
  List<int> get startYears;
  @override
  List<int> get startMonths;
  @override
  int get selectedStartYear;
  @override
  int get selectedStartMonth;
  @override
  @JsonKey(ignore: true)
  _$$ConfigStartYearmonthResponseStateImplCopyWith<
          _$ConfigStartYearmonthResponseStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
