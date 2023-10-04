import 'package:gridscape_demo/models/charger_data.dart';
import 'package:gridscape_demo/models/chargers.dart';
import 'package:gridscape_demo/models/connector.dart';
import 'package:gridscape_demo/models/evses.dart';
import 'package:gridscape_demo/models/sites.dart';

mixin PrimaryKey {
  Map<DataTypeKey, dynamic> get primaryKey;
}

enum DataTypeKey {
  SiteData,
  Sites,
  ChargerData,
  Chargers,
  Evses,
  Connector,
}

enum CachingType {
  LongTerm,
  MidTerm,
  ShortTerm,
}

const Map<Type, DataTypeKey> typeToKeyMap = {
  SiteData: DataTypeKey.SiteData,
  Sites: DataTypeKey.Sites,
  Evses: DataTypeKey.Evses,
  Connector: DataTypeKey.Connector,
  Chargers: DataTypeKey.Chargers,
  ChargerData: DataTypeKey.ChargerData,
};

const Map<Type, CachingType> typeToCaCheMap = {
  SiteData: CachingType.ShortTerm,
  Sites: CachingType.ShortTerm,
  Evses: CachingType.ShortTerm,
  Connector: CachingType.ShortTerm,
  Chargers: CachingType.ShortTerm,
  ChargerData: CachingType.ShortTerm,
};

typedef T JsonFactory<T>(Map<String, dynamic> json);

const Map<Type, JsonFactory> factories = {
  SiteData: SiteData.fromJson,
  Sites: Sites.fromJson,
  Evses: Evses.fromJson,
  Connector: Connector.fromJson,
  Chargers: Chargers.fromJson,
  ChargerData: ChargerData.fromJson,
};

Map mapFunction(Map<String, dynamic> json) {
  return json;
}
