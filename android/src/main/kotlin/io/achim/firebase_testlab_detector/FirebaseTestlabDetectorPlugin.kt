package io.achim.firebase_testlab_detector

import android.content.ContentResolver
import android.provider.Settings
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FirebaseTestlabDetectorPlugin */
class FirebaseTestlabDetectorPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  private lateinit var contentResolver: ContentResolver

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    contentResolver = flutterPluginBinding.applicationContext.contentResolver
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "firebase_testlab_detector")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "isAppRunningInTestlab") {
      result.success(isAppRunningInTestlab())
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun isAppRunningInTestlab(): Boolean {
    return Settings.System.getString(contentResolver, "firebase.test.lab")?.equals("true") ?: false
  }
}
