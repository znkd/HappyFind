//
//  Tip.m
//  HappyFind
//
//  Created by zhangnan on 13-2-23.
//
//

#import "Tip.h"
#import "CCBReader.h"

@implementation Tip
-(void)setStageNum:(int)stageNum AndlevelNum:(int)levelNum
{
    m_stageNum = stageNum;
    m_levelNum = levelNum;
}

- (void) didLoadFromCCB
{
    
}

- (void) registerWithTouchDispatcher
{
    CCDirector *director = [CCDirector sharedDirector];
    [[director touchDispatcher] addTargetedDelegate:self priority:-128 swallowsTouches:YES];
}

- (void)levelSelectedToPlay
{
    [[CCDirector sharedDirector] replaceScene:[CCBReader sceneWithNodeGraphFromFile:@"game.ccbi"]];
}
- (void)cancelTip
{
    [[self parent] removeChild:self cleanup:YES];
}
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    
}
@end
