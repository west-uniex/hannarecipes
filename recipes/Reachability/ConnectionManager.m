//
//  ConnectionManager.m
//  Coordinate
//
//  Created by Ingar Melby on 11.06.13.
//  Copyright (c) 2013 Ingar Melby. All rights reserved.
//

#import "ConnectionManager.h"
#import "Reachability.h"

@interface ConnectionManager ()




- (void) checkNetworkStatus:(NSNotification *)notice;

@end


@implementation ConnectionManager


-(id)init
{
    self = [super init];
    if(self)
    {
        
    
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(checkNetworkStatus:)
                                                     name:kReachabilityChangedNotification
                                                   object:nil];
    
        _internetReachability = [Reachability reachabilityForInternetConnection];
        [_internetReachability startNotifier];
    
        _hostReachability = [Reachability reachabilityWithHostName:@"www.apple.com"];
        [_hostReachability startNotifier];
        
        _wifiReachability = [Reachability reachabilityForLocalWiFi];
        [_wifiReachability startNotifier];

    }
    
    return self;
}

- (void) checkNetworkStatus:(NSNotification *)notice
{
    NetworkStatus internetStatus = [self.internetReachability currentReachabilityStatus];
    switch (internetStatus)
    
    {
        case NotReachable:
        {
            DLog(@"The internet is down.");
            _internetActive = NO;
            
            break;
            
        }
        case ReachableViaWiFi:
        {
            DLog(@"The internet is working via WIFI.");
            _internetActive = YES;
            //[[CoordinateModel sharedInstance] postToServerSetOfUnupdatedCoordinates];
            
            break;
            
        }
        case ReachableViaWWAN:
        {
            DLog(@"The internet is working via WWAN.");
            _internetActive = YES;
            
            break;
            
        }
    }
    
    NetworkStatus hostStatus = [self.hostReachability currentReachabilityStatus];
    switch (hostStatus)
    
    {
        case NotReachable:
        {
            DLog(@"A gateway to the host server is down.");
            _hostActive = NO;
            
            break;
            
        }
        case ReachableViaWiFi:
        {
            DLog(@"A gateway to the host server is working via WIFI.");
            _hostActive = YES;
            
            break;
            
        }
        case ReachableViaWWAN:
        {
            DLog(@"A gateway to the host server is working via WWAN.");
            _hostActive = YES;
            
            break;
            
        }
    }
    
    NetworkStatus wifiStatus = [self.wifiReachability currentReachabilityStatus];
    
    switch (wifiStatus)
    
    {
        case NotReachable:
        {
            DLog(@"A gateway to the host server is down.");
            _localWiFiActive = NO;
            
            break;
            
        }
        case ReachableViaWiFi:
        {
            DLog(@"A gateway to the host server is working via WIFI.");
            _localWiFiActive = YES;
            
            break;
            
        }
        case ReachableViaWWAN:
        {
            DLog(@"A gateway to the host server is working via WWAN.");
            _localWiFiActive = NO;
            
            break;
            
        }
    }

    [self.delegate connectionManagerDidChangeState:self];
}

// If lower than SDK 5 : Otherwise, remove the observer as pleased.

- (void)dealloc
{
    [self.wifiReachability stopNotifier];
    [self.hostReachability stopNotifier];
    [self.internetReachability stopNotifier];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
-(void) chuckOfCode
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    //Change the host name here to change the server you want to monitor.
    NSString *remoteHostName = @"www.apple.com";
    NSString *remoteHostLabelFormatString = NSLocalizedString(@"Remote Host: %@", @"Remote host label format string");
    self.remoteHostLabel.text = [NSString stringWithFormat:remoteHostLabelFormatString, remoteHostName];
    
    //  remote host: www.apple.com
	self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
	[self.hostReachability startNotifier];
	[self updateInterfaceWithReachability:self.hostReachability];
    
    //  TCP/IP routing available
    self.internetReachability = [Reachability reachabilityForInternetConnection];
	[self.internetReachability startNotifier];
	[self updateInterfaceWithReachability:self.internetReachability];
    
    //  local WiFi
    self.wifiReachability = [Reachability reachabilityForLocalWiFi];
	[self.wifiReachability startNotifier];
	[self updateInterfaceWithReachability:self.wifiReachability];

}

*/

-(NSString *) description
{
    [super description];
    
    NSString *descriptionString = nil;
    
    descriptionString = [NSString stringWithFormat:@" %@ internetReachability: %@  hostReachability:%@ wifiReachability:%@  internetActive = %d hostActive= %d  localWiFiActive = %d", NSStringFromClass([self class]), self.internetReachability, self.hostReachability, self.wifiReachability, self.internetActive, self.hostActive, self.localWiFiActive ];
    
    
    return descriptionString;

}


@end
