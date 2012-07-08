//
//  ViewController.m
//  Asteroids
//
//  Created by Romotive on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "GameView.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController

@synthesize timer = _timer;
@synthesize game = _game;
@synthesize lastDraw = _lastDraw;
@synthesize displayLink = _displayLink;
@synthesize motionManager = _motionManager, gyroHandler = _gyroHandler, operationQueue = _operationQueue;
@synthesize referenceAttitude = _referenceAttitude,gameIsRunning = _gameIsRunning;

- (void)viewDidLoad
{
    _game = [(AppDelegate *)[[UIApplication sharedApplication] delegate] game];
    _gameIsRunning = YES;
    
    [super viewDidLoad];
    
    _displayLink = [CADisplayLink displayLinkWithTarget: self selector: @selector(displayLinkFired:)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    _lastDraw = [NSDate date];
    [self displayLinkFired: _displayLink];
    
    // gyroscope stuff:
    
    _motionManager = [[CMMotionManager alloc] init];
    _referenceAttitude = _motionManager.deviceMotion.attitude;
    _motionManager.gyroUpdateInterval = 1.0/60.0;
    if (_motionManager.gyroAvailable) {
        [_motionManager startDeviceMotionUpdates];
//        _operationQueue = [NSOperationQueue currentQueue];
//        _gyroHandler = ^ (CMGyroData *gyroData, NSError *error) {
//            CMRotationRate rotate = gyroData.rotationRate;
//            NSLog(@"rotation rate = %f, %f, %f", rotate.x, rotate.y, rotate.z);
//        };
//        [_motionManager startGyroUpdatesToQueue:_operationQueue withHandler:_gyroHandler];
    } else {
        NSLog(@"No gyroscope on device.");
    }
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    } else {
        return YES;
    }
}

- (void) displayLinkFired:(CADisplayLink *)sender{
    if(_gameIsRunning){
        if([_game hasLost]){
            if(_game.numAsteroids > 1)
                _game.numAsteroids--;
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"You Lost :(" message:@"Press OK to play again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            _gameIsRunning = NO;
            [alert show];
        }
        if([_game hasWon]){
            _game.numAsteroids++;
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"You won!" message:@"Press OK to play again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            _gameIsRunning = NO;
            [alert show];
        }
    //    NSLog(@"timefired");
        [_game stepInTime: [[NSDate date] timeIntervalSinceDate: _lastDraw]];
        [self testForCollisions];
        ((GameView *)self.view).ship = [_game ship];
        ((GameView *)self.view).bullets = [_game bullets];
        ((GameView *)self.view).asteroids = [_game asteroids];
        [self.view setNeedsDisplay];
        _lastDraw = [NSDate date];
        //NSLog(@"get on with it!");
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    _gameIsRunning = YES;
    [_game newGame];
    
}

- (void) testForCollisions{
    CGRect shipRect = CGRectZero;
    shipRect.origin = [_game ship].position;
    shipRect.size = [(GameView *)self.view shipSize];
    shipRect.origin.x -= shipRect.size.width / 2;
    shipRect.origin.y -= shipRect.size.height / 2;
    
    for (Asteroid *asteroid in [_game asteroids]) {
        CGRect asteroidRect = CGRectZero;
        asteroidRect.origin = asteroid.position;
        asteroidRect.size = [(GameView *)self.view asteroidSize];
        asteroidRect.origin.x -= asteroidRect.size.width / 2;
        asteroidRect.origin.y -= asteroidRect.size.height / 2;
        
        if (CGRectIntersectsRect(shipRect, asteroidRect) && !asteroid.destroyed) {
            [_game ship].destroyed = YES;
            NSLog(@"OMG COLLISION!");
        }
        for(Bullet *bullet in [_game bullets]){
            CGRect bulletRect = CGRectZero;
            bulletRect.origin = CGPointMake(bullet.position.x-2, bullet.position.y - 2);
            bulletRect.size  = CGSizeMake(4.0,4.0);
//            NSLog(@"bulletRect = %@", NSStringFromCGRect(bulletRect));
            if (CGRectIntersectsRect(asteroidRect,bulletRect) && !asteroid.destroyed
                && !bullet.destroyed){
                asteroid.destroyed = YES;
                bullet.destroyed = YES;
                NSLog(@"Bullet hit asteroid!");
                NSLog(@"bulletRect = %@", NSStringFromCGRect(bulletRect));
                NSLog(@"asteroidRect = %@", NSStringFromCGRect(asteroidRect));
            }
        }
    }
}

- (void) updateShipOrientation{
    CMAttitude *currentAttitude = _motionManager.deviceMotion.attitude;
    if (_referenceAttitude != nil) {
        [currentAttitude multiplyByInverseOfAttitude: _referenceAttitude];
    }
    
    CGFloat maxV = 320;
    CGPoint v = CGPointMake(maxV*sin(currentAttitude.roll),maxV*sin(currentAttitude.pitch));
    
    [self.game.ship setVelocity:v];
}

- (void) gameViewWasTouched{
    NSLog(@"touched");
    [_game fireBullet];
}

@end
