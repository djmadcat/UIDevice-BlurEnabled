//
//  UIDevice+BlurEnabled.h
//  UIDevice-BlurEnabled
//
//  Created by Alexey Aleshkov on 09.01.14.
//  Copyright (c) 2014 Alexey Aleshkov. All rights reserved.
//


#import <UIKit/UIKit.h>


/*
 * The blur effect is supported in:
 *   iOS 7.0 and above
 *
 * The blur effect will appear on:
 *   iPhone 4S and newer
 *   iPad 4th Generation and newer
 *   All iPad Mini
 */
@interface UIDevice (BlurEnabled)

// Equal to (be_blurEffectSupported && be_blurEffectActive)
- (BOOL)be_blurEffectEnabled;

// Check whether blur effect renders
- (BOOL)be_blurEffectActive;

// Check whether blur supported by device and OS
- (BOOL)be_blurEffectSupported;

@end
