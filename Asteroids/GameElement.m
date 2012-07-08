//
//  GameElement.m
//  Asteroids
//
//  Created by Romotive on 7/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameElement.h"

@implementation GameElement

@synthesize position = _position, velocity = _velocity, isValid = _isValid;

- (void) stepInTime: (NSTimeInterval) interval {
    if (interval > 0) {
        _position.x += (CGFloat) _velocity.x * interval;
        _position.y += (CGFloat) _velocity.y * interval;
    }
    return;
}


- (void) drawInCGContext: (CGContextRef) context {
    //override this method in subclasses
    return;
}

- (id) initWithPosition:(CGPoint)position{
    self = [super init];
    if (self) {
        self.position = position;
    }
    return self;
}
@end
