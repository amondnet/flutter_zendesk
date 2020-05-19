package net.amond.flutter_zendesk_example

import android.os.Bundle
import dev.flutter.plugins.e2e.E2EPlugin
import io.flutter.app.FlutterActivity
import net.amond.flutter_zendesk.FlutterZendeskPlugin

class EmbeddingV1Activity : FlutterActivity() {
  @Override
  override fun onCreate(savedInstanceState: Bundle) {
    super.onCreate(savedInstanceState);
    E2EPlugin.registerWith(registrarFor("dev.flutter.plugins.e2e.E2EPlugin"))
    FlutterZendeskPlugin.registerWith(
        registrarFor("net.amond.flutter_zendesk.FlutterZendeskPlugin"))
  }
}
