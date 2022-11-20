# hashcat_dart

A new Flutter plugin project.

## Getting Started

```
git submodule init
git submodule update
```

For ffigen:
Edit hashcat.h (located at: hashcat-mobile/include/hashcat.h) and add this before anything:
```
// Order metters, ffigen will go from top to bottom and these types are needed before the others

// u32 and u64 are used for kernals since they are gaurenteed to be excatly unsigned 64 bits and 32.
// ffigen doesn't pickup the types properly so they are defnied here.
typedef unsigned int u32;
typedef unsigned long u64;

// Needed by ffigen to create the hashcat_ctx_t struct before used below
#include "types.h"
// Needed to recreate main in dart
#include "main_event.h"
// Needed for functions that setup the user options
#include "user_options.h"
// Needed for terminal operations
#include "terminal.h"
// Needed for usage information
#include "usage.h"
```
This will allow ffigen to pick up the correct types needed for hashcat.h
Remove once done.

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter development, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

