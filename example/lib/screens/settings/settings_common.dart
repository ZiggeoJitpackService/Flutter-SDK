import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ziggeo/file_selector/file_selector_config.dart';
import 'package:ziggeo/qr/qr_scanner_config.dart';
import 'package:ziggeo/uploading/uploading_config.dart';
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

  _CommonSettingsScreenState(this.ziggeo);

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return (_mediaType == null)
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
                              'tv_custom_video_mode',
                              style: TextStyle(fontSize: settings_text_size),
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
                              style: TextStyle(fontSize: settings_text_size),
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
                              style: TextStyle(fontSize: settings_text_size),
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
                              style: TextStyle(fontSize: settings_text_size),
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
                              style: TextStyle(fontSize: settings_text_size),
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
                            labelText:
                                localize.text('hint_lost_connection_action'),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextLocalized(
                              'hint_should_close_after_successful_scan',
                              style: TextStyle(fontSize: settings_text_size),
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
    await SharedPreferences.getInstance().then(
      (value) {
        setState(
          () {
            value.setBool(Utils.keyCustomPlayerMode, isCustomVideoSwitched);
            value.setBool(Utils.keyCustomCameraMode, isCustomCameraSwitched);
          },
        );
      },
    );
    ziggeo.qrScannerConfig = QrScannerConfig(
      shouldCloseAfterSuccessfulScan: _shouldCloseAfterSuccessfulScan,
    );
    ziggeo.uploadingConfig = UploadingConfig(
      shouldUseWifiOnly: _shouldUseWifiOnly,
      shouldTurnOffUploader: _shouldTurnOffUploader,
      syncInterval: (_syncInterval != null)
          ? int.parse(_syncInterval!)
          : (ziggeo.uploadingConfig?.syncInterval ??
              UploadingConfig.defaultSyncInterval),
      lostConnectionAction: (_lostConnectionAction != null)
          ? int.parse(_lostConnectionAction!)
          : (ziggeo.uploadingConfig?.lostConnectionAction ??
              UploadingConfig.UPLOADING_ERROR_ACTION_ERROR_NOTIFICATION),
    );
    ziggeo.fileSelectorConfig = FileSelectorConfig(
      shouldAllowMultipleSelection: _shouldAllowMultipleSelection,
      mediaType: (_mediaType != null)
          ? int.parse(_mediaType!)
          : (ziggeo.fileSelectorConfig?.mediaType ??
              FileSelectorConfig.videoMediaType),
    );
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
            if (value.getBool(Utils.keyCustomCameraMode) != null) {
              isCustomCameraSwitched =
                  value.getBool(Utils.keyCustomCameraMode) ?? false;
            }
            _shouldAllowMultipleSelection =
                ziggeo.fileSelectorConfig?.shouldAllowMultipleSelection ??
                    false;
            _mediaType = (ziggeo.fileSelectorConfig?.mediaType ??
                    FileSelectorConfig.videoMediaType)
                .toString();
            _syncInterval = (ziggeo.uploadingConfig?.syncInterval ??
                    UploadingConfig.defaultSyncInterval)
                .toString();
            _shouldUseWifiOnly =
                ziggeo.uploadingConfig?.shouldUseWifiOnly ?? false;
            _shouldTurnOffUploader =
                ziggeo.uploadingConfig?.shouldTurnOffUploader ?? false;
            _lostConnectionAction = (ziggeo
                        .uploadingConfig?.lostConnectionAction ??
                    UploadingConfig.UPLOADING_ERROR_ACTION_ERROR_NOTIFICATION)
                .toString();
            _shouldCloseAfterSuccessfulScan =
                ziggeo.qrScannerConfig?.shouldCloseAfterSuccessfulScan ?? false;
          },
        );
      },
    );
  }
}
