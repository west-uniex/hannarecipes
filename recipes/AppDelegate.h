//
//  AppDelegate.h
//  recipes
//
//  Created by Anna Kondratyuk on 10/30/13.
//  Copyright (c) 2013 Anna Kondratyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ConnectionManager.h"



@interface AppDelegate : UIResponder <UIApplicationDelegate, ConnectionManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) ConnectionManager *connectionManager;

+ (AppDelegate *) sharedAppDelegate;

@end
