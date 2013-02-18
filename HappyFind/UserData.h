//
//  UserData.h
//  HappyDifference
//
//  Created by zzyy on 11-11-12.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

@interface UserData : NSObject
{
    int     m_isSound;
    int     m_iPassStageNo;
    int     m_iPassLevel;
    int     m_iHighScore;
    NSMutableArray*  m_passScoreAry;
}
+(UserData*) sharedUserData;
-(void) saveData;
@property (assign) int    m_isSound;
@property (assign)  int     m_iPassStageNo;
@property (assign) int    m_iPassLevel;
@property (assign) NSMutableArray*   m_passScoreAry;
@property int   m_iHighScore;


@end
