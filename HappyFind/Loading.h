//
//  Loading.h
//  HappyFind
//
//  Created by zzyy on 13-1-4.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class OffLineRes;
@class CCBResDelegate;
@class IconsResDelegate;

@class Reachability;

@interface Loading : CCNode {
    
    OffLineRes*  m_ccbResRequest;
    CCBResDelegate* m_ccbDelegate; 
    
    OffLineRes*  m_iconsResRequest;
    IconsResDelegate* m_iconsResDelegate;
    
    CCSprite* m_timeBg;
    NSInteger m_currentProgressTimerBarPercent;
    NSInteger m_ProgressTimerBarTargetPercent;
    
}
@property(atomic,assign) BOOL internetActive;
@property(nonatomic,strong) Reachability* internetReachable;
@property(nonatomic,strong) Reachability* hostReachable;
@property(nonatomic,strong) Reachability* wifiReachable;
@property(nonatomic,strong) NSCondition* condition;
@property(nonatomic,strong) CCProgressTimer* ct;


-(void) setProgressPercent:(NSInteger)integerPercent;

-(void) startCCBResRequest;
-(void) startIconsResRequest;
-(void) gotoMenuScene;

-(void) checkNetworkStatus:(NSNotification*)notice;

@end
