package io.achim.firebase_testlab_detector

import android.content.ContentResolver
import android.provider.Settings
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
    val plugin = FirebaseTestlabDetectorPlugin()
    val contentResolver = Mockito.mock(ContentResolver::class.java)
    val contentResolverField = plugin.javaClass.getDeclaredField("contentResolver")
    contentResolverField.isAccessible = true
    contentResolverField.set(plugin, contentResolver)

    val call = MethodCall("isAppRunningInTestlab", null)
    val mockResult: MethodChannel.Result = Mockito.mock(MethodChannel.Result::class.java)

    Mockito.mockStatic(Settings.System::class.java).use { settings ->
      settings.`when`<String?> {
        Settings.System.getString(contentResolver, "firebase.test.lab")
      }.thenReturn("true")

      plugin.onMethodCall(call, mockResult)

      Mockito.verify(mockResult).success(true)
    }
  }
}
