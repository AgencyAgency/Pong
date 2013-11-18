//
//  AABallView.h
//  Pong
//
//  Created by Kyle Oba on 11/18/13.
//  Copyright (c) 2013 Kyle Oba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AABallView : UIView
- (void)setInitialPosition:(CGPoint)position;
- (void)updatePosition;
@end
