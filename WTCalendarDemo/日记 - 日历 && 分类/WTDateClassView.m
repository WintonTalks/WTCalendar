//
//  WTDateClassView.m
//  TheBeastStore
//
//  Created by 孙文强 on 15/10/14.
//  Copyright © 2015年 Winton. All rights reserved.
//

#import "CalendarDataModel.h"
#import "WTDateClassView.h"


@implementation WTDateClassView

- (instancetype)init {

    self = [super init];

    if (self) {
        
    self.backgroundColor = [UIColor colorFromHexCode:@"#E7E7E7"];
        
    [self commViewInit];
    
    }

    return self;
}


-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
    self.backgroundColor = [UIColor colorFromHexCode:@"#E7E7E7"];

    [self commViewInit];
    }
    
    return self;
}

- (void)commViewInit {
    
    UIButton *dateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dateBtn setTitle:@"日期" forState:UIControlStateNormal];
    [dateBtn setTitleColor:RGB_Color(175/255., 130/255., 63/255.) forState:UIControlStateNormal];//默认选中颜色
    [dateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [dateBtn addTarget:self action:@selector(infoDateButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:dateBtn];
    
    [dateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(@15);
        make.left.mas_equalTo(@55);
        make.width.mas_equalTo(@60);
        make.height.mas_equalTo(@35);
    }];
    
    
    UIButton *makeClassBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [makeClassBtn setTitle:@"分类" forState:UIControlStateNormal];
    [makeClassBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [makeClassBtn setTitleColor:RGB_Color(175/255., 130/255., 63/255.) forState:UIControlStateSelected];
    [makeClassBtn addTarget:self action:@selector(infoClassButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:makeClassBtn];
    
    [makeClassBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(@15);
        make.left.mas_equalTo(dateBtn).with.offset(180);
        make.width.mas_equalTo(@60);
        make.height.mas_equalTo(@35);
    }];
    
    
    UIView *stateLineView = [[UIView alloc] init];
    stateLineView.backgroundColor = RGB_Color(207/255., 207/255., 207/255.);
    [self addSubview:stateLineView];
    
    [stateLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(@64);
        make.left.mas_equalTo(@0);
        make.width.mas_equalTo(self);
        make.height.mas_equalTo(@1);
        
    }];
    
   
    //选中状态的线条
    lineChangeView = [UIView new];
    lineChangeView.backgroundColor = [UIColor colorFromHexCode:@"#BE9F65"];
    [stateLineView addSubview:lineChangeView];
    
    [lineChangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(@0);
        make.left.mas_equalTo(dateBtn);
        make.width.mas_equalTo(@60);
        make.height.mas_equalTo(@1);
    }];
    
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(moveOffWithDown:)];
    swipe.direction = UISwipeGestureRecognizerDirectionDown;
    [self addGestureRecognizer:swipe];
    
    
    calendarManager = [JTCalendarManager new];
    calendarManager.delegate = self;
    calendarManager.settings.weekDayFormat = JTCalendarWeekDayFormatShort;
    calendarManager.dateHelper.calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    calendarManager.settings.weekModeEnabled = YES;
    
    [self createRandomEvents];
    
    calendarMenuView = [[JTCalendarMenuView alloc] initWithFrame:CGRectMake(0, 65, SCREEN_Width, 64)];
    [self addSubview:calendarMenuView];
    
    
    calendarContentView = [[JTHorizontalCalendarView alloc] initWithFrame:CGRectMake(0, 129, SCREEN_Width, 85)];
    calendarContentView.delegate = self;
    [self addSubview:calendarContentView];
   
    
    [calendarManager setMenuView:calendarMenuView];
    [calendarManager setContentView:calendarContentView];
    [calendarManager setDate:[NSDate date]];
    

    _yearView = [[WTYearView alloc] initWithFrame:CGRectMake(0, 65, SCREEN_Width, SCREEN_Height - 65)];
    _yearView.delegate = self;
    _yearView.yearName = @"2015";
    _yearView.hidden = YES;
    [self addSubview:_yearView];
    [self sendSubviewToBack:_yearView];
    
}

- (void)moveOffWithDown:(UISwipeGestureRecognizer *)swipeTure {

    CGPoint offY = [swipeTure locationInView:self];
    
    if (swipeTure.state == UIGestureRecognizerStateEnded) {
        
        if (self.height == 220 && offY.y > 0) {
            
            if (_delegate && [_delegate respondsToSelector:@selector(touchDateWithSwipeOffY:)]) {
                [_delegate touchDateWithSwipeOffY:0];
            }

        }else if (self.height == 420 && offY.y > 0) {
            
            if (_delegate && [_delegate respondsToSelector:@selector(touchDateWithSwipeOffY:)]) {
                [_delegate touchDateWithSwipeOffY:1];
            }
        }
    }
}

/**
 *  日历
 *
 *  @param dateButton <#dateButton description#>
 */
- (void)infoDateButtonClick:(UIButton *)dateButton {
    
    CGRect lineMoveFrame = lineChangeView.frame;
    
    if (lineMoveFrame.origin.x > 55) {
        
        lineMoveFrame.origin.x = 55;
        lineChangeView.frame = lineMoveFrame;
    }

    [UIView animateWithDuration:0.25 animations:^{
        
        if (_delegate && [_delegate respondsToSelector:@selector(dateChangeOptionsClick:)]) {
            
            [_delegate dateChangeOptionsClick:NO];
        }
    }];
    
}

/**
 *  分类
 *
 *  @param classButton <#classButton description#>
 */
- (void)infoClassButtonClick:(UIButton *)classButton {
    
    CGRect lineMoveFrame = lineChangeView.frame;
    
    if (lineMoveFrame.origin.x < 235) {
        
        lineMoveFrame.origin.x = 235;
        lineChangeView.frame = lineMoveFrame;
    }
   
    [UIView animateWithDuration:0.25 animations:^{
        
        
        if (_delegate && [_delegate respondsToSelector:@selector(dateChangeOptionsClick:)]) {
            
            [_delegate dateChangeOptionsClick:YES];
        }
        
    }];
        
}


#pragma mark 滑动的 范围的 日历
- (void)setState:(InfoDateOffState)state {

    _state = state;

    [self reloadDateView];
}

- (void)reloadDateView {
    
   CATransition *anima = [self fadeAnimation];
    
    if (_state == StateDateInfoWeek) {
        
        
        [calendarContentView.layer addAnimation:anima forKey:@"fadeAnimation"];

        
        [UIView animateWithDuration:0.25 animations:^{
            
            _yearView.hidden = YES;
            
            calendarManager.settings.weekModeEnabled = YES;
            
            [calendarManager reload];
            
            CGRect dateFrame = calendarContentView.frame;
            dateFrame.size.height = 85;
            
            calendarContentView.frame = dateFrame;
        
            
        }];
        
    }else if (_state == StateDateInfoMonth){
       
        [calendarContentView.layer addAnimation:anima forKey:@"fadeAnimation"];

        
        [UIView animateWithDuration:0.25 animations:^{
            
            calendarMenuView.hidden = NO;
            calendarContentView.hidden = NO;
            
            _yearView.hidden = YES;
            
            [self sendSubviewToBack:_yearView];
 
        } completion:^(BOOL finished) {
            
            calendarManager.settings.weekModeEnabled = NO;
            
            [calendarManager reload];
            
            
            CGRect dateFrame = calendarContentView.frame;
            dateFrame.size.height = 300;
            
            calendarContentView.frame = dateFrame;
        }];
        
    }else{
    
        [_yearView.layer addAnimation:anima forKey:@"fadeAnimation"];
        
        [UIView animateWithDuration:0.25 animations:^{
            
            calendarMenuView.hidden = YES;
            calendarContentView.hidden = YES;
            
            _yearView.hidden = NO;
            
            [self bringSubviewToFront:_yearView];
        }];
    }
}

/**
 *  点击的月份
 *
 *  @param monthName <#monthName description#>
 */
- (void)didChangeMonthClick:(NSString *)monthName {
    
    
    [UIView animateWithDuration:0.1 animations:^{
        
        CATransition *anima = [self fadeAnimation];
        [_yearView.layer addAnimation:anima forKey:@"fadeAnimation"];
        
        _yearView.hidden = YES;
        [self sendSubviewToBack:_yearView];
        
        calendarMenuView.hidden = NO;
        calendarContentView.hidden = NO;

        NSTimeInterval indexPageMonth = (NSTimeInterval)[monthName integerValue];
        
        [calendarManager.contentView setDate:[NSDate dateWithTimeIntervalSinceNow:indexPageMonth]];
    }];
    
    if (self.yearStatePull) {
        self.yearStatePull(true);
    }
}

#pragma mark - CalendarManager delegate

// Exemple of implementation of prepareDayView method
// Used to customize the appearance of dayView
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    dayView.hidden = NO;
   // dayView.circleView.hidden = YES;

    // Other month
    if([dayView isFromAnotherMonth]){
        dayView.hidden = YES;
    }
    // Today
    else if([calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;

        dayView.textLabel.textColor = [UIColor colorFromHexCode:@"#BE9F65"];
    }
    // Selected date
    else if(_dateSelected && [calendarManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]){
        
        dayView.circleView.hidden = NO;

        dayView.textLabel.textColor =  [UIColor colorFromHexCode:@"#BE9F65"];
    }
    // Another day of the current month 整月的样式
    else{
        dayView.circleView.hidden = YES;

        dayView.textLabel.textColor = [UIColor blackColor];
    }
    
    
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    _dateSelected = dayView.date;
    
    // Animation for the circleView
    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView transitionWithView:dayView
                      duration:.3
                       options:0
                    animations:^{
                        dayView.circleView.transform = CGAffineTransformIdentity;
                        [calendarManager reload];
                    } completion:nil];
    
    
    // Load the previous or next page if touch a day from another month
    
    if(![calendarManager.dateHelper date:calendarContentView.date isTheSameMonthThan:dayView.date]){
        if([calendarContentView.date compare:dayView.date] == NSOrderedAscending){
            [calendarContentView loadNextPageWithAnimation];
        }
        else{
            [calendarContentView loadPreviousPageWithAnimation];
        }
    }
}

#pragma mark - Views customization
//标题 月份
- (UIView *)calendarBuildMenuItemView:(JTCalendarManager *)calendar
{
    UILabel *label = [UILabel new];
    
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.font = APPFont_SabonLTStd_Roman(22);
    
    return label;
}

/*！
  *用于定制menuItemView。
  *设置文本属性月份默认的名称。
  */
- (void)calendar:(JTCalendarManager *)calendar prepareMenuItemView:(UILabel *)menuItemView date:(NSDate *)date
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"MMM";
        
        dateFormatter.locale = calendarManager.dateHelper.calendar.locale;
        dateFormatter.timeZone = calendarManager.dateHelper.calendar.timeZone;
    }
    
    menuItemView.text = [dateFormatter stringFromDate:date];
}

- (UIView<JTCalendarWeekDay> *)calendarBuildWeekDayView:(JTCalendarManager *)calendar
{
    JTCalendarWeekDayView *view = [JTCalendarWeekDayView new];
    
    for(UILabel *label in view.dayViews){
        label.textColor = [UIColor blackColor];
        label.font = APPFont_SabonLTStd_Roman(13);
    }
    
    return view;
}

- (UIView<JTCalendarDay> *)calendarBuildDayView:(JTCalendarManager *)calendar
{
    JTCalendarDayView *view = [JTCalendarDayView new];
    view.circleView.hidden = YES;
    view.textLabel.font = APPFont_AkzidenzGroteskBQ_LigCnd(27);
    view.textLabel.textColor = [UIColor blackColor];
    
    view.circleRatio = .8;
    view.dotRatio = 1. / .9;
    
    return view;
}


- (void)createRandomEvents {

    _eventsByDate = [NSMutableDictionary new];

    for (int i = 0; i < 30; i++) {
        
        NSDate *randomDate = [NSDate dateWithTimeInterval:rand()%(3600 * 24 * 60) sinceDate:[NSDate date]];
        
        NSString *key = [[self dateFormatter] stringFromDate:randomDate];
        
        if (!_eventsByDate[key]) {
            _eventsByDate[key] = [NSMutableArray new];
        }
        
        [_eventsByDate[key] addObject:randomDate];
    }
}

//
//- (BOOL)haveEventForDay:(NSDate *)date
//{
//    NSString *key = [[self dateFormatter] stringFromDate:date];
//    
//    if(_eventsByDate[key] && [_eventsByDate[key] count] > 0){
//        return YES;
//    }
//    
//    return NO;
//}

- (NSDateFormatter *)dateFormatter {

    static NSDateFormatter *dateFormatter;
    if (!dateFormatter) {
        
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd-MM-yyyy";
        
    }

    return dateFormatter;
}

 - (CATransition *)fadeAnimation {
 
     CATransition *anima = [CATransition animation];
     anima.type = kCATransitionFade;
     anima.subtype = kCATransitionPush;
     anima.duration = 1.0f;
     
     return anima;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
