import 'package:location_assignment/exports.dart';

class LocationController extends GetxController {
  RxBool isPermissionDenied = false.obs;

  Future<void> checkLocationPermission(BuildContext context) async {
    PermissionStatus status = await Permission.location.status;

    if (status.isGranted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else if (status.isDenied) {
      requestLocationPermission(context);
    } /*else if (status.isPermanentlyDenied) {
      isPermissionDenied.value = true;
      AppSettings.openAppSettings(type: AppSettingsType.location);
    }*/
  }

  Future<void> requestLocationPermission(BuildContext context) async {
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else if (status.isDenied) {
      isPermissionDenied.value = true;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => InitialScreen()),
      );
    } /*else if(status.isPermanentlyDenied){
      isPermissionDenied.value = true;
      AppSettings.openAppSettings(type: AppSettingsType.location);
    }*/
  }

  Future<void> _alertDialogPopUp(BuildContext context) async {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Permission is Permanently Denied',
            style: TextStyle(fontSize: 20),
          ),
          content: Text('Location permission is required to proceed !!'),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                isPermissionDenied.value = true;
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(builder: (context) => InitialScreen()),
                // );
              },
            ),
            TextButton(
              child: Text(
                'Turn on',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                // requestLocationPermission(context);
                AppSettings.openAppSettings(type: AppSettingsType.location);
              },
            ),
          ],
        );
      },
    );
  }
}
