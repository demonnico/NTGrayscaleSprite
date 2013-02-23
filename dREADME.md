
######	让你能够直接对cocos2d中的sprite对象做RGB到Grayscale的动画

#How To Use


```
CCSprite  *animationSprite =[CCSprite spriteWithFile:@"Icon.png"];
[self addChild:animationSprite];
animationSprite.position = ccp(100, 200);


/***动画对象target目前只允许CCSprite***/
CCFadeToGrayAction * fadeOut = [CCFadeToGrayAction actionWithDuration:3.0];
[animationSprite runAction:fadeOut];

```

#TODO
对同一sprite对象进行多次动画后材质的失真问题