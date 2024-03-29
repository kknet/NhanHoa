//
//  UploadPicture.m
//  linphone
//
//  Created by admin on 12/9/17.
//

#import "UploadPicture.h"

@implementation UploadPicture

- (instancetype)init
{
    self = [super init];
    if (self) {
        _responseData = [[NSMutableData alloc] init];
    }
    return self;
}

- (void)uploadData:(NSData *)data withName: (NSString *)imageName beginUploadBlock:(void(^)(UploadPicture *uploadSession))beginBlock finishUploadBlock:(void(^)(UploadPicture *uploadSession))finishBlock
{
    beginUploadBlock = beginBlock;
    finishUploadBlock = finishBlock;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        //  CFRunLoopWakeUp(CFRunLoopGetCurrent());
        NSString *urlString = SFM(@"%@/ios_upload_file.php", link_upload_photo);
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:urlString]];
        [request setHTTPMethod:@"POST"];
        
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        NSString *contentType = SFM(@"multipart/form-data; boundary=%@", boundary);
        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
        
        NSMutableData *body = [NSMutableData data];
        if (data != nil) {
            [body appendData:[SFM(@"--%@\r\n", boundary) dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[SFM(@"Content-Disposition: form-data; name=\"uploadedfile\"; filename=\"%@\"\r\n", imageName) dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:data];
            [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
        // we close the body with one last boundary
        [body appendData:[SFM(@"--%@--\r\n", boundary) dataUsingEncoding:NSUTF8StringEncoding]];
        // assigning the completed NSMutableData buffer as the body of the HTTP POST request
        [request setHTTPBody:body];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
            if (data){
                //do something with data
                NSString *value = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                self.namePicture = value;
                self->finishUploadBlock(self);
            }else if (error){
                self.uploadError = error;
                self->finishUploadBlock(self);
            }
        }];
        
        if (self->beginUploadBlock) {
            self->beginUploadBlock(self);
        }
    });
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"NgnUploadSession - Finish upload");
    id json = [NSJSONSerialization JSONObjectWithData:_responseData options:0 error:nil];
    NSLog(@"%@", json);
    finishUploadBlock(self);
}

@end
