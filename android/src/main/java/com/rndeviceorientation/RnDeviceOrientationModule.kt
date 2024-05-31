package com.rndeviceorientation

import android.content.Context
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.Promise
import android.util.Log
import android.view.OrientationEventListener
import android.hardware.SensorManager
import com.facebook.react.bridge.WritableMap
import com.facebook.react.bridge.Arguments
import com.facebook.react.modules.core.DeviceEventManagerModule

class RnDeviceOrientationModule(reactContext: ReactApplicationContext) :
  ReactContextBaseJavaModule(reactContext) {

    private var mOrientation = 0
    private var lastOrientation = 0
    override fun getName(): String {
      return NAME
    }
  
    private fun sendEvent(reactContext: ReactApplicationContext, eventName: String, params: WritableMap?) {
      reactContext
        .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter::class.java)
        .emit(eventName, params)
  }
  
    private val orientationListener = object : OrientationEventListener(
      reactContext,SensorManager.SENSOR_DELAY_NORMAL
    ) {
      override fun onOrientationChanged(orientation: Int) {
        if (orientation > 315 || orientation < 45) {
          mOrientation = 0
        } else if (orientation > 45 && orientation < 135) {
          mOrientation = 90
        } else if (orientation > 135 && orientation < 225) {
          mOrientation = 180
        } else if (orientation > 225 && orientation < 315) {
          mOrientation = 270
        }
        if(lastOrientation != mOrientation){
          lastOrientation = mOrientation
          val params = Arguments.createMap().apply {
            putString("val", lastOrientation.toString())
          }
          sendEvent(reactContext, "OrientatitionDevicesChanged", params)
        }
        
        }
    }.apply {
      if (canDetectOrientation()) enable() else disable()
    }

  companion object {
    const val NAME = "RnDeviceOrientation"
  }
  @ReactMethod
  fun addListener(eventName: String) {}

  // @Suppress("unused", "UNUSED_PARAMETER")
  @ReactMethod
  fun removeListeners(count: Int) {}
}
