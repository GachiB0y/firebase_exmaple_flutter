package com.example.flutter_firebase

import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.yandex.mapkit.MapKitFactory;
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    MapCofig
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MapKitFactory.setApiKey("YOuR_APIKEY") // Your generated API key
        super.configureFlutterEngine(flutterEngine)
    }
}
