//
//  ARTCodec.h
//  AblyCodec
//
//  Created by Ricardo Pereira on 05/09/2019.
//  Copyright © 2019 Ably. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const ARTDeltaCodecErrorDomain;

/**
 The list of all client error codes returned under the error domain ARTAblyErrorDomain
 */
typedef CF_ENUM(NSUInteger, ARTDeltaCodecCodeError) {
    ARTDeltaCodecCodeErrorInternalFailure,
    ARTDeltaCodecCodeErrorUninitializedDecoder,
    ARTDeltaCodecCodeErrorInvalidBaseId,
    ARTDeltaCodecCodeErrorBaseIdMismatch,
    ARTDeltaCodecCodeErrorInvalidDeltaId,
    ARTDeltaCodecCodeErrorInvalidBaseData,
    ARTDeltaCodecCodeErrorInvalidDeltaData
};

@interface ARTDeltaCodec : NSObject

@property (nullable, readonly, copy) NSData *base;
@property (nullable, readonly) NSString *baseId;

/**
 Check if the delta data is a valid VCDiff/RFC3284 stream.
 */
+ (BOOL)isDelta:(NSData *)delta;

/**
 Assign a base of the encoded target.
 */
- (void)setBase:(NSData *)base withId:(NSString *)baseId;

/**
 Decode data with a valid delta.
 */
- (nullable NSData *)applyDelta:(NSData *)delta deltaId:(NSString *)deltaId baseId:(NSString *)baseId error:(NSError *__autoreleasing _Nullable * _Nullable)error;

@end

NS_ASSUME_NONNULL_END
