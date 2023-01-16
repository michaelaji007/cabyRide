import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../../configs/app_configs.dart';
import '../../../../shared/network/network_request.dart';
import '../model/method_model.dart';
import '../service/api_service.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentApiService apiService;
  PaymentCubit({required this.apiService}) : super(PaymentInitial());

  void getPaymentMethod() async {
    emit(GetCardsLoading());
    try {
      var res = await apiService.getPaymentMethod();
      if (res.isSuccessful) {
        log(jsonEncode(res.data));
        List<PaymentMethod> cards =
            (res.data as List).map((e) => PaymentMethod.fromJson(e)).toList();

        emit(GetCardsSuccess(methods: cards));
      } else {
        emit(GetCardsError(message: AppConstants.anErrorOccurred));
      }
    } catch (ex) {
      if (ex is DioError) {
        var errorMessage = networkErrorHandler(ex);

        emit(GetCardsError(message: errorMessage));
      } else {
        emit(GetCardsError(message: AppConstants.anErrorOccurred));
      }
    }
  }

  void setPrefPaymentMethod(paymentMethod, value) async {
    emit(SetPrefLoading());
    var body = {"paymentMethodType": paymentMethod, "value": value};
    try {
      var res = await apiService.setPrefPaymentMethod(body);
      if (res.isSuccessful) {
        emit(SetPrefSuccess());
      } else {
        emit(SetPrefError(message: AppConstants.anErrorOccurred));
      }
    } catch (ex) {
      if (ex is DioError) {
        var errorMessage = networkErrorHandler(ex);

        emit(SetPrefError(message: errorMessage));
      } else {
        emit(SetPrefError(message: AppConstants.anErrorOccurred));
      }
    }
  }

  void deleteCard(id) async {
    emit(DeleteCardLoading());

    try {
      var res = await apiService.deleteCard(id);

      if (res.isSuccessful) {
        emit(DeleteCardSuccess());
      } else {
        var message = res.data["message"];
        emit(DeleteCardError(message: message));
      }
    } catch (ex) {
      if (ex is DioError) {
        if (ex.response?.statusCode == 400) {
          var message = ex.response!.data["message"];
          emit(DeleteCardError(message: message));
        } else {
          var errorMessage = networkErrorHandler(ex);
          emit(DeleteCardError(message: errorMessage));
        }
      }
    }
  }

  void sentTxRef(txref) async {
    emit(SendTxRefLoading());

    try {
      var res = await apiService.sendTxRef(txref);

      if (res.isSuccessful) {
        // var data = res.data["data"];
        emit(SendTxRefSuccess());
      }
    } catch (ex) {
      if (ex is DioError) {
        var errorMessage = networkErrorHandler(ex);

        emit(SendTxRefError(message: errorMessage));
      }
    }
  }
}
