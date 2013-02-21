//
//  HelloWorldLayer.m
//  TextureMotify
//
//  Created by demon on 11/6/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "CCTexture2DMutable.h"
#import "CCSprite+FadeToGrayAction.h"
#import "NTFadeToGrayAction.h"
// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:64];

		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
	
		// position the label on the center of the screen
//		label.position =  ccp( size.width /2 , size.height/2 );
		
		// add the label as a child to this Layer
//		[self addChild: label];
        CCMenuItemLabel * labelItem  =[CCMenuItemLabel itemWithLabel:label
                                                          target:self
                                                        selector:@selector(playAnimation)];
        CCMenu * menu  =[CCMenu menuWithItems:labelItem, nil];
        [self addChild:menu];
        menu.position = ccp( size.width /2 , size.height/2 );
        
        
        animationSprite =[CCSprite spriteWithFile:@"Icon.png"];
        [self addChild:animationSprite];

        animationSprite.position = ccp(100, 200);
        
        
	}
	return self;
}

-(void)playAnimation
{
    NTFadeToGrayAction * fadeOut = [NTFadeToGrayAction actionWithDuration:3.0];
    [animationSprite runAction:fadeOut];
}

+(UIImage*)getUIImageFromData:(void*)data
                        width:(int)w
                       height:(int)h
{
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL,
                                                              data,
                                                              h*w*sizeof(uint32_t),
                                                              NULL);
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault| kCGImageAlphaLast;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    
    CGImageRef imageRef = CGImageCreate(w,
                                        h,
                                        8,
                                        32,
                                        4*w,
                                        colorSpaceRef,
                                        bitmapInfo,
                                        provider,NULL,NO,renderingIntent);
    
    return [UIImage imageWithCGImage:imageRef];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
