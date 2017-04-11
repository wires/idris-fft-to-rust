module Main

%link C "../target/debug/libidris_call.dylib"

foo : String -> String -> IO Int
foo = foreign FFI_C "count_substrings" (String -> String -> IO Int)

main : IO ()
main = do x <- foo "424242" "42"
          putStrLn ("count_substrings '424242' '42' := " ++ show x)
