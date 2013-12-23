fun squareRoot(x: real): real =
  let
    val delta = 0.0001
    fun goodEnough(guess: real): bool =
      if(Real.abs(guess*guess - x) < delta) then true else false
    fun improve(guess: real): real =
      (guess + x/guess) / 2.0
    fun tryGuess(guess: real): real =
      if goodEnough(guess) then guess
      else tryGuess(improve(guess))
  in
    tryGuess(1.0)
  end
