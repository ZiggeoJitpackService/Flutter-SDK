import 'package:ziggeo/common/base_config.dart';
import 'package:ziggeo/player/player_listener.dart';
import 'package:ziggeo/styles/player.dart';

class PlayerConfig extends BaseConfig {
  bool? shouldShowSubtitles;
  bool? isMuted;
  PlayerEventsListener? eventsListener;
  PlayerStyle? playerStyle;

  @override
  Map<String, dynamic> convertToMap() {
    var map = super.convertToMap();
    map["shouldShowSubtitles"] = shouldShowSubtitles;
    map["isMuted"] = isMuted;
    map["playerStyle"] = playerStyle?.convertToMap();
    return map;
  }

  static PlayerConfig convertFromMap(Map<String, dynamic> map) {
    var shouldShowSubtitles = map["shouldShowSubtitles"];
    var isMuted = map["isMuted"];
    var playerStyle = PlayerStyle.convertFromMap(map["playerStyle"]);
    return PlayerConfig(
      shouldShowSubtitles: shouldShowSubtitles,
      isMuted: isMuted,
      playerStyle: playerStyle,
    );
  }

  static PlayerConfig defaultPlayerConfig() {
    return PlayerConfig(
      shouldShowSubtitles: false,
      isMuted: false,
      playerStyle: PlayerStyle.defaultPlayerStyle(),
    );
  }

  PlayerConfig({
    this.shouldShowSubtitles = false,
    this.isMuted = false,
    this.playerStyle,
  });
}
