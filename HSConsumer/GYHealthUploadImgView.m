//
//  GYHealthUploadImgView.m
//  HSConsumer
//
//  Created by Apple03 on 15/7/24.
//  Copyright (c) 2015年 guiyi. All rights reserved.
//

#import "GYHealthUploadImgView.h"
#import "GYHealthUploadImgModel.h"
#import "UIImageView+WebCache.h"
@interface GYHealthUploadImgView()

@property (nonatomic,weak)UIButton * btnImg;
@property (nonatomic,weak)UILabel * lbNeed;
@property (nonatomic,weak)UILabel * lbTitle;
@property (nonatomic,weak)UIButton * btnShowTest;
@end
@implementation GYHealthUploadImgView

-(instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}
-(void)settings
{
    UIButton * btnImg = [[UIButton alloc] init];
    [btnImg addTarget:self action:@selector(chooseImg:) forControlEvents:UIControlEventTouchUpInside];
    self.btnImg = btnImg;
    [btnImg setBackgroundImage:[UIImage imageNamed:@"img_btn_bg.png"] forState:UIControlStateNormal];
    [self addSubview:self.btnImg];
    
    UILabel * lbNeed = [[UILabel alloc] init] ;
    lbNeed.textColor = [UIColor redColor];
    lbNeed.text = @"*";
    lbNeed.font = KtitleFont;
    lbNeed.textAlignment = NSTextAlignmentCenter;
    self.lbNeed = lbNeed;
    [self addSubview:self.lbNeed];
    
    UILabel * lbTitle= [[UILabel alloc] init] ;
    lbTitle.font = KtitleFont;
    lbTitle.textAlignment = NSTextAlignmentCenter;
    lbTitle.numberOfLines = 0;
    self.lbTitle = lbTitle;
    [self addSubview:lbTitle];
    
    UIButton * btnShowTest = [[UIButton alloc] init];
    [btnShowTest setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btnShowTest setTitle:@"示例图片" forState:UIControlStateNormal];
    btnShowTest.titleLabel.font = KshowFont;
    btnShowTest.layer.borderWidth = 1;
    btnShowTest.layer.borderColor = [UIColor redColor].CGColor;
    [btnShowTest addTarget:self action:@selector(showTest:) forControlEvents:UIControlEventTouchUpInside];
    self.btnShowTest = btnShowTest;
    [self addSubview:self.btnShowTest];
}
-(void)chooseImg:(UIButton *)sender
{
    NSLog(@"chooseImg");
    if ([self.delegate respondsToSelector:@selector(HealthUploadImgViewChooseImgWithButton:)]) {
        [self.delegate HealthUploadImgViewChooseImgWithButton:sender];
    }
}
-(void)showTest:(UIButton *)sender
{
    NSLog(@"showTest");
    if ([self.delegate respondsToSelector:@selector(HealthUploadImgViewShowExampleWithButton:)]) {
        [self.delegate HealthUploadImgViewShowExampleWithButton:sender];
    }
}
-(void)setModel:(GYHealthUploadImgModel *)model
{
    _model = model;
    [self settings];
}
-(void)setShowTag:(NSInteger)showTag chooseImageTag:(NSInteger)chooseImageTag
{
    self.btnImg.tag = chooseImageTag;
    self.btnShowTest.tag = showTag;
}
-(void)setImageWithImage:(UIImage *)image
{
    if (image)
    {
        [self.btnImg setBackgroundImage:image forState:UIControlStateNormal];
    }
}
-(NSInteger)getImgChooseTag
{
    return self.btnImg.tag;
}
-(void)layoutSubviews
{
    
    self.btnImg.frame = self.model.picFrame;
    if (self.model.isNeed) {
        self.lbNeed.frame = self.model.needFrame;
    }
    else
    {
        self.lbNeed.hidden = YES;
    }
    self.lbTitle.frame = self.model.titleFrame;
    self.lbTitle.text = self.model.strTitle;
    self.btnShowTest.frame = self.model.showTempFrame;
}
@end
