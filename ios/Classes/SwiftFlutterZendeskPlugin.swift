import Flutter
import UIKit
import ZendeskSDK
import ZendeskCoreSDK
import ZendeskProviderSDK

public class SwiftFlutterZendeskPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "net.amond.flutter_zendesk", binaryMessenger: registrar.messenger())
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
        let identity = Identity.createAnonymous()
        Zendesk.instance?.setIdentity(identity)
        result(appId);
    } else if ( call.method == "createRequest" ) {
        let provider = ZDKRequestProvider()

        let request = ZDKCreateRequest()
        request.subject = "My printer is on fire!"
        request.requestDescription = "The smoke is very colorful."
        request.tags = ["printer", "fire"]
        provider.createRequest(request) { response, error in
            if ( response != nil ) {
                let _response = response as! ZDKDispatcherResponse
                result(_response.data);
            } else {
                let _error = error! as NSError;
                result(FlutterError( code: String(_error.code), message: _error.domain, details: _error.userInfo  ));
            }
        }
    } else if ( call.method == "getAllRequests" ) {
        let provider = ZDKRequestProvider()
        
        provider.getAllRequests(callback: { (requets, error) in
            if ( requets != nil ) {
                result(requets);
            } else {
                let _error = error! as NSError;
                result(FlutterError( code: String(_error.code), message: _error.domain, details: _error.userInfo  ));
            }
        });
    } else if ( call.method == "getArticlesForSectionId") {
        let arguments = call.arguments as! Dictionary<String, String>;

        let helpCenterProvider = ZDKHelpCenterProvider();
        let sectionId = arguments["sectionId"];
        helpCenterProvider.getArticlesWithSectionId(sectionId) { articles, error  in
            if ( articles != nil ) {
                let items = articles! as! Array<ZDKHelpCenterArticle>

                let res = items.map( {article in
                    ["article_details": article.article_details,
                     "identifier": article.identifier,
                     "section_id": article.section_id,
                     "title": article.title,
                     "body": article.body,
                     "author_name": article.author_name,
                     "author_id": article.author_id,
                     "articleParents": article.articleParents,
                     "created_at": article.created_at.timeIntervalSince1970,
                     "position": article.position,
                     "outdated": article.outdated,
                     "voteSum": article.voteSum,
                     "voteCount": article.voteCount,
                     "locale": article.locale,
                     "labelNames": article.labelNames,
                     "htmlUrl": article.htmlUrl
                    ]
                });
                
                result([
                    "articles": res]);
            } else {
                let _error = error! as NSError;
                result(FlutterError( code: String(_error.code), message: _error.domain, details: _error.userInfo  ));
            }
        }
    } else {
        result(FlutterMethodNotImplemented);
    }
    //result("iOS " + UIDevice.current.systemVersion)
  }
}
