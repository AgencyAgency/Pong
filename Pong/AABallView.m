//
//  AABallView.m
//  Pong
//
//  Created by Kyle Oba on 11/18/13.
//  Copyright (c) 2013 Kyle Oba. All rights reserved.
//

#import "AABallView.h"

@interface AABallView ()
@property (strong, nonatomic) NSLayoutConstraint *xConstraint;
@property (strong, nonatomic) NSLayoutConstraint *yConstraint;
@property (assign, nonatomic) CGPoint velocity;
@end

@implementation AABallView

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        [self setupSizeConstraints];
        self.backgroundColor = [UIColor magentaColor];
        _velocity = CGPointMake(10.0, 10.0);
    }
    return self;
}

- (void)setInitialPosition:(CGPoint)position
{
    self.xConstraint = [NSLayoutConstraint constraintWithItem:self
                                                    attribute:NSLayoutAttributeLeft
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:self.superview
                                                    attribute:NSLayoutAttributeLeft
                                                   multiplier:1.0
                                                     constant:position.x];
    
    self.yConstraint = [NSLayoutConstraint constraintWithItem:self
                                                    attribute:NSLayoutAttributeTop
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:self.superview
                                                    attribute:NSLayoutAttributeTop
                                                   multiplier:1.0
                                                     constant:position.y];
    
    [self.superview addConstraint:self.xConstraint];
    [self.superview addConstraint:self.yConstraint];
}

- (void)updatePositionWithPaddleViews:(NSSet *)paddleViews
{
    CGPoint vel = self.velocity;
    if (CGRectGetMaxX(self.frame) >= CGRectGetMaxX(self.superview.bounds)) {
        // Bounce off the right wall:
        vel.x = -ABS(vel.x);
        
    } else if (CGRectGetMinX(self.frame) <= CGRectGetMinX(self.superview.bounds)) {
        // Bounce off the left wall:
        vel.x = ABS(vel.x);
    }
    
    if (CGRectGetMaxY(self.frame) >= CGRectGetMaxY(self.superview.bounds)) {
        // Bounce off the bottom wall:
        vel.y = -ABS(vel.y);
        
    } else if (CGRectGetMinY(self.frame) <= CGRectGetMinY(self.superview.bounds)) {
        // Bounce off the top wall:
        vel.y = ABS(vel.y);
    }
    
    // Change velocity if hits a paddle
    for (UIView *paddleView in paddleViews) {
        CGRect paddleRect = [self.superview convertRect:paddleView.bounds
                                               fromView:paddleView];
        if (CGRectIntersectsRect(self.frame, paddleRect)) {
            // Flip the vertical velocity
            vel.y = -vel.y;
            
            // Only need to worry about one paddle collision.
            break;
        }
    }
    
    // Set new velocity
    self.velocity = vel;
    
    CGPoint pos = CGPointMake(self.xConstraint.constant,
                              self.yConstraint.constant);
    
    // Constrain the X position of the ball:
    CGFloat maxPosX = CGRectGetWidth(self.superview.bounds) - CGRectGetWidth(self.bounds);
    pos.x = MIN(maxPosX, MAX(0, pos.x + self.velocity.x));
    
    // Update the X position of the ball:
    self.xConstraint.constant = pos.x;
    
    // Constrain the Y position of the ball:
    CGFloat maxPosY = CGRectGetHeight(self.superview.bounds) - CGRectGetHeight(self.bounds);
    pos.y = MIN(maxPosY, MAX(0, pos.y + self.velocity.y));
    
    // Update the Y position of the ball:
    self.yConstraint.constant = pos.y;
}

- (void)setupSizeConstraints
{
    NSLayoutConstraint *widthConstraint;
    widthConstraint = [NSLayoutConstraint constraintWithItem:self
                                                   attribute:NSLayoutAttributeWidth
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:nil
                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                  multiplier:1.0
                                                    constant:20.0];
    NSLayoutConstraint *heightConstraint;
    heightConstraint = [NSLayoutConstraint constraintWithItem:self
                                                   attribute:NSLayoutAttributeHeight
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:nil
                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                  multiplier:1.0
                                                    constant:20.0];
    
    [self addConstraint:widthConstraint];
    [self addConstraint:heightConstraint];
}

@end
