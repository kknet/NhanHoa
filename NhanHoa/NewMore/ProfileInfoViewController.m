//
//  ProfileInfoViewController.m
//  NhanHoa
//
//  Created by OS on 10/24/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ProfileInfoViewController.h"
#import "ProfileInfoTbvCell.h"

#define PERSONAL_NUM_ROWS_SECTION_1     5
#define PERSONAL_NUM_ROWS_SECTION_2     3

@interface ProfileInfoViewController ()<UITableViewDelegate, UITableViewDataSource>{
    AppDelegate *appDelegate;
    UIFont *textFont;
    
    UIView *tbHeaderView;
    UIImageView *imgAvatar;
    UILabel *lbIDAcc;
    float hTbHeader;
    float padding;
    
    float hCell;
    float hAvatar;
    
    UIView *tbFooterView;
    UIButton *btnUpdate;
}
@end

@implementation ProfileInfoViewController
@synthesize viewHeader, icBack, lbHeader, tbInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = TRUE;
    
    lbHeader.text = [appDelegate.localization localizedStringForKey:@"Profile informations"];
    [btnUpdate setTitle:[appDelegate.localization localizedStringForKey:@"Update information"]
               forState:UIControlStateNormal];
    [self displayProfileInformations];
}

- (void)displayProfileInformations
{
    NSString *avatarURL = [AccountModel getCusPhoto];
    if (![AppUtils isNullOrEmpty: avatarURL]) {
        [imgAvatar sd_setImageWithURL:[NSURL URLWithString:avatarURL] placeholderImage:DEFAULT_AVATAR];
    }else{
        imgAvatar.image = DEFAULT_AVATAR;
    }
    
    lbIDAcc.text = SFM(@"ID: %@", [AccountModel getCusIdOfUser]);
    float sizeText = [AppUtils getSizeWithText:lbIDAcc.text withFont:lbIDAcc.font andMaxWidth:SCREEN_WIDTH].width + 20.0;
    [lbIDAcc mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(sizeText);
    }];
}

- (void)setupUIForView
{
    self.view.backgroundColor = [UIColor colorWithRed:(241/255.0) green:(242/255.0) blue:(245/255.0) alpha:1.0];
    
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    padding = 15.0;
    hCell = 65.0;
    hAvatar = 100.0;
    float hFooter = 100.0;
    
    textFont = [UIFont fontWithName:RobotoMedium size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoMedium size:18.0];
        hAvatar = 80.0;
        hCell = 60.0;
        hFooter = 80.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoMedium size:20.0];
        hAvatar = 80.0;
        hCell = 60.0;
        hFooter = 80.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoMedium size:22.0];
        hAvatar = 100.0;
        hCell = 65.0;
        hFooter = 100.0;
    }
    
    //  view header
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hStatus + self.navigationController.navigationBar.frame.size.height);
    }];
    [AppUtils addBoxShadowForView:viewHeader color:GRAY_230 opacity:0.8 offsetX:1.0 offsetY:5.0];
    
    lbHeader.font = textFont;
    lbHeader.textColor = GRAY_50;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader).offset(hStatus);
        make.bottom.equalTo(viewHeader);
        make.centerX.equalTo(viewHeader.mas_centerX);
        make.width.mas_equalTo(250.0);
    }];
    
    icBack.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    [icBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewHeader).offset(5.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    //  header for tableview
    [tbInfo registerNib:[UINib nibWithNibName:@"ProfileInfoTbvCell" bundle:nil] forCellReuseIdentifier:@"ProfileInfoTbvCell"];
    tbInfo.separatorStyle = UITableViewCellSeparatorStyleNone;
    tbInfo.delegate = self;
    tbInfo.dataSource = self;
    tbInfo.backgroundColor = UIColor.clearColor;
    [tbInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom).offset(5.0);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    
    hTbHeader = 2*padding + hAvatar + 1.5*padding + 30.0 + 2*padding;
    tbHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, hTbHeader)];
    tbHeaderView.backgroundColor = self.view.backgroundColor;
    tbInfo.tableHeaderView = tbHeaderView;
    
    imgAvatar = [[UIImageView alloc] init];
    [tbHeaderView addSubview: imgAvatar];
    imgAvatar.clipsToBounds = TRUE;
    imgAvatar.layer.cornerRadius = hAvatar/2;
    [imgAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tbHeaderView).offset(2*padding);
        make.centerX.equalTo(tbHeaderView.mas_centerX);
        make.width.height.mas_equalTo(hAvatar);
    }];
    UITapGestureRecognizer *tapOnAvatar = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnAvatar)];
    imgAvatar.userInteractionEnabled = TRUE;
    [imgAvatar addGestureRecognizer: tapOnAvatar];
    
    lbIDAcc = [[UILabel alloc] init];
    lbIDAcc.textAlignment = NSTextAlignmentCenter;
    lbIDAcc.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2];
    lbIDAcc.backgroundColor = ORANGE_COLOR;
    lbIDAcc.textColor = UIColor.whiteColor;
    lbIDAcc.clipsToBounds = TRUE;
    lbIDAcc.layer.cornerRadius = 8.0;
    [tbHeaderView addSubview: lbIDAcc];
    [lbIDAcc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgAvatar.mas_bottom).offset(1.5*padding);
        make.centerX.equalTo(tbHeaderView.mas_centerX);
        make.height.mas_equalTo(30.0);
        make.width.mas_equalTo(0);
    }];
    
    //  footer for tableview
    tbFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, hFooter)];
    tbFooterView.backgroundColor = UIColor.whiteColor;
    tbInfo.tableFooterView = tbFooterView;
    
    btnUpdate = [UIButton buttonWithType: UIButtonTypeCustom];
    btnUpdate.backgroundColor = BLUE_COLOR;
    [btnUpdate setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnUpdate.titleLabel.font = textFont;
    btnUpdate.layer.cornerRadius = 8.0;
    btnUpdate.clipsToBounds = TRUE;
    [tbFooterView addSubview: btnUpdate];
    [btnUpdate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(tbFooterView.mas_centerY);
        make.height.mas_equalTo(50.0);
        make.left.equalTo(tbFooterView).offset(padding);
        make.right.equalTo(tbFooterView).offset(-padding);
    }];
    
    tbInfo.tableFooterView = tbFooterView;
}

- (IBAction)icBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (void)whenTapOnAvatar {
    NSLog(@"whenTapOnAvatar");
}

#pragma mark - UITableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return PERSONAL_NUM_ROWS_SECTION_1;
    }else{
        return PERSONAL_NUM_ROWS_SECTION_2;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProfileInfoTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileInfoTbvCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Fullname"];
                cell.lbValue.text = [AccountModel getCusRealName];
                break;
            }
            case 1:{
                cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Gender"];
                cell.lbValue.text = [AccountModel getCusGenderValue];
                
                break;
            }
            case 2:{
                cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Date of birth"];
                cell.lbValue.text = [AccountModel getCusBirthday];
                break;
            }
            case 3:{
                cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Passport"];
                cell.lbValue.text = [AccountModel getCusPassport];
                break;
            }
            case 4:{
                cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Phone number"];
                cell.lbValue.text = [AccountModel getCusPhone];
                break;
            }
        }
    }else{
        switch (indexPath.row) {
            case 0:{
                cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Permanent address"];
                cell.lbValue.text = [AccountModel getCusAddress];
                break;
            }
            case 1:{
                cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Province/ City"];
                cell.lbValue.text = [AccountModel getCusCityName];
                break;
            }
            case 2:{
                cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Country"];
                cell.lbValue.text = [appDelegate.localization localizedStringForKey:@"Viet Nam"];
                break;
            }
        }
    }
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    }else{
        UILabel *lbSection = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15.0)];
        lbSection.backgroundColor = self.view.backgroundColor;
        return lbSection;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.1;
    }else{
        return 15.0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 0) {
        return [self getHeightContentForCell];
    }
    return hCell;
}

- (float)getHeightContentForCell {
    UIFont *font = [UIFont fontWithName:RobotoRegular size:19.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        font = [UIFont fontWithName:RobotoRegular size:15.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        font = [UIFont fontWithName:RobotoRegular size:17.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        font = [UIFont fontWithName:RobotoRegular size:19.0];
    }
    
    float maxLeftSize = [AppUtils getSizeWithText:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Permanent address"] withFont:textFont andMaxWidth:SCREEN_WIDTH].width + 5.0;
    
    float maxSize = (SCREEN_WIDTH - 2*padding - maxLeftSize - 5.0);
    
    NSString *content = [AccountModel getCusAddress];
    float hContent = [AppUtils getSizeWithText:content withFont:font andMaxWidth:maxSize].height + 30.0;
    if (hContent >= hCell) {
        return hContent;
    }
    return hCell;
}

#pragma mark - UIScrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0) {
        scrollView.contentOffset = CGPointZero;
    }
}

@end
