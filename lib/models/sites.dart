import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gridscape_demo/models/chargers.dart';
import 'package:gridscape_demo/utils/class_maps.dart';

part 'sites.g.dart';

@JsonSerializable()
class Sites extends Equatable {
  String? uid;
  String? address;
  String? city;
  String? country;
  String? name;
  String? zip;
  String? state;
  String? imageUrl;
  List<Chargers>? chargers;

  Sites(
    this.uid,
    this.address,
    this.city,
    this.country,
    this.name,
    this.zip,
    this.state,
    this.imageUrl,
    this.chargers,
  );

  Sites copy() => Sites.fromJson(jsonDecode(jsonEncode(this)));

  factory Sites.fromJson(Map<String, dynamic> json) => _$SitesFromJson(json);
  Map<String, dynamic> toJson() => _$SitesToJson(this);

  static const fromJsonFactory = _$SitesFromJson;

  @override
  List<Object?> get props => [uid];

  Map<DataTypeKey, dynamic> get primaryKey => Sites.getPrimaryKey(uid ?? "0");

  static Map<DataTypeKey, dynamic> getPrimaryKey(String siteId) => {DataTypeKey.Sites: siteId};
}

@JsonSerializable()
class SiteData extends Equatable {
  List<Sites>? sites;

  SiteData(
    this.sites,
  );

  Sites copy() => Sites.fromJson(jsonDecode(jsonEncode(this)));

  factory SiteData.fromJson(Map<String, dynamic> json) => _$SiteDataFromJson(json);
  Map<String, dynamic> toJson() => _$SiteDataToJson(this);

  static const fromJsonFactory = _$SiteDataFromJson;

  static Map<DataTypeKey, dynamic> getPrimaryKey() => {DataTypeKey.SiteData: null};

  @override
  List<Object?> get props => [];
}
