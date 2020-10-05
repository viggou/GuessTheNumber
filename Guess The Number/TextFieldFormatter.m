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
    
    NSString *stringFromSecondChar;
    
    NSString *firstChar;
    
    if ([partialString length] > 1) {
        stringFromSecondChar = [partialString substringFromIndex:1];
    }
    else {
        stringFromSecondChar = partialString;
    }
    
    NSScanner *scanner = [NSScanner scannerWithString:stringFromSecondChar];
    
    firstChar = [partialString substringToIndex:1];
    
    if ([partialString length] == 1 && [firstChar containsString:@"-"]) {
        return YES;
    }
    
    if ([partialString containsString:@"-"]) {
        if (!([scanner scanInt:0] && [scanner isAtEnd])) {
            return NO;
        }
        else {
            return YES;
        }
    }
    
    if (!([scanner scanInt:0] && [scanner isAtEnd])) {
        return NO;
    }
    
    return YES;
}

@end
