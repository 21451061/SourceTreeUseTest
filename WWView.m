//
//  WWView.m
//  手势解锁
//
//  Created by 王威 on 15/4/19.
//  Copyright (c) 2015年 zju. All rights reserved.
//

#import "WWView.h"
#import "WWCircleView.h"

@interface WWView ()

@property (nonatomic, strong) NSMutableArray * selectedButtons;
@property (nonatomic, assign)  CGPoint currentMovePoint;
@end
@implementation WWView

-(NSMutableArray *)selectedButtons
{
    if (_selectedButtons == nil) {
        _selectedButtons = [NSMutableArray array];
    }
    return _selectedButtons;
}

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
    for (int i = 0; i < 9; ++i) {
        WWCircleView* btn = [WWCircleView buttonWithType:UIButtonTypeCustom];
        
        btn.tag = i;
        
        [self addSubview:btn];
    }
}

-(void)layoutSubviews
{
    CGFloat btnW = 74;
    CGFloat btnH = btnW;
    int columns = 3;
    CGFloat marginX = (self.frame.size.width - columns * btnW) / (columns + 1);
    CGFloat marginY = marginX;
    
    for (int index = 0; index < self.subviews.count; ++index) {
        int row = index / columns;
        int col = index % columns;
        CGFloat btnX = marginX + col * (btnW + marginX);
        CGFloat btnY = row * (btnH + marginY);
        WWCircleView* btn = self.subviews[index];
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}

#pragma mark -  私有方法
- (CGPoint)pointWithTouches:(NSSet*)touches
{
    UITouch* touche = [touches anyObject];
    return [touche locationInView:touche.view];
}

- (WWCircleView*)buttonWithPoint:(CGPoint)point
{
    for (WWCircleView* btn in self.subviews) {
        CGFloat wh = 24;
        CGFloat frameX = btn.center.x - wh * 0.5;
        CGFloat frameY = btn.center.y - wh * 0.5;
        if (CGRectContainsPoint(CGRectMake(frameX, frameY, wh, wh), point)) {
            return btn;
        }
    }
    return nil;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    [self touchesMoved:touches withEvent:event];
    CGPoint pos = [self pointWithTouches:touches];
    WWCircleView* btn = [self buttonWithPoint:pos];
    self.currentMovePoint = pos;

    if (btn && [self.selectedButtons containsObject:btn] == NO) {
        btn.selected = YES;
        [self.selectedButtons addObject:btn];
    }else{
        self.currentMovePoint = pos;
    }
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint pos = [self pointWithTouches:touches];
    WWCircleView* btn = [self buttonWithPoint:pos];
    if (btn && [self.selectedButtons containsObject:btn] == NO) {
        btn.selected = YES;
        [self.selectedButtons addObject:btn];
    }else{
        self.currentMovePoint = pos;
    }
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSMutableString* path = [NSMutableString string];
    for (WWCircleView* btn in self.selectedButtons) {
        [path appendFormat:@"%d", btn.tag];
    }
    
    if ([self.delegate respondsToSelector:@selector(view:didFinishPath:)]) {
        [self.delegate view:self didFinishPath:path];
    }
    
    [self.selectedButtons makeObjectsPerformSelector:@selector(setSelected:) withObject:@(NO)];
    [self.selectedButtons removeAllObjects];
    [self setNeedsDisplay];
}

- (void)setButtonSelectedNo:(WWCircleView*)btn
{
    btn.selected = NO;
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
}

-(void)drawRect:(CGRect)rect
{
    if (self.selectedButtons.count == 0) {
        return;
    }
    UIBezierPath* path = [UIBezierPath bezierPath];
    for (int index = 0; index < self.selectedButtons.count; ++index) {
        WWCircleView* btn = self.selectedButtons[index];
        if (index == 0) {
            [path moveToPoint:btn.center];
        }else{
            [path addLineToPoint:btn.center];
        }
    }
    
    [path addLineToPoint:self.currentMovePoint];
    path.lineJoinStyle = kCGLineJoinBevel;
//    [[UIColor greenColor] set];
    [[UIColor colorWithRed:32/255.0 green:210/255.0 blue:254/255.0 alpha:0.7] set];
    path.lineWidth = 8;
    [path stroke];
}
@end
