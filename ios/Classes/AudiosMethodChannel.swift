import ZiggeoMediaSwiftSDK
import Flutter
import Combine
import UIKit

public class SwiftAudioApiPlugin: NSObject, FlutterPlugin {

    var m_ziggeo: Ziggeo? = nil;

    init(ziggeo: Ziggeo){
        self.m_ziggeo = ziggeo;
    }

    public static func register(with registrar: FlutterPluginRegistrar) {
    }

    public static func registerZiggeo(registrar: FlutterPluginRegistrar, ziggeo: Ziggeo) {
        let channel = FlutterMethodChannel(name: "ziggeo_audios", binaryMessenger: registrar.messenger())
        let instance = SwiftAudioApiPlugin(ziggeo : ziggeo)
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
       if (call.method == "index") {
                if let args = call.arguments as? Dictionary<String, Any>,
                     let argsss = args as? Dictionary<String, Any>{
                     m_ziggeo?.audios.index(
                         argsss, callback: { array, error in
                               var recordings: [String] = []
                               for item in array {
                                  let itemString = item.encodeToString();
//                                   let itemStringST = String(describing: itemString);
                                  recordings.append(itemString);
                               }
                               let resultString = String(describing: recordings);
                               result(resultString);
                         }
                     );
                } else {
                     m_ziggeo?.audios.index(
                         [:], callback: { array, error in
                               var recordings: [String] = []
                               for item in array {
                                  let itemString = item.encodeToString();
//                                   let itemStringST = String(describing: itemString);
                                  recordings.append(itemString);
                               }
                               let resultString = String(describing: recordings);
                               result(resultString);
                         }
                     );
                }
        } else
        if (call.method == "get") {
               if let args = call.arguments as? Dictionary<String, Any>,
                  let videoToken = args["tokenOrKey"] as? String{
                      m_ziggeo?.audios.get(videoToken,
                          data: [:],
                          callback: { content, response, error in
                              let resultString = String(describing: content);
                              result(resultString);
                          });
                  }
        } else if (call.method == "update") {
               if let args = call.arguments as? Dictionary<String, Any>,
                  let data = args["data"] as? Dictionary<String, Any>{
                      m_ziggeo?.audios.update(
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
                  let videoToken = args["tokenOrKey"] as? String{
                      m_ziggeo?.audios.destroy(videoToken,
                          callback: { content, response, error in
                              let resultString = String(describing: content);
                              result(resultString);
                          });
                  }
        } else if (call.method == "create") {
               if let args = call.arguments as? Dictionary<String, Any>,
                  let argsss = args as? Dictionary<String, Any>{
                      m_ziggeo?.audios.create(
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
               result(FlutterError(code:"Not implemented Audio", message:"Not implemented",details: ""))
        }
    }

}

extension Encodable {
    func encoded() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}

extension Data {
    func decoded<T: Decodable>() throws -> T {
        return try JSONDecoder().decode(T.self, from: self)
    }
}

extension ZiggeoMediaSwiftSDK.ContentModel{

//     public func encode() -> [String: Any]{
//
//         var json: [String: Any] = [:]
//
//         json["key"] = self.key
//         json["title"] = self.title
//         json["description"] = self.description
//         json["state_string"] = self.stateString
//         json["token"] = self.token
//         json["created"] = self.date
//         json["duration"] = self.duration
//
//         return json;
//     }


//        public func encodeData(encoder: JSONEncoder):String -> {
//
//             var container = encoder.container(keyedBy: CodingKeys.self)
//             try container.encode(self.key, forKey: .key) // Might want to make sure that the name is not nil here
//             try container.encode(self.title, forKey: .title)
//             try container.encode(self.description, forKey: .description)
//             try container.encode(self.stateString, forKey: .state_string)
//             try container.encode(self.token, forKey: .token)
//             try container.encode(self.date, forKey: .created)
//             try container.encode(self.duration, forKey: .duration)
//
//             return container;
//         }

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

