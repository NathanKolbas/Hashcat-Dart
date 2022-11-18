
import 'hashcat_dart_platform_interface.dart';

class HashcatDart {
  Future<String?> getPlatformVersion() {
    return HashcatDartPlatform.instance.getPlatformVersion();
  }
}
