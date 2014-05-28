//
//  LTextField.h
//  LTextField
//
//  Created by leo on 5/27/14.
//  Copyright (c) 2014 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LTextFieldDelegate;

@interface LTextField : UIView

@property (copy, nonatomic) NSString * text;
@property (copy, nonatomic) NSString * placeHolder;
@property (copy, nonatomic) UIColor * selectedColor;
@property (assign, nonatomic) id<LTextFieldDelegate> delegate;

@end

@protocol LTextFieldDelegate <NSObject>

@optional

- (BOOL)textFieldShouldBeginEditing:(LTextField *)textField;        // return NO to disallow editing.
- (void)textFieldDidBeginEditing:(LTextField *)textField;           // became first responder
- (BOOL)textFieldShouldEndEditing:(LTextField *)textField;          // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)textFieldDidEndEditing:(LTextField *)textField;             // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

- (BOOL)textField:(LTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text

- (BOOL)textFieldShouldClear:(LTextField *)textField;               // called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(LTextField *)textField;              // called when 'return' key pressed. return NO to ignore.

@end
