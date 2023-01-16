import 'package:get_it/get_it.dart';

import '../../../configs/app_configs.dart';
import '../../../shared/network/network_request.dart';
import 'cubits/sign_up_cubit.dart';
import 'services/api_service.dart';

void setupSignUpServices(GetIt ioc) {
  ioc.registerSingleton<SignUpCubit>(SignUpCubit(
    apiService: SignUpApiService(
      http:
          HttpService(baseUrl: AppURL.baseAccountUrl, hasAuthorization: false),
    ),
  ));
}
