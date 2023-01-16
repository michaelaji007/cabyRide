part of 'payment_cubit.dart';

@immutable
abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class GetCardsLoading extends PaymentState {}

class GetCardsSuccess extends PaymentState {
  final List<PaymentMethod> methods;

  GetCardsSuccess({required this.methods});
}

class GetCardsError extends PaymentState {
  final String message;
  GetCardsError({required this.message});
}

class DeleteCardLoading extends PaymentState {}

class DeleteCardSuccess extends PaymentState {}

class DeleteCardError extends PaymentState {
  final String message;
  DeleteCardError({required this.message});
}

class SendTxRefLoading extends PaymentState {}

class SendTxRefSuccess extends PaymentState {}

class SendTxRefError extends PaymentState {
  final String message;
  SendTxRefError({required this.message});
}

class SetPrefLoading extends PaymentState {}

class SetPrefSuccess extends PaymentState {}

class SetPrefError extends PaymentState {
  final String message;
  SetPrefError({required this.message});
}
