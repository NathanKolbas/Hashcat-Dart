import 'package:flutter_test/flutter_test.dart';
import 'package:test_hashcat_plugin/test_hashcat_plugin.dart';
import 'package:test_hashcat_plugin/test_hashcat_plugin_platform_interface.dart';
import 'package:test_hashcat_plugin/test_hashcat_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTestHashcatPluginPlatform
    with MockPlatformInterfaceMixin
    implements TestHashcatPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final TestHashcatPluginPlatform initialPlatform = TestHashcatPluginPlatform.instance;

  test('$MethodChannelTestHashcatPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTestHashcatPlugin>());
  });

  test('getPlatformVersion', () async {
    TestHashcatPlugin testHashcatPlugin = TestHashcatPlugin();
    MockTestHashcatPluginPlatform fakePlatform = MockTestHashcatPluginPlatform();
    TestHashcatPluginPlatform.instance = fakePlatform;

    expect(await testHashcatPlugin.getPlatformVersion(), '42');
  });
}
