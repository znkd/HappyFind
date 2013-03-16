//
//  BallonMenu.h
//  HappyFind
//
//  Created by zhangyuv on 13-1-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//
#import "cocos2d.h"

@interface Ballon : CCLayer
{
    CCNode* m_spriteIcon1;
    CCNode* m_spriteIcon2;
    CCNode* m_spriteIcon3;
    CCNode* m_spriteIcon4;
    CCNode* m_spriteIcon5;
    CCNode* m_spriteIcon6;
    CCNode* m_spriteIcon7;
    int m_stageNo;
    int m_layerNo;
    int m_levelNum;
    
}
@property(nonatomic,strong) CCNode* m_spriteIcon1;
@property(nonatomic,strong) CCNode* m_spriteIcon2;
@property(nonatomic,strong) CCNode* m_spriteIcon3;
@property(nonatomic,strong) CCNode* m_spriteIcon4;
@property(nonatomic,strong) CCNode* m_spriteIcon5;
@property(nonatomic,strong) CCNode* m_spriteIcon6;
@property(nonatomic,strong) CCNode* m_spriteIcon7;

-(void) setBallonWithLayerNo:(int) layerNo stageNo:(int) stageNo levelNum:(int) levelNum;
@end
