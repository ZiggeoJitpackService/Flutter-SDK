package com.ziggeo.flutterplugin.zvideo

import android.net.Uri
import android.os.Handler
import com.ziggeo.androidsdk.Ziggeo
import com.ziggeo.androidsdk.widgets.videoview.ZVideoView
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class ZVideoMethodChannel(private val zVideoPlayer: ZVideoView, private val ziggeo: Ziggeo) : MethodChannel.MethodCallHandler {

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "onPause" -> {
                zVideoPlayer.onPause()
            }
            "onResume" -> {
                zVideoPlayer.onResume()
            }
            "initViews" -> {
                zVideoPlayer.initViews()
            }
            "getCallback" -> {
                zVideoPlayer.callback
            }
            "prepareQueueAndStartPlaying" -> {
                Handler().post { zVideoPlayer.prepareQueueAndStartPlaying() }
            }
            "setVideoToken" -> call.argument<String>("videoToken").let {
                val array = arrayOf(it)
                zVideoPlayer.videoTokens = array.toMutableList()
            }
            "setVideoPath" -> if (call.hasArgument("videoPath")) {
                call.argument<String>("videoPath")?.let {
                    zVideoPlayer.videoUris = arrayOf(Uri.parse(it)).toMutableList()
                    Handler().post {
                        zVideoPlayer.prepareQueueAndStartPlaying()
                    }
                }
            }
            "loadConfigs" -> {
                zVideoPlayer.loadConfigs()
            }
            else -> result.notImplemented()
        }
    }
}
