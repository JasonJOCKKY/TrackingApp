import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    // Get Map Api
    if let apiKey = LoadMapKeys() {
        GMSServices.provideAPIKey(apiKey)
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

struct MapKeysData: Decodable {
    var ios_mapKey: String
}

func LoadMapKeys() -> String? {
    if let fileLocation = Bundle.main.url(forResource: "maps.keys", withExtension: "json") {
        do {
            let data = try Data(contentsOf: fileLocation)
            let jsonDecoder = JSONDecoder()
            let dataFromJSON = try jsonDecoder.decode(MapKeysData.self, from: data)
            
            return dataFromJSON.ios_mapKey;
        } catch {
            print(error)
            return nil
        }
    }
    
    return nil
}
