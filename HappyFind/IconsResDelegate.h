//
//  IconsResDelegate.h
//  HappyFind
//
//  Created by zzyy on 13-1-5.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OffLineRes.h"

@class Loading;
@interface IconsResDelegate : NSObject<OffLineResDelegate> {
        Loading*  m_control;
}
- (id)initWithControl:(Loading*) control;

- (void)versionRequestFinished:(ASIHTTPRequest*) request;
- (void)resRequestFinished:(ASIHTTPRequest*) request;
- (void)requestFailed:(ASIHTTPRequest*) request;
@end
