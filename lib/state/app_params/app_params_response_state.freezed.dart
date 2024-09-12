// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_params_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AppParamsResponseState {
  bool get inputButtonClicked => throw _privateConstructorUsedError;
  Map<int, String> get creditBlankSettingMap =>
      throw _privateConstructorUsedError;
  String get homeListSelectedYearmonth => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppParamsResponseStateCopyWith<AppParamsResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppParamsResponseStateCopyWith<$Res> {
  factory $AppParamsResponseStateCopyWith(AppParamsResponseState value,
          $Res Function(AppParamsResponseState) then) =
      _$AppParamsResponseStateCopyWithImpl<$Res, AppParamsResponseState>;
  @useResult
  $Res call(
      {bool inputButtonClicked,
      Map<int, String> creditBlankSettingMap,
      String homeListSelectedYearmonth});
}

/// @nodoc
class _$AppParamsResponseStateCopyWithImpl<$Res,
        $Val extends AppParamsResponseState>
    implements $AppParamsResponseStateCopyWith<$Res> {
  _$AppParamsResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputButtonClicked = null,
    Object? creditBlankSettingMap = null,
    Object? homeListSelectedYearmonth = null,
  }) {
    return _then(_value.copyWith(
      inputButtonClicked: null == inputButtonClicked
          ? _value.inputButtonClicked
          : inputButtonClicked // ignore: cast_nullable_to_non_nullable
              as bool,
      creditBlankSettingMap: null == creditBlankSettingMap
          ? _value.creditBlankSettingMap
          : creditBlankSettingMap // ignore: cast_nullable_to_non_nullable
              as Map<int, String>,
      homeListSelectedYearmonth: null == homeListSelectedYearmonth
          ? _value.homeListSelectedYearmonth
          : homeListSelectedYearmonth // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppParamsResponseStateImplCopyWith<$Res>
    implements $AppParamsResponseStateCopyWith<$Res> {
  factory _$$AppParamsResponseStateImplCopyWith(
          _$AppParamsResponseStateImpl value,
          $Res Function(_$AppParamsResponseStateImpl) then) =
      __$$AppParamsResponseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool inputButtonClicked,
      Map<int, String> creditBlankSettingMap,
      String homeListSelectedYearmonth});
}

/// @nodoc
class __$$AppParamsResponseStateImplCopyWithImpl<$Res>
    extends _$AppParamsResponseStateCopyWithImpl<$Res,
        _$AppParamsResponseStateImpl>
    implements _$$AppParamsResponseStateImplCopyWith<$Res> {
  __$$AppParamsResponseStateImplCopyWithImpl(
      _$AppParamsResponseStateImpl _value,
      $Res Function(_$AppParamsResponseStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputButtonClicked = null,
    Object? creditBlankSettingMap = null,
    Object? homeListSelectedYearmonth = null,
  }) {
    return _then(_$AppParamsResponseStateImpl(
      inputButtonClicked: null == inputButtonClicked
          ? _value.inputButtonClicked
          : inputButtonClicked // ignore: cast_nullable_to_non_nullable
              as bool,
      creditBlankSettingMap: null == creditBlankSettingMap
          ? _value._creditBlankSettingMap
          : creditBlankSettingMap // ignore: cast_nullable_to_non_nullable
              as Map<int, String>,
      homeListSelectedYearmonth: null == homeListSelectedYearmonth
          ? _value.homeListSelectedYearmonth
          : homeListSelectedYearmonth // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AppParamsResponseStateImpl implements _AppParamsResponseState {
  const _$AppParamsResponseStateImpl(
      {this.inputButtonClicked = false,
      final Map<int, String> creditBlankSettingMap = const <int, String>{},
      this.homeListSelectedYearmonth = ''})
      : _creditBlankSettingMap = creditBlankSettingMap;

  @override
  @JsonKey()
  final bool inputButtonClicked;
  final Map<int, String> _creditBlankSettingMap;
  @override
  @JsonKey()
  Map<int, String> get creditBlankSettingMap {
    if (_creditBlankSettingMap is EqualUnmodifiableMapView)
      return _creditBlankSettingMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_creditBlankSettingMap);
  }

  @override
  @JsonKey()
  final String homeListSelectedYearmonth;

  @override
  String toString() {
    return 'AppParamsResponseState(inputButtonClicked: $inputButtonClicked, creditBlankSettingMap: $creditBlankSettingMap, homeListSelectedYearmonth: $homeListSelectedYearmonth)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppParamsResponseStateImpl &&
            (identical(other.inputButtonClicked, inputButtonClicked) ||
                other.inputButtonClicked == inputButtonClicked) &&
            const DeepCollectionEquality()
                .equals(other._creditBlankSettingMap, _creditBlankSettingMap) &&
            (identical(other.homeListSelectedYearmonth,
                    homeListSelectedYearmonth) ||
                other.homeListSelectedYearmonth == homeListSelectedYearmonth));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      inputButtonClicked,
      const DeepCollectionEquality().hash(_creditBlankSettingMap),
      homeListSelectedYearmonth);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppParamsResponseStateImplCopyWith<_$AppParamsResponseStateImpl>
      get copyWith => __$$AppParamsResponseStateImplCopyWithImpl<
          _$AppParamsResponseStateImpl>(this, _$identity);
}

abstract class _AppParamsResponseState implements AppParamsResponseState {
  const factory _AppParamsResponseState(
      {final bool inputButtonClicked,
      final Map<int, String> creditBlankSettingMap,
      final String homeListSelectedYearmonth}) = _$AppParamsResponseStateImpl;

  @override
  bool get inputButtonClicked;
  @override
  Map<int, String> get creditBlankSettingMap;
  @override
  String get homeListSelectedYearmonth;
  @override
  @JsonKey(ignore: true)
  _$$AppParamsResponseStateImplCopyWith<_$AppParamsResponseStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
