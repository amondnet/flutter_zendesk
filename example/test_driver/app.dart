import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_zendesk_example/main.dart' as app;

void main() {
  // This line enables the extension
  enableFlutterDriverExtension();

  // Call the `main()` function of your app or call `runApp` with any widget you
  // are interested in testing.
  app.main([
    'd4ffe290c8c9f234c52cd80b525cce1e747a2ccf32833f23',
    'mobile_sdk_client_3e6256e77123f7c6b125',
    'https://chatbotpf.zendesk.com'
  ]);
}
