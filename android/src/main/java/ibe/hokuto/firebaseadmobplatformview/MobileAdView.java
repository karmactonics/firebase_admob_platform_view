package ibe.hokuto.firebaseadmobplatformview;

import android.content.Context;
import android.view.View;

import com.google.android.gms.ads.AdListener;
import com.google.android.gms.ads.AdSize;
import com.google.android.gms.ads.AdView;
import com.google.android.gms.ads.AdRequest;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import static io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import static io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.platform.PlatformView;

public class MobileAdView implements PlatformView, MethodCallHandler {

    private final Context context;
    private final String adId;
    private final AdSize adSize;
    private final int uniqueId;
    private final BinaryMessenger messenger;
    private final MethodChannel methodChannel;

    private final AdView adView;

    MobileAdView(Context context, String adId, BinaryMessenger messenger, AdSize adSize, int uniqueId){
        this.context = context;
        this.adId = adId;
        this.adSize = adSize;
        this.uniqueId = uniqueId;
        this.messenger = messenger;
        methodChannel = new MethodChannel(messenger, "hokuto.ibe/firebase_admob_platform_view_" + uniqueId);
        methodChannel.setMethodCallHandler(this);

        adView = new AdView(this.context);
        adView.setAdSize(this.adSize);
        adView.setAdUnitId(this.adId);

        reloadAd();
    }

    @Override
    public View getView() {
        return adView;
    }

    @Override
    public void dispose() {
        adView.setVisibility(View.GONE);
        adView.destroy();
    }

    public void reloadAd() {
        AdRequest adRequest = adRequest();
        adView.loadAd(adRequest);
    }

    private AdRequest adRequest() {
        AdRequest adRequest = new AdRequest.Builder()
                .build();
        return adRequest;
    }

    @Override
    public void onMethodCall(MethodCall methodCall, Result result) {
        switch (methodCall.method) {
            case "reloadAd":
                reloadAd();
                break;
            default:
                break;
        }
    }
}
