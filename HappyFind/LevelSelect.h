//
//  StageSelect.h
//  HappyFind
//
//  Created by zhangyuv on 13-1-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#include "CCLayer.h"

@class CCNode;
@class CCScrollLayer;

@interface LevelSelect : CCLayer
{
    CCNode* m_scroll;
}

@property(nonatomic,assign) int m_LevelCount;
@property(nonatomic,strong) CCScrollLayer*  m_scrollLayer;

@property(nonatomic,assign) int m_stageNo;

-(void)setStageNumber:(int)stageNumber;
-(void)addTip;
@end
