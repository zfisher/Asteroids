//
//  Ship.m
//  Asteroids
//
//  Created by Zachary Fisher on 7/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Ship.h"
#import "UIImage+Additions.h"

@implementation Ship

@synthesize destroyed = _destroyed;

- (id) initWithPosition:(CGPoint)position{
    if ((self = [super init])) {
        self.position = position;
        self.velocity = CGPointZero;
        self.destroyed = NO;
    }
    return self;   
}

- (void) stepInTime: (NSTimeInterval) interval {
    [super stepInTime: interval];
    
    CGSize screensize = [[UIScreen mainScreen] bounds].size;
    CGFloat x, y;
    
    x = fmodf(self.position.x, screensize.width);
    y = fmodf(self.position.y, screensize.height);
    while (x < 0) {x += screensize.width;}
    while (y < 0) {y += screensize.height;}
    self.position = CGPointMake(x, y);
}

- (void) setAngle:(CGFloat)angle;
{
    CGPoint v = self.velocity;
    float speed = sqrt(v.x * v.x + v.y * v.y);
    self.velocity = CGPointMake(speed*cos(angle),speed*sin(angle));
}

- (CGFloat) angle {
    return atan2(self.velocity.y, self.velocity.x) + M_PI_2;
}


- (void) drawInCGContext: (CGContextRef) context {
    CGPoint point = self.position;
    UIImage * starshipImage = [[UIImage imageNamed:@"ship.jpg"] imageRotatedByRadians:[self angle]];
    point.x -= [starshipImage size].width / 2;
    point.y -= [starshipImage size].height / 2;
    [starshipImage drawAtPoint: point];
}

- (CGPoint) getFront{
    CGSize shipSize = [[UIImage imageNamed:@"ship.jpg"] size];
    float x = self.position.x + shipSize.width/2 * sin([self angle]);
    float y = self.position.y - shipSize.height/2 * cos([self angle]);
    NSLog(@"%f",[self angle]);
    return CGPointMake(x,y);
}

@end
