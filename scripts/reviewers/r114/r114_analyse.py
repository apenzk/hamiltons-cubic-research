import numpy as np, sys, os, json
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from r114_core import *

n = 6
S = Setup(n)
prs, idx = pair_index(n)
B, _, _ = weyl_basis(n)
D = np.diag([1.0 if ((i < 3 and j < 3) or (i >= 3 and j >= 3)) else -1.0 for (i, j) in prs])
G = np.array([[np.sum(B[k] * (D @ B[l] @ D)) for l in range(84)] for k in range(84)])
w, U = np.linalg.eigh(G)
C = np.einsum('kj,jab->kab', U[:, w > 0].T, B)

sols = json.load(open(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'sols.json')))
print("converged solutions:", len(sols))

# admissible (dim h, dim m) for a Z2-grading of so(6): h = fixed algebra of an involution
# so(3)+so(3)=6, so(2)+so(4)=7, u(3)=9, so(5)=10  (and their m = 15 - dim h)
ADM = {6: 9, 7: 8, 9: 6, 10: 5}

rows = []
for s in sols:
    x = np.array(s['x']); M = np.einsum('k,kab->ab', x, C); M /= np.linalg.norm(M)
    th = S.theta(M)
    if th < 0:            # fix the sign convention: theta > 0 (S^m x S^m has theta = +theta_0)
        M = -M; th = -th
    r = grading_report(S, M, tol=1e-9)
    ev = np.linalg.eigvalsh(M)
    nz = min(abs(e) for e in ev if abs(e) > 1e-9)
    # is sigma itself the grading?  positive eigenspace == Lambda^2_+ ?
    Pp = (np.diag(D) > 0).astype(float)
    signs = np.sign(np.round(ev, 12))
    rows.append(dict(theta=float(th), res=float(np.linalg.norm(S.Q(M) - th * M)),
                     S=float(r['S']), Thhm=float(r['T']['hhm']),
                     dh=r['dim_h'], dm=r['dim_m'], dz=r['dim_ker'], gap=float(nz),
                     adm=(r['dim_ker'] == 0 and ADM.get(r['dim_h']) == r['dim_m']),
                     graded=bool(r['graded_kerfree']), M=M))

rows.sort(key=lambda z: z['theta'])
# dedupe by (theta, gap, dims)
uniq = []
for z in rows:
    if not any(abs(z['theta'] - u['theta']) < 1e-9 and abs(z['gap'] - u['gap']) < 1e-9
               and z['dh'] == u['dh'] for u in uniq):
        uniq.append(z)
print("distinct (theta, gap, dims):", len(uniq))
print(f"{'theta':>12} {'res':>9} {'S':>12} {'T_hhm':>12} {'dh':>3}{'dm':>4}{'dz':>4} {'gap':>12} adm graded")
for z in uniq:
    print(f"{z['theta']:12.9f} {z['res']:9.1e} {z['S']:12.4e} {z['Thhm']:12.4e} "
          f"{z['dh']:3d}{z['dm']:4d}{z['dz']:4d} {z['gap']:12.4e} {str(z['adm']):>5} {z['graded']}")

print("\n== S=0 points ==")
for z in uniq:
    if z['S'] < 1e-8:
        print(f"theta={z['theta']:.9f} gap={z['gap']:.6e} dims h/m/ker={z['dh']}/{z['dm']}/{z['dz']} "
              f"T_hhm={z['Thhm']:.6e} admissible={z['adm']} GRADED={z['graded']}")

print("\n== graded solutions and their gaps ==")
g = [z for z in uniq if z['graded']]
print("count:", len(g))
for z in g:
    print(f"theta={z['theta']:.9f} gap={z['gap']:.6e} dims {z['dh']}/{z['dm']}")

print("\n== dim-h histogram over distinct points ==")
from collections import Counter
print(Counter((z['dh'], z['dm'], z['dz']) for z in uniq))
np.save(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'uniqM.npy'),
        np.array([z['M'] for z in uniq]))
json.dump([{k: v for k, v in z.items() if k != 'M'} for z in uniq],
          open(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'uniq.json'), 'w'))
