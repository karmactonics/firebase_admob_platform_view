package ibe.hokuto.firebaseadmobplatformview;

import android.content.Context;
import android.view.View;

import com.google.android.gms.ads.AdListener;
import com.google.android.gms.ads.AdSize;
import com.google.android.gms.ads.AdView;
import com.google.android.gms.ads.AdRequest;
import io.flutter.plugin.platform.PlatformView;

public class MobileAdView implements PlatformView {

    private final Context context;
    private final String adId;
    private final AdSize adSize;

    private final AdView adView;

    MobileAdView(Context context, String adId, AdSize adSize){
        this.context = context;
        this.adId = adId;
        this.adSize = adSize;

        adView = new AdView(this.context);
        adView.setAdSize(this.adSize);
        adView.setAdUnitId(this.adId);
        AdRequest adRequest = new AdRequest.Builder()
                .build();

        adView.loadAd(adRequest);

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

}
