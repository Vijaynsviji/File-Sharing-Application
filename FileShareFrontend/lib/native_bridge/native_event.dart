
import 'dart:ffi';
import 'dart:isolate';

import 'engine.dart';

class NativeEventReceiver {
  late final ReceivePort _receivePort;

  late final int nativePortId;

  void initialize(Engine engine) {
    _receivePort = ReceivePort();

    nativePortId = _receivePort.sendPort.nativePort;

    _receivePort.listen((event) {
      print('Received from C++: $event');
    });

    engine.initialiseDartEventPortId(nativePortId);
  }

  void dispose() {
    _receivePort.close();
  }
}