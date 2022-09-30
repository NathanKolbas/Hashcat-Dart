import 'dart:ffi';

import 'package:ffi/ffi.dart';

import 'test_hashcat_plugin_platform_interface.dart';
import 'dart:io' show Directory, FileSystemEntity;

// FFI signature of the hello_world C function
typedef HelloWorldFunc = Void Function();
// Dart type definition for calling the C foreign function
typedef HelloWorld = void Function();

// FFI signature of the native_add C function
typedef NativeAddFunc = Int32 Function(Int32 x, Int32 y);
// Dart type definition for calling the C foreign function
typedef NativeAdd = int Function(int x, int y);

// FFI signature of the native_add C function
typedef NativeSubFunc = Int32 Function(Int32 x, Int32 y);
// Dart type definition for calling the C foreign function
typedef NativeSub = int Function(int x, int y);

class TestHashcatPlugin {
  hello() {
    final DynamicLibrary nativeAddLib = DynamicLibrary.open('libhello.so');
    final HelloWorld hello = nativeAddLib
        .lookup<NativeFunction<HelloWorldFunc>>('hello_world')
        .asFunction();
    hello();
  }

  int add(int x, int y) {
    final DynamicLibrary nativeAddLib = DynamicLibrary.open('libadd.so');
    final NativeAdd hello = nativeAddLib
        .lookup<NativeFunction<NativeAddFunc>>('add')
        .asFunction();
    return hello(x, y);
  }

  int sub(int x, int y) {
    final DynamicLibrary nativeSubLib = DynamicLibrary.open('libadd.so');
    final NativeSub sub = nativeSubLib
        .lookup<NativeFunction<NativeSubFunc>>('sub')
        .asFunction();
    return sub(x, y);
  }

  test() async {
    final DynamicLibrary hashcatLib = DynamicLibrary.open('libhashcat.so');

    final int Function() setup_console = hashcatLib
        .lookup<NativeFunction<Int32 Function()>>('setup_console')
        .asFunction();
    print(setup_console());
  }

  Future<String?> getPlatformVersion() {
    return TestHashcatPluginPlatform.instance.getPlatformVersion();
  }
}
