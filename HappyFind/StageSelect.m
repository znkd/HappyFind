//
//  StageSelect.m
//  HappyFind
//
//  Created by zhangyuv on 13-1-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "StageSelect.h"
#import "CCBReader.h"
#import "SSZipArchive.h"
#import "LevelSelect.h"

@implementation CCBReader (HappyFind)

-(CCScene*) sceneWithStage:(CCScene*)scene stage:(int)stage
{
    LevelSelect* gameStageLevel = nil;
    
    CCArray* stageChildren = [scene children];
    
    for (id child in stageChildren) {
        [child isKindOfClass:[LevelSelect class]];
        gameStageLevel = child;
    }
    
    [gameStageLevel setStageNumber:stage];
    
    return scene;
}

@end

@implementation StageSelect
@synthesize m_stageCount,m_scrollLayer;

- (void) didLoadFromCCB
{

    
}

- (void)goToLevel
{

    CCNode* level = [CCBReader nodeGraphFromFile:@"level.ccbi"];
    
    LevelSelect* gameStageLevel = level;

    
    if (gameStageLevel) {

        LevelSelect* levelObj = level;
        [levelObj initGameIcons:2];
        [self addChild:levelObj];
    }

}

- (void)backToMenu
{
    [[CCDirector sharedDirector] popScene];
}

@end
