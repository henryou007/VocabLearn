//
//  SpellingTestCharacter.m
//  VocabLearn
//
//  Created by Tienchai Wirojsaksaree on 11/16/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "SpellingTestCharacter.h"

@interface SpellingTestCharacter ()

@property (nonatomic, assign, readonly) NSUInteger ID;

@end

@implementation SpellingTestCharacter

+ (instancetype)characterWithCharacter:(unichar)character {
  return [[self alloc] initWithCharacter:character];
}

- (instancetype)initWithCharacter:(unichar)character {
  if (self = [super init]) {
    _ID = [self.class nextID];
    _character = toupper(character);
  }
  return self;
}

- (NSUInteger)hash {
  NSUInteger prime = 31;
  NSUInteger result = 1;
  result = prime * result + self.ID;
  return result;
}

- (BOOL)isEqual:(id)object {
  if (self == object) {
    return YES;
  }
  if (!object || ![object isKindOfClass:self.class]) {
    return NO;
  }
  return [self isEqualToCharacter:(SpellingTestCharacter *)object];
}

- (BOOL)isEqualToCharacter:(SpellingTestCharacter *)character {
  if (self.ID != character.ID) {
    return NO;
  }
  NSAssert([self isEqualToUnichar:character.character], @"The IDs are not unique!");
  return YES;
}

- (BOOL)isEqualToUnichar:(unichar)character {
  return self.character == toupper(character);
}

- (NSString *)description {
  return [NSString stringWithCharacters:&_character length:1];
}

+ (NSUInteger)nextID {
  static NSUInteger nextID;
  @synchronized(self) {
    return nextID++;
  }
}

@end
