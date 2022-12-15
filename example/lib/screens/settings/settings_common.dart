import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ziggeo/recorder/recorder_config.dart';
import 'package:ziggeo/ziggeo.dart';
import 'package:ziggeo_example/localization.dart';
import 'package:ziggeo_example/res/colors.dart';
import 'package:ziggeo_example/res/dimens.dart';
import 'package:ziggeo_example/utils/utils.dart';
import 'package:ziggeo_example/widgets/TextLocalized.dart';

import '../../localization.dart';

class CommonSettingsScreen extends StatefulWidget {
  Ziggeo ziggeo;

  CommonSettingsScreen(this.ziggeo);

  @override
  _CommonSettingsScreenState createState() =>
      _CommonSettingsScreenState(ziggeo);
}

class _CommonSettingsScreenState extends State<CommonSettingsScreen> {
  final Ziggeo ziggeo;
  AppLocalizations localize = AppLocalizations.instance;

  bool isCustomVideoSwitched = false;
  bool isCustomCameraSwitched = false;

  bool _shouldAllowMultipleSelection = false;
  String? _mediaType;
  String? _syncInterval;
  bool _shouldUseWifiOnly = false;
  bool _shouldTurnOffUploader = false;
  String? _lostConnectionAction;
  bool _shouldCloseAfterSuccessfulScan = false;

  late RecorderConfig config;

  _CommonSettingsScreenState(this.ziggeo);

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
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextLocalized(
                        'tv_custom_video_mode',
                        style: TextStyle(fontSize: message_text_size),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Switch(
                          activeColor: Color(primary),
                          value: isCustomVideoSwitched,
                          onChanged: (value) {
                            setState(
                              () {
                                isCustomVideoSwitched = value;
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
                        'tv_custom_camera_mode',
                        style: TextStyle(fontSize: message_text_size),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Switch(
                          activeColor: Color(primary),
                          value: isCustomCameraSwitched,
                          onChanged: (value) {
                            setState(
                              () {
                                isCustomCameraSwitched = value;
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
                        'hint_should_allow_multiple_selection',
                        style: TextStyle(fontSize: message_text_size),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Switch(
                          activeColor: Color(primary),
                          value: _shouldAllowMultipleSelection,
                          onChanged: (value) {
                            setState(
                              () {
                                _shouldAllowMultipleSelection = value;
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    onChanged: (value) => _mediaType = value,
                    enabled: true,
                    initialValue: _mediaType,
                    style: null,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: localize.text('hint_media_type'),
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) => _syncInterval = value,
                    enabled: true,
                    initialValue: _syncInterval,
                    style: null,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: localize.text('hint_sync_interval'),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextLocalized(
                        'hint_should_use_wifi_only',
                        style: TextStyle(fontSize: message_text_size),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Switch(
                          activeColor: Color(primary),
                          value: _shouldUseWifiOnly,
                          onChanged: (value) {
                            setState(
                              () {
                                _shouldUseWifiOnly = value;
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
                        'hint_should_turn_off_uploader',
                        style: TextStyle(fontSize: message_text_size),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Switch(
                          activeColor: Color(primary),
                          value: _shouldTurnOffUploader,
                          onChanged: (value) {
                            setState(
                              () {
                                _shouldTurnOffUploader = value;
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    onChanged: (value) => _lostConnectionAction = value,
                    enabled: true,
                    initialValue: _lostConnectionAction,
                    style: null,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: localize.text('hint_lost_connection_action'),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextLocalized(
                        'hint_should_close_after_successful_scan',
                        style: TextStyle(fontSize: message_text_size),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Switch(
                          activeColor: Color(primary),
                          value: _shouldCloseAfterSuccessfulScan,
                          onChanged: (value) {
                            setState(
                              () {
                                _shouldCloseAfterSuccessfulScan = value;
                              },
                            );
                          },
                        ),
                      ),
                    ],
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
      value.setBool(Utils.keyCustomPlayerMode, isCustomVideoSwitched);
      value.setBool(Utils.keyCustomCameraMode, isCustomCameraSwitched);
      value.setBool(
          Utils.keyShouldAllowMultipleSelection, _shouldAllowMultipleSelection);
      value.setString(Utils.keyMediaType, _mediaType ?? '');
      value.setString(Utils.keySyncInterval, _syncInterval ?? '');
      value.setBool(Utils.keyShouldUseWifiOnly, _shouldUseWifiOnly);
      value.setBool(Utils.keyShouldTurnOffUploader, _shouldTurnOffUploader);
      value.setString(
          Utils.keyLostConnectionAction, _lostConnectionAction ?? '');
      value.setBool(Utils.keyShouldCloseAfterSuccessfulScan,
          _shouldCloseAfterSuccessfulScan);
    });
    // if (startDelay != null) {
    //   config.startDelay = int.parse(startDelay!);
    //   ziggeo.recorderConfig = config;
    // }
    // if (isBlurSwitched != null) {
    //   config.blurMode = isBlurSwitched;
    //   ziggeo.recorderConfig = config;
    // }
  }

  init() async {
    await SharedPreferences.getInstance().then(
      (value) {
        setState(
          () {
            if (value.getBool(Utils.keyCustomPlayerMode) != null) {
              isCustomVideoSwitched =
                  value.getBool(Utils.keyCustomPlayerMode) ?? false;
            }
            if (value.getBool(Utils.keyCustomPlayerMode) != null) {
              isCustomCameraSwitched =
                  value.getBool(Utils.keyCustomCameraMode) ?? false;
            }
            if (value.getBool(Utils.keyShouldAllowMultipleSelection) != null) {
              _shouldAllowMultipleSelection =
                  value.getBool(Utils.keyShouldAllowMultipleSelection) ?? false;
            }
            if (value.getString(Utils.keyMediaType) != null) {
              _mediaType = value.getString(Utils.keyMediaType) ?? "";
            }
            if (value.getString(Utils.keySyncInterval) != null) {
              _syncInterval = value.getString(Utils.keySyncInterval) ?? "";
            }
            if (value.getBool(Utils.keyShouldUseWifiOnly) != null) {
              _shouldUseWifiOnly =
                  value.getBool(Utils.keyShouldUseWifiOnly) ?? false;
            }
            if (value.getBool(Utils.keyShouldTurnOffUploader) != null) {
              _shouldTurnOffUploader =
                  value.getBool(Utils.keyShouldTurnOffUploader) ?? false;
            }
            if (value.getString(Utils.keyLostConnectionAction) != null) {
              _lostConnectionAction =
                  value.getString(Utils.keyLostConnectionAction) ?? "";
            }
            if (value.getBool(Utils.keyShouldCloseAfterSuccessfulScan) !=
                null) {
              _shouldCloseAfterSuccessfulScan =
                  value.getBool(Utils.keyShouldCloseAfterSuccessfulScan) ??
                      false;
            }
          },
        );
      },
    );
  }
}
