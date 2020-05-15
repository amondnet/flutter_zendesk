import Flutter
import UIKit
import ZendeskCoreSDK
import SupportProvidersSDK
import SupportSDK

@objc public class SwiftFlutterZendeskPlugin: NSObject, FlutterPlugin {
    private var aObjNavi: UINavigationController?
    private var requestScreen: UIViewController?
    private var requestProvider: ZDKRequestProvider?
    static var app: FlutterAppDelegate?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "net.amond.flutter_zendesk", binaryMessenger: registrar.messenger())

        let instance = SwiftFlutterZendeskPlugin()

        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public static func setApplication(_ application: FlutterAppDelegate) {
        app = application
    }

    public static func getApplication() -> FlutterAppDelegate? {
        return app
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "initialize" {
            let arguments = call.arguments as! [String: String]
            let appId = arguments["appId"]!
            let clientId = arguments["clientId"]!
            let zendeskUrl = arguments["zendeskUrl"]!

            Zendesk.initialize(appId: appId, clientId: clientId, zendeskUrl: zendeskUrl)
            Support.initialize(withZendesk: Zendesk.instance)
            // SupportUI.initialize(withZendesk: Zendesk.instance)
            result(appId)
        } else if call.method == "isInitialized" {
            
            result(true)
        } else if call.method == "setIdentity" {
            let arguments = call.arguments as! [String: String]
            let token = arguments["token"]

            var identity: Identity
            if token != nil {
                identity = Identity.createJwt(token: token!)
            } else {
                identity = Identity.createAnonymous()
            }

            Zendesk.instance?.setIdentity(identity)
            result(true)
        } else if call.method == "createRequest" {
            let arguments = call.arguments as! [String: Any]
            let subject = arguments["subject"] as? String
            let requestDescription = arguments["requestDescription"]! as! String
            let tags = arguments["tags"] as? [String]
            let customFields = arguments["customFields"] as? [[String: Any]]
            let provider = ZDKRequestProvider()

            let request = ZDKCreateRequest()
            request.subject = subject
            request.requestDescription = requestDescription
            request.tags = tags
            if customFields != nil {
                let fields = customFields!.map {
                    CustomField(fieldId: $0["fieldId"] as! Int64, value: $0["value"] as! String)
                }
                request.customFields = fields as? [CustomField]
            }

            provider.createRequest(request) { response, error in
                if response != nil {
                    let _response = response as! ZDKDispatcherResponse
                    result(_response.data)
                } else {
                    let _error = error! as NSError
                    result(FlutterError(code: "Error : " + String(_error.code), message: _error.domain, details: _error.localizedDescription))
                }
            }

        } else if call.method == "showRequest" {
            // https://developer.zendesk.com/embeddables/docs/ios_support_sdk/requests#show-a-ticket-screen
            if requestScreen == nil {
                requestScreen = RequestUi.buildRequestUi(with: [])
            }

            if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
                navigationController.pushViewController(requestScreen!, animated: true)
                result(true)
            } else {
                let storyboard: UIStoryboard? = UIStoryboard(name: "Main", bundle: nil)
                let window: UIWindow = ((UIApplication.shared.delegate?.window)!)!
                // let window = UIWindow(frame: UIScreen.main.bounds)
                // window.makeKeyAndVisible()
                // window.rootViewController = nil
                let objVC: UIViewController? = storyboard!.instantiateViewController(withIdentifier: "FlutterViewController")
                aObjNavi = UINavigationController(rootViewController: objVC!)
                aObjNavi!.isNavigationBarHidden = true
                window.rootViewController = aObjNavi!
                window.makeKeyAndVisible()
                aObjNavi!.pushViewController(requestScreen!, animated: true)
                result(true)
            }

        } else if call.method == "showRequestList" {
            // https://developer.zendesk.com/embeddables/docs/ios_support_sdk/requests#show-a-ticket-screen
            let requestListController = RequestUi.buildRequestList()

            if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
                navigationController.pushViewController(requestListController, animated: true)
                result(true)
            } else {
                let storyboard: UIStoryboard? = UIStoryboard(name: "Main", bundle: nil)
                SwiftFlutterZendeskPlugin.getApplication()?.window.rootViewController = nil
                SwiftFlutterZendeskPlugin.getApplication()?.window = UIWindow(frame: UIScreen.main.bounds)
                SwiftFlutterZendeskPlugin.getApplication()?.window.makeKeyAndVisible()

                let objVC: UIViewController? = storyboard!.instantiateViewController(withIdentifier: "FlutterViewController")
                aObjNavi = UINavigationController(rootViewController: objVC!)
                aObjNavi!.pushViewController(requestListController, animated: true)
                result(true)
            }

        } else if call.method == "getAllRequests" {
            if requestProvider == nil {
                requestProvider = ZDKRequestProvider()
            }
            requestProvider!.getAllRequests(callback: { requets, error in
                if requets != nil {
                    let _requests = requets! as ZDKRequestsWithCommentingAgents
                    let encoded = [
                        "commenting_agents": _requests.commentingAgents.map { (agent: ZDKSupportUser) in
                            var dict = agent.toJson() as Dictionary
                            dict["avatar_url"] = agent.avatarURL
                            dict["user_fields"] = agent.userFields
                            return dict
                        },
                        "requests": _requests.requests.map { (request: ZDKRequest) in
                            request.toJson()
                        },
                    ]
                    result(encoded)
                } else {
                    let _error = error! as NSError
                    result(FlutterError(code: String(_error.code), message: _error.domain, details: _error.userInfo))
                }
            })
        } else if call.method == "getRequestById" {
            if requestProvider == nil {
                requestProvider = ZDKRequestProvider()
            }
            let arguments = call.arguments as! [String: String]
            let requestId = arguments["requestId"]!

            requestProvider!.getRequestById(requestId, withCallback: { request, error in
                if request != nil {
                    result(request?.toJson())
                } else {
                    let _error = error! as NSError
                    result(FlutterError(code: String(_error.code), message: _error.domain, details: _error.userInfo))
                }
            })
        } else if call.method == "getCommentsByRequestId" {
            if requestProvider == nil {
                requestProvider = ZDKRequestProvider()
            }
            let arguments = call.arguments as! [String: String]
            let requestId = arguments["requestId"]!

            requestProvider!.getCommentsWithRequestId(requestId, withCallback: { commentsWithUser, error in
                if commentsWithUser != nil {
                    let encode = commentsWithUser!.map { commentWithUser in
                        [
                            "comment": commentWithUser.comment.toJson(),
                            "user": commentWithUser.user.toJson(),
                        ]
                    }
                    result(encode)
                } else {
                    let _error = error! as NSError
                    result(FlutterError(code: "Error: " + String(_error.code), message: _error.domain, details: _error.localizedDescription))
                }
            })
        } else if call.method == "addComment" {
            if requestProvider == nil {
                requestProvider = ZDKRequestProvider()
            }
            let arguments = call.arguments as! [String: Any]
            let requestId = arguments["requestId"] as! String
            let comment = arguments["comment"] as! String
            // let attachemntsDict = arguments["attachments"] as? [AnyHashable : Any]?;

            requestProvider!.addComment(comment, forRequestId: requestId, attachments: nil, withCallback: { comment, error in
                if comment != nil {
                    result(comment?.toJson())
                } else {
                    let _error = error! as NSError
                    result(FlutterError(code: String(_error.code), message: _error.domain, details: _error.userInfo))
                }
            })
        } else if call.method == "getArticlesForSectionId" {
            let arguments = call.arguments as! [String: String]

            let helpCenterProvider = ZDKHelpCenterProvider()
            let sectionId = arguments["sectionId"]
            helpCenterProvider.getArticlesWithSectionId(sectionId) { articles, error in
                if articles != nil {
                    let items = articles! as! [ZDKHelpCenterArticle]

                    let res = items.map { article in
                        ["identifier": article.identifier,
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
                         "htmlUrl": article.htmlUrl]
                    }

                    result([
                        "articles": res,
                    ])
                } else {
                    let _error = error! as NSError
                    result(FlutterError(code: String(_error.code), message: _error.domain, details: _error.userInfo))
                }
            }
        } else if call.method == "showArticle" {
            // https://developer.zendesk.com/embeddables/docs/ios_support_sdk/requests#show-a-ticket-screen

            let articleController = ZDKHelpCenterUi.buildHelpCenterArticleUi(withArticleId: "360022535234")

            if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
                navigationController.pushViewController(articleController, animated: true)
                result(true)
            } else {
                let storyboard: UIStoryboard? = UIStoryboard(name: "Main", bundle: nil)
                let window: UIWindow = ((UIApplication.shared.delegate?.window)!)!
                // let window = UIWindow(frame: UIScreen.main.bounds)
                // window.makeKeyAndVisible()
                // window.rootViewController = nil
                let objVC: UIViewController? = storyboard!.instantiateViewController(withIdentifier: "FlutterViewController")
                aObjNavi = UINavigationController(rootViewController: objVC!)
                // self.aObjNavi!.isNavigationBarHidden = true
                window.rootViewController = aObjNavi!
                aObjNavi!.pushViewController(articleController, animated: true)
                result(true)
            }
        } else if call.method == "showHelpCenter" {
                     // https://developer.zendesk.com/embeddables/docs/ios_support_sdk/requests#show-a-ticket-screen

                     let helpCenter = ZDKHelpCenterUi.buildHelpCenterOverviewUi()

                     if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
                         navigationController.pushViewController(helpCenter, animated: true)
                         result(true)
                     } else {
                         let storyboard: UIStoryboard? = UIStoryboard(name: "Main", bundle: nil)
                         let window: UIWindow = ((UIApplication.shared.delegate?.window)!)!
                         // let window = UIWindow(frame: UIScreen.main.bounds)
                         // window.makeKeyAndVisible()
                         // window.rootViewController = nil
                         let objVC: UIViewController? = storyboard!.instantiateViewController(withIdentifier: "FlutterViewController")
                         aObjNavi = UINavigationController(rootViewController: objVC!)
                         // self.aObjNavi!.isNavigationBarHidden = true
                         window.rootViewController = aObjNavi!
                         aObjNavi!.pushViewController(helpCenter, animated: true)
                         result(true)
                 }
        } else {
            result(FlutterMethodNotImplemented)
        }
        // result("iOS " + UIDevice.current.systemVersion)
    }
}
