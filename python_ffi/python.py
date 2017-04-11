import ctypes

library_name = "../target/debug/libidris_call.dylib"
stringtools = ctypes.CDLL(library_name)
print(stringtools.count_substrings(b"banana", b"na"))

