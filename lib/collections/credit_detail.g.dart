// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_detail.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCreditDetailCollection on Isar {
  IsarCollection<CreditDetail> get creditDetails => this.collection();
}

const CreditDetailSchema = CollectionSchema(
  name: r'CreditDetail',
  id: -5673353697231386206,
  properties: {
    r'creditDate': PropertySchema(
      id: 0,
      name: r'creditDate',
      type: IsarType.string,
    ),
    r'creditDetailDate': PropertySchema(
      id: 1,
      name: r'creditDetailDate',
      type: IsarType.string,
    ),
    r'creditDetailDescription': PropertySchema(
      id: 2,
      name: r'creditDetailDescription',
      type: IsarType.string,
    ),
    r'creditDetailItem': PropertySchema(
      id: 3,
      name: r'creditDetailItem',
      type: IsarType.string,
    ),
    r'creditDetailPrice': PropertySchema(
      id: 4,
      name: r'creditDetailPrice',
      type: IsarType.long,
    ),
    r'creditPrice': PropertySchema(
      id: 5,
      name: r'creditPrice',
      type: IsarType.string,
    ),
    r'yearmonth': PropertySchema(
      id: 6,
      name: r'yearmonth',
      type: IsarType.string,
    )
  },
  estimateSize: _creditDetailEstimateSize,
  serialize: _creditDetailSerialize,
  deserialize: _creditDetailDeserialize,
  deserializeProp: _creditDetailDeserializeProp,
  idName: r'id',
  indexes: {
    r'yearmonth': IndexSchema(
      id: -155441433374168257,
      name: r'yearmonth',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'yearmonth',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'creditDate': IndexSchema(
      id: -6597583445287446017,
      name: r'creditDate',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'creditDate',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'creditDetailDate': IndexSchema(
      id: 8249250277832393835,
      name: r'creditDetailDate',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'creditDetailDate',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _creditDetailGetId,
  getLinks: _creditDetailGetLinks,
  attach: _creditDetailAttach,
  version: '3.1.0+1',
);

int _creditDetailEstimateSize(
  CreditDetail object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.creditDate.length * 3;
  bytesCount += 3 + object.creditDetailDate.length * 3;
  bytesCount += 3 + object.creditDetailDescription.length * 3;
  bytesCount += 3 + object.creditDetailItem.length * 3;
  bytesCount += 3 + object.creditPrice.length * 3;
  bytesCount += 3 + object.yearmonth.length * 3;
  return bytesCount;
}

void _creditDetailSerialize(
  CreditDetail object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.creditDate);
  writer.writeString(offsets[1], object.creditDetailDate);
  writer.writeString(offsets[2], object.creditDetailDescription);
  writer.writeString(offsets[3], object.creditDetailItem);
  writer.writeLong(offsets[4], object.creditDetailPrice);
  writer.writeString(offsets[5], object.creditPrice);
  writer.writeString(offsets[6], object.yearmonth);
}

CreditDetail _creditDetailDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CreditDetail();
  object.creditDate = reader.readString(offsets[0]);
  object.creditDetailDate = reader.readString(offsets[1]);
  object.creditDetailDescription = reader.readString(offsets[2]);
  object.creditDetailItem = reader.readString(offsets[3]);
  object.creditDetailPrice = reader.readLong(offsets[4]);
  object.creditPrice = reader.readString(offsets[5]);
  object.id = id;
  object.yearmonth = reader.readString(offsets[6]);
  return object;
}

P _creditDetailDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _creditDetailGetId(CreditDetail object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _creditDetailGetLinks(CreditDetail object) {
  return [];
}

void _creditDetailAttach(
    IsarCollection<dynamic> col, Id id, CreditDetail object) {
  object.id = id;
}

extension CreditDetailQueryWhereSort
    on QueryBuilder<CreditDetail, CreditDetail, QWhere> {
  QueryBuilder<CreditDetail, CreditDetail, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CreditDetailQueryWhere
    on QueryBuilder<CreditDetail, CreditDetail, QWhereClause> {
  QueryBuilder<CreditDetail, CreditDetail, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterWhereClause> yearmonthEqualTo(
      String yearmonth) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'yearmonth',
        value: [yearmonth],
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterWhereClause>
      yearmonthNotEqualTo(String yearmonth) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'yearmonth',
              lower: [],
              upper: [yearmonth],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'yearmonth',
              lower: [yearmonth],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'yearmonth',
              lower: [yearmonth],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'yearmonth',
              lower: [],
              upper: [yearmonth],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterWhereClause> creditDateEqualTo(
      String creditDate) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'creditDate',
        value: [creditDate],
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterWhereClause>
      creditDateNotEqualTo(String creditDate) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'creditDate',
              lower: [],
              upper: [creditDate],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'creditDate',
              lower: [creditDate],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'creditDate',
              lower: [creditDate],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'creditDate',
              lower: [],
              upper: [creditDate],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterWhereClause>
      creditDetailDateEqualTo(String creditDetailDate) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'creditDetailDate',
        value: [creditDetailDate],
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterWhereClause>
      creditDetailDateNotEqualTo(String creditDetailDate) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'creditDetailDate',
              lower: [],
              upper: [creditDetailDate],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'creditDetailDate',
              lower: [creditDetailDate],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'creditDetailDate',
              lower: [creditDetailDate],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'creditDetailDate',
              lower: [],
              upper: [creditDetailDate],
              includeUpper: false,
            ));
      }
    });
  }
}

extension CreditDetailQueryFilter
    on QueryBuilder<CreditDetail, CreditDetail, QFilterCondition> {
  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDateEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'creditDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDateGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'creditDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDateLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'creditDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDateBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'creditDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'creditDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'creditDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'creditDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'creditDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'creditDate',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'creditDate',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDetailDateEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'creditDetailDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDetailDateGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'creditDetailDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDetailDateLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'creditDetailDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDetailDateBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'creditDetailDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDetailDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'creditDetailDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDetailDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'creditDetailDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDetailDateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'creditDetailDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDetailDateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'creditDetailDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDetailDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'creditDetailDate',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDetailDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'creditDetailDate',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDetailDescriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'creditDetailDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDetailDescriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'creditDetailDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDetailDescriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'creditDetailDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDetailDescriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'creditDetailDescription',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDetailDescriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'creditDetailDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDetailDescriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'creditDetailDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDetailDescriptionContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'creditDetailDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDetailDescriptionMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'creditDetailDescription',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDetailDescriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'creditDetailDescription',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDetailDescriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'creditDetailDescription',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDetailItemEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'creditDetailItem',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDetailItemGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'creditDetailItem',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDetailItemLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'creditDetailItem',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDetailItemBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'creditDetailItem',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDetailItemStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'creditDetailItem',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDetailItemEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'creditDetailItem',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDetailItemContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'creditDetailItem',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDetailItemMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'creditDetailItem',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDetailItemIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'creditDetailItem',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDetailItemIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'creditDetailItem',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDetailPriceEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'creditDetailPrice',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDetailPriceGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'creditDetailPrice',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDetailPriceLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'creditDetailPrice',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditDetailPriceBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'creditDetailPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditPriceEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'creditPrice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditPriceGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'creditPrice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditPriceLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'creditPrice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditPriceBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'creditPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditPriceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'creditPrice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditPriceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'creditPrice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditPriceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'creditPrice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditPriceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'creditPrice',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditPriceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'creditPrice',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      creditPriceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'creditPrice',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      yearmonthEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'yearmonth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      yearmonthGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'yearmonth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      yearmonthLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'yearmonth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      yearmonthBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'yearmonth',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      yearmonthStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'yearmonth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      yearmonthEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'yearmonth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      yearmonthContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'yearmonth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      yearmonthMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'yearmonth',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      yearmonthIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'yearmonth',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterFilterCondition>
      yearmonthIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'yearmonth',
        value: '',
      ));
    });
  }
}

extension CreditDetailQueryObject
    on QueryBuilder<CreditDetail, CreditDetail, QFilterCondition> {}

extension CreditDetailQueryLinks
    on QueryBuilder<CreditDetail, CreditDetail, QFilterCondition> {}

extension CreditDetailQuerySortBy
    on QueryBuilder<CreditDetail, CreditDetail, QSortBy> {
  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy> sortByCreditDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditDate', Sort.asc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy>
      sortByCreditDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditDate', Sort.desc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy>
      sortByCreditDetailDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditDetailDate', Sort.asc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy>
      sortByCreditDetailDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditDetailDate', Sort.desc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy>
      sortByCreditDetailDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditDetailDescription', Sort.asc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy>
      sortByCreditDetailDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditDetailDescription', Sort.desc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy>
      sortByCreditDetailItem() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditDetailItem', Sort.asc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy>
      sortByCreditDetailItemDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditDetailItem', Sort.desc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy>
      sortByCreditDetailPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditDetailPrice', Sort.asc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy>
      sortByCreditDetailPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditDetailPrice', Sort.desc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy> sortByCreditPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditPrice', Sort.asc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy>
      sortByCreditPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditPrice', Sort.desc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy> sortByYearmonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yearmonth', Sort.asc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy> sortByYearmonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yearmonth', Sort.desc);
    });
  }
}

extension CreditDetailQuerySortThenBy
    on QueryBuilder<CreditDetail, CreditDetail, QSortThenBy> {
  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy> thenByCreditDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditDate', Sort.asc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy>
      thenByCreditDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditDate', Sort.desc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy>
      thenByCreditDetailDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditDetailDate', Sort.asc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy>
      thenByCreditDetailDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditDetailDate', Sort.desc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy>
      thenByCreditDetailDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditDetailDescription', Sort.asc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy>
      thenByCreditDetailDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditDetailDescription', Sort.desc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy>
      thenByCreditDetailItem() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditDetailItem', Sort.asc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy>
      thenByCreditDetailItemDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditDetailItem', Sort.desc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy>
      thenByCreditDetailPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditDetailPrice', Sort.asc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy>
      thenByCreditDetailPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditDetailPrice', Sort.desc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy> thenByCreditPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditPrice', Sort.asc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy>
      thenByCreditPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditPrice', Sort.desc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy> thenByYearmonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yearmonth', Sort.asc);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QAfterSortBy> thenByYearmonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yearmonth', Sort.desc);
    });
  }
}

extension CreditDetailQueryWhereDistinct
    on QueryBuilder<CreditDetail, CreditDetail, QDistinct> {
  QueryBuilder<CreditDetail, CreditDetail, QDistinct> distinctByCreditDate(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'creditDate', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QDistinct>
      distinctByCreditDetailDate({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'creditDetailDate',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QDistinct>
      distinctByCreditDetailDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'creditDetailDescription',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QDistinct>
      distinctByCreditDetailItem({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'creditDetailItem',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QDistinct>
      distinctByCreditDetailPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'creditDetailPrice');
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QDistinct> distinctByCreditPrice(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'creditPrice', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CreditDetail, CreditDetail, QDistinct> distinctByYearmonth(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'yearmonth', caseSensitive: caseSensitive);
    });
  }
}

extension CreditDetailQueryProperty
    on QueryBuilder<CreditDetail, CreditDetail, QQueryProperty> {
  QueryBuilder<CreditDetail, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CreditDetail, String, QQueryOperations> creditDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'creditDate');
    });
  }

  QueryBuilder<CreditDetail, String, QQueryOperations>
      creditDetailDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'creditDetailDate');
    });
  }

  QueryBuilder<CreditDetail, String, QQueryOperations>
      creditDetailDescriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'creditDetailDescription');
    });
  }

  QueryBuilder<CreditDetail, String, QQueryOperations>
      creditDetailItemProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'creditDetailItem');
    });
  }

  QueryBuilder<CreditDetail, int, QQueryOperations>
      creditDetailPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'creditDetailPrice');
    });
  }

  QueryBuilder<CreditDetail, String, QQueryOperations> creditPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'creditPrice');
    });
  }

  QueryBuilder<CreditDetail, String, QQueryOperations> yearmonthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'yearmonth');
    });
  }
}
