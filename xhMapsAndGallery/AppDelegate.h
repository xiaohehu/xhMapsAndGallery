//
//  AppDelegate.h
//  xhMapsAndGallery
//
//  Created by Xiaohe Hu on 11/21/13.
//  Copyright (c) 2013 Xiaohe Hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "Reachability.h"

@class ViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    BOOL internetActive;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;

@property (nonatomic, retain) Reachability* internetReachable;
@property (nonatomic, retain) Reachability* hostReachable;
@property (nonatomic, retain) NSString *isWirelessAvailable;


+ (AppDelegate *)appDelegate;
@end
