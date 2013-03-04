//
//  FailedLevel.m
//  HappyFind
//
//  Created by zhangnan on 13-2-23.
//
//

#import "FailedLevel.h"
#import "CCBReader.h"

@implementation FailedLevel
- (void) didLoadFromCCB
{
    int i = 0;
    
}

- (void)replay
{
    [[CCDirector sharedDirector] replaceScene:[CCBReader sceneWithNodeGraphFromFile:@"game.ccbi"]];
}

- (void)goToSelectLevel
{
    [[CCDirector sharedDirector] replaceScene:[CCBReader sceneWithNodeGraphFromFile:@"level.ccbi"]];
}

@end
