//
//  CustomAlertView.m
//  CustomAlertView
//
//  Created by lanshang on 16/6/6.
//  Copyright © 2016年 luckyLin. All rights reserved.
//

#import "CustomAlertView.h"
#import "YanZhengCodeV.h"
#define ALERTVIEWWIDTH   ([UIScreen mainScreen].bounds.size.width-70)

@interface CustomAlertView ()<UITextFieldDelegate>
@property YanZhengCodeV*codeV;//验证码v
@property NSString*rightStr;//正确的验证码
@property UILabel*wrongL;//错误label提示

@end

@implementation CustomAlertView


-(instancetype)initWithFrame:(CGRect)frame WithTitle:(NSString *)title andDetail:(NSString *)detail andBody:(NSString *)body andCancelTitle:(NSString *)cancelTitel andOtherTitle:(NSString *)otherTitle
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        _rightStr= detail;
        [self createUIWithTitle:title andDetail:detail andBody:body andCancelTitle:cancelTitel andOtherTitle:otherTitle];
        
    }
    return self;
    
    
}

-(void)createUIWithTitle:(NSString *)title andDetail:(NSString *)detail andBody:(NSString *)body andCancelTitle:(NSString *)cancelTitel andOtherTitle:(NSString *)otherTitle
{
    //显示警示框的布局
    self.backGroundView = [[UIView alloc]init];
    self.backGroundView.center = self.center;
    self.backGroundView.backgroundColor=[UIColor whiteColor];
    self.backGroundView.layer.masksToBounds = YES;
    self.backGroundView.layer.cornerRadius = 5;
    [self addSubview:self.backGroundView];
    
    //title的设置
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = [UIColor orangeColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = title;
    CGFloat titleHeight = 30;
    self.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    self.titleLabel.frame = CGRectMake(20, 15, ALERTVIEWWIDTH-20*2, titleHeight);
    self.titleLabel.numberOfLines = 0;
    [self.backGroundView addSubview:self.titleLabel];
    
    //验证码下面的一条线
    UIView*yanZhengL=[[UIView alloc] initWithFrame:CGRectMake(20, self.titleLabel.frame.origin.y+titleHeight+10, ALERTVIEWWIDTH-20*2, 1)];
    yanZhengL.backgroundColor=[UIColor orangeColor];
    [self.backGroundView addSubview:yanZhengL];
    
    //我的需要判断下你是不是外星人？
    UILabel*weL=[[UILabel alloc] initWithFrame:CGRectMake(yanZhengL.frame.origin.x, yanZhengL.frame.origin.y+8, yanZhengL.bounds.size.width, 30)];
    weL.text=@"我的需要判断下你是不是外星人？";
    weL.font=[UIFont systemFontOfSize:15];
    [self.backGroundView addSubview:weL];
    
    
    //验证码的输入框
    self.yanZhengF = [[UITextField alloc]init];
    self.yanZhengF.delegate=self;
    self.yanZhengF.clearsOnBeginEditing=YES;
    self.yanZhengF.textAlignment = NSTextAlignmentLeft;
    self.yanZhengF.borderStyle=UITextBorderStyleBezel;
    self.yanZhengF.placeholder = @"输入验证码";
    self.yanZhengF.keyboardType = UIKeyboardTypeNumberPad;
    self.yanZhengF.font = [UIFont systemFontOfSize:13];
    self.yanZhengF.frame = CGRectMake(20,8+weL.frame.origin.y + titleHeight, ALERTVIEWWIDTH-20*2, 35);
    [self.backGroundView addSubview:self.yanZhengF];
    
    //验证码图片
    CGFloat bodyHeight = 35;
    CGFloat bodyW=100;
    _codeV  = [[YanZhengCodeV alloc] initWithFrame:CGRectMake(20, 10+self.yanZhengF.frame.origin.y + _yanZhengF.bounds.size.height, _yanZhengF.bounds.size.width-bodyW, bodyHeight)];
    _codeV.changeString=detail;//初始验证码
    [self.backGroundView addSubview:_codeV];
    
    //换一张
    self.changeB = [[UIButton alloc]init];
    [self.changeB setTitle:@"换一张" forState:UIControlStateNormal];
     [self.changeB setImage:[UIImage imageNamed:@"tab5"] forState:UIControlStateNormal];
    [self.changeB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.changeB.frame = CGRectMake(_codeV.frame.origin.x+_codeV.bounds.size.width,_codeV.frame.origin.y,  bodyW , bodyHeight);
    [self.backGroundView addSubview:self.changeB];
    
    //错误提示
    UILabel*wrongL=[[UILabel alloc] initWithFrame:CGRectMake(20, self.changeB.frame.origin.y+bodyHeight+10, ALERTVIEWWIDTH-20*2, 20)];
    wrongL.text=@"您输入的验证码错误，请重新输入。";
    wrongL.font=[UIFont systemFontOfSize:15];
    wrongL.textColor=[UIColor orangeColor];
    [self.backGroundView addSubview:wrongL];
    _wrongL=wrongL;
    wrongL.hidden=YES;
    //横线
    self.horLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,self.changeB.frame.origin.y + bodyHeight + 40 , ALERTVIEWWIDTH, 1)];
    self.horLabel.backgroundColor = [UIColor lightGrayColor];
    [self.backGroundView addSubview:self.horLabel];

    //竖线
    self.verLabel = [[UILabel alloc]init];
    CGFloat verLabelH=50;
    self.verLabel.frame = CGRectMake(self.horLabel.bounds.size.width/2,  self.horLabel.frame.origin.y+1,1, verLabelH);
    self.verLabel.backgroundColor = [UIColor lightGrayColor];
    [self.backGroundView addSubview:self.verLabel];
    
   //取消
    self.canleButton = [UIButton  buttonWithType:UIButtonTypeCustom];
    self.canleButton.frame = CGRectMake(0, self.horLabel.frame.origin.y, ALERTVIEWWIDTH/2.0, verLabelH);
    [self.canleButton setTitle:cancelTitel forState:UIControlStateNormal];
    self.canleButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.canleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.canleButton addTarget:self action:@selector(canleButtonEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.backGroundView addSubview: self.canleButton];
    
    
    //确认
    self.otherButton = [UIButton  buttonWithType:UIButtonTypeCustom];
    self.otherButton.frame = CGRectMake(ALERTVIEWWIDTH/2, self.horLabel.frame.origin.y, ALERTVIEWWIDTH/2, verLabelH);
    [self.otherButton setTitle:otherTitle forState:UIControlStateNormal];
    self.otherButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.otherButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.otherButton.tag = 309;
     [self.otherButton addTarget:self action:@selector(clickToUseDelegate:) forControlEvents:UIControlEventTouchUpInside];
    [self.backGroundView addSubview:self.otherButton];
    
    self.backGroundView.bounds = CGRectMake(0, 0, ALERTVIEWWIDTH,self.verLabel.frame.origin.y+verLabelH);

    UITapGestureRecognizer *tapBodyLab = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toDoSomething:)];
    [self.changeB addGestureRecognizer:tapBodyLab];
    
    [self shakeToShow:self.backGroundView];
    
   }

//动态计算高度
-(CGFloat)getHeightWithTitle:(NSString *)title andFont:(NSInteger)fontsize
{
    CGFloat height = [title boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontsize]} context:nil].size.height;
    return height;
}

//显示提示框的动画
- (void) shakeToShow:(UIView*)aView{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.2;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
}
//取消button事件
-(void)canleButtonEvent{
    [self removeFromSuperview];
}

//点击确定按钮调用方法
-(void)clickToUseDelegate:(UIButton *)button
{
    
    
    if ([self.delegate respondsToSelector:@selector(clickButtonWithTag:)])
    {
        
        if (_yanZhengF.text.length==0) {//验证码为空
            
        }else if ([_rightStr isEqualToString:_yanZhengF.text]) {//验证码正确
            [self.delegate clickButtonWithTag:button];
            [self removeFromSuperview];
        }else{//验证码错误
            _wrongL.hidden=NO;
            _yanZhengF.text =nil;
            [self toDoSomething:nil];//刷新验证码
        }
    }
    
}

//换一张
-(void)toDoSomething:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(clickChangButton:)])
    {
        [self.delegate clickChangButton:button];
    }
}
//改变验证码图形
-(void)changCode:(NSString*)str{
    _rightStr =str;
    [_codeV changeCoden:_rightStr];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    // 开始动画(定义了动画的名字)
    [UIView beginAnimations:@"viewUp" context:nil];
    // 设置时长
    [UIView setAnimationDuration:0.2f];
    // 设置动画内容
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - 100, self.frame.size.width, self.frame.size.height);
    // 提交动画
    [UIView commitAnimations];
}
// 结束编辑
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    // 开始动画(定义了动画的名字)
    [UIView beginAnimations:@"viewDown" context:nil];
    // 设置时长
    [UIView setAnimationDuration:0.2f];
    // 设置动画内容
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + 100, self.frame.size.width, self.frame.size.height);
    // 提交动画
    [UIView commitAnimations];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
