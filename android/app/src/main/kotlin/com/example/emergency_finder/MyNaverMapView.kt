package com.example.emergency_finder

import android.content.Context
import android.view.View
import android.widget.FrameLayout
import androidx.fragment.app.FragmentActivity
import io.flutter.plugin.platform.PlatformView

class MyNaverMapView(activity: FragmentActivity, context: Context?, id: Int, creationParmas: Map<String?, Any?>?) : PlatformView {
    private val layout: FrameLayout
    override fun getView(): View? {
        return layout
    }

    override fun dispose() {
    }
    init {
        layout = FrameLayout(context!!)
    }

}