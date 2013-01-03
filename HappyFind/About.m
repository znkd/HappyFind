//
//  About.m
//  HappyFind
//
//  Created by zhangyuv on 13-1-2.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "About.h"
#import "CCBAnimationManager.h"
#import "CCBReader.h"

@implementation About
- (void) didLoadFromCCB
{ 
  m_cgpoint = CGPointMake(0, 0);
    m_aboutLogoHappy.position = ccp(377,300);
    
  [self scheduleUpdate];

}

-(void) onAboutBackClick
{
    [self unschedule:@selector(update)];
    
    [[CCDirector sharedDirector] replaceScene:[CCBReader sceneWithNodeGraphFromFile:@"menu.ccbi"]];
}

-(void) update:(ccTime)delta
{
	//screen's Size.
	//CGSize	winSize = [[CCDirector sharedDirector] winSize];
	
	//title change
	m_aboutLogoHappy.position = ccp(m_aboutLogoHappy.position.x, m_aboutLogoHappy.position.y+50*delta);
	
	//label change
	if ((m_aboutLogoHappy.position.y + 50*delta) >= 1400) {

		m_aboutLogoHappy.position = ccp(m_aboutLogoHappy.position.x, -63);
	}
	else if ((m_aboutLogoHappy.position.y - 30*delta) < -63 ) 
	{
		m_aboutLogoHappy.position = ccp(m_aboutLogoHappy.position.x, 1500);
	}
    
}

//touch start
- (void) onEnter
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
	[super onEnter];
}
- (void) onExit
{
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super onExit];
}
- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    //CCBAnimationManager* animationManager = self.userObject;
    
    
   // NSLog(@"animationManager: %@", animationManager);
    
    //[animationManager runAnimationsForSequenceNamed:@"Default Timeline"];
    //animationManager 
    [m_aboutLogoHappy pauseSchedulerAndActions];
    
	CGPoint location = [touch locationInView: [touch view]];
	m_cgpoint = [[CCDirector sharedDirector] convertToGL:location];
	
	return YES;
}

- (void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	//CGSize	winSize = [CCDirector sharedDirector].winSize;
	
	CGPoint location = [touch locationInView: [touch view]];
	location = [[CCDirector sharedDirector] convertToGL:location];
	
	m_detlaY = location.y - m_cgpoint.y;
    
    if (m_aboutLogoHappy) {
        m_aboutLogoHappy.position = ccp(m_aboutLogoHappy.position.x, m_aboutLogoHappy.position.y+m_detlaY);
        
    }

	//m_labelAbout.position = ccp(winSize.width/2,m_labelAbout.position.y + m_detlaY);
	//m_labelAbout2.position = ccp(winSize.width/2,m_labelAbout2.position.y + m_detlaY); 
	//title.position = ccp(winSize.width/2, title.position.y + m_detlaY);
    
    m_cgpoint = location;
	
	//return YES;
}

- (void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    [m_aboutLogoHappy resumeSchedulerAndActions];
}

@end
