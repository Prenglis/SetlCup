  function factorial(n) {
      if (n == 0) {
         return 1;
      }
      return n * factorial(n - 1);
  }
  print("Calculation of factorial for i = 1 to 9");
  for (i = 0; i < 10; i = i + 1) {
      print(i, "! = ", factorial(i));
  }
  print();