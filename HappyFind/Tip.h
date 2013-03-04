//
//  Tip.h
//  HappyFind
//
//  Created by zhangnan on 13-2-23.
//
//

#import "cocos2d.h"

@interface Tip : CCLayer
{
    CCSprite* m_levelPic;
    CCSprite* m_star1;
    CCSprite* m_star2;
    CCSprite* m_star3;
    CCSprite* m_star4;
    CCSprite* m_star5;
    int m_stageNum;
    int m_levelNum;
}

-(void)setStageNum:(int)stageNum AndlevelNum:(int)levelNum;
@end
