package io.achim.firebase_testlab_detector

import android.content.ContentResolver
import android.content.Context
import android.provider.Settings
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlin.test.Test
import org.mockito.Mockito

/*
 * This demonstrates a simple unit test of the Kotlin portion of this plugin's implementation.
 *
 * Once you have built the plugin's example app, you can run these tests from the command
 * line by running `./gradlew testDebugUnitTest` in the `example/android/` directory, or
 * you can run them directly from IDEs that support JUnit such as Android Studio.
 */

internal class FirebaseTestlabDetectorPluginTest {
  @Test
  fun onMethodCall_isAppRunningInTestlab_returnsExpectedValue() {
    val contentResolver = Mockito.mock(ContentResolver::class.java)
    val context = Mockito.mock(Context::class.java)
    val binaryMessenger = Mockito.mock(BinaryMessenger::class.java)
    val binding = Mockito.mock(FlutterPlugin.FlutterPluginBinding::class.java)
    Mockito.`when`(binding.applicationContext).thenReturn(context)
    Mockito.`when`(binding.binaryMessenger).thenReturn(binaryMessenger)
    Mockito.`when`(context.contentResolver).thenReturn(contentResolver)

    Mockito.mockStatic(Settings.System::class.java).use { settings ->
      settings.`when`<String?> {
        Settings.System.getString(contentResolver, "firebase.test.lab")
      }.thenReturn("true")

      val plugin = FirebaseTestlabDetectorPlugin()
      val call = MethodCall("isAppRunningInTestlab", null)
      val mockResult: MethodChannel.Result = Mockito.mock(MethodChannel.Result::class.java)
      plugin.onAttachedToEngine(binding)
      plugin.onMethodCall(call, mockResult)
      plugin.onDetachedFromEngine(binding)

      Mockito.verify(mockResult).success(true)
    }
  }
}
