import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:gridscape_demo/models/errors/failure.dart';
import 'package:gridscape_demo/models/sites.dart';
import 'package:gridscape_demo/repositories/charger_remote_repository.dart';
import 'package:gridscape_demo/repositories/remote_repository.dart';
import 'package:injectable/injectable.dart';

abstract class IChargersRepository {
  Future<Either<Failure, SiteData>> getChargerList(
    dynamic requestBody,
  );
}

@LazySingleton(as: IChargersRepository)
class ChargersRepository implements IChargersRepository {
  ChargerRemoteRepository? _chargerRemoteRepository;

  ChargersRepository();

  RemoteRepository _getRemoteRepository() {
    return GetIt.I<RemoteRepository>().assignMap(_assignMap);
  }

  @override
  Future<Either<Failure, SiteData>> getChargerList(requestBody) async =>
      await _getRemoteRepository().processRemoteCall<SiteData>(getChargerList, params: [requestBody]);

  Future _assignMap(Dio repositoryClient, RemoteRepository remoteRepository) async {
    _chargerRemoteRepository = ChargerRemoteRepository(repositoryClient);
    final chargerRemoteRepository = _chargerRemoteRepository!;
    remoteRepository.functionMap = {
      getChargerList: chargerRemoteRepository.getListOfCharger,
    };
  }
}
