//
//  AAPaddleVC.h
//  Pong
//
//  Created by Kyle Oba on 11/17/13.
//  Copyright (c) 2013 Kyle Oba. All rights reserved.
//

@class AAPaddleVC;

#import <UIKit/UIKit.h>

@protocol AAPaddleVCDelegate <NSObject>
- (void)paddleVC:(AAPaddleVC *)paddleVC didLoadPaddleView:(UIView *)paddleView;
@end

@interface AAPaddleVC : UIViewController <UIGestureRecognizerDelegate>
@property (weak, nonatomic) id<AAPaddleVCDelegate> delegate;
@end
