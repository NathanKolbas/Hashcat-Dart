import 'dart:convert';
import 'dart:ffi' as ffi;
import 'dart:io';

import 'package:hashcat_dart/src/hashcat_instance.dart';
import 'package:path/path.dart' as path;

import 'exceptions.dart';
import '../hashcat_dart_platform_interface.dart';

class Hashcat {
  static const hashcatVersion = '6.2.6';
  static const pluginVersion = '0.0.1';
  static const _configFilename = 'hashcat_dart_config.json';

  late final ffi.DynamicLibrary hashcatLibrary;
  late final HashcatInstance instance;

  Hashcat() {
    instance = HashcatInstance(this);
  }

  /// **Must run first before using**
  ///
  /// Used to initialize Hashcat. This includes finding the shared library,
  /// setting up hashcat directory, etc.
  ///
  /// [forceDirRefresh]defaults to false but if true will copy the files regardless if they
  /// have been copied before. Note, it will not updated the config data. This is purely
  /// an update.
  ///
  /// Might throw the following errors from the used function: [HashcatPlatformNotSupported],
  /// [HashcatLibLoadFailed].
  /// Exceptions are default behavior and should be caught and handled with accordingly.
  init({ forceDirRefresh = false }) {
    // Load the Shared Library
    openDL();
    // Setup the Hashcat directory
    setupHashcatDir(refresh: forceDirRefresh);
  }

  /// Loads Hashcat's Shared Library
  ///
  /// Throws a [HashcatPlatformNotSupported] if the platform is not currently supported
  /// and [HashcatLibLoadFailed] if there was an error loading the Hashcat library.
  openDL() {
    try {
      hashcatLibrary = ffi.DynamicLibrary.open('libhashcat.so');

      if (Platform.isMacOS || Platform.isIOS) {
        // libraryPath = path.join(Directory.current.path, 'hello_library', 'libhello.dylib');
        throw HashcatPlatformNotSupported('Platform not currently supported');
      }

      if (Platform.isWindows) {
        // libraryPath = path.join(Directory.current.path, 'hello_library', 'Debug', 'hello.dll');
        throw HashcatPlatformNotSupported('Platform not currently supported');
      }
    } on HashcatPlatformNotSupported catch (e) {
      throw HashcatPlatformNotSupported(e.toString());
    } on ArgumentError catch (e) {
      throw HashcatLibLoadFailed(e.toString());
    }
  }

  /// Sets up Hashcat's working directory, modules, etc.
  ///
  /// In the future it would be nice if this directory could be specified.
  /// Should be as simple as passing null or a path to the directory to use.
  /// Null being the default path.
  ///
  /// [refresh] defaults to false but if true will copy the files regardless if they
  /// have been copied before. Note, it will not updated the config data. This is purely
  /// an update.
  setupHashcatDir({ refresh = false }) async {
    if (!refresh) {
      // This is where you would change it out for a custom dir
      final dataDir = await HashcatDartPlatform.instance.getDataDir();
      if (dataDir == null) throw HashcatDirectoryError('Unable to get data directory');
      final hashcatDir = path.join(dataDir, 'hashcat');
      // Open the config file
      final configFile = File(path.join(hashcatDir, _configFilename));
      if (!configFile.existsSync()) configFile.createSync(recursive: true);
      final jsonData = configFile.readAsStringSync();
      final config = jsonData.isEmpty ? {} : jsonDecode(jsonData);

      // Check if the directory should be updated
      // All I can think of at the moment is the version of the plugin and the version of Hashcat.
      // Ideally, this should be updated accordingly by the person using the plugin.
      if ((config['pluginVersion'] ?? '') == pluginVersion && (config['hashcatVersion'] ?? '') == hashcatVersion) {
        return;
      }

      config['pluginVersion'] = pluginVersion;
      config['hashcatVersion'] = hashcatVersion;

      // Save the updated config
      final updatedConfig = jsonEncode(config);
      configFile.writeAsStringSync(updatedConfig);
    }

    await HashcatDartPlatform.instance.setupHashcatFiles();
  }

  /// Native calls
  Future<String> hashcatDir() async {
    final dataDir = await HashcatDartPlatform.instance.getDataDir() ?? '';
    return path.join(dataDir, 'hashcat');
  }
}
