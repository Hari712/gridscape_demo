import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gridscape_demo/blocs/charger_list_bloc.dart';
import 'package:gridscape_demo/models/evses.dart';
import 'package:gridscape_demo/presentation/common_widgets/evse.dart';
import 'package:gridscape_demo/presentation/common_widgets/mapView.dart';
import 'package:gridscape_demo/utils/constants.dart';
import 'package:gridscape_demo/utils/help.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  static String path = "/";
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Position? position;
  late LocationSettings locationSettings;
  MapController mapController = MapController();
  ChargerListBloc chargerListBloc = GetIt.I<ChargerListBloc>();

  @override
  void initState() {
    super.initState();
    getCurrentPosition();
    chargerListBloc
        .add(ChargerListEvent.getChargerList({"chargerVisibility": "ALL", "hierarchyLevel": "UPTO_CONNECTOR"}));
  }

  getCurrentPosition() async {
    LocationPermission checkPermission = await Geolocator.checkPermission();
    print("checkPermission $checkPermission");
    if (checkPermission == LocationPermission.always || checkPermission == LocationPermission.whileInUse) {
      if (defaultTargetPlatform == TargetPlatform.android) {
        locationSettings = AndroidSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 100,
            forceLocationManager: true,
            intervalDuration: const Duration(seconds: 10),
            foregroundNotificationConfig: const ForegroundNotificationConfig(
              notificationText: "Example app will continue to receive your location even when you aren't using it",
              notificationTitle: "Running in Background",
              enableWakeLock: true,
            ));
      } else if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS) {
        locationSettings = AppleSettings(
          accuracy: LocationAccuracy.high,
          activityType: ActivityType.fitness,
          distanceFilter: 100,
          pauseLocationUpdatesAutomatically: true,
          showBackgroundLocationIndicator: false,
        );
      } else {
        locationSettings = const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
        );
      }

      StreamSubscription<Position> positionStream =
          Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position? pos) {
        if (pos != null) {
          setState(() {
            print("position $position $pos");
            position = pos;
            mapController.move(LatLng(pos.latitude, pos.longitude), 13);
          });
        }
      });
    } else {
      await Geolocator.requestPermission();
      getCurrentPosition();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => chargerListBloc,
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: MapView(mapController: mapController),
          ),
          Expanded(
            flex: 8,
            child: BlocBuilder<ChargerListBloc, ChargerListState>(
              bloc: chargerListBloc,
              builder: (context, state) {
                return state.when(
                  empty: (l, f) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  loaded: (l, chargers) {
                    return ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (ctx, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                          decoration: const BoxDecoration(
                            border: Border(top: BorderSide()),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    chargers[index].chargerId ?? "",
                                    style: GoogleFonts.poppins(
                                      color: AppColors.dark,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    chargers[index].name ?? "",
                                    style: GoogleFonts.poppins(
                                      color: AppColors.dark,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    chargers[index].address ?? "",
                                    style: GoogleFonts.poppins(
                                      color: AppColors.secondary,
                                    ),
                                  ),
                                  if (position != null)
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          size: 16,
                                          color: AppColors.secondary,
                                        ),
                                        Text(
                                          "${distance(chargers[index].latitude!.toDouble(), chargers[index].longitude!.toDouble(), position!.latitude, position!.longitude)} miles",
                                          style: GoogleFonts.poppins(
                                            color: AppColors.secondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (chargers[index].evses != null && chargers[index].evses!.isNotEmpty)
                                      Row(
                                        children: List.generate(
                                          chargers[index].evses!.length,
                                          (i) {
                                            Evses evses = chargers[index].evses![i];
                                            return EvseBox(
                                              evses: evses,
                                            );
                                          },
                                        ),
                                      ),
                                    Column(
                                      children: [
                                        IconButton(
                                          icon: CircleAvatar(
                                            backgroundColor: AppColors.gray,
                                            maxRadius: 16,
                                            child: const Icon(
                                              Icons.star_border,
                                              color: Colors.white,
                                            ),
                                          ),
                                          onPressed: () {},
                                        ),
                                        IconButton(
                                          icon: CircleAvatar(
                                            backgroundColor: AppColors.primary,
                                            maxRadius: 16,
                                            child: const Icon(
                                              Icons.navigation_outlined,
                                              color: Colors.white,
                                            ),
                                          ),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: chargers.length,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
