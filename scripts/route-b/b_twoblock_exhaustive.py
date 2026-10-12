"""Exhaustive plane-type sweep behind the eigenvector claim of b_twoblock_symbolic.py.

Part 2 of that script checks hand-picked pair types.  This one enumerates EVERY
pair of planes over a universe of the core four indices plus two spare p-indices
and two spare q-indices -- enough to realise every type a pair can take, since a
pair spans at most four indices -- and compares (e o X)_ab against mu * X_ab
symbolically in p and q.  784 pairs, zero mismatches.
"""
import sys, itertools, sympy as sp, time
sys.path.insert(0, 'scripts/lib')
import b_twoblock_symbolic as B
p,q=B.p,B.q; n=p+q
mu=(n-2)/(2*(p-1)*(q-1))
# core + two spare P and two spare Q realises every type a pair of planes can take
labels=['a','b','u','v','P1','P2','Q1','Q2']
blocks={'P1':'P','P2':'P','Q1':'Q','Q2':'Q'}
# X's support values, for the right-hand side mu*X_ab
supp={(('a','b'),('u','v')):sp.Rational(2,3), (('u','v'),('a','b')):sp.Rational(2,3),
      (('a','u'),('b','v')):sp.Rational(1,3), (('b','v'),('a','u')):sp.Rational(1,3),
      (('a','v'),('b','u')):sp.Rational(-1,3),(('b','u'),('a','v')):sp.Rational(-1,3)}
planes=[tuple(sorted(c)) for c in itertools.combinations(labels,2)]
bad=[]; t0=time.time(); done=0
for A in planes:
    for Bp in planes:
        got=B.circ_entry(A,Bp,blocks)
        want=sp.simplify(mu*supp.get((A,Bp),0))
        if sp.simplify(got-want)!=0: bad.append((A,Bp,got,want))
    done+=1
    print(f"  row {done}/{len(planes)} done ({time.time()-t0:.0f}s), mismatches so far {len(bad)}", flush=True)
print("TOTAL PAIRS:",len(planes)**2," MISMATCHES:",len(bad))
for x in bad[:5]: print("  ",x)
