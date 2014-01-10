//
//  BESupport.m
//  UIDevice-BlurEnabled
//
//  Created by Alexey Aleshkov on 09.01.14.
//  Copyright (c) 2014 Alexey Aleshkov. All rights reserved.
//


#import "BESupport.h"
#include <sys/sysctl.h>


NSString *BEBlurEffectModelIdentifier()
{
    size_t size;
    int name[] = { CTL_HW, HW_MACHINE };
    sysctl(name, sizeof(name) / sizeof(name[0]), NULL, &size, NULL, 0);

    char *hw_machine = malloc(size);
    sysctl(name, sizeof(name) / sizeof(name[0]), hw_machine, &size, NULL, 0);
    NSString *hardware = [NSString stringWithUTF8String:hw_machine];
    free(hw_machine);

    return hardware;
}

BOOL BEBlurEffectSupportedForModel(NSString *modelIdentifier)
{
    if (![modelIdentifier length]) {
        return NO;
    }

    BOOL result = YES;

    modelIdentifier = [modelIdentifier stringByReplacingOccurrencesOfString:@"," withString:@"."];

    NSScanner *scanner = [NSScanner scannerWithString:modelIdentifier];
    NSString *deviceType = nil;
    [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:&deviceType];
    double deviceVersion = NAN;
    [scanner scanDouble:&deviceVersion];

    if ([deviceType isEqualToString:@"iPhone"]) {
        BOOL unsupportedDeviceRange = deviceVersion < 4.1;
        result = !unsupportedDeviceRange;
    } else if ([deviceType isEqualToString:@"iPod"]) {
        BOOL unsupportedDeviceRange = deviceVersion < 5.1;
        result = !unsupportedDeviceRange;
    } else if ([deviceType isEqualToString:@"iPad"]) {
        // 2.4 - iPad 2; 2.5 .. 2.7 - iPad Mini; 3.1 .. 3.3 - iPad 3
        BOOL unsupportedDeviceRange = deviceVersion <= 2.4 || (3.1 <= deviceVersion && deviceVersion <= 3.3);
        result = !unsupportedDeviceRange;
    }

    return result;
}

BOOL BEBlurEffectSupportedForSystemVersion(NSString *systemVersion)
{
    double version = [systemVersion doubleValue];

    BOOL result = version >= 7;

    return result;
}
