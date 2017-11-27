//
//  CustomAlertView.h
//  CustomAlertView
//
//  Created by lanshang on 16/6/6.
//  Copyright © 2016年 luckyLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomAlertViewDelegate <NSObject>

@optional
-(void)clickChangButton:(UIView *)view;

-(void)clickButtonWithTag:(UIButton *)button;



@end



@interface CustomAlertView : UIView

@property (nonatomic,strong)UIView *backGroundView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UITextField *yanZhengF;
@property (nonatomic,strong)UIButton *changeB;
@property (nonatomic,strong)UIButton *canleButton;
@property (nonatomic,strong)UIButton *otherButton;
@property (nonatomic,strong)UILabel *horLabel;
@property (nonatomic,strong)UILabel *verLabel;

@property (nonatomic,assign)id<CustomAlertViewDelegate>delegate;

-(instancetype)initWithFrame:(CGRect)frame WithTitle:(NSString *)title andDetail:(NSString *)detail andBody:(NSString *)body andCancelTitle:(NSString *)cancelTitel andOtherTitle:(NSString *)otherTitle;

-(void)changCode:(NSString*)str;

@end
