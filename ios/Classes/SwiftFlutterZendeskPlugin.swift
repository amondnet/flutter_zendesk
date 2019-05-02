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
        
        result(appId);
    } else if (  call.method == "setIdentity" ) {
        let arguments = call.arguments as! Dictionary<String, String>;
        let token = arguments["token"];

        var identity :Identity
        if ( token != nil ) {
            identity = Identity.createJwt(token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozLCJ1c2VybmFtZSI6Imtha2FvXzEwMzEwMTc5MjMiLCJleHAiOjE1NTY4NTA3NDcsImVtYWlsIjoiIiwib3JpZ19pYXQiOjE1NTY3NjQzNDd9.xTydw8wBaOyTIu74MG6WWr9iBz2hSnI-2JbsfyHo2qM");
        } else {
            identity = Identity.createAnonymous()
        }
        
        Zendesk.instance?.setIdentity(identity)
        result(true);
    } else if ( call.method == "createRequest" ) {
        let arguments = call.arguments as! Dictionary<String, Any>;
        let subject = arguments["subject"]! as! String;
        let requestDescription = arguments["requestDescription"]! as! String;
        let tags = arguments["tags"] as? Array<String>;
        
        let provider = ZDKRequestProvider()
                
        let request = ZDKCreateRequest()
        request.subject = subject
        request.requestDescription = requestDescription
        request.tags = tags
        provider.createRequest(request) { response, error in
            if ( response != nil ) {
                let _response = response as! ZDKDispatcherResponse
                result(_response.data);
            } else {
                let _error = error! as NSError;
                result([FlutterError( code: String(_error.code), message: _error.domain, details: _error.userInfo  )]);
            }
        }
    } else if ( call.method == "getAllRequests" ) {
        let provider = ZDKRequestProvider()
        
        provider.getAllRequests(callback: { (requets, error) in
            if ( requets != nil ) {
                let _requests = requets! as ZDKRequestsWithCommentingAgents
                
                let encoded = [
                    "commentingAgents": _requests.commentingAgents.map( {agent in agent.toJson() }),
                    "requests": _requests.requests.map( {request in request.toJson() }),
                ];
                result(encoded);
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
                result([FlutterError( code: String(_error.code), message: _error.domain, details: _error.userInfo  )]);
            }
        }
    } else {
        result(FlutterMethodNotImplemented);
    }
    //result("iOS " + UIDevice.current.systemVersion)
  }
}
