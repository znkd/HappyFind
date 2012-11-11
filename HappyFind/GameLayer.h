//
//  GameLayer.h
//  HappyFind
//
//  Created by zzyy on 12-8-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameLayer : CCLayer {
    
    //cocosbuilder
    CCSprite*       m_roomBg;
    
    CCSprite*       m_player1;
    CCSprite*       m_bgOfP1;
    CCLabelTTF*       m_titleOfP1;
    
    CCSprite*     m_player2;
    CCSprite*     m_player3;
    CCSprite*     m_player4;
    
    CCNode*     m_photoNodeRoot;
    CCSprite*     m_leftPicSprite;
    CCSprite*     m_rightPicSprite;
    CCNode*     m_answerNode;
    CCLayerColor* m_readGoLayer;
    CCSprite*   m_ready;
    CCSprite*   m_go;
    
    CCNode*   m_playerStatusNodeRoot;
    CCSprite* m_playerStatusBg;
    CCSprite* m_player1Status;
    CCSprite* m_player2Status;
    CCSprite* m_player3Status;
    CCSprite* m_player4Status;
    CCSprite* m_photoIndex;
    
    int                m_iNumOfFind;
    CGRect             m_touchRectLeft;
    CGRect             m_touchRectright;
    NSMutableArray*    m_answersPointAry;
    int                m_itotalStage;
    int                m_itotalLevel;
    int                m_iCurStage;
    int                m_iCurLevel;
    int                m_orgImageWith;
    int                m_midLength;
    
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

@end
