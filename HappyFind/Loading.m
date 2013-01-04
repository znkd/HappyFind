//
//  Loading.m
//  HappyFind
//
//  Created by zzyy on 13-1-4.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "Loading.h"
#import "CCBReader.h"

#import "CCBResDelegate.h"

@implementation Loading

- (void) didLoadFromCCB
{ 
    m_ccbDelegate = [[CCBResDelegate alloc] initWithControl:self];
    m_ccbResRequest = [[OffLineRes alloc] initWithDelegate:m_ccbDelegate];
    [m_ccbResRequest RequestAStartsynchronous:@"version"];
}
-(void) dealloc
{
    [m_ccbDelegate release];
    [m_ccbResRequest release];
    [super dealloc];
}
-(void) startCCBResRequest
{
    [m_ccbResRequest RequestAStartsynchronous:@"ccb.zip"];
}
-(void) gotoMenuScene
{
    [[CCDirector sharedDirector] runWithScene:[CCBReader sceneWithNodeGraphFromFile:@"menu.ccbi"]];
}

@end
