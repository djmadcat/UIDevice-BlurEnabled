//
//  UIDevice+BlurEnabled.m
//  UIDevice-BlurEnabled
//
//  Created by Alexey Aleshkov on 09.01.14.
//  Copyright (c) 2014 Alexey Aleshkov. All rights reserved.
//


#import "UIDevice+BlurEnabled.h"
#import "BESupport.h"
#import "BEColor.h"
#import <OBShapedButton/UIImage+ColorAtPixel.h>
#import <UIView-JTViewToImage/UIView-JTViewToImage.h>


static BOOL kBlurEffectSupported = NO;
static BOOL kBlurEffectLastState = NO;


__attribute__((constructor))
static void initializeBlurEffectVariables()
{
    NSString *systemVersion = [UIDevice currentDevice].systemVersion;
    BOOL blurEffectSupportedBySystem = BEBlurEffectSupportedForSystemVersion(systemVersion);

    NSString *modelIdentifier = BEBlurEffectModelIdentifier();
    BOOL blurEffectSupportedByDevice = BEBlurEffectSupportedForModel(modelIdentifier);

    kBlurEffectSupported = blurEffectSupportedBySystem && blurEffectSupportedByDevice;

    kBlurEffectLastState = kBlurEffectSupported;
}


@implementation UIDevice (BlurEnabled)

- (BOOL)be_blurEffectSupported
{
    return kBlurEffectSupported;
}

- (BOOL)be_blurEffectActive
{
    if (![UIToolbar instanceMethodForSelector:@selector(barTintColor)]) {
        return NO;
    }
    
    CGSize insets = CGSizeMake(16, 16);
    CGSize size = CGSizeMake(64, 64);
    CGRect frame = CGRectMake(-size.width * 2, -size.height * 2, size.width, size.height);
    CGPoint testPoint = CGPointMake(truncf(size.width / 2), truncf(size.height / 2));

    UIView *backgroundView = [[UIView alloc] initWithFrame:frame];

	UIToolbar *blurView = [[UIToolbar alloc] initWithFrame:CGRectInset(backgroundView.bounds, insets.width, insets.height)];
	blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	blurView.translucent = YES;
	blurView.barTintColor = [UIColor clearColor];
	blurView.backgroundColor = [UIColor clearColor];

    [backgroundView addSubview:blurView];
    [[UIApplication sharedApplication].delegate.window addSubview:backgroundView];
    [[UIApplication sharedApplication].delegate.window bringSubviewToFront:backgroundView];

    BOOL result = NO;

    UIImage *viewShotImage;
    UIColor *testUIColor;
    {
        UIColor *standardRedColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
        backgroundView.backgroundColor = standardRedColor;
        viewShotImage = [backgroundView toImage];
        testUIColor = [viewShotImage colorAtPixel:testPoint];
        BEColor testRedColor = BEColorFromUIColor(testUIColor);

        UIColor *standardGreenColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:1];
        backgroundView.backgroundColor = standardGreenColor;
        viewShotImage = [backgroundView toImage];
        testUIColor = [viewShotImage colorAtPixel:testPoint];
        BEColor testGreenColor = BEColorFromUIColor(testUIColor);

        UIColor *standardBlueColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:1];
        backgroundView.backgroundColor = standardBlueColor;
        viewShotImage = [backgroundView toImage];
        testUIColor = [viewShotImage colorAtPixel:testPoint];
        BEColor testBlueColor = BEColorFromUIColor(testUIColor);

        UIColor *standardWhiteColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        backgroundView.backgroundColor = standardWhiteColor;
        viewShotImage = [backgroundView toImage];
        testUIColor = [viewShotImage colorAtPixel:testPoint];
        BEColor testWhiteColor = BEColorFromUIColor(testUIColor);

        UIColor *standardBlackColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        backgroundView.backgroundColor = standardBlackColor;
        viewShotImage = [backgroundView toImage];
        testUIColor = [viewShotImage colorAtPixel:testPoint];
        BEColor testBlackColor = BEColorFromUIColor(testUIColor);

        BOOL maxComponentsEqual = (testWhiteColor.red == testRedColor.red) && (testWhiteColor.red == testGreenColor.green) && (testWhiteColor.red == testBlueColor.blue);
        BOOL minComponentsEqual = (testBlackColor.red == testRedColor.green) && (testBlackColor.red == testGreenColor.blue) && (testBlackColor.red == testBlueColor.red);

        result = !maxComponentsEqual && !minComponentsEqual;
    }

    [backgroundView removeFromSuperview];

    return result;
}

- (BOOL)be_blurEffectEnabled
{
    BOOL result = [self be_blurEffectSupported] && [self be_blurEffectActive];
    return result;
}

@end
