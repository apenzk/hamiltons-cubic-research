# Dai–Fu 2023, transcription of §3 (pp. 4–9)

Conventions: $R_{ijkl}$ with $\mathrm{Ric}_{ik}=R_{ijkj}$; $\mathring R(e_i\odot e_j)=R_{iklj}\,e_k\odot e_l$ on $S^2(V)$, restricted to $S^2_0(V)$, following Li and Cao–Gursky–Tran; $S^2_0$ has dimension $\frac{(n-1)(n+2)}2$.

**Two cubic contractions (p. 5).** $\alpha:=R_{tpsq}R_{tpkl}R_{sqkl}$, $\beta:=R_{tspq}R_{tjpl}R_{sjql}$. By the first Bianchi identity: $R_{tspq}R_{tpkl}R_{sqkl}=\frac12\alpha$, $R_{tpsq}R_{tkpl}R_{skql}=\frac14\alpha$, $R_{pstq}R_{tjpl}R_{sjql}=-\frac14\alpha+\beta$.

**Proposition 3.1 (p. 5).** For $T$ a harmonic algebraic curvature tensor on $(M^n,g)$, $n\ge3$: $\langle\Delta T,T\rangle=2R_{lt}T_{ijkl}T_{ijkt}-R_{tskl}T_{ijkl}T_{ijts}-4R_{itls}T_{ijlk}T_{tjsk}=2R_{lt}T_{ijkl}T_{ijkt}-\alpha-4\beta$. Proof: second Bianchi and the Ricci identity.

**Proposition 3.2 (p. 6).** $\langle\mathring R(T^{S^2_0}),T^{S^2_0}\rangle=\frac{2n+32}{n}R_{st}T_{sjkl}T_{tjkl}-5\alpha+4\beta-\frac{16}{n^2}s|T|^2$.

**Lemma 3.3 (p. 7).** On an Einstein manifold: $\operatorname{tr}\mathring R=\frac{n+2}{2n}s$; $\operatorname{tr}(\mathring R^2)=\frac34|R|^2-\frac{s^2}{n^2}$; $\operatorname{tr}(\mathring R^3)=-\beta+\frac18\alpha+\frac{s^3}{n^3}$. Proof: $\operatorname{tr}A=\frac12\sum_{ij}A_{ijij}$ for self-adjoint $A$ on $S^2(V)$; $\operatorname{tr}(\tilde R^2)=\frac34|R|^2$; $\operatorname{tr}(\tilde R^3)=-R_{isjt}R_{kslt}R_{ikjl}+\frac18R_{ijkl}R_{ijst}R_{klst}$; then subtract the $g/\sqrt n$ direction.

**Proposition 3.4 (p. 8).** With $\{S_\alpha\}$ an orthonormal eigenbasis of $\mathring R$ and eigenvalues $\lambda_\alpha$: $3\langle\Delta R,R\rangle=\sum_\alpha\lambda_\alpha|S_\alpha W|^2+8\frac{-n^3+6n^2+12n-8}{3n^4(n-1)^2}s^3+8\frac{2n^2-22n+8}{3n^2(n-1)}s\sum\lambda_\alpha^2+16\sum\lambda_\alpha^3$. En route, $\langle\Delta R,R\rangle=\frac2ns|R|^2-\frac32\alpha+4\operatorname{tr}(\mathring R^3)-\frac4{n^3}s^3$.

## What this gives on $\mathrm{Weyl}_n$

For $R=W$ Ricci-flat, $s=0$: $\operatorname{tr}\mathring W^2=\frac34|W|^2$ and $\operatorname{tr}\mathring W^3=\frac18\alpha-\beta$. With $|W|^2=4\|M\|_F^2$ for $M$ the operator on $\Lambda^2$ and $\alpha=8\operatorname{tr}_{\Lambda^2}M^3$, the Bochner cubic $-\alpha-4\beta$ is a combination of the two spectral traces, which is the content of the record's bi-spectral identity $\theta=\frac32\operatorname{tr}_{\Lambda^2}M^3-\frac12\operatorname{tr}_{S^2_0}\mathring W^3$, **the second sign is MINUS, and this file carried a plus**, which evaluates to $0$ across the whole $n\le5$ range and gives $-7\sqrt{10}/30$ at $S^3\times S^3$ against the correct $\theta_0(6)=+\sqrt{10}/3$. *The minus is forced: $\frac32p_3(\mu)-\frac12p_3(\omega)=\theta_0(2m)$ identically in $m$, and no other second coefficient reproduces it.* (verified to $10^{-16}$ in [run_bispectral_identity.py](../../scripts/runs/run_bispectral_identity.py); the constants there are in the record's normalisation $\|M\|_F=1$).

Their Lemma 4.4 / 4.6 bound $\sum\lambda^3$ for a nondecreasing sequence with prescribed $\sum\lambda$, $\sum\lambda^2$ and a lower bound on partial sums, the elementary one-spectrum optimisation the second-kind literature runs on. It carries a sign hypothesis and is not sharp at any point of this project's catalogue.
