//
//  MainMenu.h
//  HappyFind
//
//  Created by zzyy on 12-8-14.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class FogAndStars;
@interface MainMenu : CCNode {
    CCSprite*   m_options;
    CCSprite*   m_twitter;
    CCSprite*   m_facebook;
    CCSprite*   m_about;
    CCSprite*   m_playBtn;
    FogAndStars* m_fogAndStars;
}

@end
