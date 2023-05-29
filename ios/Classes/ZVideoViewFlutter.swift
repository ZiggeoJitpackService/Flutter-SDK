import Foundation
import Flutter
import UIKit
import ZiggeoMediaSwiftSDK

class ZVideoViewFlutter: NSObject, FlutterPlatformView {
    private var _nativeWebView: CustomVideoPlayer
    private var _methodChannel: FlutterMethodChannel

    func view() -> UIView {
        return _nativeWebView
    }

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger
    ) {
        _nativeWebView = CustomVideoPlayer()
        _methodChannel = FlutterMethodChannel(name: "z_video_view", binaryMessenger: messenger)

        super.init()
        // iOS views can be created here
        _methodChannel.setMethodCallHandler(onMethodCall)

    }


    func onMethodCall(call: FlutterMethodCall, result: FlutterResult) {
        switch(call.method){
        case "setUrl":
            setText(call:call, result:result)
        case "onResume":
            setText(call:call, result:result)
        case "initViews":
            setText(call:call, result:result)
        case "getCallback":
            setText(call:call, result:result)
        case "prepareQueueAndStartPlaying":
            setText(call:call, result:result)
        case "setVideoToken":
            setText(call:call, result:result)
        case "setVideoPath":
            setText(call:call, result:result)
        case "loadConfigs":
            setText(call:call, result:result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    func setText(call: FlutterMethodCall, result: FlutterResult){
        let url = call.arguments as! String
        _nativeWebView.loadRequest(NSURLRequest(url: NSURL(string: url)! as URL) as URLRequest)
    }

}
