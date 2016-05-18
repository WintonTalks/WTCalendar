//
//  WTYearView.m
//  TheBeastStore
//
//  Created by 孙文强 on 15/11/16.
//  Copyright © 2015年 Winton. All rights reserved.
//

#import "WTYearView.h"

@implementation WTYearView

#define  MONTH_WITH_TAG   244446677
- (instancetype)init {

    self = [super init];
    
    if (self) {
        
        self.backgroundColor = [UIColor colorFromHexCode:@"#E7E7E7"];
        
        [self commViewInit];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];

    if (self) {
      
        self.backgroundColor = [UIColor colorFromHexCode:@"#E7E7E7"];
        
        [self commViewInit];
    }

    return self;
}

- (void)commViewInit {
    
    subTitleLb = [UILabel createInfoLabel:@"" font:APPFont_SabonLTStd_Roman(22) textAlignment:NSTextAlignmentCenter];
    [self addSubview:subTitleLb];
    
    [subTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(15);
        make.width.mas_equalTo(@110);
        make.height.mas_equalTo(@34);
    }];    
    
    [self addYearData];
    
    int y = 0, x = 0;
    for (int i = 0; i < dataArrs.count; i++) {
        
        if (i%3 == 0) {
            
            y ++;
            
            x = 0;
        }
        
        WTMonthInfoView *infoView = [[WTMonthInfoView alloc] init];
        infoView.userInteractionEnabled = YES;
        infoView.tag = MONTH_WITH_TAG + i;
        infoView.model = dataArrs[i];
        [self addSubview:infoView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(monthTapWithSelected:)];
        [infoView addGestureRecognizer:tapGesture];
        
        
        [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.mas_equalTo(self).with.offset(y * 105 + 5);
            make.left.mas_equalTo(@(x * 130 + 22));
            make.width.mas_equalTo(@72);
            make.height.mas_equalTo(@110);
        }];
        
        x++;
    }

}

- (void)setYearName:(NSString *)yearName {

    subTitleLb.text = yearName;
}

- (void)monthTapWithSelected:(UITapGestureRecognizer *)tapGesture {
    
    if (tapGesture.state == UIGestureRecognizerStateEnded) {
        
        [self recoveryWithView];
        
        WTMonthInfoView *infoView = (WTMonthInfoView *)tapGesture.view;

        infoView.selectedMonth = YES;
        
        if (_delegate && [_delegate respondsToSelector:@selector(didChangeMonthClick:)]) {
            
            [_delegate didChangeMonthClick:infoView.model.monthName];
        }
    }
}

- (void)recoveryWithView {

    for (int index = 0; index < 12; index++) {
        
        WTMonthInfoView *monthView = (WTMonthInfoView *)[self viewWithTag:MONTH_WITH_TAG + index];
        
        monthView.selectedMonth = NO;
    }
}

- (void)addYearData {
    
    dataArrs = [NSMutableArray new];
    
    WTAnnualModel *model1 = [WTAnnualModel new];
    model1.monthName = @"1";
    model1.monthEngName = @"Jan";


    WTAnnualModel *model2 = [WTAnnualModel new];
    model2.monthName = @"2";
    model2.monthEngName = @"Feb";
    
    
    WTAnnualModel *model3 = [WTAnnualModel new];
    model3.monthName = @"3";
    model3.monthEngName = @"Mar";
    
    WTAnnualModel *model4 = [WTAnnualModel new];
    model4.monthName = @"4";
    model4.monthEngName = @"Apr";
    
    
    WTAnnualModel *model5 = [WTAnnualModel new];
    model5.monthName = @"5";
    model5.monthEngName = @"May";
    
    
    WTAnnualModel *model6 = [WTAnnualModel new];
    model6.monthName = @"6";
    model6.monthEngName = @"Jun";
    
    
    WTAnnualModel *model7 = [WTAnnualModel new];
    model7.monthName = @"7";
    model7.monthEngName = @"Jul";
    
    
    WTAnnualModel *model8 = [WTAnnualModel new];
    model8.monthName = @"8";
    model8.monthEngName = @"Aug";
    
    
    WTAnnualModel *model9 = [WTAnnualModel new];
    model9.monthName = @"9";
    model9.monthEngName = @"Sep";
    
    WTAnnualModel *model10 = [WTAnnualModel new];
    model10.monthName = @"10";
    model10.monthEngName = @"Oct";
    
    
    WTAnnualModel *model11 = [WTAnnualModel new];
    model11.monthName = @"11";
    model11.monthEngName = @"Nov";
    

    WTAnnualModel *model12 = [WTAnnualModel new];
    model12.monthName = @"12";
    model12.monthEngName = @"Dec";

    
    [dataArrs addObject:model1];
    [dataArrs addObject:model2];
    [dataArrs addObject:model3];
    [dataArrs addObject:model4];
    [dataArrs addObject:model5];
    [dataArrs addObject:model6];
    [dataArrs addObject:model7];
    [dataArrs addObject:model8];
    [dataArrs addObject:model9];
    [dataArrs addObject:model10];
    [dataArrs addObject:model11];
    [dataArrs addObject:model12];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end


@implementation WTMonthInfoView

- (instancetype)init {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    yearLb = [UILabel createInfoLabel:@"" font:APPFont_AkzidenzGroteskBQ_LigCnd(60) textAlignment:NSTextAlignmentCenter];
    [self addSubview:yearLb];
    
    [yearLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(@0);
        make.left.mas_equalTo(@0);
        make.width.mas_equalTo(@84);
        make.height.mas_equalTo(@115);
    }];
    
    
    engLb = [UILabel createInfoLabel:@"" font:APPFont_SabonLTStd_Roman(14) textAlignment:NSTextAlignmentCenter];
    [self addSubview:engLb];
    
    [engLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(yearLb).with.offset(80);
        make.left.mas_equalTo(yearLb).with.offset(19);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(@34);
    }];
    
    
    lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor clearColor];
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(engLb).with.offset(32);
        make.left.mas_equalTo(yearLb).with.offset(26);
        make.width.mas_equalTo(@38);
        make.height.mas_equalTo(@12);
        
    }];
    
    return self;
}

- (void)setSelectedMonth:(BOOL)selectedMonth {
    
    if (selectedMonth) {
        
        yearLb.textColor = [UIColor colorFromHexCode:@"#BE9F65"];
        engLb.textColor = [UIColor colorFromHexCode:@"#BE9F65"];
        lineView.backgroundColor = [UIColor colorFromHexCode:@"#BE9F65"];
    }else {
        
        yearLb.textColor = [UIColor blackColor];
        engLb.textColor = [UIColor blackColor];
        lineView.backgroundColor = [UIColor clearColor];
    }
}

- (void)setModel:(WTAnnualModel *)model {
    
    yearLb.text = model.monthName;
    engLb.text = model.monthEngName;
}

@end


