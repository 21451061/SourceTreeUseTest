//
//  WWCircleView.m
//  手势解锁
//
//  Created by 王威 on 15/4/26.
//  Copyright (c) 2015年 zju. All rights reserved.
//

#import "WWCircleView.h"

@implementation WWCircleView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

-(void)setup
{
    self.userInteractionEnabled = NO;
    [self setBackgroundImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
}
@end
