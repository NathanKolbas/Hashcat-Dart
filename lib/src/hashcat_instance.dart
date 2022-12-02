// Ignore underscore vars and all caps since we want to copy the same names in
// Hashcat for consistency and easy Ctrl+C Ctrl+F Ctrl+V lookup
// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'dart:async';
import 'dart:ffi' as ffi;
import 'dart:isolate';

import 'package:ffi/ffi.dart' as pffi;

import '../hashcat.dart';

class _HashcatIsolateArgs {
  final String command;
  final String hashcatDir;
  final SendPort sendPort;

  _HashcatIsolateArgs(this.command, this.hashcatDir, this.sendPort);
}

class HashcatInstance {
  static void printCallback(String char) {
    print(char);
  }

  final Hashcat hashcat;

  HashcatInstance(this.hashcat);

  /// Execute a Hashcat command
  ///
  /// This will run on a separate core/thread using Dart [Isolate]s so it does not block the main thread
  Future<int> execute(String command, { void Function(String) callback = printCallback }) async {
    final String hashcatDir = await hashcat.hashcatDir();
    // Create a port to allow communication with the Isolate
    final ReceivePort port = ReceivePort();
    // Create the args needed to be passed
    final _HashcatIsolateArgs args = _HashcatIsolateArgs(command, hashcatDir, port.sendPort);

    Completer c1 = Completer();
    int result = -1;
    port.listen((message) {
      // Everything should be a String
      if (message is String) {
        callback(message);
      } else if (message is int) {
        // The last send should be an int which is the return value
        result = message;
        port.close();
      }
    }, onDone: () => c1.complete());
    final isolate = await Isolate.spawn<_HashcatIsolateArgs>(_hashcatMain, args);
    // This will wait until Hashcat is done
    await c1.future;
    // Close the thread
    isolate.kill(priority: Isolate.immediate);

    return result;
  }

  /// This is a static function that will run in an [Isolate] which is in a separate core/thread
  static int _hashcatMain(_HashcatIsolateArgs args) {
    final dl = ffi.DynamicLibrary.open('libhashcat.so');

    // Should be updated for each new Hashcat version
    final ffi.Pointer<pffi.Utf8> VERSION_TAG = '6.2.6'.toNativeUtf8();
    // This is created at compile time in Hashcat so it probably should be
    // turned into a const and each release updated?
    /// COMPTIME := $(shell date +%s)  i.e. seconds since epoch
    final int COMPTIME = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    final clArgs = CommandLineArgs(args.command);


    // Lookup symbols
    /// void event (const u32 id, hashcat_ctx_t *hashcat_ctx, const void *buf, const size_t len)
    final ffi.Pointer<ffi.NativeFunction<ffi.Void Function(u32, ffi.Pointer<hashcat_ctx_t>, ffi.NativeFunction<ffi.Void Function()>, size_t)>> event = dl.lookup<ffi.NativeFunction<ffi.Void Function(u32, ffi.Pointer<hashcat_ctx_t>, ffi.NativeFunction<ffi.Void Function()>, size_t)>>('event');
    final int Function(ffi.Pointer<time_t>) time = dl.lookup<ffi.NativeFunction<time_t Function(ffi.Pointer<time_t>)>>('time').asFunction();
    final int Function(ffi.Pointer<hashcat_ctx_t>, ffi.Pointer<ffi.NativeFunction<ffi.Void Function(u32, ffi.Pointer<hashcat_ctx_t>, ffi.NativeFunction<ffi.Void Function()>, size_t)>>) hashcat_init = dl.lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<hashcat_ctx_t>, ffi.Pointer<ffi.NativeFunction<ffi.Void Function(u32, ffi.Pointer<hashcat_ctx_t>, ffi.NativeFunction<ffi.Void Function()>, size_t)>>)>>('hashcat_init').asFunction();
    final int Function(ffi.Pointer<hashcat_ctx_t>) user_options_init = dl.lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<hashcat_ctx_t>)>>('user_options_init').asFunction();
    final int Function(ffi.Pointer<hashcat_ctx_t>) user_options_sanity = dl.lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<hashcat_ctx_t>)>>('user_options_sanity').asFunction();
    final int Function(ffi.Pointer<hashcat_ctx_t>, int, ffi.Pointer<ffi.Pointer<pffi.Utf8>>) user_options_getopt = dl.lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<hashcat_ctx_t>, ffi.Int, ffi.Pointer<ffi.Pointer<pffi.Utf8>>)>>('user_options_getopt').asFunction();
    final void Function(ffi.Pointer<hashcat_ctx_t>, ffi.Pointer<pffi.Utf8>) welcome_screen = dl.lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<hashcat_ctx_t>, ffi.Pointer<pffi.Utf8>)>>('welcome_screen').asFunction();
    final int Function(ffi.Pointer<hashcat_ctx_t>, ffi.Pointer<pffi.Utf8>, ffi.Pointer<pffi.Utf8>, int, ffi.Pointer<ffi.Pointer<pffi.Utf8>>, int) hashcat_session_init = dl.lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<hashcat_ctx_t>, ffi.Pointer<pffi.Utf8>, ffi.Pointer<pffi.Utf8>, ffi.Int, ffi.Pointer<ffi.Pointer<pffi.Utf8>>, ffi.Int)>>('hashcat_session_init').asFunction();
    final void Function(ffi.Pointer<hashcat_ctx_t>) hashcat_destroy = dl.lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<hashcat_ctx_t>)>>('hashcat_destroy').asFunction();
    final void Function(ffi.Pointer<hashcat_ctx_t>) user_options_destroy = dl.lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<hashcat_ctx_t>)>>('user_options_destroy').asFunction();
    final void Function(ffi.Pointer<hashcat_ctx_t>) usage_big_print = dl.lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<hashcat_ctx_t>)>>('usage_big_print').asFunction();
    final void Function(ffi.Pointer<hashcat_ctx_t>) hash_info = dl.lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<hashcat_ctx_t>)>>('hash_info').asFunction();
    final void Function(ffi.Pointer<hashcat_ctx_t>) backend_info = dl.lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<hashcat_ctx_t>)>>('backend_info').asFunction();
    final void Function(ffi.Pointer<hashcat_ctx_t>) backend_info_compact = dl.lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<hashcat_ctx_t>)>>('backend_info_compact').asFunction();
    final void Function(ffi.Pointer<hashcat_ctx_t>) user_options_info = dl.lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<hashcat_ctx_t>)>>('user_options_info').asFunction();
    final int Function(ffi.Pointer<hashcat_ctx_t>) hashcat_session_execute = dl.lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<hashcat_ctx_t>)>>('hashcat_session_execute').asFunction();
    final int Function(ffi.Pointer<hashcat_ctx_t>) hashcat_session_destroy = dl.lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<hashcat_ctx_t>)>>('hashcat_session_destroy').asFunction();
    final void Function(ffi.Pointer<hashcat_ctx_t>, int, int) goodbye_screen = dl.lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<hashcat_ctx_t>, time_t, time_t)>>('goodbye_screen').asFunction();

    // Check this gist for setting up native callback for dart:
    // https://gist.github.com/espresso3389/be5674ab4e3154f0b7c43715dcef3d8d
    // It needs to be done this way so that any thread in C can call back
    // Dart_InitializeApiDL defined in Dart SDK (dart_api_dl.c)
    final int Function(ffi.Pointer<ffi.Void>) Dart_InitializeApiDL = dl.lookup<ffi.NativeFunction<ffi.IntPtr Function(ffi.Pointer<ffi.Void>)>>("Dart_InitializeApiDL").asFunction();
    final void Function(int) init_native_callback = dl.lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int64)>>('init_native_callback').asFunction();
    final ffi.Pointer<hashcat_ctx_t> Function() build_hashcat_ctx = dl.lookup<ffi.NativeFunction<ffi.Pointer<hashcat_ctx_t> Function()>>('build_hashcat_ctx').asFunction();
    final void Function(ffi.Pointer<hashcat_ctx_t>) free_hashcat_ctx = dl.lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<hashcat_ctx_t>)>>('free_hashcat_ctx').asFunction();


    // Initialize the native callback
    if (Dart_InitializeApiDL(ffi.NativeApi.initializeApiDLData) != 0) {
      throw "Failed to initialize Dart API";
    }
    init_native_callback(args.sendPort.nativePort);


    // The text in green, like below, is the native code and comments from Hashcat
    /// From Hashcat

    /// this increases the size on windows dos boxes

    /// setup_console ();

    /// const time_t proc_start = time (NULL);
    int proc_start = time(ffi.nullptr);

    /// hashcat main context

    /// hashcat_ctx_t *hashcat_ctx = (hashcat_ctx_t *) hcmalloc (sizeof (hashcat_ctx_t));
    ffi.Pointer<hashcat_ctx_t> hashcat_ctx = build_hashcat_ctx();

    /// if (hashcat_init (hashcat_ctx, event) == -1)
    if (hashcat_init(hashcat_ctx, event) == -1) {
      /// hcfree (hashcat_ctx);
      free_hashcat_ctx(hashcat_ctx);

      clArgs.free();
      pffi.calloc.free(VERSION_TAG);

      /// return -1;
      args.sendPort.send(-1);
      return -1;
    }

    /// install and shared folder need to be set to recognize "make install" use

    /// const char *install_folder = NULL;
    /// const char *shared_folder  = NULL;
    ///
    /// #if defined (INSTALL_FOLDER)
    /// install_folder = INSTALL_FOLDER;
    /// #endif
    ///
    /// #if defined (SHARED_FOLDER)
    /// shared_folder = SHARED_FOLDER;
    /// #endif

    final String hashcatDir = args.hashcatDir;
    ffi.Pointer<pffi.Utf8> install_folder = hashcatDir.toNativeUtf8();
    ffi.Pointer<pffi.Utf8> shared_folder = hashcatDir.toNativeUtf8();

    /// initialize the user options with some defaults (you can override them later)

    /// if (user_options_init (hashcat_ctx) == -1)
    if (user_options_init(hashcat_ctx) == -1) {
      /// hashcat_destroy (hashcat_ctx);
      hashcat_destroy(hashcat_ctx);

      /// hcfree (hashcat_ctx);
      free_hashcat_ctx(hashcat_ctx);

      clArgs.free();
      pffi.calloc.free(VERSION_TAG);
      pffi.calloc.free(install_folder);
      pffi.calloc.free(shared_folder);

      /// return -1;
      args.sendPort.send(-1);
      return -1;
    }

    /// parse commandline parameters and check them

    /// if (user_options_getopt (hashcat_ctx, argc, argv) == -1)
    if (user_options_getopt(hashcat_ctx, clArgs.argc, clArgs.argv) == -1) {
      /// user_options_destroy (hashcat_ctx);
      user_options_destroy(hashcat_ctx);

      /// hashcat_destroy (hashcat_ctx);
      hashcat_destroy(hashcat_ctx);

      /// hcfree (hashcat_ctx);
      free_hashcat_ctx(hashcat_ctx);

      clArgs.free();
      pffi.calloc.free(VERSION_TAG);
      pffi.calloc.free(install_folder);
      pffi.calloc.free(shared_folder);

      /// return -1;
      args.sendPort.send(-1);
      return -1;
    }

    /// if (user_options_sanity (hashcat_ctx) == -1)
    if (user_options_sanity(hashcat_ctx) == -1) {
      /// user_options_destroy (hashcat_ctx);
      user_options_destroy(hashcat_ctx);

      /// hashcat_destroy (hashcat_ctx);
      hashcat_destroy(hashcat_ctx);

      /// hcfree (hashcat_ctx);
      free_hashcat_ctx(hashcat_ctx);

      clArgs.free();
      pffi.calloc.free(VERSION_TAG);
      pffi.calloc.free(install_folder);
      pffi.calloc.free(shared_folder);

      /// return -1;
      args.sendPort.send(-1);
      return -1;
    }

    /// some early exits

    ffi.Pointer<user_options_t> user_options = hashcat_ctx.ref.user_options;

    /// #ifdef WITH_BRAIN
    /// if (user_options->brain_server == true)
    /// {
    ///   const int rc = brain_server (user_options->brain_host, user_options->brain_port, user_options->brain_password, user_options->brain_session_whitelist, user_options->brain_server_timer);
    ///
    ///   hcfree (hashcat_ctx);
    ///
    ///   return rc;
    /// }
    /// #endif

    /// if (user_options->version == true)
    if (user_options.ref.version == true) {
      /// printf ("%s\n", VERSION_TAG);
      args.sendPort.send(VERSION_TAG);

      /// user_options_destroy (hashcat_ctx);
      user_options_destroy(hashcat_ctx);

      /// hashcat_destroy (hashcat_ctx);
      hashcat_destroy(hashcat_ctx);

      /// hcfree (hashcat_ctx);
      free_hashcat_ctx(hashcat_ctx);

      clArgs.free();
      pffi.calloc.free(VERSION_TAG);
      pffi.calloc.free(install_folder);
      pffi.calloc.free(shared_folder);

      /// return 0;
      args.sendPort.send(0);
      return 0;
    }

    /// init a hashcat session; this initializes backend devices, hwmon, etc

    /// welcome_screen (hashcat_ctx, VERSION_TAG);
    welcome_screen(hashcat_ctx, VERSION_TAG);

    int rc_final = -1;

    /// if (hashcat_session_init (hashcat_ctx, install_folder, shared_folder, argc, argv, COMPTIME) == 0)
    if (hashcat_session_init(hashcat_ctx, install_folder, shared_folder, clArgs.argc, clArgs.argv, COMPTIME) == 0) {
      /// if (user_options->usage == true)
      if (user_options.ref.usage == true) {
        /// usage_big_print (hashcat_ctx);
        usage_big_print(hashcat_ctx);

        /// rc_final = 0;
        rc_final = 0;
      }
      /// else if (user_options->hash_info == true)
      else if (user_options.ref.hash_info == true) {
        /// hash_info (hashcat_ctx);
        hash_info(hashcat_ctx);

        /// rc_final = 0;
        rc_final = 0;
      }
      /// else if (user_options->backend_info > 0)
      else if (user_options.ref.backend_info > 0) {
        /// if this is just backend_info, no need to execute some real cracking session

        /// backend_info (hashcat_ctx);
        backend_info(hashcat_ctx);

        /// rc_final = 0;
        rc_final = 0;
      } else {
        /// now execute hashcat

        /// backend_info_compact (hashcat_ctx);
        backend_info_compact(hashcat_ctx);

        /// user_options_info (hashcat_ctx);
        user_options_info(hashcat_ctx);

        /// rc_final = hashcat_session_execute (hashcat_ctx);
        rc_final = hashcat_session_execute(hashcat_ctx);
      }
    }

    /// finish the hashcat session, this shuts down backend devices, hwmon, etc

    /// hashcat_session_destroy (hashcat_ctx);
    hashcat_session_destroy(hashcat_ctx);

    /// finished with hashcat, clean up

    /// const time_t proc_stop = time (NULL);
    int proc_stop = time(ffi.nullptr);

    /// goodbye_screen (hashcat_ctx, proc_start, proc_stop);
    goodbye_screen(hashcat_ctx, proc_start, proc_stop);

    /// hashcat_destroy (hashcat_ctx);
    hashcat_destroy(hashcat_ctx);

    /// hcfree (hashcat_ctx);
    free_hashcat_ctx(hashcat_ctx);

    clArgs.free();
    pffi.calloc.free(VERSION_TAG);
    pffi.calloc.free(install_folder);
    pffi.calloc.free(shared_folder);

    /// return rc_final;
    args.sendPort.send(rc_final);
    return rc_final;
  }
}
