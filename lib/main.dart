import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/application/storage/storage_keys.dart';
import 'package:provider/repositories/auth_repository.dart';
import 'package:provider/repositories/service_profile_update_repository.dart';
import 'package:provider/repositories/tracking_repository.dart';
import 'package:provider/router/route_constants.dart';
import 'package:provider/router/router.dart';
import 'package:provider/state/auth_state.dart';
import 'package:provider/state/service_profile_update_state.dart';
import 'package:provider/state/tracking_state.dart';
import 'package:provider/ui/profile_page.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'application/storage/localstorage.dart';
Future<void> getPermission() async {
  PermissionStatus permission =
      await PermissionHandler().checkPermissionStatus(PermissionGroup.location);
  if (permission == PermissionStatus.denied) {
    await PermissionHandler()
        .requestPermissions([PermissionGroup.locationAlways]);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.initializeSharedPreference();
  runApp(InstantSewaProvider());
}

class InstantSewaProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Injector(
      inject: [
        Inject<AuthState>(() => AuthState(AuthRepositoryImpl())),
        Inject<ServiceProviderUpdateState>(
            () => ServiceProviderUpdateState(ServiceProfileUpdateRepositoryImpl())),
        Inject<TrackingState>(() => TrackingState(TrackingRepositoryImpl())),
      ],
      builder: (context) {
        return  MaterialApp(
            home: ProfilePage(),
            debugShowCheckedModeBanner: false,
            onGenerateRoute: Routers.onGenerateRoute,
            initialRoute: LocalStorage.getItem(TOKEN) != null
                ? LocalStorage.getItem(FUllNAME) == null
                ? fullNameUpdateRoute
                : LocalStorage.getItem(PHONE) == null
                ? phoneUpdateRoute
                : LocalStorage.getItem(ADDRESS_ADDRESS) == null
                ? addressUpdateRoute
                : homeRoute
                : loginRoute,
          );
      },
    );
  }
}
