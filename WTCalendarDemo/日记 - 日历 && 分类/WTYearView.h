//
//  WTYearView.h
//  TheBeastStore
//
//  Created by 孙文强 on 15/11/16.
//  Copyright © 2015年 Winton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarDataModel.h"

@protocol WTYearViewDelegate <NSObject>

- (void)didChangeMonthClick:(NSString *)monthName;

@end

@interface WTYearView : UIView
{
    NSMutableArray *dataArrs;
    UILabel *subTitleLb;
}

@property (assign, nonatomic) id<WTYearViewDelegate>delegate;

@property (strong, nonatomic) NSString *yearName;

@end


@interface WTMonthInfoView : UIView
{

    UIView *lineView;
    UILabel *yearLb, *engLb;
}

@property (assign, nonatomic) BOOL selectedMonth;

@property (strong, nonatomic) WTAnnualModel *model;

@end
