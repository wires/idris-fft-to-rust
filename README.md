# using FFI to rust

just simple examples of calling rust from node, python or idris

basic substring counting example for rust ([src]())

```rust
extern crate libc;

use std::ffi::CStr;
use std::str;
use libc::c_char;

#[no_mangle]
pub extern "C" fn count_substrings(value: *const c_char, substr: *const c_char) -> i32 {
    let c_value = unsafe { CStr::from_ptr(value).to_bytes() };
    let c_substr = unsafe { CStr::from_ptr(substr).to_bytes() };
    match str::from_utf8(c_value) {
        Ok(value) => match str::from_utf8(c_substr) {
            Ok(substr) => rust_substrings(value, substr),
            Err(_) => -1,
        },
        Err(_) => -1,
    }
}

fn rust_substrings(value: &str, substr: &str) -> i32 {
    value.matches(substr).count() as i32
}
```

calling this from idris:


```idris
module Main

%link C "../target/debug/libidris_call.dylib"

foo : String -> String -> IO Int
foo = foreign FFI_C "count_substrings" (String -> String -> IO Int)

main : IO ()
main = do x <- foo "424242" "42"
          putStrLn ("count_substrings '424242' '42' := " ++ show x)
```

#### references

- [idris 1.0 ffi](http://docs.idris-lang.org/en/latest/reference/ffi.html)
- [rust ffi examples](https://zsiciarz.github.io/24daysofrust/book/vol1/day23.html)
