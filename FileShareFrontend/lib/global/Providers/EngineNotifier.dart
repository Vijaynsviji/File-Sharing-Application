

import 'package:flutter/cupertino.dart';

import '../../native_bridge/engine.dart';

class EngineNotifier extends ChangeNotifier {
  Engine? _engine;
  String? _errorMessage;

  // Getters for the UI
  Engine? get engine => _engine;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;

  EngineNotifier() {
    _initializeEngine();
  }

  void _initializeEngine() {
    try {
      // Attempt once-off setup safely
      _engine = Engine();
      _errorMessage = null;
    } catch (e) {
      _engine = null;
      _errorMessage = e.toString();
      debugPrint("Engine Setup Error: $e");
    }
    notifyListeners(); // Notify UI about success or failure
  }

  @override
  void dispose() {
    // Make sure we clean up the native pointer when the provider is destroyed
    _engine?.dispose();
    super.dispose();
  }
}
