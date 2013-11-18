//
//  AABallView.h
//  Pong
//
//  Created by Kyle Oba on 11/18/13.
//  Copyright (c) 2013 Kyle Oba. All rights reserved.
//

@class AABallView;

#import <UIKit/UIKit.h>

@protocol AABallViewDelegate <NSObject>
- (void)ballViewDidHitTop:(AABallView *)ballView;
- (void)ballViewDidHitBottom:(AABallView *)ballView;
@end

@interface AABallView : UIView
@property (weak, nonatomic) id<AABallViewDelegate> delegate;
@property (assign, nonatomic) BOOL shouldBeDestroyed;
- (void)setInitialPosition:(CGPoint)position;
- (void)updatePositionWithPaddleViews:(NSSet *)paddleViews;
@end
