//
//  SelectProfileView.m
//  NhanHoa
//
//  Created by admin on 5/2/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "SelectProfileView.h"
#import "ProfileDetailCell.h"

@implementation SelectProfileView
@synthesize viewHeader, icAdd, lbTitle, tbProfile, icClose;
@synthesize hHeader, delegate, selectedRow;

//  Add profile
@synthesize scvAddProfile, lbVision, icPersonal, lbPersonal, icBusiness, lbBusiness, lbName, tfName, lbSex, icMale, lbMale, icFemale, lbFemale, lbBOD, tfBOD, lbPassport, tfPassport, lbPhone, tfPhone, lbEmail, tfEmail, lbAddress, tfAddress, lbCountry, tfCountry, imgArrCountry, btnCountry, lbCity, tfCity, imgArrCity, btnCity, imgPassport, lbTitlePassport, imgPassportFront, imgPassportBehind, lbPassportFront, lbPassportBehind, btnSave, btnCancel;

- (void)setupUIForView {
    selectedRow = 0;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(self.hHeader);
    }];
    
    icClose.imageEdgeInsets = UIEdgeInsetsMake(13, 13, 13, 13);
    [icClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset([AppDelegate sharedInstance].hStatusBar);
        make.left.equalTo(self);
        make.width.height.mas_equalTo(self.hHeader - [AppDelegate sharedInstance].hStatusBar);
    }];
    
    icAdd.imageEdgeInsets = UIEdgeInsetsMake(11, 11, 11, 11);
    [icAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.icClose);
        make.right.equalTo(self.mas_right);
        make.width.equalTo(self.icClose.mas_width);
    }];
    
    lbTitle.font = [UIFont fontWithName:RobotoRegular size:18.0];
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.icClose);
        make.left.equalTo(self.icClose.mas_right).offset(5.0);
        make.right.equalTo(self.icAdd.mas_left).offset(-5.0);
    }];
    
    tbProfile.separatorStyle = UITableViewCellSelectionStyleNone;
    [tbProfile registerNib:[UINib nibWithNibName:@"ProfileDetailCell" bundle:nil] forCellReuseIdentifier:@"ProfileDetailCell"];
    tbProfile.delegate = self;
    tbProfile.dataSource = self;
    [tbProfile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewHeader.mas_bottom);
        make.left.right.bottom.equalTo(self);
    }];
    
    //  setup for add profile
    float padding = 15.0;
    float mTop = 10.0;
    
    [scvAddProfile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewHeader.mas_bottom);
        make.left.right.bottom.equalTo(self);
    }];
    
    lbVision.font = [UIFont fontWithName:RobotoMedium size:16.0];
    lbVision.textColor = TITLE_COLOR;
    [lbVision mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scvAddProfile);
        make.left.equalTo(self).offset(padding);
        make.width.mas_equalTo(SCREEN_WIDTH-2*padding);
        make.height.mas_equalTo(40.0);
    }];
    
    //  Choose type profile
    icPersonal.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [icPersonal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbVision.mas_bottom).offset(5.0);
        make.left.equalTo(self.lbVision).offset(-4.0);
        make.width.height.mas_equalTo(30.0);
    }];
    
    lbPersonal.textColor = lbVision.textColor;
    lbPersonal.font = [UIFont fontWithName:RobotoRegular size:16.0];
    [lbPersonal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.icPersonal);
        make.left.equalTo(self.icPersonal.mas_right).offset(3.0);
        make.right.equalTo(self.mas_centerX);
    }];
    
    icBusiness.imageEdgeInsets = icPersonal.imageEdgeInsets;
    [icBusiness mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.icPersonal);
        make.left.equalTo(self.mas_centerX);
        make.width.equalTo(self.icPersonal.mas_width);
    }];
    
    lbBusiness.textColor = lbVision.textColor;
    lbBusiness.font = lbPersonal.font;
    [lbBusiness mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbPersonal);
        make.left.equalTo(self.icBusiness.mas_right).offset(3.0);
        make.right.equalTo(self).offset(-padding);
    }];
    
    //  Name
    lbName.textColor = lbVision.textColor;
    lbName.font = lbPersonal.font;
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbBusiness.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.lbVision);
        mas_equalTo(.he)
    }];
    
}

- (IBAction)icAddClick:(UIButton *)sender {
}

- (IBAction)icCloseClick:(UIButton *)sender {
    [delegate onIconCloseClicked];
}

#pragma mark - UITableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileDetailCell *cell = (ProfileDetailCell *)[tableView dequeueReusableCellWithIdentifier:@"ProfileDetailCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        [cell updateUIForBusinessProfile: FALSE];
    }else{
        [cell updateUIForBusinessProfile: TRUE];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != selectedRow) {
        selectedRow = (int)indexPath.row;
        [tableView beginUpdates];
        [tableView endUpdates];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == selectedRow) {
        if (selectedRow == 0) {
            return [self getHeightProfileForBusiness: FALSE];
        }else{
            return [self getHeightProfileForBusiness: TRUE];
        }
    }else{
        if (indexPath.row == 0) {
            return 61.0;
        }else{
            return 81.0;
        }
    }
}

- (float)getHeightProfileForBusiness: (BOOL)isBusiness {
    float hItem = 30.0;
    
    float wPassport = (SCREEN_WIDTH - 3*15.0)/2;
    float hPassport = wPassport * 2/3;
    float hDetailView = 15 + 9 * hItem + hPassport + hItem + 15;
    
    if (isBusiness) {
        return 80 + hDetailView + 1;
    }else{
        return 60 + hDetailView + 1;
    }
}


- (IBAction)icPersonalClick:(UIButton *)sender {
}

- (IBAction)icBusinessClick:(UIButton *)sender {
}

- (IBAction)icMaleClick:(UIButton *)sender {
}

- (IBAction)icFemaleClick:(UIButton *)sender {
}

- (IBAction)btnCountryPress:(UIButton *)sender {
}

- (IBAction)btnCancelPress:(UIButton *)sender {
}

- (IBAction)btnSavePress:(UIButton *)sender {
}
@end
