//
//  GameElement.h
//  Asteroids
//
//  Created by Romotive on 7/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameElement : NSObject

@property (nonatomic) CGPoint position;
@property (nonatomic) CGPoint velocity;
@property BOOL isValid;

- (void) stepInTime: (NSTimeInterval) interval;
- (void) drawInCGContext: (CGContextRef) context;
- (id) initWithPosition:(CGPoint)position;

@end
