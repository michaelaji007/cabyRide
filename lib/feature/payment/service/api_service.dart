import 'package:dio/dio.dart';

import '../../../../shared/network/network_request.dart';

class PaymentApiService {
  final HttpService http;
  PaymentApiService({required this.http});

  Future<Response> getPaymentMethod() async {
    return http.getRequest(
      "payment-methods",
    );
  }

  Future<Response> deleteCard(id) async {
    return http.delete("cards/$id");
  }

  Future<Response> setPrefPaymentMethod(Map body) async {
    return http.put("payment-methods/preference", data: body);
  }

  Future<Response> sendTxRef(paystackReference) async {
    return http.post(
      "cards/paystack/$paystackReference",
    );
  }

  // Future<Response> selectPreferrredMethod(Object body) async {
  //   return http.post("", data: body);
  // }
}
