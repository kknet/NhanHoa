//
//  BOViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 4/27/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "BOViewController.h"
#import "WebServices.h"
#import "AccountModel.h"

@interface BOViewController ()<WebServicesDelegate>{
    WebServices *webService;
}
@end

@implementation BOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    webService = [[WebServices alloc] init];
    webService.delegate = self;
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:whois_mod forKey:@"mod"];
    [jsonDict setObject:@"lehoangson.top" forKey:@"domain"];
    [jsonDict setObject:[AccountModel getCusIdOfUser] forKey:@"cus_id"];
    [jsonDict setObject:[NSNumber numberWithInt: 1] forKey:@"type"];
    [webService callWebServiceWithLink:whois_func withParams:jsonDict];
    
    [webService callWebServiceWithLink:@"" withParams:jsonDict];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - Webservice delegate

- (void)failedToCallWebService:(NSString *)link andError:(NSString *)error {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] link: %@.\n Error: %@", __FUNCTION__, link, error] toFilePath:[AppDelegate sharedInstance].logFilePath];
    [ProgressHUD dismiss];
}

- (void)successfulToCallWebService:(NSString *)link withData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] link: %@.\n Response data: %@", __FUNCTION__, link, @[data]] toFilePath:[AppDelegate sharedInstance].logFilePath];
    [ProgressHUD dismiss];
}

- (void)receivedResponeCode:(NSString *)link withCode:(int)responeCode {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] -----> function = %@ & responeCode = %d", __FUNCTION__, link, responeCode] toFilePath:[AppDelegate sharedInstance].logFilePath];
    [ProgressHUD dismiss];
}

@end
