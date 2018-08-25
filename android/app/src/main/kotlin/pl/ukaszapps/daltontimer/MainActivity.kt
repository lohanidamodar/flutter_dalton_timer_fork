package pl.ukaszapps.daltontimer

import android.os.Bundle
import android.view.WindowManager

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity(): FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

    // awake screen plugin
    io.flutter.plugin.common.MethodChannel(flutterView, CHANNEL_NAME).setMethodCallHandler { methodCall, result ->
      when (methodCall.method) {
        METHOD_SET_AWAKE -> {
          window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
          result.success(null)
        }
        METHOD_CLEAR_AWAKE -> {
          window.clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
          result.success(null)
        }
        else -> {
          result.notImplemented()
        }
      }
    }
  }

  companion object {
    const val CHANNEL_NAME = "pl.ukaszapps/screenwakelock"
    const val METHOD_SET_AWAKE = "setAwake"
    const val METHOD_CLEAR_AWAKE = "clearAwake"
  }
}
