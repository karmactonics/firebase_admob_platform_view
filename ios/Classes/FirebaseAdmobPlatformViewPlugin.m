#import "FirebaseAdmobPlatformViewPlugin.h"
#import <firebase_admob_platform_view-Swift.h>

@implementation FirebaseAdmobPlatformViewPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFirebaseAdmobPlatformViewPlugin registerWithRegistrar:registrar];
}
@end
