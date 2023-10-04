import 'package:gridscape_demo/models/standard_response.dart';
import 'package:gridscape_demo/utils/constants.dart';

class Failure {
  String get msg =>
      (message == "" ? (ErrorMessages.internalFail + "\n") : (message + "\n")) +
      "<->" +
      (errors.isNotEmpty && isSupportType
          ? ("Error No : " +
              "<|>" +
              () {
                String errorString = "";
                errors.asMap().forEach((i, e) {
                  if (e.errorId != null) {
                    errorString += e.errorId!;
                    if (i < errors.length - 1) errorString += ", ";
                  }
                });
                return errorString;
              }.call())
          : "") +
      "<->" +
      (isSupportType ? "\n\n${ErrorMessages.support}" : "");

  final String message;
  final bool isSupportType;
  final List<ErrorMessage> errors;

  Failure(this.message, this.isSupportType, this.errors);
}

class NetworkFailure extends Failure {
  NetworkFailure() : super(ErrorMessages.networkFail, false, []);
}

class ServerFailure extends Failure {
  ServerFailure(String? msg, bool isSupportType, List<ErrorMessage> errorList)
      : super(msg ?? ErrorMessages.serverFail, isSupportType, errorList);
}

class InternalFailure extends Failure {
  InternalFailure(String? msg) : super(msg ?? ErrorMessages.internalFail, true, []);
}

class DataFailure extends Failure {
  DataFailure(String? msg) : super(msg ?? ErrorMessages.dataFail, true, []);
}

class TokenFailure extends Failure {
  TokenFailure(String? msg) : super(msg ?? ErrorMessages.tokenExpiry, false, []);
}

class TimeoutFailure extends Failure {
  TimeoutFailure([String? msg]) : super(msg ?? ErrorMessages.timeOut, true, []);
}
