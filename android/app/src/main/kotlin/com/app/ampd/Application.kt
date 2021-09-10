package com.app.ampd

import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry

import com.app.ampd.FirebaseCloudMessagingPluginRegistrant
import com.app.ampd.FlutterLocalNotificationPluginRegistrant
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService

class Application : FlutterApplication(), PluginRegistry.PluginRegistrantCallback {

    override fun onCreate() {
        super.onCreate()
        FlutterFirebaseMessagingService.setPluginRegistrant(this)
    }

    override fun registerWith(registry: PluginRegistry?) {
        if (registry != null) {
            FirebaseCloudMessagingPluginRegistrant.registerWith(registry)
            FlutterLocalNotificationPluginRegistrant.registerWith(registry)
        }
    }

}