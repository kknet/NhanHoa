//
//  CartPaymentViewController.m
//  NhanHoa
//
//  Created by OS on 11/19/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "CartPaymentViewController.h"
#import "DomainProfileTbvCell.h"
#import "ChooseProfileView.h"


@interface CartPaymentViewController ()<UITableViewDelegate, UITableViewDataSource, ChooseProfileViewDelegate>
{
    UIFont *textFont;
    float hCell;
    float hSmallCell;
    
    ChooseProfileView *profileView;
}

@end

@implementation CartPaymentViewController
@synthesize viewHeader, icBack, lbHeader, viewMenu, icBackStep, lbStepTitle, icNextStep, lbBgState, lbBgActiveState, tbProfile;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    icBackStep.hidden = TRUE;
}

- (IBAction)icBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (IBAction)icBackStepClick:(UIButton *)sender {
}

- (IBAction)icNextStepClick:(UIButton *)sender {
}

- (void)setupUIForView
{
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    float paddingTop = 25.0;
    float paddingY = 15.0;
    float hTitle = 20.0;
    
    float padding = 15.0;
    
    textFont = [UIFont fontWithName:RobotoBold size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
    }
    hCell = paddingTop + hTitle + paddingY + 80.0 + paddingTop;
    
    //  header view
    viewHeader.backgroundColor = UIColor.whiteColor;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hStatus + self.navigationController.navigationBar.frame.size.height);
    }];
    [AppUtils addBoxShadowForView:viewHeader color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    //  header
    lbHeader.textColor = GRAY_50;
    lbHeader.font = textFont;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader).offset(hStatus);
        make.centerX.equalTo(viewHeader.mas_centerX);
        make.bottom.equalTo(viewHeader);
        make.width.mas_equalTo(250.0);
    }];
    
    icBack.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    [icBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewHeader).offset(5.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    //  view menu
    [viewMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(55.0);
    }];
    
    icBackStep.imageEdgeInsets = icNextStep.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    [icBackStep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewMenu).offset(5.0);
        make.centerY.equalTo(viewMenu.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    [icNextStep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewMenu).offset(-5.0);
        make.centerY.equalTo(viewMenu.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    lbStepTitle.textColor = GRAY_50;
    lbStepTitle.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize];
    [lbStepTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(icBackStep);
        make.left.equalTo(icBackStep.mas_right);
        make.right.equalTo(icNextStep.mas_left);
    }];
    
    lbBgState.backgroundColor = GRAY_235;
    [lbBgState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(viewMenu);
        make.height.mas_equalTo(3.0);
    }];
    
    lbBgActiveState.backgroundColor = ORANGE_COLOR;
    [lbBgActiveState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewMenu);
        make.top.bottom.equalTo(lbBgState);
        make.width.mas_equalTo(SCREEN_WIDTH/3);
    }];
    
    [tbProfile registerNib:[UINib nibWithNibName:@"DomainProfileTbvCell" bundle:nil] forCellReuseIdentifier:@"DomainProfileTbvCell"];
    tbProfile.delegate = self;
    tbProfile.dataSource = self;
    tbProfile.separatorStyle = UITableViewCellSelectionStyleNone;
    [tbProfile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.bottom.equalTo(self.view).offset(-padding);
        make.top.equalTo(viewMenu.mas_bottom);
    }];
}

- (void)addListProfileForChoose {
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"ChooseProfileView" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[ChooseProfileView class]]) {
            profileView = (ChooseProfileView *) currentObject;
            break;
        }
    }
    profileView.delegate = self;
    [self.view addSubview: profileView];
    [profileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(0);
    }];
    [profileView setupUIForViewWithHeightNav: self.navigationController.navigationBar.frame.size.height];
}

#pragma mark - UITableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[CartModel getInstance] countItemInCart];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *domainInfo = [[CartModel getInstance].listDomain objectAtIndex: indexPath.row];
    NSString *domain = [domainInfo objectForKey:@"domain"];
    
    DomainProfileTbvCell *cell = (DomainProfileTbvCell *)[tableView dequeueReusableCellWithIdentifier:@"DomainProfileTbvCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.lbDomain.text = domain;
    
    NSDictionary *profile = [domainInfo objectForKey:profile_cart];
    if (profile == nil) {
        [cell showProfileContentForCell: FALSE];
        
        //  [cell showProfileView:FALSE withBusiness:FALSE];
    }else{
        [cell showProfileContentForCell: TRUE];
        
        NSString *type = [profile objectForKey:@"cus_own_type"];
//        if ([type isEqualToString:@"0"]) {
//            [cell showProfileView: TRUE withBusiness: FALSE];
//        }else{
//            [cell showProfileView: TRUE withBusiness: TRUE];
//        }
        [cell displayContentWithInfo: profile];
    }
    
    cell.btnChoose.tag = indexPath.row;
    [cell.btnChoose addTarget:self
                       action:@selector(chooseProfile:)
             forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return hCell;
}

- (void)chooseProfile: (UIButton *)sender {
    if (profileView == nil) {
        [self addListProfileForChoose];
    }
    [self performSelector:@selector(startShowProfilesListView:) withObject:[NSNumber numberWithInt:(int)sender.tag] afterDelay:0.1];
}

- (void)startShowProfilesListView: (NSNumber *)tagIndex {
    //  gắn tag tương ứng với index đang xử lý
    profileView.tag = [tagIndex intValue];
    
    [profileView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCREEN_HEIGHT);
    }];
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
    
//    if (chooseProfileView.frame.origin.y == 0) {
//        [self showProfileList: FALSE withTag: -1];
//    }else{
//        [self showProfileList: TRUE withTag: tag];
//    }
}

#pragma mark - ChooseProfileDelegateView
-(void)closeChooseProfileView {
    [profileView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(void)choosedProfileForDomain {
    [self closeChooseProfileView];
    [tbProfile reloadData];
}

@end
