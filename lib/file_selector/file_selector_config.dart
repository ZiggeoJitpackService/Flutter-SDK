import 'package:ziggeo/common/base_config.dart';
import 'package:ziggeo/file_selector/file_selector_listener.dart';

class FileSelectorConfig extends BaseConfig {
  static const videoMediaType = 0x01;
  static const audioMediaType = 0x02;
  static const imageMediaType = 0x04;

  var shouldAllowMultipleSelection = false;
  var mediaType = [videoMediaType];

  FileSelectorEventsListener? eventsListener;

  FileSelectorConfig({
    this.shouldAllowMultipleSelection = false,
    this.mediaType = const [videoMediaType],
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
        map["shouldAllowMultipleSelection"] ?? false;
    var mediaType = map["mediaType"];

    print("mediaType");
    print(mediaType);

    return FileSelectorConfig(
      shouldAllowMultipleSelection: shouldAllowMultipleSelection,
      mediaType: [mediaType],
    );
  }
}
