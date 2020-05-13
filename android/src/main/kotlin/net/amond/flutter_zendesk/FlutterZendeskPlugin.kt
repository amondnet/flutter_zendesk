package net.amond.flutter_zendesk

import android.content.Context
import com.zendesk.service.ErrorResponse
import com.zendesk.service.ZendeskCallback
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import kotlinx.serialization.ImplicitReflectionSerializer
import kotlinx.serialization.Properties
import zendesk.core.AnonymousIdentity
import zendesk.core.Identity
import zendesk.core.JwtIdentity
import zendesk.core.Zendesk
import zendesk.support.CreateRequest
import zendesk.support.Request
import zendesk.support.RequestProvider
import zendesk.support.Support
import zendesk.support.guide.HelpCenterActivity
import zendesk.support.guide.ViewArticleActivity
import zendesk.support.request.RequestActivity
import zendesk.support.requestlist.RequestListActivity


@ImplicitReflectionSerializer
class FlutterZendeskPlugin : FlutterPlugin, ActivityAware, MethodChannel.MethodCallHandler {
  private var activityContext: Context? = null
  private var applicationContext: Context? = null
  private var methodChannel: MethodChannel? = null

  companion object {

    /** Plugin registration. */
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "net.amond.flutter_zendesk")
      val instance = FlutterZendeskPlugin()
      instance.activityContext = registrar.activity()
      instance.applicationContext = registrar.context()
      instance.onAttachedToEngine(registrar.context(), registrar.messenger());

    }
  }


  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    onAttachedToEngine(binding.applicationContext, binding.binaryMessenger)
  }

  private fun onAttachedToEngine(applicationContext: Context,
      messenger: BinaryMessenger) {
    this.applicationContext = applicationContext
    methodChannel = MethodChannel(messenger, "net.amond.flutter_zendesk")
    methodChannel!!.setMethodCallHandler(this)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    applicationContext = null;
    methodChannel?.setMethodCallHandler(null);
    methodChannel = null;
  }

  override fun onDetachedFromActivity() {
    activityContext = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activityContext = binding.activity
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activityContext = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activityContext = null
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "createJwt" -> {
        createJWT(call, result)
      }
      "initialize" -> {
        init(call, result)
      }
      "isInitialized" -> {
        isInitialized(result)
      }
      "createRequest" -> {
        createRequest(call, result)
      }
      "getArticlesForSectionId" -> {
        getArticlesForSectionId(call, result)
      }
      "getAllRequests" -> {
        getAllRequests(call, result)
      }
      "getRequestById" -> {
        result.notImplemented()
      }
      "addComment" -> {
        result.notImplemented()
      }
      "getCommentsByRequestId" -> {
        result.notImplemented()
      }
      "setIdentity" -> {
        setIdentity(call, result)
      }
      "anonymousIdentity" -> {
        anonymousIdentity(call, result)
      }
      "showTicketsScreen", "RequestListUI", "showRequestList", "showTickets" -> {
        showRequestListScreen(call, result)
      }
      "showRequestScreen", "RequestUI", "showRequest" -> {
        showRequestScreen(call, result)
      }
      "showHelpCenter" -> {
        showHelpCenterScreen(call, result)
      }
      "showViewArticle" -> {
        showViewArticleScreen(call, result)
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  private fun createJWT(call: MethodCall, result: MethodChannel.Result) {

  }

  private fun createRequest(call: MethodCall, result: MethodChannel.Result) {
    val createRequest = CreateRequest()

    //Support.INSTANCE.provider()!!.requestProvider().createRequest()


  }

  private fun anonymousIdentity(call: MethodCall, result: MethodChannel.Result) {
    val identity = AnonymousIdentity.Builder()
    call.arguments?.let {
      val arguments = call.arguments as Map<String, Any>
      arguments["name"]?.let { name ->
        identity.withNameIdentifier(name as String)
      }
      arguments["email"]?.let { email ->
        identity.withEmailIdentifier(email as String)
      }
    }
    Zendesk.INSTANCE.setIdentity(identity.build())
    return result.success(true)
  }

  private fun getArticlesForSectionId(call: MethodCall, result: MethodChannel.Result) {

  }

  private fun getAllRequests(call: MethodCall, result: MethodChannel.Result) {
    val provider: RequestProvider = Support.INSTANCE.provider()!!.requestProvider()

    provider.getAllRequests(object : ZendeskCallback<List<Request>>() {
      override fun onSuccess(requests: List<Request>) {
        val dto = requests.map { Properties.store(it.toDTO()) }
        result.success(dto)
      }

      override fun onError(error: ErrorResponse) {
        result.error("GET_ALL_REQUESTS_ERROR", error.reason, null)
      }
    })
  }

  private fun showHelpCenterScreen(call: MethodCall, result: Result) {
    if (activityContext == null) {
      return result.error("SHOW_HELP_CENTER_UI_ERROR", "context is null", null)
    } else {
      try {
        val builder = HelpCenterActivity.builder()
        // TODO arguments
        builder.show(activityContext!!)
        result.success(null)
      } catch (e: Exception) {
        result.error("SHOW_HELP_CENTER_UI_ERROR", e.localizedMessage, null)
      }
    }
  }

  private fun showViewArticleScreen(call: MethodCall, result: Result) {
    if (activityContext == null) {
      return result.error("SHOW_ARTICLE_UI_ERROR", "context is null", null)
    } else {
      val builder = ViewArticleActivity.builder()
      // TODO arguments
      builder.show(activityContext!!)
    }
  }

  private fun showRequestListScreen(call: MethodCall, result: Result) {
    if (activityContext == null) {
      return result.error("SHOW_REQUEST_LIST_UI_ERROR", "context is null", null)
    } else {
      val builder = RequestListActivity.builder()
      builder.show(activityContext!!)
    }
  }

  private fun showRequestScreen(call: MethodCall, result: Result) {
    if (activityContext == null) {
      return result.error("SHOW_REQUEST_UI_ERROR", "context is null", null)
    } else {
      val builder = RequestActivity.builder()
      call.arguments?.let {
        val argument = it as Map<String, Any>
        if (call.hasArgument("requestSubject")) {
          builder.withRequestSubject(argument["requestSubject"] as String)
        }
        if (call.hasArgument("tags")) {
          builder.withTags(argument["tags"] as List<String>)
        }
      }
      builder.show(activityContext!!)
    }
  }

  private fun init(call: MethodCall, result: Result) {
    val arguments = call.arguments as Map<String, String>
    val appId = arguments["appId"] ?: error("zendeskUrl is required")
    val clientId = arguments["clientId"] ?: error("zendeskUrl is required")
    val zendeskUrl = arguments["zendeskUrl"] ?: error("zendeskUrl is required")
    try {
      Zendesk.INSTANCE.init(applicationContext!!, zendeskUrl, appId, clientId)
      Support.INSTANCE.init(Zendesk.INSTANCE);
      result.success(null);
    } catch (e: Exception) {
      result.error("INITIALIZE_ERROR", e.localizedMessage, null)
    }
  }

  private fun isInitialized(result: Result) {
    try {
      result.success(Zendesk.INSTANCE.isInitialized)
    } catch (e: Throwable) {
      result.error("IS_INITIALIZE_ERROR", e.localizedMessage, null)
    }
  }

  private fun setIdentity(call: MethodCall, result: Result) {
    val arguments = call.arguments as Map<String, Any>
    val token = arguments["token"] as String
    val identity: Identity = JwtIdentity(token)
    Zendesk.INSTANCE.setIdentity(identity)
  }
}
