# r224: the same arithmetic identity for Sym^k(Weyl_n), k = 2 and 4, as a check on
# the omega-basis machinery itself rather than on the k=3 answer.
load('scripts/reviewers/r224/universal_o_lib.sage')
for k in (2,4):
    P = s(h[k].plethysm(omega([2,2])))
    E = {a:b for a,b in omega_expand(P, 4*k).items() if b}
    thr = max(sum(1 for x in a if x>=1)+sum(1 for x in a if x>=2) for a in E)
    print("Sym^%d: %d blocks, %d mult, threshold %d" % (k, len(E), sum(E.values()), thr))
    for n in (thr, thr+1, thr+2, thr+4):
        m = n//2
        A = WeylCharacterRing(("B%d" if n%2 else "D%d") % m)
        tot = 0
        for lam, mult in E.items():
            hw = list(lam) + [0]*(m-len(lam))
            d = A(*hw).degree()
            if n % 2 == 0 and len(lam) == m: d = 2*d
            tot += mult*d
        dW = n*(n+1)*(n+2)*(n-3)//12
        want = binomial(dW+k-1, k)
        print("   n=%-3d %-24d vs %-24d %s" % (n, tot, want, "MATCH" if tot==want else "*** MISMATCH ***"))
