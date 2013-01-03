//
//  About.h
//  HappyFind
//
//  Created by zhangyuv on 13-1-2.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"
#include "CCSprite.h"

@interface About : CCLayer
{
    CCSprite* m_aboutLogoHappy;
    CGPoint m_cgpoint;
    int m_detlaX;
	int m_detlaY;
}
@end

