# Changelog

## HEAD

* [CHANGE] Errors are thrown as `GPhoto2::Error` rather than `RuntimeError`.
  Use `#message` and `#code` to extract the the GPhoto2 error message and
  return code, respectively.
* [ADD] `Camera#trigger` for trigger capture.
* [FIX] `TextCameraWidget` values can by any object that implements `#to_s`.
