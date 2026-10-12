# r214 claim 6, SECOND independent route: build the O(12) character of the Weyl
# module from symmetric functions instead of Freudenthal.
#
# Littlewood restriction GL(12) -> O(12):  s_{(2,2)} = [2,2] + [2] + [0].
# Sym^2 = h_2 = [2] + [0].  Hence  char[2,2] = s_{22}(X) - h_2(X)  where X is the
# multiset of the 12 weights of the standard rep: x_1..x_6, x_1^-1..x_6^-1.
Ls = LaurentPolynomialRing(ZZ, 6, 'x')
x = Ls.gens()
X = list(x) + [xi**-1 for xi in x]
Sym = SymmetricFunctions(ZZ); s = Sym.s(); h = Sym.h()
def ev(f):
    return f.expand(12, alphabet='y').subs({SR('y%d'%(i+1)): 0 for i in []}) # placeholder
# expand directly as polynomial in 12 variables then substitute
P = PolynomialRing(ZZ, 12, 'y'); y = P.gens()
def to_laurent(poly):
    out = Ls.zero()
    for mono, c in zip(poly.monomials(), poly.coefficients()):
        e = mono.exponents()[0]
        t = Ls.one()
        for i in range(6): t *= x[i]**e[i]
        for i in range(6): t *= x[i]**(-e[6+i])
        out += c*t
    return out
s22 = to_laurent(P(s[2,2].expand(12, alphabet='y')))
h2  = to_laurent(P(h[2].expand(12, alphabet='y')))
chi = s22 - h2
print("dim (sum of all weight multiplicities):", sum(chi.coefficients()))
dom = [(2,2,0,0,0,0),(2,1,1,0,0,0),(1,1,1,1,0,0),(2,0,0,0,0,0),(1,1,0,0,0,0),(0,0,0,0,0,0)]
D = dict(zip([tuple(m.exponents()[0]) if False else None for m in []],[]))
coeffs = {}
for mono, c in zip(chi.monomials(), chi.coefficients()):
    coeffs[tuple(mono.exponents()[0])] = c
for w in dom:
    print("   ", w, "->", coeffs.get(w, 0))
print("multiset:", sorted(coeffs.get(w,0) for w in dom))
