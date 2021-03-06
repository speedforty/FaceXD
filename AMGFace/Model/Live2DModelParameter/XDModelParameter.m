//
//  XDModelParameter.m
//  AMGFace
//
//  Created by CmST0us on 2020/3/16.
//  Copyright © 2020 hakura. All rights reserved.
//

#import "XDModelParameter.h"
#import "UIDevice+UUID.h"

@implementation XDModelParameter

- (id)copyWithZone:(nullable NSZone *)zone {
    XDModelParameter *copyParameter = [[XDModelParameter allocWithZone:zone] init];
    copyParameter.headPitch = [self.headPitch copy];
    copyParameter.headYaw = [self.headYaw copy];
    copyParameter.headRoll = [self.headRoll copy];
    copyParameter.bodyAngleX = [self.bodyAngleX copy];
    copyParameter.bodyAngleY = [self.bodyAngleY copy];
    copyParameter.bodyAngleZ = [self.bodyAngleZ copy];
    copyParameter.eyeLOpen = [self.eyeLOpen copy];
    copyParameter.eyeROpen = [self.eyeROpen copy];
    copyParameter.eyeLSmile = [self.eyeLSmile copy];
    copyParameter.eyeRSmile = [self.eyeRSmile copy];
    copyParameter.eyeBrowYL = [self.eyeBrowYL copy];
    copyParameter.eyeBrowYR = [self.eyeBrowYR copy];
    copyParameter.eyeBrowLForm = [self.eyeBrowLForm copy];
    copyParameter.eyeBrowRForm = [self.eyeBrowRForm copy];
    copyParameter.eyeBrowAngleL = [self.eyeBrowAngleL copy];
    copyParameter.eyeBrowAngleR = [self.eyeBrowAngleR copy];
    copyParameter.eyeX = [self.eyeX copy];
    copyParameter.eyeY = [self.eyeY copy];
    copyParameter.mouthOpenY = [self.mouthOpenY copy];
    copyParameter.mouthForm = [self.mouthForm copy];
    copyParameter.mouthU = [self.mouthU copy];
    copyParameter.blendShapes = [self.blendShapes copy];
    copyParameter.isTracked = [self.isTracked copy];
    copyParameter.transforms = [self.transforms copy];
    return copyParameter;
}

- (NSDictionary *)parameterValueDictionary {
    return @{
        @"headPitch"       : [NSString stringWithFormat: @"%.3lf", self.headPitch.floatValue],
        @"headYaw"         : [NSString stringWithFormat: @"%.3lf", self.headYaw.floatValue],
        @"headRoll"        : [NSString stringWithFormat: @"%.3lf", self.headRoll.floatValue],
        @"bodyAngleX"      : [NSString stringWithFormat: @"%.3lf", self.bodyAngleX.floatValue],
        @"bodyAngleY"      : [NSString stringWithFormat: @"%.3lf", self.bodyAngleY.floatValue],
        @"bodyAngleZ"      : [NSString stringWithFormat: @"%.3lf", self.bodyAngleZ.floatValue],
        @"eyeLOpen"        : [NSString stringWithFormat: @"%.3lf", self.eyeLOpen.floatValue],
        @"eyeROpen"        : [NSString stringWithFormat: @"%.3lf", self.eyeROpen.floatValue],
        @"eyeLSmile"        : [NSString stringWithFormat: @"%.3lf", self.eyeLSmile.floatValue],
        @"eyeRSmile"        : [NSString stringWithFormat: @"%.3lf", self.eyeRSmile.floatValue],
        @"eyeBrowYL"       : [NSString stringWithFormat: @"%.3lf", self.eyeBrowYL.floatValue],
        @"eyeBrowYR"       : [NSString stringWithFormat: @"%.3lf", self.eyeBrowYR.floatValue],
        @"eyeBrowLForm"    : [NSString stringWithFormat: @"%.3lf", self.eyeBrowLForm.floatValue],
        @"eyeBrowRForm"    : [NSString stringWithFormat: @"%.3lf", self.eyeBrowRForm.floatValue],
        @"eyeBrowAngleL"   : [NSString stringWithFormat: @"%.3lf", self.eyeBrowAngleL.floatValue],
        @"eyeBrowAngleR"   : [NSString stringWithFormat: @"%.3lf", self.eyeBrowAngleR.floatValue],
        @"eyeX"            : [NSString stringWithFormat: @"%.3lf", self.eyeX.floatValue],
        @"eyeY"            : [NSString stringWithFormat: @"%.3lf", self.eyeY.floatValue],
        @"mouthOpenY"      : [NSString stringWithFormat: @"%.3lf", self.mouthOpenY.floatValue],
        @"mouthForm"       : [NSString stringWithFormat: @"%.3lf", self.mouthForm.floatValue],
        @"mouthU"          : [NSString stringWithFormat: @"%.3lf", self.mouthU.floatValue],
        @"blendShapes"     : self.blendShapes == nil ? @{} : self.blendShapes,
        @"isTracked"       : self.isTracked == nil ? @(YES) : self.isTracked,
        @"uuid"            : [UIDevice UUID],
        @"transforms"      : self.transforms == nil ? @{} : self.transforms,
    };
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@", self.parameterValueDictionary];
}
@end
