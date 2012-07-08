//
//  Game.m
//  Asteroids
//
//  Created by Romotive on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Game.h"

@implementation Game

@synthesize ship = _ship, asteroids = _asteroids, bullets = _bullets;
@synthesize numAsteroids = _numAsteroids;

- (id) init {
    if ((self = [super init])) {
        _asteroids = [NSMutableArray array];
        _bullets = [NSMutableArray array];
        _numAsteroids = 5;
    }
    return self;
}

- (void) newGame {
    CGSize screensize = [[UIScreen mainScreen] bounds].size; 
    CGPoint screencenter = CGPointMake(screensize.width / 2.0, screensize.height / 2.0);
    
    srandom(time(NULL));
    
    _asteroids = [NSMutableArray array];
    _bullets = [NSMutableArray array];
    
    
    for (int i = 0; i < _numAsteroids; ++i) {
        CGPoint p = CGPointZero;
        do {
            p = CGPointMake(random() % (int)screensize.width,random() % (int)screensize.height);
        } while (sqrt(pow(p.x - screencenter.x, 2) + pow(p.y - screencenter.y, 2)) < 100);
        
        [_asteroids addObject: [[Asteroid alloc] initWithPosition:p]];
    }
    
    _ship = [[Ship alloc] initWithPosition: screencenter];
    _ship.velocity = CGPointMake(0,50);
}

- (void) stepInTime: (NSTimeInterval) interval {
    for (Asteroid *asteroid in _asteroids) {
        [asteroid stepInTime: interval];
    }
    for (Bullet *bullet in _bullets) {
        [bullet stepInTime: interval];
    }
    [_ship stepInTime: interval];
}

- (void) fireBullet {
    CGPoint bulletPosition = [self.ship getFront];
    Bullet * newBullet = [[Bullet alloc] initWithPosition:bulletPosition angle:[self.ship angle] - M_PI_2];
    newBullet.velocity = CGPointMake(newBullet.velocity.x + self.ship.velocity.x,
                                     newBullet.velocity.y + self.ship.velocity.y);
    [_bullets addObject:newBullet];
//    NSLog(@"%@",_bullets);
    
}

- (BOOL) hasWon{
    for (Asteroid *asteroid in self.asteroids){
        if(!asteroid.destroyed) return NO;
        
    }
    return YES;
}

- (BOOL) hasLost{
    return self.ship.destroyed;
}

@end
