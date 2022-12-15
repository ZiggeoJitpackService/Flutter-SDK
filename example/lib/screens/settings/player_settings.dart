import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ziggeo/player/player_config.dart';
import 'package:ziggeo/styles/player.dart';
import 'package:ziggeo/ziggeo.dart';
import 'package:ziggeo_example/localization.dart';
import 'package:ziggeo_example/res/colors.dart';
import 'package:ziggeo_example/res/dimens.dart';
import 'package:ziggeo_example/utils/utils.dart';
import 'package:ziggeo_example/widgets/TextLocalized.dart';

import '../../localization.dart';

class PlayerSettingsScreen extends StatefulWidget {
  Ziggeo ziggeo;

  PlayerSettingsScreen(this.ziggeo);

  @override
  _PlayerSettingsScreenState createState() =>
      _PlayerSettingsScreenState(ziggeo);
}

class _PlayerSettingsScreenState extends State<PlayerSettingsScreen> {
  final Ziggeo ziggeo;
  AppLocalizations localize = AppLocalizations.instance;

  bool shouldShowSubtitles = false;
  bool isMuted = false;

  String? _controllerStyle;
  String? _textColor;
  String? _unplayedColor;
  String? _playedColor;
  String? _bufferedColor;
  String? _tintColor;

  late PlayerConfig config;

  _PlayerSettingsScreenState(this.ziggeo);

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
                        'hint_should_show_subtitles',
                        style: TextStyle(fontSize: message_text_size),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Switch(
                          activeColor: Color(primary),
                          value: shouldShowSubtitles,
                          onChanged: (value) {
                            setState(
                              () {
                                shouldShowSubtitles = value;
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
                        'hint_is_mute',
                        style: TextStyle(fontSize: message_text_size),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Switch(
                          activeColor: Color(primary),
                          value: isMuted,
                          onChanged: (value) {
                            setState(
                              () {
                                isMuted = value;
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    onChanged: (value) => _controllerStyle = value,
                    enabled: true,
                    initialValue: _controllerStyle,
                    style: null,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: localize.text('hint_controller_style'),
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) => _textColor = value,
                    enabled: true,
                    initialValue: _textColor,
                    style: null,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: localize.text('hint_text_color'),
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) => _playedColor = value,
                    enabled: true,
                    initialValue: _playedColor,
                    style: null,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: localize.text('hint_played_color'),
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) => _unplayedColor = value,
                    enabled: true,
                    initialValue: _unplayedColor,
                    style: null,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: localize.text('hint_unplayed_color'),
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) => _bufferedColor = value,
                    enabled: true,
                    initialValue: _bufferedColor,
                    style: null,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: localize.text('hint_buffered_color'),
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) => _tintColor = value,
                    enabled: true,
                    initialValue: _tintColor,
                    style: null,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: localize.text('hint_tint_color'),
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
    config = PlayerConfig();

    await SharedPreferences.getInstance().then(
      (value) {
        value.setBool(Utils.keyShouldShowSubtitles, shouldShowSubtitles);
        value.setBool(Utils.keyIsMuted, isMuted);
        value.setString(Utils.keyControllerStyle, _controllerStyle ?? "");
        value.setString(Utils.keyTextColor, _textColor ?? "");
        value.setString(Utils.keyUnplayedColor, _unplayedColor ?? "");
        value.setString(Utils.keyPlayedColor, _playedColor ?? "");
        value.setString(Utils.keyBufferedColor, _bufferedColor ?? "");
        value.setString(Utils.keyTintColor, _tintColor ?? "");
      },
    );
    config.isMuted = isMuted;
    config.shouldShowSubtitles = shouldShowSubtitles;
    ziggeo.playerStyle = PlayerStyle(
      controllerStyle:
          (_controllerStyle != null && _controllerStyle!.isNotEmpty)
              ? int.parse(_controllerStyle!)
              : (await widget.ziggeo.getPlayerStyle())?.controllerStyle,
      textColor: (_textColor != null && _textColor!.isNotEmpty)
          ? int.parse(_textColor!)
          : (await widget.ziggeo.getPlayerStyle())?.textColor,
      unplayedColor: (_unplayedColor != null && _unplayedColor!.isNotEmpty)
          ? int.parse(_unplayedColor!)
          : (await widget.ziggeo.getPlayerStyle())?.playedColor,
      playedColor: (_playedColor != null && _playedColor!.isNotEmpty)
          ? int.parse(_playedColor!)
          : (await widget.ziggeo.getPlayerStyle())?.unplayedColor,
      bufferedColor: (_bufferedColor != null && _bufferedColor!.isNotEmpty)
          ? int.parse(_bufferedColor!)
          : (await widget.ziggeo.getPlayerStyle())?.bufferedColor,
      tintColor: (_tintColor != null && _tintColor!.isNotEmpty)
          ? int.parse(_tintColor!)
          : (await widget.ziggeo.getPlayerStyle())?.tintColor,
    );
    ziggeo.playerConfig = config;
  }

  init() async {
    await SharedPreferences.getInstance().then(
      (value) {
        setState(
          () {
            if (value.getBool(Utils.keyShouldShowSubtitles) != null) {
              shouldShowSubtitles =
                  value.getBool(Utils.keyShouldShowSubtitles) ?? false;
            }
            if (value.getBool(Utils.keyIsMuted) != null) {
              isMuted = value.getBool(Utils.keyIsMuted) ?? false;
            }
            if (value.getString(Utils.keyControllerStyle) != null) {
              _controllerStyle =
                  value.getString(Utils.keyControllerStyle) ?? '';
            }
            if (value.getString(Utils.keyTextColor) != null) {
              _textColor = value.getString(Utils.keyTextColor) ?? '';
            }
            if (value.getString(Utils.keyUnplayedColor) != null) {
              _unplayedColor = value.getString(Utils.keyUnplayedColor) ?? '';
            }
            if (value.getString(Utils.keyPlayedColor) != null) {
              _playedColor = value.getString(Utils.keyPlayedColor) ?? '';
            }
            if (value.getString(Utils.keyBufferedColor) != null) {
              _bufferedColor = value.getString(Utils.keyBufferedColor) ?? '';
            }
            if (value.getString(Utils.keyTintColor) != null) {
              _tintColor = value.getString(Utils.keyTintColor) ?? '';
            }
          },
        );
      },
    );
  }
}
