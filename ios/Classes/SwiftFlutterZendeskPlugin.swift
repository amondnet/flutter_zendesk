import Flutter
import UIKit
import ZendeskSDK
import ZendeskCoreSDK
import ZendeskProviderSDK

public class SwiftFlutterZendeskPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "net.amond.flutter_zendesk", binaryMessenger: registrar.messenger(), codec: FlutterJSONMethodCodec())
    let instance = SwiftFlutterZendeskPlugin()
    
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if ( call.method == "initialize" ) {
        let arguments = call.arguments as! Dictionary<String, String>;
        let appId = arguments["appId"]!;
        let clientId = arguments["clientId"]!;
        let zendeskUrl = arguments["zendeskUrl"]!;
        
        Zendesk.initialize(appId: appId, clientId: clientId, zendeskUrl: zendeskUrl);
        Support.initialize(withZendesk: Zendesk.instance)
        result(Zendesk.instance);
    } else if ( call.method == "createRequest" ) {
        let provider = ZDKRequestProvider()

        let request = ZDKCreateRequest()
        request.subject = "My printer is on fire!"
        request.requestDescription = "The smoke is very colorful."
        request.tags = ["printer", "fire"]
        provider.createRequest(request) { resultId, error in
            if ( resultId != nil ) {
                result(resultId);
            } else {
                let _error = error! as NSError;
                result([FlutterError( code: String(_error.code), message: _error.domain, details: _error.userInfo  )]);
            }
        }
    } else if ( call.method == "getAllRequests" ) {
        let provider = ZDKRequestProvider()
        
        provider.getAllRequests(callback: { (requets, error) in
            if ( requets != nil ) {
                result(requets);
            } else {
                let _error = error! as NSError;
                result([FlutterError( code: String(_error.code), message: _error.domain, details: _error.userInfo  )]);
            }
        });
    } else if ( call.method == "getArticlesForSectionId") {
        let arguments = call.arguments as! Dictionary<String, String>;

        let helpCenterProvider = ZDKHelpCenterProvider();
        let sectionId = arguments["sectionId"];
        helpCenterProvider.getArticlesWithSectionId(sectionId) { articles, error  in
            if ( articles != nil ) {
                result(articles);
            } else {
                let _error = error! as NSError;
                result([FlutterError( code: String(_error.code), message: _error.domain, details: _error.userInfo  )]);
            }
        }
    } else {
        result(FlutterMethodNotImplemented);
    }
    result("iOS " + UIDevice.current.systemVersion)
  }
}
