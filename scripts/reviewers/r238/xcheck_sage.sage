# r238 claim 6 cross-check: an INDEPENDENT implementation using Sage's own
# plethysm and Schur expansion, rather than the power-sum pairing.
Sym = SymmetricFunctions(QQ); s = Sym.s(); h = Sym.h()
A = s[2,2] - s[2]
for k in range(1, 7):
    f = s(h[k].plethysm(A))
    tot = sum(int(c) for la, c in f.monomial_coefficients().items()
              if all(x % 2 == 0 for x in la))
    print("k=%d  universal (Sage plethysm + even-partition sum) = %d" % (k, tot))
    sys.stdout.flush()
