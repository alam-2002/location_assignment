import 'package:location_assignment/exports.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool isPermissionDenied = false;

  // LocationController locationController = Get.put(LocationController());

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
    // locationController.checkLocationPermission(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text(isPermissionDenied ? 'Permission Handler' : ''),
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
                          // locationController.requestLocationPermission(context);
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
