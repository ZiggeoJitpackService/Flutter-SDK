import Flutter
import UIKit

public class SwiftZiggeoPlayerViewPlugin: NSObject, FlutterPlugin {

    public static func register(with registrar: FlutterPluginRegistrar) {
        registrar.register(FLNativeViewFactory(messenger: registrar.messenger()), withId: "z_video_player")
       }

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "ziggeo", binaryMessenger: registrar.messenger())
        let instance = SwiftZiggeoPlayerViewPlugin(registrar: registrar);
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
}

class FLNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return FLNativeView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }
}

class FLNativeView: NSObject, FlutterPlatformView {
    private var _view: UIView
    private var _methodChannel: FlutterMethodChannel

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = UIView()
        _methodChannel = FlutterMethodChannel(name: "z_video_view", binaryMessenger: messenger)
        super.init()
        // iOS views can be created here
        createNativeView(view: _view)
        _methodChannel.setMethodCallHandler(onMethodCall)
    }

    func view() -> UIView {
        return _view
    }

    func createNativeView(view _view: UIView){
        _view.backgroundColor = UIColor.blue
        let nativeLabel = UILabel()
        nativeLabel.text = "Native text from iOS"
        nativeLabel.textColor = UIColor.white
        nativeLabel.textAlignment = .center
        nativeLabel.frame = CGRect(x: 0, y: 0, width: 180, height: 48.0)
        _view.addSubview(nativeLabel)
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
//             _view.loadRequest(NSURLRequest(url: NSURL(string: url)! as URL) as URLRequest)
        }
}


