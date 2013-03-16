//
//  Stage.m
//  HappyFind
//
//  Created by zhangnan on 13-3-7.
//
//

#import "Stage.h"

#import "UserData.h"
#import "CCBReader.h"
#import "LevelSelect.h"

@implementation Stage

- (void) didLoadFromCCB
{
        
}

-(void) setIconFilePath:(NSString*) path withStageNo:(int) stageNo
{
    m_iStageNo = stageNo;
    int iPassStageNo = [UserData sharedUserData].m_iPassStageNo;
    NSString* fileName_n = @"icon_n.png";
    NSString* fileName_s = @"icon_s.png";
    NSString* fileName_d = @"icon_d.png";

    CCSprite* image = [CCSprite spriteWithFile:[path stringByAppendingPathComponent:fileName_n]];
    [m_stageItem setNormalImage:(CCNode <CCRGBAProtocol>*)image];
    image = [CCSprite spriteWithFile:[path stringByAppendingPathComponent:fileName_s]];
    [m_stageItem setSelectedImage:(CCNode <CCRGBAProtocol>*)image];
    image = [CCSprite spriteWithFile:[path stringByAppendingPathComponent:fileName_d]];
    [m_stageItem setDisabledImage:(CCNode <CCRGBAProtocol>*)image];
    
    if (iPassStageNo < stageNo) {
        [m_stageItem setIsEnabled:NO];
    }

}
- (void)goToLevel
{
    LevelSelect* levelObj = (LevelSelect*)[CCBReader nodeGraphFromFile:@"level.ccbi"];
    [levelObj addBallonsByStageNo:m_iStageNo];
    [[CCDirector sharedDirector] pushScene: (CCScene*)levelObj];
}
@end
