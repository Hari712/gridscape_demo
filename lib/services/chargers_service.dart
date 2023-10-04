import 'package:dartz/dartz.dart';
import 'package:gridscape_demo/models/errors/failure.dart';
import 'package:gridscape_demo/models/sites.dart';
import 'package:gridscape_demo/services/chargers_local_service.dart';
import 'package:injectable/injectable.dart';

abstract class IChargersService {
  Future<Either<Failure, SiteData>> getChargersList(dynamic requestBody);
}

@LazySingleton(as: IChargersService)
class ChargersService implements IChargersService {
  final ChargersLocalService _chargersLocalService;
  ChargersService(this._chargersLocalService);

  @override
  Future<Either<Failure, SiteData>> getChargersList(requestBody) async =>
      await _chargersLocalService.getChargersList(requestBody);
}
