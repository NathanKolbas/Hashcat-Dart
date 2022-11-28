package com.hashcat.dart.hashcat_dart

import android.content.Context
import android.content.res.AssetManager
import android.os.Build
import androidx.annotation.RequiresApi

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.File
import java.io.File.separator
import java.io.FileOutputStream
import java.io.IOException
import java.io.OutputStream

fun AssetManager.copyAssetFolder(srcName: String, dstName: String): Boolean {
  return try {
    var result: Boolean
    val fileList = this.list(srcName) ?: return false
    if (fileList.isEmpty()) {
      result = copyAssetFile(srcName, dstName)
    } else {
      val file = File(dstName)
      result = file.mkdirs()
      for (filename in fileList) {
        result = result and copyAssetFolder(
          srcName + separator.toString() + filename,
          dstName + separator.toString() + filename
        )
      }
    }
    result
  } catch (e: IOException) {
    e.printStackTrace()
    false
  }
}

fun AssetManager.copyAssetFile(srcName: String, dstName: String): Boolean {
  return try {
    val inStream = this.open(srcName)
    val outFile = File(dstName)
    val out: OutputStream = FileOutputStream(outFile)
    val buffer = ByteArray(1024)
    var read: Int
    while (inStream.read(buffer).also { read = it } != -1) {
      out.write(buffer, 0, read)
    }
    inStream.close()
    out.close()
    true
  } catch (e: IOException) {
    e.printStackTrace()
    false
  }
}

/** HashcatDartPlugin */
class HashcatDartPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context: Context

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "hashcat_dart")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  private val dataDir: String
    get() = context.dataDir.absolutePath

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
        "getDataDir" -> {
          result.success(dataDir)
        }
        "setupHashcatFiles" -> {
          // Since there are multiple ABIs for android we will need to store their compiled files
          // separately and then copy the correct ones. There has got to be a better way so the bundled
          // APK only includes that devices ABI but this works for now.
          val arch = System.getProperty("os.arch")

          // Copy the files that are specific to the architecture
          val copySuccess = context.assets.copyAssetFolder("hashcat$separator$arch", "$dataDir${separator}hashcat")

          // Copy the files that are shared across architectures
          val copySharedSuccess = context.assets.copyAssetFolder("hashcat${separator}shared", "$dataDir${separator}hashcat")

          result.success(copySuccess && copySharedSuccess)
        }
        else -> {
          result.notImplemented()
        }
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
