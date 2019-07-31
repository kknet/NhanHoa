//
//  DomainDNSViewController.m
//  NhanHoa
//
//  Created by OS on 7/31/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "DomainDNSViewController.h"
#import "DNSManagerCell.h"
#import "DNSDetailCell.h"

@interface DomainDNSViewController ()<UITableViewDelegate, UITableViewDataSource> {
    UIScrollView *scvContent;
    UITableView *tbContent;
    float hCell;
}
@end

@implementation DomainDNSViewController
@synthesize tbRecords;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Quản lý DNS";
    hCell = 40.0;
    
    [tbRecords mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
    
    //  tbRecords.separatorStyle = UITableViewCellSelectionStyleNone;
    //  tbRecords.delegate = self;
    //  tbRecords.dataSource = self;
    //  [tbRecords registerNib:[UINib nibWithNibName:@"DNSManagerCell" bundle:nil] forCellReuseIdentifier:@"DNSManagerCell"];
    tbRecords.hidden = TRUE;
    
    scvContent = [[UIScrollView alloc] init];
    [self.view addSubview: scvContent];
    scvContent.showsVerticalScrollIndicator = FALSE;
    scvContent.showsHorizontalScrollIndicator = FALSE;
    scvContent.pagingEnabled = TRUE;
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    float hContent = 20*hCell;
    float padding = 5.0;
    float wContent = (padding + 140 + padding) + 1.0 + (padding + 40.0 + padding) + 1.0 + (padding + 120.0 + padding) + 1.0 + (padding + 100.0 + padding) + 1.0 + (padding + 45.0 + padding) + 1.0 + (padding + 40.0 + padding) + 1.0 + (padding + 40.0 + padding);
    
    tbContent = [[UITableView alloc] init];
    [tbContent registerNib:[UINib nibWithNibName:@"DNSDetailCell" bundle:nil] forCellReuseIdentifier:@"DNSDetailCell"];
    tbContent.separatorStyle = UITableViewCellSelectionStyleNone;
    tbContent.scrollEnabled = FALSE;
    tbContent.delegate = self;
    tbContent.dataSource = self;
    [scvContent addSubview: tbContent];
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scvContent);
        make.width.mas_equalTo(wContent);
        make.height.mas_equalTo(hContent);
    }];
    
    scvContent.contentSize = CGSizeMake(wContent, hContent);
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];
}

- (void) orientationChanged:(NSNotification *)note
{
    UIDevice * device = note.object;
    
//    UIDeviceOrientationUnknown,
//    UIDeviceOrientationPortrait,            // Device oriented vertically, home button on the bottom
//    UIDeviceOrientationPortraitUpsideDown,  // Device oriented vertically, home button on the top
//    UIDeviceOrientationLandscapeLeft,       // Device oriented horizontally, home button on the right
//    UIDeviceOrientationLandscapeRight,      // Device oriented horizontally, home button on the left
//    UIDeviceOrientationFaceUp,              // Device oriented flat, face up
//    UIDeviceOrientationFaceDown
    self.view.backgroundColor = UIColor.greenColor;
    if (device.orientation == UIDeviceOrientationLandscapeRight) {
        [UIView animateWithDuration:0.2
                              delay:0.0
                            options:0
                         animations:^{
                             scvContent.backgroundColor = UIColor.orangeColor;
                             scvContent.transform = CGAffineTransformMakeRotation(-M_PI/2);
                             scvContent.frame = self.view.bounds;
                             
                         }completion:^(BOOL finished){
                             NSLog(@"Done!");
                         }];
    }else if (device.orientation == UIDeviceOrientationLandscapeLeft){
        [UIView animateWithDuration:0.2
                              delay:0.0
                            options:0
                         animations:^{
                             scvContent.backgroundColor = UIColor.orangeColor;
                             scvContent.transform = CGAffineTransformMakeRotation(M_PI/2);
                             scvContent.frame = self.view.bounds;
                             
                         }completion:^(BOOL finished){
                             NSLog(@"Done!");
                         }];
        
    }else if (device.orientation == UIDeviceOrientationPortrait){
        [UIView animateWithDuration:0.2
                              delay:0.0
                            options:0
                         animations:^{
                             scvContent.backgroundColor = UIColor.orangeColor;
                             scvContent.transform = CGAffineTransformMakeRotation(0);
                             scvContent.frame = self.view.bounds;
                             
                         }completion:^(BOOL finished){
                             NSLog(@"Done!");
                         }];
    }
}

#pragma mark - UITableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DNSDetailCell *cell = (DNSDetailCell *)[tableView dequeueReusableCellWithIdentifier:@"DNSDetailCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.lbTTL.text = @"3600";
    cell.lbValue.text = @"103.101.163.135";
    cell.lbType.text = @"A";
    cell.lbHost.text = [NSString stringWithFormat:@"hoadon.skype %d", (int)indexPath.row];
    
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = UIColor.whiteColor;
    }else{
        cell.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1.0];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%d", (int)indexPath.row);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return hCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return hCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    float padding = 5.0;
    float totalWidth = (padding + 140 + padding) + 1.0 + (padding + 40.0 + padding) + 1.0 + (padding + 120.0 + padding) + 1.0 + (padding + 100.0 + padding) + 1.0 + (padding + 45.0 + padding) + 1.0 + (padding + 40.0 + padding) + 1.0 + (padding + 40.0 + padding);
    
    UIView *viewSection = [[UIView alloc] initWithFrame:CGRectMake(0, 0, totalWidth, 40.0)];
    viewSection.backgroundColor = [UIColor colorWithRed:(235/255.0) green:(235/255.0) blue:(235/255.0) alpha:1.0];
    
    UILabel *lbHost = [[UILabel alloc] init];
    lbHost.text = @"Host";
    [viewSection addSubview: lbHost];
    [lbHost mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewSection).offset(padding);
        make.top.bottom.equalTo(viewSection);
        make.width.mas_equalTo(140.0);
    }];
    
    UILabel *lbSepa1 = [[UILabel alloc] init];
    [viewSection addSubview: lbSepa1];
    [lbSepa1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(viewSection);
        make.left.equalTo(lbHost.mas_right).offset(padding);
        make.width.mas_equalTo(1.0);
    }];
    
    UILabel *lbType = [[UILabel alloc] init];
    lbType.text = @"Type";
    [viewSection addSubview: lbType];
    [lbType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(viewSection);
        make.left.equalTo(lbSepa1.mas_right).offset(padding);
        make.width.height.mas_equalTo(40.0);
    }];
    
    UILabel *lbSepa2 = [[UILabel alloc] init];
    [viewSection addSubview: lbSepa2];
    [lbSepa2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(viewSection);
        make.left.equalTo(lbType.mas_right).offset(padding);
        make.width.mas_equalTo(1.0);
    }];
    
    UILabel *lbValue = [[UILabel alloc] init];
    lbValue.text = @"Value";
    [viewSection addSubview: lbValue];
    [lbValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(viewSection);
        make.left.equalTo(lbSepa2.mas_right).offset(padding);
        make.width.mas_equalTo(120.0);
    }];
    
    UILabel *lbSepa3 = [[UILabel alloc] init];
    [viewSection addSubview: lbSepa3];
    [lbSepa3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(viewSection);
        make.left.equalTo(lbValue.mas_right).offset(padding);
        make.width.mas_equalTo(1.0);
    }];
    
    UILabel *lbMX = [[UILabel alloc] init];
    lbMX.text = @"MX";
    [viewSection addSubview: lbMX];
    [lbMX mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(viewSection);
        make.left.equalTo(lbSepa3.mas_right).offset(padding);
        make.width.mas_equalTo(100.0);
    }];
    
    UILabel *lbSepa4 = [[UILabel alloc] init];
    [viewSection addSubview: lbSepa4];
    [lbSepa4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(viewSection);
        make.left.equalTo(lbMX.mas_right).offset(padding);
        make.width.mas_equalTo(1.0);
    }];
    
    UILabel *lbTTL = [[UILabel alloc] init];
    lbTTL.text = @"TTL";
    [viewSection addSubview: lbTTL];
    [lbTTL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(viewSection);
        make.left.equalTo(lbSepa4.mas_right).offset(padding);
        make.width.mas_equalTo(45.0);
    }];
    
    UILabel *lbSepa5 = [[UILabel alloc] init];
    [viewSection addSubview: lbSepa5];
    [lbSepa5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(viewSection);
        make.left.equalTo(lbTTL.mas_right).offset(padding);
        make.width.mas_equalTo(1.0);
    }];
    
    UILabel *lbEdit = [[UILabel alloc] init];
    lbEdit.text = @"Sửa";
    [viewSection addSubview: lbEdit];
    [lbEdit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbSepa5.mas_right).offset(padding);
        make.top.bottom.equalTo(viewSection);
        make.width.height.mas_equalTo(40.0);
    }];
    
    UILabel *lbSepa6 = [[UILabel alloc] init];
    [viewSection addSubview: lbSepa6];
    [lbSepa6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(viewSection);
        make.left.equalTo(lbEdit.mas_right).offset(padding);
        make.width.mas_equalTo(1.0);
    }];
    
    UILabel *lbRemove = [[UILabel alloc] init];
    lbRemove.text = @"Xóa";
    [viewSection addSubview: lbRemove];
    [lbRemove mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbSepa6.mas_right).offset(padding);
        make.top.bottom.equalTo(viewSection);
        make.width.mas_equalTo(40.0);
    }];
    
    lbHost.textAlignment = lbType.textAlignment = lbValue.textAlignment = lbMX.textAlignment = lbTTL.textAlignment = lbEdit.textAlignment = lbRemove.textAlignment = NSTextAlignmentCenter;
    lbHost.font = lbType.font = lbValue.font = lbMX.font = lbTTL.font = lbEdit.font = lbRemove.font = [UIFont fontWithName:RobotoMedium size:15.0];
    //  lbSepa1.backgroundColor = lbSepa2.backgroundColor = lbSepa3.backgroundColor = lbSepa4.backgroundColor = lbSepa5.backgroundColor = lbSepa6.backgroundColor = [UIColor colorWithRed:(235/255.0) green:(235/255.0) blue:(235/255.0) alpha:1.0];
    lbSepa1.backgroundColor = lbSepa2.backgroundColor = lbSepa3.backgroundColor = lbSepa4.backgroundColor = lbSepa5.backgroundColor = lbSepa6.backgroundColor = [UIColor redColor];
    
    return viewSection;
}

@end
