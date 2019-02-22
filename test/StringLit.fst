module StringLit

module IO = FStar.HyperStack.IO

open FStar.HyperStack.ST

let test (x:string): Stack string (fun _ -> true) (fun _ _ _ -> true) =
  strcat "hello " x

let cat (x y:string): Stack string (fun _ -> true) (fun _ _ _ -> true) =
  strcat x y

let test_c_string () =
  // C strings, modeled as zero-terminated, not relying on GC
  C.String.(print !$"hello, world\n")

let main () =
  // F* strings, unaware of zero-termination, supports concatenation using a
  // conservative GC; HyperIO provides functions in the Stack effect
  IO.print_string (test "jonathan!\n");
  // Generates nice testcases to be run with clang -fsanitize=address...!
  IO.print_string (cat "" "");
  IO.print_string (cat "" "\n");
  IO.print_string (cat "\n" "");
  C.EXIT_SUCCESS
