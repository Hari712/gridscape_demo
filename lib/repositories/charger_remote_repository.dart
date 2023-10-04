import 'package:dio/dio.dart';
import 'package:gridscape_demo/models/sites.dart';
import 'package:gridscape_demo/models/standard_response.dart';
import 'package:retrofit/retrofit.dart';

part 'charger_remote_repository.g.dart';

@RestApi()
abstract class ChargerRemoteRepository {
  factory ChargerRemoteRepository(Dio dio, {String baseUrl}) = _ChargerRemoteRepository;

  @POST("/chargers")
  Future<StandardResponse<SiteData, SiteData>> getListOfCharger(
    @Body() dynamic requestBody,
  );
}
