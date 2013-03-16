//
//  BallonMenu.m
//  HappyFind
//
//  Created by zhangyuv on 13-1-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "Ballon.h"

#import "LevelSelect.h"
#import "UserData.h"


@implementation Ballon
@synthesize m_spriteIcon1, m_spriteIcon2, m_spriteIcon3, m_spriteIcon4, m_spriteIcon5, m_spriteIcon6, m_spriteIcon7;

- (void) didLoadFromCCB
{ 

}

-(void) setBallonWithLayerNo:(int) layerNo stageNo:(int) stageNo levelNum:(int) levelNum
{
    int iPassLevel = [UserData sharedUserData].m_iPassLevel;
    m_layerNo = layerNo;
    m_stageNo = stageNo;
    m_levelNum = levelNum;
    NSArray*    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString*   docPath = [paths objectAtIndex:0];
    NSString*   iPadPath = [docPath stringByAppendingPathComponent:@"iPad"];
    
    NSMutableArray* arrSprites = [[NSMutableArray alloc]initWithCapacity:1];
    [arrSprites addObject:m_spriteIcon1];
    [arrSprites addObject:m_spriteIcon2];
    [arrSprites addObject:m_spriteIcon3];
    [arrSprites addObject:m_spriteIcon4];
    [arrSprites addObject:m_spriteIcon5];
    [arrSprites addObject:m_spriteIcon6];
    [arrSprites addObject:m_spriteIcon7];
    if (levelNum > 0) {
        NSString* dst = [iPadPath stringByAppendingPathComponent:@"stages"];
        NSString* iconsPath = nil;
        for(int idx=0;idx < [arrSprites count];idx++)
        {
            if(idx+layerNo*[arrSprites count] >= levelNum)
            {
                break;
            }
            NSString* level = [NSString stringWithFormat:@"level%d",idx+layerNo*[arrSprites count]];
            NSString* stage = [NSString stringWithFormat:@"stage%d",m_stageNo];
            iconsPath = [[dst stringByAppendingPathComponent:stage] stringByAppendingPathComponent:level];
            NSString* iconImgPath = [iconsPath stringByAppendingPathComponent:@"icon.png"];
            if ([[NSFileManager defaultManager] fileExistsAtPath:iconImgPath]) {
                CCSprite* sprite = [[CCSprite alloc]initWithFile:iconImgPath];
                [[arrSprites objectAtIndex:idx] addChild:sprite];
                if(iPassLevel < idx+layerNo*[arrSprites count])
                {
                    [sprite addChild:[CCSprite spriteWithFile:@"lock.png"]];
                }
                [sprite release];
            }
        }
        
    }
    [arrSprites release];
}


@end
