//
//  DropDownListView.m
//  DropDownDemo
//
//  Created by 童明城 on 14-5-28.
//  Copyright (c) 2014年 童明城. All rights reserved.
//

#define DEGREES_TO_RADIANS(angle) ((angle)/180.0 *M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians)*(180.0/M_PI))

#import "DropDownWithChildListView.h"
#import "UIView+CustomBorder.h"

@implementation DropDownWithChildListView
{
    NSMutableArray *marrDatasource ;
    int tempIndex;
    UILabel * lbTemp;
    UIImageView * imgViewTemp;
    UIButton * btnTemp;
    UIView * footerView;
    UITableView * tvTemp;
    int mutilpleChoiceCount;
    NSInteger sectionNum ;
    CGRect superFrame;
    UILabel * lbSectionTitle;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame dataSource:(id)datasource delegate:(id) delegate WithUseType :( kUseType )type WithOther :(id)other
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        currentExtendSection = -1;
        self.dropDownDataSource = datasource;
        self.dropDownDelegate = delegate;
        self.ItemuseType=type;
        superFrame=frame;
        sectionNum=0;
        //回调
        if ([self.dropDownDataSource respondsToSelector:@selector(numberOfSections)] ) {
            
            sectionNum = [self.dropDownDataSource numberOfSections];
            
        }
        //回调
        if ([self.dropDownDataSource respondsToSelector:@selector(multipleChoiceCount)]) {
            mutilpleChoiceCount=[self.dropDownDataSource multipleChoiceCount];
            
        }
        
        if (sectionNum == 0) {
            self = nil;
        }
        //添加btn
        for (int i = 0; i <sectionNum; i++) {
            CGFloat sectionWidth = (1.0*(frame.size.width)/sectionNum);
            sectionBtn = [[UIButton alloc] initWithFrame:CGRectMake(sectionWidth*i, 1, sectionWidth, frame.size.height-2)];
            sectionBtn.tag = SECTION_BTN_TAG_BEGIN + i;
            sectionBtn.backgroundColor=[UIColor whiteColor];
            sectionBtn.titleLabel.font=[UIFont systemFontOfSize:14.0f];
            [sectionBtn addTarget:self action:@selector(sectionBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
            NSString *sectionBtnTitle = @"--";
            //用label 显示section titile btn的titile当字多的时候，显示效果不符合要求
            CGRect LabelFrame = sectionBtn.frame;
            LabelFrame.origin.x = sectionBtn.frame.origin.x+5;
            LabelFrame.size.width = sectionBtn.frame.size.width-16-5;
            
            lbSectionTitle =[[UILabel alloc]initWithFrame:LabelFrame];
            lbSectionTitle.tag=SECTION_LB_TAG_BEGIN+i;
            lbSectionTitle.textAlignment=UITextAlignmentCenter;
            lbSectionTitle.font=[UIFont systemFontOfSize:15.0f];
            //回调
            if ([self.dropDownDataSource respondsToSelector:@selector(titleInSection:index:)]) {
                
                sectionBtnTitle = [self.dropDownDataSource titleInSection:i index:[self.dropDownDataSource defaultShowSection:i]];
                
            }
            
           
            //设置 item的title
            if (self.ItemuseType==surroundShopType&&i==0) {

                   lbSectionTitle.text=@"全城";
    
            }else if (self.ItemuseType==surroundShopType&&i==1)
            {
                
                NSString * surroundFindTitle=[[NSUserDefaults standardUserDefaults]objectForKey:@"surroundingTitle"];
              
                
                if (other) {
                    self.fromSurroundShopBottom=[other boolValue];
                    if ( [other boolValue]) {
                        lbSectionTitle.text=@"全部";
                    }else
                    {
                        lbSectionTitle.text=surroundFindTitle;
                    }
                    
                }else
                {
                
                  lbSectionTitle.text=surroundFindTitle;
                }
               
                
            }
        
            else if (self.ItemuseType==surroundShopType&&i==2)
            {
            
                NSString * surroundFindTitle=[[NSUserDefaults standardUserDefaults]objectForKey:@"surroundingTitle"];
                lbSectionTitle.text=surroundFindTitle;
                
                
             //other用来标示来自周边逛中 首页过来的分类是上面还是下面。
                if (other) {
                    if ( [other boolValue]) {
                        
                        lbSectionTitle.text=sectionBtnTitle;
                        
                        
                    }else
                    {
                        lbSectionTitle.text=sectionBtnTitle;
                    }

                }
                
              
            
            }
            
            
            else if (self.ItemuseType==surroundGoodsType&&i==1)
            {
                
                NSString * surroundGoodsTitle=[[NSUserDefaults standardUserDefaults]objectForKey:@"surroundingGoodsTitle"];
                lbSectionTitle.text=surroundGoodsTitle;
                
                
               
            
            }
            else if (self.ItemuseType==surroundGoodsType&&i==0)
            {
                
                lbSectionTitle.text=@"全城";
         
                
            }
            else if (self.ItemuseType==easyBuyListType&&i==0)
            {
                
                NSString * surroundGoodsTitle=[[NSUserDefaults standardUserDefaults]objectForKey:@"easyBuyTitle"];
                lbSectionTitle.text=surroundGoodsTitle;
            
                
            }

            
            else
            {
                // modify by songjk 显示默认
                lbSectionTitle.text=sectionBtnTitle;
//                if (self.ItemuseType==easyBuySearchType) {
//                    if (i==0) {
//                        
//                    lbSectionTitle.text=@"默认";
//                        
//                    }else if (i==1)
//                    {
//                    
//                    lbSectionTitle.text=@"全部";
//                    
//                    }
//                    
//                }
//                else{
//                    
//                    lbSectionTitle.text=sectionBtnTitle;
//                
//                }
                
            }
            
            [sectionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            lbSectionTitle.textColor=[UIColor blackColor];
            
            [self addSubview:sectionBtn];
            [self addSubview:lbSectionTitle];
            [self addBottomBorder];
            [self setBottomBorderInset:YES];//让边线在view的内部
            
            //添加旋转的图片
            UIImageView *sectionBtnIv = [[UIImageView alloc] initWithFrame:CGRectMake(sectionWidth*i +(sectionWidth - 16), (self.frame.size.height-9)/2, 16, 8)];
            [sectionBtnIv setImage:[UIImage imageNamed:@"ep_ico_drop_down_menu.png"]];
            [sectionBtnIv setContentMode:UIViewContentModeScaleToFill];
            sectionBtnIv.tag = SECTION_IV_TAG_BEGIN + i;
            if (self.ItemuseType==easyBuySearchType&&i==2) {
                sectionBtnIv.hidden=YES;
            }
            [self addSubview: sectionBtnIv];
            
        }
        
        //部分页面需要foot 和确认 btn 提前初始化，用于外部添加监听事件。
        _footerViewInSectionTwo =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
        
        _BtnConfirm =[UIButton buttonWithType: UIButtonTypeCustom];
        
        
    }
    return self;
}


//用于回调  需要重新设置数据源时需要调用
-(void)reloadDatasoureArray:(NSMutableArray *)array
{
    
    sectionNum=0;
    if ([self.dropDownDataSource respondsToSelector:@selector(numberOfSections)] ) {
        
        sectionNum = [self.dropDownDataSource numberOfSections];
        
    }
    
    if ([self.dropDownDataSource respondsToSelector:@selector(multipleChoiceCount)]) {
        mutilpleChoiceCount=[self.dropDownDataSource multipleChoiceCount];
        
    }
    
    for (int i = 0; i <sectionNum; i++) {
        sectionBtn.tag = SECTION_BTN_TAG_BEGIN + i;
        sectionBtn.backgroundColor=[UIColor whiteColor];
        sectionBtn.titleLabel.font=[UIFont systemFontOfSize:14.0f];
        [sectionBtn addTarget:self action:@selector(sectionBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
        NSString *sectionBtnTitle = @"--";
        
        //用label 显示section titile
        CGRect LabelFrame = sectionBtn.frame;
        LabelFrame.origin.x=sectionBtn.frame.origin.x+5;
        LabelFrame.size.width=sectionBtn.frame.size.width-16-5;
        lbSectionTitle.tag=SECTION_LB_TAG_BEGIN+i;
        lbSectionTitle.textAlignment=UITextAlignmentCenter;
        lbSectionTitle.font=[UIFont systemFontOfSize:15.0f];
        if ([self.dropDownDataSource respondsToSelector:@selector(titleInSection:index:)]) {
            
            sectionBtnTitle = [self.dropDownDataSource titleInSection:i index:[self.dropDownDataSource defaultShowSection:i]];
            
        }
        
        NSString * surroundFindTitle=[[NSUserDefaults standardUserDefaults]objectForKey:@"surroundingTitle"];
        
        if (self.ItemuseType==surroundShopType&&i==1) {
            lbSectionTitle.text=surroundFindTitle;
        }else if (self.ItemuseType==surroundShopType&&i==2&&self.fromSurroundShopBottom)
        {
        lbSectionTitle.text=sectionBtnTitle;
        }
        else
        {
            lbSectionTitle.text=sectionBtnTitle;
        }
        [sectionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        lbSectionTitle.textColor=[UIColor blackColor];
        
        
        [self addSubview:sectionBtn];
        [self addSubview:lbSectionTitle];
        
    }
    
}


-(void)sectionBtnTouch:(UIButton *)btn
{
    //删除vc中的temptv
    if (_deleteTableview &&[_deleteTableview respondsToSelector:@selector(deleteTableviewInSectionOne)]) {
        [_deleteTableview deleteTableviewInSectionOne];
    }
    
    marrDatasource=[NSMutableArray array];
    
    NSInteger section = btn.tag - SECTION_BTN_TAG_BEGIN;
    
    //在有多选项时，用这个方法回调，清除多选的数组
    if (_dropDownDelegate && [ _dropDownDelegate respondsToSelector:@selector(btnTouch:)]) {
        [_dropDownDelegate btnTouch:section];
    }
    
    
    if (self.ItemuseType==easyBuySearchType&&section==2) {
        
        return;
        
    }
    
    //旋转imageview
    UIImageView *currentIV= (UIImageView *)[self viewWithTag:(SECTION_IV_TAG_BEGIN +currentExtendSection)];
    
    [UIView animateWithDuration:0.1 animations:^{
        currentIV.transform = CGAffineTransformRotate(currentIV.transform, DEGREES_TO_RADIANS(180));
    }];
    
    
    if (currentExtendSection == section) {
        if (marrDatasource.count>0) {
            [marrDatasource removeAllObjects];
        }
        [self hideExtendedChooseView];
        
    }else{
        currentExtendSection = section;
        currentIV = (UIImageView *)[self viewWithTag:SECTION_IV_TAG_BEGIN + currentExtendSection];
        [UIView animateWithDuration:0.1 animations:^{
            currentIV.transform = CGAffineTransformRotate(currentIV.transform, DEGREES_TO_RADIANS(180));
        }];
        
        //轻松购 搜索商品时 用于在section1 时 实现多选
        if (self.ItemuseType==easyBuySearchType) {
            
            mutilpleChoiceCount=[self.dropDownDataSource numberOfRowsInSection:currentExtendSection]  ;
        }
        
        for (int i=0; i<mutilpleChoiceCount; i++) {
            
            [marrDatasource addObject:@NO];
            
        } //轻松购 搜索商品时 用于在section1 时 实现多选
        
        
        [self showChooseListViewInSection:currentExtendSection choosedIndex:[self.dropDownDataSource defaultShowSection:currentExtendSection]];
    }
    
    
    if (currentExtendSection==(sectionNum-1)) {
        
        
        if (self.ItemuseType==surroundShopType)
        {
            
        } else{
            
            
            CGPoint p = CGPointMake(320/2, 25);
            _BtnConfirm.center=p;
            _BtnConfirm.bounds=CGRectMake(0, 0, 280, 36);
            [_BtnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_BtnConfirm setBackgroundImage:[UIImage imageNamed:@"3.png"] forState:UIControlStateNormal];
            
            _BtnConfirm.tag=currentExtendSection;
            [_BtnConfirm setTitle:@"确定" forState:UIControlStateNormal];
            [_footerViewInSectionTwo addSubview:_BtnConfirm];
            _BtnConfirm.layer.masksToBounds=YES;
            _BtnConfirm.layer.cornerRadius=3;
            _BtnConfirm.layer.borderWidth=1.0f;
            _BtnConfirm.layer.borderColor=kNavigationBarColor.CGColor;
            [_footerViewInSectionTwo addTopBorder];
            
            self.mTableView.tableFooterView=_footerViewInSectionTwo;
        }
    }else{
        
        if (self.ItemuseType==easyBuySearchType&&currentExtendSection==1) {
            //            _footerViewInSectionTwo =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
            //            _BtnConfirm =[UIButton buttonWithType: UIButtonTypeCustom];
            CGPoint p = CGPointMake(320/2, 25);
            _BtnConfirm.center=p;
            _BtnConfirm.bounds=CGRectMake(0, 0, 280, 36);
            [_BtnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_BtnConfirm setBackgroundImage:[UIImage imageNamed:@"3.png"] forState:UIControlStateNormal];
            _BtnConfirm.tag=currentExtendSection;
            [_BtnConfirm setTitle:@"确定" forState:UIControlStateNormal];
            [_footerViewInSectionTwo addSubview:_BtnConfirm];
            _BtnConfirm.layer.masksToBounds=YES;
            _BtnConfirm.layer.cornerRadius=3;
            _BtnConfirm.layer.borderWidth=1.0f;
            _BtnConfirm.layer.borderColor=kNavigationBarColor.CGColor;
            
            
            self.mTableView.tableFooterView=_footerViewInSectionTwo;
        }else{
            
            self.mTableView.tableFooterView=footerView;
        }
        
        
        
    }
    
    
}


- (void)setTitle:(NSString *)title inSection:(NSInteger) section
{
    UIButton *btn = (id)[self viewWithTag:SECTION_BTN_TAG_BEGIN +section];
    [btn setTitle:title forState:UIControlStateNormal];
}


- (BOOL)isShow
{
    if (currentExtendSection == -1) {
        return NO;
    }
    return YES;
}


//一定要 在label 复制后调用此方法，这里把currentSection调整了
-  (void)hideExtendedChooseView
{
    //通过代理方法remove  在section 1 中弹出的子类tableview
    if (_deleteTableview &&[_deleteTableview respondsToSelector:@selector(deleteTableviewInSectionOne)]) {
        [_deleteTableview deleteTableviewInSectionOne];
        
        
    }
    //删除 弹出的一级tableview
    if (currentExtendSection != -1) {
        
        //等于-1目的是  为了 区分不通的section
        currentExtendSection = -1;
        CGRect rect = self.mTableView.frame;
        rect.size.height = 0;
        [UIView animateWithDuration:0.3 animations:^{
            self.mTableBaseView.alpha = 1.0f;
            self.mTableView.alpha = 1.0f;
            
            self.mTableBaseView.alpha = 0.2f;
            self.mTableView.alpha = 0.2;
            
            self.mTableView.frame = rect;
        }completion:^(BOOL finished) {
            [self.mTableView removeFromSuperview];
            [self.mTableBaseView removeFromSuperview];
        }];
    }
    
}

-(void)showChooseListViewInSection:(NSInteger)section choosedIndex:(NSInteger)index
{
    if (!self.mTableView) {
        self.mTableBaseView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height , self.frame.size.width, self.mSuperView.frame.size.height - self.frame.origin.y - self.frame.size.height)];
        
        
        self.mTableBaseView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5];
        
        UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTappedAction)];
        [self.mTableBaseView addGestureRecognizer:bgTap];
        
        
        int height;
        
        height=(kScreenHeight-64-40)*0.8;
        //        if ([GlobalData shareInstance].currentDeviceScreenInch==kDeviceScreenInch_3_5) {
        //
        //            height=(kScreenHeight-64-40)*0.6;
        //
        //        }else if ([GlobalData shareInstance].currentDeviceScreenInch==kDeviceScreenInch_4_0)
        //        {
        //
        //            height=(kScreenHeight-64-40)*0.6;
        //
        //        }else
        //        {
        //
        //            height=(kScreenHeight-64-40)*0.6;
        //
        //        }
        
        
        self.mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.frame.origin.y + self.frame.size.height, self.frame.size.width, height) style:UITableViewStylePlain];
        self.mTableView.delegate = self;
        self.mTableView.dataSource = self;
        
        
        //单选 多选，不同的实现方式  都通过自定义cell来实现
        [self.mTableView registerNib:[UINib nibWithNibName:@"GYEasyBuyFirstTableViewCell" bundle:nil] forCellReuseIdentifier:@"firstCell"];
        
        [self.mTableView registerNib:[UINib nibWithNibName:@"GYEasyBuySecondeTableViewCell" bundle:nil] forCellReuseIdentifier:@"secondCell"];
        
        [self.mTableView registerNib:[UINib nibWithNibName:@"GYEasyBuySecondeTableViewCell" bundle:nil] forCellReuseIdentifier:@"fourthCell"];
        
        [self.mTableView registerNib:[UINib nibWithNibName:@"GYEasyBuyThirdTableViewCell" bundle:nil] forCellReuseIdentifier:@"thirdCell"];
        
        [self.mTableView registerNib:[UINib nibWithNibName:@"GYEasyBuySecondeTableViewCell" bundle:nil] forCellReuseIdentifier:@"surroundShopCell"];
        
        footerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 1)];
        footerView.backgroundColor=kDefaultVCBackgroundColor;
        self.mTableView.tableFooterView=footerView;
        
    }
    
    //修改tableview的frame
    int sectionWidth = (self.frame.size.width)/[self.dropDownDataSource numberOfSections];
    CGRect rect = self.mTableView.frame;
    
    rect.origin.x = 0;
    if (self.ItemuseType==surroundShopType) {//第一个分组的时候，tableview 的宽度为sectionWidth
        
        
        switch (section) {
            case 0:
                rect.size.width = sectionWidth;
                break;
            case 1:
                rect.size.width = sectionWidth;
                break;
            case 2:
                rect.size.width = 320;
                break;
            default:
                break;
        }
        
        self.mTableView.frame = rect;
    }else if (self.ItemuseType==easyBuyListType)
    {
        switch (section) {
            case 0:
                rect.size.width = sectionWidth;
                break;
            case 1:
                rect.size.width = kScreenWidth;
                break;
            case 2:
                rect.size.width = 320;
                break;
            default:
                break;
        }
        //      rect.size.height = 380;
        self.mTableView.frame = rect;
        
        
    }else if (self.ItemuseType==surroundGoodsType)
    {
        
        
        switch (section) {
            case 0:
                rect.size.width = 140;
                break;
            case 1:
                rect.size.width = 140;
                break;
            case 2:
                rect.size.width = kScreenWidth ;
                break;
            case 3:
                rect.size.width = kScreenWidth;
            default:
                break;
        }
        
        self.mTableView.frame = rect;
        
        
        
    }
    
    else {
        
        rect.size.width = 320;
        
        self.mTableView.frame = rect;
        
    }
    
    //隐藏分割线
    if ([self.mTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.mTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    
    
    if (kSystemVersionGreaterThanOrEqualTo(@"8.0")) {
        
        //        [self.mTableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
    
    [self.mSuperView addSubview:self.mTableBaseView];
    [self.mSuperView addSubview:self.mTableView];
    
    //动画设置位置
    
    rect .size.height = (kScreenHeight-64-40)*0.8;
    
    
    [UIView animateWithDuration:0.3 animations:^{
        self.mTableBaseView.alpha = 0.2;
        self.mTableView.alpha = 0.2;
        
        self.mTableBaseView.alpha = 1.0;
        self.mTableView.alpha = 1.0;
        self.mTableView.frame =  rect;
    }];
    
    [self.mTableView reloadData];
    
}


-(void)bgTappedAction
{
    UIImageView *currentIV = (UIImageView *)[self viewWithTag:(SECTION_IV_TAG_BEGIN + currentExtendSection)];
    [UIView animateWithDuration:0.3 animations:^{
        currentIV.transform = CGAffineTransformRotate(currentIV.transform, DEGREES_TO_RADIANS(180));
    }];
    [self hideExtendedChooseView];
}


#pragma mark -- UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (currentExtendSection) {
        case 0:
        {
            
            if (self.ItemuseType==easyBuySearchType) {
                GYEasyBuySecondeTableViewCell * cell =(GYEasyBuySecondeTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
                [cell selectOneRow];
                
                NSString *chooseCellTitle = [self.dropDownDataSource titleInSection:currentExtendSection index:indexPath.row];
                UILabel *currentSectionLB = (UILabel *)[self viewWithTag:SECTION_LB_TAG_BEGIN + currentExtendSection];
                currentSectionLB.text=chooseCellTitle;
                currentSectionLB.textColor=kNavigationBarColor;
                
                if (_dropDownDataSource && [_dropDownDataSource respondsToSelector:@selector(didSelectedOneShow:WithIndexPath:WithCurrentSection:)]) {
                    [_dropDownDataSource didSelectedOneShow:chooseCellTitle WithIndexPath:indexPath WithCurrentSection:currentExtendSection];
                }
                [self bgTappedAction];
                
            }else{
                
                
                GYEasyBuyFirstTableViewCell * cell =(GYEasyBuyFirstTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
                
                [cell setSelectPicture:YES];
                
                if ([self.dropDownDelegate respondsToSelector:@selector(chooseAtSection:index:WithHasChild:)]) {
                    //                NSString *chooseCellTitle = [self.dropDownDataSource titleInSection:currentExtendSection index:indexPath.row];
                    
                    //控制是否有子集的bool  has
                    
                    [self.dropDownDelegate chooseAtSection:currentExtendSection index:indexPath.row WithHasChild:_has];
                    
                    //选择全城的时候，要到这里来
                    
                    if (indexPath.row==0) {
                        switch (self.ItemuseType) {
                            case surroundShopType:
                            case surroundGoodsType:
                            {
                                NSString *chooseCellTitle = [self.dropDownDataSource titleInSection:currentExtendSection index:indexPath.row];
                                UILabel *currentSectionBtn = (UILabel *)[self viewWithTag:SECTION_LB_TAG_BEGIN + currentExtendSection];
                                currentSectionBtn.textColor=kNavigationBarColor;
                                currentSectionBtn.text=chooseCellTitle;
                                [self bgTappedAction];
                                
                                
                            }
                                break;
                                
                            default:
                                break;
                        }
 
                    }
                    
//                    if (self.ItemuseType==surroundShopType&&indexPath.row==0) {
//                        //调用隐藏扩展view后，当前的currentextendSection 为-1  这里需注意
//                        NSString *chooseCellTitle = [self.dropDownDataSource titleInSection:currentExtendSection index:indexPath.row];
//                        UILabel *currentSectionBtn = (UILabel *)[self viewWithTag:SECTION_LB_TAG_BEGIN + currentExtendSection];
//                        currentSectionBtn.textColor=kNavigationBarColor;
//                        currentSectionBtn.text=chooseCellTitle;
//                          [self bgTappedAction];
//                    }
                    //没有子集就把一级分类中的title 设置到button中
                    //有二级分类
                    //                if (_has) {
                    //                    UILabel *currentSectionLB = (UILabel *)[self viewWithTag:SECTION_LB_TAG_BEGIN + currentExtendSection];
                    //                    currentSectionLB.text=chooseCellTitle;
                    //                    //没有二级分类
                    //                }
                    
                }
            }
            
        }
            break;
        case 1:
        {
            
            if (self.ItemuseType==easyBuySearchType) {
                //多选代码
                
                //当item有三个时，第三个item对应的是多选。
                BOOL  isClick = NO;
                GYEasyBuyThirdTableViewCell * thirdcell =(GYEasyBuyThirdTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
                
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
                
                if ([marrDatasource[indexPath.row] boolValue] == isClick ) {//先做一次判断，区分是不是同一个cell
                    //同一个cell里面 把isclick取反
                    isClick  = !isClick ;
                    marrDatasource[indexPath.row] = [NSNumber numberWithBool:isClick];//再复制给数组用于再做判断
                    
                    [thirdcell selectOneRow:indexPath.row WithSelected:YES];
                    
                    NSString *chooseCellTitle = [self.dropDownDataSource titleInSection:currentExtendSection index:indexPath.row];
                    UILabel *currentSectionLB = (UILabel *)[self viewWithTag:SECTION_LB_TAG_BEGIN + currentExtendSection];
                    currentSectionLB.text=chooseCellTitle;
                    currentSectionLB.textColor=kNavigationBarColor;
                    
                    if (_dropDownDataSource && [_dropDownDataSource respondsToSelector:@selector(didSelectedOneShow:WithIndexPath:WithCurrentSection:)]) {
                        [_dropDownDataSource didSelectedOneShow:chooseCellTitle WithIndexPath:indexPath WithCurrentSection:currentExtendSection];
                    }
                    
                }else
                {
                    marrDatasource[indexPath.row] = [NSNumber numberWithBool:isClick];
                    
                    [thirdcell selectOneRow:indexPath.row WithSelected:NO];
                    
                    //取消选中项
                    if (_dropDownDataSource && [_dropDownDataSource respondsToSelector:@selector(mutableSelectRemoveObj:WithCurrentSectin:)]) {
                        [_dropDownDataSource mutableSelectRemoveObj:indexPath WithCurrentSectin:currentExtendSection];
                    }
                }
                
            }
            else  if (self.ItemuseType==easyBuyListType)
            {
                GYEasyBuySecondeTableViewCell * cell =(GYEasyBuySecondeTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
                [cell selectOneRow];
                
                NSString *chooseCellTitle = [self.dropDownDataSource titleInSection:currentExtendSection index:indexPath.row];
                UILabel *currentSectionLB = (UILabel *)[self viewWithTag:SECTION_LB_TAG_BEGIN + currentExtendSection];
                currentSectionLB.text=chooseCellTitle;
                currentSectionLB.textColor=kNavigationBarColor;
                
                if (_dropDownDataSource && [_dropDownDataSource respondsToSelector:@selector(didSelectedOneShow:WithIndexPath:WithCurrentSection:)]) {
                    [_dropDownDataSource didSelectedOneShow:chooseCellTitle WithIndexPath:indexPath WithCurrentSection:currentExtendSection];
                }
                [self bgTappedAction];
                
                
            }
            else
            {
                
                GYEasyBuySecondeTableViewCell * cell =(GYEasyBuySecondeTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
                [cell selectOneRow];
                
                //解决周边逛  第二个section 点击出 子集 的问题。
                if ([self.dropDownDelegate respondsToSelector:@selector(chooseAtSection:index:WithHasChild:)]) {
                    NSString *chooseCellTitle = [self.dropDownDataSource titleInSection:currentExtendSection index:indexPath.row];
                    
                    //控制是否有子集的bool  has
                    
                    [self.dropDownDelegate chooseAtSection:currentExtendSection index:indexPath.row WithHasChild:_has];
                    //没有子集就把一级分类中的title 设置到button中
                    //有二级分类
                    if (_has) {
                        UILabel *currentSectionLB = (UILabel *)[self viewWithTag:SECTION_LB_TAG_BEGIN + currentExtendSection];
                        currentSectionLB.text=chooseCellTitle;
                        //没有二级分类
                    }
                    
                }
                
            }
            
        }
            break;
            //复用问题主要出在 section2 时  返回的cell  secondCell 或者 forthcell。
        case 2:
        {
            
            //secondcell  进入这里
            if ([[tableView cellForRowAtIndexPath:indexPath]  isKindOfClass:[GYEasyBuySecondeTableViewCell class]]) {
                
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
                GYEasyBuySecondeTableViewCell * forthcell =(GYEasyBuySecondeTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
                [forthcell selectOneRow];
                
                //调用隐藏扩展view后，当前的currentextendSection 为-1  这里需注意
                NSString *chooseCellTitle = [self.dropDownDataSource titleInSection:currentExtendSection index:indexPath.row];
                UILabel *currentSectionBtn = (UILabel *)[self viewWithTag:SECTION_LB_TAG_BEGIN + currentExtendSection];
                currentSectionBtn.textColor=kNavigationBarColor;
                currentSectionBtn.text=chooseCellTitle;
                
                //周边逛中 全部都是单选，需要和其他场景区分
                if (self.ItemuseType==surroundShopType) {
                    if (_dropDownDataSource && [_dropDownDataSource respondsToSelector:@selector(didSelectedOneShow:WithIndexPath:WithCurrentSection:)]) {
                        [ _dropDownDataSource  didSelectedOneShow : chooseCellTitle WithIndexPath:indexPath WithCurrentSection:currentExtendSection];
                        
                    }
                    
                    
                    [self bgTappedAction];
                    
                }else if(self.ItemuseType==surroundGoodsType){
                    
                    [ _dropDownDataSource  didSelectedOneShow : chooseCellTitle WithIndexPath:indexPath WithCurrentSection:currentExtendSection];
                    [self bgTappedAction];
                    
                }else
                {
                    [self bgTappedAction];
                    
                }
                
                
                
            }else if ([[tableView cellForRowAtIndexPath:indexPath]  isKindOfClass:[GYEasyBuyThirdTableViewCell class]])
            {
                BOOL  isClick = NO;
                GYEasyBuyThirdTableViewCell * thirdcell =(GYEasyBuyThirdTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
                
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
                
                if ([marrDatasource[indexPath.row] boolValue] == isClick ) {//先做一次判断，区分是不是同一个cell
                    //同一个cell里面 把isclick取反
                    isClick  = !isClick ;
                    marrDatasource[indexPath.row] = [NSNumber numberWithBool:isClick];//再复制给数组用于再做判断
                    NSString *chooseCellTitle = [self.dropDownDataSource titleInSection:currentExtendSection index:indexPath.row];
                    [thirdcell selectOneRow:indexPath.row WithSelected:YES];
                    UILabel *currentSectionBtn = (UILabel *)[self viewWithTag:SECTION_LB_TAG_BEGIN + currentExtendSection];
                    currentSectionBtn.textColor=kNavigationBarColor;
                    currentSectionBtn.text=chooseCellTitle;
                    //添加选中项
                    if (_dropDownDataSource && [_dropDownDataSource respondsToSelector:@selector(didSelectedOneShow:WithIndexPath:WithCurrentSection:)]) {
                        [ _dropDownDataSource  didSelectedOneShow :chooseCellTitle WithIndexPath:indexPath WithCurrentSection:currentExtendSection];
                    }
                    
                    
                }else{
                    
                    marrDatasource[indexPath.row] = [NSNumber numberWithBool:isClick];
                    
                    [thirdcell selectOneRow:indexPath.row WithSelected:NO];
                    //取消选中项
                    if (_dropDownDataSource && [_dropDownDataSource respondsToSelector:@selector(mutableSelectRemoveObj:WithCurrentSectin:)]) {
                        [_dropDownDataSource mutableSelectRemoveObj:indexPath WithCurrentSectin:currentExtendSection];
                    }
                    
                }
                
            }
            
            
        }
            break;
        case 3:
        {
            BOOL  isClick = NO;
            GYEasyBuyThirdTableViewCell * thirdcell =(GYEasyBuyThirdTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
            if ([marrDatasource[indexPath.row] boolValue] == isClick ) {//先做一次判断，区分是不是同一个cell
                //同一个cell里面 把isclick取反
                isClick  = !isClick ;
                marrDatasource[indexPath.row] = [NSNumber numberWithBool:isClick];//再复制给数组用于再做判断
                //调用隐藏扩展view后，当前的currentextendSection 为-1  这里需注意
                NSString *chooseCellTitle = [self.dropDownDataSource titleInSection:currentExtendSection index:indexPath.row];
                
                UILabel *currentSectionBtn = (UILabel *)[self viewWithTag:SECTION_LB_TAG_BEGIN + currentExtendSection];
                
                currentSectionBtn.textColor=kNavigationBarColor;
                currentSectionBtn.text=chooseCellTitle;
                [thirdcell selectOneRow:indexPath.row WithSelected:YES];
                
                //添加选中项
                if (_dropDownDataSource && [_dropDownDataSource respondsToSelector:@selector(didSelectedOneShow:WithIndexPath:WithCurrentSection:)]) {
                    [ _dropDownDataSource  didSelectedOneShow :chooseCellTitle WithIndexPath:indexPath WithCurrentSection:currentExtendSection];
                }
                
                
            }else{
                marrDatasource[indexPath.row] = [NSNumber numberWithBool:isClick];
                
                [thirdcell selectOneRow:indexPath.row WithSelected:NO];
                //取消选中项
                if (_dropDownDataSource && [_dropDownDataSource respondsToSelector:@selector(mutableSelectRemoveObj:WithCurrentSectin:)]) {
                    [_dropDownDataSource mutableSelectRemoveObj:indexPath WithCurrentSectin:currentExtendSection];
                }
                
            }
            
            
            
        }
            break;
        default:
            break;
    }
    
    
    NSLog(@"%d========cursection",currentExtendSection);
    //    //调用隐藏扩展view后，当前的currentextendSection 为-1  这里需注意
    //    NSString *chooseCellTitle = [self.dropDownDataSource titleInSection:currentExtendSection index:indexPath.row];
    //    UILabel *currentSectionBtn = (UILabel *)[self viewWithTag:SECTION_LB_TAG_BEGIN + currentExtendSection];
    //    currentSectionBtn.textColor=kNavigationBarColor;
    //    currentSectionBtn.text=chooseCellTitle;
    
    //用于解决  是否有二级分类，引起的隐藏分类列表不一致的问题。
    //    if (_has) {
    //
    //    }else{
    //        if (self.ItemuseType==easyBuySearchType) {
    //
    //        }else{
    //
    //            UIImageView *currentIV = (UIImageView *)[self viewWithTag:(SECTION_IV_TAG_BEGIN + currentExtendSection)];
    //            [UIView animateWithDuration:0.3 animations:^{
    //                currentIV.transform = CGAffineTransformRotate(currentIV.transform, DEGREES_TO_RADIANS(180));
    //            }];
    //            [self hideExtendedChooseView];
    //
    //
    //        }
    //
    //
    //    }
    
}

#pragma mark -- UITableView DataSource


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dropDownDataSource numberOfRowsInSection:currentExtendSection];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * FirstcellIdentifier = @"firstCell";
    static NSString * SecondcellIdentifier = @"secondCell";
    static NSString * ThirdcellIdentifier = @"thirdCell";
    static NSString * SurrondShopcellIdentifier = @"surroundShopCell";
    
    //如果横条中有四个选项，就创建第四个CELL
    UITableViewCell * Cell=nil;
    
    //    GYEasyBuySecondeTableViewCell * forthCell =[tableView dequeueReusableCellWithIdentifier:FourthcellIdentifier];
    
    GYEasyBuyFirstTableViewCell *  firstCell = [tableView dequeueReusableCellWithIdentifier:FirstcellIdentifier];
    
    GYEasyBuySecondeTableViewCell * Secondcell =[tableView dequeueReusableCellWithIdentifier:SecondcellIdentifier];
    
    GYEasyBuyThirdTableViewCell *  ThirdCell =[tableView dequeueReusableCellWithIdentifier:ThirdcellIdentifier];
    
    
    GYEasyBuySecondeTableViewCell * SurroundShopcell =[tableView dequeueReusableCellWithIdentifier:SurrondShopcellIdentifier];
    
    switch (currentExtendSection) {
        case 0:
        {
            if (self.ItemuseType==easyBuySearchType) {
                
                if (Secondcell==nil) {
                    Secondcell= [[GYEasyBuySecondeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SecondcellIdentifier];
                    
                }
                [Secondcell   nonSelectOneRow];
                Secondcell.delegate=self;
                
                
            }else
            {
                if (!firstCell) {
                    firstCell= [[GYEasyBuyFirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: ThirdcellIdentifier];
                    
                    
                }
                firstCell.imgFrontPicture.hidden=YES;
                firstCell.delegate=self;
                
            }
            
            
            
        }
            break;
        case 1:
        {
            
            if (self.ItemuseType==surroundShopType) {
                
                
                if (!firstCell) {
                    firstCell= [[GYEasyBuyFirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: ThirdcellIdentifier];
                    
                }
                firstCell.imgFrontPicture.hidden=YES;
                firstCell.delegate=self;
            }else{
                
                
                if (Secondcell==nil) {
                    Secondcell= [[GYEasyBuySecondeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SecondcellIdentifier];
                    
                }
                [Secondcell   nonSelectOneRow];
                Secondcell.delegate=self;
                
                
            }
        }
            break;
            
        case 2:
        {
            
            if (SurroundShopcell==nil) {
                SurroundShopcell= [[GYEasyBuySecondeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SurrondShopcellIdentifier];
                
            }
            [SurroundShopcell nonSelectOneRow];
            SurroundShopcell.delegate=self;
            
            
            
        }
            break;
        case 3:
        {  if (ThirdCell==nil) {
            
            ThirdCell= [[GYEasyBuyThirdTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: ThirdcellIdentifier];
            Cell=ThirdCell;
        }
            
        }
            break;
        default:
            
            break;
    }
    
    [firstCell refreshUIWith:[self.dropDownDataSource titleInSection:currentExtendSection index:indexPath.row]];
    
    [Secondcell refreshUIWith:[self.dropDownDataSource titleInSection:currentExtendSection index:indexPath.row]];
    
    [Secondcell.btnSelected addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [ThirdCell refreshUIWith:[self.dropDownDataSource titleInSection:currentExtendSection index:indexPath.row]];
    
    
    [SurroundShopcell refreshUIWith:[self.dropDownDataSource titleInSection:currentExtendSection index:indexPath.row]];
    
    //    surroundShopType=1,
    //    surroundGoodsType,
    //    easyBuyListType,
    //    easyBuySearchType,
    
    switch (self.ItemuseType) {
        case surroundShopType:
        {
            
            switch (currentExtendSection) {
                case 0:
                    return firstCell;
                    break;
                case 1:
                    return Secondcell;
                    break;
                case 2:
                    return SurroundShopcell;
                    break;
                default:
                    break;
            }
            
            
            
            
        }
            break;
        case surroundGoodsType:
        {
            
            switch (currentExtendSection) {
                case 0:
                    return firstCell;
                    break;
                case 1:
                    return Secondcell;
                    break;
                case 2:
                    return SurroundShopcell;
                    break;
                case 3:
                    return ThirdCell;
                    break;
                default:
                    break;
            }
            
            
            
            
        }
            break;
        case easyBuyListType:
        {
            
            switch (currentExtendSection) {
                case 0:
                    return firstCell;
                    break;
                case 1:
                    return Secondcell;
                    break;
                case 2:
                    return ThirdCell;
                    break;
                    
                    break;
                default:
                    break;
            }
            
        }
            break;
        case easyBuySearchType:
        {
            
            //不同的section 对应不同的Cell。
            switch (currentExtendSection) {
                case 0:
                    return Secondcell;
                    break;
                case 1:
                    return ThirdCell;
                    break;
                case 2:
                    return SurroundShopcell;
                    break;
                    
                    break;
                default:
                    break;
            }
            
            
            
            
        }
            break;
        default:
            break;
    }
    
    
    
    return nil;
    
}

//隐藏分割线
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if (kSystemVersionGreaterThanOrEqualTo(@"8.0")) {
        
        //        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}

-(void)BtnClicked:(id )sender
{
    
}


#pragma mark vc的代理方法。
//另一个VC  点击选中按钮后调用的回调方法。
-(void)chooseRowWith:(NSString *)titile WithSection:(NSInteger)index WithTableView: (UITableView *)table
{
    
    UILabel *currentSectionLb = (UILabel *)[self viewWithTag:SECTION_LB_TAG_BEGIN + index];
    
    tvTemp=table;
    
    currentSectionLb.text=titile;
    
    currentSectionLb.textColor=kNavigationBarColor;
    
    
    UIImageView *currentIV= (UIImageView *)[self viewWithTag:(SECTION_IV_TAG_BEGIN +currentExtendSection)];
    
    [UIView animateWithDuration:0.3 animations:^{
        currentIV.transform = CGAffineTransformRotate(currentIV.transform, DEGREES_TO_RADIANS(180));
    }];
    //新点击的sction 与之前的section是同一个
    if (currentExtendSection==index) {
        
        [self hideExtendedChooseView];
        
    }else{
        
        
        //        currentExtendSection = index;
        //        currentIV = (UIImageView *)[self viewWithTag:SECTION_IV_TAG_BEGIN + currentExtendSection];
        //        [UIView animateWithDuration:0.3 animations:^{
        //
        //            currentIV.transform = CGAffineTransformRotate(currentIV.transform, DEGREES_TO_RADIANS(180));
        //        }];
        //
        //        [self showChooseListViewInSection:currentExtendSection choosedIndex:[self.dropDownDataSource defaultShowSection:currentExtendSection]];
        
    }
    
}


#pragma mark 点击确认 隐藏tableview代理方法。
-(void)hidenBackgroundView
{
    [self bgTappedAction];
    
}

#pragma mark secondcell 代理方法接受 label   button

-(void)selectedOneRow:(UILabel *)titleLabel WithButton :(UIButton *)sender WithIndex:(int)index
{
    if (tempIndex==index) {
        
        return;
    }else {
        lbTemp.textColor=[UIColor blackColor];
        lbTemp=titleLabel;
        lbTemp.textColor=[UIColor redColor];
        
    }
    
    
}


#pragma mark currentextendSection = 1 时 图片单选

-(void)sendSelectedPictureToVC :(UIImageView *)sender
{
    
    imgViewTemp.hidden=YES;
    imgViewTemp=sender;
    imgViewTemp.hidden=NO;
    
}

#pragma mark  //secondcell 单选单利方法。

//secondcell 单选单利方法。
-(void)sendDataWithTitle:(UILabel *)title WithSelectedBtn :(UIButton *)sender
{
    lbTemp.textColor=[UIColor blackColor];
    lbTemp=title;
    lbTemp.textColor=[UIColor redColor];
    
    btnTemp.hidden=YES;
    btnTemp=sender;
    btnTemp.hidden=NO;
    
    
    
}
@end
