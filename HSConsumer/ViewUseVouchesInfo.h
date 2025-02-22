//
//  ViewUseVouchesInfo.h
//  HSConsumer
//
//  Created by apple on 14-12-22.
//  Copyright (c) 2014年 guiyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewUseVouchesInfo : UIView

@property (strong, nonatomic) IBOutlet UIView *vLine;

@property (strong, nonatomic) IBOutlet UILabel *lbLabelHSConsumptionVouchers;//消费劵
@property (strong, nonatomic) IBOutlet UILabel *lbLabelHSGoldVouchers;  //代金劵
@property (strong, nonatomic) IBOutlet UILabel *lbLabelTotalVouchers;   //抵金额

@property (strong, nonatomic) IBOutlet UILabel *lbHSConsumptionVouchers;//消费劵
@property (strong, nonatomic) IBOutlet UILabel *lbHSGoldConsumption;//代金劵
@property (strong, nonatomic) IBOutlet UILabel *lbTotalVouchers;   //抵金额

@property (strong, nonatomic) IBOutlet UILabel *lbLabelDi0;  //抵
@property (strong, nonatomic) IBOutlet UILabel *lbLabelDi1;  //抵
@property (strong, nonatomic) IBOutlet UILabel *lbVouchersInfo0;//劵信息
@property (strong, nonatomic) IBOutlet UILabel *lbVouchersInfo1;//劵信息


+ (CGFloat)getHeight;

@end
