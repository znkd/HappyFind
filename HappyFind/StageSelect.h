//
//  StageSelect.h
//  HappyFind
//
//  Created by zhangyuv on 13-1-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "CCNode.h"
#import "CCScrollLayer.h"
#import "CCBReader.h"


@interface StageSelect : CCNode
{
    CCNode* m_scroll;
}

@property(nonatomic,assign) int m_stageCount;
@property(nonatomic,strong) CCScrollLayer* m_scrollLayer;
@end
