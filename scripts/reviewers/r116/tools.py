import numpy as np
from core import *; from weyl import *

def split(W, tol):
    lam,V = np.linalg.eigh(W)
    mmask = lam < -tol
    return lam, V[:,mmask], V[:,~mmask]   # m-frame, h-frame  (columns)

def Sabc(C, A, Bf, Cf):
    """sum over frames A,B,C of <[Xa,Xb],Xc>^2 ; frames are column matrices"""
    T = np.einsum('abc,ai,bj,ck->ijk', C, A, Bf, Cf, optimize=True)
    return float(np.sum(T**2))

def grading_report(W, C, tol=1e-8):
    lam, Vm, Vh = split(W, tol)
    r = {}
    r['lam']=lam; r['dim_m']=Vm.shape[1]; r['dim_h']=Vh.shape[1]
    r['S_mmm']=Sabc(C,Vm,Vm,Vm); r['S_hhm']=Sabc(C,Vh,Vh,Vm); r['S_hmh']=Sabc(C,Vh,Vm,Vh)
    r['S_mmh']=Sabc(C,Vm,Vm,Vh); r['S_hhh']=Sabc(C,Vh,Vh,Vh)
    r['graded'] = (r['S_mmm']<1e-8 and r['S_hhm']<1e-8)
    nz = np.abs(lam)[np.abs(lam)>tol]
    r['min_nonzero_abs_lam'] = float(nz.min()) if len(nz) else 0.0
    return r

def theta(W,C): return ip(W,Q(W,C))
