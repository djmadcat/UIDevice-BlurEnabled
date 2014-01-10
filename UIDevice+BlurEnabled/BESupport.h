//
//  BESupport.h
//  UIDevice-BlurEnabled
//
//  Created by Alexey Aleshkov on 09.01.14.
//  Copyright (c) 2014 Alexey Aleshkov. All rights reserved.
//


#import <Foundation/Foundation.h>


NSString *BEBlurEffectModelIdentifier();

BOOL BEBlurEffectSupportedForModel(NSString *modelIdentifier);

BOOL BEBlurEffectSupportedForSystemVersion(NSString *systemVersion);
