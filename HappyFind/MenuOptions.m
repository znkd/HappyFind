//
//  MenuOptions.m
//  HappyFind
//
//  Created by zhangyuv on 13-1-2.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "MenuOptions.h"
#import "CCBAnimationManager.h"
#import "CCBReader.h"
@interface MenuOptions ()

@property (nonatomic,assign) boolean_t btnOptionsOn;
@end

@implementation MenuOptions
@synthesize btnOptionsOn=_btnOptionsOn;

- (void) didLoadFromCCB
{ 
    _btnOptionsOn = false;
}

-(void) onSelectOptions
{
    _btnOptionsOn = !_btnOptionsOn;
    CCBAnimationManager* animationManager = self.userObject;
    //CCActionManager* animationManager = self.userObject;
    
    NSLog(@"animationManager: %@", animationManager);
    
    if (_btnOptionsOn) {
        [animationManager runAnimationsForSequenceNamed:@"options_Timeline"];
    }
    else {
        [animationManager runAnimationsForSequenceNamed:@"options_return_Timeline"];
    }
    
}

-(void) onAboutClick
{
    [[CCDirector sharedDirector] replaceScene:[CCBReader sceneWithNodeGraphFromFile:@"about.ccbi"]];
}

@end
