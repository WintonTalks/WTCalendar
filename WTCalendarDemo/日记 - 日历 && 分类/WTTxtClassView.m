//
//  WTTxtClassView.m
//  TheBeastStore
//
//  Created by 孙文强 on 15/11/3.
//  Copyright © 2015年 Winton. All rights reserved.
//

#import "WTTxtClassView.h"

@implementation WTTxtClassView

#define MainWidth self.bounds.size.width


- (instancetype)init {

    self = [super init];

    if (self) {
        
    self.backgroundColor = [UIColor whiteColor];
    [self commView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];

    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self commView];
    }
    
    return self;
}

- (void)commView {

    classDataArrs = [NSMutableArray new];
    
    UICollectionViewFlowLayout *flowLayot = [[UICollectionViewFlowLayout alloc] init];
    flowLayot.sectionInset = UIEdgeInsetsZero;
    flowLayot.itemSize = CGSizeMake(MainWidth/2,MainWidth/2);
    flowLayot.minimumLineSpacing = 0;
    flowLayot.minimumInteritemSpacing = 0;
    
    classCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height - 65) collectionViewLayout:flowLayot];
    classCollectionView.collectionViewLayout = flowLayot;
    classCollectionView.backgroundColor = [UIColor clearColor];
    classCollectionView.delegate = self;
    classCollectionView.dataSource = self;
    [classCollectionView registerClass:[ProjectClassViewCell class] forCellWithReuseIdentifier:@"DataClassReuseIdentifier"];
    [self addSubview:classCollectionView];

    
    [self addData];
}


/**
 *  模拟数据- 本地
 */
- (void)addData {
    
    CalendarDataModel *model1 = [CalendarDataModel new];
    model1.name = @"# 关于工作";
    model1.imgUrl = @"http://oss.thebeastshop.com/image/m20151110041053005045.png";
    
    
    CalendarDataModel *model2 = [CalendarDataModel new];
    model2.name = @"# 关于工作";
    model2.imgUrl = @"http://oss.thebeastshop.com/image/m20151110041053005045.png";
    
    CalendarDataModel *model3 = [CalendarDataModel new];
    model3.name = @"# 关于工作";
    model3.imgUrl = @"http://oss.thebeastshop.com/image/m20151110041053005045.png";
    
    
    CalendarDataModel *model4 = [CalendarDataModel new];
    model4.name = @"关于餐具";
    model4.imgUrl = @"http://oss.thebeastshop.com/image/m20151110041053005045.png";
    
    
    CalendarDataModel *model5 = [CalendarDataModel new];
    model5.name = @"关于时尚";
    model5.imgUrl = @"http://oss.thebeastshop.com/image/m20151110041053005045.png";
    
    CalendarDataModel *model6 = [CalendarDataModel new];
    model6.name = @"关于家居";
    model6.imgUrl = @"http://oss.thebeastshop.com/image/m20151110041053005045.png";
    
    
    [classDataArrs addObject:model1];
    [classDataArrs addObject:model2];
    [classDataArrs addObject:model3];
    [classDataArrs addObject:model4];
    [classDataArrs addObject:model5];
    [classDataArrs addObject:model6];
    
    
    [classCollectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return classDataArrs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ProjectClassViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DataClassReuseIdentifier" forIndexPath:indexPath];
    
    CalendarDataModel *dateModel = classDataArrs[indexPath.row];
    
    cell.dateModel = dateModel;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_delegate && [_delegate respondsToSelector:@selector(maskTxtClassDidChangeClick)]) {
        
        [_delegate maskTxtClassDidChangeClick];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (scrollView == classCollectionView) {
        
        CGPoint offY = classCollectionView.contentOffset;
        
        if (offY.y < -10) {
            
            if (_delegate && [_delegate respondsToSelector:@selector(hiddenDateView)]) {
                [_delegate hiddenDateView];
            }
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end



@implementation ProjectClassViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UIImageView *mdImageView = [[UIImageView alloc] init];
        mdImageView.tag = 2033456;
        [self.contentView addSubview:mdImageView];
        
        [mdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        
        UILabel *mdNameLb = [[UILabel alloc] init];
        mdNameLb.textColor = [UIColor colorFromHexCode:@"#000000"];
        mdNameLb.textAlignment = NSTextAlignmentLeft;
        mdNameLb.font = APPFont_DFPHeiW5(20);
        mdNameLb.tag = 26666899;
        [self.contentView addSubview:mdNameLb];
        
        [mdNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.left.mas_equalTo(@54);
            make.bottom.mas_equalTo(@9.5);
            make.width.mas_equalTo(@150);
            make.height.mas_equalTo(@34);
        }];
    }
    
    return self;
}

- (void)setDateModel:(CalendarDataModel *)dateModel {
    
//    UIImageView *mdImageView = (UIImageView *)[self.contentView viewWithTag:2033456];
//    [mdImageView setImageWithURL:[NSURL URLWithString:dateModel.imgUrl]];
    
    UILabel *mdNameLb = (UILabel *)[self.contentView viewWithTag:26666899];
    mdNameLb.text = dateModel.name;
}

@end


