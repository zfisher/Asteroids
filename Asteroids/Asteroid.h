//
//  Asteroid.h
//  Asteroids
//
//  Created by Romotive on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameElement.h"

@interface Asteroid : GameElement

@property BOOL destroyed;
@property int exploded;

- (id) initWithPosition:(CGPoint)position;



@end
