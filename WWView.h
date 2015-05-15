//
//  WWView.h
//  手势解锁
//
//  Created by 王威 on 15/4/19.
//  Copyright (c) 2015年 zju. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WWView;

@protocol WWViewDelegate <NSObject>

@optional

-(void)view:(WWView*)view didFinishPath:(NSString*)path;

@end

@interface WWView : UIView
@property (nonatomic, weak)IBOutlet  id<WWViewDelegate>  delegate;
@end
