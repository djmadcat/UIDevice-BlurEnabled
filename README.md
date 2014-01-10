# UIDevice-BlurEnabled

UIDevice category to check whether blur is enabled.

## Overview

This is a hack method to check whether blur is enabled on current device. It is based on testing of rendering blur effect at runtime.

## How it works

1. We create `UIView` with custom `backgroundColor`
2. Add `UIToolbar` with `translucent = YES` to `UIView`
3. Add `UIView` to `UIWindow` beyond the screen (this allows you to perform `UIView` rendering)
4. Check rendered colors with tricky algorithm
5. Remove `UIView` from `UIWindow`

You must check `be_blurEffectEnabled` at every `applicationDidBecomeActive:` call or by subscribing to `UIApplicationDidBecomeActiveNotification` in your controller or custom view to fix views' rendering settings.

## Dependencies

* `'UIView-JTViewToImage', '~> 0.1'` to take screenshot of `UIView` as `UIImage`
* `'OBShapedButton', '~> 1.0.2'` to access the pixel color

## Example usage

``` objective-c
#import "UIDevice+BlurEnabled.h"

@implementation BEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIDevice *currentDevice = [UIDevice currentDevice];
    NSLog(@"Blur supported by device and OS: %@", [currentDevice be_blurEffectSupported] ? @"YES" : @"NO");
    NSLog(@"Blur active ('increase contrast' disabled): %@", [currentDevice be_blurEffectActive] ? @"YES" : @"NO");
    NSLog(@"Blur enabled (supported && active): %@", [currentDevice be_blurEffectEnabled] ? @"YES" : @"NO");
}

@end
```

## Read more

- http://stackoverflow.com/questions/19717454/is-there-a-way-to-check-if-increase-contrast-is-enabled-in-the-accessibility-s

## Contact

Alexey Aleshkov

- https://github.com/djmadcat
- https://twitter.com/coreshock
- djmadcat@gmail.com

## License

UIDevice-BlurEnabled is available under the BSD 2-Clause license. See the `LICENSE` file for more info.
