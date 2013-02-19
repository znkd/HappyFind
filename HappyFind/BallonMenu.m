//
//  BallonMenu.m
//  HappyFind
//
//  Created by zhangyuv on 13-1-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "BallonMenu.h"
#import "CCBReader.h"

@implementation BallonMenu
@synthesize m_spriteIcon1, m_spriteIcon2, m_spriteIcon3, m_spriteIcon4, m_spriteIcon5, m_spriteIcon6, m_spriteIcon7;
- (void) didLoadFromCCB
{ 

}

-(void)selectBallonOne
{
    [[CCDirector sharedDirector] replaceScene:[CCBReader sceneWithNodeGraphFromFile:@"game.ccbi"]];
}

-(void)selectBallonTwo
{
    [[CCDirector sharedDirector] replaceScene:[CCBReader sceneWithNodeGraphFromFile:@"game.ccbi"]];
}

-(void)selectBallonThree
{
    [[CCDirector sharedDirector] replaceScene:[CCBReader sceneWithNodeGraphFromFile:@"game.ccbi"]];
}

-(void)selectBallonFour
{
    [[CCDirector sharedDirector] replaceScene:[CCBReader sceneWithNodeGraphFromFile:@"game.ccbi"]];
}

-(void)selectBallonFive
{
    [[CCDirector sharedDirector] replaceScene:[CCBReader sceneWithNodeGraphFromFile:@"game.ccbi"]];
}

-(void)selectBallonSix
{
    [[CCDirector sharedDirector] replaceScene:[CCBReader sceneWithNodeGraphFromFile:@"game.ccbi"]];
}

-(void)selectBallonSeven
{
    [[CCDirector sharedDirector] replaceScene:[CCBReader sceneWithNodeGraphFromFile:@"game.ccbi"]];
}

@end
