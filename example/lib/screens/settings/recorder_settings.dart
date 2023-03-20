import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ziggeo/recorder/recorder_config.dart';
import 'package:ziggeo/recorder/stop_recording_confirmation_dialog_config.dart';
import 'package:ziggeo/ziggeo.dart';
import 'package:ziggeo_example/localization.dart';
import 'package:ziggeo_example/res/colors.dart';
import 'package:ziggeo_example/res/dimens.dart';
import 'package:ziggeo_example/widgets/TextLocalized.dart';

import '../../localization.dart';

class RecorderSettingsScreen extends StatefulWidget {
  Ziggeo ziggeo;

  RecorderSettingsScreen(this.ziggeo);

  @override
  _RecorderSettingsScreenState createState() =>
      _RecorderSettingsScreenState(ziggeo);
}

class _RecorderSettingsScreenState extends State<RecorderSettingsScreen> {
  final Ziggeo ziggeo;
  AppLocalizations localize = AppLocalizations.instance;

  bool _shouldShowFaceOutline = false;
  bool _isLiveStreaming = false;
  bool _shouldAutoStartRecording = false;
  String? _startDelay;
  bool _blurMode = false;
  bool _shouldSendImmediately = false;
  bool _shouldDisableCameraSwitch = false;
  String? _videoQuality;
  String? _facing;
  String? _maxDurationRec;
  bool _shouldEnableCoverShot = false;
  bool _shouldConfirmStopRecording = false;
  bool _isPausedMode = false;

  String? _titleText;
  String? _mesText;
  String? _posBtnText;
  String? _negBtnText;

  late RecorderConfig config;

  _RecorderSettingsScreenState(this.ziggeo);

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return (_startDelay == null)
        ? Scaffold(body: Container())
        : Scaffold(
            body: Padding(
              padding: EdgeInsets.all(common_margin),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: btn_qr_height),
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextLocalized(
                              'hint_should_show_face_outline',
                              style: TextStyle(fontSize: settings_text_size),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Switch(
                                value: _shouldShowFaceOutline,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      _shouldShowFaceOutline = value;
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextLocalized(
                              'hint_is_live_streaming',
                              style: TextStyle(fontSize: settings_text_size),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Switch(
                                activeColor: Color(primary),
                                value: _isLiveStreaming,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      _isLiveStreaming = value;
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextLocalized(
                              'hint_should_auto_start_recording',
                              style: TextStyle(fontSize: settings_text_size),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Switch(
                                activeColor: Color(primary),
                                value: _shouldAutoStartRecording,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      _shouldAutoStartRecording = value;
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          onChanged: (value) => _startDelay = value,
                          enabled: true,
                          initialValue: _startDelay,
                          style: null,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: localize.text('hint_start_delay'),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextLocalized(
                              'tv_blur_mode',
                              style: TextStyle(fontSize: settings_text_size),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Switch(
                                activeColor: Color(primary),
                                value: _blurMode,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      _blurMode = value;
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextLocalized(
                              'hint_should_send_immediately',
                              style: TextStyle(fontSize: settings_text_size),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Switch(
                                activeColor: Color(primary),
                                value: _shouldSendImmediately,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      _shouldSendImmediately = value;
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextLocalized(
                              'hint_should_disable_camera_switch',
                              style: TextStyle(fontSize: settings_text_size),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Switch(
                                activeColor: Color(primary),
                                value: _shouldDisableCameraSwitch,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      _shouldDisableCameraSwitch = value;
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          onChanged: (value) => _videoQuality = value,
                          enabled: true,
                          initialValue: _videoQuality,
                          style: null,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: localize.text('hint_video_quality'),
                          ),
                        ),
                        TextFormField(
                          onChanged: (value) => _facing = value,
                          enabled: true,
                          initialValue: _facing,
                          style: null,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: localize.text('hint_facing'),
                          ),
                        ),
                        TextFormField(
                          onChanged: (value) => _maxDurationRec = value,
                          enabled: true,
                          initialValue: _maxDurationRec,
                          style: null,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: localize.text('hint_max_duration_rec'),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextLocalized(
                              'hint_should_enable_cover_shot',
                              style: TextStyle(fontSize: settings_text_size),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Switch(
                                activeColor: Color(primary),
                                value: _shouldEnableCoverShot,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      _shouldEnableCoverShot = value;
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextLocalized(
                              'hint_should_confirm_stop_recording',
                              style: TextStyle(fontSize: settings_text_size),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Switch(
                                activeColor: Color(primary),
                                value: _shouldConfirmStopRecording,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      _shouldConfirmStopRecording = value;
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextLocalized(
                              'hint_is_paused_mode',
                              style: TextStyle(fontSize: settings_text_size),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Switch(
                                activeColor: Color(primary),
                                value: _isPausedMode,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      _isPausedMode = value;
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          onChanged: (value) => _titleText = value,
                          enabled: true,
                          initialValue: _titleText,
                          style: TextStyle(fontSize: settings_text_size),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: localize.text('hint_title_text'),
                          ),
                        ),
                        TextFormField(
                          onChanged: (value) => _mesText = value,
                          enabled: true,
                          initialValue: _mesText,
                          style: TextStyle(fontSize: settings_text_size),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: localize.text('hint_mes_text'),
                          ),
                        ),
                        TextFormField(
                          onChanged: (value) => _posBtnText = value,
                          enabled: true,
                          initialValue: _posBtnText,
                          style: TextStyle(fontSize: settings_text_size),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: localize.text('hint_pos_btn_text'),
                          ),
                        ),
                        TextFormField(
                          onChanged: (value) => _negBtnText = value,
                          enabled: true,
                          initialValue: _negBtnText,
                          style: TextStyle(fontSize: settings_text_size),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: localize.text('hint_neg_btn_text'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: btn_qr_width,
                      height: btn_qr_height,
                      child: ElevatedButton(
                        onPressed: () {
                          onSavedBtnPressed();
                        },
                        child: TextLocalized('btn_save_settings'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }

  onSavedBtnPressed() async {
    config = RecorderConfig();
    config.blurMode = _blurMode;
    config.shouldShowFaceOutline = _shouldShowFaceOutline;
    config.isLiveStreaming = _isLiveStreaming;
    config.shouldAutoStartRecording = _shouldAutoStartRecording;
    config.startDelay = (_startDelay != null)
        ? int.parse(_startDelay!)
        : (widget.ziggeo.recorderConfig)?.startDelay;
    config.shouldSendImmediately = _shouldSendImmediately;
    config.shouldDisableCameraSwitch = _shouldDisableCameraSwitch;
    config.videoQuality = (_videoQuality != null)
        ? int.parse(_videoQuality!)
        : (widget.ziggeo.recorderConfig)?.videoQuality;
    config.facing = (_facing != null)
        ? int.parse(_facing!)
        : (widget.ziggeo.recorderConfig)?.facing;
    config.maxDuration = (_maxDurationRec != null)
        ? int.parse(_maxDurationRec!)
        : (widget.ziggeo.recorderConfig)?.maxDuration;
    config.shouldEnableCoverShot = _shouldEnableCoverShot;
    config.shouldConfirmStopRecording = _shouldConfirmStopRecording;
    config.isPausedMode = _isPausedMode;
    config.stopRecordingConfirmationDialogConfig =
        StopRecordingConfirmationDialogConfig(
      titleText: _titleText,
      mesText: _mesText,
      posBtnText: _posBtnText,
      negBtnText: _negBtnText,
    );
    ziggeo.recorderConfig = config;
  }

  init() async {
    setState(
      () {
        _shouldShowFaceOutline =
            (widget.ziggeo.recorderConfig)?.shouldShowFaceOutline ?? false;
        _isLiveStreaming =
            (widget.ziggeo.recorderConfig)?.isLiveStreaming ?? false;
        _shouldAutoStartRecording =
            (widget.ziggeo.recorderConfig)?.shouldAutoStartRecording ?? false;
        _startDelay = (widget.ziggeo.recorderConfig)?.startDelay.toString();
        _blurMode = (widget.ziggeo.recorderConfig)?.blurMode ?? false;
        _shouldSendImmediately =
            (widget.ziggeo.recorderConfig)?.shouldSendImmediately ?? false;
        _shouldDisableCameraSwitch =
            (widget.ziggeo.recorderConfig)?.shouldDisableCameraSwitch ?? false;
        _videoQuality = (widget.ziggeo.recorderConfig)?.videoQuality.toString();
        _facing = (widget.ziggeo.recorderConfig)?.facing.toString();
        _maxDurationRec =
            (widget.ziggeo.recorderConfig)?.maxDuration.toString();
        _shouldEnableCoverShot =
            (widget.ziggeo.recorderConfig)?.shouldEnableCoverShot ?? false;
        _shouldConfirmStopRecording =
            (widget.ziggeo.recorderConfig)?.shouldConfirmStopRecording ?? false;
        _isPausedMode = (widget.ziggeo.recorderConfig)?.isPausedMode ?? false;
        _titleText = (widget
                .ziggeo.recorderConfig?.stopRecordingConfirmationDialogConfig)
            ?.titleText;
        _mesText = (widget
                .ziggeo.recorderConfig?.stopRecordingConfirmationDialogConfig)
            ?.mesText;
        _posBtnText = (widget
                .ziggeo.recorderConfig?.stopRecordingConfirmationDialogConfig)
            ?.posBtnText;
        _negBtnText = (widget
                .ziggeo.recorderConfig?.stopRecordingConfirmationDialogConfig)
            ?.negBtnText;
      },
    );
  }
}
