//
//  CCSprite+FadeToGrayAction.m
//  TextureMotify
//
//  Created by demon on 11/6/12.
//
//

#import "CCSprite+FadeToGrayAction.h"

@implementation CCSprite (FadeToGrayAction)

-(void)runToGrayAction
{
    int width   = self.contentSizeInPixels.width;
    int height  = self.contentSizeInPixels.height;
    
    CCTexture2DMutable * mutableTexture = [self getMutableTexture];
    
    for (int i=0;i<width; i++)
    {
        for(int j=0;j<height;j++)
        {
            
            ccColor4B  origin = [mutableTexture pixelAt:CGPointMake(i, j)];
            int gray = origin.r*0.3+origin.g*0.59+origin.b*0.11;
            [mutableTexture setPixelAt:CGPointMake(i, j)
                                  rgba:ccc4(gray,
                                            gray,
                                            gray,
                                            origin.a)];
            
        }
    }
    
    [mutableTexture apply];
    
    self.texture = mutableTexture;
}

-(CCTexture2DMutable*)getMutableTexture
{
    int width   = self.contentSizeInPixels.width;
    int height  = self.contentSizeInPixels.height;
    
    CCRenderTexture * renderTexture = [CCRenderTexture renderTextureWithWidth:width
                                                                       height:height];
    
    //从openGL纹理中读取的像素是上下倒置的
    GLubyte* upsideDownPixels =  malloc(width *height * sizeof(GLubyte) * 4);
    //还原后正确的像素信息
//    GLubyte* pixels = malloc(width *height * sizeof(GLubyte) * 4);
    
    CGPoint  anchopoint =  self.anchorPoint;
    
    CCSprite * renderSprite = [CCSprite spriteWithTexture:self.texture];
    renderSprite.anchorPoint = ccp(0, 0);
    [renderTexture begin];
    [renderSprite visit];
    glReadPixels(0, 0, width,height, GL_RGBA, GL_UNSIGNED_BYTE, upsideDownPixels);
    [renderTexture end];
    renderSprite.anchorPoint = anchopoint;
    
//    for(int y = 0; y <width; y++)
//    {
//        for(int x = 0; x <height * 4; x++)
//        {
//            pixels[(height - y) * width * 4 + x] = upsideDownPixels[y * 4 * width + x];
//        }
//    }
//    
//    free(upsideDownPixels);
    
    //pixels 的内存在CCTexture2DMutable的 dealloc时将释放    
    CCTexture2DMutable * mutableTexture = [[CCTexture2DMutable alloc] initWithData:upsideDownPixels
                                                                       pixelFormat:kTexture2DPixelFormat_RGBA8888
                                                                        pixelsWide:width
                                                                        pixelsHigh:height
                                                                       contentSize:CGSizeMake(width, height)];

    [mutableTexture apply];
    
    self.texture = mutableTexture;
    self.textureRect =CGRectMake(0,
                                 0,
                                 mutableTexture.contentSize.width,
                                 mutableTexture.contentSize.height);
    
    return [mutableTexture autorelease];
}

@end
