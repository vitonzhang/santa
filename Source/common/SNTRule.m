/// Copyright 2015 Google Inc. All rights reserved.
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
///    http://www.apache.org/licenses/LICENSE-2.0
///
///    Unless required by applicable law or agreed to in writing, software
///    distributed under the License is distributed on an "AS IS" BASIS,
///    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
///    See the License for the specific language governing permissions and
///    limitations under the License.

#import "SNTRule.h"

@implementation SNTRule

- (instancetype)initWithShasum:(NSString *)shasum
                         state:(santa_rulestate_t)state
                          type:(santa_ruletype_t)type
                     customMsg:(NSString *)customMsg {
  self = [super init];
  if (self) {
    _shasum  = shasum;
    _state = state;
    _type = type;
    _customMsg = customMsg;
  }
  return self;
}

#pragma mark NSSecureCoding

#define ENCODE(obj, key) if (obj) [coder encodeObject:obj forKey:key]
#define DECODE(cls, key) [decoder decodeObjectOfClass:[cls class] forKey:key]
#define DECODEARRAY(cls, key) \
    [decoder decodeObjectOfClasses:[NSSet setWithObjects:[NSArray class], [cls class], nil] \
                            forKey:key]

+ (BOOL)supportsSecureCoding { return YES; }

- (void)encodeWithCoder:(NSCoder *)coder {
  ENCODE(self.shasum, @"shasum");
  ENCODE(@(self.state), @"state");
  ENCODE(@(self.type), @"type");
  ENCODE(self.customMsg, @"custommsg");
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
  self = [super init];
  if (self) {
    _shasum = DECODE(NSString, @"shasum");
    _state = [DECODE(NSNumber, @"state") intValue];
    _type = [DECODE(NSNumber, @"type") intValue];
    _customMsg = DECODE(NSString, @"custommsg");
  }
  return self;
}

@end
