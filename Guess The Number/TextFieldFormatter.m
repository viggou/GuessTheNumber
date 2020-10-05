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
    
    NSString *firstChar = [partialString substringToIndex:1];
    
    if ([partialString length] > 1 && [firstChar isEqualToString:@"-"]) {
        stringFromSecondChar = [partialString substringFromIndex:1];
    }
    else {
        stringFromSecondChar = partialString;
    }
    
    NSScanner *scanner = [NSScanner scannerWithString:stringFromSecondChar];
    
    if ([partialString length] == 1 && [firstChar isEqualToString:@"-"]) {
        return YES;
    }
    else if ([partialString length] >= 1 && [stringFromSecondChar containsString:@"-"]) {
        return NO;
    }
    
    if ([firstChar isEqualToString:@"-"]) {
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
