//
//  ARTCodec.mm
//  AblyCodec
//
//  Created by Ricardo Pereira on 05/09/2019.
//  Copyright © 2019 Ably. All rights reserved.
//

#import "ARTCodec.h"

#import "xdelta3.h"

@implementation ARTCodec

- (void)test {
    NSString *base = @"fhgj fhgj input0 fhgj fhgj";
    NSData *baseData = [base dataUsingEncoding:NSUTF8StringEncoding];

    NSString *deltaBase64 = @"1sPEAAABGgALGgABAwIxHwIaABA=";
    NSData *deltaData = [[NSData alloc] initWithBase64EncodedString:deltaBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];

    NSString *expectedOutput = @"fhgj fhgj input1 fhgj fhgj";

    const uint8_t *base_buf = (const uint8_t *)baseData.bytes;
    usize_t base_size = baseData.length;
    const uint8_t *delta_buf = (const uint8_t *)deltaData.bytes;
    usize_t delta_size = deltaData.length;

    int result;
    // The output array must be large enough
    NSMutableData *outputData = [NSMutableData dataWithLength:sizeof(uint8_t) * 32 * 1024 * 1024];
    usize_t output_size = outputData.length;
    uint8_t *output_buf = (uint8_t *)outputData.mutableBytes;

    //int xd3_decode_memory(const uint8_t *inputOut, usize_t input_size, const uint8_t *source, usize_t source_size, uint8_t *output_buf, usize_t *output_size, usize_t avail_output, int flags)

    result = xd3_decode_memory(delta_buf, delta_size, base_buf, base_size, output_buf, &output_size, output_size, 0);

    switch (result) {
        case ENOSPC:
            NSLog(@"Output size is not large enough");
            return;
        case XD3_INVALID_INPUT:
            NSLog(@"ERROR %d invalid input/decoder error", result);
            return;
    }

    if (result) {
        NSLog(@"ERROR %d", result);
        return;
    }

    NSString *output = [[NSString alloc] initWithBytes:outputData.bytes length:output_size encoding:NSUTF8StringEncoding];

    NSLog(@"%@", output);
    NSLog(@"%lu", output_size);
    NSLog(@"%lu", (unsigned long)output.length);
    NSLog(@"%@", expectedOutput);
    NSLog(@"%lu", (unsigned long)expectedOutput.length);
    NSLog(@"%d", [expectedOutput isEqualToString:output]);
    NSLog(@"%d", [expectedOutput isEqual:output]);

    // Success:
    // hasVCDiffHeader?
    NSLog(@"%hhu", delta_buf[0]); //214 V
    NSLog(@"%d", delta_buf[0] == 214);
    NSLog(@"%hhu", delta_buf[1]); //195 C
    NSLog(@"%d", delta_buf[1] == 195);
    NSLog(@"%hhu", delta_buf[2]); //196 D
    NSLog(@"%d", delta_buf[2] == 196);
    NSLog(@"%hhu", delta_buf[3]); //0 \0
    NSLog(@"%d", delta_buf[3] == 0); //0 \0
}

@end
