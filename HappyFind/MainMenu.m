//
//  MainMenu.m
//  HappyFind
//
//  Created by zzyy on 12-8-14.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "MainMenu.h"
#import "cocos2d.h"
#import "CCBReader.h"

@implementation MainMenu
// This method is called right after the class has been instantiated
// by CCBReader. Do any additional initiation here. If no extra
// initialization is needed, leave this method out.
- (void) didLoadFromCCB
{    
    CCMoveTo* move = [CCMoveTo actionWithDuration:1 position:CGPointMake(216, 596)];

    [m_titleLogo runAction:move];
    
    CCMoveTo* move2 = [CCMoveTo actionWithDuration:1 position:CGPointMake(518, 120)];
    [m_play runAction:move2];
    
}

-(void) OnPlay
{
    [[CCDirector sharedDirector] replaceScene:[CCBReader sceneWithNodeGraphFromFile:@"room.ccbi"]];
}
@end
