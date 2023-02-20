import ZiggeoMediaSwiftSDK
import Flutter
import Combine
import UIKit

public class SwiftZiggeoPlugin: NSObject, FlutterPlugin, ZiggeoQRCodeReaderDelegate {
    // for screen recorder
    public let SCREEN_RECORDER_BACKGROUND_COLOR = "background_color"
    public let SCREEN_RECORDER_TEXT_COLOR = "title_color"
    public let SCREEN_RECORDER_TITLE = "title"
    public let SCREEN_RECORDER_FRAME = "frame"
    public let SCREEN_RECORDER_FRAME_X_START = "frame_x_start"
    public let SCREEN_RECORDER_FRAME_Y_START = "frame_y_start"
    public let SCREEN_RECORDER_FRAME_X_END = "frame_x_end"
    public let SCREEN_RECORDER_FRAME_Y_END = "frame_y_end"

    public let REAR_CAMERA = "rearCamera"
    public let FRONT_CAMERA = "frontCamera"
    public let HIGH_QUALITY = "highQuality"
    public let MEDIUM_QUALITY = "mediumQuality"
    public let LOW_QUALITY = "lowQuality"
    public let ERR_UNKNOWN = "ERR_UNKNOWN"
    public let ERR_DURATION_EXCEEDED = "ERR_DURATION_EXCEEDED"
    public let ERR_FILE_DOES_NOT_EXIST = "ERR_FILE_DOES_NOT_EXIST"
    public let ERR_PERMISSION_DENIED = "ERR_PERMISSION_DENIED"
    public let MAX_DURATION = "max_duration"
    public let ENFORCE_DURATION = "enforce_duration"
    public let CLOSE_AFTER_SUCCESS_FUL_SCAN = "closeAfterSuccessfulScan"
    public let KEY_HIDE_RECORDER_CONTROLS = "hideRecorderControls"
    public let KEY_HIDE_PLAYER_CONTROLS = "hidePlayerControls"

    var m_ziggeo: Ziggeo? = nil;
    var m_flutterPluginRegistrar: FlutterPluginRegistrar? = nil;
    var result: ((String) -> ())? = nil ;

    public func ziggeoQRCodeScaned(_ qrCode: String) {
       self.result?(qrCode);
    }

    init(registrar: FlutterPluginRegistrar){
       self.m_flutterPluginRegistrar = registrar;
    }

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "ziggeo", binaryMessenger: registrar.messenger())
        let instance = SwiftZiggeoPlugin(registrar: registrar);
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let viewController = UIApplication.shared.windows.filter({ (w) -> Bool in
                    return w.isHidden == false
         }).first?.rootViewController;
       if (call.method == "setAppToken") {
          if let args = call.arguments as? Dictionary<String, Any>,
            let appToken = args["appToken"] as? String{
            m_ziggeo = Ziggeo(token: appToken,delegate: viewController! as! ZiggeoDelegate);
            registerAllTheChannels();
          }
        } else if (call.method == "startQrScanner") {
            self.result = { res in result(res);};
            m_ziggeo = Ziggeo(qrCodeReaderDelegate: self as! ZiggeoQRCodeReaderDelegate);
//             if let args = call.arguments as? Dictionary<String, Any>,
//                let shouldCloseAfterSuccessfulScan = args["shouldCloseAfterSuccessfulScan"] as? Bool{
            m_ziggeo?.startQrScanner();
        } else if (call.method == "getPlayerConfig") {
//              no getters
        } else if (call.method == "getPlayerStyle") {
//              no getters
        } else if (call.method == "setPlayerConfig") {
//              todo  add PlayerConfig params
        } else if (call.method == "setPlayerStyle") {
//              no style
        } else if (call.method == "getFileSelectorConfig") {
//              no getters
        } else if (call.method == "setFileSelectorConfig") {
//              no config
        } else if (call.method == "setQrScannerConfig") {
//              no config
        } else if (call.method == "getQrScannerConfig") {
//              no config
        } else if (call.method == "setUploadingConfig") {
//              no config
        } else if (call.method == "getUploadingConfig") {
//              no getters
        } else if (call.method == "setRecordingConfirmationDialogConfig") {
//              no config
        } else if (call.method == "setRecorderConfig") {
            var mapRecorderConfigParams = [String: Any]();
            if let args = call.arguments as? Dictionary<String, Any>,
              let coverSelectorEnabled = args["shouldEnableCoverShot"] as? Bool{
              m_ziggeo?.setCoverSelectorEnabled(coverSelectorEnabled);
            }
            if let args = call.arguments as? Dictionary<String, Any>,
              let isLiveStreaming = args["isLiveStreaming"] as? Bool{
              m_ziggeo?.setLiveStreamingEnabled(isLiveStreaming);
            }
            if let args = call.arguments as? Dictionary<String, Any>,
              let startDelay = args["startDelay"] as? Int{
              m_ziggeo?.setAutostartRecordingAfter(startDelay);
              m_ziggeo?.setStartDelay(startDelay);
            }
            if let args = call.arguments as? Dictionary<String, Any>,
              let blurMode = args["blurMode"] as? Bool{
              m_ziggeo?.setBlurMode(blurMode);
            }
            if let args = call.arguments as? Dictionary<String, Any>,
              let maxDuration = args["maxDuration"] as? Int{
              m_ziggeo?.setMaxRecordingDuration(maxDuration);
            }
            if let args = call.arguments as? Dictionary<String, Any>,
              let shouldSendImmediately = args["shouldSendImmediately"] as? Bool{
              m_ziggeo?.setSendImmediately(shouldSendImmediately);
            }
            if let args = call.arguments as? Dictionary<String, Any>,
              let shouldDisableCameraSwitch = args["shouldDisableCameraSwitch"] as? Bool{
              m_ziggeo?.setCameraSwitchEnabled(!shouldDisableCameraSwitch);
            }
            if let args = call.arguments as? Dictionary<String, Any>,
              let videoQuality = args["videoQuality"] as? Int{
                 m_ziggeo?.setQuality(videoQuality);
            }
            if let args = call.arguments as? Dictionary<String, Any>,
              let facing = args["facing"] as? Int{
                 if(facing == 0){
                    m_ziggeo?.setCamera(REAR_CAMERA);
                 }
                 if(facing == 1){
                    m_ziggeo?.setCamera(FRONT_CAMERA);
                 }
            }
        } else if (call.method == "getRecorderConfig") {
//              no config getters
        } else if (call.method == "getStopRecordingConfirmationDialogConfig") {
//              no config
        } else if (call.method == "getAppToken") {
//              no getters
        } else if (call.method == "cancelUploadByPath") {
               if let args = call.arguments as? Dictionary<String, Any>,
                   let deleteFile = args["deleteFile"] as? Bool,
                   let path = args["path"] as? String{
                   m_ziggeo?.cancelUpload(path, deleteFile);
               }
        } else if (call.method == "cancelCurrentUpload") {
//              m_ziggeo?.cancelUpload();
        } else if (call.method == "getClientAuthToken") {
//              no getters
        } else if (call.method == "setClientAuthToken") {
             if let args = call.arguments as? Dictionary<String, Any>,
                 let clientAuthToken = args["clientAuthToken"] as? String{
//               no setters
             }
        } else if (call.method == "setServerAuthToken") {
             if let args = call.arguments as? Dictionary<String, Any>,
                 let clientAuthToken = args["serverAuthToken"] as? String{
//               no setters
             }
        } else if (call.method == "getServerAuthToken") {
//               no getters
        } else if (call.method == "startCameraRecorder") {
             m_ziggeo?.record();
        } else if (call.method == "startAudioRecorder") {
             m_ziggeo?.startAudioRecorder();
        } else if (call.method == "startAudioPlayerByToken") {
             if let args = call.arguments as? Dictionary<String, Any>,
                 let tokens = args["token"] as? String{
                 m_ziggeo?.startAudioPlayer( [tokens]);
             }
        } else if (call.method == "startAudioPlayerByPath") {
//              no method
        } else if (call.method == "showImageByToken") {
             if let args = call.arguments as? Dictionary<String, Any>,
                 let tokens = args["token"] as? String{
                 m_ziggeo?.showImage( [tokens]);
             }
        } else if (call.method == "showImageByPath") {
//              no method
        } else if (call.method == "startImageRecorder") {
             m_ziggeo?.startImageRecorder();
        } else if (call.method == "startPlayer") {
             if let args = call.arguments as? Dictionary<String, Any>,
                 let tokens = args["tokens"] as? [String]{
                 m_ziggeo?.playVideo(tokens);
             }
        }  else if (call.method == "startPlayer") {
             if let args = call.arguments as? Dictionary<String, Any>,
                 let paths = args["paths"] as? String{
                 m_ziggeo?.playFromUri( [paths]);
             }
        } else if (call.method == "startScreenRecorder") {
        //todo
          let button = UIButton(type: .system)
          button.addTarget(self, action: "Action:", for: UIControl.Event.touchUpInside)
            if let data = call.arguments as? Dictionary<String, Any>,
               let args = data["args"] as? Dictionary<String, Any>{
               if let background_color = args[SCREEN_RECORDER_BACKGROUND_COLOR] as? String{
                     button.backgroundColor = UIColor(hex: background_color)
                 } else {
                     button.backgroundColor = .white
               }
               if let title = args[SCREEN_RECORDER_TITLE] as? String{
                     button.setTitle(title, for: UIControl.State.normal)
                 } else {
                     button.setTitle("Record", for: UIControl.State.normal)
               }
               if let title_color = args[SCREEN_RECORDER_TEXT_COLOR] as? String{
                     button.setTitleColor(UIColor(hex: title_color), for: .normal)
                 } else {
                     button.setTitleColor(.black, for: .normal)
               }
               if let frame = args[SCREEN_RECORDER_FRAME] as? Dictionary<String, Int>,
                  let frame_x_start = frame[SCREEN_RECORDER_FRAME_X_START] as? Int,
                  let frame_y_start = frame[SCREEN_RECORDER_FRAME_Y_START] as? Int,
                  let frame_x_end = frame[SCREEN_RECORDER_FRAME_X_END] as? Int,
                  let frame_y_end = frame[SCREEN_RECORDER_FRAME_Y_END] as? Int{
                     button.frame = CGRectMake(
                        CGFloat(frame_x_start),
                        CGFloat(frame_y_start),
                        CGFloat(frame_x_end),
                        CGFloat(frame_y_end))
                 } else {
                     button.frame = CGRectMake(16, viewController!.view.bounds.height - 96, 50, 50)
               }
               viewController!.view.addSubview(button)
            } else {
                     button.backgroundColor = .white
                     button.frame = CGRectMake(16, viewController!.view.bounds.height - 96, 50, 50)
                     button.setTitle("Record", for: UIControl.State.normal)
                     button.setTitleColor(.black, for: .normal)
                     viewController!.view.addSubview(button)
                 }

          m_ziggeo?.startScreenRecorder(
                    addRecordingButtonToView: button as! UIView,
                    frame: CGRect(
                         x: 0, y: 0,
                         width: viewController!.view.bounds.width,
                         height: viewController!.view.bounds.height),
                    appGroup: "com.ziggeo.sdk"
          );
        } else if (call.method == "uploadFromFileSelector") {
//              if let args = call.arguments as? Dictionary<String, Any>,
//                  let data = args["args"] as? Dictionary<String, Any>{
                    m_ziggeo?.uploadFromFileSelector(
                       [Ziggeo_Key_Type.MEDIA_TYPES.rawValue:[Media_Type.Video.rawValue,
                       Media_Type.Audio.rawValue,
                       Media_Type.Image.rawValue]]
                    );
//              }
        } else if (call.method == "sendReport") {
             if let args = call.arguments as? Dictionary<String, Any>,
                 let logs = args["logs"] as? [String]{
                 m_ziggeo?.sendReport( logs );
             }
        } else {
            result(FlutterError(code:"Not implemented", message:"Not implemented",details: ""))
        }
    }

    private func registerAllTheChannels(){
        SwiftVideoApiPlugin.registerZiggeo(registrar: m_flutterPluginRegistrar!, ziggeo: m_ziggeo!);
        SwiftAudioApiPlugin.registerZiggeo(registrar: m_flutterPluginRegistrar!, ziggeo: m_ziggeo!);
        SwiftImageApiPlugin.registerZiggeo(registrar: m_flutterPluginRegistrar!, ziggeo: m_ziggeo!);
        SwiftStreamApiPlugin.registerZiggeo(registrar: m_flutterPluginRegistrar!, ziggeo: m_ziggeo!);
    }

}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}

    public enum Media_Type: String {
        case Video = "video"
        case Audio = "audio"
        case Image = "image"
    }

    public enum Ziggeo_Key_Type : String {
        case BYTES_SENT = "bytesSent"
        case BYTES_TOTAL = "totalBytes"
        case FILE_NAME = "fileName"
        case PATH = "path"
        case QR = "qr"
        case TOKEN = "token"
    //    case ERROR = "error"
        case PERMISSIONS = "permissions"
        case SOUND_LEVEL = "sound_level"
        case SECONDS_LEFT = "seconds_left"
        case MILLIS_PASSED = "millis_passed"
        case MILLIS = "millis"
        case FILES = "files"
        case VALUE = "value"
        case MEDIA_TYPES = "media_types"
        case BLUR_EFFECT = "blur_effect"
        case CLIENT_AUTH = "client_auth"
        case SERVER_AUTH = "server_auth"
        case TAGS = "tags"

        static let allValues = [BYTES_SENT, BYTES_TOTAL, FILE_NAME, PATH, QR, TOKEN, /*ERROR,*/ PERMISSIONS, SOUND_LEVEL, SECONDS_LEFT, MILLIS_PASSED, MILLIS, FILES, VALUE, MEDIA_TYPES, BLUR_EFFECT, CLIENT_AUTH, SERVER_AUTH, TAGS]
    }

extension UIViewController: ZiggeoDelegate {
    // ZiggeoRecorderDelegate
    public func ziggeoRecorderLuxMeter(_ luminousity: Double) {
    }

    public func ziggeoRecorderAudioMeter(_ audioLevel: Double) {
    }

    public func ziggeoRecorderFaceDetected(_ faceID: Int, rect: CGRect) {
    }

    public func ziggeoRecorderReady() {
//        Common.addLog("Recorder Ready")
    }

    public func ziggeoRecorderCanceled() {
//        Common.addLog("Recorder Canceled")
    }

    public func ziggeoRecorderStarted() {
//        Common.addLog("Recorder Started")
    }

    public func ziggeoRecorderStopped(_ path: String) {
//        Common.addLog("Recorder Stopped")
    }

    public func ziggeoRecorderCurrentRecordedDurationSeconds(_ seconds: Double) {
//        Common.addLog("Recorder Recording Duration: \(seconds)")
    }

    public func ziggeoRecorderPlaying() {
//        Common.addLog("Recorder Playing")
    }

    public func ziggeoRecorderPaused() {
//        Common.addLog("Recorder Paused")
    }

    public func ziggeoRecorderRerecord() {
//        Common.addLog("Recorder Rerecord")
    }

    public func ziggeoRecorderManuallySubmitted() {
//        Common.addLog("Recorder Manually Submitted")
    }


    public func ziggeoStreamingStarted() {
//        Common.addLog("Streaming Started")
    }

    public func ziggeoStreamingStopped() {
//        Common.addLog("Streaming Stopped")
    }


    // ZiggeoUploadDelegate
    public func preparingToUpload(_ path: String) {
//        Common.addLog("Preparing To Upload: \(path)")
    }

    public func failedToUpload(_ path: String) {
//        Common.addLog("Failed To Upload: \(path)")
    }

    public func uploadStarted(_ path: String, token: String, streamToken: String, backgroundTask: URLSessionTask) {
//        Common.addLog("Upload Started: \(token) - \(streamToken)")
    }

    public func uploadProgress(_ path: String, token: String, streamToken: String, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
//        Common.addLog("Upload Progress: \(totalBytesSent) - \(totalBytesExpectedToSend)")
    }

    public func uploadFinished(_ path:String, token: String, streamToken: String) {
//        Common.addLog("Upload Finished: \(token) - \(streamToken)")

//        Common.recordingVideosController?.getRecordings()
//        Common.recordingAudiosController?.getRecordings()
//        Common.recordingImagesController?.getRecordings()
    }

    public func uploadVerified(_ path:String, token: String, streamToken: String, response: URLResponse?, error: Error?, json: NSDictionary?) {
//        Common.addLog("Upload Verified: \(token) - \(streamToken)")
    }

    public func uploadProcessing(_ path: String, token: String, streamToken: String) {
//        Common.addLog("Upload Processing: \(token) - \(streamToken)")
    }

    public func uploadProcessed(_ path: String, token: String, streamToken: String) {
//        Common.addLog("Upload Processed: \(token) - \(streamToken)")
    }

    public func delete(_ token: String, streamToken: String, response: URLResponse?, error: Error?, json: NSDictionary?) {
//        Common.addLog("delete: \(token) - \(streamToken)")
    }


    // ZiggeoHardwarePermissionCheckDelegate
    public func checkCameraPermission(_ granted: Bool) {
    }

    public func checkMicrophonePermission(_ granted: Bool) {
    }

    public func checkPhotoLibraryPermission(_ granted: Bool) {
    }

    public func checkHasCamera(_ hasCamera: Bool) {
    }

    public func checkHasMicrophone(_ hasMicrophone: Bool) {
    }


    // ZiggeoPlayerDelegate
    public func ziggeoPlayerPlaying() {
//        Common.addLog("Player Playing")
    }

    public func ziggeoPlayerPaused() {
//        Common.addLog("Player Paused")
    }

    public func ziggeoPlayerEnded() {
//        Common.addLog("Player Ended")
    }

    public func ziggeoPlayerSeek(_ positionMillis: Double) {
//        Common.addLog("Player Seek: \(positionMillis)")
    }

    public func ziggeoPlayerReadyToPlay() {
//        Common.addLog("Player Ready To Play")
    }
}
