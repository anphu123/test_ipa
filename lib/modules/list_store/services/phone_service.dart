import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class PhoneService {
  static const String storePhoneNumber = '0817433226';
  
  static Future<void> makePhoneCall({String? phoneNumber}) async {
    final phone = phoneNumber ?? storePhoneNumber;
    
    try {
      // Thử gọi trực tiếp với flutter_phone_direct_caller
      bool? result = await FlutterPhoneDirectCaller.callNumber(phone);
      if (result == true) {
        return;
      }
      
      // Fallback: Thử mở ứng dụng gọi điện
      final telUri = Uri.parse('tel:$phone');
      if (await canLaunchUrl(telUri)) {
        await launchUrl(telUri, mode: LaunchMode.externalApplication);
        return;
      }
      
      // Nếu không mở được, thử mở dialer với scheme khác
      final dialerSchemes = [
        'tel:$phone',
        'dialer:$phone', 
        'phone:$phone',
      ];
      
      for (String scheme in dialerSchemes) {
        final uri = Uri.parse(scheme);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
          return;
        }
      }
      
      // Thử mở với intent Android
      final androidDialer = Uri.parse('intent://dial/$phone#Intent;scheme=tel;package=com.android.dialer;end');
      if (await canLaunchUrl(androidDialer)) {
        await launchUrl(androidDialer);
        return;
      }
      
      // Fallback: copy số điện thoại và thông báo
      await Clipboard.setData(ClipboardData(text: phone));
      _showInfoSnackbar('Đã copy số điện thoại $phone. Vui lòng mở ứng dụng gọi điện thủ công.');
      
    } catch (e) {
      // Fallback cuối: copy số điện thoại
      try {
        await Clipboard.setData(ClipboardData(text: phone));
        _showInfoSnackbar('Không thể mở ứng dụng gọi điện. Đã copy số $phone vào clipboard.');
      } catch (clipboardError) {
        _showErrorSnackbar('Lỗi: Không thể gọi điện hoặc copy số. Số điện thoại: $phone');
      }
    }
  }
  
  static Future<void> showCallConfirmDialog({
    String? phoneNumber,
    String? storeName,
  }) async {
    final phone = phoneNumber ?? storePhoneNumber;
    final name = storeName ?? 'cửa hàng';
    
    Get.dialog(
      AlertDialog(
        title: Text('Xác nhận cuộc gọi'),
        content: Text('Bạn có muốn gọi điện cho $name?\nSố điện thoại: $phone'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Hủy'),
          ),
          TextButton(
            onPressed: () async {
              Get.back();
              await Clipboard.setData(ClipboardData(text: phone));
              _showInfoSnackbar('Đã copy số điện thoại $phone');
            },
            child: Text('Copy số'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              makePhoneCall(phoneNumber: phone);
            },
            child: Text('Gọi ngay'),
          ),
        ],
      ),
    );
  }
  
  static void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Lỗi',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: Duration(seconds: 4),
    );
  }
  
  static void _showInfoSnackbar(String message) {
    Get.snackbar(
      'Thông báo',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      duration: Duration(seconds: 4),
    );
  }
}






