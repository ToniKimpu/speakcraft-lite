import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:speakcraft/core/di/service_locator.dart';
import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:speakcraft/model/app_user/app_user.dart';
import 'package:speakcraft/model/payment_method/payment_method.dart';
import 'package:speakcraft/model/payment_submission/payment_submission.dart';
import 'package:speakcraft/repositories/payment/payment_repository.dart';

part 'payment_bloc.freezed.dart';

@freezed
abstract class PaymentEvent with _$PaymentEvent {
  const factory PaymentEvent.loadMethods() = _LoadMethods;
  const factory PaymentEvent.submitPayment(PaymentMethod method, File proof) =
      _SubmitPayment;
}

@freezed
abstract class PaymentState with _$PaymentState {
  const factory PaymentState.initial() = _Initial;
  const factory PaymentState.loadingMethods() = _LoadingMethods;
  const factory PaymentState.methodsLoaded(List<PaymentMethod> methods) =
      _MethodsLoaded;
  const factory PaymentState.methodsError(String message) = _MethodsError;
  const factory PaymentState.submitting() = _Submitting;
  const factory PaymentState.submitted(PaymentSubmission submission) =
      _Submitted;
  const factory PaymentState.submitError(String message) = _SubmitError;
}

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository _repository;

  PaymentBloc({PaymentRepository? repository})
      : _repository = repository ?? sl<PaymentRepository>(),
        super(const PaymentState.initial()) {
    on<PaymentEvent>((event, emit) async {
      await event.when(
        loadMethods: () => _mapLoadMethodsToState(emit),
        submitPayment: (method, proof) =>
            _mapSubmitPaymentToState(method, proof, emit),
      );
    });
  }

  Future<void> _mapLoadMethodsToState(Emitter<PaymentState> emit) async {
    emit(const PaymentState.loadingMethods());
    try {
      final methods = await _repository.loadActiveMethods();
      emit(PaymentState.methodsLoaded(methods));
    } catch (e) {
      AppLogger.instance.error('_loadMethodsError: $e', error: e);
      emit(const PaymentState.methodsError(
          'Could not load payment methods. Please try again.'));
    }
  }

  Future<void> _mapSubmitPaymentToState(
    PaymentMethod method,
    File proof,
    Emitter<PaymentState> emit,
  ) async {
    final userId = sl<ValueNotifier<AppUser>>().value.id;
    if (userId == null) {
      emit(const PaymentState.submitError(
          'Your session expired. Please sign in again.'));
      return;
    }
    emit(const PaymentState.submitting());
    try {
      final proofPath = await _repository.uploadProof(proof);
      final submission = await _repository.submitPayment(
        userId: userId,
        method: method,
        proofPath: proofPath,
      );
      emit(PaymentState.submitted(submission));
    } catch (e) {
      AppLogger.instance.error('_submitPaymentError: $e', error: e);
      emit(const PaymentState.submitError(
          'Could not submit your payment. Please try again.'));
    }
  }
}
