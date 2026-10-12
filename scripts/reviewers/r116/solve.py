import numpy as np
from scipy.optimize import root
from core import *; from weyl import *; from tools import *; from sub import *

class Prob:
    def __init__(self, sub, C):
        self.sub=sub; self.C=C; self.F=sub.reshape(len(sub),-1); self.d=len(sub)
    def W(self,x): return np.einsum('i,ijk->jk', x, self.sub)
    def proj(self,M): return self.F@M.ravel()
    def res(self,x):
        W=self.W(x); return self.proj(Q(W,self.C)) - x
    def solve(self,x0,tol=1e-12):
        s=root(self.res,x0,method='hybr',tol=1e-13)
        x=s.x; r=np.linalg.norm(self.res(x))
        return x,r,s.success
    def normalise(self,x):
        W=self.W(x); nr=np.sqrt(ip(W,W))
        if nr<1e-9: return None,None
        return W/nr, 1.0/nr
