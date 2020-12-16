import 'package:eatoz_map/mapScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eatoz_map/provider/map_data_provider.dart';
import 'package:permission/permission.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController srcLatController = TextEditingController();
  TextEditingController srcLngController = TextEditingController();

  TextEditingController destLatController = TextEditingController();
  TextEditingController destLngController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var mapDataProvider = Provider.of<MapDataProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Let's Go !"),
          elevation: 0.0,
        ),
        body: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Source: '),
                      Flexible(
                        child: TextField(
                          controller: srcLatController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Latitude',
                            hintText: 'Enter Latitude ',
                          ),
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          controller: srcLngController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Longitude',
                            hintText: 'Enter Longitude',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 10.0,
                // ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Destination: '),
                      Flexible(
                        child: TextField(
                          controller: destLatController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Latitude',
                            hintText: 'Enter Latitude ',
                          ),
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          controller: destLngController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Longitude',
                            hintText: 'Enter Longitude',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 10.0,
                // ),
                RaisedButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: Text('Go to Maps'),
                  onPressed: () {
                    mapDataProvider.setLatLng([
                      double.parse(srcLatController.text.trim()),
                      double.parse(srcLngController.text.trim())
                    ], [
                      double.parse(destLatController.text.trim()),
                      double.parse(destLngController.text.trim())
                    ]);

                    // getPermis();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MapScreen(
                            {mapDataProvider.src, mapDataProvider.dest})));
                  },
                )
              ],
            )));
  }

  // getPermis() async {
  //   var permissions =
  //       await Permission.getPermissionsStatus([PermissionName.Location]);
  //   if (permissions[0].permissionStatus == PermissionStatus.notAgain) {
  //     var askpermissions =
  //         await Permission.requestPermissions([PermissionName.Location]);
  //   }
  // }
}
