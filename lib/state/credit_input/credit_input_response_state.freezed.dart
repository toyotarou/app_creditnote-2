// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'credit_input_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreditInputResponseState {
  int get itemPos => throw _privateConstructorUsedError;
  List<String> get creditDates => throw _privateConstructorUsedError;
  List<String> get creditNames => throw _privateConstructorUsedError;
  List<int> get creditPrices => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreditInputResponseStateCopyWith<CreditInputResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreditInputResponseStateCopyWith<$Res> {
  factory $CreditInputResponseStateCopyWith(CreditInputResponseState value,
          $Res Function(CreditInputResponseState) then) =
      _$CreditInputResponseStateCopyWithImpl<$Res, CreditInputResponseState>;
  @useResult
  $Res call(
      {int itemPos,
      List<String> creditDates,
      List<String> creditNames,
      List<int> creditPrices});
}

/// @nodoc
class _$CreditInputResponseStateCopyWithImpl<$Res,
        $Val extends CreditInputResponseState>
    implements $CreditInputResponseStateCopyWith<$Res> {
  _$CreditInputResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemPos = null,
    Object? creditDates = null,
    Object? creditNames = null,
    Object? creditPrices = null,
  }) {
    return _then(_value.copyWith(
      itemPos: null == itemPos
          ? _value.itemPos
          : itemPos // ignore: cast_nullable_to_non_nullable
              as int,
      creditDates: null == creditDates
          ? _value.creditDates
          : creditDates // ignore: cast_nullable_to_non_nullable
              as List<String>,
      creditNames: null == creditNames
          ? _value.creditNames
          : creditNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      creditPrices: null == creditPrices
          ? _value.creditPrices
          : creditPrices // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreditInputResponseStateImplCopyWith<$Res>
    implements $CreditInputResponseStateCopyWith<$Res> {
  factory _$$CreditInputResponseStateImplCopyWith(
          _$CreditInputResponseStateImpl value,
          $Res Function(_$CreditInputResponseStateImpl) then) =
      __$$CreditInputResponseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int itemPos,
      List<String> creditDates,
      List<String> creditNames,
      List<int> creditPrices});
}

/// @nodoc
class __$$CreditInputResponseStateImplCopyWithImpl<$Res>
    extends _$CreditInputResponseStateCopyWithImpl<$Res,
        _$CreditInputResponseStateImpl>
    implements _$$CreditInputResponseStateImplCopyWith<$Res> {
  __$$CreditInputResponseStateImplCopyWithImpl(
      _$CreditInputResponseStateImpl _value,
      $Res Function(_$CreditInputResponseStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemPos = null,
    Object? creditDates = null,
    Object? creditNames = null,
    Object? creditPrices = null,
  }) {
    return _then(_$CreditInputResponseStateImpl(
      itemPos: null == itemPos
          ? _value.itemPos
          : itemPos // ignore: cast_nullable_to_non_nullable
              as int,
      creditDates: null == creditDates
          ? _value._creditDates
          : creditDates // ignore: cast_nullable_to_non_nullable
              as List<String>,
      creditNames: null == creditNames
          ? _value._creditNames
          : creditNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      creditPrices: null == creditPrices
          ? _value._creditPrices
          : creditPrices // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc

class _$CreditInputResponseStateImpl implements _CreditInputResponseState {
  const _$CreditInputResponseStateImpl(
      {this.itemPos = 0,
      final List<String> creditDates = const [],
      final List<String> creditNames = const [],
      final List<int> creditPrices = const []})
      : _creditDates = creditDates,
        _creditNames = creditNames,
        _creditPrices = creditPrices;

  @override
  @JsonKey()
  final int itemPos;
  final List<String> _creditDates;
  @override
  @JsonKey()
  List<String> get creditDates {
    if (_creditDates is EqualUnmodifiableListView) return _creditDates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_creditDates);
  }

  final List<String> _creditNames;
  @override
  @JsonKey()
  List<String> get creditNames {
    if (_creditNames is EqualUnmodifiableListView) return _creditNames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_creditNames);
  }

  final List<int> _creditPrices;
  @override
  @JsonKey()
  List<int> get creditPrices {
    if (_creditPrices is EqualUnmodifiableListView) return _creditPrices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_creditPrices);
  }

  @override
  String toString() {
    return 'CreditInputResponseState(itemPos: $itemPos, creditDates: $creditDates, creditNames: $creditNames, creditPrices: $creditPrices)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreditInputResponseStateImpl &&
            (identical(other.itemPos, itemPos) || other.itemPos == itemPos) &&
            const DeepCollectionEquality()
                .equals(other._creditDates, _creditDates) &&
            const DeepCollectionEquality()
                .equals(other._creditNames, _creditNames) &&
            const DeepCollectionEquality()
                .equals(other._creditPrices, _creditPrices));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      itemPos,
      const DeepCollectionEquality().hash(_creditDates),
      const DeepCollectionEquality().hash(_creditNames),
      const DeepCollectionEquality().hash(_creditPrices));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreditInputResponseStateImplCopyWith<_$CreditInputResponseStateImpl>
      get copyWith => __$$CreditInputResponseStateImplCopyWithImpl<
          _$CreditInputResponseStateImpl>(this, _$identity);
}

abstract class _CreditInputResponseState implements CreditInputResponseState {
  const factory _CreditInputResponseState(
      {final int itemPos,
      final List<String> creditDates,
      final List<String> creditNames,
      final List<int> creditPrices}) = _$CreditInputResponseStateImpl;

  @override
  int get itemPos;
  @override
  List<String> get creditDates;
  @override
  List<String> get creditNames;
  @override
  List<int> get creditPrices;
  @override
  @JsonKey(ignore: true)
  _$$CreditInputResponseStateImplCopyWith<_$CreditInputResponseStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
