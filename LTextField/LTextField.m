//
//  LTextField.m
//  LTextField
//
//  Created by leo on 5/27/14.
//  Copyright (c) 2014 leo. All rights reserved.
//

#import "LTextField.h"

@interface LTextField()<UITextFieldDelegate>

@property (nonatomic)  UITextField * textField;
@property (nonatomic, strong, readonly) CAShapeLayer * longLineBorder;
@property (nonatomic, strong, readonly) CAShapeLayer * shortLineBorder;
@property (nonatomic, strong, readonly) UIView * border;
@property (nonatomic, strong, readonly) CATextLayer * holderLayer;

//@property CGFloat holderLength;
@property BOOL editing;

@end

@implementation LTextField

@dynamic text;

- (id)initWithFrame:(CGRect)frame andSelectedColor:(UIColor*)color
{
    self = [self initWithFrame:frame];
    if (self) {
        _selectedColor = color;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect bounds = self.bounds;
        _editing = NO;
        self.backgroundColor = [UIColor clearColor];
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(bounds.size.height*0.4, bounds.size.height*0.1, bounds.size.width - bounds.size.height*0.8, bounds.size.height*0.8)];
        _textField.font = [UIFont systemFontOfSize:bounds.size.height*0.3];
        _holderLayer = [[CATextLayer alloc] init];
        _selectedColor = [UIColor colorWithRed:97.0f/255.0f green:189.0f/255.0f blue:236.0f/255.0f alpha:1];
        _textField.delegate = self;
        _longLineBorder = [[CAShapeLayer alloc] init];
        _shortLineBorder = [[CAShapeLayer alloc] init];
        [self drawBorder];
        [self addSubview:_textField];
//        [self addSubview:_holderLabel];
        [self.layer addSublayer:_longLineBorder];
        [self.layer addSublayer:_shortLineBorder];
        [self.layer addSublayer:_holderLayer];
    }
    return self;
}

- (NSString *)text
{
    return  _textField.text;
}

- (void)setText:(NSString *)text
{
    [_textField setText:text];
}

- (void)setPlaceHolder:(NSString *)placeHolder
{
    CGRect bounds =  self.bounds;
    CGSize placeHolderSize = [placeHolder sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:bounds.size.height*0.25]}];
    [_holderLayer setContentsScale:[[UIScreen mainScreen] scale]];
    [_holderLayer setFrame:CGRectMake(bounds.size.height*0.4, bounds.size.height*0.375, placeHolderSize.width, bounds.size.height*0.25)];
    [_holderLayer setString:placeHolder];
    [_holderLayer setFont:CFBridgingRetain([UIFont systemFontOfSize:bounds.size.height*0.23].fontName)];
    [_holderLayer setFontSize:bounds.size.height*0.23];
    [_holderLayer setAlignmentMode:kCAAlignmentCenter];
    [_holderLayer setForegroundColor:[UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1].CGColor];
    [_holderLayer setBorderColor:[UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1].CGColor];
    
//    _holderLabel.frame = CGRectMake(bounds.size.height*0.4, bounds.size.height*0.375, placeHolderSize.width, bounds.size.height*0.25);
//    _holderLabel.text = placeHolder;
//    _holderLabel.font = [UIFont systemFontOfSize:bounds.size.height*0.23];
//    _holderLabel.textAlignment = NSTextAlignmentCenter;
//    _holderLabel.textColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1];
    
    [self drawBorder];
    
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (_editing) {
        CGContextSetStrokeColorWithColor(context, _selectedColor.CGColor);
        [self drawBorderWithContext:context];
    } else {
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1].CGColor);
        [self drawBorderWithContext:context];
    }
}


- (void)drawBorderWithContext:(CGContextRef)context
{
//    CGRect bounds = self.bounds;
//
//    CGContextSetLineWidth(context, 2.0);
//    CGContextAddArc(context, bounds.size.height*0.4 + 1, bounds.size.height*0.5, bounds.size.height*0.4, M_PI/2, 3*M_PI/2, 0);
//    CGContextStrokePath(context);
//    CGContextAddArc(context, bounds.size.width - bounds.size.height*0.4 - 1, bounds.size.height*0.5, bounds.size.height*0.4, M_PI/2, 3*M_PI/2, 1);
//    CGContextStrokePath(context);
//    
//    if (_textField.text.length != 0 || _editing) {
//        CGContextMoveToPoint(context, bounds.size.height*0.4 + _holderLabel.bounds.size.width, bounds.size.height*0.1);
//        CGContextAddLineToPoint(context, bounds.size.width - bounds.size.height*0.4, bounds.size.height*0.1);
//        CGContextStrokePath(context);
//    } else {
//        CGContextMoveToPoint(context, bounds.size.height*0.4, bounds.size.height*0.1);
//        CGContextAddLineToPoint(context, bounds.size.width - bounds.size.height*0.4, bounds.size.height*0.1);
//        CGContextStrokePath(context);
//    }
//    
//    CGContextMoveToPoint(context, bounds.size.height*0.4, bounds.size.height*0.9);
//    CGContextAddLineToPoint(context, bounds.size.width - bounds.size.height*0.4, bounds.size.height*0.9);
//    CGContextStrokePath(context);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_textField resignFirstResponder];
}

- (void)drawBorder
{
    CGRect bounds = self.bounds;
    
    UIBezierPath * longPath = [[UIBezierPath alloc] init];
    [longPath moveToPoint:CGPointMake(bounds.size.height*0.4 + _holderLayer.bounds.size.width, bounds.size.height*0.1)];
    [longPath addLineToPoint:CGPointMake(bounds.size.width - bounds.size.height*0.4, bounds.size.height*0.1)];
    [longPath addArcWithCenter:CGPointMake(bounds.size.width - bounds.size.height*0.4 - 1, bounds.size.height*0.5) radius:bounds.size.height*0.4 startAngle:3*M_PI/2 endAngle:M_PI/2 clockwise:1];
    [longPath addArcWithCenter:CGPointMake(bounds.size.height*0.4 + 1, bounds.size.height*0.5) radius:bounds.size.height*0.4 startAngle:M_PI/2 endAngle:3*M_PI/2 clockwise:1];
    
    _longLineBorder.frame = self.bounds;
    _longLineBorder.path = longPath.CGPath;
    _longLineBorder.strokeColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1].CGColor;
    _longLineBorder.fillColor = nil;
    _longLineBorder.lineWidth = 1.5f;
    _longLineBorder.lineJoin = kCALineJoinRound;
    
    UIBezierPath * shortPath = [[UIBezierPath alloc] init];
    [shortPath moveToPoint:CGPointMake(bounds.size.height*0.4, bounds.size.height*0.1)];
    [shortPath addLineToPoint:CGPointMake(bounds.size.height*0.4 + _holderLayer.bounds.size.width, bounds.size.height*0.1)];
    [shortPath closePath];
    
    _shortLineBorder.frame = self.bounds;
    _shortLineBorder.path = shortPath.CGPath;
    _shortLineBorder.strokeColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1].CGColor;
    _shortLineBorder.fillColor = nil;
    _shortLineBorder.lineWidth = 1.5f;
    _shortLineBorder.lineJoin = kCALineJoinRound;
}


#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CABasicAnimation * longLineAnimation = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
    longLineAnimation.duration = 0.4;
    longLineAnimation.fromValue = (__bridge id) [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1].CGColor;
    longLineAnimation.toValue = (__bridge id) _selectedColor.CGColor;
    longLineAnimation.removedOnCompletion = NO;
    longLineAnimation.fillMode = kCAFillModeForwards;
    [_longLineBorder addAnimation:longLineAnimation forKey:@"strokeColor"];
    
    if (_textField.text.length == 0) {
        CABasicAnimation * shortLineAnimation = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
        shortLineAnimation.duration = 0.2;
        shortLineAnimation.fromValue = (__bridge id) [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1].CGColor;
        shortLineAnimation.toValue = (__bridge id) [UIColor clearColor].CGColor;
        shortLineAnimation.removedOnCompletion = NO;
        shortLineAnimation.fillMode = kCAFillModeForwards;
        [_shortLineBorder addAnimation:shortLineAnimation forKey:@"strokeColor"];
    }
    
//    CABasicAnimation * holderColorAnimation = [CABasicAnimation animationWithKeyPath:@"foregroundColor"];
//    holderColorAnimation.duration = 0.4;
//    holderColorAnimation.fillMode = kCAFillModeForwards;
//    holderColorAnimation.removedOnCompletion = NO;
//    holderColorAnimation.fromValue = (__bridge id) [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1].CGColor;
//    holderColorAnimation.toValue = (__bridge id) _selectedColor.CGColor;
//    [_holderLayer addAnimation:holderColorAnimation forKey:@"foregroundColor"];
//    
//    CGPoint point = _holderLayer.frame.origin;
    
//    CABasicAnimation * holderPositionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
//    holderPositionAnimation.duration = 0.4;
//    holderPositionAnimation.fillMode = kCAFillModeForwards;
//    holderPositionAnimation.removedOnCompletion = NO;
//    holderPositionAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(point.x, point.y)];
//    holderPositionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(point.x, 0)];
//    [_holderLayer addAnimation:holderPositionAnimation forKey:@"position"];
    
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _holderLayer.foregroundColor = _selectedColor.CGColor;
        CGRect frame = _holderLayer.frame;
        frame.origin.y = -3;
        _holderLayer.frame = frame;
//        _holderLabel.textColor = _selectedColor;
//        CGRect frame = _holderLabel.frame;
//        frame.origin.y = 0;
//        _holderLabel.frame = frame;
   } completion:NULL];
    if ([_delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [_delegate textFieldDidBeginEditing:self];
    }

}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CABasicAnimation * longLineAnimation = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
    longLineAnimation.duration = 0.4;
    longLineAnimation.toValue = (__bridge id) [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1].CGColor;
    longLineAnimation.fromValue = (__bridge id) _selectedColor.CGColor;
    longLineAnimation.removedOnCompletion = NO;
    longLineAnimation.fillMode = kCAFillModeForwards;
    [_longLineBorder addAnimation:longLineAnimation forKey:@"strokeColor"];
    
    
    if (textField.text.length == 0) {
        
        CABasicAnimation * shortLineAnimation = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
        
        shortLineAnimation = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
        shortLineAnimation.duration = 0.4;
        shortLineAnimation.toValue = (__bridge id) [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1].CGColor;
        shortLineAnimation.fromValue = (__bridge id) [UIColor clearColor].CGColor;
        shortLineAnimation.removedOnCompletion = NO;
        shortLineAnimation.fillMode = kCAFillModeForwards;
        [_shortLineBorder addAnimation:shortLineAnimation forKey:@"strokeColor"];
        
//        CABasicAnimation * holderColorAnimation = [CABasicAnimation animationWithKeyPath:@"foregroundColor"];
//        holderColorAnimation.duration = 0.4;
//        holderColorAnimation.fillMode = kCAFillModeForwards;
//        holderColorAnimation.removedOnCompletion = NO;
//        holderColorAnimation.toValue = (__bridge id) [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1].CGColor;
//        holderColorAnimation.fromValue = (__bridge id) _selectedColor.CGColor;
//        [_holderLayer addAnimation:holderColorAnimation forKey:@"foreGroundColor"];
//        
//        CGPoint point = _holderLayer.frame.origin;
//        
//        CABasicAnimation * holderPositionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
//        holderPositionAnimation.duration = 0.4;
//        holderPositionAnimation.fillMode = kCAFillModeForwards;
//        holderPositionAnimation.removedOnCompletion = NO;
//        holderPositionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(point.x, point.y)];
//        holderPositionAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(point.x, 0)];
//        [_holderLayer addAnimation:holderPositionAnimation forKey:@"position"];
        [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _holderLayer.foregroundColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1].CGColor;
            CGRect frame = _holderLayer.frame;
            frame.origin.y = self.bounds.size.height*0.375;
            _holderLayer.frame = frame;
        } completion:NULL];
    } else {
//        CABasicAnimation * holderColorAnimation = [CABasicAnimation animationWithKeyPath:@"foregroundColor"];
//        holderColorAnimation.duration = 0.4;
//        holderColorAnimation.fillMode = kCAFillModeForwards;
//        holderColorAnimation.removedOnCompletion = NO;
//        holderColorAnimation.toValue = (__bridge id) [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1].CGColor;
//        holderColorAnimation.fromValue = (__bridge id) _selectedColor.CGColor;
//        [_holderLayer addAnimation:holderColorAnimation forKey:@"foreGroundColor"];
        [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _holderLayer.foregroundColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1].CGColor;
        } completion:NULL];
    }
    if ([_delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [_delegate textFieldDidEndEditing:self];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [_delegate textFieldShouldBeginEditing:self];
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [_delegate textFieldShouldEndEditing:self];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([_delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [_delegate textField:self shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [_delegate textFieldShouldClear:self];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [_delegate textFieldShouldReturn:self];
    }
    return YES;
}

@end
