//
//  CCSprite+FadeToGrayAction.h
//  TextureMotify
//
//  Created by demon on 11/6/12.
//
//

#import "CCSprite.h"
#import "CCRenderTexture.h"
#import "CCTexture2DMutable.h"
#import "CGPointExtension.h"

@interface CCSprite (FadeToGrayAction)

-(void)runToGrayAction;
-(CCTexture2DMutable*)getMutableTexture;
@end
