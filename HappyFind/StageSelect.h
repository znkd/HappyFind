//
//  StageSelect.h
//  HappyFind
//
//  Created by zhangyuv on 13-1-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "CCNode.h"
#import "BallonMenu.h"
#import "CCScrollLayer.h"

@interface StageSelect : CCNode

@property(nonatomic,assign) int m_StagesCount;
@property(nonatomic,strong) CCScrollLayer* stageLayer;
//@property(nonatomic,strong) BallonMenu* ballonNode;
//@property(nonatomic,strong) BallonMenu* ballon2Node;
//@property(nonatomic,strong) BallonMenu* ballon3Node;
@property(nonatomic,strong) NSMutableArray* ballonArr;
@end
