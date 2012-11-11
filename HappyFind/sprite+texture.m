//
//  MyCocos2DClass.m
//  HappyFind
//
//  Created by zzyy on 12-9-22.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "sprite+texture.h"


@implementation CCSprite (Texture)
-(void) setTextureWithFile:(NSString*) path
{
    UIImage*   image = [[UIImage alloc] initWithContentsOfFile:path];
    CGImageRef imageRef = image.CGImage;
    CCTexture2D*    roleTex = [[CCTexture2D alloc] initWithCGImage:imageRef resolutionType:kCCResolutionUnknown];
    [self setTexture:roleTex];
    [image release];
}
@end
