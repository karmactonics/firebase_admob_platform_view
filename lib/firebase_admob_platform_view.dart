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

  static final String testBannerId =
      Platform.isAndroid ? 'ca-app-pub-3940256099942544/6300978111' 
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

class AdBannerView extends StatefulWidget {
  final String adId;
  final AdSizeType adSizeType;
  final int width;
  final int height;

  const AdBannerView(
      {Key key,
      @required this.adId,
      @required this.adSizeType,
      @required this.width,
      @required this.height})
      : super(key: key);

  @override
  _AdBannerViewState createState() => _AdBannerViewState();
}

class _AdBannerViewState extends State<AdBannerView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.transparent),
      child:SizedBox(
        width: widget.width.toDouble(),
        height: widget.height.toDouble(),
        child: (Platform.isAndroid)? AndroidView(
        viewType: "MobileAdView",
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
          Factory<OneSequenceGestureRecognizer>(
            () => EagerGestureRecognizer(),
          ),
        ].toSet(),
        creationParams: {
          "adId": widget.adId,
          "adSizeType": widget.adSizeType.toString(),
          "width": widget.width,
          "height": widget.height
        },
        creationParamsCodec: StandardMessageCodec(),
      ): Text("Doesn`t support iOS"),
      ) 
    );
  }
}
