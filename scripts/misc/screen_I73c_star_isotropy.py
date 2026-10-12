# L245's reach over the n=12 survivors: for each survivor point of an off-ray screen log, the smaller of the two
# extreme eigenspaces (E_0 or E_2, the one with fewer elements) cannot be a star e ^ U when its multiplicity
# exceeds the isotropy ceiling h_c (the largest a_c with a_0+a_1+a_2 = n-1, sum lambda_c a_c = 0, a >= 0).
# Splits the count into m_c > n-1 (a star in R^n has dim U <= n-1 anyway) and h_c < m_c <= n-1 (L245's own).
# Usage: python3 screen_I73c_star_isotropy.py <screen log>. Seconds. Screen only.
import sys, re, ast, numpy as np
from scipy.optimize import linprog
n = 12
def spectrum(m, frac):
    a = m[1]*frac+m[2]; b = -m[0]-m[1]+m[1]*frac; s = -b/a; t = -1+frac*(s+1)
    d = np.array([-1.0, t, s]); return d/np.sqrt(np.dot(m, d**2))
def hc(L, c):
    cv = np.zeros(3); cv[c] = -1
    return -linprog(cv, A_eq=[[1, 1, 1], list(L)], b_eq=[n-1, 0], bounds=[(0, None)]*3, method='highs').fun
H = []
for l in open(sys.argv[1]):
    if l.startswith('FEASIBLE'):
        m = ast.literal_eval(re.search(r'\(.*?\)', l).group(0)); fr = ast.literal_eval(re.search(r'\[.*\]', l).group(0))
        H += [(m, f) for f in fr]
tot = triv = own = 0
for m, f in H:
    L = spectrum(m, f); c = 0 if m[0] <= m[2] else 2
    if m[c] > hc(L, c):
        tot += 1
        if m[c] > n-1: triv += 1
        else: own += 1
print(f'{len(H)} points; smaller extreme eigenspace cannot be a star at {tot}: {triv} with m_c > n-1, {own} by L245 (h_c < m_c <= n-1)')
