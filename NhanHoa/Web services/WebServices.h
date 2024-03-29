//
//  WebServices.h
//  linphone
//
//  Created by admin on 6/6/18.
//

#import <Foundation/Foundation.h>

@protocol WebServicesDelegate
- (void)failedToCallWebService:(NSString *)link andError:(id)error;
- (void)successfulToCallWebService: (NSString *)link withData: (NSDictionary *)data;
- (void)receivedResponeCode: (NSString *)link withCode: (int)responeCode;
@optional
- (void)receivedRecordAudioData: (NSData *)audioData;
- (void)dnsRecordResultWithData: (NSDictionary *)data action: (NSString *)action;
- (void)dnsRecordFailedWithData: (id)data action: (NSString *)action;

@end

@interface WebServices : NSObject
@property (retain) id <NSObject, WebServicesDelegate > delegate;
@property(nonatomic,retain) NSMutableData   *receivedData;

- (void)callWebServiceWithLink: (NSString *)linkService withParams: (NSDictionary *)paramsDict;
- (void)callWebServiceWithLink: (NSString *)linkService withParams: (NSDictionary *)paramsDict inBackgroundMode: (BOOL)isBackgroundMode;
- (void)callGETWebServiceWithFunction: (NSString *)function andParams: (NSString *)params;
- (void)apiWebServiceForCallWithParams: (NSDictionary *)paramsDict;
- (void)apiWSForRecordDNSWithParams: (NSDictionary *)paramsDict andAction: (NSString *)action;

@end


