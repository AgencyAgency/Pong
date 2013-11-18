//
//  AAViewController.m
//  Pong
//
//  Created by Kyle Oba on 11/17/13.
//  Copyright (c) 2013 Kyle Oba. All rights reserved.
//

#import "AAViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface AAViewController ()
@property (weak, nonatomic) IBOutlet UILabel *bottomPlayerScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *topPlayerScoreLabel;
@property (assign, nonatomic) NSInteger bottomPlayerScore;
@property (assign, nonatomic) NSInteger topPlayerScore;
@property (assign, nonatomic) NSInteger totalScore;
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
    
    // Wait to do all the adding of balls after looping complete.
    // This avoids an error when you try to add a ball to the
    // set while still iterating through it.
    NSInteger total = self.topPlayerScore + self.bottomPlayerScore;
    if (total > self.totalScore && total % 100 == 0) {
        [self addBallToDisplay];
        self.totalScore = total;
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
    
    self.topPlayerScoreLabel.transform = CGAffineTransformMakeRotation(M_PI);
    [self updateScores];
}

- (void)addBallToDisplayAtPosition:(CGPoint)position
{
    AABallView *ballView = [[AABallView alloc] init];
    ballView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:ballView];
    [ballView setInitialPosition:position];
    
    ballView.delegate = self;
    [self.balls addObject:ballView];
}

- (void)addBallToDisplay
{
    [self addBallToDisplayAtPosition:CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds))];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}


#pragma mark - Actions

- (IBAction)actionAreaTapped:(UITapGestureRecognizer *)sender
{
    CGPoint tapPos = [sender locationInView:self.view];
    [self addBallToDisplayAtPosition:tapPos];
}


#pragma mark - Segue

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


#pragma mark - AABallView delegate

- (void)updateScores
{
    self.bottomPlayerScoreLabel.text = [NSString stringWithFormat:@"%08d", self.bottomPlayerScore];
    self.topPlayerScoreLabel.text = [NSString stringWithFormat:@"%08d", self.topPlayerScore];
}

- (void)ballViewDidHitTop:(AABallView *)ballView
{
    self.bottomPlayerScore += 10;
    [self updateScores];
}

- (void)ballViewDidHitBottom:(AABallView *)ballView
{
    self.topPlayerScore += 10;
    [self updateScores];
}

@end
