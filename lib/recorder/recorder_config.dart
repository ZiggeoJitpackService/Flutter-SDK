import 'package:ziggeo/common/base_config.dart';
import 'package:ziggeo/recorder/recorder_listener.dart';

import 'stop_recording_confirmation_dialog_config.dart';

class RecorderConfig extends BaseConfig {
  static const defaultStartDelay = 3; // seconds
  static const qualityHigh = 0;
  static const qualityMedium = 1;
  static const qualityLow = 2;
  static const facingBack = 0;
  static const facingFront = 1;

  //IOS screen recorder button settings
  static const SCREEN_RECORDER_BACKGROUND_COLOR = "background_color";
  static const SCREEN_RECORDER_TEXT_COLOR = "title_color";
  static const SCREEN_RECORDER_TITLE = "title";
  static const SCREEN_RECORDER_FRAME = "frame";
  static const SCREEN_RECORDER_FRAME_X_START = "frame_x_start";
  static const SCREEN_RECORDER_FRAME_Y_START = "frame_y_start";
  static const SCREEN_RECORDER_FRAME_X_END = "frame_x_end";
  static const SCREEN_RECORDER_FRAME_Y_END = "frame_y_end";

  bool? shouldShowFaceOutline;
  bool? isLiveStreaming;
  bool? shouldAutoStartRecording;
  int? startDelay;
  bool? blurMode;
  bool? shouldSendImmediately;
  bool? shouldDisableCameraSwitch;
  int? videoQuality;
  int? facing;
  int? maxDuration;
  bool? shouldEnableCoverShot;
  bool? shouldConfirmStopRecording;
  bool? isPausedMode;
  StopRecordingConfirmationDialogConfig? stopRecordingConfirmationDialogConfig;
  RecorderEventsListener? eventsListener;

  static RecorderConfig defaultRecorderConfig() {
    return RecorderConfig(
      shouldShowFaceOutline : false,
      isLiveStreaming : false,
      shouldAutoStartRecording : false,
      startDelay : defaultStartDelay,
      blurMode : false,
      shouldSendImmediately : true,
      shouldDisableCameraSwitch : false,
      videoQuality : 0,
      facing : 0,
      maxDuration : 0,
      shouldEnableCoverShot : true,
      shouldConfirmStopRecording : true,
      isPausedMode : true,
      stopRecordingConfirmationDialogConfig : StopRecordingConfirmationDialogConfig(),
    );
  }

  RecorderConfig({
    this.shouldShowFaceOutline = false,
    this.isLiveStreaming = false,
    this.shouldAutoStartRecording = false,
    this.startDelay = defaultStartDelay,
    this.blurMode = false,
    this.shouldSendImmediately = true,
    this.shouldDisableCameraSwitch = false,
    this.videoQuality = 0,
    this.facing = 0,
    this.maxDuration = 0,
    this.shouldEnableCoverShot = true,
    this.shouldConfirmStopRecording = true,
    this.isPausedMode = true,
    StopRecordingConfirmationDialogConfig?
        stopRecordingConfirmationDialogConfig,
    RecorderEventsListener? eventsListener,
  });

  static RecorderConfig convertFromMap(Map<String, dynamic> map) {
    var shouldShowFaceOutline = map["shouldShowFaceOutline"];
    var isLiveStreaming = map["isLiveStreaming"];
    var shouldAutoStartRecording = map["shouldAutoStartRecording"];
    var startDelay = map["startDelay"];
    var blurMode = map["blurMode"];
    var shouldSendImmediately = map["shouldSendImmediately"];
    var shouldDisableCameraSwitch = map["shouldDisableCameraSwitch"];
    var videoQuality = map["videoQuality"];
    var facing = map["facing"];
    var maxDuration = map["maxDuration"];
    var shouldEnableCoverShot = map["shouldEnableCoverShot"];
    var shouldConfirmStopRecording = map["shouldConfirmStopRecording"];
    var stopRecordingConfirmationDialogConfig =
        map["stopRecordingConfirmationDialogConfig"];
    var isPausedMode = map["isPausedMode"];
    return RecorderConfig(
      shouldShowFaceOutline: shouldShowFaceOutline,
      isLiveStreaming: isLiveStreaming,
      shouldAutoStartRecording: shouldAutoStartRecording,
      startDelay: startDelay,
      blurMode: blurMode,
      shouldSendImmediately: shouldSendImmediately,
      shouldDisableCameraSwitch: shouldDisableCameraSwitch,
      videoQuality: videoQuality,
      facing: facing,
      maxDuration: maxDuration,
      shouldEnableCoverShot: shouldEnableCoverShot,
      shouldConfirmStopRecording: shouldConfirmStopRecording,
      stopRecordingConfirmationDialogConfig:
          stopRecordingConfirmationDialogConfig ?? StopRecordingConfirmationDialogConfig(),
      isPausedMode: isPausedMode ?? true,
    );
  }

  @override
  Map<String, dynamic> convertToMap() {
    var map = super.convertToMap();
    map["shouldShowFaceOutline"] = shouldShowFaceOutline;
    map["isLiveStreaming"] = isLiveStreaming;
    map["shouldAutoStartRecording"] = shouldAutoStartRecording;
    map["startDelay"] = startDelay;
    map["blurMode"] = blurMode;
    map["shouldSendImmediately"] = shouldSendImmediately;
    map["shouldDisableCameraSwitch"] = shouldDisableCameraSwitch;
    map["videoQuality"] = videoQuality;
    map["facing"] = facing;
    map["maxDuration"] = maxDuration;
    map["shouldEnableCoverShot"] = shouldEnableCoverShot;
    map["shouldConfirmStopRecording"] = shouldConfirmStopRecording;
    map["stopRecordingConfirmationDialogConfig"] =
        stopRecordingConfirmationDialogConfig;
    map["isPausedMode"] = isPausedMode;
    return map;
  }
}
