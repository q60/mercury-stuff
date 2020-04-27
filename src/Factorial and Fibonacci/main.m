:- module main.

:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.

:- implementation.
:- import_module int, list, string.
:- func fib(int) = int.
:- func fac(int) = int.

fib(Ceiling) = FibResult :-
  if Ceiling =< 2 then
    FibResult = 1
  else
    fib(Ceiling - 1) = APartFib,
    fib(Ceiling - 2) = BPartFib,
    APartFib + BPartFib = FibResult.

fac(Number) = FacResult :-
  if Number = 0 then
    FacResult = 1
  else
    Number * fac(Number - 1) = FacResult.

main(!IO) :-
  io.write_string("What to do: ", !IO),
  io.read_line_as_string(OptionRead, !IO),
  (
    if
      OptionRead = ok(Option)
    then
      StringOption = string.strip(Option),
      (
        if StringOption = "factorial" then
          io.write_string("Enter a number: ", !IO),
          io.read_line_as_string(FacNum, !IO),
          (
            if
              FacNum = ok(FacNumRead),
              string.to_int(string.strip(FacNumRead), FacNumInt)
            then
              i(FacNumInt) = APartFac,
              i(fac(FacNumInt)) = BPartFac,
              io.format("Factorial of %d is %d\n", [APartFac, BPartFac], !IO)
            else
              io.write_string("Got NaN\n", !IO)
          )
        else
          (
            if StringOption = "fibonacci" then
              io.write_string("Enter position number: ", !IO),
              io.read_line_as_string(ResultOfReading, !IO),
              (
                if
                  ResultOfReading = ok(String),
                  string.to_int(string.strip(String), FibCeiling)
                then
                  i(FibCeiling) = APartFib,
                  i(fib(FibCeiling)) = BPartFib,
                  io.format("Fibonacci number on position of %d is %d\n", [APartFib, BPartFib], !IO)
                else
                  io.write_string("Got NaN\n", !IO)
              )
            else
              io.write_string("Wrong option\n", !IO)
          )
        )
      else
        io.write_string("EOF\n", !IO) % Just "throwing" this message because `else` branch is mandatory.
  ).
