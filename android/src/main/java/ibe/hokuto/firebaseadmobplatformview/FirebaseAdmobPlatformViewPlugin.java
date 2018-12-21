package ibe.hokuto.firebaseadmobplatformview;

import com.google.android.gms.ads.MobileAds;
import com.google.firebase.FirebaseApp;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FirebaseAdmobPlatformViewPlugin */
public class FirebaseAdmobPlatformViewPlugin implements MethodCallHandler {

  private final Registrar registrar;
  private final MethodChannel channel;

  public static void registerWith(Registrar registrar) {
    final MethodChannel channel =
            new MethodChannel(registrar.messenger(), "hokuto.ibe/firebase_admob_platform_view");
    channel.setMethodCallHandler(new FirebaseAdmobPlatformViewPlugin(registrar, channel));

  }

  private FirebaseAdmobPlatformViewPlugin(Registrar registrar, MethodChannel channel) {
    this.registrar = registrar;
    this.channel = channel;
    FirebaseApp.initializeApp(registrar.context());
  }

  private void callInitialize(MethodCall call, Result result) {
    String appId = call.argument("appId");
    if (appId == null || appId.isEmpty()) {
      result.error("no_app_id", "a null or empty AdMob appId was provided", null);
      return;
    }
    MobileAds.initialize(registrar.context(), appId);
    registrar.platformViewRegistry().registerViewFactory("MobileAdView", new MobileAdViewFactory(registrar.messenger()));
    result.success(Boolean.TRUE);
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("initialize")) {
      callInitialize(call, result);
    } else {

    }
  }
}
