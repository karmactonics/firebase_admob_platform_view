package ibe.hokuto.firebaseadmobplatformview;

import android.content.Context;

import com.google.android.gms.ads.AdSize;

import java.util.Map;

import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class MobileAdViewFactory extends PlatformViewFactory {

    public MobileAdViewFactory() {
        super(StandardMessageCodec.INSTANCE);
    }

    @Override
    public PlatformView create(Context context, int i, Object o) {
        Map<String, Object> args = (Map<String, Object>) o;
        String adId = (String) args.get("adId");
        int width = (int) args.get("width");
        int height = (int) args.get("height");
        String adSizeType = (String) args.get("adSizeType");

        AdSize adSize;
        if (adSizeType.equals("AdSizeType.SmartBanner")) {
          adSize = AdSize.SMART_BANNER;
        } else {
          adSize = new AdSize(width, height);
        }

        return new MobileAdView(context, adId, adSize);
    }


}
