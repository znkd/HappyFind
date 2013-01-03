//
//  OffLineRes.h
//  HappyFind
//
//  Created by zzyy on 13-1-2.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    REQUEST_IDL =0,
    REQUEST_START,
    REQUEST_PAUSE,
    REQUEST_END,
}REQUEST_STATE;

typedef enum
{
    RES_UNKONWN,
    RES_LASTEST,
    RES_PASTED
}RES_STATE;

@class ASIHTTPRequest;
@interface OffLineRes : NSObject
{
    NSString        *m_pathOfServer;
    NSString        *m_pathOfDoc;

    REQUEST_STATE   m_requestState;
    RES_STATE       m_resState;
}
-(void) offLineResStart:(int) kindNo;

@end
