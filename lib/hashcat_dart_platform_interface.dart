import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'hashcat_dart_method_channel.dart';

abstract class HashcatDartPlatform extends PlatformInterface {
  /// Constructs a HashcatDartPlatform.
  HashcatDartPlatform() : super(token: _token);

  static final Object _token = Object();

  static HashcatDartPlatform _instance = MethodChannelHashcatDart();

  /// The default instance of [HashcatDartPlatform] to use.
  ///
  /// Defaults to [MethodChannelHashcatDart].
  static HashcatDartPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [HashcatDartPlatform] when
  /// they register themselves.
  static set instance(HashcatDartPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getDataDir() {
    throw UnimplementedError('dataDir() has not been implemented.');
  }
}
