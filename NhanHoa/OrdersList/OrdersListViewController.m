//
//  OrdersListViewController.m
//  NhanHoa
//
//  Created by OS on 8/3/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "OrdersListViewController.h"
#import "OrderDetailViewController.h"
#import "OrderItemTbvCell.h"
#import "OrderTypeTbvCell.h"

#define NUM_TYPE_OF_ORDER   6

@interface OrdersListViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
{
    AppDelegate *appDelegate;
    float padding;
    NSMutableArray *listData;
    UIFont *textFont;
    float hMenu;
    float hCell;
    float hSection;
    float hTextfield;
    
    UIButton *btnAll;
    UIButton *btnPending;
    UIButton *btnCreating;
    UIButton *btnUsing;
    UIButton *btnAboutToExpire;
    UIButton *btnExpired;
    
    UIView *viewType;
    UITableView *tbType;
    
    eMenuType curMenu;
}

@end

@implementation OrdersListViewController
@synthesize viewHeader, lbHeader, icCart, scvContent, viewTop, tfSearch, imgSearch, scvMenu, tbContent;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //  self.navigationItem.title = [appDelegate.localization localizedStringForKey:@"Orders management"];
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = TRUE;
    
    [self showContenWithCurrentLanguage];
    
    [self createDemoDatas];
    [self reupdateLayoutAfterPreparedData];
}

- (void)reupdateLayoutAfterPreparedData {
    [tbContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(listData.count * hCell + hSection);
    }];
    
    float hContent = padding + hTextfield + padding + hMenu + padding + listData.count*hCell + hSection;
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hContent);
}

- (void)showContenWithCurrentLanguage {
    lbHeader.text = [appDelegate.localization localizedStringForKey:@"Orders management"];
    tfSearch.placeholder = [appDelegate.localization localizedStringForKey:@"Search domains or IP"];
    
    //  set title for menu buttons
    [btnAll setTitle:[appDelegate.localization localizedStringForKey:@"All"] forState:UIControlStateNormal];
    [btnPending setTitle:[appDelegate.localization localizedStringForKey:@"Pending"] forState:UIControlStateNormal];
    [btnCreating setTitle:[appDelegate.localization localizedStringForKey:@"Creating"] forState:UIControlStateNormal];
    [btnUsing setTitle:[appDelegate.localization localizedStringForKey:@"Using"] forState:UIControlStateNormal];
    [btnAboutToExpire setTitle:[appDelegate.localization localizedStringForKey:@"About to expire"] forState:UIControlStateNormal];
    [btnExpired setTitle:[appDelegate.localization localizedStringForKey:@"Expired"] forState:UIControlStateNormal];
}

- (void)setupUIForView
{
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    hTextfield = 45.0;
    hMenu = 40.0;
    hCell = 125;    //  5 + 25*4 + 5 + 15.0
    hSection = 40.0;
    curMenu = eMenuAll;
    cho nay
    
    padding = 15.0;
    textFont = [UIFont fontWithName:RobotoRegular size:20.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoRegular size:16.0];
        hTextfield = 40.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6) {
        textFont = [UIFont fontWithName:RobotoRegular size:18.0];
        hTextfield = 42.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS) {
        textFont = [UIFont fontWithName:RobotoRegular size:20.0];
        hTextfield = 45.0;
    }
    
    //  header view
    viewHeader.backgroundColor = BLUE_COLOR;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hStatus + self.navigationController.navigationBar.frame.size.height);
    }];
    
    lbHeader.font = textFont;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader).offset(hStatus);
        make.centerX.equalTo(viewHeader.mas_centerX);
        make.bottom.equalTo(viewHeader);
        make.width.mas_equalTo(250.0);
    }];
    
    icCart.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    [icCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewHeader).offset(-5.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    //  content
    scvContent.backgroundColor = [UIColor colorWithRed:(238/255.0) green:(238/255.0)
                                                  blue:(238/255.0) alpha:1.0];
    scvContent.delegate = self;
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-self.tabBarController.tabBar.frame.size.height);
    }];
    
    viewTop.backgroundColor = UIColor.clearColor;
    [viewTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(padding + hTextfield);
    }];
    [self addCurvePathForViewWithHeight:(padding + hTextfield) forView:viewTop];
    
    //  search view
    tfSearch.layer.cornerRadius = hTextfield/2;
    tfSearch.font = [UIFont fontWithName:RobotoItalic size:textFont.pointSize];
    [tfSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scvContent).offset(padding);
        make.left.equalTo(viewTop).offset(padding);
        make.right.equalTo(viewTop).offset(-padding);
        make.height.mas_equalTo(hTextfield);
    }];
    
    tfSearch.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, padding+30.0, hTextfield)];
    tfSearch.leftViewMode = UITextFieldViewModeAlways;
    
    [imgSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tfSearch).offset(padding);
        make.centerY.equalTo(tfSearch.mas_centerY);
        make.width.height.mas_equalTo(22.0);
    }];
    [AppUtils addBoxShadowForView:tfSearch color:GRAY_100 opacity:0.6 offsetX:1.0 offsetY:1.0];
    
    //  menu
    scvMenu.showsHorizontalScrollIndicator = FALSE;
    scvMenu.backgroundColor = UIColor.clearColor;
    [scvMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfSearch.mas_bottom).offset(padding);
        make.left.equalTo(viewTop).offset(padding/2);
        make.right.equalTo(viewTop).offset(-padding/2);
        make.height.mas_equalTo(hMenu);
    }];
    [self addMenuContentToScrollView];
    
    //  tableview
    tbContent.backgroundColor = UIColor.clearColor;
    [tbContent registerNib:[UINib nibWithNibName:@"OrderItemTbvCell" bundle:nil] forCellReuseIdentifier:@"OrderItemTbvCell"];
    tbContent.delegate = self;
    tbContent.dataSource = self;
    tbContent.separatorStyle = UITableViewCellSelectionStyleNone;
    tbContent.showsVerticalScrollIndicator = FALSE;
    tbContent.scrollEnabled = FALSE;
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scvMenu.mas_bottom).offset(padding);
        make.left.equalTo(viewTop).offset(padding/2);
        make.right.equalTo(viewTop).offset(-padding/2);
        make.height.mas_equalTo(0);
    }];
}

- (void)addMenuContentToScrollView {
    //  remove all subviews was added before
    [scvMenu.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    float contentSize = 0;
    
    UIFont *menuFont = [UIFont fontWithName:RobotoMedium size:textFont.pointSize-2];
    
    float sizeText = [AppUtils getSizeWithText:[appDelegate.localization localizedStringForKey:@"All"]
                                      withFont:menuFont andMaxWidth:SCREEN_WIDTH].width + 20.0;
    
    //  all menu button
    float hBTN = 33.0;
    btnAll = [UIButton buttonWithType: UIButtonTypeCustom];
    [btnAll setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    btnAll.backgroundColor = [UIColor colorWithRed:(228/255.0) green:(238/255.0)
                                              blue:(249/255.0) alpha:1.0];
    [scvMenu addSubview: btnAll];
    [btnAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scvMenu);
        make.centerY.equalTo(scvMenu.mas_centerY);
        make.height.mas_equalTo(hBTN);
        make.width.mas_equalTo(sizeText);
    }];
    contentSize += sizeText;
    
    //  pending menu button
    sizeText = [AppUtils getSizeWithText:[appDelegate.localization localizedStringForKey:@"Pending"]
                                withFont:menuFont andMaxWidth:SCREEN_WIDTH].width + 20.0;
    
    btnPending = [UIButton buttonWithType: UIButtonTypeCustom];
    [btnPending setTitleColor:GRAY_100 forState:UIControlStateNormal];
    [scvMenu addSubview: btnPending];
    [btnPending mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btnAll.mas_right).offset(padding/2);
        make.top.bottom.equalTo(btnAll);
        make.width.mas_equalTo(sizeText);
    }];
    contentSize = contentSize + padding/2 + sizeText;
    
    //  creating menu button
    sizeText = [AppUtils getSizeWithText:[appDelegate.localization localizedStringForKey:@"Creating"]
                                withFont:menuFont andMaxWidth:SCREEN_WIDTH].width + 20.0;
    
    btnCreating = [UIButton buttonWithType: UIButtonTypeCustom];
    [btnCreating setTitleColor:GRAY_100 forState:UIControlStateNormal];
    [scvMenu addSubview: btnCreating];
    [btnCreating mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btnPending.mas_right).offset(padding/2);
        make.top.bottom.equalTo(btnPending);
        make.width.mas_equalTo(sizeText);
    }];
    contentSize = contentSize + padding/2 + sizeText;
    
    //  using menu button
    sizeText = [AppUtils getSizeWithText:[appDelegate.localization localizedStringForKey:@"Using"]
                                withFont:menuFont andMaxWidth:SCREEN_WIDTH].width + 20.0;
    
    btnUsing = [UIButton buttonWithType: UIButtonTypeCustom];
    [btnUsing setTitleColor:GRAY_100 forState:UIControlStateNormal];
    [scvMenu addSubview: btnUsing];
    [btnUsing mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btnCreating.mas_right).offset(padding/2);
        make.top.bottom.equalTo(btnCreating);
        make.width.mas_equalTo(sizeText);
    }];
    contentSize = contentSize + padding/2 + sizeText;
    
    //  about to expire menu button
    sizeText = [AppUtils getSizeWithText:[appDelegate.localization localizedStringForKey:@"About to expire"]
                                withFont:menuFont andMaxWidth:SCREEN_WIDTH].width + 20.0;
    
    btnAboutToExpire = [UIButton buttonWithType: UIButtonTypeCustom];
    [btnAboutToExpire setTitleColor:GRAY_100 forState:UIControlStateNormal];
    [scvMenu addSubview: btnAboutToExpire];
    [btnAboutToExpire mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btnUsing.mas_right).offset(padding/2);
        make.top.bottom.equalTo(btnUsing);
        make.width.mas_equalTo(sizeText);
    }];
    contentSize = contentSize + padding/2 + sizeText;
    
    //  expired menu button
    sizeText = [AppUtils getSizeWithText:[appDelegate.localization localizedStringForKey:@"Expired"]
                                withFont:menuFont andMaxWidth:SCREEN_WIDTH].width + 20.0;
    
    btnExpired = [UIButton buttonWithType: UIButtonTypeCustom];
    [btnExpired setTitleColor:GRAY_100 forState:UIControlStateNormal];
    [scvMenu addSubview: btnExpired];
    [btnExpired mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btnAboutToExpire.mas_right).offset(padding/2);
        make.top.bottom.equalTo(btnAboutToExpire);
        make.width.mas_equalTo(sizeText);
    }];
    contentSize = contentSize + padding/2 + sizeText;
    
    btnAll.titleLabel.font = btnPending.titleLabel.font = btnCreating.titleLabel.font = btnUsing.titleLabel.font = btnAboutToExpire.titleLabel.font = btnExpired.titleLabel.font = menuFont;
    
    btnAll.layer.cornerRadius = btnPending.layer.cornerRadius = btnCreating.layer.cornerRadius = btnUsing.layer.cornerRadius = btnAboutToExpire.layer.cornerRadius = btnExpired.layer.cornerRadius = 17.0;
    
    scvMenu.contentSize = CGSizeMake(contentSize, hMenu);
}

- (void)addCurvePathForViewWithHeight: (float)height forView: (UIView *)view {
    float hCurve = 18.0;
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint: CGPointMake(0, 0)];
    [path addLineToPoint: CGPointMake(0, height-hCurve)];
    [path addQuadCurveToPoint:CGPointMake(SCREEN_WIDTH, height-hCurve) controlPoint:CGPointMake(SCREEN_WIDTH/2, height+hCurve)];
    [path addLineToPoint: CGPointMake(SCREEN_WIDTH, 0)];
    [path closePath];
    
    //Add gradient layer to top view
    
    CAShapeLayer *shapeLayer = [CAShapeLayer new];
    shapeLayer.path = path.CGPath;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.backgroundColor = BLUE_COLOR.CGColor;
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
    //  gradientLayer.startPoint = CGPointMake(0.5, 0);
    //  gradientLayer.endPoint = CGPointMake(0.5, 1);
    //  gradientLayer.colors = @[(id)[UIColor colorWithRed:(27/255.0) green:(100/255.0) blue:(202/255.0) alpha:1].CGColor, (id)[UIColor colorWithRed:(29/255.0) green:(104/255.0) blue:(209/255.0) alpha:1.0].CGColor];
    
    [view.layer insertSublayer:gradientLayer atIndex:0];
    gradientLayer.mask = shapeLayer;
}

- (void)createDemoDatas {
    listData = [[NSMutableArray alloc] init];
    
    NSDictionary *info = [[NSDictionary alloc] initWithObjectsAndKeys:@"ORD896893", @"ord_id", @"bsnhakhoa.net", @"domain", @"DT tên miền quốc tế .NET", @"name", @"0", @"price", @"28/06/2020", @"create_date", @"28/06/2021", @"end_date", @"1", @"status", nil];
    [listData addObject: info];
    
    NSDictionary *info1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"ORD896863", @"ord_id", @"lehson.name.vn", @"domain", @"DT tên miền quốc gia .NAME.VN", @"name", @"0", @"price", @"14/07/2019", @"create_date", @"14/07/2020", @"end_date", @"1", @"status", nil];
    [listData addObject: info1];
    
    NSDictionary *info2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"ORD886198", @"ord_id", @"sonlh1984.name.vn", @"domain", @"Tài khoản trả trước", @"name", @"0", @"price", @"28/06/2020", @"create_date", @"28/06/2021", @"end_date", @"1", @"status", nil];
    [listData addObject: info2];
    
    NSDictionary *info3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"ORD896893", @"ord_id", @"bsnhakhoa.net", @"domain", @"DT tên miền quốc tế .NET", @"name", @"0", @"price", @"", @"create_date", @"", @"end_date", @"1", @"status", nil];
    [listData addObject: info3];
    
    NSDictionary *info4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"ORD886195", @"ord_id", @"sonlh1984.name.vn", @"domain", @"ĐK tên miền quốc gia .NAME.VN", @"name", @"0", @"price", @"", @"create_date", @"", @"end_date", @"1", @"status", nil];
    [listData addObject: info4];
    
    NSDictionary *info5 = [[NSDictionary alloc] initWithObjectsAndKeys:@"ORD885825", @"ord_id", @"lehoangson.net", @"domain", @"DT tên miền quốc tế .NET", @"name", @"0", @"price", @"16/06/2025", @"create_date", @"16/06/2025", @"end_date", @"1", @"status", nil];
    [listData addObject: info5];
    
    NSDictionary *info6 = [[NSDictionary alloc] initWithObjectsAndKeys:@"ORD885816", @"ord_id", @"vnnic.vn", @"domain", @"Tranfer tên miền quốc gia .VN", @"name", @"0", @"price", @"", @"create_date", @"", @"end_date", @"1", @"status", nil];
    [listData addObject: info6];
    
    NSDictionary *info7 = [[NSDictionary alloc] initWithObjectsAndKeys:@"ORD882872", @"ord_id", @"lehoangson.net", @"domain", @"ĐK Email Hosting – BASIC 1 (Space:20GB;Email:50)", @"name", @"0", @"price", @"05/07/2019", @"create_date", @"05/01/2020", @"end_date", @"1", @"status", nil];
    [listData addObject: info7];
    
    NSDictionary *info8 = [[NSDictionary alloc] initWithObjectsAndKeys:@"ORD882870", @"ord_id", @"nooplinux.com", @"domain", @"ĐK Email - Web4s Enterprise", @"name", @"0", @"price", @"05/07/2019", @"create_date", @"05/07/2020", @"end_date", @"1", @"status", nil];
    [listData addObject: info8];
    
    NSDictionary *info9 = [[NSDictionary alloc] initWithObjectsAndKeys:@"ORD882867", @"ord_id", @"webpro.vn", @"domain", @"ĐK Email Hosting – CLASSIC 2 (Space:10GB;Email:20)", @"name", @"0", @"price", @"05/07/2019", @"create_date", @"05/07/2020", @"end_date", @"1", @"status", nil];
    [listData addObject: info9];
    
    NSDictionary *info10 = [[NSDictionary alloc] initWithObjectsAndKeys:@"ORD882223", @"ord_id", @"lehoangson.com", @"domain", @"ĐK tên miền quốc tế .COM", @"name", @"0", @"price", @"05/07/2019", @"create_date", @"05/07/2021", @"end_date", @"1", @"status", nil];
    [listData addObject: info10];
}

#pragma mark - UITableview Delegate & Data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == tbContent) {
        return listData.count;
    }
    return NUM_TYPE_OF_ORDER;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tbContent) {
        OrderItemTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderItemTbvCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //    NSDictionary *info = [listData objectAtIndex: indexPath.row];
        //    cell.lbService.text = [info objectForKey:@"name"];
        //    cell.lbOrID.text = [info objectForKey:@"ord_id"];
        //    cell.lbDomain.text = [info objectForKey:@"domain"];
        //
        //    NSString *price = [AppUtils convertStringToCurrencyFormat:[info objectForKey:@"price"]];
        //    cell.lbMoney.text = SFM(@"%@ đ", price);
        //
        //    cell.lbTime.text = SFM(@"[%@ - %@]", [info objectForKey:@"create_date"], [info objectForKey:@"end_date"]);
        //
        //    cell.lbStatus.attributedText = [AppUtils generateTextWithContent:@"Đã kích hoạt" font:[AppDelegate sharedInstance].fontRegular color:GREEN_COLOR image:[UIImage imageNamed:@"tick_green"] size:16.0 imageFirst:TRUE];
        
        return cell;
    }else{
        OrderTypeTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderTypeTbvCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        switch (indexPath.row) {
            case 0:{
                cell.lbName.text = [appDelegate.localization localizedStringForKey:@"All orders"];
                cell.lbCount.text = @"12";
                
                [cell setCellIsSelected: TRUE];
                break;
            }
            case 1:{
                cell.lbName.text = [appDelegate.localization localizedStringForKey:@"Pending orders"];
                cell.lbCount.text = @"2";
                
                [cell setCellIsSelected: FALSE];
                break;
            }
            case 2:{
                cell.lbName.text = [appDelegate.localization localizedStringForKey:@"Creating orders"];
                cell.lbCount.text = @"2";
                
                [cell setCellIsSelected: FALSE];
                break;
            }
            case 3:{
                cell.lbName.text = [appDelegate.localization localizedStringForKey:@"Using orders"];
                cell.lbCount.text = @"3";
                
                [cell setCellIsSelected: FALSE];
                break;
            }
            case 4:{
                cell.lbName.text = [appDelegate.localization localizedStringForKey:@"About to expire orders"];
                cell.lbCount.hidden = TRUE;
                
                [cell setCellIsSelected: FALSE];
                break;
            }
            case 5:{
                cell.lbName.text = [appDelegate.localization localizedStringForKey:@"Expired orders"];
                cell.lbCount.hidden = TRUE;
                
                [cell setCellIsSelected: FALSE];
                break;
            }
                
            default:
                break;
        }
        
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == tbContent) {
        OrderDetailViewController *orderDetailVC = [[OrderDetailViewController alloc] initWithNibName:@"OrderDetailViewController" bundle:nil];
        [self.navigationController pushViewController:orderDetailVC animated:TRUE];
    }else{
        [self closeChooseOrdersListType];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == tbContent) {
        UIView *viewSection = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-padding, hSection)];
        
        UIButton *icShowType = [UIButton buttonWithType: UIButtonTypeCustom];
        [icShowType setImage:[UIImage imageNamed:@"ic_arrow_down"] forState:UIControlStateNormal];
        [icShowType addTarget:self
                       action:@selector(showTypeOfOrdersList)
             forControlEvents:UIControlEventTouchUpInside];
        //  icShowType.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
        [viewSection addSubview: icShowType];
        [icShowType mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(viewSection).offset(-padding);
            make.centerY.equalTo(viewSection.mas_centerY);
            make.width.height.mas_equalTo(35.0);
        }];
        
        UILabel *lbTitle = [[UILabel alloc] init];
        lbTitle.font = [UIFont fontWithName:RobotoBold size:textFont.pointSize+1];
        lbTitle.text = @"Tất cả đơn hàng (12)";
        lbTitle.textColor = GRAY_50;
        [viewSection addSubview: lbTitle];
        [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(viewSection);
            make.right.equalTo(icShowType.mas_left);
            make.top.bottom.equalTo(viewSection);
        }];
        
        return viewSection;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == tbContent) {
        return hCell;
    }
    return 50.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == tbContent) {
        return hSection;
    }
    return 0;
}

- (IBAction)icCartClick:(UIButton *)sender {
}

- (void)showTypeOfOrdersList {
    if (viewType == nil) {
        viewType = [[UIView alloc] init];
        viewType.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:0.5];
        viewType.hidden = TRUE;
        [appDelegate.window addSubview: viewType];
        [viewType mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self.view);
        }];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeChooseOrdersListType)];
        [viewType addGestureRecognizer: tapGesture];
        
        tbType = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 6*50.0)];
        tbType.separatorStyle = UITableViewCellSelectionStyleNone;
        tbType.scrollEnabled = FALSE;
        tbType.delegate = self;
        tbType.dataSource = self;
        [tbType registerNib:[UINib nibWithNibName:@"OrderTypeTbvCell" bundle:nil] forCellReuseIdentifier:@"OrderTypeTbvCell"];
        [viewType addSubview: tbType];
    }
    
    viewType.hidden = FALSE;
    [UIView animateWithDuration:0.2 animations:^{
        tbType.frame = CGRectMake(0, SCREEN_HEIGHT-6*50, SCREEN_WIDTH, 6*50);
    }];
}

- (void)closeChooseOrdersListType {
    [UIView animateWithDuration:0.2 animations:^{
        tbType.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 6*50);
    }completion:^(BOOL finished) {
        viewType.hidden = TRUE;
    }];
}

#pragma mark - UIScrollDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0) {
        scrollView.contentOffset = CGPointZero;
    }
}

@end
