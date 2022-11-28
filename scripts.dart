import 'dart:io';

import 'package:args/args.dart';
import 'package:io/io.dart';
import 'package:path/path.dart' as path;

const Map<String, String> androidAarchMap = {
  'arm64': 'aarch64-linux-android',
  'x86_64': 'x86_64-linux-android',
  'armeabi': 'armv7a-linux-androideabi',
};

const Map<String, String> androidJniLibsAarchMap = {
  'arm64': 'arm64-v8a',
  'x86_64': 'x86_64',
  'armeabi': 'armeabi-v7a',
};

const Map<String, String> androidAssetsAarchMap = {
  'arm64': 'aarch64',
  'x86_64': 'x86_64',
  'armeabi': 'armv7a',
};

late ArgResults argResults;
final cwd = path.context.current;
final hashcatMobileDir = path.join(cwd, 'hashcat-mobile');

runCommand(String executable, List<String> arguments, { String? workingDirectory, Map<String, String>? environment }) async {
  final p = await Process.start(executable, arguments, workingDirectory: workingDirectory, environment: environment, includeParentEnvironment: true);
  await stdout.addStream(p.stdout);
  if ((await p.exitCode) != 0) throw Exception('Run failed');
}

Future<int> compile() async {
  final platforms = argResults['platform'] as List<String>;
  // If nothing is specified then default to their platform
  if (platforms.isEmpty) platforms.add(Platform.operatingSystem);

  for (final platform in platforms) {
    switch (platform) {
      case 'android': {
        await compileAndroid();
        break;
      }
      case 'ios': throw Exception('iOS is not supported');
      case 'linux': throw Exception('Linux is not supported');
      case 'macos': throw Exception('MacOS is not supported');
      case 'windows': throw Exception('Windows is not supported');
    }
  }

  return 0;
}

compileAndroid() async {
  stdout.writeln('Building Android...');

  final aarch = argResults['aarch'] as List<String>;
  for (final arch in aarch) {
    stdout.writeln('Building $arch...');

    // First clean
    await runCommand('make', ['clean'], workingDirectory: hashcatMobileDir);

    // Now build
    await runCommand('make', [], workingDirectory: hashcatMobileDir, environment: {
      'BUILD_ANDROID': '1',
      'ANDROID_NDK_PATH': argResults['NDK_PATH'],
      'ANDROID_TARGET': androidAarchMap[arch] ?? ''
    });

    await copyFiles('android');
  }

  stdout.writeln('Done building Android!');
}

copyFiles(String platform, { androidArch='' }) {
  if (argResults['no-copy']) return;

  stdout.writeln('Copying files...');

  // Find Hashcat lib since it has version number and it could be dylib, so, or dll
  final hashcatLib = File(Directory(hashcatMobileDir).listSync().where((element) => element.path.contains('libhashcat')).first.path);
  final hashcatLibExtension = hashcatLib.path.split('/').last.split('.')[1];
  final hashcatOpenCL = Directory(path.join(hashcatMobileDir, 'OpenCL'));
  final hashcatModules = Directory(path.join(hashcatMobileDir, 'modules'));

  switch (platform) {
    case 'android': {
      // Since there are multiple ABIs for android we will need to store their compiled files
      // separately and then copy the correct ones. There has got to be a better way so the bundled
      // APK only includes that devices ABI but this works for now.
      final assetArch = androidAssetsAarchMap[androidArch] ?? '';
      final libDir = Directory(path.join(cwd, 'android', 'src', 'main', 'jniLibs', assetArch));
      final assetDir = Directory(path.join(cwd, 'android', 'src', 'main', 'assets', 'hashcat', assetArch));

      // This directory is used for files that are do not depend on the architecture
      final sharedDir = Directory(path.join(cwd, 'android', 'src', 'main', 'assets', 'hashcat', 'shared'));

      stdout.writeln('Creating directories');
      libDir.createSync();
      sharedDir.createSync();
      assetDir.createSync();

      stdout.writeln('Copying libhashcat.so');
      hashcatLib.copySync(path.join(libDir.path, "libhashcat.$hashcatLibExtension"));

      // OpenCL folder does NOT depend on the architecture
      stdout.writeln('Copying OpenCL directory');
      copyPathSync(hashcatOpenCL.path, path.join(sharedDir.path, 'OpenCL'));

      stdout.writeln('Copying modules directory');
      copyPathSync(hashcatModules.path, path.join(assetDir.path, 'modules'));
      break;
    }
    case 'ios': throw Exception('iOS is not supported');
    case 'linux': throw Exception('Linux is not supported');
    case 'macos': throw Exception('MacOS is not supported');
    case 'windows': throw Exception('Windows is not supported');
  }

  stdout.writeln('Done copying files!');
}

main(List<String> args) async {
  final parser = ArgParser()
    ..addFlag('help', negatable: false, help: 'Prints information and help about args')
    ..addFlag('compile', abbr: 'c', negatable: false, help: 'Compiles Hashcat and copies the folders to the correct locations')
    ..addFlag('no-copy', negatable: false, help: 'Do not copy built files and folders to the correct locations')
    ..addOption('NDK_PATH', help: 'Path to your NDK used for Android compile. Should be like: `/Users/name/Library/Android/sdk/ndk/21.4.707.5529/llvm/prebuilt/darwin-x86_64`')
    ..addMultiOption('platform', allowed: ['android'],
        help: 'Specify which platform to build for',
        allowedHelp: {
          'android': 'build for the android platform'
        })
    ..addMultiOption('aarch', allowed: ['arm64', 'x86_64', 'armeabi'], defaultsTo: ['arm64'],
        help: 'Specify which architecture to build for on Android',
        allowedHelp: {
          'arm64': 'Build the arm64-v8a android architecture'
        });

  argResults = parser.parse(args);

  // Print help
  if (argResults['help']) stdout.write(parser.usage);

  if (argResults['compile']) await compile();

  return 0;
}
