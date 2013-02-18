//
//  CCBResDelegate.m
//  HappyFind
//
//  Created by zzyy on 13-1-4.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "CCBResDelegate.h"
#import "ASIHTTPRequest.h"
#import "Loading.h"
#import "SSZipArchive.h"

@implementation CCBResDelegate

- (id)initWithControl:(Loading*) control
{
    if((self = [super init]))
    {
        m_control = control;
    }
    return self;
}
-(void) dealloc
{
    [m_versionServerPath release];
    [super dealloc];
}
- (void)versionRequestFinished:(ASIHTTPRequest*) request
{
    //get version from server
    NSString* versionServerPath = request.downloadDestinationPath;
    m_versionServerPath = [[NSString alloc] initWithString:versionServerPath]; 
    NSString* versionOfServer;
    NSData* dataOfServer = [NSData dataWithContentsOfFile:versionServerPath];
    versionOfServer = [[NSString alloc] initWithData:dataOfServer encoding:NSUTF8StringEncoding];
    
    //get local version from doc or app
    NSArray*    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString*   docPath = [paths objectAtIndex:0];
    NSString*   versionLocalPath;
    NSString*   versionOfLocal;
    
    if([[NSFileManager defaultManager] fileExistsAtPath:[docPath stringByAppendingPathComponent:@"version"]]){
        versionLocalPath = [docPath stringByAppendingPathComponent:@"version"];
    }
    else {
        versionLocalPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"version.txt"];
    }
    
    NSData* dataOfLocal = [NSData dataWithContentsOfFile:versionLocalPath];
    versionOfLocal = [[NSString alloc] initWithData:dataOfLocal encoding:NSUTF8StringEncoding];
    
    //compare local version between server
    if ([versionOfLocal compare:versionOfServer] != NSOrderedSame) {
        
        [m_control startCCBResRequest];
        
    }else {
        
        [m_control startIconsResRequest];
    } 
}

- (void)resRequestFinished:(ASIHTTPRequest*) request
{
    //ccb.zip from tmp unzip to doc
    NSArray*    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString*   docPath = [paths objectAtIndex:0];
    NSString*   unzipPath = [docPath stringByAppendingPathComponent:@"ccb"];
    //unzip
    [SSZipArchive unzipFileAtPath:request.downloadDestinationPath toDestination:unzipPath];
    //delete .zip
    NSFileManager *defaultManager;
    defaultManager = [NSFileManager defaultManager];
    [defaultManager removeItemAtPath:request.downloadDestinationPath  error:NULL];
    
    //version in tmp to doc
    NSString* src = m_versionServerPath;
    NSString* dst = [docPath stringByAppendingPathComponent:@"version"];
    [[NSFileManager defaultManager] moveItemAtPath: src toPath:dst error:nil];
    
    [m_control setProgressPercent:40];

    [m_control startIconsResRequest];
}

- (void)requestFailed:(ASIHTTPRequest*) request
{
    //[m_control startIconsResRequest];
    [m_control setProgressPercent:100];
    
    [m_control performSelector:@selector(gotoMenuScene) withObject:nil afterDelay:0.5];
    //[m_control gotoMenuScene];
}
@end
