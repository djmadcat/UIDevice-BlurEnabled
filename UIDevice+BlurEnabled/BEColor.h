//
//  BEColor.h
//  UIDevice-BlurEnabled
//
//  Created by Alexey Aleshkov on 09.01.14.
//  Copyright (c) 2014 Alexey Aleshkov. All rights reserved.
//


#import <Foundation/Foundation.h>


typedef struct BEColor {
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat alpha;
} BEColor;


BEColor BEColorFromUIColor(UIColor *color);
