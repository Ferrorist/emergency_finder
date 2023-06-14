package com.example.emergency_finder

import android.util.Log
import androidx.fragment.app.FragmentManager
import com.naver.maps.map.MapFragment
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {
    private var mapFragment: MapFragment? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        flutterEngine.platformViewsController.registry.registerViewFactory(
                "UserNaverMap",
                MapViewFactory(this)
        )

        val channel = MethodChannel(
                flutterEngine.dartExecutor.binaryMessenger,
                "fullscreen"
        )



        channel.setMethodCallHandler { call, result ->
            if (call.method == "handleBackPressed") {
                Log.i("MethodCall", "handleBackPressed")
                if (mapFragment != null) {
                    Log.i("mapFragment", "onDestroy")
                    val fragmentManager: FragmentManager = supportFragmentManager
                    fragmentManager.beginTransaction().remove(mapFragment!!).commit()
                    mapFragment = null
                } else {
                    Log.i("mapFragment", "Fragment is null")
                }
            }
        }
    }
    fun setMapFragment(fragment: MapFragment) {
        mapFragment = fragment
    }

    override fun onDestroy() {
        super.onDestroy()
        Log.i("MainActivity", "onDestroy")
        if(mapFragment != null){
            val fragmentManager: FragmentManager = supportFragmentManager
            fragmentManager.beginTransaction().remove(mapFragment!!).commit()
            mapFragment = null
            Log.i("mapFragment", "MainActivity.onDestroy")
        }
    }
}
