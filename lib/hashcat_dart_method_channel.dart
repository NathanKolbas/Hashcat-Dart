import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'hashcat_dart_platform_interface.dart';

/// An implementation of [HashcatDartPlatform] that uses method channels.
class MethodChannelHashcatDart extends HashcatDartPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('hashcat_dart');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
