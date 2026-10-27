import 'dart:ffi';
import 'dart:isolate';

import 'engine.dart';
import 'nativ_event_handler.dart';

class NativeEventReceiver {
  late final ReceivePort _receivePort;

  late final int nativePortId;

  void initialize(Engine engine, NativeEventHandler eventHandler) {
    _receivePort = ReceivePort();

    nativePortId = _receivePort.sendPort.nativePort;

    _receivePort.listen((event) {
      // print('Received from C++: $event');
      eventHandler.handleEventReceived(event);
    });

    engine.initialiseDartEventPortId(nativePortId);
  }

  void dispose() {
    _receivePort.close();
  }
}
