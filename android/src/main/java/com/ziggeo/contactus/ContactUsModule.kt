package com.ziggeo.contactus

import com.facebook.react.bridge.*
import com.ziggeo.BaseModule
import com.ziggeo.tasks.SimpleTask
import java.util.*

/**
 * Created by alex on 6/25/2017.
 */
class ContactUsModule(reactContext: ReactApplicationContext) : BaseModule(reactContext) {
    override fun getName() = "ContactUs"

    @ReactMethod
    fun sendReport(logsArray: ReadableArray?, promise: Promise) {
        val task = SimpleTask(promise)
        val logs: MutableList<String> = ArrayList()
        logsArray?.let {
            for (`object` in it.toArrayList()) {
                logs.add(`object`.toString())
            }
        }
        ziggeo.sendReport(logs)
        task.resolve(null)
    }

    @ReactMethod
    fun sendEmailToSupport(args: ReadableMap?, promise: Promise) {
        val task = SimpleTask(promise)
        ziggeo.sendEmailToSupport()
        task.resolve(null)
    }

    @ReactMethod
    fun setAppToken(appToken: String) {
        ziggeo.appToken = appToken
    }

    // we must override this method to make @ReactMethod annotation work
    @ReactMethod
    override fun setClientAuthToken(token: String) {
        super.setClientAuthToken(token)
    }

    // we must override this method to make @ReactMethod annotation work
    @ReactMethod
    override fun setServerAuthToken(token: String) {
        super.setServerAuthToken(token)
    }


}
