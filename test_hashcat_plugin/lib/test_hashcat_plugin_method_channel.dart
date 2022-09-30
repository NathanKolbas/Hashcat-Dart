import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'test_hashcat_plugin_platform_interface.dart';

/// An implementation of [TestHashcatPluginPlatform] that uses method channels.
class MethodChannelTestHashcatPlugin extends TestHashcatPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('test_hashcat_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
