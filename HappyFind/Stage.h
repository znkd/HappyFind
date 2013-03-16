//
//  Stage.h
//  HappyFind
//
//  Created by zhangnan on 13-3-7.
//
//

#import "cocos2d.h"

@interface Stage : CCLayer
{
    CCMenuItemImage* m_stageItem;
    int     m_iStageNo;
}
-(void) setIconFilePath:(NSString*) path withStageNo:(int) stageNo;
@end
