//
//  WTDateClassView.h
//  TheBeastStore
//
//  Created by 孙文强 on 15/10/14.
//  Copyright © 2015年 Winton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTYearView.h"
#import "JTCalendar.h"

typedef NS_ENUM(NSUInteger, InfoDateOffState){

    StateDateInfoWeek,
    StateDateInfoMonth,
    StateDateInfoYear
};

@protocol WTDateClassViewDelegate <NSObject>

- (void)dateChangeOptionsClick:(BOOL)options;

- (void)touchDateWithSwipeOffY:(NSUInteger)indexTag;

@end


@interface WTDateClassView : UIView<JTCalendarDelegate, WTYearViewDelegate, UIScrollViewDelegate>
{
    JTCalendarManager *calendarManager;
    JTCalendarMenuView *calendarMenuView;
    
    JTHorizontalCalendarView *calendarContentView;
        
    UIView *lineChangeView;
    
    NSMutableDictionary *_eventsByDate;
    
    NSDate *_dateSelected;

}

@property (assign, nonatomic) InfoDateOffState state;

@property (strong, nonatomic) WTYearView *yearView;

@property (assign, nonatomic) id<WTDateClassViewDelegate>delegate;

@property (nonatomic, copy) void (^yearStatePull)(BOOL);

@end


