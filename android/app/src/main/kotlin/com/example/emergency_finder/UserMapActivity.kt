package com.example.emergency_finder

import android.os.Bundle
import android.util.Log
import androidx.fragment.app.FragmentActivity
import com.naver.maps.geometry.LatLng
import com.naver.maps.map.CameraPosition
import com.naver.maps.map.MapFragment
import com.naver.maps.map.NaverMap
import com.naver.maps.map.NaverMapOptions
import com.naver.maps.map.OnMapReadyCallback
import com.naver.maps.map.overlay.Marker
import kotlinx.coroutines.*

class UserMapActivity : FragmentActivity(), OnMapReadyCallback {
    private val fm = supportFragmentManager
    private var latitude: Double? = NaverMap.DEFAULT_CAMERA_POSITION.target.latitude
    private var longitude: Double? = NaverMap.DEFAULT_CAMERA_POSITION.target.longitude

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_map)

        runBlocking {
            latitude = async { getToIntent("latitude") }.await()
            longitude = async {getToIntent("longitude")}.await()
        }
        Log.i("LatLng : ", "latitude : " + latitude + ", longitude : " + longitude)
        val mapFragment = fm.findFragmentById(R.id.Map_container) as MapFragment?
                ?: MapFragment.newInstance(
                        NaverMapOptions().camera(
                                CameraPosition(
                                        LatLng(latitude!!, longitude!!),
                                        NaverMap.DEFAULT_CAMERA_POSITION.zoom,
                                        30.0,
                                        45.0
                                )
                        )
                ).also {
                    supportFragmentManager.beginTransaction().add(R.id.Map_container, it).commit()
                }
        // OnMapReadyCallback 등록
        mapFragment.getMapAsync(this)
    }

    // 객체가 준비되면 호출되는 callback method
    override fun onMapReady(naverMap: NaverMap) {
        Marker().apply{
            position = LatLng(latitude!!, longitude!!)
            map = naverMap
        }
    }

    suspend fun getToIntent(name: String): Double {
        delay(500L)
        return intent.getDoubleExtra(name, 0.0)
    }
}