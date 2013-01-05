//
//  Loading.h
//  HappyFind
//
//  Created by zzyy on 13-1-4.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class OffLineRes;
@class CCBResDelegate;
@class IconsResDelegate;

@interface Loading : CCNode {
    
    OffLineRes*  m_ccbResRequest;
    CCBResDelegate* m_ccbDelegate; 
    
    OffLineRes*  m_iconsResRequest;
    IconsResDelegate* m_iconsResDelegate;
}
-(void) startCCBResRequest;
-(void) startIconsResRequest;
-(void) gotoMenuScene;
@end
