//
//  StageSelect.m
//  HappyFind
//
//  Created by zhangyuv on 13-1-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "LevelSelect.h"

#import "Ballon.h"
#import "CCScrollLayer.h"
#import "UserData.h"
#import "CCBReader.h"
#import "Tip.h"
@implementation LevelSelect
@synthesize m_scrollLayer,m_stageNo;


-(void) dealloc
{
    [m_scrollLayer release];
    [super dealloc];
}
- (void) didLoadFromCCB
{
}

-(void)addBallonsByStageNo:(int)stageNo
{
    m_stageNo = stageNo;
    
    //find stage folder
    int iLevelNum = 0;
    NSArray*    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString*   docPath = [paths objectAtIndex:0];
    NSString*   iPadPath = [docPath stringByAppendingPathComponent:@"iPad"];
    NSString* level = [NSString stringWithFormat:@"level%d",iLevelNum];
    NSString* stage = [NSString stringWithFormat:@"stage%d",m_stageNo];
    NSString* folderPath = [[[iPadPath stringByAppendingPathComponent:@"stages"] stringByAppendingPathComponent:stage] stringByAppendingPathComponent:level];
    while ([[NSFileManager defaultManager] fileExistsAtPath:folderPath]) {
        NSString* level = [NSString stringWithFormat:@"level%d",iLevelNum];
        NSString* stage = [NSString stringWithFormat:@"stage%d",m_stageNo];
        folderPath = [[[iPadPath stringByAppendingPathComponent:@"stages"] stringByAppendingPathComponent:stage] stringByAppendingPathComponent:level];
        iLevelNum++;
    }
    
    int scrollLayerCount = iLevelNum/7 + (iLevelNum%7 == 0?0:1);
    NSMutableArray* layers  = [[NSMutableArray alloc] initWithCapacity:1];
    for (int j=0; j<scrollLayerCount; j++) {
        Ballon* ballonM = nil;
        //if (j%3 == 0) {
            ballonM = (Ballon*)[CCBReader nodeGraphFromFile:@"Ballon.ccbi" owner:self];
        //}
        //else if(j%3 == 1)
        //{
        //    ballonM = (Ballon*)[CCBReader nodeGraphFromFile:@"Ballon2.ccbi" owner:self];
        //}
        //else
        //{
        //   ballonM = (Ballon*)[CCBReader nodeGraphFromFile:@"Ballon3.ccbi" owner:self];
        //}
        
        [ballonM setBallonWithLayerNo:j stageNo:m_stageNo levelNum:iLevelNum];

        [layers addObject:ballonM];
        
    }
    

    CGSize winsize = [[CCDirector sharedDirector] winSize];
    m_scrollLayer = [[CCScrollLayer alloc]initWithLayers:layers widthOffset:0*winsize.width];
    [m_scroll addChild:m_scrollLayer];
    [layers release];

}

- (void)backToStage
{
    [[CCDirector sharedDirector] popScene];
}
-(void)selectBallon:(id)sender
{
    //get levelNo.
    int iTag = [(CCNode*)sender tag];
    
    int levelNumber = [m_scrollLayer currentScreen]*7+iTag;
    int stageNumber = m_stageNo;
    int iPassLevel = [UserData sharedUserData].m_iPassLevel;
    int iPassStage = [UserData sharedUserData].m_iPassStageNo;
    if(iPassLevel < levelNumber || iPassStage < stageNumber)
    {
        //unlock tip
        return;
    }
    //get tipnode
    Tip* tip = (Tip*)[CCBReader nodeGraphFromFile:@"Tip.ccbi"];
    [tip setStageNum:m_stageNo AndlevelNum:levelNumber];
    [self addChild:tip];
}

@end
