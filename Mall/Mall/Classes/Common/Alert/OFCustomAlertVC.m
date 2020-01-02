//
//  OFCustomAlertVC.m
//  BFAlertViewController
//
//  Created by OFweek01 on 2019/12/31.
//  Copyright © 2019 OFweek01. All rights reserved.
//

#import "OFCustomAlertVC.h"
#import <Masonry.h>

@interface OFCustomAlertVC ()

// 全屏的按钮
@property (nonatomic, strong) UIButton *backgroundButton;
// 主要内容
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) UIButton *cancelButton;
// 水平线
@property (nonatomic, strong) UIView *horizontalLineView;
// 竖直线
@property (nonatomic, strong) UIView *verticalLineView;
@property (nonatomic, strong) OFAlertConfig *config;

@end

@implementation OFCustomAlertVC

+ (instancetype) alertWithConfig: (OFAlertConfig *) config {
    OFCustomAlertVC *VC = [[OFCustomAlertVC alloc]init];
    VC.config = config;
    return VC;
}

#pragma mark - Life cycle
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
}

#pragma mark - Private methods
- (void) setupUI {
    [self.view addSubview:self.backgroundButton];
    [self.view addSubview:self.contentView];
    [self.backgroundButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
        
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(50);
        make.right.mas_equalTo(self.view).offset(-50);
        make.centerY.mas_equalTo(self.view);
    }];
    
    // 标题
    self.titleLabel.text = self.config.title;
    self.titleLabel.textColor = self.config.titleColor ? self.config.titleColor : self.titleLabel.textColor;
    self.titleLabel.font = self.config.titleFont ? self.config.titleFont : self.titleLabel.font;
    self.titleLabel.textAlignment = self.config.titleAlignment ? self.config.titleAlignment : self.titleLabel.textAlignment;
    
    // 详细信息
    self.messageLabel.text = self.config.message;
    self.messageLabel.textColor = self.config.messageColor ? self.config.messageColor : self.messageLabel.textColor;
    self.messageLabel.font = self.config.messageFont ? self.config.messageFont : self.messageLabel.font;
    self.messageLabel.textAlignment = self.config.messageAlignment ? self.config.messageAlignment : self.messageLabel.textAlignment;
    
    // 分割线颜色
    self.horizontalLineView.backgroundColor = self.config.lineColor ? self.config.lineColor : self.horizontalLineView.backgroundColor;
    self.verticalLineView.backgroundColor = self.config.lineColor ? self.config.lineColor : self.verticalLineView.backgroundColor;
    
    // 确定按钮
    if (self.config.sureButtonTitleColor) {
        [self.sureButton setTitleColor:self.config.sureButtonTitleColor forState:UIControlStateNormal];
    }
    if (self.config.sureButtonTitleFont) {
        self.sureButton.titleLabel.font = self.config.sureButtonTitleFont;
    }
    
    if (self.config.sureButtonTitle) {
        [self.sureButton setTitle:self.config.sureButtonTitle forState:UIControlStateNormal];
    }
    
    // 取消按钮
    if (self.config.cancleButtonTitleColor) {
        [self.cancelButton setTitleColor:self.config.cancleButtonTitleColor forState:UIControlStateNormal];
    }
    if (self.config.cancleButtonTitleFont) {
        self.cancelButton.titleLabel.font = self.config.cancleButtonTitleFont;
    }
    
    if (self.config.cancleButtonTitle) {
        [self.cancelButton setTitle:self.config.cancleButtonTitle forState:UIControlStateNormal];
    }
    
    // 设置contentView上的内容
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.messageLabel];
    [self.contentView addSubview:self.horizontalLineView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.right.mas_equalTo(self.contentView).offset(-10);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.contentView).offset(10);
    }];
    
    if ([self.config.title length] == 0) {
        [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.titleLabel);
            make.top.mas_equalTo(self.contentView).offset(15);
            make.height.mas_greaterThanOrEqualTo(50);
        }];
    } else {
        [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.titleLabel);
            make.top.mas_equalTo(self.titleLabel.mas_bottom);
            make.height.mas_greaterThanOrEqualTo(40);
        }];
    }

    [self.horizontalLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.messageLabel.mas_bottom).offset(15);
        make.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
    
    // 单个按钮
    if (self.config.isSingleButton) {
        [self.contentView addSubview:self.sureButton];
        [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.horizontalLineView.mas_bottom);
            make.left.right.bottom.mas_equalTo(self.contentView);
            make.height.mas_equalTo(50);
        }];
    } else {
        
        [self.contentView addSubview:self.sureButton];
        [self.contentView addSubview:self.cancelButton];
        [self.contentView addSubview:self.verticalLineView];
                
        [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.horizontalLineView.mas_bottom);
            make.left.bottom.mas_equalTo(self.contentView);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(self.contentView).multipliedBy(0.5).offset(0.5);
        }];
        
        [self.verticalLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.horizontalLineView.mas_bottom);
            make.bottom.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.sureButton.mas_right);
            make.width.mas_equalTo(0.5);
        }];
        
        [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.horizontalLineView.mas_bottom);
            make.right.bottom.mas_equalTo(self.contentView);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(self.sureButton);
        }];
    }
}

- (void) showAnimation {
    // 第一步：将view宽高缩至无限小（点）
    _contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity,CGFLOAT_MIN, CGFLOAT_MIN);
    [UIView animateWithDuration:0.3
    animations:^{
        // 第二步： 以动画的形式将view慢慢放大至原始大小的1.2倍
        self->_contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
        self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    }
    completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            // 第三步： 以动画的形式将view恢复至原始大小
            self->_contentView.transform = CGAffineTransformIdentity;
            self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        }];
    }];
}

- (void) dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        // 第一步： 以动画的形式将view慢慢放大至原始大小的1.2倍
        self->_contentView.transform =
              CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
        self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }
    completion:^(BOOL finished) {
      [UIView animateWithDuration:0.3 animations:^{
                // 第二步： 以动画的形式将view缩小至原来的1/1000分之1倍
              self->_contentView.transform = CGAffineTransformScale(
                    CGAffineTransformIdentity, 0.001, 0.001);
          }
          completion:^(BOOL finished) {
              self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
                // 第三步： 移除
              [self->_contentView removeFromSuperview];
              [self dismissViewControllerAnimated:NO completion:nil];
      }];
    }];
   
}

#pragma mark - Event response
- (void) sureButtonClick {
    if (self.config.sureBlock) {
        self.config.sureBlock();
    }
    [self dismiss];
}

- (void) cancelButtonClick {
    if (self.config.cancelBlock) {
        self.config.cancelBlock();
    }
    [self dismiss];
}

- (void) backgroundButtonClick {
    
}

#pragma mark - Setter & Getter
- (UIButton *)backgroundButton {
    if (!_backgroundButton) {
        _backgroundButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backgroundButton.backgroundColor = [UIColor clearColor];
        [_backgroundButton addTarget:self action:@selector(backgroundButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backgroundButton;
}
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 15;
        _contentView.clipsToBounds = YES;
    }
    return _contentView;
}

- (UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [_sureButton setTitleColor:[UIColor colorWithRed:85/255.0 green:143/255.0 blue:227/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor colorWithRed:85/255.0 green:143/255.0 blue:227/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    }
    return _titleLabel;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        _messageLabel.numberOfLines = 0;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    }
    return _messageLabel;
}

- (UIView *)horizontalLineView {
    if (!_horizontalLineView) {
        _horizontalLineView = [[UIView alloc]init];
        _horizontalLineView.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
    }
    return _horizontalLineView;
}

- (UIView *) verticalLineView {
    if (!_verticalLineView) {
        _verticalLineView = [[UIView alloc]init];
        _verticalLineView.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
    }
    return _verticalLineView;
}

- (void)setConfig:(OFAlertConfig *)config {
    _config = config;
    [self setupUI];
    [self showAnimation];
}

@end
