//
//  Asteroid.m
//  Asteroids
//
//  Created by Romotive on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Asteroid.h"

@implementation Asteroid

@synthesize destroyed = _destroyed, exploded = _exploded;

- (id) initWithPosition:(CGPoint)position{
    if ((self = [super init])) {
        self.position = position;
        srandom(self.position.x);
        CGFloat angle = (CGFloat) random();
        long v = 40 + random() % 60;
        self.velocity = CGPointMake(v*cos(angle),v*sin(angle));
//        NSLog(@"velocity is: %@", NSStringFromCGPoint(self.velocity));
        self.destroyed = NO;
        self.exploded = 0;
    }
    return self;
}

- (void) stepInTime: (NSTimeInterval) interval {
    CGSize screensize = [[UIScreen mainScreen] bounds].size;
    [super stepInTime: interval];
    
    CGFloat x, y;
    
    x = fmodf(self.position.x, screensize.width);
    y = fmodf(self.position.y, screensize.height);
    while (x < 0) {x += screensize.width;}
    while (y < 0) {y += screensize.height;}
    self.position = CGPointMake(x, y);
//    NSLog(@"asteroid stepped in time");
}

- (void) drawInCGContext: (CGContextRef) context {
    if(!self.destroyed){
        CGPoint point = self.position;
        UIImage * asteroidImage = [UIImage imageNamed:@"asteroid.png"];
        point.x -= [asteroidImage size].width / 2;
        point.y -= [asteroidImage size].height / 2;
        [asteroidImage drawAtPoint: point];
    }
    if(self.exploded < 10 && self.destroyed){
        CGPoint point = self.position;
        UIImage * fireImage = [UIImage imageNamed:@"explosion.png"];
        point.x -= [fireImage size].width / 2;
        point.y -= [fireImage size].height / 2;
        [fireImage drawAtPoint: point];
        self.exploded++;
    }
}

- (NSString *) description {
    return [NSString stringWithFormat:@"Asteroid at %@", NSStringFromCGPoint(self.position)];
}
@end
