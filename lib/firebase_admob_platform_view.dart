import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'dart:io';
import 'package:meta/meta.dart';

class FirebaseAdmobPlatformView {
  /// The single shared instance of this plugin.
  static final FirebaseAdmobPlatformView _instance =
      FirebaseAdmobPlatformView();
  static FirebaseAdmobPlatformView get instance => _instance;

  MethodChannel _channel =
      const MethodChannel('hokuto.ibe/firebase_admob_platform_view');

  static final String testAppId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544~3347511713'
      : 'ca-app-pub-3940256099942544~1458002511';

  static final String testBannerId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  /// Initialize this plugin for the AdMob app specified by `appId`.
  Future<bool> initialize(
      {@required String appId,
      String trackingId,
      bool analyticsEnabled = false}) {
    assert(appId != null && appId.isNotEmpty);
    assert(analyticsEnabled != null);
    return _invokeBooleanMethod("initialize", <String, dynamic>{
      'appId': appId,
      'trackingId': trackingId,
      'analyticsEnabled': analyticsEnabled,
    });
  }

  Future<bool> _invokeBooleanMethod(String method, [dynamic arguments]) async {
    final bool result =
        await FirebaseAdmobPlatformView.instance._channel.invokeMethod(
      method,
      arguments,
    );
    return result;
  }
}

// The types of ad sizes supported for banners. The names of the values are used
// in MethodChannel calls to iOS and Android, and should not be changed.
enum AdSizeType {
  WidthAndHeight,
  SmartBanner,
}

class AdSize {
  final int height;
  final int width;
  final AdSizeType adSizeType;

  // Private constructor. Apps should use the static constants rather than
  // create their own instances of [AdSize].
  const AdSize._({
    @required this.width,
    @required this.height,
    @required this.adSizeType,
  });

  factory AdSize.custom(int width, int height) {
    return AdSize._(
        width: width, height: height, adSizeType: AdSizeType.WidthAndHeight);
  }

  /// The standard banner (320x50) size.
  static const AdSize banner = AdSize._(
    width: 320,
    height: 50,
    adSizeType: AdSizeType.WidthAndHeight,
  );

  /// The large banner (320x100) size.
  static const AdSize largeBanner = AdSize._(
    width: 320,
    height: 100,
    adSizeType: AdSizeType.WidthAndHeight,
  );

  /// The medium rectangle (300x250) size.
  static const AdSize mediumRectangle = AdSize._(
    width: 300,
    height: 250,
    adSizeType: AdSizeType.WidthAndHeight,
  );

  /// The full banner (468x60) size.
  static const AdSize fullBanner = AdSize._(
    width: 468,
    height: 60,
    adSizeType: AdSizeType.WidthAndHeight,
  );

  /// The leaderboard (728x90) size.
  static const AdSize leaderboard = AdSize._(
    width: 728,
    height: 90,
    adSizeType: AdSizeType.WidthAndHeight,
  );

  static const AdSize smartBanner = AdSize._(
    width: 0,
    height: 0,
    adSizeType: AdSizeType.SmartBanner,
  );
}

class AdBannerView extends StatefulWidget {
  final String adId;
  final AdSize adSize;

  const AdBannerView({
    Key key, 
    @required this.adId, 
    @required this.adSize}) 
    : super(key: key);

  @override
  _AdBannerViewState createState() => _AdBannerViewState();
}

class _AdBannerViewState extends State<AdBannerView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.transparent),
        alignment: Alignment.center,
        child: SizedBox(
          width: widget.adSize.width.toDouble(),
          height: widget.adSize.height.toDouble(),
          child: (Platform.isAndroid)
              ? AndroidView(
                  viewType: "MobileAdView",
                  gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                    Factory<OneSequenceGestureRecognizer>(
                      () => EagerGestureRecognizer(),
                    ),
                  ].toSet(),
                  creationParams: {
                    "adId": widget.adId,
                    "adSizeType": widget.adSize.adSizeType.toString(),
                    "width": widget.adSize.width,
                    "height": widget.adSize.height,
                  },
                  creationParamsCodec: StandardMessageCodec(),
                )
              : Text("Doesn`t support iOS"),
        ));
  }
}
