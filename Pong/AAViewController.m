//
//  AAViewController.m
//  Pong
//
//  Created by Kyle Oba on 11/17/13.
//  Copyright (c) 2013 Kyle Oba. All rights reserved.
//

#import "AAViewController.h"
#import "AABallView.h"
#import <QuartzCore/QuartzCore.h>

@interface AAViewController ()
@property (strong, nonatomic) CADisplayLink *displayLink;
@property (strong, nonatomic) NSMutableSet *balls;
@property (strong, nonatomic) NSMutableSet *paddleViews;
@end

@implementation AAViewController

- (NSMutableSet *)balls
{
    if (!_balls) {
        _balls = [NSMutableSet set];
    }
    return _balls;
}

- (NSMutableSet *)paddleViews
{
    if (!_paddleViews) {
        _paddleViews = [NSMutableSet set];
    }
    return _paddleViews;
}

- (void)tick:(CADisplayLink *)sender
{
    for (AABallView *ballView in self.balls) {
        [ballView updatePositionWithPaddleViews:self.paddleViews];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.displayLink = [CADisplayLink displayLinkWithTarget:self
                                                   selector:@selector(tick:)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop]
                           forMode:NSDefaultRunLoopMode];
    
    [self addBallToDisplay];
}

- (void)addBallToDisplay
{
    AABallView *ballView = [[AABallView alloc] init];
    ballView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:ballView];
    [ballView setInitialPosition:CGPointMake(50.0, 100.0)];
    
    [self.balls addObject:ballView];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"embedPaddle"]) {
        AAPaddleVC *paddleVC = segue.destinationViewController;
        paddleVC.delegate = self;
    }
}


#pragma mark - AAPadleVC delegate

- (void)paddleVC:(AAPaddleVC *)paddleVC didLoadPaddleView:(UIView *)paddleView
{
    [self.paddleViews addObject:paddleView];
}

@end
