//
//  ViewController.m
//  WTCalendarDemo
//
//  Created by Winton on 16/4/3.
//  Copyright © 2016年 Winton. All rights reserved.
//

#import "WTDateClassView.h"
#import "ViewController.h"

@interface ViewController ()<WTDateClassViewDelegate>
{

    WTDateClassView *dateClassView;
}
@end

#define AnimationTimer  0.22

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UILabel *downStretchingLb = [[UILabel alloc] init];
    downStretchingLb.textAlignment = NSTextAlignmentCenter;
    downStretchingLb.textColor = [UIColor blackColor];
    downStretchingLb.font = [UIFont systemFontOfSize:14];
    downStretchingLb.text = @"请向下拉";
    [self.view addSubview:downStretchingLb];
    
    [downStretchingLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(120, 66));
    }];
    
    [self createSwipeFullCalendar];
}

- (void)createSwipeFullCalendar {

    UISwipeGestureRecognizer *swipeture1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(moveDateViewOffWithUp:)];
    swipeture1.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeture1];
    
    
    UISwipeGestureRecognizer *swipeture2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(moveDateViewOffWithDown:)];
    swipeture2.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeture2];


    __weak typeof(self)weakSelf = self;
    dateClassView = [[WTDateClassView alloc] initWithFrame:CGRectMake(0, -220, SCREEN_Width, 220)];
    dateClassView.delegate = self;
    dateClassView.yearStatePull = ^(BOOL statePull) {
      
        [weakSelf updateMonth];
    };
    
    [self.view addSubview:dateClassView];
}


#pragma mark 日历滑动方法

/**
 *  手势 向上滑动
 *
 *  @param swipe <#swipe description#>
 */

- (void)moveDateViewOffWithUp:(UISwipeGestureRecognizer *)swipe {

    CGPoint offY = [swipe locationInView:self.view];
    CGFloat y = 0.f;
    
    if (swipe.state == UIGestureRecognizerStateBegan) {
        
        if (dateClassView.frame.origin.y < 0) {
            
            
            y = -220;
        }else {
            
            y = 0;
        }
        
    }else if (swipe.state == UIGestureRecognizerStateChanged){
        
        
    }else if (swipe.state == UIGestureRecognizerStateEnded){
        
        if (y < 0) return;
        
        CGRect frame = dateClassView.frame;
        
        if (y == 0 && frame.size.height == 220) {
            
            
            [UIView animateWithDuration:AnimationTimer animations:^{
                
                
                CGRect frame = dateClassView.frame;
                frame.origin.y = -220;
                dateClassView.frame = frame;
                
                dateClassView.state = StateDateInfoWeek;
                
            }];
            
        }else if (frame.size.height == 420){
            
            [UIView animateWithDuration:AnimationTimer animations:^{
                
                CGRect frame = dateClassView.frame;
                
                frame.size.height = 220;
                dateClassView.frame = frame;
                dateClassView.state = StateDateInfoWeek;
                
            }];
            
            
        }else if(frame.size.height == WT_Height && offY.y < WT_Height){
            
            [UIView animateWithDuration:AnimationTimer animations:^{
                CGRect frame = dateClassView.frame;
                frame.size.height = 420;
                dateClassView.frame = frame;
                
                dateClassView.state = StateDateInfoMonth;
                
            }];
            
        }
    }
}

/**
 *  手势向下滑动
 *
 *  @param swipe <#swipe description#>
 */
- (void)moveDateViewOffWithDown:(UISwipeGestureRecognizer *)swipe {

    CGPoint offY = [swipe locationInView:self.view];
    // CGFloat y = 0.f;
    
    if (swipe.state == UIGestureRecognizerStateBegan) {
        
        
    }else if (swipe.state ==UIGestureRecognizerStateChanged){
        
        
        
    }else if (swipe.state == UIGestureRecognizerStateEnded){
        
        CGRect frame = dateClassView.frame;
        if (frame.origin.y < 0) {
            
            [UIView animateWithDuration:AnimationTimer animations:^{
                
                CGRect frame = dateClassView.frame;
                frame.origin.y = 0;
                
                dateClassView.frame = frame;
                
                dateClassView.state = StateDateInfoWeek;
            }];
            
            
        }else if (frame.origin.y == 0 && offY.y > 0 && offY.y < 420){
            
            [UIView animateWithDuration:AnimationTimer animations:^{
                
                CGRect frame = dateClassView.frame;
                
                frame.origin.y = 0;
                frame.size.height = 420;
                
                dateClassView.frame = frame;
                dateClassView.state = StateDateInfoMonth;
                
            }];
            
        }else if(dateClassView.frame.size.height == 420 && offY.y > 0){
            
            [UIView animateWithDuration:AnimationTimer animations:^{
                
                CGRect frame = dateClassView.frame;
                
                frame.origin.y = 0;
                frame.size.height = WT_Height;
                
                dateClassView.frame = frame;
                
                dateClassView.state = StateDateInfoYear;
                
            } completion:^(BOOL finished) {
                
            }];
            
        }
    }
}



- (void)dateChangeOptionsClick:(BOOL)options {
    
    if (options) {
        //yes -> class
        
        [UIView animateWithDuration:AnimationTimer animations:^{
            
            CGRect frame = dateClassView.frame;
            frame.origin.y = 0;
            frame.size.height = 220;
            
            dateClassView.frame = frame;
            
            
        } completion:^(BOOL finished) {
            
            dateClassView.state = StateDateInfoWeek;

        
        }];
        
    }else{
        //No -> calendar
        
        [UIView animateWithDuration:AnimationTimer animations:^{
            
//            homeClassView.hidden = YES;
//            
//            [self.view sendSubviewToBack:homeClassView];
        }];
    }
}

- (void)updateMonth {

    CGRect frame = dateClassView.frame;
    
    frame.origin.y = 0;
    frame.size.height = 420;
    
    dateClassView.frame = frame;
    dateClassView.state = StateDateInfoMonth;
}


- (void)touchDateWithSwipeOffY {
    
    [UIView animateWithDuration:AnimationTimer animations:^{
        
        CGRect frame = dateClassView.frame;
        
        frame.origin.y = 0;
        frame.size.height = WT_Height;
        
        dateClassView.frame = frame;
        
        dateClassView.state = StateDateInfoYear;
        
    } completion:^(BOOL finished) {
        
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
