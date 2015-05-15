//
//  ViewController.m
//  手势解锁
//
//  Created by 王威 on 15/4/18.
//  Copyright (c) 2015年 zju. All rights reserved.
//

#import "ViewController.h"
#import "WWView.h"

@interface ViewController ()<WWViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}



-(void)view:(WWView *)view didFinishPath:(NSString *)path
{
    NSLog(@"捕捉手势路径%@", path);
}

@end
