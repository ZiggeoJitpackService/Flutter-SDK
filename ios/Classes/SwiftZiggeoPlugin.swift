import ZiggeoMediaSwiftSDK
import Flutter
import Combine
import UIKit

public class SwiftZiggeoPlugin: NSObject, FlutterPlugin, ZiggeoQRScannerDelegate {
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

    public func qrCodeScaned(_ qrCode: String) {
       self.result?(qrCode);
    }

     public func qrCodeScanCancelledByUser() {
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
            m_ziggeo = Ziggeo(token: appToken);
            registerAllTheChannels();
          }
        } else if (call.method == "startQrScanner") {
            self.result = { res in result(res);};
            m_ziggeo = Ziggeo();
            m_ziggeo?.qrScannerDelegate = self;
            m_ziggeo?.startQrScanner();
        } else if (call.method == "getPlayerConfig") {
                  var res = m_ziggeo?.getVideoPlayerConfig()
                  let encoder = JSONEncoder()
                  do {
                      let modelData = try encoder.encode(res)
                      let jsonString = String(data: modelData, encoding: .utf8)
                      result(jsonString)
                  } catch {
                      print(error)
                  }
        } else if (call.method == "getPlayerStyle") {
//              no getters
        } else if (call.method == "setPlayerConfig") {
          var shouldShowSubtitlesParam = false;
          var isMutedParam = false;
          if let args = call.arguments as? Dictionary<String, Any>{
             if let shouldShowSubtitles = args["shouldShowSubtitles"] as? Bool{
                 shouldShowSubtitlesParam = shouldShowSubtitles;
                 }
             if let isMuted = args["isMuted"] as? Bool{
                 isMutedParam = isMuted;
                }
             }
          m_ziggeo?.setVideoPlayerConfig(["shouldShowSubtitles": shouldShowSubtitlesParam,
                                     "isMuted": isMutedParam
                                    ]);
        } else if (call.method == "setPlayerStyle") {
//              todo  add PlayerStyle params
        } else if (call.method == "getFileSelectorConfig") {
                  var res = m_ziggeo?.getFileSelectorConfig()
                  let encoder = JSONEncoder()
                  do {
                      let modelData = try encoder.encode(res)
                      let jsonString = String(data: modelData, encoding: .utf8)
                      result(jsonString)
                  } catch {
                      print(error)
                  }
        } else if (call.method == "setFileSelectorConfig") {
          var mediaTypeParam = 0x01;
          if let args = call.arguments as? Dictionary<String, Any>,
             let mediaType = args["mediaType"] as? Int{
                 mediaTypeParam = mediaType;
             }
          m_ziggeo?.setFileSelectorConfig(["mediaType": mediaTypeParam]);
        } else if (call.method == "setQrScannerConfig") {
          var shouldCloseParam = true;
          if let args = call.arguments as? Dictionary<String, Any>,
             let shouldCloseAfterSuccessfulScan = args["shouldCloseAfterSuccessfulScan"] as? Bool{
                 shouldCloseParam = shouldCloseAfterSuccessfulScan;
             }
          m_ziggeo?.setQrScannerConfig([CLOSE_AFTER_SUCCESS_FUL_SCAN: shouldCloseParam]);
        } else if (call.method == "getQrScannerConfig") {
                  var res = m_ziggeo?.getQrScannerConfig()
                  let encoder = JSONEncoder()
                  do {
                      let modelData = try encoder.encode(res)
                      let jsonString = String(data: modelData, encoding: .utf8)
                      result(jsonString)
                  } catch {
                      print(error)
                  }
        } else if (call.method == "setUploadingConfig") {
//              no config
        } else if (call.method == "getUploadingConfig") {
//              no getters
        } else if (call.method == "setRecordingConfirmationDialogConfig") {
//              no config
        } else if (call.method == "setRecorderConfig") {
                    var isLiveStreamingParam = false
                    var blurModeParam = false
                    var shouldSendImmediatelyParam = false
                    var shouldDisableCameraSwitchParam = false
                    var shouldEnableCoverShotParam = false
                    var shouldAutoStartRecordingParam = false
                    var shouldShowFaceOutlineParam = false
                    var facingParam = 0
                    var startDelayParam = 0
                    var videoQualityParam = 1
                    var maxDurationParam = 0
            if let args = call.arguments as? Dictionary<String, Any>,
              let coverSelectorEnabled = args["shouldEnableCoverShot"] as? Bool{
              shouldEnableCoverShotParam = coverSelectorEnabled;
//               m_ziggeo?.setCoverSelectorEnabled(coverSelectorEnabled);
            }
            if let args = call.arguments as? Dictionary<String, Any>,
              let isLiveStreaming = args["isLiveStreaming"] as? Bool{
              isLiveStreamingParam = isLiveStreaming;
//               m_ziggeo?.setLiveStreamingEnabled(isLiveStreaming);
            }
            if let args = call.arguments as? Dictionary<String, Any>,
              let startDelay = args["startDelay"] as? Int{
              startDelayParam = startDelay;
              shouldAutoStartRecordingParam = startDelayParam > 0;
//               m_ziggeo?.setAutostartRecordingAfter(startDelay);
//               m_ziggeo?.setStartDelay(startDelay);
            }
            if let args = call.arguments as? Dictionary<String, Any>,
              let shouldShowFaceOutline = args["shouldShowFaceOutline"] as? Bool{
              shouldShowFaceOutlineParam = shouldShowFaceOutline;
            }
            if let args = call.arguments as? Dictionary<String, Any>,
              let blurMode = args["blurMode"] as? Bool{
              blurModeParam = blurMode;
//               m_ziggeo?.setBlurMode(blurMode);
            }
            if let args = call.arguments as? Dictionary<String, Any>,
              let maxDuration = args["maxDuration"] as? Int{
              maxDurationParam = maxDuration;
//               m_ziggeo?.setMaxRecordingDuration(maxDuration);
            }
            if let args = call.arguments as? Dictionary<String, Any>,
              let shouldSendImmediately = args["shouldSendImmediately"] as? Bool{
              shouldSendImmediatelyParam = shouldSendImmediately;
//               m_ziggeo?.setSendImmediately(shouldSendImmediately);
            }
            if let args = call.arguments as? Dictionary<String, Any>,
              let shouldDisableCameraSwitch = args["shouldDisableCameraSwitch"] as? Bool{
              shouldDisableCameraSwitchParam = shouldDisableCameraSwitch;
//               m_ziggeo?.setCameraSwitchEnabled(!shouldDisableCameraSwitch);
            }
            if let args = call.arguments as? Dictionary<String, Any>,
              let videoQuality = args["videoQuality"] as? Int{
              videoQualityParam = videoQuality;
//                  m_ziggeo?.setQuality(videoQuality);
            }
            if let args = call.arguments as? Dictionary<String, Any>,
              let facing = args["facing"] as? Int{
              facingParam = facing;
            }
            m_ziggeo?.setVideoRecorderConfig([
                 "isLiveStreaming": isLiveStreamingParam,
                 "blurMode": blurModeParam,
                 "shouldSendImmediately": shouldSendImmediatelyParam,
                 "shouldDisableCameraSwitch": shouldDisableCameraSwitchParam,
                 "shouldEnableCoverShot": shouldEnableCoverShotParam,
                 "shouldAutoStartRecording": shouldAutoStartRecordingParam,
                 "shouldShowFaceOutline":shouldShowFaceOutlineParam,
                 "facing":facingParam,
                 "startDelay": startDelayParam,
                 "videoQuality": videoQualityParam,
                 "maxDuration": maxDurationParam
            ]);
        } else if (call.method == "getRecorderConfig") {
                  var res = m_ziggeo?.getVideoRecorderConfig()
                  let encoder = JSONEncoder()
                  do {
                      let modelData = try encoder.encode(res)
                      let jsonString = String(data: modelData, encoding: .utf8)
                      result(jsonString)
                  } catch {
                      print(error)
                  }
        } else if (call.method == "getStopRecordingConfirmationDialogConfig") {
//              no config
        } else if (call.method == "getAppToken") {
                result(m_ziggeo?.getAppToken());
        } else if (call.method == "cancelUploadByPath") {
               if let args = call.arguments as? Dictionary<String, Any>,
                   let deleteFile = args["deleteFile"] as? Bool,
                   let path = args["path"] as? String{
                   m_ziggeo?.cancelUpload(path, deleteFile);
               }
        } else if (call.method == "cancelCurrentUpload") {
//         _ path: String?, _ delete_file: Bool
//              m_ziggeo?.cancelUpload();
        } else if (call.method == "getClientAuthToken") {
                result(m_ziggeo?.getClientAuthToken());
        } else if (call.method == "setClientAuthToken") {
             if let args = call.arguments as? Dictionary<String, Any>,
                 let clientAuthToken = args["clientAuthToken"] as? String{
                 m_ziggeo?.setClientAuthToken(clientAuthToken)
             }
        } else if (call.method == "setServerAuthToken") {
             if let args = call.arguments as? Dictionary<String, Any>,
                 let serverAuthToken = args["serverAuthToken"] as? String{
                 m_ziggeo?.setServerAuthToken(serverAuthToken)
             }
        } else if (call.method == "getServerAuthToken") {
                 result(m_ziggeo?.getServerAuthToken());
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
             if let args = call.arguments as? Dictionary<String, Any>,
                 let paths = args["path"] as? String{
//                  m_ziggeo?.startAudioPlayerByPaths( [paths]);
             }
//           m_ziggeo?.startAudioPlayerByPaths( ["paths"]);
        } else if (call.method == "showImageByToken") {
             if let args = call.arguments as? Dictionary<String, Any>,
                 let tokens = args["token"] as? String{
                 m_ziggeo?.showImage( [tokens]);
             }
        } else if (call.method == "showImageByPath") {
             if let args = call.arguments as? Dictionary<String, Any>,
                 let paths = args["path"] as? String{
//                  m_ziggeo?.showImageByPath( [paths]);
             }
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
                    appGroup: "com.ziggeo.sdk",
                    preferredExtension: ""
          );
        } else if (call.method == "uploadFromFileSelector") {
             if let args = call.arguments as? Dictionary<String, Any>,
                 let data = args["args"] as? Dictionary<String, Any>{
                    m_ziggeo?.uploadFromFileSelector(
                       [Ziggeo_Key_Type.MEDIA_TYPES.rawValue:[Media_Type.Video.rawValue,
                       Media_Type.Audio.rawValue,
                       Media_Type.Image.rawValue]]
                    );
             }
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
