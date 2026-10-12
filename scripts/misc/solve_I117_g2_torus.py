"""Exact positive-definite #-idempotents on g2's torus family (I117, R48).

C = A + sum_a w_a P_a over the six positive root planes (long P0, P1, P4; short P2, P3, P5) and the
Cartan block A. By equivariance the family is closed under #, with A # A = 0, A # P_a = (1/2)(a^T A a) P_a,
P_a # P_a = a a^T on the Cartan, and the mixed products read off g2 in so(7) (screen_I117_g2_torus.py):
long-long and long-short 1/2, short-short 1/2 onto the long root and 2/3 onto the short one.
C # C = C is A = sum w_a^2 a a^T together with the six equations below, rational in w.
Computes a Groebner basis and the real positive solutions exactly.
Run: /usr/bin/python3 scripts/misc/solve_I117_g2_torus.py   (bounded by the caller)
"""
import sympy as sp, sys, time
w = sp.symbols('w0:6', positive=True)
Mq = [[4, 1, 1, 1, 1, 0],
      [1, 4, 1, 0, 1, 1],
      [1, 1, sp.Rational(4, 9), sp.Rational(1, 9), 0, sp.Rational(1, 9)],
      [1, 0, sp.Rational(1, 9), sp.Rational(4, 9), 1, sp.Rational(1, 9)],
      [1, 1, 0, 1, 4, 1],
      [0, 1, sp.Rational(1, 9), sp.Rational(1, 9), 1, sp.Rational(4, 9)]]
X = [sum(w[a]**2 * Mq[a][g] for a in range(6)) for g in range(6)]
f43 = sp.Rational(4, 3)
RHS = [w[1]*w[4] + w[2]*w[3],
       w[0]*w[4] + w[2]*w[5],
       w[0]*w[3] + w[1]*w[5] + f43*w[3]*w[5],
       w[0]*w[2] + w[4]*w[5] + f43*w[2]*w[5],
       w[0]*w[1] + w[3]*w[5],
       w[1]*w[2] + w[3]*w[4] + f43*w[2]*w[3]]
eqs = [sp.expand(w[g]*(1 - X[g]) - RHS[g]) for g in range(6)]
if __name__ == '__main__':
    q = sp.Rational(1, 4)
    assert all(e.subs({wi: q for wi in w}) == 0 for e in eqs), 'uniform point must solve the system'
    t0 = time.time()
    Gb = sp.groebner(eqs, *w, order='lex')
    print('groebner done in', round(time.time() - t0, 1), 's, size', len(Gb.exprs)); sys.stdout.flush()
    sols = sp.solve_poly_system(Gb.exprs, *w)
    pos = [s for s in sols if all(sp.re(sp.N(x)) > 1e-12 and abs(sp.im(sp.N(x))) < 1e-12 for x in s)]
    print('solutions:', len(sols), 'positive real:', len(pos))
    for s in pos:
        print([sp.nsimplify(x) for x in s], [float(sp.N(x)) for x in s])
