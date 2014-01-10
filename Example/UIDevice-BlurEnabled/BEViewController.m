//
//  BEViewController.m
//  UIDevice-BlurEnabled
//
//  Created by Alexey Aleshkov on 09.01.14.
//  Copyright (c) 2014 Alexey Aleshkov. All rights reserved.
//

#import "BEViewController.h"
#import "UIDevice+BlurEnabled.h"

@interface BEViewController ()

@end

@implementation BEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSLog(@"Blur supported: %@", [[UIDevice currentDevice] be_blurEffectSupported] ? @"YES" : @"NO");
    NSLog(@"Blur active: %@", [[UIDevice currentDevice] be_blurEffectActive] ? @"YES" : @"NO");
    NSLog(@"Blur enabled: %@", [[UIDevice currentDevice] be_blurEffectEnabled] ? @"YES" : @"NO");
}

@end
