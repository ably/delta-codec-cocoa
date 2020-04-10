Pod::Spec.new do |s|
  s.name              = 'AblyDeltaCodec'
  s.version           = '1.2.0'
  s.summary           = 'Cocoa VCDiff decoder'
  s.homepage          = 'https://ably.io'
  s.author            = { "Ably" => "support@ably.io" }
  s.license           = 'MIT'
  s.social_media_url  = 'https://twitter.com/ablyrealtime'
  s.description       = <<-DESC
                        Cocoa VCDiff decoder. Uses Xdelta version 3, a C library for delta compression using VCDIFF/RFC 3284 streams.
                        DESC
  s.source            = { :git => "https://github.com/ably/delta-codec-cocoa.git", :tag => s.version.to_s, :submodules => true }
  s.ios.deployment_target = '8.0'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '4.0'
  s.osx.deployment_target = '10.10'
  s.requires_arc      = true
  s.source_files      = 'DeltaCodec/*.{h}', 'source/*.{h,hh,m,mm}', 'xdelta/xdelta3/xdelta3.c', 'xdelta/xdelta3/xdelta3.h', 'xdelta/xdelta3/xdelta3-blkcache.h', 'xdelta/xdelta3/xdelta3-cfgs.h', 'xdelta/xdelta3/xdelta3-decode.h', 'xdelta/xdelta3/xdelta3-djw.h', 'xdelta/xdelta3/xdelta3-fgk.h', 'xdelta/xdelta3/xdelta3-hash.h', 'xdelta/xdelta3/xdelta3-internal.h', 'xdelta/xdelta3/xdelta3-list.h', 'xdelta/xdelta3/xdelta3-lzma.h', 'xdelta/xdelta3/xdelta3-main.h', 'xdelta/xdelta3/xdelta3-merge.h', 'xdelta/xdelta3/xdelta3-second.h'
  s.public_header_files = 'DeltaCodec/*.{h}', 'source/ARTDeltaCodec.h'
  s.private_header_files = 'source/config.h', 'xdelta/xdelta3/xdelta3.h', 'xdelta/xdelta3/xdelta3-blkcache.h', 'xdelta/xdelta3/xdelta3-cfgs.h', 'xdelta/xdelta3/xdelta3-decode.h', 'xdelta/xdelta3/xdelta3-djw.h', 'xdelta/xdelta3/xdelta3-fgk.h', 'xdelta/xdelta3/xdelta3-hash.h', 'xdelta/xdelta3/xdelta3-internal.h', 'xdelta/xdelta3/xdelta3-list.h', 'xdelta/xdelta3/xdelta3-lzma.h', 'xdelta/xdelta3/xdelta3-main.h', 'xdelta/xdelta3/xdelta3-merge.h', 'xdelta/xdelta3/xdelta3-second.h'
  s.xcconfig = {
    "GCC_PREPROCESSOR_DEFINITIONS" => 'HAVE_CONFIG_H=1'
  }
end
