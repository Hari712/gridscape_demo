import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@module
abstract class RegisterModule {
  Connectivity get connection => Connectivity();

  @lazySingleton
  Logger get logger => Logger();
}
