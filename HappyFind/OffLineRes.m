//
//  OffLineRes.m
//  HappyFind
//
//  Created by zzyy on 13-1-2.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "OffLineRes.h"
#import "ASIHTTPRequest.h"
#import "SSZipArchive.h"


@implementation OffLineRes

@synthesize m_pathOfDoc;
@synthesize m_tmpPathOfDoc;
@synthesize m_downloadDestinationPath;

-(id) initWithDelegate:(id<OffLineResDelegate> ) delegate
{
    // always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
    if((self = [super init]))
    {
        m_pathOfServer = [[NSString alloc] initWithString:@"http://192.168.1.102/"];
        NSArray*    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        m_pathOfDoc = [[paths objectAtIndex:0] retain];
        m_tmpPathOfDoc = [[m_pathOfDoc stringByAppendingPathComponent:@"tmp"] retain];
        [[NSFileManager defaultManager] createDirectoryAtPath:m_tmpPathOfDoc withIntermediateDirectories:YES attributes:nil error:nil];
        m_delegate = delegate;
        m_requestState = REQUEST_IDL;
        m_resState = RES_UNKONWN;
    }
    return self;
}

-(void) dealloc
{
    [m_tmpPathOfDoc release];
    [m_pathOfDoc release];
    [m_pathOfServer release];

    [super dealloc];
}

-(void) RequestAStartsynchronous:(NSString*) resName
{
    if (m_requestState != REQUEST_START) {
        NSString*   resquestStr = [m_pathOfServer stringByAppendingString:resName];
        NSURL*      requestUrl = [NSURL URLWithString:resquestStr];
        ASIHTTPRequest*  request;
        request = [ASIHTTPRequest requestWithURL:requestUrl];
        
        NSString* dst = [m_tmpPathOfDoc stringByAppendingPathComponent:resName];
        [request setDownloadDestinationPath: dst];
        [request setDelegate:self];

        [request startAsynchronous];
        m_requestState = REQUEST_START;
    }
}
-(void) RequestStartSynchronous:(NSString*) resName
{
    if (m_requestState != REQUEST_START) {
        NSString*   resquestStr = [m_pathOfServer stringByAppendingString:resName];
        NSURL*      requestUrl = [NSURL URLWithString:resquestStr];
        ASIHTTPRequest*  request;
        request = [ASIHTTPRequest requestWithURL:requestUrl];
        
        NSString* dst = [m_tmpPathOfDoc stringByAppendingPathComponent:resName];
        [request setDownloadDestinationPath: dst];
        
        [request startSynchronous];
        m_requestState = REQUEST_START;
    }
}

-(void)requestFinished:(ASIHTTPRequest*) request
{
    m_requestState = REQUEST_END;
    
    m_downloadDestinationPath = request.downloadDestinationPath;
    
    if([m_downloadDestinationPath rangeOfString:@".zip"].length){
        
        [m_delegate resRequestFinished:request];
        
    }else{
        [m_delegate versionRequestFinished:request];
    }

}
    
-(void)requestFailed:(ASIHTTPRequest
                     *)request

{
    m_requestState = REQUEST_END;
    NSError*    error = [request error];
    [m_delegate requestFailed:request];
}
    
    
@end
