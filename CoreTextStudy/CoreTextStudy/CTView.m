//
//  CTView.m
//  CoreTextStudy
//
//  Created by 臧金晓 on 13-7-11.
//  Copyright (c) 2013年 臧金晓. All rights reserved.
//

#import "CTView.h"
#import <CoreText/CoreText.h>

@implementation CTView

- (void)drawRect:(CGRect)rect
{
    NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc]initWithString:@"新组建的四个部门分别是：操作系统技术集团（Operating Systems Engineering Group）；设备与工作室技术集团（Devices and Studios Engineering Group）；应用与服务技术集团（Applications and Services Engineering Group）；云与娱乐技术集团（Cloud and Enterprise Engineering Group）。"];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGPathRef path = CGPathCreateWithRect(CGRectMake(0, 20, 320, 460), NULL);
    CTFontRef font = CTFontCreateWithName(CFSTR("Helvetica"), 18, NULL);
    [aStr addAttribute:(id)kCTFontAttributeName value:(id)font range:NSMakeRange(0, aStr.length)];
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)aStr);
    CFRange range;
    CGSize size = CTFramesetterSuggestFrameSizeWithConstraints(frameSetter, CFRangeMake(0, aStr.length), NULL, CGSizeMake(320, 120), &range);
    NSLog(@"%@",NSStringFromCGSize(size));
    NSLog(@"%ld",range.length);
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, range.length), path, NULL);
    //CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -480);
    CTFrameDraw(frame, context);
    
}

@end
