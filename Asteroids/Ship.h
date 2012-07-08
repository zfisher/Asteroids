//
//  Ship.h
//  Asteroids
//
//  Created by Zachary Fisher on 7/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameElement.h"

@interface Ship : GameElement

@property BOOL destroyed;

- (CGFloat) angle;
- (void) setAngle:(CGFloat)angle;
- (CGPoint) getFront;

@end
