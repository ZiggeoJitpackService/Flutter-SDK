import 'package:ziggeo/common/base_config.dart';
import 'package:ziggeo/file_selector/file_selector_listener.dart';

class FileSelectorConfig extends BaseConfig {
  static const videoMediaType = 0x01;
  static const audioMediaType = 0x02;
  static const imageMediaType = 0x04;

  static const iosMovieMediaType = "public.movie";
  static const iosVideoMediaType = "public.video";
  static const iosAudioMediaType = "public.audio";
  static const iosImageMediaType = "public.image";

  var shouldAllowMultipleSelection = false;
  var mediaType = videoMediaType;

  FileSelectorEventsListener? eventsListener;

  FileSelectorConfig({
    this.shouldAllowMultipleSelection = false,
    this.mediaType = videoMediaType,
  });

  @override
  Map<String, dynamic> convertToMap() {
    var map = super.convertToMap();
    map["shouldAllowMultipleSelection"] = shouldAllowMultipleSelection;
    map["mediaType"] = mediaType;
    return map;
  }

  static FileSelectorConfig convertFromMap(Map<String, dynamic> map) {
    var shouldAllowMultipleSelection =
    (map["shouldAllowMultipleSelection"] is bool)
        ? map["shouldAllowMultipleSelection"]
        : map["shouldAllowMultipleSelection"] == 1;
    var mediaType = map["mediaType"];

    switch (map["mediaType"].toString()) {
      case iosVideoMediaType:
        {
          mediaType = videoMediaType;
          break;
        }
      case iosMovieMediaType:
        {
          mediaType = videoMediaType;
          break;
        }
      case iosAudioMediaType:
        {
          mediaType = audioMediaType;
          break;
        }
      case iosImageMediaType:
        {
          mediaType = imageMediaType;
          break;
        }
    }

    if (mediaType is List<dynamic>) {
      mediaType = videoMediaType;
    }

    return FileSelectorConfig(
      shouldAllowMultipleSelection: shouldAllowMultipleSelection,
      mediaType: mediaType,
    );
  }
}
