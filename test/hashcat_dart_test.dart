import 'package:flutter_test/flutter_test.dart';
import 'package:hashcat_dart/hashcat_dart.dart';
import 'package:hashcat_dart/hashcat_dart_platform_interface.dart';
import 'package:hashcat_dart/hashcat_dart_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockHashcatDartPlatform
    with MockPlatformInterfaceMixin
    implements HashcatDartPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final HashcatDartPlatform initialPlatform = HashcatDartPlatform.instance;

  test('$MethodChannelHashcatDart is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelHashcatDart>());
  });

  test('getPlatformVersion', () async {
    HashcatDart hashcatDartPlugin = HashcatDart();
    MockHashcatDartPlatform fakePlatform = MockHashcatDartPlatform();
    HashcatDartPlatform.instance = fakePlatform;

    expect(await hashcatDartPlugin.getPlatformVersion(), '42');
  });
}
