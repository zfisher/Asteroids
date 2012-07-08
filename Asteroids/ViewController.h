//
//  ViewController.h
//  Asteroids
//
//  Created by Romotive on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import "Game.h"

@interface ViewController : UIViewController

@property (assign,nonatomic) NSTimer * timer;
@property (retain) CADisplayLink * displayLink;
@property (retain) NSDate * lastDraw;
@property (weak) Game * game;
@property (retain) CMMotionManager * motionManager;
@property (strong) CMGyroHandler gyroHandler;
@property (retain) NSOperationQueue * operationQueue;
@property (retain) CMAttitude * referenceAttitude;
@property BOOL gameIsRunning;

- (void) gameViewWasTouched;
- (void) updateShipOrientation;

@end
