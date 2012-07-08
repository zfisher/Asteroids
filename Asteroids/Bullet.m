//
//  Bullet.m
//  Asteroids
//
//  Created by Romotive on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Bullet.h"

@implementation Bullet

@synthesize destroyed = _destroyed;

- (id) initWithPosition:(CGPoint)position angle:(float) angle{
    if ((self = [super init])) {
        self.position = position;
        self.velocity = CGPointMake(100*cos(angle),100*sin(angle));
        self.isValid = YES;
        self.destroyed = NO;
    }
    return self;
}

- (void) stepInTime: (NSTimeInterval) interval {
    [super stepInTime: interval];
    
    CGRect screenbounds = [[UIScreen mainScreen] bounds];
    self.isValid = CGRectContainsPoint(screenbounds, self.position);
}

- (void) drawInCGContext: (CGContextRef) context {
    if(!self.destroyed){
        CGPoint point = self.position;
        [[UIColor whiteColor] set];
        CGRect bulletRect = CGRectMake(point.x - 2, point.y-2, 4, 4);
        CGContextAddEllipseInRect(context, bulletRect);
        CGContextDrawPath(context, kCGPathFill);
    }
}
@end
