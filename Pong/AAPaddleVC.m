//
//  AAPaddleVC.m
//  Pong
//
//  Created by Kyle Oba on 11/17/13.
//  Copyright (c) 2013 Kyle Oba. All rights reserved.
//

#import "AAPaddleVC.h"

@interface AAPaddleVC ()
@property (weak, nonatomic) IBOutlet UIView *paddleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *paddleXConstraint;
@end

@implementation AAPaddleVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

- (IBAction)panPaddle:(UIPanGestureRecognizer *)sender {
    UIView *paddle = [sender view];

    if ([sender state] == UIGestureRecognizerStateBegan || [sender state] == UIGestureRecognizerStateChanged) {
        
        // How far did the panning finger move in (X, Y)?
        // We're only concerned with the X-motion.
        CGPoint translation = [sender translationInView:[paddle superview]];
        
        // Where was the left edge of the paddle?
        CGFloat oldX = self.paddleXConstraint.constant;
        
        // Where is the panning finger pushing it to now?
        CGFloat newX = oldX + translation.x;
        
        // What is the furthest the paddle can go?
        CGFloat maxX = CGRectGetWidth(self.view.bounds) - CGRectGetWidth(self.paddleView.bounds);
        CGFloat minX = 0.0;
        
        // Constrain the location of the paddle:
        CGFloat x = MIN(maxX, MAX(minX, newX));
        
        // Set location of left edge of paddle:
        self.paddleXConstraint.constant = x;
        
        // Reset translation on pan recognizer to (0, 0):
        [sender setTranslation:CGPointZero inView:[paddle superview]];
    }
}

@end
