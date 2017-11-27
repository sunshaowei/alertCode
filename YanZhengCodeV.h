//
//  YanZhengCodeV.h
//  tuXingCode
//
//  Created by nankang on 2017/11/24.
//  Copyright © 2017年 nankang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YanZhengCodeV : UIView
@property (nonatomic, retain) NSArray *changeArray;
@property (nonatomic, retain) NSString *changeString;
@property (nonatomic, retain) UILabel *codeLabel;

-(void)changeCoden:(NSString*)str;
@end
