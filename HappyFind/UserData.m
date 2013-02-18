//
//  UserData.m
//  HappyDifference
//
//  Created by zzyy on 11-11-12.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "UserData.h"
#import "GameCtl.h"

@implementation UserData

@synthesize m_isSound,m_iPassStageNo,m_iPassLevel,m_passScoreAry,m_iHighScore;

#define config_file @"cfg.plist"

static UserData*  _sharedUserData = nil;

+(UserData*) sharedUserData
{
	if (!_sharedUserData) 
    {
        _sharedUserData = [[UserData alloc]init];
        
	}
    
	return _sharedUserData;
}
-(NSString*) dataFilepath
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* doc = [paths objectAtIndex:0];
    return [doc stringByAppendingPathComponent:config_file];
}

-(id)init
{
    if((self = [super init]))
    {
        NSString* filePath = [self dataFilepath];
        if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
        {
            NSDictionary* cfgDic = [NSDictionary dictionaryWithContentsOfFile:filePath];
            m_isSound = [(NSNumber*)[cfgDic objectForKey:@"issound"] intValue];
            NSNumber* passStageNo = [cfgDic objectForKey:@"passstageno"];
            m_iPassStageNo = [passStageNo intValue];
            NSNumber* passLevel = [cfgDic objectForKey:@"passlevel"];
            m_iPassLevel  = [passLevel intValue];
            NSNumber* highScore = [cfgDic objectForKey:@"highscore"];
            m_iHighScore  = [highScore intValue];
            
            m_passScoreAry = (NSMutableArray*)[cfgDic objectForKey:@"passscoreary"];
            [m_passScoreAry retain];
        }
        else
        {
            m_isSound = true;
            m_iPassStageNo = 0;
            m_iPassLevel = 0;
            m_iHighScore = 0;
            
            //read plist to memory
            
            NSDictionary* root = [GameCtl sharedGameCtl].m_difGameSceneDic;

            //photos group stage nums
            NSArray* stageAry = [root objectForKey:@"stages"];
            int stageNum = [stageAry count];
            m_passScoreAry = [[NSMutableArray alloc]init];
            
            for(int iCnt =0; iCnt < stageNum; iCnt++)
            {
                NSMutableArray* stageScoreAry = [[NSMutableArray alloc]init];
                int iLevelNum = [[stageAry objectAtIndex:iCnt]count];
                for(int iLoop =0; iLoop < iLevelNum; iLoop++)
                {
                    NSNumber* score = [[NSNumber alloc]initWithInt:0];
                    [stageScoreAry addObject:score];
                    [score release];
                }
                [m_passScoreAry addObject:stageScoreAry];
                [stageScoreAry release];
            }
        }
    }
    return  self;
}
-(void) saveData
{
    NSMutableDictionary* cfgDic = [[NSMutableDictionary alloc]init];
    NSNumber* isSound =[NSNumber numberWithInt:m_isSound];
    [cfgDic setObject:isSound forKey:@"issound"];
    NSNumber*   passStageNo = [NSNumber numberWithInt:m_iPassStageNo];
    [cfgDic setObject:passStageNo forKey:@"passstageno"];
    NSNumber*   passLevel = [NSNumber numberWithInt:m_iPassLevel];
    [cfgDic setObject:passLevel forKey:@"passlevel"];
    NSNumber*   highScore = [NSNumber numberWithInt:m_iHighScore];
    [cfgDic setObject:passLevel forKey:@"highscore"];
    
    [cfgDic setObject:m_passScoreAry forKey:@"passscoreary"];
    
    [cfgDic writeToFile:[self dataFilepath] atomically:YES];
    [cfgDic release];
}
// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)

	// don't forget to call "super dealloc"
    [m_passScoreAry release];
	[super dealloc];
}
@end
