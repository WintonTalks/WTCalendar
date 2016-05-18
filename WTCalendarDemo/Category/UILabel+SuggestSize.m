//
//  UILabel+SuggestSize.m
//  WordPress
//
//  Created by Eric J on 6/18/13.
//  Copyright (c) 2013 WordPress. All rights reserved.
//

#import "UILabel+SuggestSize.h"

@implementation UILabel (SuggestSize)

+ (UILabel *)createInfoLabel:(NSString *)name
                        font:(UIFont *)font
               textAlignment:(NSTextAlignment)textAlignment {

    UILabel *infoLb = [[UILabel alloc] init];
    infoLb.font = font;
    infoLb.text = name;
    infoLb.textAlignment = textAlignment;
    infoLb.textColor = [UIColor blackColor];
    infoLb.numberOfLines = 0;

    return infoLb;
}


- (CGSize)suggestedSizeForWidth:(CGFloat)width {
    if (self.attributedText)
        return [self suggestSizeForAttributedString:self.attributedText width:width];
    
	return [self suggestSizeForString:self.text width:width];
}

- (CGSize)suggestSizeForAttributedString:(NSAttributedString *)string width:(CGFloat)width {
    if (!string) {
        return CGSizeZero;
    }
    return [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
}

- (CGSize)suggestSizeForString:(NSString *)string width:(CGFloat)width {
    if (!string) {
        return CGSizeZero;
    }
    return [self suggestSizeForAttributedString:[[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: self.font}] width:width];
}

@end
