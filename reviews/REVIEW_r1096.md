# Review r1096: I113 audit note and I73(c) summed-pairs note

*Reviewer r1096, 2026-09-23. Log: [agent_logs/r1096-i113c.log](../agent_logs/r1096-i113c.log). Subject: [2026-09-23-I113-audit.md](2026-09-23-I113-audit.md) and [2026-09-23-I73c-summed-pairs.md](2026-09-23-I73c-summed-pairs.md) as committed at f6e38e30. Analysis only. Every computation below is a screen of seconds on objects built here, using the confirmed helpers structure_constants, weyl_projector and circ of [screen_I73_pair_direction.py](../scripts/misc/screen_I73_pair_direction.py). The I113 screen script was neither imported nor run.*

| # | claim | verdict |
|---|---|---|
| A1 | I113(b) reflection identities, Lean | **CONFIRMED** |
| A2 | subalgebra scope of $T(D,D,N)=0$, and the F39 critique | **GAP**: criterion and both examples confirmed, the F39 critique misdiagnosed |
| A3 | (1.5) step 1, Casimir | **CONFIRMED** |
| A4 | (1.5) step 2, quartic identity at any eigenpair | **CONFIRMED** |
| A5 | (1.5) needs no criticality, maximality or bottom eigenvector | **CONFIRMED**, with a correction to the positivity reading |
| C1 | per-pair norms | **CONFIRMED** |
| C2 | summed norm formula | **CONFIRMED** |
| C3 | one free Gram parameter | **GAP**, minor, repaired here |
| C4 | correction bounds and per-pair inequality | **CONFIRMED**, with one omission carried to C5 |
| C5 | link to R35 and its direction | **GAP**: overreaches, and misses a bound the record already holds |

## A1, CONFIRMED

Link by link: pairing criticality with $D$ gives $\lambda q=f+2T(D,D,N)+t=f+t$, and $P(W)=\lambda$ gives $\lambda=f+3T(D,D,N)+3t+p=f+3t+p$. Eliminating $t$ gives $2f=p+\lambda(3q-1)$. The difference $P(D+N)-P(D-N)=6T(D,D,N)+2p=2p$. At a global maximiser $\lvert D-N\rvert^2=\lvert D\rvert^2+\lvert N\rvert^2=1$, so $P(N)\ge0$. The Lean statements of reflection_restriction and reflection_difference in [I113Reflection.lean](../lean/HamiltonsCubic/Results/I113Reflection.lean) carry exactly these hypotheses (criticality for all $X$, unit norm, orthogonality and hsub for the first, and hsub alone for the second) over an arbitrary real module with symmetric $T$ and $B$. `#print axioms` on both returns propext, Classical.choice, Quot.sound only.

## A2, GAP

**Confirmed half.** If $Q(S)\subseteq S$ and $N\perp S$ then $T(D,D,N)=\langle Q(D),N\rangle=0$. Both examples qualify. The coordinate-diagonal locus is closed because $Q$ of a diagonal operator is diagonal. The zero-extended $\mathcal W_{n-1}$ is closed because $\#$ of two operators supported on $\mathfrak{so}(n-1)$ is supported there ($\mathfrak{so}(n-1)$ is a subalgebra), and $Q(\mathcal W_{n-1})\subseteq\mathcal W_{n-1}$ (Hamilton, via Bhattacharya eq. 3.1, as cited in L234). The note asserts the zero-extension case without this sentence. Screen: $\lvert\pi_{S^\perp}\pi_{\mathcal W_n}Q(D)\rvert=0$ to machine precision at random zero-extended $D$, $n=5,6,7$, and the same for the diagonal locus.

**The F39 critique is misdiagnosed.** The archive's source, Theorem 3.1 of an outside report archive (unpublished, held in the private record) (line 115), writes "in any coordinate frame write $W=D+F$, with $D$ diagonal and $F\perp\mathcal D$". Every frame's diagonal locus is the $O(n)$-conjugate of the coordinate one and $Q$ is equivariant, so each is a $Q$-subalgebra and "in any frame" is exactly right. The footer's only defect is that it never says $D$ is the frame-diagonal part. **Correction: name $D$ as the diagonal part in that frame, and keep "any frame".** To the brief's question: with $D$ the frame-diagonal part, no frame gives $T(D,D,N)\ne0$. A split with no subalgebra behind it does, generically, e.g. $D=\langle W,u\rangle u$ for a generic unit $u$, but that is a split the archive never uses.

## A3, CONFIRMED

Checked link by link. Write $\rho_i$ for $A$ acting in slot $i$. Invariance gives $(\rho_1+\rho_2)^2\equiv\rho_3^2$ under $T$, so $\sum_\alpha T\big((\rho_1+\rho_2)^2(W\otimes Z),Z\big)=-cT(W,Z,Z)$. Expanding gives $-2cT+2\sum_\alpha T(A_\alpha W,A_\alpha Z,Z)$, hence $\sum_\alpha T(A_\alpha W,A_\alpha Z,Z)=\tfrac c2T$. Invariance at $(W,Z,A_\alpha Z)$ then gives $\sum_\alpha T(W,A_\alpha Z,A_\alpha Z)=cT-\tfrac c2T=\tfrac c2T$. With $\langle KY,Y\rangle=\tfrac\lambda2\lvert Y\rvert^2-T(W,Y,Y)$, the displayed sum follows at any real $\lambda$, and $\Delta_H=\lambda\lvert Z\rvert^2-T(W,Z,Z)$. Two implicit inputs, both true. The Casimir is scalar on $\mathcal W_n$ because $\mathcal W_n$ is irreducible for $n\ge5$, and at $n=4$ the two halves share the Casimir. The value $c=4(n-1)$ is the Young-diagram value $\sum_i\lambda_i(\lambda_i+n-2i)$ at $(2,2)$ for the $\tfrac12\operatorname{tr}$-orthonormal basis, where the vector representation gives $n-1$. Screen: Casimir ratio exactly $-16,-20,-24$ at $n=5,6,7$, and the summed identity exact at a random real $\lambda$.

## A4, CONFIRMED

Re-derived by hand. The non-separable part of $z_{ij}^2+\sum_{m\ne i,j}z_{im}z_{jm}$ is $(1-2a+(n-2)a^2)q_iq_j-(h_i^3h_j+h_ih_j^3)+h_ih_j$. The full sum over $m$ contributes $h_ih_j+na^2q_iq_j$, the $m=i,j$ removals contribute $-(1+2a)(h_i^3h_j+h_ih_j^3)-2a(1+2a)q_iq_j-2bh_ih_j$, and $z_{ij}^2$ contributes $(1+2a^2)q_iq_j+2a(h_i^3h_j+h_ih_j^3)+2bh_ih_j$. The three contractions and the $\lvert Z\rvert^2$ formula check, the latter matching the archive's $\tfrac{n^2-3n+3}{2(n-1)(n-2)}-\tfrac n{2(n-2)}t_4$. "Any eigenpair" is true, and only the diagonal of $\mathring Wh=\mu h$ in $h$'s eigenframe is used. The identity does not use $\lvert W\rvert=1$ either. Screen: residual $\le1.1\times10^{-16}$ at the top and bottom eigenpairs of random Weyl $W$, $n=5,6,7$, with $\langle W,Z\rangle=\mu/2$ holding.

**Sign remark.** The archive's operator is Li's $(\mathring Wh)_{ij}=\sum W_{iklj}h_{kl}$ (an outside report archive (unpublished, held in the private record) line 635), which the record standardises on ([conventions.md](../findings/conventions.md)). The note's $h\mapsto\sum_{jl}W_{ijkl}h_{jl}$ is minus that. So the note's $\mu$ is an eigenvalue of ITS operator and minus an eigenvalue of Li's, and the archive's "bottom eigenvector" is the TOP eigenvector of the note's operator. The note is self-consistent through the pin $\langle W,Z\rangle=\mu/2$, but its word "BOTTOM" in the Consequence paragraph is the archive's and should say so.

## A5, CONFIRMED, with a correction to the positivity reading

The identity uses none of criticality, maximality or extremality, and $\lambda$ is a free parameter. The Consequence paragraph's reading of $\Delta_H\ge0$ from $K\succeq0$ needs one fact neither the archive nor the note states. $K\succeq0$ holds on $W^\perp$ only, and $\langle KW,W\rangle=-\tfrac\lambda2$ at a critical point, so $A_\alpha\cdot Z\perp W$ is needed. It holds for every eigen-$h$: $\langle A\cdot Z(h),W\rangle$ is proportional to $\langle\mathring Wh,[A,h]\rangle=\mu\operatorname{tr}(h[A,h])=0$. Screen: $\max_\alpha\lvert\langle A_\alpha Z,W\rangle\rvert\le4\times10^{-16}$. Reading $\Delta_H\ge0$ needs local maximality, and reading $\Delta_M\ge0$ needs $h$ extremal. So the hypotheses the archive lists belong to the sign reading. The identity itself needs none of them.

## C1, CONFIRMED

$\lvert h\rvert^2=g-\tfrac12\sum_\gamma T_{\alpha\beta\gamma}$ follows as written from $\lVert UV\rVert_F^2=\operatorname{tr}(U^2V^2)$ and $\lVert[U,V]\rVert_F^2=2\sum_\gamma T_{\alpha\beta\gamma}$, with $T$ the squared structure constants. The $\lVert N_4\rVert^2$ sketch is terse on the signs of the two crossing contractions, but the constant is right. The unprojected value $\tfrac14(\varepsilon_\alpha+\varepsilon_\beta)-\tfrac14\sum\varepsilon_\gamma T_{\alpha\beta\gamma}$ follows from $Y_0^2=\tfrac14(u\otimes u+v\otimes v)$ and $Y_0^\#=-\tfrac14[u,v]\otimes[u,v]$. Screen at eigenpairs of random Weyl $e$, $n=5,6,7$: $\lVert X\rVert^2$, $\lvert h\rvert^2$ and the unprojected value are exact to $1.7\times10^{-15}$. The $\Lambda^4$ correction vanishes at $n=5$, which also fixes the sign of the Ricci correction $+\tfrac1{2(n-2)}\langle h,\mathring eh\rangle$ in the note's index order. Both coordinate extremes check by hand.

## C2, CONFIRMED

Linear in the per-pair data: $\sum g=\operatorname{tr}(A_aA_b)=G_{ab}$ from $\sum_{\alpha\in a}\Psi_\alpha^2=-A_a$, and $\sum\sum_\gamma T=\tau_{ab}$.

## C3, GAP (minor, repaired)

The three matrix identities and the six equations are right. The note exhibits one dependency, but "exactly one" needs the remaining five to be independent, which is not argued. **Repair.** The map $G\mapsto(G\mathbf1,G\varepsilon)$ on symmetric $3\times3$ matrices has kernel the $G$ that vanish on $\operatorname{span}(\mathbf1,\varepsilon)$. That span is two-dimensional because the three values are distinct, so the kernel is $\mathbb R\,zz^{\mathsf T}$ with $z=\mathbf1\times\varepsilon=(\varepsilon_3-\varepsilon_2,\varepsilon_1-\varepsilon_3,\varepsilon_2-\varepsilon_1)$. So the rank is 5, the solution set is an affine line, and $G_{12}$ is a valid coordinate on it since $z_1z_2\ne0$. The side constraints are correct.

## C4, CONFIRMED

L125 gives $\langle X,e\circ X\rangle\le\tfrac12\lVert X\rVert^2$. L234 gives $\langle X,e\circ X\rangle=\langle Y_0,e\circ Y_0\rangle-A_r-A_4$ with $\lVert X\rVert^2=\tfrac12-\tfrac{\lvert h\rvert^2}{n-2}-\lVert\omega\rVert^2$. The corrections enter the necessary condition with a plus sign, so the UPPER bounds $A_r\le\tfrac{\mathring\mu}{2(n-2)}\lvert h\rvert^2$ ($h=\operatorname{Ric}Y_0$ is traceless since $\langle u,v\rangle=0$) and $A_4\le\tfrac38\nu\lVert\omega\rVert^2$ are the right direction. The display follows. $\mathring\mu=\mu/\theta$ with R35's $\mu=-\lambda_{\min}$ of Li's operator is right, by the sign remark under A4. **Omission:** the closing "analytic next step is to bound $\mathring\mu$" does not register that an upper bound is already on file (see C5).

## C5, GAP

The implication is read correctly. Above $\sqrt{3/2}$, R35's branch forces $\beta\mu\ge\theta$, so $\mathring\mu\ge\tfrac n{n-1}$, and the displayed coefficient $\tfrac{\mathring\mu-1}{2(n-2)}$ is then positive. Two defects remain.

- **"A lower bound on $\mathring\mu$ loosens R33's pair inequality" overreaches.** The exact pair inequality (L125 with L234) carries $\langle h,\mathring eh\rangle$ for the specific $h=\operatorname{Ric}Y_0$, and a lower bound on the top eigenvalue says nothing about that. Only the $\mathring\mu$-relaxation is loosened. So "R33 and R35 are one question at this term" holds for the relaxed display only.
- **The record already holds the upper bound.** The second-kind projection estimate $\tfrac{n-1}n\mu\le\Theta_n\lvert W\rvert$ is proved at both parities ([target.md](../findings/target.md) line 266, [bispectral.md](../findings/bispectral.md)). At a unit global maximiser $\theta\ge\Theta_n$, so $\mathring\mu\le\tfrac{\Theta_n}{\beta\theta}\le\tfrac n{n-1}$ unconditionally. The Ricci coefficient in the display is therefore at most $\tfrac1{2(n-1)(n-2)}$ wherever I73 is posed, and it belongs in the class-level system of the closing section. Combined with R35's branch it forces $\mathring\mu=\tfrac n{n-1}$, which is the equality case and R35 closing the conjecture outright. So the "weakening where (c) needs it strong" happens only in a regime R35 would already end.

## Summary

Both I113 identities stand. (b) is exact and kernel-checked with standard axioms. The Casimir step and the quartic step of (1.5) are correct link by link, $\lambda$ cancels, and the identity holds at every Weyl $W$ and every eigenpair, screened exact at $n=5,6,7$. Two corrections to I113. The F39 footer needs "$D$ the frame-diagonal part", not a narrower frame, because every frame's diagonal locus is a $Q$-subalgebra. The positivity reading $\Delta_H\ge0$ silently uses $A_\alpha\cdot Z\perp W$, which holds for every eigen-$h$ and should be stated, and the note's "bottom" is the top of its own operator. In the I73(c) note the norm formulas, the summation and the per-pair inequality are right and screened. The Gram count needs the rank argument supplied above. The R35 link overreaches: a lower bound on $\mathring\mu$ loosens only the relaxation. It also misses that the record's projection estimate already caps $\mathring\mu\le\tfrac n{n-1}$ at a global maximiser, which bounds the Ricci slack by $\tfrac1{2(n-1)(n-2)}$ and should enter the class-level system.
