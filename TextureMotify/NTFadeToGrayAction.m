//
//  CCFadeToGrayAction.m
//  TextureMotify
//
//  Created by demon on 11/27/12.
//
//

#import "NTFadeToGrayAction.h"
#import "CCSprite+FadeToGrayAction.h"
@implementation NTFadeToGrayAction

- (void)dealloc
{
    if(mutableTexture)
        [mutableTexture release];
    [super dealloc];
}

+(id)actionWithDuration:(CGFloat)duration
{
    return [[[NTFadeToGrayAction alloc] initWithDuration:duration] autorelease];
}


-(id) initWithDuration: (ccTime) t
{
	if( (self=[super initWithDuration: t]) )
    {
        
    }
	return self;
}

-(void) startWithTarget:(id)aTarget
{
    [super startWithTarget:aTarget];
    CCSprite * target = (CCSprite*)target_;
    if(!mutableTexture)
    {
        if(![target_ isKindOfClass:[CCSprite class]])
        {
            NSLog(@"taget Error, must be a CCSprite target！");
            return;
        }
        if([target.texture isKindOfClass:[CCTexture2DMutable class]])
        {
            CCTexture2DMutable * mutableOrigin  = (CCTexture2DMutable*)target.texture;
            [mutableOrigin restore];
        }
        mutableTexture  = [target getMutableTexture];
        [mutableTexture retain];
        //解决像素获取后在屏幕上显示倒置的问题
        target.scaleY = -target.scaleY;
    }
}

-(void)update:(ccTime)time
{
    CCSprite * target = (CCSprite*)target_;
    int width  = target.contentSizeInPixels.width;
    int height = target.contentSizeInPixels.height;
    
    for (int i=0;i<width; i++)
    {
        for(int j=0;j<height;j++)
        {

            ccColor4B  origin = [mutableTexture pixelAt:CGPointMake(i, j)];
            int gray  = origin.r*0.3+origin.g*0.59+origin.b*0.11;
            [mutableTexture setPixelAt:CGPointMake(i, j)
                                  rgba:ccc4(gray*time-(origin.r*time)+origin.r,
                                            gray*time-(origin.g*time)+origin.g,
                                            gray*time-(origin.b*time)+origin.b,
                                            origin.a)];
        }
    }
    [mutableTexture apply];
}

@end
