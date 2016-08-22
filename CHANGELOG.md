# Changelog

## HEAD

## 0.6.1 (2016-08-21)

* [FIX] `ManagedStruct.release` actually calls `*_free` functions. Autorelease
  invocations were silently failing with a `TypeError` because the functions
  expected structs, not pointers.

## 0.6.0 (2016-07-11)

* [FIX] Use the correct default filename when a `CameraFile` is a preview.
* [ADD] Add `CameraFileInfo` and related operations. `CameraFile#info` only
  supports files.
* [FIX] `CameraWidget#label` calls the correct widget label function.
* [FIX] `Camera#[]=` raises an `ArgumentError` when passed an invalid key
  instead of failing on `nil`.
* [ADD] Add `CameraAbilities#operations` to always return an `Integer`.
  libgphoto2 does not stay in the defined enum set of `CameraOperations`;
  therefore, it is treated as an integer bit field instead.
* [CHANGE] Errors are thrown as `GPhoto2::Error` rather than `RuntimeError`.
  Use `#message` and `#code` to extract the the GPhoto2 error message and
  return code, respectively.
* [ADD] `Camera#trigger` for trigger capture.
* [FIX] `TextCameraWidget` values can by any object that implements `#to_s`.
