//
//  GYMyAccountsTableViewController.m
//  HSConsumer
//
//  Created by apple on 14-10-15.
//  Copyright (c) 2014年 guiyi. All rights reserved.
//

#import "GYMyAccountsTableViewController.h"
#import "GYMyHSTabBarViewController.h"
#import "CellMyAccountCell.h"
#import "CellUserInfo.h"
#import "GlobalData.h"

@interface GYMyAccountsTableViewController ()
{
    NSArray *titlesForAccSection;     //账户名称集合
    NSArray *titlesForHSDAccSection;  //互生币账户名称集合
    NSArray *imgForAccSection;        //账户名称图标集
    NSArray *imgForHSDAccSection;     //互生币账户名称图标集
    CellUserInfo *cellUserInfo;
    GlobalData *data;
}
@end

@implementation GYMyAccountsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = kLocalized(@"my_account");
    data = [GlobalData shareInstance];
    
    [self.tableView registerNib:[UINib nibWithNibName:data.currentDeviceScreenInch == kDeviceScreenInch_3_5 ?  @"CellMyAccountCell_35" : @"CellMyAccountCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kCellMyAccountCellIdentifier];
    cellUserInfo = [[[NSBundle mainBundle] loadNibNamed:data.currentDeviceScreenInch == kDeviceScreenInch_3_5 ? @"CellUserInfo_35" : @"CellUserInfo" owner:self options:nil] lastObject];
    [cellUserInfo.btnRealName addTarget:self action:@selector(pushRealNameVC:) forControlEvents:UIControlEventTouchUpInside];
    [cellUserInfo.btnPhoneYes addTarget:self action:@selector(pushPhoneBinding:) forControlEvents:UIControlEventTouchUpInside];
    [cellUserInfo.btnEmailYes addTarget:self action:@selector(pushEmailBinding:) forControlEvents:UIControlEventTouchUpInside];
    
    titlesForAccSection = [NSArray arrayWithObjects:kLocalized(@"points_account"),
                           kLocalized(@"cash_account"),
                           kLocalized(@"investment_account"), nil];
    imgForAccSection = [NSArray arrayWithObjects:@"cell_img_points_account",
                           @"cell_img_cash_account",
                           @"cell_img_investment_account", nil];
    
    titlesForHSDAccSection = [NSArray arrayWithObjects:kLocalized(@"HS_coins_to_cash_account"),
                           kLocalized(@"HS_coins_consumer_account_balance"), nil];
    imgForHSDAccSection = [NSArray arrayWithObjects:@"cell_img_HSC_to_cash_acc",
                        @"cell_img_HSC_to_consume", nil];
    //兼容IOS6设置背景色
    UIView* bview = [[UIView alloc] init];
    bview.backgroundColor = kDefaultVCBackgroundColor;
    [self.tableView setBackgroundView:bview];
}

//重新设置self.view的坐标
- (void)resetSelfViewFrame
{
    TabBarView *tabBarView = [(GYMyHSTabBarViewController *)self.tabBarController tabBarView];
    CGRect selfFrame =  self.view.frame;
    if (kSystemVersionLessThan(@"7.0"))
    {
        selfFrame.origin.y += CGRectGetHeight(tabBarView.frame);
    }else
    {
        selfFrame.origin.y = CGRectGetMaxY(tabBarView.frame);
    }
    selfFrame.size.height = selfFrame.size.height - CGRectGetHeight(tabBarView.frame);
    [self.view setFrame:selfFrame];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self resetSelfViewFrame];
//    [(GYMyHSTabBarViewController *)self.tabBarController getTransitionViewRect];

//    [(GYMyHSTabBarViewController *)self.tabBarController setTabBarHidden:YES];
//    NSLog(@"%@",self.tabBarController.tabBar);//[[[self.view.subviews reverseObjectEnumerator] allObjects] lastObject]
//    NSLog(@"aaa:%@",self.tabBarController.view.subviews);
//    self.tabBarController tra
//    NSLog(@"%@", [[[self.tabBarController.view.subviews reverseObjectEnumerator] allObjects] lastObject]);
//    NSLog(@"%@",self.tabBarController.tabBar);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;
    switch (section)
    {
        case 0:
            rows = 1;
            break;
        case 1:
            rows = 3;
            break;
        case 2:
            rows = 2;
            break;
        default:
            break;
    }
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellMyAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellMyAccountCellIdentifier];
    NSString *labelStr = nil;
    UIImage *img = nil;
    switch (indexPath.section)
    {
        case 0:
            cellUserInfo.lbLabelCardNo.text = [NSString stringWithFormat:@"%@  %@",
                                               kLocalized(@"points_card_number"), [Utils formatCardNo:@"05001010001"]];
            
            cellUserInfo.lbLabelHello.text = kLocalized(@"先生，下午好");//国际化时注意称呼前后
            cellUserInfo.lbLastLoginInfo.text = kLocalized(@"上次登录时间: 2014-05-25 18:30");
            //加载头像
            if (data.user.useHeadPictureURL)
            {
                cellUserInfo.ivUser.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://picURL"]]];//之后可使用缓存方式处理访问
            }else
            {
                cellUserInfo.ivUser.image = kLoadPng(@"cell_img_noneuserimg");
//                cellUserInfo.ivUser.image = nil;
            }
            
            [cellUserInfo.btnRealName setBackgroundImage:kLoadPng(data.user.isRealName ? @"icon_real_name_yes" : @"icon_real_name_no")
                                                forState:UIControlStateNormal];
            [cellUserInfo.btnPhoneYes setBackgroundImage:kLoadPng(data.user.isPhoneBinding ? @"icon_phone_yes" : @"icon_phone_no")
                                                forState:UIControlStateNormal];
            [cellUserInfo.btnEmailYes setBackgroundImage:kLoadPng(data.user.isEmailBinding ? @"icon_email_ye" : @"icon_email_no")
                                                forState:UIControlStateNormal];
            
            [cellUserInfo setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cellUserInfo;
            break;
        case 1:
            labelStr = [titlesForAccSection objectAtIndex:indexPath.row];
            img = kLoadPng([imgForAccSection objectAtIndex:indexPath.row]);
            break;
        case 2:
            labelStr = [titlesForHSDAccSection objectAtIndex:indexPath.row];
            img = kLoadPng([imgForHSDAccSection objectAtIndex:indexPath.row]);
            break;
        default:
            break;
    }
    
    cell.lbAccounName.text = labelStr;
    cell.lbAccountValue.text = [Utils formatCurrencyStyle:123456789.123];
    cell.ivTitle.image = img;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (data.currentDeviceScreenInch)
    {
        case kDeviceScreenInch_3_5:
            if (indexPath.section == 0)
            {
                return 88;//110  86
            }else
            {
                return kDefaultCellHeight3_5inch;//kDefaultCellHeight//kDefaultCellHeight3_5inch
            }
            break;
        case kDeviceScreenInch_4_0:
        default:
            if (indexPath.section == 0)
            {
                return 110;
            }else
            {
                return kDefaultCellHeight;
            }
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;//第一栏位设
//        return 35;//第一栏位设
    }else
    {
        return 6;//加上页脚＝16
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

#pragma - 用户信息绑定按钮
- (void)pushRealNameVC:(id)sender
{
    DDLogInfo(@"弹出实名认证vc.");
}

- (void)pushPhoneBinding:(id)sender
{
    DDLogInfo(@"弹出手机绑定vc.");

}

- (void)pushEmailBinding:(id)sender
{
    DDLogInfo(@"弹出油箱绑定vc.");
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

@end
