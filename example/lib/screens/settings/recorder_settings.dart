import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ziggeo/recorder/recorder_config.dart';
import 'package:ziggeo/ziggeo.dart';
import 'package:ziggeo_example/localization.dart';
import 'package:ziggeo_example/res/dimens.dart';
import 'package:ziggeo_example/utils/utils.dart';
import 'package:ziggeo_example/widgets/TextLocalized.dart';
import 'package:ziggeo_example/res/colors.dart';

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
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(common_margin),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: btn_qr_height),
              child:
              ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextLocalized(
                        'hint_should_show_face_outline',
                        style: TextStyle(fontSize: message_text_size),
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
                        style: TextStyle(fontSize: message_text_size),
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
                        style: TextStyle(fontSize: message_text_size),
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
                        style: TextStyle(fontSize: message_text_size),
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
                        style: TextStyle(fontSize: message_text_size),
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
                        style: TextStyle(fontSize: message_text_size),
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
                        style: TextStyle(fontSize: message_text_size),
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
                        style: TextStyle(fontSize: message_text_size),
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
                        style: TextStyle(fontSize: message_text_size),
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
                    style: null,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: localize.text('hint_title_text'),
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) => _mesText = value,
                    enabled: true,
                    initialValue: _mesText,
                    style: null,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: localize.text('hint_mes_text'),
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) => _posBtnText = value,
                    enabled: true,
                    initialValue: _posBtnText,
                    style: null,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: localize.text('hint_pos_btn_text'),
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) => _negBtnText = value,
                    enabled: true,
                    initialValue: _negBtnText,
                    style: null,
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
                child: RaisedButton(
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

    await SharedPreferences.getInstance().then((value) {
      value.setBool(Utils.keyShouldShowFaceOutline, _shouldShowFaceOutline);
      value.setBool(Utils.keyIsLiveStreaming, _isLiveStreaming);
      value.setBool(
          Utils.keyShouldAutoStartRecording, _shouldAutoStartRecording);
      value.setString(Utils.keyStartDelay, _startDelay ?? '');
      value.setBool(Utils.keyBlurMode, _blurMode);
      value.setBool(Utils.keyShouldSendImmediately, _shouldSendImmediately);
      value.setBool(
          Utils.keyShouldDisableCameraSwitch, _shouldDisableCameraSwitch);
      value.setString(Utils.keyVideoQuality, _videoQuality ?? '');
      value.setString(Utils.keyFacing, _facing ?? '');
      value.setString(Utils.keyMaxDurationRec, _maxDurationRec ?? '');
      value.setBool(Utils.keyShouldEnableCoverShot, _shouldEnableCoverShot);
      value.setBool(
          Utils.keyShouldConfirmStopRecording, _shouldConfirmStopRecording);
      value.setBool(Utils.keyIsPausedMode, _isPausedMode);
      value.setString(Utils.keyTitleText, _titleText ?? '');
      value.setString(Utils.keyMesText, _mesText ?? '');
      value.setString(Utils.keyPosBtnText, _posBtnText ?? '');
      value.setString(Utils.keyNegBtnText, _negBtnText ?? '');
    });
    if (_startDelay != null) {
      config.startDelay = int.parse(_startDelay!);
    }
    config.blurMode = _blurMode;
    ziggeo.recorderConfig = config;
  }

  init() async {
    await SharedPreferences.getInstance().then(
          (value) {
        setState(
              () {
            if (value.getBool(Utils.keyShouldShowFaceOutline) != null) {
              _shouldShowFaceOutline =
                  value.getBool(Utils.keyShouldShowFaceOutline) ?? false;
            }
            if (value.getBool(Utils.keyIsLiveStreaming) != null) {
              _isLiveStreaming =
                  value.getBool(Utils.keyIsLiveStreaming) ?? false;
            }
            if (value.getBool(Utils.keyShouldAutoStartRecording) != null) {
              _shouldAutoStartRecording =
                  value.getBool(Utils.keyShouldAutoStartRecording) ?? false;
            }
            if (value.getBool(Utils.keyStartDelay) != null) {
              _startDelay = value.getString(Utils.keyStartDelay) ?? '';
            }
            if (value.getBool(Utils.keyBlurMode) != null) {
              _blurMode = value.getBool(Utils.keyBlurMode) ?? false;
            }
            if (value.getBool(Utils.keyShouldSendImmediately) != null) {
              _shouldSendImmediately =
                  value.getBool(Utils.keyShouldSendImmediately) ?? false;
            }
            if (value.getBool(Utils.keyShouldDisableCameraSwitch) != null) {
              _shouldDisableCameraSwitch =
                  value.getBool(Utils.keyShouldDisableCameraSwitch) ?? false;
            }
            if (value.getBool(Utils.keyVideoQuality) != null) {
              _videoQuality = value.getString(Utils.keyVideoQuality) ?? '';
            }
            if (value.getBool(Utils.keyFacing) != null) {
              _facing = value.getString(Utils.keyFacing) ?? '';
            }
            if (value.getBool(Utils.keyMaxDurationRec) != null) {
              _maxDurationRec = value.getString(Utils.keyMaxDurationRec) ?? '';
            }
            if (value.getBool(Utils.keyShouldEnableCoverShot) != null) {
              _shouldEnableCoverShot =
                  value.getBool(Utils.keyShouldEnableCoverShot) ?? false;
            }
            if (value.getBool(Utils.keyShouldConfirmStopRecording) != null) {
              _shouldConfirmStopRecording =
                  value.getBool(Utils.keyShouldConfirmStopRecording) ?? false;
            }
            if (value.getBool(Utils.keyIsPausedMode) != null) {
              _isPausedMode = value.getBool(Utils.keyIsPausedMode) ?? false;
            }
            if (value.getBool(Utils.keyTitleText) != null) {
              _titleText = value.getString(Utils.keyTitleText) ?? '';
            }
            if (value.getBool(Utils.keyMesText) != null) {
              _mesText = value.getString(Utils.keyMesText) ?? '';
            }
            if (value.getBool(Utils.keyPosBtnText) != null) {
              _posBtnText = value.getString(Utils.keyPosBtnText) ?? '';
            }
            if (value.getBool(Utils.keyNegBtnText) != null) {
              _negBtnText = value.getString(Utils.keyNegBtnText) ?? '';
            }
          },
        );
      },
    );
  }
}
