//
//  Game.h
//  Asteroids
//
//  Created by Romotive on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ship.h"
#import "Asteroid.h"
#import "Bullet.h"

@interface Game : NSObject

@property NSMutableArray *asteroids;
@property NSMutableArray *bullets;

@property Ship * ship;

@property int numAsteroids;

- (void) newGame; 
- (void) stepInTime: (NSTimeInterval) interval;
- (void) fireBullet;
- (BOOL) hasWon;
- (BOOL) hasLost;

@end
