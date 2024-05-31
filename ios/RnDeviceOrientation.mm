#import "RnDeviceOrientation.h"

@implementation RnDeviceOrientation
{
  bool hasListeners;
  UIInterfaceOrientation _lastDeviceOrientation;
}

- (instancetype)init
{
    if ((self = [super init])) {
        _lastDeviceOrientation = [self getDeviceOrientation];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
        [self addListener:@"OrientatitionDevicesChanged"];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeListeners:1];
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
