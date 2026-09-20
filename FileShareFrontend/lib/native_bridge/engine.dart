import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';

class Engine {
  late final DynamicLibrary _library;

  late final Pointer<Void> _engine;
  bool _isDisposed = false;

  // --- C++ Function Signatures ---
  late final int Function(Pointer<Void>) _initializeDartApi;
  late final void Function(Pointer<Void>) _destroy;
  late final void Function(Pointer<Void>) _startBroadcast;
  late final void Function(Pointer<Void>) _startListening;
  late final void Function(Pointer<Void>) _stopBroadcasting;
  late final void Function(Pointer<Void>) _stopListening;
  late final void Function(Pointer<Void>) _startTcpListening;
  late final void Function(Pointer<Void>) _stopTcpListening;

  late final void Function(Pointer<Void>, Pointer<Utf8>) _sendFileRequest;
  late final void Function(Pointer<Void>, Pointer<Utf8>) _sendFileResponse;
  late final void Function(Pointer<Void>, Pointer<Utf8>) _addUserSelectedFiles;

  late final void Function(Pointer<Void>, int) _initialiseDartEventPortId;

  Engine() {
    _library = _loadLibrary();

    final create = _library.lookupFunction<
        Pointer<Void> Function(),
        Pointer<Void> Function()
    >('engine_create');

    _engine = create();

    _destroy = _library.lookup<NativeFunction<Void Function(Pointer<Void>)>>('engine_destroy').asFunction();
    _startBroadcast = _library.lookup<NativeFunction<Void Function(Pointer<Void>)>>('engine_startBroadCast').asFunction();
    _startListening = _library.lookup<NativeFunction<Void Function(Pointer<Void>)>>('engine_startListening').asFunction();
    _stopBroadcasting = _library.lookup<NativeFunction<Void Function(Pointer<Void>)>>('engine_stopBroadCasting').asFunction();
    _stopListening = _library.lookup<NativeFunction<Void Function(Pointer<Void>)>>('engine_stopListening').asFunction();
    _startTcpListening = _library.lookup<NativeFunction<Void Function(Pointer<Void>)>>('engine_startTCPListening').asFunction();
    _stopTcpListening = _library.lookup<NativeFunction<Void Function(Pointer<Void>)>>('engine_stopTCPListening').asFunction();

    _sendFileRequest = _library.lookup<NativeFunction<Void Function(Pointer<Void>, Pointer<Utf8>)>>('engine_sendFileRequest').asFunction();
    _sendFileResponse = _library.lookup<NativeFunction<Void Function(Pointer<Void>, Pointer<Utf8>)>>('engine_sendFileResponse').asFunction();
    _addUserSelectedFiles = _library.lookup<NativeFunction<Void Function(Pointer<Void>, Pointer<Utf8>)>>('engine_addUserSelectedFiles').asFunction();

    _initialiseDartEventPortId = _library.lookup<NativeFunction<Void Function(Pointer<Void>, Int64)>>('engine_initialiseDartEventPortId').asFunction();
  }


  Pointer<Void> get engine => _engine;

  // --- Engine Commands ---

  void startBroadcast() => _verifyAlive(() => _startBroadcast(_engine));
  void startListening() => _verifyAlive(() => _startListening(_engine));
  void stopBroadcasting() => _verifyAlive(() => _stopBroadcasting(_engine));
  void stopListening() => _verifyAlive(() => _stopListening(_engine));
  void startTcpListening() => _verifyAlive(() => _startTcpListening(_engine));
  void stopTcpListening() => _verifyAlive(() => _stopTcpListening(_engine));

  DynamicLibrary _loadLibrary() {
    if (Platform.isAndroid) {
      return DynamicLibrary.open('libfile_share_engine.so');
    }

    throw UnsupportedError(
      'Unsupported platform: ${Platform.operatingSystem}',
    );
  }

  void sendFileRequest(String senderIPAddress) {
    _verifyAlive(() {
      final nativeString = senderIPAddress.toNativeUtf8();
      try {
        _sendFileRequest(_engine, nativeString);
      } finally {
        calloc.free(nativeString);
      }
    });
  }

  void sendFileResponse(String deviceId) {
    _verifyAlive(() {
      final nativeString = deviceId.toNativeUtf8();
      try {
        _sendFileResponse(_engine, nativeString);
      } finally {
        calloc.free(nativeString);
      }
    });
  }

  void addUserSelectedFiles(String jsonString) {
    _verifyAlive(() {
      final nativeString = jsonString.toNativeUtf8();
      try {
        _addUserSelectedFiles(_engine, nativeString);
      } finally {
        calloc.free(nativeString);
      }
    });
  }

  void initialiseDartEventPortId(int dartPortId) {
    _verifyAlive(() => _initialiseDartEventPortId(_engine, dartPortId));
  }

  // --- Setup & Lifecycle ---

  void _bindDartApi() {
    _initializeDartApi = _library
        .lookup<NativeFunction<IntPtr Function(Pointer<Void>)>>('engine_initialize_dart_api')
        .asFunction();

    final result = _initializeDartApi(NativeApi.initializeApiDLData);
    if (result != 0) {
      throw StateError('Failed to initialize Dart API DL in native engine.');
    }
  }

  void _verifyAlive(void Function() action) {
    if (_isDisposed) {
      throw StateError('Cannot use Engine after dispose() has been called.');
    }
    action();
  }

  void dispose() {
    final destroy = _library.lookupFunction<
        Void Function(Pointer<Void>),
        void Function(Pointer<Void>)
    >('engine_destroy');

    destroy(_engine);
  }
}