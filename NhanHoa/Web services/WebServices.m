//
//  WebServices.m
//  linphone
//
//  Created by admin on 6/6/18.
//

#import "WebServices.h"
#import "JSONKit.h"

@implementation WebServices
@synthesize delegate, receivedData;

- (void)callWebServiceWithLink: (NSString *)linkService withParams: (NSDictionary *)paramsDict
{
    receivedData = [[NSMutableData alloc] init];
    
    NSString *strURL = [NSString stringWithFormat:@"%@/%@", link_api, linkService];
    NSURL *URL = [NSURL URLWithString:strURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: URL];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setTimeoutInterval: 60];
    
    NSString *jsonRequest = [paramsDict JSONString];
    NSData *requestData = [jsonRequest dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setValue:[NSString stringWithFormat:@"%d", (int)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(connection) {
        NSLog(@"Connection Successful");
    }else {
        [delegate failedToCallWebService:strURL andError:@""];
    }
}

- (void)callGETWebServiceWithFunction: (NSString *)function andParams: (NSString *)params
{
    receivedData = [[NSMutableData alloc] init];
    
    NSString *strURL = [NSString stringWithFormat:@"%@/%@?%@", link_api, function, params];
    NSURL *URL = [NSURL URLWithString:strURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: URL];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setTimeoutInterval: 60];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"hash"];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(connection) {
        NSLog(@"Connection Successful");
    }else {
        [delegate failedToCallWebService:strURL andError:@""];
    }
}

- (void)callWebServiceWithLink: (NSString *)linkService withParams: (NSDictionary *)paramsDict inBackgroundMode: (BOOL)isBackgroundMode
{
    receivedData = [[NSMutableData alloc] init];
    
    NSString *strURL = [NSString stringWithFormat:@"%@/%@", link_api, linkService];
    NSURL *URL = [NSURL URLWithString:strURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: URL];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setTimeoutInterval: 60];
    
    NSString *jsonRequest = [paramsDict JSONString];
    NSData *requestData = [jsonRequest dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setValue:[NSString stringWithFormat:@"%d", (int)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        // whatever you do on the connectionDidFinishLoading
        // delegate can be moved here
        if (error != nil) {
            [self.delegate failedToCallWebService:strURL andError:@""];
        }else{
            NSString *value = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            id object = [value objectFromJSONString];
            if ([object isKindOfClass:[NSDictionary class]]) {
                NSString *result = [object objectForKey:@"result"];
                if (![result isKindOfClass:[NSNull class]] && result != nil)
                {
                    if ([result isEqualToString:@"failure"] || [result isEqualToString:@"failed"]) {
                        NSString *message = [object objectForKey:@"message"];
                        [self.delegate failedToCallWebService:linkService andError:message];
                    }else if([result isEqualToString:@"success"])
                    {
                        id data = [object objectForKey:@"data"];
                        if ([data isKindOfClass:[NSDictionary class]]) {
                            [self.delegate successfulToCallWebService:linkService withData:data];
                        }else{
                            if (data == nil && [object isKindOfClass:[NSDictionary class]]) {
                                [self.delegate successfulToCallWebService:linkService withData:object];
                            }else{
                                [self.delegate successfulToCallWebService:linkService withData:data];
                            }
                        }
                    }
                }else{
                    
                }
            }
        }
    }];
}

// This method is used to receive the data which we get using post method.
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data {
    [receivedData appendData: data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //  NSString *strURL = [[[connection currentRequest] URL] absoluteString];
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    NSString *function = [self getFunctionFromRequestURL:[[connection currentRequest] URL]];
    [delegate receivedResponeCode:function withCode:(int)[httpResponse statusCode]];
}

// This method receives the error report in case of connection is not made to server.
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSURL *requestURL = [[connection currentRequest] URL];
    NSString *function = [self getFunctionFromRequestURL:requestURL];
    
    NSString *strError = [error.userInfo objectForKey:@"NSLocalizedDescription"];
    [delegate failedToCallWebService:function andError:strError];
}

// This method is used to process the data after connection has made successfully.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *value = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    receivedData = nil;
    id object = [value objectFromJSONString];
    if ([object isKindOfClass:[NSDictionary class]]) {
        id result = [object objectForKey:@"success"];
        if (![result isKindOfClass:[NSNull class]] && result != nil)
        {
            NSURL *requestURL = [[connection currentRequest] URL];
            NSString *urlPath = requestURL.path;
            if ([urlPath hasSuffix:@"/"]) {
                urlPath = [urlPath stringByReplacingOccurrencesOfString:@"/" withString:@""];
            }
            
            NSString *function = @"";
            if (![AppUtils isNullOrEmpty: urlPath]) {
                NSArray *tmpArr = [urlPath componentsSeparatedByString:@"/"];
                if (tmpArr != nil) {
                    function = (NSString *)[tmpArr lastObject];
                    
                    if ([result boolValue] == NO || [result intValue] == 0) {
                        id data = [object objectForKey:@"data"];
                        if ([data isKindOfClass:[NSString class]]) {
                            [delegate failedToCallWebService:function andError:data];
                            
                        }else if ([data isKindOfClass:[NSDictionary class]]){
                            [delegate failedToCallWebService:function andError:data];
                        }
                        
                    }else {
                        id data = [object objectForKey:@"data"];
                        if ([data isKindOfClass:[NSDictionary class]]) {
                            [delegate successfulToCallWebService:function withData:data];
                        }else{
                            if (data == nil && [object isKindOfClass:[NSDictionary class]]) {
                                [delegate successfulToCallWebService:function withData:object];
                            }else{
                                [delegate successfulToCallWebService:function withData:data];
                            }
                        }
                    }
                }else{
                    [delegate failedToCallWebService:function andError:@"Unknown error"];
                }
            }else{
                NSString *strURL = [requestURL absoluteString];
                [delegate failedToCallWebService:strURL andError:result];
            }
        }else{
            NSURL *requestURL = [[connection currentRequest] URL];
            NSString *function = [self getFunctionFromRequestURL: requestURL];
            if (![AppUtils isNullOrEmpty: function]) {
                if ([function isEqualToString: whois_func]) {
                    [delegate successfulToCallWebService:function withData:object];
                }else{
                    [delegate failedToCallWebService:function andError:result];
                }
            }
            [delegate failedToCallWebService:function andError:result];
        }
    }
}

- (NSString *)getFunctionFromRequestURL: (NSURL *)requestURL {
    NSString *urlPath = requestURL.path;
    if ([urlPath hasSuffix:@"/"]) {
        urlPath = [urlPath stringByReplacingOccurrencesOfString:@"/" withString:@""];
    }
    
    NSString *function = @"";
    if (![AppUtils isNullOrEmpty: urlPath]) {
        NSArray *tmpArr = [urlPath componentsSeparatedByString:@"/"];
        if (tmpArr != nil) {
            function = (NSString *)[tmpArr lastObject];
            return function;
        }
    }
    return @"";
}

@end
