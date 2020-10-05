//
//  TextFieldFormatter.m
//  Guess The Number
//
//  Created by Viggo Lekdorf on 04/10/2020.
//

#import "TextFieldFormatter.h"

@implementation TextFieldFormatter

- (BOOL)isPartialStringValid:(NSString *)partialString newEditingString:(NSString **)newString errorDescription:(NSString **)error {
    if ([partialString length] == 0) {
        return YES;
    }
    
    NSScanner *scanner = [NSScanner scannerWithString:partialString];
    
    if (!([scanner scanInt:0] && [scanner isAtEnd])) {
        return NO;
    }
    
    return YES;
}

@end
