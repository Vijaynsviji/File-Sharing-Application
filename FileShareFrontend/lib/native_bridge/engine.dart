import 'dart:ffi';
import 'dart:io';

class Engine {
  late final DynamicLibrary _library;

  late final Pointer<Void> _engine;

  Engine() {
    _library = _loadLibrary();

    final create = _library.lookupFunction<
        Pointer<Void> Function(),
        Pointer<Void> Function()
    >('engine_create');

    _engine = create();
  }

  DynamicLibrary _loadLibrary() {
    if (Platform.isAndroid) {
      return DynamicLibrary.open('libfile_share_engine.so');
    }

    throw UnsupportedError(
      'Unsupported platform: ${Platform.operatingSystem}',
    );
  }

  void dispose() {
    final destroy = _library.lookupFunction<
        Void Function(Pointer<Void>),
        void Function(Pointer<Void>)
    >('engine_destroy');

    destroy(_engine);
  }
}