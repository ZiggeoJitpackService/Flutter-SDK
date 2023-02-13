import Flutter
import Combine
import UIKit
import ZiggeoMediaSwiftSDK

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
                                      recordings.append(jsonString!);
                                      recordings.append(",");
                                  } catch {
                                      print(error)
                                  }
                               }
                               var recordingsResult: String = recordings.dropLast() + "]";
                               let newResultString = recordingsResult.clearJson()
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
                  let data = args["mapData"] as? Dictionary<String, Any> {
                      if(data != nil){
                            let token = data["token"] as! String
                            m_ziggeo?.videos.update(
                                 token,
                                 data: data,
                                 callback: { content, response, error in
                                  var resultItem: String = ""
                                  let encoder = JSONEncoder()
                                  do {
                                      let modelData = try encoder.encode(content)
                                      let jsonString = String(data: modelData, encoding: .utf8)
                                      resultItem.append(jsonString!)
                                  } catch {
                                      print(error)
                                  }
                                 result(resultItem.clearJson());
                            });
                      }
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
                  let params = args["data"] as? Dictionary<String, Any>,
                  let path = args["path"] as? String{
                         m_ziggeo?.videos.create(
                          path,
                          data: params,
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

    func unClearJson(text: String) -> String {
        return text.replacingOccurrences(of: "\"", with: "\\\"", options: .literal, range: nil);
    }

    func convertToDictionary(text: String) -> [String: String]? {
        let text = unClearJson(text: text)
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

}

extension String{
   public func clearJson() -> String{
       return self.replacingOccurrences(of: "\\", with: "", options: .literal, range: nil);
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
            try container.encode(self.duration, forKey: .duration)
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
                               var recordings: String = "["
                               for item in array {
                                  let encoder = JSONEncoder()
                                  do {
                                      let modelData = try encoder.encode(item)
                                      let jsonString = String(data: modelData, encoding: .utf8)
                                      recordings.append(jsonString!);
                                      recordings.append(",");
                                  } catch {
                                      print(error)
                                  }
                               }
                               var recordingsResult: String = recordings.dropLast() + "]";
                               let newResultString = recordingsResult.clearJson()
                               result(newResultString);
                         }
                     );
                }
        } else if (call.method == "get") {
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
                  let data = args["mapData"] as? Dictionary<String, Any> {
                      if(data != nil){
                            let token = data["token"] as! String
                            m_ziggeo?.audios.update(
                                 token,
                                 data: data,
                                 callback: { content, response, error in
                                  var resultItem: String = ""
                                  let encoder = JSONEncoder()
                                  do {
                                      let modelData = try encoder.encode(content)
                                      let jsonString = String(data: modelData, encoding: .utf8)
                                      resultItem.append(jsonString!)
                                  } catch {
                                      print(error)
                                  }
                                 result(resultItem.clearJson());
                            });
                      }
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
                  let params = args["data"] as? Dictionary<String, Any>,
                  let path = args["path"] as? String{
                      m_ziggeo?.audios.create(
                          path,
                          data: params,
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

public class SwiftImageApiPlugin: NSObject, FlutterPlugin {

    var m_ziggeo: Ziggeo? = nil;

    init(ziggeo: Ziggeo){
        self.m_ziggeo = ziggeo;
    }

    public static func register(with registrar: FlutterPluginRegistrar) {
    }

    public static func registerZiggeo(registrar: FlutterPluginRegistrar, ziggeo: Ziggeo) {
        let channel = FlutterMethodChannel(name: "ziggeo_images", binaryMessenger: registrar.messenger())
        let instance = SwiftImageApiPlugin(ziggeo : ziggeo)
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
       if (call.method == "index") {
                if let args = call.arguments as? Dictionary<String, Any>,
                     let argsss = args as? Dictionary<String, Any>{
                     m_ziggeo?.images.index(
                         argsss, callback: { array, error in
                               var recordings: String = "["
                               for item in array {
                                  let encoder = JSONEncoder()
                                  do {
                                      let modelData = try encoder.encode(item)
                                      let jsonString = String(data: modelData, encoding: .utf8)
                                      recordings.append(jsonString!);
                                      recordings.append(",");
                                  } catch {
                                      print(error)
                                  }
                               }
                               var recordingsResult: String = recordings.dropLast() + "]";
                               let newResultString = recordingsResult.clearJson()
                               result(newResultString);
                         }
                     );
                }
        } else
        if (call.method == "get") {
               if let args = call.arguments as? Dictionary<String, Any>,
                  let videoToken = args["tokenOrKey"] as? String{
                      m_ziggeo?.images.get(videoToken,
                          data: [:],
                          callback: { content, response, error in
                              let resultString = String(describing: content);
                              result(resultString);
                          });
                  }
        } else if (call.method == "update") {
               if let args = call.arguments as? Dictionary<String, Any>,
                  let data = args["mapData"] as? Dictionary<String, Any> {
                      if(data != nil){
                            let token = data["token"] as! String
                            m_ziggeo?.images.update(
                                 token,
                                 data: data,
                                 callback: { content, response, error in
                                  var resultItem: String = ""
                                  let encoder = JSONEncoder()
                                  do {
                                      let modelData = try encoder.encode(content)
                                      let jsonString = String(data: modelData, encoding: .utf8)
                                      resultItem.append(jsonString!)
                                  } catch {
                                      print(error)
                                  }
                                 result(resultItem.clearJson());
                            });
                      }
                  }
        } else if (call.method == "destroy") {
               if let args = call.arguments as? Dictionary<String, Any>,
                  let videoToken = args["tokenOrKey"] as? String{
                      m_ziggeo?.images.destroy(videoToken,
                          callback: { content, response, error in
                              let resultString = String(describing: content);
                              result(resultString);
                          });
                  }
        } else if (call.method == "create") {
               if let args = call.arguments as? Dictionary<String, Any>,
                  let params = args["data"] as? Dictionary<String, Any>,
                  let path = args["path"] as? String{
                         m_ziggeo?.images.create(
                          path,
                          data: params,
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
        } else if (call.method == "getImageUrl") {
               if let args = call.arguments as? Dictionary<String, Any>,
                  let tokenOrKey = args["tokenOrKey"] as? String{
                      result(m_ziggeo?.images.getImageUrl(tokenOrKey));
             }
        }
        else {
               result(FlutterError(code:"Not implemented Images", message:"Not implemented",details: ""))
        }
    }

}

public class SwiftStreamApiPlugin: NSObject, FlutterPlugin {

    var m_ziggeo: Ziggeo? = nil;

    init(ziggeo: Ziggeo){
        self.m_ziggeo = ziggeo;
    }

    public static func register(with registrar: FlutterPluginRegistrar) {
    }

    public static func registerZiggeo(registrar: FlutterPluginRegistrar, ziggeo: Ziggeo) {
        let channel = FlutterMethodChannel(name: "ziggeo_streams", binaryMessenger: registrar.messenger())
        let instance = SwiftStreamApiPlugin(ziggeo : ziggeo)
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
       if (call.method == "accept") {
                if let args = call.arguments as? Dictionary<String, Any>,
                     let videoToken = args["videoToken"] as? String,
                     let streamToken = args["streamToken"] as? String{
                     //todo create method
                }
        } else if (call.method == "destroy") {
               if let args = call.arguments as? Dictionary<String, Any>,
                  let videoToken = args["videoToken"] as? String,
                  let streamToken = args["streamToken"] as? String{
                     //todo create method
                  }
        } else if (call.method == "create") {
               if let args = call.arguments as? Dictionary<String, Any>,
                  let videoToken = args["videoToken"] as? String,
                  let path = args["path"] as? String,
                  let params = args["args"] as? Dictionary<String, String>{
                     //todo create method
                  }
        } else {
               result(FlutterError(code:"Not implemented Stream", message:"Not implemented",details: ""))
        }
    }

}


