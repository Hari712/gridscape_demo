import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:gridscape_demo/presentation/common_widgets/common_textfield.dart';
import 'package:gridscape_demo/utils/constants.dart';

class MapView extends StatelessWidget {
  final MapController mapController;
  const MapView({Key? key, required this.mapController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(zoom: 13),
      children: [
        TileLayer(
          urlTemplate: 'http://{s}.google.com/vt?lyrs=m&x={x}&y={y}&z={z}',
          subdomains: ['mt0', 'mt1', 'mt2', 'mt3'],
          maxZoom: 13,
        ),
        CurrentLocationLayer(),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: const EdgeInsets.all(10),
                  child: const CommonTextField(labelText: "Search chargers")),
              IconButton(
                icon: CircleAvatar(
                  backgroundColor: AppColors.secondary,
                  child: const Icon(
                    Icons.settings_applications_sharp,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                onPressed: () {},
              ),
            ],
          ),
        )
      ],
    );
  }
}
