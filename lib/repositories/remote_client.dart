import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gridscape_demo/utils/constants.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@lazySingleton
class RemoteClient {
  final Logger _logger;

  RemoteClient(this._logger);

  Future<Dio?> getRemoteClient({Map<String, String>? headers, String? urlKey, bool authorized = true}) async {
    return _getRemoteClient(urlKey: urlKey, headers: headers);
  }

  Dio _getRemoteClient({Map<String, String>? headers, String? urlKey}) {
    Map<String, String> header = {
      "authorization":
          "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJVc2VyIERldGFpbHMiLCJpc3MiOiJHcmlkc2NhcGUiLCJpYXQiOjE2OTA4NzU2MTgsImVtYWlsIjoidGVzdF9yYWh1bDRAeW9wbWFpbC5jb20iLCJjdXN0b21lciI6MX0.89EJmwdHChxx_uAPtBwPtblJ5HMY0KdltI7Z9GRPsIs",
    };

    if (headers != null) header.addAll(headers);

    return Dio(
      BaseOptions(
        baseUrl: "https://demo.grid-scape.com/m-interface/v2",
        headers: header,
      ),
    )..interceptors.addAll(
        [
          InterceptorsWrapper(
            onResponse: (resp, _) {
              //provide log calling function
              if (LogConstants.responseData) {
                _logger.d(
                    "[${resp.requestOptions.method}] ${resp.requestOptions.baseUrl + resp.requestOptions.path}" +
                        "\n" +
                        jsonEncode(resp.data),
                    error: null,
                    stackTrace: StackTrace.empty);
              }
              _.next(resp);
            },
          ),
        ],
      );
  }
}
