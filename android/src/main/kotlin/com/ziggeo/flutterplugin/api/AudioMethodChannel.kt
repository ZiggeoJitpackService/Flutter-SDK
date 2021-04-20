package com.ziggeo.flutterplugin.api

import android.annotation.SuppressLint
import com.ziggeo.androidsdk.Ziggeo
import com.ziggeo.androidsdk.net.models.audios.AudioDetails
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.reactivex.Completable
import io.reactivex.Single
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import java.io.File

class AudiosMethodChannel(private val ziggeo: Ziggeo) : MethodCallHandler {

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "index" -> {
                var args: HashMap<String, String>? = null
                (call.arguments as? HashMap<String, String>)?.let {
                    args = it
                }
                processRequest(ziggeo.apiRx().audiosRaw()
                        .index(args), call, result)
            }
            "get" -> call.argument<String>("tokenOrKey")?.let {
                processRequest(ziggeo.apiRx().audiosRaw()[it], call, result)
            }
            "update" -> call.argument<String>("data")?.let {
                processRequest(ziggeo.apiRx().audiosRaw().update(AudioDetails.fromJson(it)), call, result)
            }
            "destroy" -> call.argument<String>("tokenOrKey")?.let {
                processRequest(ziggeo.apiRx().audiosRaw().destroy(it), call, result)
            }
            "create" -> {
                var args: HashMap<String, String>? = null
                (call.arguments as? HashMap<String, String>)?.let {
                    args = it
                }
                (call.arguments as? File)?.let {
                    processRequest(ziggeo.apiRx().audiosRaw()
                            .create(it, args), call, result)
                }
            }
            else -> result.notImplemented()
        }
    }

    @SuppressLint("CheckResult")
    private fun processRequest(request: Single<*>, call: MethodCall, result: MethodChannel.Result) {
        request.subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe { json, throwable ->
                    if (throwable != null) {
                        result.error(call.method, throwable.toString(), throwable.message)
                    } else json?.let {
                        result.success(json)
                    }
                }
    }

    @SuppressLint("CheckResult")
    private fun processRequest(request: Completable, call: MethodCall, result: MethodChannel.Result) {
        request.subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe({
                    result.success(null)
                }, { throwable: Throwable? -> result.error(call.method, throwable.toString(), throwable?.message) })
    }
}
