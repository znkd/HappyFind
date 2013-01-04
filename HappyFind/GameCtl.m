//
//  GameCtl.m
//  super-find
//
//  Created by zzyy on 12-8-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import "GameCtl.h"
#import "CCBReader.h"
#import "OffLineRes.h"

@implementation GameCtl

static GameCtl* _sharedGameCtl = nil;

@synthesize m_difGameSceneDic,m_stagePathAry;

+(GameCtl *)sharedGameCtl
{
    if (!_sharedGameCtl) {
        _sharedGameCtl = [[self alloc] init];
        
        NSArray*    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString*   docPath = [paths objectAtIndex:0];        
        if(![[NSFileManager defaultManager] fileExistsAtPath:[docPath stringByAppendingPathComponent:@"ccb"]])
        {//the first startup from app folder to get ccb.zip
            [CCBReader unzipResources:@"ccb.zip"];
        }

    }
    return _sharedGameCtl;
}

-(id) init
{
    // always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
    if((self = [super init]))
    {
        m_stagePathAry = [[NSMutableArray alloc]init];
        
        
        NSArray*    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString*   docPath = [paths objectAtIndex:0];
        NSString*  resPictureRoot =  [docPath stringByAppendingPathComponent:@"iPad"];
        
        //get stage folder
        for(int iCnt =0;;iCnt++)
        {
            NSString*   stageNoStr = [NSString stringWithFormat:@"stage%d",iCnt];
            NSString*   stageFloderPath = [resPictureRoot stringByAppendingPathComponent:stageNoStr];
            BOOL isDir = NO;    
            [[NSFileManager defaultManager] fileExistsAtPath:stageFloderPath isDirectory:(&isDir)];  
            if (isDir) {  
                [m_stagePathAry addObject:stageFloderPath];  
            }  
            if(isDir == NO)
                break;
        }
        
        NSString*   difGameScenePath = [resPictureRoot stringByAppendingPathComponent:@"GameCtl.plist"];
        m_difGameSceneDic = [NSDictionary dictionaryWithContentsOfFile:difGameScenePath];
        [m_difGameSceneDic retain];//note
    }
	return self;
}

-(void) dealloc
{
    [m_stagePathAry release];
    [m_difGameSceneDic release];
    [super dealloc];
}


@end
