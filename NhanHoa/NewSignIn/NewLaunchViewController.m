//
//  NewLaunchViewController.m
//  NhanHoa
//
//  Created by OS on 10/17/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "NewLaunchViewController.h"
#import "NewSignInViewController.h"
#import "NewSignUpViewController.h"
#import "SignInDescClvCell.h"

#define NUM_OF_SLIDES   3

@interface NewLaunchViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>{
    float padding;
    float hCollectionView;
    
    UIColor *inactiveColor;
    float hDot;
}
@end

@implementation NewLaunchViewController
@synthesize imgLogo, clvDesc, btnSignIn, btnSignUp, viewPageControl, lbDot1, lbDot2, lbDot3;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = TRUE;
    
}

- (void)setupUIForView
{
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    padding = 15.0;
    inactiveColor = [UIColor colorWithRed:(185/255.0) green:(209/255.0) blue:(241/255.0) alpha:1.0];
    
    float marginY = 30.0;
    float hLabel = 60.0;
    float hContent = 60.0;
    float hSlider = 60.0;
    
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        marginY = 10.0;
        hLabel = 40.0;
        hContent = 40.0;
        hSlider = 15.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6) {
        marginY = 15.0;
        hLabel = 40.0;
        hContent = 50.0;
        hSlider = 15.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        marginY = 30.0;
        hLabel = 60.0;
        hContent = 60.0;
    }
    
    UIImage *image = [UIImage imageNamed:@"signin_logo"];
    float realWidth = SCREEN_WIDTH * 2/4 + 50;
    float realHeight = realWidth * image.size.height / image.size.width;
    
    //  NSLog(@"top: %f", [AppDelegate sharedInstance].safeAreaTopPadding);
    [imgLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(hStatus+marginY);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(realWidth);
        make.height.mas_equalTo(realHeight);
    }];
    
    float sizeButton = (SCREEN_WIDTH - 3*padding)/2;
    float hButton = 50.0;
    
    btnSignIn.layer.cornerRadius = btnSignUp.layer.cornerRadius = 7.0;
    
    btnSignIn.backgroundColor = BLUE_COLOR;
    btnSignIn.titleLabel.font = [UIFont fontWithName:RobotoMedium size:19.0];
    [btnSignIn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnSignIn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.bottom.equalTo(self.view).offset(-padding-[AppDelegate sharedInstance].safeAreaBottomPadding);
        make.width.mas_equalTo(sizeButton);
        make.height.mas_equalTo(hButton);
    }];
    [AppUtils addBoxShadowForView:btnSignIn color:[UIColor colorWithRed:(150/255.0) green:(150/255.0)
                                                                   blue:(150/255.0) alpha:0.8]
                          opacity:1.0 offsetX:1.0 offsetY:1.0];
    
    btnSignUp.backgroundColor = UIColor.whiteColor;
    btnSignUp.titleLabel.font = [UIFont fontWithName:RobotoMedium size:19.0];
    [btnSignUp setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    [btnSignUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btnSignIn.mas_right).offset(padding);
        make.top.bottom.equalTo(btnSignIn);
        make.width.mas_equalTo(sizeButton);
    }];
    [AppUtils addBoxShadowForView:btnSignUp color:[UIColor colorWithRed:(200/255.0) green:(200/255.0)
                                                                   blue:(200/255.0) alpha:0.8]
                          opacity:1.0 offsetX:1.0 offsetY:1.0];
    
    //  collection view content
    float wImgCollection = (SCREEN_WIDTH - 2*padding);
    hCollectionView = wImgCollection + padding + hLabel + hContent;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10.0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    clvDesc.collectionViewLayout = layout;
    
    clvDesc.delegate = self;
    clvDesc.dataSource = self;
    clvDesc.backgroundColor = UIColor.clearColor;
    [clvDesc registerNib:[UINib nibWithNibName:@"SignInDescClvCell" bundle:nil] forCellWithReuseIdentifier:@"SignInDescClvCell"];
    clvDesc.showsHorizontalScrollIndicator = FALSE;
    clvDesc.pagingEnabled = TRUE;
    [clvDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.centerY.equalTo(self.view.mas_centerY);
        make.height.mas_equalTo(hCollectionView);
    }];
    
    //  page control view
    hDot = 9.0;
    
    viewPageControl.backgroundColor = UIColor.clearColor;
    [viewPageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(clvDesc.mas_bottom);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(hSlider);
    }];
    
    lbDot1.clipsToBounds = lbDot2.clipsToBounds = lbDot3.clipsToBounds = TRUE;
    lbDot2.layer.cornerRadius = lbDot3.layer.cornerRadius = hDot/2;
    lbDot1.layer.cornerRadius = (hDot - 0)/2;
    
    lbDot2.backgroundColor = inactiveColor;
    [lbDot2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewPageControl.mas_centerX);
        make.centerY.equalTo(viewPageControl.mas_centerY);
        make.width.height.mas_equalTo(hDot);
    }];
    
    lbDot3.backgroundColor = inactiveColor;
    [lbDot3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbDot2.mas_right).offset(hDot);
        make.top.bottom.equalTo(lbDot2);
        make.width.mas_equalTo(hDot);
    }];
    
    lbDot1.backgroundColor = BLUE_COLOR;
    [lbDot1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lbDot2.mas_left).offset(-hDot);
        make.top.bottom.equalTo(lbDot2);
        //  make.centerY.equalTo(viewPageControl.mas_centerY);
        //  make.height.mas_equalTo(hDot);
        make.width.mas_equalTo(3.5*hDot);
    }];
}

- (void)setupSliderWithSelectedIndex: (int)selectedIndex {
    if (selectedIndex == 0) {
        lbDot1.backgroundColor = BLUE_COLOR;
        lbDot2.backgroundColor = lbDot3.backgroundColor = inactiveColor;
        
        [lbDot1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(3.5*hDot);
        }];
        
        [lbDot2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(hDot);
        }];
        
        [lbDot3 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(hDot);
        }];
    }else if (selectedIndex == 1){
        lbDot2.backgroundColor = BLUE_COLOR;
        lbDot1.backgroundColor = lbDot3.backgroundColor = inactiveColor;
        
        [lbDot1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(hDot);
        }];
        
        [lbDot2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(3.5*hDot);
        }];
        
        [lbDot3 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(hDot);
        }];
    }else{
        lbDot3.backgroundColor = BLUE_COLOR;
        lbDot1.backgroundColor = lbDot2.backgroundColor = inactiveColor;
        
        [lbDot1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(hDot);
        }];
        
        [lbDot2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(hDot);
        }];
        
        [lbDot3 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(3.5*hDot);
        }];
    }
    
    [UIView animateWithDuration:0.1 animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - UICollectionview menu
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return NUM_OF_SLIDES;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SignInDescClvCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SignInDescClvCell" forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        cell.imgPhoto.image = [UIImage imageNamed:@"login_desc_2"];
        cell.lbTitle.text = @"Tra cứu tên miền nhanh chóng";
        cell.lbContent.text = @"Ứng dụng đăng ký và quản lý tên miền được ưa chuộng nhất hiện nay.";
        
    }else if (indexPath.row == 1){
        cell.imgPhoto.image = [UIImage imageNamed:@"login_desc_1"];
        cell.lbTitle.text = @"Đăng ký tên miền ngay";
        cell.lbContent.text = @"để xây dựng thương hiệu của bạn trên Internet";
        
    }else{
        cell.imgPhoto.image = [UIImage imageNamed:@"login_desc_3"];
        cell.lbTitle.text = @"Đăng ký dịch vụ của chúng tôi ngay hôm nay";
        cell.lbContent.text = @"Cảm ơn 60.000+ khách hàng đã tin tưởng và đang sử dụng dịch vụ của chúng tôi.";
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH, hCollectionView);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

#pragma mark - UIScrollView
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x == 0) {
        [self setupSliderWithSelectedIndex: 0];
        
    }else if (scrollView.contentOffset.x == SCREEN_WIDTH) {
        [self setupSliderWithSelectedIndex: 1];
        
    }else {
        [self setupSliderWithSelectedIndex: 2];
    }
}

- (IBAction)btnSignInPress:(UIButton *)sender {
    NewSignInViewController *signInVC = [[NewSignInViewController alloc] initWithNibName:@"NewSignInViewController" bundle:nil];
    [self.navigationController pushViewController:signInVC animated:TRUE];
}

- (IBAction)btnSignUpPress:(UIButton *)sender {
    NewSignUpViewController *signUpVC = [[NewSignUpViewController alloc] initWithNibName:@"NewSignUpViewController" bundle:nil];
    [self.navigationController pushViewController:signUpVC animated:TRUE];
}

@end
