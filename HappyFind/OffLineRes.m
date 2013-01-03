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

-(id) init
{
    // always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
    if((self = [super init]))
    {
        m_pathOfServer = [[NSString alloc] initWithString:@"http://192.168.1.102"];
        NSArray*    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        m_pathOfDoc = [[paths objectAtIndex:0] retain];
        
        m_requestState = REQUEST_IDL;
        m_resState = RES_UNKONWN;
    }
    return self;
}

-(void) dealloc
{
    [m_pathOfDoc release];
    [m_pathOfServer release];

    [super dealloc];
}

-(void) offLineResStart:(int) kindNo
{
    if (m_requestState != REQUEST_START) {
        NSString*   resName = [NSString stringWithFormat:@"/stage%d.zip", kindNo];
        NSString*   resStr = [m_pathOfServer stringByAppendingString:resName];
        NSURL*      requestUrl = [NSURL URLWithString:resStr];
        ASIHTTPRequest*  request;
        request = [ASIHTTPRequest requestWithURL:requestUrl];
        
        NSString* dst = [m_pathOfDoc stringByAppendingString:resName];
        [request setDownloadDestinationPath: dst];
        [request setDelegate:self];

        [request startAsynchronous];
        m_requestState = REQUEST_START;
    }
}

-(void)requestFinished:(ASIHTTPRequest*) request
{
    
    NSString*   zipPath = request.downloadDestinationPath;

    NSString*   unzipPath = [zipPath stringByReplacingOccurrencesOfString:[zipPath lastPathComponent] withString:@"iPad"];

    [SSZipArchive unzipFileAtPath:zipPath toDestination:unzipPath];
    

    NSFileManager *defaultManager;
    defaultManager = [NSFileManager defaultManager];
    [defaultManager removeItemAtPath:zipPath error:NULL];

    m_requestState = REQUEST_END;
}
    
-(void)requestFailed:(ASIHTTPRequest
                     *)request

{
    m_requestState = REQUEST_END;
    NSError*    error = [request error];
    
}
    
    
@end
