import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gridscape_demo/models/chargers.dart';
import 'package:gridscape_demo/models/evses.dart';
import 'package:gridscape_demo/utils/class_maps.dart';

part 'charger_data.g.dart';

@JsonSerializable()
class ChargerData extends Equatable {
  String? uid;
  String? chargerId;
  List<Evses>? evses;
  String? imageUrl;
  String? isPublic;
  double? latitude;
  double? longitude;
  bool? isFavorite;
  String? address;
  String? city;
  String? country;
  String? name;
  String? zip;
  String? state;
  List<Chargers>? chargers;

  ChargerData(
    this.uid,
    this.chargerId,
    this.evses,
    this.imageUrl,
    this.isPublic,
    this.latitude,
    this.longitude,
    this.isFavorite,
    this.address,
    this.city,
    this.country,
    this.name,
    this.zip,
    this.state,
    this.chargers,
  );

  ChargerData copy() => ChargerData.fromJson(jsonDecode(jsonEncode(this)));

  factory ChargerData.fromJson(Map<String, dynamic> json) => _$ChargerDataFromJson(json);
  Map<String, dynamic> toJson() => _$ChargerDataToJson(this);

  static const fromJsonFactory = _$ChargerDataFromJson;

  @override
  List<Object?> get props => [chargerId];

  Map<DataTypeKey, dynamic> get primaryKey => ChargerData.getPrimaryKey(chargerId ?? "0");

  static Map<DataTypeKey, dynamic> getPrimaryKey(String chargerId) => {DataTypeKey.ChargerData: chargerId};
}
