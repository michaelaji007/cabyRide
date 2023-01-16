import 'package:get_it/get_it.dart';
import 'package:go_caby_rider/feature/payment/cubits/payment_cubit.dart';
import 'package:go_caby_rider/feature/payment/service/api_service.dart';

import '../../../configs/app_configs.dart';
import '../../../shared/network/network_request.dart';

void setupPaymentServices(GetIt ioc) {
  ioc.registerSingleton<PaymentCubit>(PaymentCubit(
    apiService: PaymentApiService(
      http: HttpService(baseUrl: AppURL.basePaymentUrl, hasAuthorization: true),
    ),
  ));
}
