//
//  Bullet.h
//  Asteroids
//
//  Created by Romotive on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameElement.h"

@interface Bullet : GameElement

@property BOOL destroyed;

- (id) initWithPosition:(CGPoint)position angle:(float)angle;



@end
