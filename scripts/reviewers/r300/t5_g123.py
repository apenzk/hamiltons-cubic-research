"""G1 (trace over V), G2 (Weyl projection load-bearing / order), G3 (reach of V)."""
import sys; sys.path.insert(0,'scripts/reviewers/r300')
import numpy as np, core300 as C

def analyse(name, W, n):
    W = W/np.linalg.norm(W)
    th = float(np.tensordot(W, C.Q(n,W))); e = W/th
    B = C.weyl_basis(n); D=len(B); N=B.shape[1]
    M,_ = C.Le_matrix(n, e)
    w = C.to_coords(n,W); w/=np.linalg.norm(w)
    Pp = np.eye(D)-np.outer(w,w)
    ev, U = np.linalg.eigh(Pp@M@Pp)
    lam_full = ev[-1]; mult = int(np.sum(np.abs(ev-lam_full)<1e-8))
    top = U[:, np.abs(ev-lam_full)<1e-8]           # (D, mult) top eigenspace in Weyl coords

    S0 = C.sym0_basis(n)
    HA = np.array([ (C.D_A(n,A)@W + W@C.D_A(n,A)) for A in S0 ])   # (k,N,N)
    # --- variant W: project into Weyl_n, then into e-perp
    co = np.einsum('kij,mij->km', HA, B)                # Weyl coords of P_Weyl(H_A)
    coP = co - np.outer(co@w, w)                        # then e-perp
    Uv, sv = C.orth_rows(coP)
    # --- variant R: reverse order, e-perp first (in the ambient Sym^2), then Weyl
    HAp = HA - np.einsum('k,ij->kij', np.einsum('kij,ij->k',HA,W), W)   # remove W component in ambient
    co2 = np.einsum('kij,mij->km', HAp, B); co2 = co2 - np.outer(co2@w, w)
    Uv2, _ = C.orth_rows(co2)

    # --- variant N: NO Weyl projection: span of raw H_A inside Sym^2, minus the W direction
    F = HAp.reshape(len(HAp),-1)
    Un, sn = C.orth_rows(F)
    dev = np.array([v.reshape(N,N) for v in Un])
    Lv = np.array([0.5*(e@X+X@e)+C.sharp_bilin(n,e,X) for X in dev])
    Mn = np.einsum('kij,lij->kl', dev, Lv); Mn = 0.5*(Mn+Mn.T)
    evn = np.linalg.eigvalsh(Mn)
    # traces
    def stats(Ub):
        Mv = Ub@M@Ub.T; Mv=0.5*(Mv+Mv.T)
        evv=np.linalg.eigvalsh(Mv)
        return len(Ub), float(np.trace(Mv))/len(Ub), float(evv[-1])
    d1,t1,l1 = stats(Uv); d2,t2,l2 = stats(Uv2)
    # how much of the raw H_A lies outside Weyl_n
    frac = np.linalg.norm(HA - np.array([C.proj_weyl(n,H) for H in HA]))/np.linalg.norm(HA)
    # principal angles V (weyl-projected) vs top eigenspace
    cos = np.linalg.svd(Uv@top, compute_uv=False)
    print(f"--- {name}  n={n} dim(Weyl)={D} theta={th:.9f}")
    print(f"    full-space lambda_max|perp = {lam_full:.9f}  mult={mult}")
    print(f"    dim Sym_0 = {len(S0)}, dim V (Weyl-proj, e-perp) = {d1};  reverse order dim = {d2}")
    print(f"    subspace overlap of the two orders (min principal cos) = {np.linalg.svd(Uv@Uv2.T,compute_uv=False).min():.12f}")
    print(f"    G1  tr(L_e|V)/dim V = {t1:.6f}    [reverse order: {t2:.6f}]")
    print(f"    G3  lambda_max(L_e|V) = {l1:.6f}   ratio to full = {l1/lam_full:.6f}")
    print(f"    G2  ||H_A outside Weyl_n|| / ||H_A|| = {frac:.4f};  NO-Weyl-proj: dim={len(Un)}, lambda_max={evn[-1]:.6f}, tr/dim={float(np.trace(Mn))/len(Un):.6f}")
    print(f"    principal cosines V vs top eigenspace: {np.round(cos,6)}")
    return lam_full

for nm, W, n in [("S^3xS^5",)+C.sphere_pair(3,5), ("CP^3",)+C.cpm(3), ("CP^4",)+C.cpm(4), ("C5 blowup",)+C.c5_blowup()]:
    analyse(nm, W, n)
