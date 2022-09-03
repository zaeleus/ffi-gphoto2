# Changelog

## 0.10.0 (2022-09-02)

* [CHANGE] Mark `gp_camera_wait_for_event` as a blocking call ([#19]).

[#19]: https://github.com/zaeleus/ffi-gphoto2/pull/19

## 0.9.0 (2021-04-17)

* [CHANGE] Update to ffi 1.15.0. This raises the minimum Ruby version to 2.3.0.

## 0.8.0 (2020-06-29)

* [FIX] Fix deprecation warning (`warning: rb_safe_level will be removed in
  Ruby 3.0`) by updating to ffi 1.12.0.
* [CHANGE] Raise minimum Ruby version to 2.0.0, which comes from the dependency
  on ffi 1.12.0 (specifically 1.11.1).

## 0.7.1 (2017-01-02)

* [FIX] Load `ffi` before any usage of the bindings.

## 0.7.0 (2016-09-19)

* [CHANGE] Raise minimum `libgphoto2` version to 2.5.2. This version introduced
  `gp_port_reset`.
* [ADD] Add `FFI::GPhoto2Port::GPPort` struct and related functions to do a
  port reset.

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
