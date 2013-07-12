//
//  CTView.m
//  CoreTextStudy
//
//  Created by 臧金晓 on 13-7-11.
//  Copyright (c) 2013年 臧金晓. All rights reserved.
//

#import "CTView.h"
#import <CoreText/CoreText.h>

#define jxLog NSLog(@"%s",__FUNCTION__)

@implementation CTView

void deallocCallBack(void *p)
{
    jxLog;
}
CGFloat RunDelegateGetAscentCallback( void *refCon ){
    NSString *imageName = (NSString *)refCon;
    return 30;//[UIImage imageNamed:imageName].size.height;
}

CGFloat RunDelegateGetDescentCallback(void *refCon){
    return 0;
}
//CTRun的回调，获取宽度
CGFloat RunDelegateGetWidthCallback(void *refCon){
    NSString *imageName = (NSString *)refCon;
    return 30;//[UIImage imageNamed:imageName].size.width;
}

- (void)drawRect:(CGRect)rect
{
    NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc]initWithString:@" 新组建的四个部门分别是：操作系统技术集团（Operating Systems Engineering Group）；设备与工作室技术集团（Devices and Studios Engineering Group）；应用与服务技术集团（Applications and Services Engineering Group）；云与娱乐技术集团（Cloud and Enterprise Engineering Group）。"];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGPathRef path = CGPathCreateWithRect(CGRectMake(0, 20, 320, 460), NULL);
    CTFontRef font = CTFontCreateWithName(CFSTR("Helvetica"), 18, NULL);
    [aStr addAttribute:(id)kCTFontAttributeName value:(id)font range:NSMakeRange(0, aStr.length)];
    CTRunDelegateCallbacks callBack;
    callBack.version = kCTRunDelegateVersion1;
    callBack.dealloc = deallocCallBack;
    callBack.getAscent = RunDelegateGetAscentCallback;
    callBack.getWidth = RunDelegateGetWidthCallback;
    callBack.getDescent = RunDelegateGetDescentCallback;
    CTRunDelegateRef rundelegate = CTRunDelegateCreate(&callBack, NULL);
    [aStr addAttribute:(id)kCTRunDelegateAttributeName value:(id)rundelegate range:NSMakeRange(0, 1)];
    [aStr addAttribute:@"imageName" value:@"社保" range:NSMakeRange(0, 1)];
    //[aStr addAttribute:@"imageName" value:imageName range:NSMakeRange(0, 9)];
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)aStr);
    CFRange range;
    CGSize size = CTFramesetterSuggestFrameSizeWithConstraints(frameSetter, CFRangeMake(0, aStr.length), NULL, CGSizeMake(320, 460), &range);
    NSLog(@"%@",NSStringFromCGSize(size));
    NSLog(@"%ld",range.length);
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, MIN(aStr.length, range.length)), path, NULL);
    //CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -480);
    CTFrameDraw(frame, context);
    
}

@end
