package com.guoka.copy_large_file

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.util.PathUtils
import java.io.File
import java.io.InputStream

/** CopyLargeFilePlugin */
class CopyLargeFilePlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  private lateinit var flutterPluginBinding: FlutterPlugin.FlutterPluginBinding

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.guoka/copy_large_file")
    channel.setMethodCallHandler(this)
    this.flutterPluginBinding = flutterPluginBinding
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if(call.method == "copyLargeFile") {
      val args = call.arguments as Map<String, Any>
      val fileName = args["fileName"] as String?
      if (fileName != null) {
        result.success(copyLargeFileIfNeeded(fileName))
      } else {
        result.success("Android could not extract flutter arguments in method: (copyLargeFile)")
      }
    } else {
      result.notImplemented()
    }
  }

  private fun copyLargeFileIfNeeded(fileName: String): String {
    val assetStream: InputStream = flutterPluginBinding.applicationContext.assets.open(fileName)
    val appliationDocumentsFolderPath: String = PathUtils.getDataDirectory(flutterPluginBinding.applicationContext)
    val outputFilePath: String = appliationDocumentsFolderPath + "/" + fileName

    if (!File(outputFilePath).exists()) {
      File(outputFilePath).copyInputStreamToFile(assetStream)
    }
    return outputFilePath
  }

  private fun File.copyInputStreamToFile(inputStream: InputStream) {
    inputStream.use { input ->
      this.outputStream().use { fileOut ->
        input.copyTo(fileOut)
      }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
