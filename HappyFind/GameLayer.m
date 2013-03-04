//
//  GameLayer.m
//  HappyFind
//
//  Created by zzyy on 12-8-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"
#import "GameCtl.h"
#import "SimpleAudioEngine.h"
#import "sprite+texture.h"
#import "CCBReader.h"
#import "AppDelegate.h"
@implementation CCAnimation(Helper)
+(CCAnimation*) animationWithFile:(NSString*)name frameCount:(int)frameCount delay:(float)delay
{
    NSMutableArray* frames = [NSMutableArray arrayWithCapacity:frameCount];
    for(int i =0; i<frameCount; i++)
    {
        NSString* file = [NSString stringWithFormat:@"%drb.png",30*(i+1)];
        CCTexture2D* texture = [[CCTextureCache sharedTextureCache] addImage:file];
        
        CGSize texSize = texture.contentSize;
        CGRect texRect = CGRectMake(0, 0, texSize.width, texSize.height);
        CCSpriteFrame* frame = [CCSpriteFrame frameWithTexture:texture rect:texRect];
        [frames addObject:frame];
    }
    //return [CCAnimation animationWithName:name delay:delay frames:frames];
    return [CCAnimation animationWithSpriteFrames:frames delay:delay];
}
@end

@implementation GameLayer
@synthesize ct;

-(void) randStateAndLevel
{
    //read No.stage answers an No.photo
    NSDictionary* GameCtlRoot = [GameCtl sharedGameCtl].m_difGameSceneDic;
    //photos group stage nums
    NSArray* stageAry = [GameCtlRoot objectForKey:@"stages"];
    
    m_itotalStage = [stageAry count];
    NSArray* stage = [stageAry objectAtIndex:m_iCurStage];
    m_itotalLevel = [stage count];
    
    m_iCurStage = 0;
    m_iCurLevel = 0;
}
-(void) drawAnswersWithRandFlag:(BOOL) bFlag
{
    //answers
    NSString*   answerPath = [m_levelFolderRoot stringByAppendingPathComponent:@"answers.plist"];
    NSDictionary* answersDic = [NSDictionary dictionaryWithContentsOfFile:answerPath];
    m_answersPointAry = [[NSMutableArray alloc]init];
    NSArray* answers = [answersDic objectForKey:@"answers"];
    NSMutableArray* copyAnswers = [NSMutableArray arrayWithArray:answers];
    //get random answer for 5 answers
    for(int iCnt = 0 ;iCnt < 5; iCnt++)
    {
        if([copyAnswers count] >0)
        {
            NSDictionary* item;
            if(bFlag)
            {
                int randIndex = rand()%[copyAnswers count];
                item = [copyAnswers objectAtIndex:randIndex];
                [copyAnswers removeObject:item];
            }
            else
            {
                item = [copyAnswers objectAtIndex:iCnt];
            }
            //draw answer png
            NSString*   name = [item objectForKey:@"name"];
            NSString*   namePath = [m_levelFolderRoot stringByAppendingPathComponent:name];
            CCSprite*   answerSprite = [CCSprite spriteWithFile:namePath];
            NSString*   xStr = [item objectForKey:@"x"];
            NSString*   yStr = [item objectForKey:@"y"];
            CGPoint     point = ccp(xStr.floatValue, yStr.floatValue);
            [answerSprite setPosition:point];
            [m_answerNode addChild:answerSprite];
            [m_answersPointAry addObject:item];
        }
    }
}
-(void) drawPhoto
{
    //draw photo
    //read No.stage answers an No.photo
    NSArray*    stagePathAry = [GameCtl sharedGameCtl].m_stagePathAry;
    NSString*   stagePath = [stagePathAry objectAtIndex:m_iCurStage];    
    NSString*   levelNoStr = [NSString stringWithFormat:@"level%d",m_iCurLevel+1];
    m_levelFolderRoot = [stagePath stringByAppendingPathComponent:levelNoStr];
    NSString*   orgPath = [m_levelFolderRoot stringByAppendingPathComponent:@"origin.png"];
    
    UIImage*  orgImage = [UIImage imageWithContentsOfFile:orgPath];
    m_orgImageWith = orgImage.size.width;
    int orgImageHeigh = orgImage.size.height;
    m_midLength = 4;
    
    CGImageRef roleImage = orgImage.CGImage;
    CCTexture2D*    roleTex = [[CCTexture2D alloc] initWithCGImage:roleImage resolutionType:kCCResolutionUnknown];

    [m_leftPicSprite setTexture:roleTex];
    [m_rightPicSprite setTexture:roleTex];
    
    //touch range
    m_touchRectLeft = CGRectMake(0, 0, m_orgImageWith, orgImageHeigh);
    m_touchRectright = CGRectMake(m_orgImageWith+m_midLength, 0, m_orgImageWith, orgImageHeigh);
}
-(void) drawReadyGoLayer
{

    [m_ready runAction:[CCSequence actions:
                            [CCDelayTime actionWithDuration:0.5],
                            [CCFadeOut actionWithDuration:0.5],nil]];
    [m_go runAction:[CCSequence actions:
                         [CCDelayTime actionWithDuration:0.5],
                         [CCFadeIn actionWithDuration:0.5],[CCFadeOut actionWithDuration:0.5],
                         [CCCallFunc actionWithTarget:self selector:@selector(removeReadyGoLayer)],nil]];
}
-(void) removeReadyGoLayer
{
    [self removeChild:m_readGoLayer cleanup:YES];
    
}
-(void) hideWaitingRoom
{
    m_roomBg.visible = NO;
}

-(void) initPlayingRoom
{
    m_playerStatusNodeRoot.visible = YES;
    
    m_photoNodeRoot.visible = YES;
    
    [self randStateAndLevel];
    [self drawPhoto];
    [self drawAnswersWithRandFlag:YES];
}

-(void) startGame:(id)sender
{
    NSArray*    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString*   docPath = [paths objectAtIndex:0];
    NSString*   tmp = [docPath stringByAppendingPathComponent:@"ccb"];
    [m_key1 setTextureWithFile:[tmp stringByAppendingPathComponent:@"key.png"]];
    [m_key2 setTextureWithFile:[tmp stringByAppendingPathComponent:@"key.png"]];
    [m_key3 setTextureWithFile:[tmp stringByAppendingPathComponent:@"key.png"]];
    [m_key4 setTextureWithFile:[tmp stringByAppendingPathComponent:@"key.png"]];
    [m_key5 setTextureWithFile:[tmp stringByAppendingPathComponent:@"key.png"]];
    
    //1:hide waiting room
    [self hideWaitingRoom];
    
    //2:init playing room
    [self initPlayingRoom];
}

-(void) initWaitingRoom
{
    [self startGame:nil];
    
    //player info
    int iNumOfPlayer=2;
    BOOL bIsMale1 = FALSE;
    BOOL bIsMale2 = FALSE;
    int  bgP1 = 1;
    int  bgP2 = 2;
    NSString* titleP1 = @"player1";
    NSString* tilteP2 = @"player2";
    //
    
    m_player1.visible = FALSE;
    m_player2.visible = FALSE;
    m_player3.visible = FALSE;
    m_player4.visible = FALSE;
    switch (iNumOfPlayer) 
    {
            
        case 4:
            m_player4.visible = TRUE;
        case 3:
            m_player3.visible = TRUE;
        case 2:
            m_player2.visible = TRUE;
            if(bIsMale2)
            {
                // NSString*  resRoot =  [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"room"];
                
            }
            else 
            {
                NSString*  path =  [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"room"];
                path = [path stringByAppendingPathComponent:@"female-n.png"];
                [m_player2 setTextureWithFile:path];
            }
        case 1:
            m_player1.visible = TRUE;
            if(bIsMale1)
            {
                // NSString*  resRoot =  [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"room"];
                
            }
            else 
            {
                NSString*  path =  [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"room"];
                path = [path stringByAppendingPathComponent:@"female-n.png"];
                [m_player1 setTextureWithFile:path];
            }
            switch (bgP1) {
                case 0:
                {
                    NSString*  path =  [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"room"];
                    path = [path stringByAppendingPathComponent:@"1.png"];
                    [m_bgOfP1 setTextureWithFile:path];
                    break;
                }
                case 1:
                {
                    NSString*  path =  [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"room"];
                    path = [path stringByAppendingPathComponent:@"2.png"];
                    [m_bgOfP1 setTextureWithFile:path];
                    break;
                }
                case 2:
                {
                    NSString*  path =  [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"room"];
                    path = [path stringByAppendingPathComponent:@"3.png"];
                    [m_bgOfP1 setTextureWithFile:path];
                    break;
                }
                default:
                    break;
            }
            
            [m_titleOfP1 setString:titleP1];
            break;
        default:
            m_player1.visible = TRUE;
            break;
    }
}

// This method is called right after the class has been instantiated
// by CCBReader. Do any additional initiation here. If no extra
// initialization is needed, leave this method out.
- (void) didLoadFromCCB
{
    //position:(120,0)
    CCSprite* timeProgress = [[CCSprite alloc]initWithFile:@"time.png"];
    
    self.ct = [[CCProgressTimer alloc]initWithSprite:timeProgress];
    self.ct.percentage = 100;
    self.ct.type = kCCProgressTimerTypeBar;
    self.ct.anchorPoint = CGPointMake(0, 0);
    [self.ct setMidpoint:CGPointMake(0, 0)];
    [self.ct setBarChangeRate:ccp(1,0)];
    self.ct.position = CGPointMake(10.0f, 24.0f);
    [self addChild:self.ct];
    
    [self initWaitingRoom];

    
    [self schedule:@selector(updateBar) interval:0.5];
    
}
- (void) dealloc
{
    [self unschedule:@selector(updateBar)];
    [super dealloc];
}

- (void)pause
{
    self.isTouchEnabled = NO;
    [self addChild:[CCBReader nodeGraphFromFile:@"pauseGame.ccbi"]];
    
    //if (![HappyDifferenceAppDelegate get].paused) {
	//	[HappyDifferenceAppDelegate get].paused = YES;
	//	[super onExit];
	//}
    
}

/*-(void) resume
{
	if (![AppController get].paused) {
		return ;
	}
	
    [self.parent removeChild:m_pauseLayer cleanup:YES];
    
	[AppDelegate get].paused = NO;
	[super onEnter];
}*/

-(void) updateBar
{
    CCProgressTimer* bar = self.ct;
    bar.percentage--;

    if(bar.percentage <= 0)//failed
    {
        bar.percentage = 0;
        
        [self unschedule:@selector(updateBar)];
        self.isTouchEnabled = NO;
        
        //show failed level
        CCNode* node = [CCBReader nodeGraphFromFile:@"failed.ccbi"];
        [self addChild:node];
    }
    else
    {
        //if(m_openStarNum == [m_starIcon count])
        //{
        //    [self unschedule:@selector(updateBar)];
            //show pass level
            //[self nextLevel];
        //}
    }

}

- (void) openStar
{
    m_iNumOfFind++;
    if(m_iNumOfFind >5)
        m_iNumOfFind = 5;
    
    //ccb.zip from tmp unzip to doc
    NSArray*    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString*   docPath = [paths objectAtIndex:0];
    NSString*   tmp = [docPath stringByAppendingPathComponent:@"ccb"];
                       
    switch (m_iNumOfFind) 
    {
        case 1:
            //[m_star1 setVisible:YES];
            [m_key1 setTextureWithFile:[tmp stringByAppendingPathComponent:@"keyok.png"]];
            break;
        case 2:
            //[m_star2 setVisible:YES];
            [m_key2 setTextureWithFile:[tmp stringByAppendingPathComponent:@"keyok.png"]];
            break;
        case 3:
            //[m_star3 setVisible:YES];
            [m_key3 setTextureWithFile:[tmp stringByAppendingPathComponent:@"keyok.png"]];
            break;
        case 4:
            //[m_star4 setVisible:YES];
            [m_key4 setTextureWithFile:[tmp stringByAppendingPathComponent:@"keyok.png"]];
            break;
        case 5:
            //[m_star5 setVisible:YES];
            [m_key5 setTextureWithFile:[tmp stringByAppendingPathComponent:@"keyok.png"]];
            break;
            
        default:
            break;
    }
}
//layer touch
- (void) registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}
- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInView: [touch view]]; 
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    
    if(!CGRectContainsPoint(m_touchRectLeft, touchLocation)
       &&!CGRectContainsPoint(m_touchRectright, touchLocation))
    {
        return NO;
    }
    
    for(NSDictionary* item in m_answersPointAry)
    {
        NSString* strx = [item objectForKey:@"x"];
        NSString* stry = [item objectForKey:@"y"];
        CGFloat x1 = strx.floatValue;
        CGFloat y1 = stry.floatValue;
        
		CGFloat x2 = strx.floatValue + m_orgImageWith + m_midLength;
        CGFloat y2 = stry.floatValue;
        
        if(((fabs(touchLocation.x - x1)*fabs(touchLocation.x - x1) + fabs(touchLocation.y - y1)*fabs(touchLocation.y - y1)) < 55*55)
		   || ((fabs(touchLocation.x - x2)*fabs(touchLocation.x - x2) + fabs(touchLocation.y - y2)*fabs(touchLocation.y - y2)) < 55*55))
            
        {
            //open star
            [self openStar];
#if 1
            //run action
            CCAnimation* anim = [CCAnimation animationWithFile:@"touch frame" frameCount:12 delay:0.02f];
            CCAnimate* animate = [CCAnimate actionWithAnimation:anim];
            CCSprite* touchFrame1 = [CCSprite spriteWithFile:@"360rb.png"];
			CCSprite* touchFrame2 = [CCSprite spriteWithFile:@"360rb.png"];
            [self addChild:touchFrame1];
			[self addChild:touchFrame2];
            [touchFrame1 setPosition:ccp(x1,y1)];
			[touchFrame2 setPosition:ccp(x2,y2)];
            [touchFrame1 runAction:animate];
			[touchFrame2 runAction:animate];
#endif
            
            [m_answersPointAry removeObject:item];
            
            [[SimpleAudioEngine sharedEngine]playEffect:@"ding_add.mp3"];
            
            return YES;
        }
        
    }
    
#if 1
    CCMoveBy* moveLeft = [CCMoveBy actionWithDuration:0.05 position:ccp(8,0)];
    CCMoveBy* moveRight=[CCMoveTo actionWithDuration:0.05 position:ccp(8, 0)];  
    CCFiniteTimeAction* action= [CCSequence actions:moveLeft,moveRight, nil];  
    CCActionInterval* actionShake = [CCRepeat actionWithAction:action times:5];
    [self runAction:actionShake];
#else
    CCActionInterval* shaky = [CCShaky3D actionWithRange:4 shakeZ:false grid:ccg(15, 10) duration:5];
    [self runAction:shaky];
#endif
    
    [[SimpleAudioEngine sharedEngine]playEffect:@"error.mp3"];
	
    self.ct.percentage -= 15;
	
    return YES; //这儿如果返回NO 此次触摸将被忽略
}
@end
