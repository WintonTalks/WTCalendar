//
//  CalendarDataModel.h
//  TheBeastStore
//
//  Created by Winton on 15/10/13.
//  Copyright © 2015年 Winton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarDataModel : NSObject

@property (strong, nonatomic) NSString *name, *imgUrl;

@end


@interface WTDateTxtDataModel : NSObject

@property (strong, nonatomic) NSString *dateName, *engTitle, *infoTitle, *subTitle;

@property (strong, nonatomic) UIImage *titleImg;

@end


@interface WTAnnualModel : NSObject

@property (strong, nonatomic) NSString *monthName,*monthEngName;

@end
