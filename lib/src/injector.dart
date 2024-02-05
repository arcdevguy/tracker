import 'package:get_it/get_it.dart';
import 'location/flutter_location_service.dart';
import 'location/location_service.dart';
import 'provider/home_provider.dart';

GetIt getIt = GetIt.instance;

class Injector {
  static void init() {
    getIt.registerFactory<LocationService>(() => FlutterLocationService());
    // getIt.registerFactory<HomeProvider>(() => HomeProvider(locationService: getIt()));
    getIt.registerFactory<HomeProvider>(() => HomeProvider(locationService: getIt<LocationService>()));
  }
}
