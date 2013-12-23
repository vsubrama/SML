fun num_to_real(n:num):real =
  (case n of
     Int_num(n) => Real.fromInt(n)
   | Real_num(n) => n);