//
//  CCBResDelegate.h
//  HappyFind
//
//  Created by zzyy on 13-1-4.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OffLineRes.h"
@class Loading;

@interface CCBResDelegate : NSObject<OffLineResDelegate> {
    Loading*  m_control;
    NSString* m_versionServerPath;
}
- (id)initWithControl:(Loading*) control;

- (void)versionRequestFinished:(ASIHTTPRequest*) request;
- (void)resRequestFinished:(ASIHTTPRequest*) request;
- (void)requestFailed:(ASIHTTPRequest*) request;
@end
