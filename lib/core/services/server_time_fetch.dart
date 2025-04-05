import 'package:cloud_functions/cloud_functions.dart';

Future<int> fetchServerTimeIST() async {
  try {
    final HttpsCallable callable =
    FirebaseFunctions.instance.httpsCallable('getServerTime');

    final response = await callable.call();
    final serverTime = response.data['serverTime'];
    print('Server Time from Firebase: $serverTime');

    // Convert serverTime string to DateTime (UTC)
    final currentTimeUtc = DateTime.parse(serverTime.toString());

    // Convert UTC to IST (UTC + 5:30)
    final currentTimeIST = currentTimeUtc.add(const Duration(hours: 5, minutes: 30));

    // Get timestamp in milliseconds
    final timestampIST = currentTimeIST.millisecondsSinceEpoch;
    print('Timestamp (IST): $timestampIST');

    return timestampIST;
  } catch (e) {
    print('Error: ${e.toString()}');
    return 0; // Return 0 in case of an error
  }
}


