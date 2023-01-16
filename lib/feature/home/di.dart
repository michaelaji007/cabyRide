import 'package:get_it/get_it.dart';
import 'package:go_caby_rider/feature/home/services/address_api_service.dart';
import 'package:go_caby_rider/feature/home/services/api_service.dart';

import '../../../shared/network/network_request.dart';
import 'cubits/address_cubit.dart';
import 'cubits/trip_cubit.dart';

void setupAddressServices(GetIt ioc) {
  ioc.registerSingleton<AddressApiService>(AddressApiService(
      http: HttpService(baseUrl: "", hasAuthorization: true)));

  ioc.registerSingleton<AddressCubit>(AddressCubit(
      apiService: AddressApiService(
          http: HttpService(baseUrl: "", hasAuthorization: true))));

  ioc.registerSingleton<TripCubit>(TripCubit(
      apiService: TripApiService(
          http: HttpService(baseUrl: "", hasAuthorization: true))));
}
