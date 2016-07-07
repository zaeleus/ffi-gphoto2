# Changelog

## HEAD

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
