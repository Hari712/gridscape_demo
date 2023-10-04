import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:gridscape_demo/utils/json_value_converter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logger/logger.dart';

part 'standard_response.g.dart';

@JsonSerializable()
class ErrorMessage {
  String? errorId;
  int? statusCode;
  String? message;

  ErrorMessage(this.errorId, this.statusCode, this.message);

  factory ErrorMessage.fromJson(Map<String, dynamic> json) => _$ErrorMessageFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorMessageToJson(this);
  static const fromJsonFactory = _$ErrorMessageFromJson;
}

@JsonSerializable()
class StandardResponse<A, B> {
  int? statusCode;
  List<ErrorMessage>? errors;
  String? statusMessage;
  String? timestamp;
  @JsonKey(name: 'data')
  dynamic dataDoNotUse;

  @JsonKey(ignore: true)
  B? get data {
    if (dataDoNotUse == null)
      return null;
    else {
      try {
        return JsonTypeParser.decode<A>(dataDoNotUse);
      } catch (e) {
        GetIt.I<Logger>().i(e.toString(), error: null, stackTrace: null);
        return null;
      }
    }
  }

  set data(B? value) {
    if (value == null)
      dataDoNotUse = null;
    else {
      try {
        dataDoNotUse = jsonDecode(jsonEncode(value));
      } catch (e) {
        dataDoNotUse = null;
      }
    }
  }

  StandardResponse(this.statusCode, this.statusMessage, this.timestamp, this.errors, this.dataDoNotUse);

  factory StandardResponse.fromData(dynamic newData) => StandardResponse(1000, "", "", [], newData);

  factory StandardResponse.fromJson(Map<String, dynamic> json) => _$StandardResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StandardResponseToJson(this);
  static const fromJsonFactory = _$StandardResponseFromJson;
}
