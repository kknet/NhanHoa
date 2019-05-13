//
//  ChooseCityPopupView.m
//  NhanHoa
//
//  Created by lam quang quan on 5/11/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ChooseCityPopupView.h"
#import "CityCell.h"
#import "CityObject.h"

@implementation ChooseCityPopupView
@synthesize viewHeader, icClose, lbTitle, tbCity, delegate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        // Initialization code
        self.backgroundColor =  UIColor.whiteColor;
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 12.0;
        
        viewHeader = [[UIView alloc] init];
        viewHeader.backgroundColor = BLUE_COLOR;
        [self addSubview: viewHeader];
        [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.mas_equalTo(45.0);
        }];
        
        //  close popup
        icClose = [[UIButton alloc] init];
        icClose.imageEdgeInsets = UIEdgeInsetsMake(12, 12, 12, 12);
        [icClose setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [icClose addTarget:self
                    action:@selector(fadeOut)
          forControlEvents:UIControlEventTouchUpInside];
        [viewHeader addSubview: icClose];
        [icClose mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(self);
            make.width.height.mas_equalTo(44.0);
        }];
        
        lbTitle = [[UILabel alloc] init];
        lbTitle.text = @"Chọn Tỉnh/Thành phố";
        lbTitle.textColor = UIColor.whiteColor;
        lbTitle.font = [UIFont fontWithName:RobotoRegular size:18.0];
        [viewHeader addSubview: lbTitle];
        [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.viewHeader.mas_centerX);
            make.width.mas_equalTo(150.0);
            make.top.bottom.equalTo(self.viewHeader);
        }];
        
        tbCity = [[UITableView alloc] init];
        [tbCity registerNib:[UINib nibWithNibName:@"CityCell" bundle:nil] forCellReuseIdentifier:@"CityCell"];
        tbCity.delegate = self;
        tbCity.dataSource = self;
        tbCity.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview: tbCity];
        [tbCity mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self);
            make.top.equalTo(self.viewHeader.mas_bottom);
        }];
        
    }
    return self;
}


- (void)showInView:(UIView *)aView animated:(BOOL)animated {
    //Add transparent
    UIView *viewBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    viewBackground.backgroundColor = UIColor.blackColor;
    viewBackground.alpha = 0.5;
    viewBackground.tag = 20;
    [aView addSubview:viewBackground];
    
    [aView addSubview:self];
    if (animated) {
        [self fadeIn];
    }
}

- (void)fadeIn {
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)fadeOut {
    for (UIView *subView in self.superview.subviews){
        if (subView.tag == 20){
            [subView removeFromSuperview];
        }
    }
    
    [UIView animateWithDuration:.35 animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [[NSNotificationCenter defaultCenter] removeObserver:self];
            [self removeFromSuperview];
        }
    }];
}

#pragma mark - UITableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[AppDelegate sharedInstance].listCity count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CityCell *cell = (CityCell *)[tableView dequeueReusableCellWithIdentifier:@"CityCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CityObject *city = [[AppDelegate sharedInstance].listCity objectAtIndex: indexPath.row];
    cell.lbName.text = city.name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self fadeOut];
    CityObject *city = [[AppDelegate sharedInstance].listCity objectAtIndex: indexPath.row];
    [delegate choosedCity: city];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}


@end
