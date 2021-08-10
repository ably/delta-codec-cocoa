# AblyDeltaCodec

<a href="https://github.com/ably/delta-codec-cocoa/actions">
  <img src="https://github.com/ably/delta-codec-cocoa/workflows/Build/badge.svg" />
</a>

Cocoa **VCDiff decoder**.

Uses [Xdelta version 3](https://github.com/ably-forks/xdelta/tree/xdelta-cocoa), a C library - forked by Ably - for delta compression using VCDIFF/[RFC 3284](https://tools.ietf.org/html/rfc3284) streams.

## Objective-C example

```objc
@import AblyDeltaCodec;

NSError *error;
ARTDeltaCodec *codec = [[ARTDeltaCodec alloc] init];
[codec setBase:baseData withId:@"m1"];
NSData *outputData = [codec applyDelta:deltaData deltaId:@"m2" baseId:@"m1" error:&error];

// Output data is an utf-8 string:
NSString *output = [[NSString alloc] initWithData:outputData encoding:NSUTF8StringEncoding];
```

## Swift example

```swift
import AblyDeltaCodec

let codec = ARTDeltaCodec()
codec.setBase(baseData, withId: "m1")

do {
    let outputData = try codec.applyDelta(deltaData, deltaId: "m2", baseId: "m1")
    // Output data is an utf-8 string:
    let output = String(data: outputData, encoding: .utf8)
}
catch {
    print(error)
}
```

# API Reference

- [class `isDelta`](#class-isdelta)
- [class `applyDelta`](#class-applydelta)
- [`setBase`](#setbase)
- [`applyDelta`](#applydelta)

## Stateless

### class isDelta

> ###### DECLARATION
>
> **Objective-C**
>
> +(BOOL)isDelta:delta;
>
> **Swift**
>
> class func isDelta(_ delta: Data) -> Bool

**Arguments**:

* `delta`: `NSData`/`Data` (is a binary encoded as **vcdiff**, as specified in RFC 3284.)

**Return Value**:

Returns a `BOOL`/`Boolean` telling if it's a valid delta or not.

### class applyDelta

> ###### DECLARATION
>
> **Objective-C**
>
> +(NSData *)applyDelta:current previous:previous error:error;
>
> **Swift**
>
> class func applyDelta(_ current: Data, previous: Data) -> Data (throws)

**Arguments**:

* `current`: `NSData`/`Data` (is the binary encoding of the information needed to transform the source to the target. It is encoded as vcdiff, as specified in RFC 3284.)
* `previous`: `NSData`/`Data` (is the group of bytes to transform into the target.)
* `error`: `NSError` (Objective-C only) (is the error object when something goes wrong. It's nullable so it's optional.)

**Return Value**:

Returns a `NSData`/`Data` object of the target. It can return `nil`.

## Stateful

### setBase

> ###### DECLARATION
>
> **Objective-C**
>
> -(void)setBase:base withId:baseId;
>
> **Swift**
>
> func setBase(_ base: Data, withId baseId: Data)

**Arguments**:

* `base`: `NSData`/`Data` (is the group of bytes to transform into the target. This is probably an old, cached version.)
* `baseId`: `NSString`/`String` (is an identifier of the base.)

**Return Value**:

Returns nothing.

### applyDelta

> ###### DECLARATION
>
> **Objective-C**
>
> -(NSData *)applyDelta:delta deltaId:deltaId baseId:baseId error:error;
>
> **Swift**
>
> func applyDelta(_ delta: Data, deltaId deltaId: String, baseId baseId: String) -> Data (throws)

**Arguments**:

* `delta`: `NSData`/`Data` (is the binary encoding of the information needed to transform the source to the target. It is encoded as vcdiff, as specified in RFC 3284.)
* `deltaId`: `NSString`/`String` (is an identifier of the delta.)
* `baseId `: `NSString`/`String` (is an identifier of the base used to verify if it matches with the current assigned base.)
* `error`: `NSError` (Objective-C only) (is the error object when something goes wrong. It's nullable so it's optional.)

**Return Value**:

Returns a `NSData` object of the target. It can return `nil`.

**Acknowledgments**:

The `delta` will be the new `base`.

