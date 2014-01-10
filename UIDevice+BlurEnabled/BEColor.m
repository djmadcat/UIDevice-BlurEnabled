//
//  BEColor.m
//  UIDevice-BlurEnabled
//
//  Created by Alexey Aleshkov on 09.01.14.
//  Copyright (c) 2014 Alexey Aleshkov. All rights reserved.
//


#import "BEColor.h"


BEColor BEColorFromUIColor(UIColor *color)
{
    BEColor result;
	NSCAssert([color getRed:&result.red green:&result.green blue:&result.blue alpha:&result.alpha], @"BEColorFromUIColor supports only RGBA color space");
    return result;
}
