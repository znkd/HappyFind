//
//  GameCtl.h
//  super-find
//
//  Created by zzyy on 12-8-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameCtl : NSObject
{
    
    NSMutableArray* m_stagePathAry;
    NSDictionary* m_difGameSceneDic;
    NSString*   m_usrName;
    int         m_iExpOfUser;
    int         m_iLevelOfUser;
}
+(GameCtl *)sharedGameCtl;


@property(assign, readonly) NSDictionary* m_difGameSceneDic;
@property(assign, readonly) NSMutableArray* m_stagePathAry;
@end


