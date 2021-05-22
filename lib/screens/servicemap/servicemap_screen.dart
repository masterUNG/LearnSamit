import 'dart:ffi';

import 'package:ASmartApp/models/search_hospital_model.dart';
import 'package:ASmartApp/services/rest_api.dart';
import 'package:ASmartApp/utils/my_style.dart';
import 'package:ASmartApp/utils/normal_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ServiceMapScreen extends StatefulWidget {
  ServiceMapScreen({Key key}) : super(key: key);

  @override
  _ServiceMapScreenState createState() => _ServiceMapScreenState();
}

class _ServiceMapScreenState extends State<ServiceMapScreen> {
  String search;
  List<SearchHospitalModel> searchHospitalModels = List();

  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // LatLng latlng = LatLng(
  //   13.842797,
  //   100.5772309,
  // );

  LatLng latLng;

  LatLng createLatLng(double lat, double lng) {
    return LatLng(lat, lng);
  }

  @override
  void initState() {
    super.initState();

    latLng = createLatLng(
      13.842797,
      100.5772309,
    );
  }

  Set<Marker> setMarker() {
    return Set<Marker>.of(markers.values);
  }

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{
    MarkerId('baac-01'): Marker(
      markerId: MarkerId('baac-01'),
      position: LatLng(13.842797, 100.5772309),
      infoWindow: InfoWindow(
          title: 'ธกส สำนักงานใหญ่',
          snippet: 'แขวง เสนานิคม เขตจตุจักร กรุงเทพมหานคร 10220'),
      onTap: () {
        //_onMarkerTapped(markerId);
        print('Marker Tapped');
      },
      onDragEnd: (LatLng position) {
        print('Drag Ended');
      },
    ),
    MarkerId('baac-02'): Marker(
      markerId: MarkerId('baac-02'),
      position: LatLng(13.841135, 100.545355),
      infoWindow: InfoWindow(
          title: 'ธนาคาร ธกส. สาขาย่อยประชาชื่น',
          snippet:
              '14 ถนน เทศบาลสงเคราะห์ แขวง ลาดยาว เขตจตุจักร กรุงเทพมหานคร 10900'),
      onTap: () {
        //_onMarkerTapped(markerId);
        print('Marker Tapped');
      },
      onDragEnd: (LatLng position) {
        print('Drag Ended');
      },
    ),
    MarkerId('baac-03'): Marker(
      markerId: MarkerId('baac-03'),
      position: LatLng(13.821531, 100.591431),
      infoWindow: InfoWindow(
          title: 'ธนาคารธกส. วังหิน',
          snippet:
              'ซอย ลาดพร้าววังหิน 52 แขวง ลาดพร้าว เขตลาดพร้าว กรุงเทพมหานคร 10230'),
      onTap: () {
        //_onMarkerTapped(markerId);
        print('Marker Tapped');
      },
      onDragEnd: (LatLng position) {
        print('Drag Ended');
      },
    ),
    MarkerId('baac-04'): Marker(
      markerId: MarkerId('baac-04'),
      position: LatLng(13.821220, 100.591206),
      infoWindow: InfoWindow(
          title: 'ธนาคารเพื่อการเกษตรและสหกรณ์การเกษตร สาขาย่อยโชคชัย 4',
          snippet:
              '481 ถนนลาดพร้าว-วังหิน ต.ลาดพร้าว อ.ลาดพร้าว กรุงเทพมหานคร 10230'),
      onTap: () {
        //_onMarkerTapped(markerId);
        print('Marker Tapped');
      },
      onDragEnd: (LatLng position) {
        print('Drag Ended');
      },
    )
  };

  Future<Null> findLocationBySearch(String search) async {
    Map<String, dynamic> data = Map();
    data['IMEI'] = 'baac1234';
    data['pass'] = 'baac';
    data['search_name'] = search;

    var result = await CallAPI().postData(data, 'HospitalDetail/');
    // print('######## result search map ===>>> $result');
    if (result.toString() == '[]') {
      normalDialog(context, 'ไม่มี $search ในฐานข้อมูลของเรา');
    } else {
      for (var json in result) {
        SearchHospitalModel model = SearchHospitalModel.fromJson(json);
        setState(() {
          searchHospitalModels.add(model);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              if (searchHospitalModels.length != 0) {
                searchHospitalModels.clear();
              }

              if (search == null || search.isEmpty) {
                normalDialog(context, 'กรุณากรอก ค้นหาด้วย คะ');
              } else {
                findLocationBySearch(search);
              }
            },
          )
        ],
        title: Container(
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(30),
          ),
          //width: 200,
          height: 40,
          child: TextField(
            style: MyStyle().whiteStyle(),
            onChanged: (value) => search = value.trim(),
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: TextStyle(color: Colors.white54),
              contentPadding: EdgeInsets.only(left: 16, bottom: 8),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          searchHospitalModels.length == 0
              ? SizedBox()
              : ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: searchHospitalModels.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      print(
                          'you Click ${searchHospitalModels[index].latitude}');
                      double lat = double.parse(
                          searchHospitalModels[index].latitude.trim());
                      double lng = double.parse(
                          searchHospitalModels[index].longitude.trim());
                      latLng = createLatLng(lat, lng);
                      mapController.moveCamera(CameraUpdate.newCameraPosition(
                          CameraPosition(target: latLng, zoom: 16)));

                      Marker marker = Marker(
                        markerId:
                            MarkerId('id${searchHospitalModels[index].id}'),
                        position: latLng,
                        infoWindow: InfoWindow(
                          title: searchHospitalModels[index].name,
                          snippet: searchHospitalModels[index].description,
                        ),
                      );
                      // print('Before  ${setMarker().length}');

                      markers[MarkerId('id${searchHospitalModels[index].id}')] =
                          marker;

                      setState(() {
                        setMarker();

                        // print('Last ${setMarker().length}');
                      });
                    },
                    child: Text(searchHospitalModels[index].name),
                  ),
                ),
          Expanded(
            child: GoogleMap(
              // markers: Set<Marker>.of(markers.values),
              markers: setMarker(),
              initialCameraPosition: CameraPosition(target: latLng, zoom: 14.0),
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
            ),
          ),
        ],
      ),
    );
  }
}
