import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ziggeo_example/res/dimens.dart';

class Utils {
  //common settings
  static const String keyAppToken = "app_token";
  static const String keyCustomPlayerMode = "custom_player";
  static const String keyCustomCameraMode = "custom_camera";

  static const String keyShouldAllowMultipleSelection = "should_allow_multiple_selection";
  static const String keyMediaType = "media_type";
  static const String keySyncInterval = "sync_interval";
  static const String keyShouldUseWifiOnly = "should_use_wifi_only";
  static const String keyShouldTurnOffUploader = "should_turn_off_uploader";
  static const String keyLostConnectionAction = "lost_connection_action";
  static const String keyShouldCloseAfterSuccessfulScan = "should_close_after_successfulScan";

  //player config
  static const String keyShouldShowSubtitles = "should_show_subtitles";
  static const String keyIsMuted = "is_muted";
  static const String keyControllerStyle = "controller_style";
  static const String keyTextColor = "text_color";
  static const String keyUnplayedColor = "unplayed_color";
  static const String keyPlayedColor = "played_color";
  static const String keyBufferedColor = "buffered_color";
  static const String keyTintColor = "tint_color";
  //recorder config
  static const String keyBlurMode = "blur_mode";
  static const String keyShouldShowFaceOutline = "should_show_face_outline";
  static const String keyIsLiveStreaming = "is_live_streaming";
  static const String keyShouldAutoStartRecording = "should_auto_start_recording";
  static const String keyStartDelay = "start_delay";
  static const String keyShouldSendImmediately = "should_send_immediately";
  static const String keyShouldDisableCameraSwitch = "should_disable_camera_switch";
  static const String keyVideoQuality = "video_quality";
  static const String keyFacing = "facing";
  static const String keyMaxDurationRec = "max_duration_rec";
  static const String keyShouldEnableCoverShot = "should_enable_cover_shot";
  static const String keyShouldConfirmStopRecording = "should_confirm_stop_recording";
  static const String keyIsPausedMode = "is_paused_mode";
  static const String keyTitleText = "title_text";
  static const String keyMesText = "_mesText";
  static const String keyPosBtnText = "pos_btn_text";
  static const String keyNegBtnText = "neg_btn_text";


  static sendEmail(String address) async {
    final Email email = Email(
      recipients: [address],
    );

    await FlutterEmailSender.send(email);
  }

  static openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static showToast(BuildContext context, String text) {
    Widget widget = Container(
        padding: const EdgeInsets.all(toastPadding),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(shadowOpacity),
              spreadRadius: spreadRadius,
              blurRadius: blurRadius,
            )
          ],
          borderRadius: BorderRadius.circular(borderRadius),
          color: Colors.white,
        ),
        child: Text(text));

    FToast().showToast(
      child: widget,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: duration),
    );
  }
}
