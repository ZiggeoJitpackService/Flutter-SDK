import ZiggeoMediaSwiftSDK
import Flutter
import Combine
import UIKit

public class SwiftVideoApiPlugin: NSObject, FlutterPlugin {

    var m_ziggeo: Ziggeo? = nil;

    init(ziggeo: Ziggeo){
        self.m_ziggeo = ziggeo;
    }

    public static func register(with registrar: FlutterPluginRegistrar) {
    }

    public static func registerZiggeo(registrar: FlutterPluginRegistrar, ziggeo: Ziggeo) {
        let channel = FlutterMethodChannel(name: "ziggeo_videos", binaryMessenger: registrar.messenger())
        let instance = SwiftVideoApiPlugin(ziggeo : ziggeo)
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
       if (call.method == "index") {
                if let args = call.arguments as? Dictionary<String, Any>,
                     let argsss = args as? Dictionary<String, Any>{
                     m_ziggeo?.videos.index(
                         argsss, callback: { array, error in
                               var recordings: String = "["

                               for item in array {
                                  let encoder = JSONEncoder()
                                  do {
                                      let modelData = try encoder.encode(item)
                                      let jsonString = String(data: modelData, encoding: .utf8)
                                      let resultItem = jsonString!.dropFirst().dropLast()
                                      recordings.append(jsonString!);
                                      recordings.append(",");
                                  } catch {
                                      print(error)
                                  }
                               }
                               var recordingsResult: String = recordings.dropLast() + "]";
                               let newResultString = recordingsResult.replacingOccurrences(of: "\\", with: "", options: .literal, range: nil)
                               result(newResultString);
                         }
                     );
                }
        } else
        if (call.method == "get") {
               if let args = call.arguments as? Dictionary<String, Any>,
                  let videoToken = args["videoToken"] as? String{
                      m_ziggeo?.videos.get(videoToken,
                          data: [:],
                          callback: { content, response, error in
                              let resultString = String(describing: content);
                              result(resultString);
                          });
                  }
        } else if (call.method == "getVideoUrl") {
               if let args = call.arguments as? Dictionary<String, Any>,
                  let videoToken = args["videoToken"] as? String{
                      result(m_ziggeo?.videos.getVideoUrl(videoToken));
                  }
        } else if (call.method == "getImageUrl") {
               if let args = call.arguments as? Dictionary<String, Any>,
                  let videoToken = args["videoToken"] as? String{
                      result(m_ziggeo?.videos.getImageUrl(videoToken));
                  }
        } else if (call.method == "update") {
               if let args = call.arguments as? Dictionary<String, Any>,
                  let data = args["data"] as? Dictionary<String, Any>{
                      m_ziggeo?.videos.update(
                      //todo token, data to model
                          "token",
                          data: data,
                          callback: { content, response, error in
                              let resultString = String(describing: content);
                              result(resultString);
                          });
                  }
        } else if (call.method == "destroy") {
               if let args = call.arguments as? Dictionary<String, Any>,
                  let videoToken = args["videoToken"] as? String{
                      m_ziggeo?.videos.destroy(videoToken,
                          callback: { content, response, error in
                              let resultString = String(describing: content);
                              result(resultString);
                          });
                  }
        } else if (call.method == "create") {
               if let args = call.arguments as? Dictionary<String, Any>,
                  let argsss = args as? Dictionary<String, Any>{
                      m_ziggeo?.videos.create(
                      //todo strUrl, data
                          "strUrl",
                          data: argsss,
                          callback: { content, response, error in
                              let resultString = String(describing: content);
                              result(resultString);
                          },
                          progress: {intOne, intTwo in
                          },
                          confirmCallback: {jsonObject, response, error in
                              let resultString = String(describing: jsonObject);
                              result(resultString);
                          });
                  }
        } else {
               result(FlutterError(code:"Not implemented Video", message:"Not implemented",details: ""))
        }
    }

}

extension ZiggeoMediaSwiftSDK.ContentModel:Encodable{

    public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(self.key, forKey: .key)
            try container.encode(self.title, forKey: .title)
            try container.encode(self.description, forKey: .description)
            try container.encode(self.stateString, forKey: .state_string)
            try container.encode(self.token, forKey: .token)
            try container.encode(self.date, forKey: .created)
            try container.encode(self.duration.roundToDecimal(2), forKey: .duration)

    }

    enum CodingKeys: String, CodingKey {
           case key
           case title
           case description
           case state_string
           case token
           case created
           case duration
    }
}

extension Double {
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}

