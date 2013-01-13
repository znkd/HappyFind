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

@implementation StageSelect
@synthesize m_StagesCount,stageLayer,ballonArr;

- (void) didLoadFromCCB
{ 
    NSArray*    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString*   docPath = [paths objectAtIndex:0];        
    if(![[NSFileManager defaultManager] fileExistsAtPath:[docPath stringByAppendingPathComponent:@"ccb"]])
    {//the first startup from app folder to get ccb.zip
        [CCBReader unzipResources:@"ccb.zip"];
    }
    
    //find icons folder
    int iconsCount = 0;
    
    NSString*   iPadPath = [docPath stringByAppendingPathComponent:@"iPad"];
    if(![[NSFileManager defaultManager] fileExistsAtPath:[iPadPath stringByAppendingPathComponent:@"icons"]])
    {//the first startup from app folder to get stage0.zip
        NSString* dst = [iPadPath stringByAppendingPathComponent:@"icons"];
        [[NSFileManager defaultManager] createDirectoryAtPath:dst withIntermediateDirectories:YES attributes:nil error:nil];
        NSString* src = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"icons.zip"];
        //unzip
        [SSZipArchive unzipFileAtPath:src toDestination:dst];
        
        //NSString* iconfolder = iPadPath stringByAppendingPathComponent:@"icons" 
    }
    
    NSString* folderName = [NSString stringWithFormat:@"icon%d",iconsCount];
    NSString* folderPath = [[iPadPath stringByAppendingPathComponent:@"icons"] stringByAppendingPathComponent:folderName];
    while ([[NSFileManager defaultManager] fileExistsAtPath:folderPath]) {
        folderName = [NSString stringWithFormat:@"icon%d",++iconsCount];
        folderPath = [[iPadPath stringByAppendingPathComponent:@"icons"] stringByAppendingPathComponent:folderName];
    }

    
    //NSMutableArray* layers = [[NSMutableArray alloc]initWithCapacity:3];
    //[layers addObject:ballonNode];
    //[layers addObject:ballon2Node];
    //[layers addObject:ballon3Node];
    

    
    int scrollLayerCount = iconsCount/7 + (iconsCount%7 == 0?0:1);
    
    NSMutableArray* arrSprites = [[NSMutableArray alloc]initWithCapacity:1];
    
    //ballonNode = [CCBReader nodeGraphFromFile:@"Ballon.ccbi"];
    //ballon2Node = [CCBReader nodeGraphFromFile:@"Ballon2.ccbi"];
    //ballon3Node = [CCBReader nodeGraphFromFile:@"Ballon3.ccbi"];
    ballonArr  = [[NSMutableArray alloc] initWithCapacity:1];
    
    for (int j=0; j<scrollLayerCount; j++) {
        BallonMenu* ballonM = nil;
        if (j%3 == 0) {
            ballonM = [CCBReader nodeGraphFromFile:@"Ballon.ccbi"];
        }
        else if(j%3 == 1)
        {
            ballonM = [CCBReader nodeGraphFromFile:@"Ballon2.ccbi"];
        }
        else
        {
            ballonM = [CCBReader nodeGraphFromFile:@"Ballon3.ccbi"];
        }
        
        [arrSprites addObject:ballonM.m_spriteIcon1];
        [arrSprites addObject:ballonM.m_spriteIcon2];
        [arrSprites addObject:ballonM.m_spriteIcon3];
        [arrSprites addObject:ballonM.m_spriteIcon4];
        [arrSprites addObject:ballonM.m_spriteIcon5];
        [arrSprites addObject:ballonM.m_spriteIcon6];
        [arrSprites addObject:ballonM.m_spriteIcon7];
        
        [ballonArr addObject:ballonM];
       
    }
    
    if (iconsCount > 0) {
        NSString* dst = [iPadPath stringByAppendingPathComponent:@"icons"];
        NSString* iconsPath = nil;
        for(int idx=0;idx < iconsCount;idx++)
        {
            NSString* sname = [NSString stringWithFormat:@"icon%d",idx];
            iconsPath = [dst stringByAppendingPathComponent:sname];
            NSString* iconImgPath = [iconsPath stringByAppendingPathComponent:@"icon.png"];
            if ([[NSFileManager defaultManager] fileExistsAtPath:iconImgPath]) {
                CCSprite* sprite = [[CCSprite alloc]initWithFile:iconImgPath];
                
                [[arrSprites objectAtIndex:idx] addChild:sprite];
            }
        }

    }
    
    
    CGSize winsize = [[CCDirector sharedDirector] winSize];
    stageLayer = [[CCScrollLayer alloc]initWithLayers:ballonArr widthOffset:0*winsize.width];
    [self addChild:stageLayer];

    
}
@end
