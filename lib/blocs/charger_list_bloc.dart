import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gridscape_demo/models/charger_data.dart';
import 'package:gridscape_demo/models/errors/failure.dart';
import 'package:gridscape_demo/models/sites.dart';
import 'package:gridscape_demo/services/chargers_service.dart';
import 'package:gridscape_demo/utils/enum.dart';
import 'package:injectable/injectable.dart';

part 'charger_list_bloc.freezed.dart';

@injectable
class ChargerListBloc extends Bloc<ChargerListEvent, ChargerListState> {
  IChargersService _chargersService;

  ChargerListBloc(
    this._chargersService,
  ) : super(const ChargerListState.empty(LoadingStatus.Initialized, null)) {
    on<ChargerListEvent>((event, emit) async {
      await event.when(
        getChargerList: (requestBody) async {
          final resp = await _chargersService.getChargersList(requestBody);
          resp.fold(
            (l) => emit(ChargerListState.empty(LoadingStatus.Error, l)),
            (r) {
              List<Sites> sites = r.sites ?? [];
              List<ChargerData> chargers = [];
              for (var i = 0; i < sites.length; i++) {
                if (sites[i].chargers != null) {
                  sites[i].chargers?.forEach(
                        (e) => chargers.add(
                          ChargerData(
                            e.uid,
                            e.chargerId,
                            e.evses,
                            e.imageUrl,
                            e.isPublic,
                            e.latitude,
                            e.longitude,
                            e.isFavorite,
                            sites[i].address,
                            sites[i].city,
                            sites[i].country,
                            sites[i].name,
                            sites[i].zip,
                            sites[i].state,
                            sites[i].chargers,
                          ),
                        ),
                      );
                }
              }
              print("chargers $chargers");
              return emit(ChargerListState.loaded(LoadingStatus.Done, chargers));
            },
          );
        },
      );
    });
  }
}

@freezed
class ChargerListState with _$ChargerListState {
  const factory ChargerListState.empty(LoadingStatus loadingStatus, Failure? failure) = _EmptyState;
  const factory ChargerListState.loaded(LoadingStatus loadingStatus, List<ChargerData> chargerData) = _LoadedState;
}

@freezed
class ChargerListEvent with _$ChargerListEvent {
  const factory ChargerListEvent.getChargerList(requestBody) = _GetChargerList;
}
