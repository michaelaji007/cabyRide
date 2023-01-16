import 'package:get_it/get_it.dart';
import 'package:go_caby_rider/shared/Location/location_services.dart';

import 'navigation/navigation_service.dart';

setupSharedServices(GetIt ioc) {
  ioc.registerSingleton<NavigationService>(NavigationService());
  // ioc.registerSingleton<AnalyticService>(AnalyticService());
  ioc.registerSingleton<LocationService>(LocationService());
}
