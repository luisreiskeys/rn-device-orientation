#import "RnDeviceOrientation.h"

@implementation RnDeviceOrientation
{
  bool hasListeners;
  UIInterfaceOrientation _lastDeviceOrientation;
}
// Will be called when this module's first listener is added.
-(void)startObserving {
    hasListeners = YES;
    _lastDeviceOrientation = [self getDeviceOrientation];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    [self addListener:@"OrientatitionDevicesChanged"];
    // Set up any upstream listeners or background tasks as necessary
}

// Will be called when this module's last listener is removed, or on dealloc.
-(void)stopObserving {
    hasListeners = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeListeners:1];
    // Remove upstream listeners, stop unnecessary background tasks
}

- (UIInterfaceOrientation)getDeviceOrientation {
    UIInterfaceOrientation deviceOrientation = (UIInterfaceOrientation) [UIDevice currentDevice].orientation;
    return deviceOrientation;
}

- (void)deviceOrientationDidChange:(NSNotification *)notification
{
    // UIInterfaceOrientation orientation = [self getInterfaceOrientation];
    UIInterfaceOrientation deviceOrientation = [self getDeviceOrientation];
    
    // do not send Unknown Orientation
    if (deviceOrientation==UIInterfaceOrientationUnknown) {
        return;
    }
    
    
    if (deviceOrientation!=_lastDeviceOrientation) {
        [self sendEventWithName:@"OrientatitionDevicesChanged" body:@{@"val":[self getOrientationStr:deviceOrientation]}];
        _lastDeviceOrientation = deviceOrientation;
    }
}

- (NSString *)getOrientationStr: (UIInterfaceOrientation)orientation {
    
    NSString *orientationStr;
    switch (orientation) {
        case UIInterfaceOrientationPortrait:
            orientationStr = @"0";
            break;
            
        case UIInterfaceOrientationLandscapeLeft:
            orientationStr = @"90";
            break;
            
        case UIInterfaceOrientationLandscapeRight:
            orientationStr = @"270";
            break;
            
        case UIInterfaceOrientationPortraitUpsideDown:
            orientationStr = @"180";
            break;
            
        case UIDeviceOrientationFaceUp:
            orientationStr = @"0";
            break;
            
        case UIDeviceOrientationFaceDown:
            orientationStr = @"180";
            break;
            
        default:
            orientationStr = @"UNKNOWN";
            break;
    }
    return orientationStr;
}
- (NSArray<NSString *> *)supportedEvents
{
    return @[@"OrientatitionDevicesChanged"];
}
RCT_EXPORT_MODULE();
@end
