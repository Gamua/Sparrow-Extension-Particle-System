//
//  Game.m
//  Particle System Demo
//

#import "Game.h"

@implementation Game
{
    SXParticleSystem *_particleSystem;
}

- (id)init
{
    if ((self = [super init]))
    {
        float width = Sparrow.stage.width;
        float height = Sparrow.stage.height;
        
        // create particle system
        _particleSystem = [[SXParticleSystem alloc] initWithContentsOfFile:@"fire.pex"];
        _particleSystem.x = width / 2.0f;
        _particleSystem.y = height / 2.0f;
        
        // add it to the stage and the juggler
        [self addChild:_particleSystem];
        [Sparrow.juggler addObject:_particleSystem];
        
        [_particleSystem start];
        
        // register touch event for emitter manipulation
        [self addEventListener:@selector(onTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    }
    return self;
}

- (SPDisplayObject *)hitTestPoint:(SPPoint *)localPoint forTouch:(BOOL)isTouch
{
    return self;
}

- (void)onTouch:(SPTouchEvent *)event
{
    SPTouch *touch = [[event touchesWithTarget:self] anyObject];
    if (touch)
    {
        SPPoint *emitterPos = [touch locationInSpace:_particleSystem];
        _particleSystem.emitterX = emitterPos.x;
        _particleSystem.emitterY = emitterPos.y;
        
        if (touch.phase == SPTouchPhaseEnded && touch.tapCount == 3)
            Sparrow.currentController.showStats = !Sparrow.currentController.showStats;
    }
}

@end
