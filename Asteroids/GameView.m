//
//  GameView.m
//  Asteroids
//
//  Created by Romotive on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameView.h"
#import "UIImage+Additions.h"

@implementation GameView

@synthesize delegate = _delegate;

//@synthesize shipPosition = _shipPosition, asteroidPositions = _asteroidPositions, bulletPositions = _bulletPositions;
@synthesize ship = _ship, bullets = _bullets, asteroids = _asteroids;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.ship = nil;
        self.bullets = [NSArray array];
        self.asteroids = [NSArray array];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [(ViewController *)self.delegate updateShipOrientation];
    
    // Drawing code
    UIColor* myColor = [UIColor blackColor];
    [myColor set];
    UIRectFill(rect);
    
//    NSLog(@"asteroid positions is: %@", self.asteroidPositions);
    for (Asteroid *asteroid in self.asteroids) {
        [asteroid drawInCGContext:UIGraphicsGetCurrentContext()];
    }
    
    for (Bullet *bullet in self.bullets) {
        [bullet drawInCGContext:UIGraphicsGetCurrentContext()];
    }
    
    [self.ship drawInCGContext:UIGraphicsGetCurrentContext()];
}
//
//- (void) drawStarshipAtPoint: (CGPoint)point angle: (CGFloat)angle {
//    UIImage * starshipImage = [UIImage imageNamed:@"ship.jpg"];
//    
////    CGRect starshipRect = CGRectMake(0,0, [starshipImage size].width, [starshipImage size].height);
////    [scaledImage rotate: angle];
//    point.x -= [starshipImage size].width / 2;
//    point.y -= [starshipImage size].height / 2;
//    [starshipImage drawAtPoint: point];
//}
//
//- (void) drawAsteroidAtPoint: (CGPoint)point {
////    NSLog(@"drawAsteroid called");
//    UIImage * asteroidImage = [UIImage imageNamed:@"asteroid.png"];
//    point.x -= [asteroidImage size].width / 2;
//    point.y -= [asteroidImage size].height / 2;
//    [asteroidImage drawAtPoint: point];
//}
//
//- (void) drawBulletAtPoint: (CGPoint)point {
//    [[UIColor whiteColor] set];
//    CGRect bulletRect = CGRectMake(point.x - 2, point.y-2, 4, 4);
//    CGContextAddEllipseInRect(UIGraphicsGetCurrentContext(), bulletRect);
//    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFill);
//}

- (CGSize) shipSize{
    return [[UIImage imageNamed:@"ship.jpg"] size];
}

- (CGSize) asteroidSize{
    return [[UIImage imageNamed:@"asteroid.png"] size];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.delegate gameViewWasTouched];
}

@end
