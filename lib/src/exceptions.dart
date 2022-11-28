class HashcatPlatformNotSupported implements Exception {
  String message;

  HashcatPlatformNotSupported(this.message);

  @override
  String toString() {
    String result = 'HashcatPlatformNotSupported';
    return '$result: $message';
  }
}

class HashcatLibLoadFailed implements Exception {
  String message;

  HashcatLibLoadFailed(this.message);

  @override
  String toString() {
    String result = 'HashcatLibLoadFailed';
    return '$result: $message';
  }
}

class HashcatDirectoryError implements Exception {
  String message;

  HashcatDirectoryError(this.message);

  @override
  String toString() {
    String result = 'HashcatLibLoadFailed';
    return '$result: $message';
  }
}
