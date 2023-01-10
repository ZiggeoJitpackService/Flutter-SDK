import 'package:flutter/material.dart';
import 'package:ziggeo/player/player_config.dart';
import 'package:ziggeo/styles/player.dart';
import 'package:ziggeo/ziggeo.dart';
import 'package:ziggeo_example/localization.dart';
import 'package:ziggeo_example/res/colors.dart';
import 'package:ziggeo_example/res/dimens.dart';
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
    return (_controllerStyle == null)
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
    config.isMuted = isMuted;
    config.shouldShowSubtitles = shouldShowSubtitles;
    config.playerStyle = PlayerStyle(
      controllerStyle: (_controllerStyle != null &&
              _controllerStyle!.isNotEmpty &&
              !_controllerStyle!.contains("null"))
          ? int.parse(_controllerStyle!.trim())
          : (await widget.ziggeo.getPlayerStyle())?.controllerStyle,
      textColor: (_textColor != null &&
              _textColor!.isNotEmpty &&
              !_textColor!.contains("null"))
          ? int.parse(_textColor!.trim())
          : (await widget.ziggeo.getPlayerStyle())?.textColor,
      unplayedColor: (_unplayedColor != null &&
              _unplayedColor!.isNotEmpty &&
              !_unplayedColor!.contains("null"))
          ? int.parse(_unplayedColor!.trim())
          : (await widget.ziggeo.getPlayerStyle())?.playedColor,
      playedColor: (_playedColor != null &&
              _playedColor!.isNotEmpty &&
              !_playedColor!.contains("null"))
          ? int.parse(_playedColor!.trim())
          : (await widget.ziggeo.getPlayerStyle())?.unplayedColor,
      bufferedColor: (_bufferedColor != null &&
              _bufferedColor!.isNotEmpty &&
              !_bufferedColor!.contains("null"))
          ? int.parse(_bufferedColor!.trim())
          : (await widget.ziggeo.getPlayerStyle())?.bufferedColor,
      tintColor: (_tintColor != null &&
              _tintColor!.isNotEmpty &&
              !_tintColor!.contains("null"))
          ? int.parse(_tintColor!.trim())
          : (await widget.ziggeo.getPlayerStyle())?.tintColor,
    );
    ziggeo.playerStyle = config.playerStyle;
    ziggeo.playerConfig = config;
  }

  init() async {
    setState(
      () {
        var value = widget.ziggeo.playerConfig?.playerStyle;
        shouldShowSubtitles =
            (widget.ziggeo.playerConfig)?.shouldShowSubtitles ?? false;
        isMuted = (widget.ziggeo.playerConfig)?.isMuted ?? false;
        _controllerStyle = (value)?.controllerStyle.toString();
        _textColor = (value)?.textColor.toString();
        _unplayedColor = (value)?.unplayedColor.toString();
        _playedColor = (value)?.playedColor.toString();
        _bufferedColor = (value)?.bufferedColor.toString();
        _tintColor = (value)?.tintColor.toString();
      },
    );
  }
}
