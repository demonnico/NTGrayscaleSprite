//
//  CCFadeToGrayAction.h
//  TextureMotify
//
//  Created by demon on 11/27/12.
//
//

#import "CCActionInterval.h"
#import "CCTexture2DMutable.h"

@interface NTFadeToGrayAction : CCActionInterval
{
    CCTexture2DMutable * mutableTexture;
}
+(id)actionWithDuration:(ccTime)duration;
@end
