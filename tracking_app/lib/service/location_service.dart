// import 'package:location/location.dart';

// Location _location = Location();

// // Checked the location service is enabled and the permission is granted.
// // \return true ready to use location
// // \return false can not use location
// Future<bool> serviceCheckLocationEnabled() async {
//   bool isEnabled = await _location.serviceEnabled();
//   if (!isEnabled) {
//     isEnabled = await _location.requestService();
//     if (!isEnabled) {
//       return false;
//     }
//   }

//   PermissionStatus perm = await _location.hasPermission();
//   if (perm != PermissionStatus.granted) {
//     perm = await _location.requestPermission();
//     if (perm != PermissionStatus.granted) {
//       return false;
//     }
//   }

//   return true;
// }

// Stream<LocationData> serviceLocationStream() {
//   return _location.onLocationChanged;
// }
