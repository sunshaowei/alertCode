//
//  ViewController.m
//  CustomAlertView
//
//  Created by lanshang on 16/6/6.
//  Copyright © 2016年 luckyLin. All rights reserved.
//

#import "ViewController.h"
#import "CustomAlertView.h"
@interface ViewController ()<CustomAlertViewDelegate>
@property CustomAlertView *alertView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *customButton = [UIButton  buttonWithType:UIButtonTypeCustom];
    customButton.backgroundColor = [UIColor clearColor];
    customButton.frame = CGRectMake(50, 100,self.view.frame.size.width - 50*2, 100);
    customButton.layer.borderColor = [UIColor blackColor].CGColor;
    customButton.layer.borderWidth = 1;
    NSString *title = @"好的";
    [customButton setTitle:title forState:UIControlStateNormal];
    [customButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    customButton.titleLabel.numberOfLines = 0;
    [customButton addTarget:self action:@selector(clickToAlertView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:customButton];
}
//添加验证码警示框
-(void)clickToAlertView:(UIButton *)button
{
    
    CustomAlertView *alertView = [[CustomAlertView alloc]initWithFrame:self.view.bounds WithTitle:@"验证码" andDetail:@"9966" andBody:@"换一张" andCancelTitle:@"取消" andOtherTitle:@"确认"];
    
    [alertView.canleButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [alertView.otherButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    alertView.delegate = self;
    [self.view addSubview:alertView];
    _alertView=alertView;
}

// 实现自定义alertView的协议
-(void)clickChangButton:(UIView *)label
{
    int num = (arc4random() % 10000);
   NSString* randomStr = [NSString stringWithFormat:@"%.4d", num];
    
    [_alertView changCode:randomStr];
}

-(void)clickButtonWithTag:(UIButton *)button
{
        [self clickChangButton:nil];
    
}

//点击空白收回键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
