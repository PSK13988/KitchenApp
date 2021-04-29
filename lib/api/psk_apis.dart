import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterrestaurant/api/ps_url.dart';
import 'package:flutterrestaurant/config/ps_config.dart';
import 'package:flutterrestaurant/ui/common/dialog/warning_dialog_view.dart';
import 'package:flutterrestaurant/ui/product/detail/product_detail_view.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class PskApiUtils {
  static Future<bool> enquiryOurServices(
      {String service,
      String name,
      String mobile,
      String email,
      String message}) async {
    print('Calling Enquiry Api...');
    const String urlEnd =
        '${PsConfig.ps_app_url}${PsUrl.ps_transaction_enquiry}';
    print('Calling Api: $urlEnd');

    final Map<String, String> body = {
      'service': service.trim(),
      'name': name.trim(),
      'mobile': mobile.trim(),
      'email': email.trim(),
      'message': message.trim(),
    };

    print('Calling Api: $urlEnd');
    print('params: $body');
    final Response response = await http.post(urlEnd, body: body);

    print('StatusCode: ${response?.statusCode}, response: ${response?.body}');
    if (response.body.contains('1')) {
      return true;
    } else {
      return false;
    }
  }

  static Future<void> cancelOrder({String transactionId}) async {
    print('Calling Cancel Api...');
    const String urlEnd = '${PsUrl.ps_transaction_cancel_url}';
    //http://welcomekitchen.in/flutter-restaurant-admin/index.php/rest/transactionheaders/cancel_order/api_key/welcomekitchenind?transactions_header_id=trans_hdr_31f749e7d8328934d685f1d33a1142d7
    final String url =
        '${PsConfig.ps_app_url}$urlEnd?transactions_header_id=$transactionId';
    print('Calling Api: $url');
    final Response response = await http.get(url,
        headers: <String, String>{'content-type': 'application/json'});

    print('StatusCode: ${response?.statusCode}, response: ${response?.body}');
  }

  static Future<bool> checkShopStatus(BuildContext context) async {
    print('Calling ShopStatus Api...');
    const String urlEnd = '${PsUrl.ps_shop_status_url}';
    const String url = '${PsConfig.ps_app_url}$urlEnd';
    //http://welcomekitchen.in/flutter-restaurant-admin/index.php/rest/transactionheaders/shop_status/api_key/welcomekitchenind
    print('Calling Api: $url');
    final Response response = await http.get(url,
        headers: <String, String>{'content-type': 'application/json'});

    print('StatusCode: ${response?.statusCode}, response: ${response?.body}');
    if (response != null && response.body != null && response.body.isNotEmpty) {
      final ShopStatusResponse shopStatusResponse =
          ShopStatusResponse.fromJson(jsonDecode(response.body));
      print('shopStatusResponse ${shopStatusResponse.status}');
      if (shopStatusResponse.status == 'true') {
        return true;
      } else {
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return WarningDialog(
                message: shopStatusResponse.message,
              );
            });
        return false;
      }
    } else {
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return const WarningDialog(
              message: 'Unknown error occurred, please try after some time',
            );
          });
      return false;
    }
  }
}
