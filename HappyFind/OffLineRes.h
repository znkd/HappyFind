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

@protocol OffLineResDelegate <NSObject>
- (void)versionRequestFinished:(ASIHTTPRequest*) request;
- (void)resRequestFinished:(ASIHTTPRequest*) request;
- (void)requestFailed:(ASIHTTPRequest*) request;
@end

@interface OffLineRes : NSObject
{
    NSString        *m_pathOfServer;
    NSString        *m_tmpPathOfDoc;
    NSString        *m_pathOfDoc;
    
    id<OffLineResDelegate> m_delegate;

    REQUEST_STATE   m_requestState;
    RES_STATE       m_resState;
    
    NSString*       m_downloadDestinationPath;
}
@property (nonatomic, assign) NSString* m_pathOfDoc;
@property (nonatomic, assign) NSString* m_tmpPathOfDoc;
@property (nonatomic, assign) NSString* m_downloadDestinationPath;

-(id) initWithDelegate:(id<OffLineResDelegate> ) delegate;
-(void) RequestAStartsynchronous:(NSString*) resName;
-(void) RequestStartSynchronous:(NSString*) resName;
@end
