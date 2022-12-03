import 'dart:ffi';

import 'package:ffi/ffi.dart';

/// Used to take a String and convert it into Command-Line Arguments.
/// This is useful for calling C's main function that takes the length
/// of the arguments and a pointer that points to a list of "Strings".
///
/// **IMPORTANT**: Remember to call [free] to release the memory that has
/// been allocated for the pointers when done.
class CommandLineArgs {
  final RegExp argsSplit = RegExp(r'([-a-zA-Z0-9]+)|(".*?[^\\]")|("")|([/._\-a-zA-Z0-9]+)');
  late final List<Pointer<Utf8>> _args;
  late final Pointer<Pointer<Utf8>> argv;
  late final int argc;

  CommandLineArgs(String argString) {
    final argsList = argsSplit.allMatches(argString);
    argc = argsList.length;
    _args = argsList.map((s) => s.group(0)!.toNativeUtf8().cast<Utf8>()).toList();
    argv = malloc.allocate(sizeOf<Pointer<Utf8>>() * argc);
    for (int i = 0; i < argc; i++) {
      argv[i] = _args[i];
    }
  }

  free() {
    malloc.free(argv);
    _args.forEach(malloc.free);
  }
}
