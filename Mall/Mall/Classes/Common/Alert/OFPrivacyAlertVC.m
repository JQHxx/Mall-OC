//
//  PrivacyAlertVC.m
//  BFAlertViewController
//
//  Created by OFweek01 on 2019/12/31.
//  Copyright © 2019 OFweek01. All rights reserved.
//

#import "OFPrivacyAlertVC.h"
#import <Masonry.h>
#import <YYText.h>

@interface OFPrivacyAlertVC ()

@property (nonatomic, strong) UIButton *backgroundButton;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) UILabel *privacyTileLabel;
@property (nonatomic, strong) YYLabel *contentLabel;

@end

@implementation OFPrivacyAlertVC

#pragma mark - Life cycle
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self showAnimation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self setupUI];
    [self setupContent];
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
    
    // 设置contentView上的内容
    [self.contentView addSubview:self.privacyTileLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.sureButton];
    
    [self.privacyTileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.right.mas_equalTo(self.contentView).offset(-15);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.contentView);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.privacyTileLabel);
        make.top.mas_equalTo(self.privacyTileLabel.mas_bottom);
        make.height.mas_greaterThanOrEqualTo(20);
    }];
    
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(self.contentLabel.mas_bottom);
    }];
    
}

- (void) setupContent {
    
    //设置整段字符串的颜色
    UIColor *color = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:15], NSForegroundColorAttributeName: color};
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"1.在浏览使用时，我们会收集、使用设备标识信息用于推荐。\n2.你可以查看完整版《用户协议》和《隐私政策》以便了解我们收集、使用、共享、存储信息的情况，以及对信息的保护策施。\n\n如果你同意请点击下面的按钮以接受我们的服务。" attributes:attributes];
    //设置高亮色和点击事件
    [text yy_setTextHighlightRange:[[text string] rangeOfString:@"《用户协议》"] color:[UIColor colorWithRed:85/255.0 green:143/255.0 blue:227/255.0 alpha:1.0] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        NSLog(@"点击了《用户协议》");
        if (self.agreementActionBlock) {
            self.agreementActionBlock(@"《用户协议》");
        }
    }];
    //设置高亮色和点击事件
    [text yy_setTextHighlightRange:[[text string] rangeOfString:@"《隐私政策》"] color:[UIColor colorWithRed:85/255.0 green:143/255.0 blue:227/255.0 alpha:1.0] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        NSLog(@"点击了《隐私政策》");
        if (self.agreementActionBlock) {
            self.agreementActionBlock(@"《隐私政策》");
        }

    }];
    _contentLabel.attributedText = text;
}

#pragma mark - Public methods
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
- (void) backgroundButtonClick {
    
}

- (void) sureButtonClick {
    if (self.tapActionBlock) {
        self.tapActionBlock();
    }
    [self dismiss];
}

#pragma mark - Setter & Getter
- (UIButton *)backgroundButton {
    if (!_backgroundButton) {
        _backgroundButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backgroundButton.backgroundColor = [UIColor clearColor];
        [_backgroundButton  addTarget:self action:@selector(backgroundButtonClick) forControlEvents:UIControlEventTouchUpInside];
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
        [_sureButton setTitle:@"知道了" forState:UIControlStateNormal];
        [_sureButton setTitleColor:[UIColor colorWithRed:85/255.0 green:143/255.0 blue:227/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}

- (UILabel *)privacyTileLabel {
    if (!_privacyTileLabel) {
        _privacyTileLabel = [[UILabel alloc]init];
        _privacyTileLabel.font = [UIFont systemFontOfSize:15];
        _privacyTileLabel.text = @"个人信息保护指引";
        _privacyTileLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    }
    return _privacyTileLabel;
}

- (YYLabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[YYLabel alloc]init];
        _contentLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        _contentLabel.numberOfLines = 0;
        // 要设置，不然高度不正确
        _contentLabel.preferredMaxLayoutWidth = UIScreen.mainScreen.bounds.size.width - 2 * 50 - 2 * 15;
        _privacyTileLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    }
    return _contentLabel;
}

@end
