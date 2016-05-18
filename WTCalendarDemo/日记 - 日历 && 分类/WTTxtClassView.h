//
//  WTTxtClassView.h
//  TheBeastStore
//
//  Created by 孙文强 on 15/11/3.
//  Copyright © 2015年 Winton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarDataModel.h"


@protocol WTTxtClassViewDelegate <NSObject>

- (void)maskTxtClassDidChangeClick;
- (void)hiddenDateView;

@end

@interface WTTxtClassView : UIView<UICollectionViewDataSource,UICollectionViewDelegate>
{

    NSMutableArray *classDataArrs;
    UICollectionView *classCollectionView;
}

@property (assign, nonatomic) id<WTTxtClassViewDelegate>delegate;

@end


@interface ProjectClassViewCell : UICollectionViewCell

@property (strong, nonatomic) CalendarDataModel *dateModel;

@end

