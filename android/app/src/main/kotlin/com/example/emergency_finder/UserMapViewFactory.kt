package com.example.emergency_finder

import android.content.Context
import androidx.fragment.app.FragmentActivity
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class UserMapViewFactory(private val activity: FragmentActivity) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        val creationParams = args as Map<String?, Any?>?
        return MyNaverMapView(activity, context, viewId, args)
    }
}