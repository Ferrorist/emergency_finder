//package com.example.emergency_finder
//
//import android.os.Bundle
//import android.view.LayoutInflater
//import android.view.View
//import android.view.ViewGroup
//import androidx.fragment.app.Fragment
//import com.naver.maps.map.*
//import android.util.Log
//
//class MapFragment: Fragment(), OnMapReadyCallback {
//    private lateinit var mapView: MapView
//
//    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
//        val rootView = inflater.inflate(R.layout.fragment_layout, container, false)
//
//        mapView = rootView.findViewById(R.id.map_view)
//        mapView.onCreate(savedInstanceState)
//        mapView.getMapAsync(this)
//        return rootView
//    }
//
//    override fun onMapReady(maps: NaverMap) {
//    }
//
//    override fun onResume() {
//        super.onResume()
//        mapView.onResume()
//    }
//
//    override fun onPause() {
//        super.onPause()
//        mapView.onPause()
//
//    }
//
//    override fun onDestroyView() {
//        super.onDestroyView()
//        mapView.onDestroy()
//
//    }
//
//    override fun onSaveInstanceState(outState: Bundle) {
//        super.onSaveInstanceState(outState)
//        mapView.onSaveInstanceState(outState)
//    }
//}