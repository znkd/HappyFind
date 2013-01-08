//
//  FogAndStars.m
//  HappyFind
//
//  Created by zhangyuv on 13-1-8.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "FogAndStars.h"
#import "CCBReader.h"
#import "CCBAnimationManager.h"
@implementation FogAndStars
- (void) didLoadFromCCB
{    
    CCBAnimationManager* animationManager = self.userObject;
    
    NSLog(@"animationManager: %@", animationManager);
    
    [animationManager runAnimationsForSequenceNamed:@"Default Timeline"];
    
    
}

-(void) performFogComeIn
{
    CCBAnimationManager* animationManager = self.userObject;
    
    NSLog(@"animationManager: %@", animationManager);
    
    [animationManager runAnimationsForSequenceNamed:@"ComeIn_Timeline"];
}
@end
