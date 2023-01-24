import ZiggeoMediaSwiftSDK
import Flutter
import Combine
import UIKit

public class SwiftZiggeoPlugin: NSObject, FlutterPlugin {

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

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "ziggeo", binaryMessenger: registrar.messenger())
        let instance = SwiftZiggeoPlugin()
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
          }
        } else if (call.method == "startQrScanner") {
            m_ziggeo = Ziggeo(qrCodeReaderDelegate: viewController! as! ZiggeoQRCodeReaderDelegate)
            if let args = call.arguments as? Dictionary<String, Any>,
               let shouldCloseAfterSuccessfulScan = args["shouldCloseAfterSuccessfulScan"] as? Bool{
               m_ziggeo?.startQrScanner([CLOSE_AFTER_SUCCESS_FUL_SCAN:shouldCloseAfterSuccessfulScan]);
            }
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
                 let tokens = args["tokens"] as? String{
                 m_ziggeo?.startAudioPlayer( [tokens]);
             }
        } else if (call.method == "startAudioPlayerByPath") {
//              no method
        } else if (call.method == "showImageByToken") {
             if let args = call.arguments as? Dictionary<String, Any>,
                 let tokens = args["tokens"] as? String{
                 m_ziggeo?.showImage( [tokens]);
             }
        } else if (call.method == "showImageByPath") {
//              no method
        } else if (call.method == "startImageRecorder") {
             m_ziggeo?.startImageRecorder();
        } else if (call.method == "startPlayer") {
             if let args = call.arguments as? Dictionary<String, Any>,
                 let tokens = args["tokens"] as? String{
                 m_ziggeo?.playVideo( [tokens]);
             }
        }  else if (call.method == "startPlayer") {
             if let args = call.arguments as? Dictionary<String, Any>,
                 let paths = args["paths"] as? String{
                 m_ziggeo?.playFromUri( [paths]);
             }
        } else if (call.method == "startScreenRecorder") {
        //todo
             m_ziggeo?.startScreenRecorder();
        } else if (call.method == "uploadFromFileSelector") {
             if let args = call.arguments as? Dictionary<String, Any>,
                 let data = args["data"] as? [String : Any]{
                 m_ziggeo?.uploadFromFileSelector( data );
             }
        } else if (call.method == "sendReport") {
             if let args = call.arguments as? Dictionary<String, Any>,
                 let logs = args["logs"] as? [String]{
                 m_ziggeo?.sendReport( logs );
             }
        } else {
            result("Not implemented")
        }
    }

}

extension UIViewController: ZiggeoQRCodeReaderDelegate {
    public func ziggeoQRCodeScaned(_ qrCode: String) {
//         self.login(qrCode)
    }
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
