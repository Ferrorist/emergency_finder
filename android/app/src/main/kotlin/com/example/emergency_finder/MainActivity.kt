package com.example.emergency_finder
import android.util.Log
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterFragmentActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine
                .platformViewsController
                .registry
                .registerViewFactory(
                        "UserNaverMap",
                        MapViewFactory())

//        GeneratedPluginRegistrant.registerWith(flutterEngine)
//
//        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "UserNaverMap")
//                .setMethodCallHandler { call, result ->
//                    if(call.method.equals("sendUserLatLng")){
//                        val latitude = call.argument<Double>("latitude")
//                        val longitude = call.argument<Double>("longitude")
//
//                        val intent = Intent(this, UserMapActivity::class.java)
//
//                        intent.putExtra("latitude", latitude)
//                        intent.putExtra("longitude", longitude)
//                        Log.i("startAcitivty", "MainActivity → UserMapActivity")
//                        startActivity(intent)
//                        result.success(null)
//
//                    } else {
//                        Log.i("error", "Failed to MainActivity → UserMapActivity")
//                        result.notImplemented()
//                    }
//                }
    }
}