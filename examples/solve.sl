// Iterative Berechnung der Loesung der Gleichung x = cos(x).

function solve() {
    x    = 0;
    oldX = 1;
    while (x != oldX) {
        oldX = x;
        x = cos(x);
    }
    return x;
}

print("Loesung von x = cos(x) ist x = ", solve(), " (iterative Loesung)");

// Rekursive Berechnung der Loesung der Gleichung x = cos(x).
function solveRecursive(x) {
    if (x == cos(x)) {
        return x;
    }    
    return solveRecursive(cos(x));
}

print("Loesung von x = cos(x) ist x = ", solveRecursive(0), " (rekursive Loesung)");

quit;

