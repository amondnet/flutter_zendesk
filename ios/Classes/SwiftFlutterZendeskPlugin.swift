import Flutter
import UIKit
import ZendeskSDK
import ZendeskCoreSDK
import ZendeskProviderSDK

@objc public class SwiftFlutterZendeskPlugin: NSObject, FlutterPlugin {
    private var aObjNavi: UINavigationController?
    private var requestScreen: UIViewController?
    
    static var app: FlutterAppDelegate?;
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "net.amond.flutter_zendesk", binaryMessenger: registrar.messenger())
    
    let instance = SwiftFlutterZendeskPlugin()
    
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
  
    
    public static func setApplication(_ application: FlutterAppDelegate) {
        self.app = application;
    }
    
    public static func getApplication( ) -> FlutterAppDelegate?  {
        return self.app;
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
    } else if (call.method == "Show a ticket screen") {
        //https://developer.zendesk.com/embeddables/docs/ios_support_sdk/requests#show-a-ticket-screen
        if ( self.requestScreen == nil ) {
            self.requestScreen = RequestUi.buildRequestUi(with: [])
        }
        
        if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
            navigationController.pushViewController(self.requestScreen!, animated: true)
            result (true)
        } else {
            let storyboard : UIStoryboard? = UIStoryboard.init(name: "Main", bundle: nil);
            let window: UIWindow = ((UIApplication.shared.delegate?.window)!)!
            //let window = UIWindow(frame: UIScreen.main.bounds)
            //window.makeKeyAndVisible()
            //window.rootViewController = nil
            let objVC: UIViewController? = storyboard!.instantiateViewController(withIdentifier: "FlutterViewController")
            self.aObjNavi = UINavigationController(rootViewController: objVC!)
            self.aObjNavi!.isNavigationBarHidden = true
            window.rootViewController = self.aObjNavi!
            window.makeKeyAndVisible()
            self.aObjNavi!.pushViewController(self.requestScreen!, animated: true)
            result (true)
        }
        
    } else if (call.method == "showTickets") {
        //https://developer.zendesk.com/embeddables/docs/ios_support_sdk/requests#show-a-ticket-screen
        let requestListController = RequestUi.buildRequestList()

        if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
            navigationController.pushViewController(requestListController, animated: true)
            result (true)
        } else {
            let storyboard : UIStoryboard? = UIStoryboard.init(name: "Main", bundle: nil);
            SwiftFlutterZendeskPlugin.getApplication()?.window.rootViewController = nil
            SwiftFlutterZendeskPlugin.getApplication()?.window = UIWindow(frame: UIScreen.main.bounds)
            SwiftFlutterZendeskPlugin.getApplication()?.window.makeKeyAndVisible()
            
            let objVC: UIViewController? = storyboard!.instantiateViewController(withIdentifier: "FlutterViewController")
            self.aObjNavi = UINavigationController(rootViewController: objVC!)
            self.aObjNavi!.pushViewController(requestListController, animated: true)
            result (true)
        }
        
    } else if ( call.method == "createRequest" ) {
        let provider = ZDKRequestProvider()
        
        provider.createRequest(ZDKCreateRequest!, withCallback: { (Any?, error) in
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
    } else if ( call.method == "getRequestById" ) {
        let provider = ZDKRequestProvider()
        let arguments = call.arguments as! Dictionary<String, String>;
        let requestId = arguments["requestId"]!;

        provider.getRequestById(requestId, withCallback: { (request, error) in
            if ( request != nil ) {
                result(request?.toJson());
            } else {
                let _error = error! as NSError;
                result([FlutterError( code: String(_error.code), message: _error.domain, details: _error.userInfo  )]);
            }
        });
    } else if ( call.method == "getCommentsByRequestId" ) {
        let provider = ZDKRequestProvider()
        let arguments = call.arguments as! Dictionary<String, String>;
        let requestId = arguments["requestId"]!;
        
        provider.getCommentsWithRequestId(requestId, withCallback: { (commentsWithUser, error ) in
            if ( commentsWithUser != nil ) {
                let encode = commentsWithUser!.map( {commentWithUser in
                    [
                        "comment": commentWithUser.comment.toJson(),
                        "user": commentWithUser.user.toJson()
                    ]
                });
                result(encode);
            } else {
                let _error = error! as NSError;
                result([FlutterError( code: String(_error.code), message: _error.domain, details: _error.userInfo  )]);
            }
        });
    } else if ( call.method == "addComment" ) {
        let provider = ZDKRequestProvider()
        let arguments = call.arguments as! Dictionary<String, Any>;
        let requestId = arguments["requestId"] as! String;
        let comment = arguments["comment"] as! String;
        // let attachemntsDict = arguments["attachments"] as? [AnyHashable : Any]?;

        
        provider.addComment(comment, forRequestId: requestId, attachments: nil, withCallback: { ( comment, error ) in
            if ( comment != nil ) {
                result(comment?.toJson());
            } else {
                let _error = error! as NSError;
                result([FlutterError( code: String(_error.code), message: _error.domain, details: _error.userInfo  )]);
            }
        });
    }else if ( call.method == "getArticlesForSectionId") {
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
    } else if (call.method == "showArticle") {
    //https://developer.zendesk.com/embeddables/docs/ios_support_sdk/requests#show-a-ticket-screen
                
        let articleController = ZDKHelpCenterUi.buildHelpCenterArticleUi(withArticleId: "360022535234")
        
        if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
            navigationController.pushViewController(articleController, animated: true)
            result (true)
        } else {
            let storyboard : UIStoryboard? = UIStoryboard.init(name: "Main", bundle: nil);
            let window: UIWindow = ((UIApplication.shared.delegate?.window)!)!
            //let window = UIWindow(frame: UIScreen.main.bounds)
            //window.makeKeyAndVisible()
            //window.rootViewController = nil
            let objVC: UIViewController? = storyboard!.instantiateViewController(withIdentifier: "FlutterViewController")
            self.aObjNavi = UINavigationController(rootViewController: objVC!)
            //self.aObjNavi!.isNavigationBarHidden = true
            window.rootViewController = self.aObjNavi!
            self.aObjNavi!.pushViewController(articleController, animated: true)
            result (true)
        }
    
    } else {
        result(FlutterMethodNotImplemented);
    }
    //result("iOS " + UIDevice.current.systemVersion)
  }

}
