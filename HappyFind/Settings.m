//
//  Settings.m
//  HappyFind
//
//  Created by zhangyuv on 13-1-3.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "Settings.h"
#import "CCBAnimationManager.h"
#import "CCBReader.h"

@interface Settings ()

@property (nonatomic,assign) boolean_t btnOptionsOn;
@property (nonatomic,assign) boolean_t btnVoiceOn;
@end

@implementation Settings
@synthesize btnOptionsOn=_btnOptionsOn,btnVoiceOn=_btnVoiceOn;

- (void) didLoadFromCCB
{ 
    _btnOptionsOn = false;
    _btnVoiceOn = true;
}

-(void) onSelectSettings
{
    _btnOptionsOn = !_btnOptionsOn;
    CCBAnimationManager* animationManager = self.userObject;
    //CCActionManager* animationManager = self.userObject;
    
    NSLog(@"animationManager: %@", animationManager);
    
    if (_btnOptionsOn) {
        [animationManager runAnimationsForSequenceNamed:@"Settings_On_Timeline"];
    }
    else {
        [animationManager runAnimationsForSequenceNamed:@"Settings_Off_Timeline"];
    }
    
}

-(void) onVoiceClick
{
    //[[CCDirector sharedDirector] replaceScene:[CCBReader sceneWithNodeGraphFromFile:@"about.ccbi"]];
    _btnVoiceOn = !_btnVoiceOn;
    if (_btnVoiceOn) {
        CCSprite* img = [CCSprite spriteWithFile:@"sound_o.png"];
        [m_voiceBtn setNormalImage:(CCNode<CCRGBAProtocol> *)img];
    }else {
        CCSprite* img = [CCSprite spriteWithFile:@"sound_c.png"];
        [m_voiceBtn setNormalImage:(CCNode<CCRGBAProtocol> *)img];
    }
}
@end
