# r224: is 12 special, or just 4k?  The same construction for Sym^k(Weyl).
load('scripts/reviewers/r224/universal_o_lib.sage')
for k in (1,2,3,4):
    P = s(h[k].plethysm(omega([2,2])))
    E = {a:b for a,b in omega_expand(P, 4*k).items() if b}
    worst = max((sum(1 for x in a if x>=1)+sum(1 for x in a if x>=2), a) for a in E)
    print("Sym^%d : %3d blocks, %4d mult, max rows %d, threshold %2d at %s"
          % (k, len(E), sum(E.values()), max(len(a) for a in E), worst[0], list(worst[1])))
