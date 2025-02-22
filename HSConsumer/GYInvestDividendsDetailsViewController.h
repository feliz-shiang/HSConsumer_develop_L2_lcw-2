//
//  GYBaseQueryListViewController.h
//  HSConsumer
//
//  Created by apple on 14-10-29.
//  Copyright (c) 2014年 guiyi. All rights reserved.
//

//明细查询类

#import <UIKit/UIKit.h>
#import "GYDetailsNextViewController.h"

@interface GYInvestDividendsDetailsViewController : UIViewController

@property (nonatomic, assign) BOOL isShowBtnDetail; //是否显示查看明细提示行 默认为YES;
@property (nonatomic, assign) EMDetailsCode detailsCode;//账户类型
@property (strong, nonatomic) NSString *strTradeSn;     //交易流水号
@property (strong, nonatomic) NSDictionary *dicConf;    //取得明细的配置文件对应模块
@end
