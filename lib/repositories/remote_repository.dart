import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gridscape_demo/models/errors/exception.dart';
import 'package:gridscape_demo/models/errors/failure.dart';
import 'package:gridscape_demo/models/standard_response.dart';
import 'package:gridscape_demo/repositories/remote_client.dart';
import 'package:gridscape_demo/utils/constants.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@injectable
class RemoteRepository {
  Logger _logger;
  RemoteClient _remoteClient;

  RemoteRepository(this._logger, this._remoteClient);

  late Function(Dio repoClient, RemoteRepository remoteRepository) _assignMap;
  Map<Function, Function> _functionMap = {};
  String? _urlKey;

  set functionMap(Map<Function, Function> functionMap) {
    _functionMap = functionMap;
  }

  set urlKey(String? urlKey) {
    _urlKey = urlKey;
  }

  RemoteRepository assignMap(Function(Dio repoClient, RemoteRepository remoteRepository) assignMap) {
    this._assignMap = assignMap;
    return this;
  }

  Future<Either<Failure, T>> processRemoteCall<T>(Function callingFunction,
      {List? params, Map<String, String>? headers, bool authorized = true}) async {
    try {
      final repoClient = await _remoteClient.getRemoteClient(headers: headers, urlKey: _urlKey, authorized: authorized);

      if (repoClient != null) {
        await _assignMap(repoClient, this);

        final callFunction = _functionMap[callingFunction];
        if (callFunction == null) return Left(InternalFailure("Method not Found"));

        String func = callFunction.toString().split("Function")[1].replaceAll(":.", "");

        var resp = await () async {
          try {
            //call appropriate api
            Future callFuture = Function.apply(callFunction, params);
            return await callFuture.timeout(Duration(seconds: 300));
          } catch (e) {
            if (e is DioError) {
              StandardResponse stResp = StandardResponse.fromJson(jsonDecode(jsonEncode(e.response?.data)));
              return stResp;
            } else
              throw e;
          }
        }.call();

        //return data if its type is as per asked return type
        if (resp is T) {
          return Right(resp);
        } else if (resp is StandardResponse && resp.data is T) {
          return Right(resp.data);
        } else if (resp is Iterable<StandardResponse>) {
          List<StandardResponse> failed = resp.where((e) => !(e.statusCode == "1000")).toList();
          if (failed.isNotEmpty) {
            List<StandardResponse> tokenFailed = resp
                .where((e) =>
                    (e.statusMessage?.toLowerCase().contains("authorization") ?? false) ||
                    (e.errors?.any((e) => e.errorId == "1101") ?? false))
                .toList();
            resp = tokenFailed.isNotEmpty ? tokenFailed.first : failed.first;
          }
        }

        //if api fails not because of token expiry then send message from response to UI
        return Left(ServerFailure(ErrorMessages.internalFail, true, []));
      } else {
        return Left(TokenFailure("Failed to create request."));
      }
    } catch (e) {
      //if something went wrong on server side
      if (e is ServerException) {
        _logger.e(e);
        return Left(ServerFailure(e.msg, false, []));
      }
      //internet connection turned off
      else if (e is SocketException) {
        _logger.e(e);
        return Left(InternalFailure("Couldn't connect to server."));
      }
      //server did not responded on time
      else if (e is TimeoutException) {
        _logger.e(e);
        return Left(TimeoutFailure());
      }
      //if something went wrong from app side
      else {
        _logger.e(e);
        return Left(InternalFailure(null));
      }
    }
  }
}
