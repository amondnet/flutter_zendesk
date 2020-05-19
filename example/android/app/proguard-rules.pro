## Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-dontwarn io.flutter.embedding.**

-keep class zendesk.core.AuthenticationRequestWrapper { *; }
-keep class zendesk.core.PushRegistrationRequestWrapper { *; }
-keep class zendesk.core.PushRegistrationRequest { *; }
-keep class zendesk.core.PushRegistrationResponse { *; }
-keep class zendesk.core.ApiAnonymousIdentity { *; }
-keep class zendesk.support.Comment { *; }
-keep class zendesk.support.CreateRequest { *; }
-keep class zendesk.support.CreateRequestWrapper { *; }
-keep class zendesk.support.EndUserComment { *; }
-keep class zendesk.support.Request { *; }
-keep class zendesk.support.UpdateRequestWrapper { *; }