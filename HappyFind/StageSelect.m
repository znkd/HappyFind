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
    CCScene* levelScene = [CCBReader sceneWithNodeGraphFromFile:@"level.ccbi"];
    
    LevelSelect* gameStageLevel = nil;
    
    CCArray* stageChildren = [levelScene children];
    
    for (id child in stageChildren) {
        if([child isKindOfClass:[LevelSelect class]])
        {
            gameStageLevel = child;
            break;
        }
    }
    
    if (gameStageLevel) {
        [gameStageLevel setStageNumber:8];
        
        [[CCDirector sharedDirector] replaceScene:levelScene];
    }

}

- (void)backToMenu
{
    [[CCDirector sharedDirector] replaceScene:[CCBReader sceneWithNodeGraphFromFile:@"menu.ccbi"]];
}

@end
