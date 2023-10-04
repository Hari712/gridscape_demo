import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gridscape_demo/utils/class_maps.dart';

part 'connector.g.dart';

@JsonSerializable()
class Connector extends Equatable {
  String? id;
  String? type;
  double? maxPortPowerInKw;
  String? tariff;

  Connector(this.id, this.type, this.maxPortPowerInKw, this.tariff);

  Connector copy() => Connector.fromJson(jsonDecode(jsonEncode(this)));

  factory Connector.fromJson(Map<String, dynamic> json) => _$ConnectorFromJson(json);
  Map<String, dynamic> toJson() => _$ConnectorToJson(this);

  static const fromJsonFactory = _$ConnectorFromJson;

  @override
  List<Object?> get props => [id];

  Map<DataTypeKey, dynamic> get primaryKey => Connector.getPrimaryKey(id ?? "0");

  static Map<DataTypeKey, dynamic> getPrimaryKey(String chargerId) => {DataTypeKey.Connector: chargerId};
}
