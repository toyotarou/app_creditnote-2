// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'credit_blank_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreditBlankResponseState {
  List<CreditBlankInputValue> get creditBlankInputValueList =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreditBlankResponseStateCopyWith<CreditBlankResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreditBlankResponseStateCopyWith<$Res> {
  factory $CreditBlankResponseStateCopyWith(CreditBlankResponseState value,
          $Res Function(CreditBlankResponseState) then) =
      _$CreditBlankResponseStateCopyWithImpl<$Res, CreditBlankResponseState>;
  @useResult
  $Res call({List<CreditBlankInputValue> creditBlankInputValueList});
}

/// @nodoc
class _$CreditBlankResponseStateCopyWithImpl<$Res,
        $Val extends CreditBlankResponseState>
    implements $CreditBlankResponseStateCopyWith<$Res> {
  _$CreditBlankResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? creditBlankInputValueList = null,
  }) {
    return _then(_value.copyWith(
      creditBlankInputValueList: null == creditBlankInputValueList
          ? _value.creditBlankInputValueList
          : creditBlankInputValueList // ignore: cast_nullable_to_non_nullable
              as List<CreditBlankInputValue>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreditBlankResponseStateImplCopyWith<$Res>
    implements $CreditBlankResponseStateCopyWith<$Res> {
  factory _$$CreditBlankResponseStateImplCopyWith(
          _$CreditBlankResponseStateImpl value,
          $Res Function(_$CreditBlankResponseStateImpl) then) =
      __$$CreditBlankResponseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<CreditBlankInputValue> creditBlankInputValueList});
}

/// @nodoc
class __$$CreditBlankResponseStateImplCopyWithImpl<$Res>
    extends _$CreditBlankResponseStateCopyWithImpl<$Res,
        _$CreditBlankResponseStateImpl>
    implements _$$CreditBlankResponseStateImplCopyWith<$Res> {
  __$$CreditBlankResponseStateImplCopyWithImpl(
      _$CreditBlankResponseStateImpl _value,
      $Res Function(_$CreditBlankResponseStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? creditBlankInputValueList = null,
  }) {
    return _then(_$CreditBlankResponseStateImpl(
      creditBlankInputValueList: null == creditBlankInputValueList
          ? _value._creditBlankInputValueList
          : creditBlankInputValueList // ignore: cast_nullable_to_non_nullable
              as List<CreditBlankInputValue>,
    ));
  }
}

/// @nodoc

class _$CreditBlankResponseStateImpl implements _CreditBlankResponseState {
  const _$CreditBlankResponseStateImpl(
      {final List<CreditBlankInputValue> creditBlankInputValueList = const []})
      : _creditBlankInputValueList = creditBlankInputValueList;

  final List<CreditBlankInputValue> _creditBlankInputValueList;
  @override
  @JsonKey()
  List<CreditBlankInputValue> get creditBlankInputValueList {
    if (_creditBlankInputValueList is EqualUnmodifiableListView)
      return _creditBlankInputValueList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_creditBlankInputValueList);
  }

  @override
  String toString() {
    return 'CreditBlankResponseState(creditBlankInputValueList: $creditBlankInputValueList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreditBlankResponseStateImpl &&
            const DeepCollectionEquality().equals(
                other._creditBlankInputValueList, _creditBlankInputValueList));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_creditBlankInputValueList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreditBlankResponseStateImplCopyWith<_$CreditBlankResponseStateImpl>
      get copyWith => __$$CreditBlankResponseStateImplCopyWithImpl<
          _$CreditBlankResponseStateImpl>(this, _$identity);
}

abstract class _CreditBlankResponseState implements CreditBlankResponseState {
  const factory _CreditBlankResponseState(
          {final List<CreditBlankInputValue> creditBlankInputValueList}) =
      _$CreditBlankResponseStateImpl;

  @override
  List<CreditBlankInputValue> get creditBlankInputValueList;
  @override
  @JsonKey(ignore: true)
  _$$CreditBlankResponseStateImplCopyWith<_$CreditBlankResponseStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
