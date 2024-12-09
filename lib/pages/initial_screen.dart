import 'package:flutter/material.dart';
import 'package:location_assignment/pages/home_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool isPermissionDenied = false;

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isPermissionDenied ? 'Permission Handler' : ''),
        centerTitle: true,
      ),
      body: SafeArea(
        child: isPermissionDenied
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Location permission is required to proceed !!'),
                  SizedBox(height: 25),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          _requestLocationPermission();
                        },
                        child: Text(
                          'Allow Permission',
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Container(),
      ),
    );
  }

  Future<void> _checkLocationPermission() async {
    PermissionStatus status = await Permission.location.status;

    if (status.isGranted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else if (status.isDenied) {
      _requestLocationPermission();
    }
  }

  Future<void> _requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else if (status.isDenied) {
      setState(() {
        isPermissionDenied = true;
      });
    }
  }
}
