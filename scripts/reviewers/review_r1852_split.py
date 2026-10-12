# r1852: split P(B_f) of the saved capped maximiser into 9 sum JJJ and 24 sum XXX, and compare with the operator E = P - 1.5 tr W^3
import numpy as np, sys, runpy, os
n=int(sys.argv[1]); c=sys.argv[2]; d=sys.argv[3]
sys.argv=['x',str(n),'0','9']
g=runpy.run_path('scripts/misc/screen_I121_capped_fourset.py')
a=np.load(os.path.join(d,f"sfmax_n{n}_c{c}.npy"))
L,LJ,rects,EM=g['L'],g['LJ'],g['rects'],g['EM']
X=L@a; J=LJ@a
jjj=9*np.sum(J[rects[:,0]]*J[rects[:,1]]*J[rects[:,2]]); xxx=24*np.sum(X[rects[:,0]]*X[rects[:,1]]*X[rects[:,2]])
print(f"n={n} c={c}: 9JJJ={jjj:.4f} 24XXX={xxx:.4f} P={jjj+xxx:.4f} maxE={EM(X).max():.4f} norm={a@g['Mnorm']@a:.4f}")
