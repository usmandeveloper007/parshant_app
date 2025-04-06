import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:parshant_app/core/utils/utils.dart';

// WhatsApp Open Karna
void openWhatsApp(
  String message1,
) async {
  String? value = await SharedPreferencesHelper.getValue();

  String message = "$message1 \n\nRef.ID:$value";

  final intent = AndroidIntent(
    action: 'android.intent.action.VIEW',
    data: "https://wa.me/918221859558?text=${Uri.encodeComponent(message)}",
    package: "com.whatsapp",
  );

  await intent.launch();
}

void initiateWhatsAppPayment(String upiId, String amount) {
  if (Platform.isAndroid) {
    final intent = AndroidIntent(
      action: 'android.intent.action.VIEW',
      data: Uri.encodeFull('upi://pay?pa=$upiId&pn=Receiver&am=$amount&cu=INR'),
      package: 'com.whatsapp',
    );

    intent.launch().catchError((e) {
      print('WhatsApp Pay खोलने में समस्या हुई: $e');
    });
  } else {
    print('यह सुविधा केवल Android पर उपलब्ध है।');
  }
}

//
