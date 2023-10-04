import 'package:dartz/dartz.dart';
import 'package:gridscape_demo/models/errors/failure.dart';
import 'package:gridscape_demo/models/sites.dart';
import 'package:gridscape_demo/repositories/chargers_repository.dart';
import 'package:gridscape_demo/utils/connection.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@injectable
class ChargersLocalService {
  IChargersRepository _chargersRepository;

  final Logger _logger;
  final InternetConnectivity _internetConnectivity = InternetConnectivity.instance;

  ChargersLocalService(this._chargersRepository, this._logger);

  Future<Either<Failure, SiteData>> getChargersList(dynamic requestBody) async {
    try {
      bool isOnline = await _internetConnectivity.hasInternet();

      if (!isOnline) return Left(NetworkFailure());

      final resp = await _chargersRepository.getChargerList(requestBody);
      return resp.fold((l) => Left(l), (r) => Right(r));
    } catch (e) {
      _logger.e(e);
      return Left(InternalFailure(null));
    }
  }
}
