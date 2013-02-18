//
//  Loading.m
//  HappyFind
//
//  Created by zzyy on 13-1-4.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "Loading.h"
#import "CCBReader.h"

#import "CCBResDelegate.h"
#import "IconsResDelegate.h"
#import "Reachability.h"

@implementation Loading
@synthesize internetActive;
@synthesize internetReachable;
@synthesize hostReachable;
@synthesize wifiReachable;
@synthesize condition;
@synthesize ct;

-(void)checkNetworkStatus:(NSNotification *)notice
{
    if (!self.condition) {
        return ;
    }
    
//    [self.condition lock];
    
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    switch (internetStatus) {
        case NotReachable:
        {
            NSLog(@"the internet is down.");
            self.internetActive = NO;
            break;
        }
        case ReachableViaWiFi:
        {
            NSLog(@"the internet is working via WIFI.");
            self.internetActive = YES;
            break;
        }
        case ReachableViaWWAN:
        {
            NSLog(@"the internet is working via wwan.");
            self.internetActive = YES;
            break;
        }
        default:
            break;
    }
    
//    if (self.internetActive == YES) {
//        UIAlertView* alertview = [[UIAlertView alloc] initWithTitle:@"Network Tip" message:@"this is a test." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alertview show];
        
//        [self.condition signal];
//    }
    
//    [self.condition unlock];

}

-(void)checkNetwork
{
    //check for internet connection
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus:) name:kReachabilityChangedNotification object:nil];
    self.internetReachable = [Reachability reachabilityForInternetConnection];
    [self.internetReachable startNotifier];
    
    //check if a pathway to a random host exits
    self.hostReachable = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [self.hostReachable startNotifier];
    
    //check wifi
    self.wifiReachable = [Reachability reachabilityForLocalWiFi];
    [self.wifiReachable startNotifier];
}

-(void) setProgressPercent:(NSInteger)integerPercent
{
    m_ProgressTimerBarTargetPercent = integerPercent;
}

- (void) didLoadFromCCB
{
    //test network
    self.internetActive = NO;
    self.condition = [[NSCondition alloc]init];
    m_currentProgressTimerBarPercent = 0;
    m_ProgressTimerBarTargetPercent = 1;
    
    [self scheduleUpdate];
    
    //position:(120,0)
    CCSprite* timeProgress = [[CCSprite alloc]initWithFile:@"time.png"];
    
    self.ct = [[CCProgressTimer alloc]initWithSprite:timeProgress];
    self.ct.percentage = 0;
    self.ct.type = kCCProgressTimerTypeBar;
    self.ct.anchorPoint = CGPointMake(0, 0);
    [self.ct setMidpoint:CGPointMake(0, 0)];
    self.ct.position = CGPointMake(120.0f, 0.0f);
    [self addChild:self.ct];
    
    
    [self checkNetwork];
    
    //net ok is 10 percent.
    
//    //waiting while alertview is done.
//    [self.condition lock];
//    while (self.internetActive == NO) {
//        //[NSThread sleepForTimeInterval:0.5];
//        [self.condition wait];
//    }
    
    //download res ccb & icon ccb
    m_ccbDelegate = [[CCBResDelegate alloc] initWithControl:self];
    m_ccbResRequest = [[OffLineRes alloc] initWithDelegate:m_ccbDelegate];
    [m_ccbResRequest RequestAStartsynchronous:@"version"];
    
    m_iconsResDelegate = [[IconsResDelegate alloc] initWithControl:self];
    m_iconsResRequest =[[OffLineRes alloc] initWithDelegate:m_iconsResDelegate];
    
//    [self.condition unlock];
}

-(void)update:(ccTime)tm
{
    if(m_ProgressTimerBarTargetPercent < m_currentProgressTimerBarPercent)
    {
        
        return ;
    }
    
    self.ct.percentage = m_currentProgressTimerBarPercent++;
    
}

-(void) dealloc
{
    [m_ccbDelegate release];
    [m_ccbResRequest release];
    
    [m_iconsResDelegate release];
    [m_iconsResRequest release];
    [super dealloc];
}
-(void) startCCBResRequest
{
    [m_ccbResRequest RequestAStartsynchronous:@"ccb.zip"];
}
-(void) startIconsResRequest
{
    [m_iconsResRequest RequestAStartsynchronous:@"icons.zip"];
}
-(void) gotoMenuScene
{
    self.ct.percentage = 0;
    [[CCDirector sharedDirector] runWithScene:[CCBReader sceneWithNodeGraphFromFile:@"menu.ccbi"]];
}

@end
