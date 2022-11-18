import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hashcat_dart/hashcat_dart_method_channel.dart';

void main() {
  MethodChannelHashcatDart platform = MethodChannelHashcatDart();
  const MethodChannel channel = MethodChannel('hashcat_dart');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
