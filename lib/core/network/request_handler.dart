import 'dart:async';
import 'dart:developer';

// import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:grateful_notes/core/network/response_model.dart';
import 'package:logger/logger.dart';

class RequestHandler {
  final Function() request;
  final bool removeFocus, showProgress;
  final ValueSetter<ResponseModel> onSuccess;
  final ValueSetter<ResponseModel> onError;
  final Function()? onRequestStart, onRequestEnd;

  RequestHandler({
    required this.request,
    required this.onSuccess,
    required this.onError,
    this.showProgress = false,
    this.removeFocus = true,
    this.onRequestStart,
    this.onRequestEnd,
  });

  Future<void> sendRequest() async {
    if (removeFocus) FocusManager.instance.primaryFocus?.unfocus();
    try {
      await onRequestStart?.call();
      ResponseModel result = await request.call();

      onSuccess(result);
    } catch (e) {
      if (e is ResponseModel) {
        onError(e);
        return;
      }
      Logger().e(e.toString());
      onError(ResponseModel(code: 400, data: {"data": "fail"}, success: false));
      onRequestEnd?.call();
    } finally {
      log("Network Call Terminated >> > Request Ended::");
      onRequestEnd?.call();
    }
    // onRequestEnd?.call();
  }
}
