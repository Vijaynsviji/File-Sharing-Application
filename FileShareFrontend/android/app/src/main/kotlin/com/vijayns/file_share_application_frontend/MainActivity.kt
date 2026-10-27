
package com.vijayns.file_share_application_frontend

import android.content.Context
import android.net.wifi.WifiManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    companion object {
        private const val WIFI_CHANNEL =
            "com.vijayns.file_share/wifi"
    }

    override fun configureFlutterEngine(
        flutterEngine: FlutterEngine
    ) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            WIFI_CHANNEL
        ).setMethodCallHandler(
            { call: MethodCall, result: MethodChannel.Result ->

                when (call.method) {

                    "isWifiEnabled" -> {
                        try {
                            val wifiManager =
                                applicationContext.getSystemService(
                                    Context.WIFI_SERVICE
                                ) as WifiManager

                            val isEnabled = wifiManager.isWifiEnabled

                            result.success(isEnabled)

                        } catch (e: Exception) {
                            result.error(
                                "WIFI_CHECK_FAILED",
                                e.message
                                    ?: "Unable to check Wi-Fi state",
                                null
                            )
                        }
                    }

                    else -> {
                        result.notImplemented()
                    }
                }
            }
        )
    }
}
