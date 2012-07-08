//
//  GameView.h
//  Asteroids
//
//  Created by Romotive on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "Ship.h"
#import "Bullet.h"
#import "Asteroid.h"

@interface GameView : UIView

@property (retain) Ship *ship;
@property NSArray *bullets;
@property NSArray *asteroids;
//@property CGPoint shipPosition;
//@property NSArray * asteroidPositions;
//@property NSArray * bulletPositions;
@property (assign) IBOutlet ViewController *delegate;

- (CGSize) shipSize;
- (CGSize) asteroidSize;

@end
