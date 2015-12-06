//
//  ConnectionManager.h
//  Coordinate
//
//  Created by Ingar Melby on 11.06.13.
//  Copyright (c) 2013 Ingar Melby. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Reachability;

@protocol ConnectionManagerDelegate;

@interface ConnectionManager : NSObject

@property (strong,readonly)  Reachability *internetReachability;
@property (strong,readonly)  Reachability *hostReachability;
@property (strong, readonly) Reachability *wifiReachability;



@property (readonly) BOOL internetActive;
@property (readonly) BOOL hostActive;
@property (readonly) BOOL localWiFiActive;

@property (nonatomic, weak) id <ConnectionManagerDelegate> delegate;

@end



@protocol ConnectionManagerDelegate <NSObject>

- (void) connectionManagerDidChangeState: (ConnectionManager *)connectionManager;

@end