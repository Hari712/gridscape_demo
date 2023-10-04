import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gridscape_demo/models/evses.dart';
import 'package:gridscape_demo/utils/class_maps.dart';

part 'chargers.g.dart';

@JsonSerializable()
class Chargers extends Equatable {
  String? uid;
  String? chargerId;
  List<Evses>? evses;
  String? imageUrl;
  String? isPublic;
  double? latitude;
  double? longitude;
  bool? isFavorite;

  Chargers(
    this.uid,
    this.chargerId,
    this.evses,
    this.imageUrl,
    this.isPublic,
    this.latitude,
    this.longitude,
    this.isFavorite,
  );

  Chargers copy() => Chargers.fromJson(jsonDecode(jsonEncode(this)));

  factory Chargers.fromJson(Map<String, dynamic> json) => _$ChargersFromJson(json);
  Map<String, dynamic> toJson() => _$ChargersToJson(this);

  static const fromJsonFactory = _$ChargersFromJson;

  @override
  List<Object?> get props => [chargerId];

  Map<DataTypeKey, dynamic> get primaryKey => Chargers.getPrimaryKey(chargerId ?? "0");

  static Map<DataTypeKey, dynamic> getPrimaryKey(String chargerId) => {DataTypeKey.Chargers: chargerId};
}
