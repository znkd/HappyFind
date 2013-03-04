//
//  IconsResDelegate.m
//  HappyFind
//
//  Created by zzyy on 13-1-5.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "IconsResDelegate.h"
#import "ASIHTTPRequest.h"
#import "SSZipArchive.h"
#import "Loading.h"

@implementation IconsResDelegate
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
    [super dealloc];
}
- (void)versionRequestFinished:(ASIHTTPRequest*) request
{
    
}
- (void)resRequestFinished:(ASIHTTPRequest*) request
{
    //ccb.zip from tmp unzip to doc
    NSArray*    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString*   docPath = [paths objectAtIndex:0];
    NSString*   tmp = [[docPath stringByAppendingPathComponent:@"iPad"] stringByAppendingPathComponent:@"tmp"];
    [[NSFileManager defaultManager] createDirectoryAtPath:tmp withIntermediateDirectories:YES attributes:nil error:nil];

    NSString*   unzipPath = [tmp stringByAppendingPathComponent:@"stages"];
    //unzip
    [SSZipArchive unzipFileAtPath:request.downloadDestinationPath toDestination:unzipPath];
    //delete .zip
    NSFileManager *defaultManager;
    defaultManager = [NSFileManager defaultManager];
    [defaultManager removeItemAtPath:request.downloadDestinationPath  error:NULL];
    [m_control setProgressPercent:100];
    [m_control performSelector:@selector(gotoMenuScene) withObject:nil afterDelay:0.5];
    //[m_control gotoMenuScene];
}
- (void)requestFailed:(ASIHTTPRequest*) request
{
    [m_control setProgressPercent:100];
    
    [m_control performSelector:@selector(gotoMenuScene) withObject:nil afterDelay:0.5];
    //[m_control gotoMenuScene];
}
@end
