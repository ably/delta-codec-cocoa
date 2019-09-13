# DeltaCodec

<a href="https://github.com/ably/ably-delta-codec-cocoa/actions">
  <img src="https://github.com/ably/ably-delta-codec-cocoa/workflows/Build/badge.svg" />
</a>

Cocoa **VCDiff decoder**.

Uses [Xdelta version 3](https://github.com/jmacd/xdelta), a C library for delta compression using VCDIFF/RFC 3284 streams.

```objc
@import DeltaCodec;

NSError *error;
ARTDeltaCodec *codec = [[ARTDeltaCodec alloc] init];
[codec setBase:baseData withId:@"m1"];
NSData *outputData = [codec applyDelta:deltaData deltaId:@"m2" baseId:@"m1" error:&error];
NSString *output = [[NSString alloc] initWithData:outputData encoding:NSUTF8StringEncoding];
```

## API (Objective-C)

### +(BOOL)isDelta:delta;

* `delta` NSData

Returns a `BOOL` telling if it's a valid delta or not.

`delta` is a binary encoded as **vcdiff**, as specified in [RFC 3284](https://tools.ietf.org/html/rfc3284).

### -(void)setBase:base withId:baseId;

* `base` NSData
* `baseId` NSString

Returns nothing.

`base` is the group of bytes to transform into the target. In delta encoding, this probably an old, cached version.

`baseId` is an identifier of the base.

### -(NSData *)applyDelta:delta deltaId:deltaId baseId:baseId error:error;

* `delta` NSData
* `deltaId` NSString
* `baseId ` NSString
* `error` NSError (optional)

Returns a `NSData` object of the target. It can return `nil`.

`delta` is the binary encoding of the information needed to transform the source to the target. It is encoded as vcdiff, as specified in [RFC 3284](https://tools.ietf.org/html/rfc3284).

`deltaId ` is an identifier of the delta.

`baseId ` is an identifier of the base used to verify if it matches with the current assigned base.

`error` is the error object when something goes wrong. It's nullable so it's optional.

The `delta` will be the new `base`.

## API (Swift)

TODO