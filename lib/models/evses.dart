import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gridscape_demo/models/connector.dart';
import 'package:gridscape_demo/utils/class_maps.dart';

part 'evses.g.dart';

@JsonSerializable()
class Evses extends Equatable {
  String? evseId;
  String? uid;
  List<Connector>? connector;
  String? evseStatus;

  Evses(
    this.evseId,
    this.uid,
    this.connector,
    this.evseStatus,
  );

  Evses copy() => Evses.fromJson(jsonDecode(jsonEncode(this)));

  factory Evses.fromJson(Map<String, dynamic> json) => _$EvsesFromJson(json);
  Map<String, dynamic> toJson() => _$EvsesToJson(this);

  static const fromJsonFactory = _$EvsesFromJson;

  @override
  List<Object?> get props => [uid];

  Map<DataTypeKey, dynamic> get primaryKey => Evses.getPrimaryKey(uid ?? "0");

  static Map<DataTypeKey, dynamic> getPrimaryKey(String evsesID) => {DataTypeKey.Evses: evsesID};
}
