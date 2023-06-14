package com.example.emergency_finder

import android.content.Context
import android.content.ContextWrapper
import android.os.Bundle
import android.util.Log
import android.view.View
import androidx.fragment.app.FragmentActivity
import androidx.fragment.app.FragmentManager
import androidx.fragment.app.FragmentTransaction
import com.naver.maps.map.util.FusedLocationSource
import com.naver.maps.map.LocationTrackingMode
import com.naver.maps.map.MapFragment
import com.naver.maps.map.NaverMap
import com.naver.maps.map.OnMapReadyCallback
import io.flutter.plugin.platform.PlatformView

class NaverMapView(
        context: Context?,
        id: Int,
        creationParams: Map<String?, Any?>?,
        private val activity: FragmentActivity
) : PlatformView, OnMapReadyCallback {

    private val fragment: MapFragment
    private lateinit var naverMap: NaverMap
    private lateinit var locationSource: FusedLocationSource
    private var isTrackingUser: Boolean = creationParams?.get("isTrackingUser") as? Boolean ?: false

    override fun getView(): View? {
        return fragment.view
    }

    override fun dispose() {
        onDestroy()
    }

    init {
        Log.i("MyNaverMapView", "start init")
        var activityContext = context
        while (activityContext is ContextWrapper) {
            if (activityContext is FragmentActivity) {
                break
            }
            activityContext = activityContext.baseContext
        }

        val fragmentManager: FragmentManager = (activityContext as FragmentActivity).supportFragmentManager
        val fragmentTransaction: FragmentTransaction = fragmentManager.beginTransaction()

        fragment = MapFragment.newInstance()
        fragmentTransaction.add(id, fragment)
        fragmentTransaction.commitNow()

        fragment.getMapAsync(this)

//        fragment = fragmentManager.findFragmentById(R.id.map_fragment) as MapFragment?
//                ?:MapFragment.newInstance().also {
//                    fragmentManager.beginTransaction().add(R.id.map_fragment, it).commit()
//                }

        fragment.getMapAsync(this)

        if (activity is MainActivity) {
            activity.setMapFragment(fragment)
        }

        locationSource = FusedLocationSource(activity, 1000)
    }

    override fun onMapReady(naverMap: NaverMap) {
        Log.i("MyNaverMapView", "onMapReady")
        this.naverMap = naverMap
        naverMap.locationSource = locationSource

        Log.i("MyNaverMapView", "LocationTrackingMode")
        naverMap.locationTrackingMode =
                if (isTrackingUser) LocationTrackingMode.Follow else LocationTrackingMode.None
    }

    fun onResume() {
        Log.i("MyNaverMapView", "onResume - fragment")
        fragment.onResume()
    }

    fun onPause() {
        Log.i("MyNaverMapView", "onPause - fragment")
        fragment.onPause()
    }

    fun onSaveInstanceState(outState: Bundle) {
        Log.i("MyNaverMapView", "onSaveInstanceState - fragment")
        fragment.onSaveInstanceState(outState)
    }

    fun onDestroy() {
        Log.i("MyNaverMapView", "onDestroy - fragment")
        fragment.onDestroy()
    }
}
