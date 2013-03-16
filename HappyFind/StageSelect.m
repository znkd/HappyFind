//
//  StageSelect.m
//  HappyFind
//
//  Created by zhangyuv on 13-1-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "StageSelect.h"

#import "CCBReader.h"
#import "CCScrollLayer.h"
#import "Stage.h"

@implementation StageSelect
@synthesize m_stageCount,m_scrollLayer;

- (void) didLoadFromCCB
{
    NSMutableArray* layers;
    layers = [[NSMutableArray alloc] initWithCapacity:1];
    //find stage folder
    NSArray*    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString*   docPath = [paths objectAtIndex:0];
    int iStageNum = 0;
    NSString*   iPadPath = [docPath stringByAppendingPathComponent:@"iPad"];
    NSString* stageFolderName = [NSString stringWithFormat:@"stage%d",iStageNum];
    NSString* folderPath = [[iPadPath stringByAppendingPathComponent:@"stages"] stringByAppendingPathComponent:stageFolderName];
    while ([[NSFileManager defaultManager] fileExistsAtPath:folderPath]) {
        
        Stage* stage = (Stage*)[CCBReader nodeGraphFromFile:@"stage.ccbi"];
        [stage setIconFilePath:folderPath withStageNo:iStageNum];
        [layers addObject:stage];
        
        iStageNum++;
        NSString* stageFolderName = [NSString stringWithFormat:@"stage%d",iStageNum];
        folderPath = [[iPadPath stringByAppendingPathComponent:@"stages"] stringByAppendingPathComponent:stageFolderName];
    }
    
    //add to scroll layer
    CGSize winsize = [[CCDirector sharedDirector] winSize];
    m_scrollLayer = [[CCScrollLayer alloc]initWithLayers:layers widthOffset:0.6*winsize.width];
    [m_scroll addChild:m_scrollLayer];
    [layers release];
    
}



- (void)backToMenu
{
    [[CCDirector sharedDirector] popScene];
}

- (void)dealloc
{
    [m_scrollLayer release];
    [super dealloc];
}
@end
