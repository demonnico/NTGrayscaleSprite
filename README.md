######	it makes a CCSprite from a RGB to grayscale easily.

#How To Use

![](https://raw.github.com/demon1105/ImagesLib/master/demo.gif)

```
CCSprite  *animationSprite =[CCSprite spriteWithFile:@"Icon.png"];
[self addChild:animationSprite];
animationSprite.position = ccp(100, 200);


/***as far as now, just support for CCSprite***/
CCFadeToGrayAction * fadeOut = [CCFadeToGrayAction actionWithDuration:3.0];
[animationSprite runAction:fadeOut];

```

#TODO
it's a little strange that if make many times grayscale animation for one sprite.
