//
//  GameLayer.h
//  HappyFind
//
//  Created by zzyy on 12-8-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@interface CCAnimation(Helper)
+(CCAnimation*) animationWithFile:(NSString*)name frameCount:(int)frameCount delay:(float)delay;
@end

@interface GameLayer : CCLayer {
    
    //cocosbuilder
    CCSprite*           m_leftPicSprite;
    CCSprite*           m_rightPicSprite;
    CCNode*             m_answerNode;
    
    CCLayerColor*       m_readGoLayer;
    CCSprite*           m_ready;
    CCSprite*           m_go;
    
    CCSprite*           m_key1;
    CCSprite*           m_key2;
    CCSprite*           m_key3;
    CCSprite*           m_key4;
    CCSprite*           m_key5;
    
    int                 m_iNumOfFind;
    CGRect              m_touchRectLeft;
    CGRect              m_touchRectright;
    NSMutableArray*     m_answersPointAry;
    int                 m_itotalStage;
    int                 m_itotalLevel;
    int                 m_iCurStage;
    int                 m_iCurLevel;
    int                 m_orgImageWith;
    int                 m_midLength;
    
    NSString*           m_levelFolderRoot;
    
    //player info
    NSString*           m_nameOfPlayer1;
    BOOL                m_isMale;

    enum
    {
        GAMELAYER_IDLE,
        GAMELAYER_READY,
        GAMELAYER_PLAYING,
        GAMELAYER_WAITING,
        GAMELAYER_WILL_OVER,
        GAMELAYER_SUCESS,
    }GAMELAYER_STATUS;
}

@property(nonatomic,strong) CCProgressTimer* ct;

@end
