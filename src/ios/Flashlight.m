#import "SocialSharing.h"
#import <Cordova/CDV.h>

@implementation SocialSharing

- (void)available:(CDVInvokedUrlCommand*)command {
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:[self deviceHasFlashlight]];
    NSString *callbackId = command.callbackId;
    [self writeJavascript:[pluginResult toSuccessCallbackString:callbackId]];
}

- (void)switchOn:(CDVInvokedUrlCommand*)command {
    if ([self deviceHasFlashlight]) {
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOn];
        [device setFlashMode:AVCaptureFlashModeOn];
        [device unlockForConfiguration];
    }
}

- (void)switchOff:(CDVInvokedUrlCommand*)command {
    if ([self deviceHasFlashlight]) {
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOff];
        [device setFlashMode:AVCaptureFlashModeOff];
        [device unlockForConfiguration];
    }
}

-(BOOL*)deviceHasFlashlight {
    if (NSClassFromString(@"AVCaptureDevice")) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        return [device hasTorch] && [device hasFlash];
    }
    return false;
}

@end
