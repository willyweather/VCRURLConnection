//
// VCRResponse.m
//
// Copyright (c) 2012 Dustin Barker
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "VCRResponse.h"

@interface VCRResponse ()

@property (nonatomic, retain, readwrite) NSDictionary *headerFields;

@end

@implementation VCRResponse

- (id)initWithJSON:(id)json {
    if ((self = [self init])) {
        self.url = [NSURL URLWithString:[json objectForKey:@"url"]];
        self.statusCode = [[json objectForKey:@"statusCode"] intValue];
        self.responseData = [[json objectForKey:@"body"] dataUsingEncoding:NSUTF8StringEncoding];
        self.headerFields = [json objectForKey:@"headers"];
        if (!self.headerFields) {
            self.headerFields = [NSDictionary dictionary];
        }
    }
    return self;
}

- (BOOL)isEqual:(VCRResponse *)response {
    return [self.url isEqual:response.url] && [self.responseData isEqual:response.responseData];
}

- (void)recordHTTPURLResponse:(NSHTTPURLResponse *)response {
    self.url = response.URL;
    self.headerFields = [response allHeaderFields];
    self.statusCode = response.statusCode;
}

- (NSHTTPURLResponse *)generateHTTPURLResponse {
    return [[[NSHTTPURLResponse alloc] initWithURL:self.url
                                        statusCode:self.statusCode
                                       HTTPVersion:@"HTTP/1.1"         // FIXME: don't hardcode, but make default
                                      headerFields:self.headerFields] autorelease];
}

- (void)dealloc {
    self.url = nil;
    self.headerFields = nil;
    [super dealloc];
}

@end
