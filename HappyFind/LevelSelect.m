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
#import "CCBReader.h"
#import "Tip.h"
#import "StageSelect.h"
@implementation LevelSelect
@synthesize m_scrollLayer,m_stageNo;

-(void) addTip
{
    [self addChild:[CCBReader nodeGraphFromFile:@"Tip.ccbi"]];
}
-(void)setStageNumber:(int)stageNumber
{
    m_stageNo = stageNumber;
}
-(id)init
{
    self = [super init];
    if (self) {
        
        CCNode* parent = self.parent;
        
        StageSelect* gameStage = nil;
        
        CCArray* stageChildren = [parent children];
        
        for (id child in stageChildren) {
            if([child isKindOfClass:[StageSelect class]])
            {
                gameStage = child;
                
                m_stageNo = [gameStage getCurrentStageNo];
                break;
            }
        }

    }
    
    return self;
}

-(void) dealloc
{
    [m_scrollLayer release];
    [super dealloc];
}
- (void) didLoadFromCCB
{
}

-(void)initGameIcons:(int)stageNo
{
    NSArray*    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString*   docPath = [paths objectAtIndex:0];
    
    //find stage folder
    int iLevelNum = 0;
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
    
    NSMutableArray* arrSprites = [[NSMutableArray alloc]initWithCapacity:1];
    
    NSMutableArray* layers  = [[NSMutableArray alloc] initWithCapacity:1];
    for (int j=0; j<scrollLayerCount; j++) {
        Ballon* ballonM = nil;
        if (j%3 == 0) {
            ballonM = [CCBReader nodeGraphFromFile:@"Ballon.ccbi" owner:self];
        }
        else if(j%3 == 1)
        {
            ballonM = [CCBReader nodeGraphFromFile:@"Ballon2.ccbi" owner:self];
        }
        else
        {
            ballonM = [CCBReader nodeGraphFromFile:@"Ballon3.ccbi" owner:self];
        }
        
        [arrSprites addObject:ballonM.m_spriteIcon1];
        [arrSprites addObject:ballonM.m_spriteIcon2];
        [arrSprites addObject:ballonM.m_spriteIcon3];
        [arrSprites addObject:ballonM.m_spriteIcon4];
        [arrSprites addObject:ballonM.m_spriteIcon5];
        [arrSprites addObject:ballonM.m_spriteIcon6];
        [arrSprites addObject:ballonM.m_spriteIcon7];
        
        [layers addObject:ballonM];
        
    }
    
    if (iLevelNum > 0) {
        NSString* dst = [iPadPath stringByAppendingPathComponent:@"stages"];
        NSString* iconsPath = nil;
        for(int idx=0;idx < iLevelNum;idx++)
        {
            NSString* level = [NSString stringWithFormat:@"level%d",idx];
            NSString* stage = [NSString stringWithFormat:@"stage%d",m_stageNo];
            iconsPath = [[dst stringByAppendingPathComponent:stage] stringByAppendingPathComponent:level];
            NSString* iconImgPath = [iconsPath stringByAppendingPathComponent:@"icon.png"];
            if ([[NSFileManager defaultManager] fileExistsAtPath:iconImgPath]) {
                CCSprite* sprite = [[CCSprite alloc]initWithFile:iconImgPath];
                
                [[arrSprites objectAtIndex:idx] addChild:sprite];
            }
        }
        
    }
    [arrSprites release];
    
    
    CGSize winsize = [[CCDirector sharedDirector] winSize];
    m_scrollLayer = [[CCScrollLayer alloc]initWithLayers:layers widthOffset:0*winsize.width];
    [m_scroll addChild:m_scrollLayer];
    [layers release];

}

- (void)backToStage
{
    //[[CCDirector sharedDirector] replaceScene:[CCBReader sceneWithNodeGraphFromFile:@"stage.ccbi"]];
    //[[CCDirector sharedDirector] popScene];
    [self removeFromParentAndCleanup:YES];
}
-(void)selectBallon:(id)sender
{
    //get levelNo.
    int iTag = [(CCNode*)sender tag];
    
    int levelNumber = [m_scrollLayer currentScreen]*7+iTag;
    
    //get tipnode
    CCNode* tipScene = [CCBReader nodeGraphFromFile:@"Tip.ccbi"];
    
    Tip* tip = tipScene;
    
    /*CCArray* stageChildren = [tipScene children];
    
    for (id child in stageChildren) {
        if([child isKindOfClass:[Tip class]])
        {
            tip = child;
            break;
        }
    }*/
    
    if (tip) {
        [tip setStageNum:m_stageNo AndlevelNum:levelNumber];
        
        
        [self addChild:tipScene];
    }

    
}

@end
