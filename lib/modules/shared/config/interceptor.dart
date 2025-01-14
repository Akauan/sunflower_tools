import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:sunflower_tools/modules/shared/theme/theme.dart';

class InterceptorConfig {
  // Loading Index
  RxInt loadingIndex = 0.obs;

  // Instantiating the Dio.
  final Dio _dio;

  // Getting the Dio.
  get dio => _dio;

  InterceptorConfig() : _dio = Dio() {
    // Adding the interceptors.
    _dio.interceptors.add(
      InterceptorsWrapper(
        // Request interceptor.
        onRequest: (options, handler) {
          if (loadingIndex.value == 0) {
            // Loading removido
            // getx.Get.dialog(
            //   PopScope(
            //     canPop: false,
            //     onPopInvoked: (bool didPop) async {
            //       if (didPop) return;
            //     },
            //     child: DecoratedBox(
            //       decoration: const BoxDecoration(color: ThemeColor.whiteColor),
            //       child: Center(
            //         child: Lottie.asset(
            //           'assets/jsons/loading.json',
            //         ),
            //       ),
            //     ),
            //   ),
            //   barrierDismissible: false,
            //   barrierColor: ThemeColor.whiteColor,
            // );
          }

          // Changing the value of the variable used for loading.
          loadingIndex.value += 1;

          //  Adding the content type.
          options.headers[HttpHeaders.contentTypeHeader] = 'application/json';

          // defining limit of request time.
          options.connectTimeout = const Duration(milliseconds: 30000);
          options.receiveTimeout = const Duration(milliseconds: 30000);

          // Checking if the request is a FormData.
          if (options.data is FormData) {
            // Adding the content type.
            options.headers[HttpHeaders.contentTypeHeader] =
                'multipart/form-data';
          }

          // Continuing with the request.
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // Changing the value of the variable used for loading.
          loadingIndex.value -= 1;

          if (loadingIndex.value == 0) {
            getx.Get.until((route) => !getx.Get.isDialogOpen!);
          }

          // Continuing with the request.
          return handler.next(response);
        },

        onError: (error, handler) {
          // Changing the value of the variable used for loading.
          loadingIndex.value -= 1;

          if (loadingIndex.value == 0) {
            if (error.requestOptions.method == 'GET') {
              getx.Get.back(closeOverlays: true);
            } else {
              getx.Get.until((route) => !getx.Get.isDialogOpen!);
            }
          }
          _showException(error.response?.data);
          // Continuing with the request.

          // Log the end time of the request.
          final endTime = DateTime.now().second;

          // Calculate the time taken for the request.
          final startTime = error.requestOptions.extra['startTime'];
          final timeTaken = endTime - startTime;

          // Log the time taken for the request.
          log('A solicitação para ${error.requestOptions.uri} levou $timeTaken segundos');
          return handler.next(error);
        },
      ),
    );
  }

  // Implementing the snackbar message to show the error message, requiring the message to be shown
  getx.SnackbarController errorSnackBarCustom(
      {required String message, Color colorText = ThemeColor.primaryColor}) {
    // Settings of the snackbar message with the required message
    return getx.Get.snackbar(
      'Ops!',
      message,
      showProgressIndicator: false,
      colorText: colorText,
      duration: const Duration(seconds: 3),
      backgroundColor: ThemeColor.whiteColor,
      progressIndicatorBackgroundColor: ThemeColor.whiteColor,
      dismissDirection: DismissDirection.horizontal,
      isDismissible: false,
    );
  }

  // Function to show the custom Snackbar, requiring the title and the content of the message
  getx.SnackbarController snackBarCustom({
    required String title,
    required String menssage,
    Color? colorText,
  }) {
    // Settings of the snackbar message with the requireds title and message
    return getx.Get.snackbar(
      title,
      menssage,
      showProgressIndicator: false,
      colorText: colorText ?? ThemeColor.primaryColor,
      duration: const Duration(seconds: 3),
      backgroundColor: ThemeColor.whiteColor,
      dismissDirection: DismissDirection.horizontal,
    );
  }

  // Setting messeges for some of the most common status code responses
  requestError(
    String code,
  ) {
    if (code == '400') {
      errorSnackBarCustom(
          message: "Data submission issues. Please contact support.");
    } else if (code == '401') {
      errorSnackBarCustom(message: "Incorrect username or password.");
    } else if (code == '200') {
      errorSnackBarCustom(message: "User connected.");
    } else if (code == '500') {
      errorSnackBarCustom(
          message: "Server unavailable. Please contact support.");
    } else if (code == "disconnected") {
      errorSnackBarCustom(
          message: "You are disconnected. Please try again later.");
    } else {
      errorSnackBarCustom(message: "Unknown error. Please contact support.");
    }
  }

  void _showException(data) {
    try {
      if (data.runtimeType == String) {
        errorSnackBarCustom(
            message: "Algo deu errado. Entre em contato com o suporte.");
      } else if (data.runtimeType == List<dynamic>) {
        errorSnackBarCustom(message: data[0]);
      } else {
        data.forEach((key, value) {
          if (value.runtimeType == List) {
            for (var element in value) {
              errorSnackBarCustom(
                message: '$key $element',
              );
            }
          } else {
            errorSnackBarCustom(message: value.toString());
          }
        });
      }
    } catch (e) {
      errorSnackBarCustom(
          message: 'Serviço indisponível. Tente novamente mais tarde.');
    }
  }
}
