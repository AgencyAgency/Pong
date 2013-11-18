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
@property (strong, nonatomic) NSMutableArray *balls;
@end

@implementation AAViewController

- (NSMutableArray *)balls
{
    if (!_balls) {
        _balls = [NSMutableArray array];
    }
    return _balls;
}

- (void)tick:(CADisplayLink *)sender
{
    for (AABallView *ballView in self.balls) {
        [ballView updatePosition];
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

@end
