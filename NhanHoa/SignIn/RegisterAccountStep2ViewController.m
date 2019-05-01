//
//  RegisterAccountStep2ViewController.m
//  NhanHoa
//
//  Created by admin on 5/1/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "RegisterAccountStep2ViewController.h"
#import "PersonalProfileView.h"
#import "BusinessProfileView.h"

@interface RegisterAccountStep2ViewController ()<UIScrollViewDelegate>{
    PersonalProfileView *personalProfile;
    BusinessProfileView *businessProfile;
}

@end

@implementation RegisterAccountStep2ViewController
@synthesize viewMenu, viewAccInfo, lbAccount, lbNumOne, lbSepa, viewProfileInfo, lbProfile, lbNumTwo, scvContent;
@synthesize hMenu;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Thông tin hồ sơ";
    [self setupUIForView];
    
    [self addPersonalProfileView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification object:nil];
}

//  Hiển thị bàn phím
- (void)keyboardWillShow:(NSNotification *)notif {
    CGSize keyboardSize = [[[notif userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    [scvContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewMenu.mas_bottom).offset(10.0);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.bottom.equalTo(self.view).offset(-keyboardSize.height);
    }];
}

//  Ẩn bàn phím
- (void)keyboardDidHide: (NSNotification *) notif{
    [scvContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewMenu.mas_bottom).offset(10.0);
        make.left.bottom.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
}

- (void)addPersonalProfileView {
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"PersonalProfileView" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[PersonalProfileView class]]) {
            personalProfile = (PersonalProfileView *) currentObject;
            break;
        }
    }
    [personalProfile.icPersonal addTarget:self
                                   action:@selector(selectPersonalProfile)
                         forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tapOnPersonal = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPersonalProfile)];
    personalProfile.lbPersonal.userInteractionEnabled = TRUE;
    [personalProfile.lbPersonal addGestureRecognizer: tapOnPersonal];
    
    [personalProfile.icBusiness addTarget:self
                                   action:@selector(selectBusinessProfile)
                         forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tapOnBusiness = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectBusinessProfile)];
    personalProfile.lbBusiness.userInteractionEnabled = TRUE;
    [personalProfile.lbBusiness addGestureRecognizer: tapOnBusiness];
    
    [self.scvContent addSubview: personalProfile];
    
    /*
        10: is mTop (margin top)
        30: is height of title label
        38: is height of textfield
        15: is padding for view
    */
    float hView = 110 + 7*10 + 7*30 + 7*38 + 40.0 + 4*15.0;
    
    [personalProfile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hView);
    }];
    [personalProfile setupUIForView];
    self.scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hView);
}

- (void)addBusinessProfileView {
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"BusinessProfileView" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[BusinessProfileView class]]) {
            businessProfile = (BusinessProfileView *) currentObject;
            break;
        }
    }
    [businessProfile.icPersonal addTarget:self
                                   action:@selector(selectPersonalProfile)
                         forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tapOnPersonal = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPersonalProfile)];
    businessProfile.lbPersonal.userInteractionEnabled = TRUE;
    [businessProfile.lbPersonal addGestureRecognizer: tapOnPersonal];
    
    [businessProfile.icBusiness addTarget:self
                                   action:@selector(selectBusinessProfile)
                         forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tapOnBusiness = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectBusinessProfile)];
    businessProfile.lbBusiness.userInteractionEnabled = TRUE;
    [businessProfile.lbBusiness addGestureRecognizer: tapOnBusiness];
    
    [self.scvContent addSubview: businessProfile];
    
    /*
     10: is mTop (margin top)
     30: is height of title label
     38: is height of textfield
     15: is padding for view
     */
    float hView = 110 + 11*10 + 13*30 + 11*38 + 7*15 + 40.0;
    [businessProfile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hView);
    }];
    [businessProfile setupUIForView];
    self.scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hView);
}


- (void)selectPersonalProfile {
    [personalProfile.icPersonal setImage:[UIImage imageNamed:@"tick_orange"]
                                forState:UIControlStateNormal];
    [personalProfile.icBusiness setImage:[UIImage imageNamed:@"no_tick"]
                                forState:UIControlStateNormal];
    
    [businessProfile.icPersonal setImage:[UIImage imageNamed:@"tick_orange"]
                                forState:UIControlStateNormal];
    [businessProfile.icBusiness setImage:[UIImage imageNamed:@"no_tick"]
                                forState:UIControlStateNormal];
    
    if (personalProfile == nil) {
        [self addPersonalProfileView];
    }
    personalProfile.hidden = FALSE;
    businessProfile.hidden = TRUE;
}

- (void)selectBusinessProfile {
    [personalProfile.icPersonal setImage:[UIImage imageNamed:@"no_tick"]
                                forState:UIControlStateNormal];
    [personalProfile.icBusiness setImage:[UIImage imageNamed:@"tick_orange"]
                                forState:UIControlStateNormal];
    
    [businessProfile.icPersonal setImage:[UIImage imageNamed:@"no_tick"]
                                forState:UIControlStateNormal];
    [businessProfile.icBusiness setImage:[UIImage imageNamed:@"tick_orange"]
                                forState:UIControlStateNormal];
    
    if (businessProfile == nil) {
        [self addBusinessProfileView];
    }
    personalProfile.hidden = TRUE;
    businessProfile.hidden = FALSE;
}

- (void)setupUIForView {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    hMenu = 60.0;
    self.view.backgroundColor = [UIColor colorWithRed:(246/255.0) green:(247/255.0) blue:(251/255.0) alpha:1.0];
    
    [viewMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(self.hMenu);
    }];
    
    lbSepa.textColor = [UIColor colorWithRed:(130/255.0) green:(146/255.0) blue:(169/255.0) alpha:1.0];
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.viewMenu.mas_centerX);
        make.top.bottom.equalTo(self.viewMenu);
    }];
    
    [viewAccInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.viewMenu);
        make.right.equalTo(self.lbSepa.mas_left);
    }];
    
    lbAccount.font = [UIFont fontWithName:RobotoRegular size:14.0];
    [lbAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.viewAccInfo);
        make.right.equalTo(self.viewAccInfo).offset(-2.0);
    }];
    
    lbNumOne.clipsToBounds = TRUE;
    lbNumOne.layer.cornerRadius = 20.0/2;
    lbNumOne.font = lbAccount.font;
    [lbNumOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lbAccount.mas_left).offset(-3.0);
        make.centerY.equalTo(self.lbAccount.mas_centerY);
        make.width.height.mas_equalTo(20.0);
    }];
    
    [viewProfileInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.viewMenu);
        make.left.equalTo(self.lbSepa.mas_right);
    }];
    
    lbNumTwo.clipsToBounds = TRUE;
    lbNumTwo.layer.cornerRadius = 20.0/2;
    lbNumTwo.font = lbAccount.font;
    [lbNumTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewProfileInfo).offset(2.0);
        make.centerY.equalTo(self.viewProfileInfo.mas_centerY);
        make.width.height.mas_equalTo(20.0);
    }];
    
    lbProfile.font = lbAccount.font;
    [lbProfile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbNumTwo.mas_right).offset(3.0);
        make.top.bottom.equalTo(self.viewProfileInfo);
    }];
    
    scvContent.delegate = self;
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewMenu.mas_bottom).offset(10.0);
        make.left.bottom.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
}

//implementation
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing: TRUE];
}

@end
