package com.example.emergency_finder

import android.content.Context
import android.content.ContextWrapper
import android.os.Bundle
import android.util.Log
import android.view.View
import androidx.fragment.app.FragmentActivity
import androidx.fragment.app.FragmentManager
import androidx.fragment.app.FragmentTransaction
import com.naver.maps.map.*
import com.naver.maps.map.MapFragment
import com.naver.maps.map.util.FusedLocationSource
import io.flutter.plugin.platform.PlatformView

class NaverMapView(context: Context?, id: Int, creationParams: Map<String?, Any?>?) : PlatformView, OnMapReadyCallback {
    private val fragment: MapFragment
    private lateinit var naverMap: NaverMap
    private lateinit var locationSource: FusedLocationSource

    override fun getView(): View? {
        return fragment.view
    }

    override fun dispose() {
        fragment.mapView!!.onDestroy()
    }

    init {
        Log.i("MyNaverMapView2", "start init")
        var activityContext = context
        while (activityContext is ContextWrapper) {
            if (activityContext is FragmentActivity) {
                break
            }
            activityContext = activityContext.baseContext
        }

        val fragmentManager: FragmentManager = (activityContext as FragmentActivity).supportFragmentManager
        val fragmentTransaction: FragmentTransaction = fragmentManager.beginTransaction()

        fragment = MapFragment()

        fragmentTransaction.add(id, fragment)
        fragmentTransaction.commitNow()

        fragment.mapView!!.onCreate(Bundle())
        fragment.mapView!!.getMapAsync(this)


        locationSource = FusedLocationSource(fragment.activity!!, 1000)
    }

    override fun onMapReady(naverMap: NaverMap) {
        Log.i("MyNaverMapView2", "onMapReady")
        this.naverMap = naverMap
        naverMap.locationSource = locationSource

        Log.i("MyNaverMapView2", "LocationTrackingMode")
        naverMap.locationTrackingMode = LocationTrackingMode.Follow
    }

    // MapFragment의 생명주기와 동기화하여 호출되도록 오버라이드
    fun onResume() {
        fragment.mapView!!.onResume()
    }

    fun onPause() {
        fragment.mapView!!.onPause()
    }

    fun onSaveInstanceState(outState: Bundle) {
        fragment.mapView!!.onSaveInstanceState(outState)
    }

    fun onDestroy() {
        fragment.mapView!!.onDestroy()
    }
}