# REVIEW r1160: the Ricci correction as a difference of commutator masses

*Gate 2 on [the working file](2026-09-25-I73c-per-vector-rows.md) at 4ca4f921, brief [2026-09-25-commutator-mass-gate2-brief.md](2026-09-25-commutator-mass-gate2-brief.md). Argued from the definitions. One screen of a few seconds on a random symmetric operator on $\Lambda^2\mathbb R^6$ (not a Weyl tensor, since every check below is index algebra valid for any curvature-type operator), reported as a screen only.*

## Verdict

- **Item 1: CONFIRMED.** Ricci-flatness gives $A_0=A_2$.
- **Item 2: CONFIRMED with a SIGN CORRECTION.** $Q_c=\tfrac12C_c-\mathop{\mathrm{tr}}(A_ch^2)$ is right, but the record's identity $\sum_c\lambda_cQ_c(h)=\mathring W(h,h)$ holds with the opposite sign to the $\mathring e$ that enters $B_{\mathrm{Ric}}$ ([L234](../findings/second-order.md)'s pairing). In that convention $\langle h,\mathring eh\rangle=\tfrac a{2\theta}\big(C_0(h)-C_2(h)\big)$.
- **Item 3: REFUTED as a usable cancellation.** The whole-family algebra is right under its hypothesis, but no isometry can swap $E_0$ and $E_2$ at a critical point with $\theta\neq0$, so the hypothesis is never met on the family the paragraph is about. The $V_+$ reading is correct: a swap would carry $V_+$ to the negative eigenspace of $B_{\mathrm{lead}}$.
- **Item 4: PLAUSIBLE, one overstatement.** The $O(n/\kappa)$ size is right (sharp constant $n\lvert h\rvert^2/\kappa$). "What the identity adds is antisymmetry under $E_0\leftrightarrow E_2$" overstates: $\tfrac a\theta(Q_2-Q_0)$ was already antisymmetric. What the identity adds is that the $\mathop{\mathrm{tr}}(A_ch^2)$ parts cancel, leaving a difference of two nonnegative masses.

## Item 1: the Ricci contraction

Take $\varphi_{ij}=E_{ij}-E_{ji}$, unit in $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}X^{\mathsf T}Y$, and the four-tensor $R_{ijkl}=\langle\varphi_{ij},W\varphi_{kl}\rangle$ of [the projected-pair note](2026-09-23-I73c-projected-pair.md). Since $\langle\psi,\varphi_{ij}\rangle=\tfrac12(\psi_{ij}-\psi_{ji})=\psi_{ij}$ for skew $\psi$,
$$R_{ijkl}=\sum_\psi\lambda_\psi\,\psi_{ij}\psi_{kl},\qquad \sum_iR_{ijil}=\sum_\psi\lambda_\psi(\psi^{\mathsf T}\psi)_{jl}=\sum_\psi\lambda_\psi(\psi\psi^{\mathsf T})_{jl}.$$
The anchor is $W=\mathrm{Id}$: $\sum_{i<j}\varphi_{ij}\varphi_{ij}^{\mathsf T}=(n-1)I$, the sphere's Ricci, so the sign is $+$ in the record's convention ([r703](REVIEW_r703.md)'s $\mathring{\mathrm{Id}}(\mathrm{id})=(n-1)\mathrm{id}$). An algebraic Weyl tensor has zero Ricci contraction, so $-aA_0+aA_2=0$ and $A_0=A_2$ at $a\neq0$. The sign is immaterial to this conclusion. Criticality is not used: it holds for every Weyl tensor with spectrum $(-a,0,a)$. *Screen: the contraction against $\sum\lambda\psi\psi^{\mathsf T}$ agreed to $2\times10^{-15}$.*

The first paragraph's $A_c=\sum\psi^{\mathsf T}\psi$ and the second's $\sum\psi\psi^{\mathsf T}$ are the same matrix for skew $\psi$, and the isotropic value $A_c=\tfrac{2p}nI$ follows from $\mathop{\mathrm{tr}}A_c=\sum\lVert\psi\rVert_F^2=2p$. The bound $\lvert\mathop{\mathrm{tr}}(\psi h\psi h)\rvert\le\lVert\psi h\rVert_F^2=\mathop{\mathrm{tr}}(\psi^{\mathsf T}\psi h^2)$ is Cauchy–Schwarz, so $\lvert Q_c\rvert\le\mathop{\mathrm{tr}}(A_ch^2)$ holds, and $\tfrac a\theta\cdot\tfrac{2p}n=\kappa/(n\theta^2)=O(1)$ in the band.

## Item 2: the commutator-mass form, and its sign

**The algebra holds.** $[\psi,h]^{\mathsf T}=h^{\mathsf T}\psi^{\mathsf T}-\psi^{\mathsf T}h^{\mathsf T}=-h\psi+\psi h=[\psi,h]$, so $\mathop{\mathrm{tr}}([\psi,h]^2)=\lVert[\psi,h]\rVert_F^2$. And $\psi^2=-\psi\psi^{\mathsf T}$. With `trace_psi_h` (read in [ClassTraceTest.lean](../lean/HamiltonsCubic/Results/ClassTraceTest.lean), a correct cyclic-trace proof for arbitrary square $\psi,h$) this gives $Q_c(h)=\tfrac12C_c(h)-\mathop{\mathrm{tr}}(A_ch^2)$, and with $A_0=A_2$,
$$Q_2(h)-Q_0(h)=\tfrac12\big(C_2(h)-C_0(h)\big).$$

**The sign of the step to $\langle h,\mathring eh\rangle$ is reversed.** Expanding with $R_{ijkl}=\sum\lambda\psi_{ij}\psi_{kl}$,
$$\sum_\psi\lambda_\psi\mathop{\mathrm{tr}}(\psi h\psi h)=\sum R_{ijkl}h_{jk}h_{li}=-\sum R_{ijkl}h_{ik}h_{jl},$$
the last step by relabelling $i\leftrightarrow j$ and $R_{jikl}=-R_{ijkl}$. The right-hand pairing $\sum e_{ijkl}h_{ik}h_{jl}$ is exactly the $\langle h,\mathring eh\rangle$ defined in [L234](../findings/second-order.md) ([the projected-pair note](2026-09-23-I73c-projected-pair.md), Statement), which is the one in $B_{\mathrm{Ric}}=-\tfrac1{2(n-2)}(\langle h_\alpha,\mathring eh_\beta\rangle)$. Check at $W=\mathrm{Id}$ on traceless $h$: $\sum_\psi\mathop{\mathrm{tr}}(\psi h\psi h)=\lvert h\rvert^2-(\mathop{\mathrm{tr}}h)^2=+\lvert h\rvert^2$, while L234's $\sum(\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk})h_{ik}h_{jl}=(\mathop{\mathrm{tr}}h)^2-\lvert h\rvert^2=-\lvert h\rvert^2$. *Screen: on a random symmetric operator at $n=6$ the two sides were $-17.8436$ and $+17.8436$.*

So the working file's "Criticality on symmetric directions" identity $\sum_c\lambda_cQ_c=\mathring W(h,h)$ reads $\mathring W$ as minus L234's pairing, and in the convention of $B_{\mathrm{Ric}}$
$$\langle h,\mathring eh\rangle=-\tfrac a\theta\big(Q_2(h)-Q_0(h)\big)=\frac a{2\theta}\big(C_0(h)-C_2(h)\big).$$
**What the sign changes.** $B_{\mathrm{Ric}}$'s diagonal is $\tfrac a{4\theta(n-2)}\big(C_2-C_0\big)(h_\alpha)$, so the Ricci correction is harmful (negative) on pair directions whose commutator mass sits more on $E_0$ than on $E_2$. That is the side $V_+$ lives on, so any $V_+$-adapted cancellation argument has to be set up with this sign. Magnitudes, the $O(1)$ estimates and the swap discussion are unaffected. The same sign question applies to the other two identities of that paragraph (line 137), which I have not checked beyond noting that they share the reading of $\mathring W$.

## Item 3: the swap paragraph

**The whole-family algebra is right under its hypothesis.** If $g\in O(n)$ has $gE_0g^{\mathsf T}=E_2$ and $gE_2g^{\mathsf T}=E_0$, then $h_{uv}=uv+vu$ is symmetric in $(u,v)$ and equivariant, $Q_0(gh g^{\mathsf T})=Q_2(h)$ by cyclicity, and $\sum_{u,v}Q(h_{uv})$ is basis-independent (a quadratic form traced over $E_0\otimes E_2$). So $\sum_{u,v}Q_0(h_{uv})=\sum_{u,v}Q_2(h_{uv})$.

**The hypothesis is never met at a critical point with $\theta\neq0$.** A swap fixes $E_1$ (orthogonal complement under the orthogonal map $\mathrm{Ad}_g$), so $gWg^{\mathsf T}=-W$. $\mathrm{Ad}_g$ is a Lie algebra automorphism of $\mathfrak{so}(n)$ for every $g\in O(n)$, so $Q(W)=W^2+W^\#$ is equivariant, and $Q$ is quadratic. Then
$$\theta W=Q(W)=Q(-W)=Q(gWg^{\mathsf T})=g\,Q(W)\,g^{\mathsf T}=-\theta W,$$
so $\theta W=0$. **The cancellation in the whole-family trace therefore has no instance on the critical symmetric family.** Whether $\sum_{u,v}(C_2-C_0)(h_{uv})$ vanishes for another reason is open and is not argued in the file. The sentence "the cancellation available is in the whole-family trace" should become: a swap symmetry would give it, and criticality excludes the swap.

**The $V_+$ reading is correct, and sharper than stated.** Under a swap (with the flip $E_0\otimes E_2\to E_2\otimes E_0\cong E_0\otimes E_2$), $M_0\leftrightarrow M_2$, so $B_{\mathrm{lead}}=M_0-M_2\mapsto-B_{\mathrm{lead}}$ and $V_+$ goes to the negative eigenspace, with $T\mapsto-T$. So a swap-symmetric family has $T=0$, which is a second way to see that the certificate regime and swap symmetry are incompatible. The closing alternative "a certificate space that is swap-symmetric" is therefore empty on critical points, and only the $V_+$-adapted cancellation remains as stated.

The reference to [F76](../findings/fence-posts.md) as the whole-family object I read only as far as its heading ("the class-level summed pair test cannot close"), which is consistent with the sentence.

## Item 4: conclusions beyond the items

- **Size, CONFIRMED.** For symmetric $h$, $\sum_{\text{all }\psi}\lVert[\psi,h]\rVert_F^2=2n\lvert h\rvert^2-2(\mathop{\mathrm{tr}}h)^2$ (from the two identities above at $W=\mathrm{Id}$), and $h_{uv}$ is traceless ($\mathop{\mathrm{tr}}h_{uv}=-4\langle u,v\rangle=0$). So $\lvert\langle h,\mathring eh\rangle\rvert\le\tfrac a{2\theta}(C_0+C_2)\le\tfrac a\theta\,n\lvert h\rvert^2=\tfrac n\kappa\lvert h\rvert^2$, which is $O(1)$ in the band. *Screen: Casimir mass over $\lvert h_0\rvert^2$ equal to $12=2n$ at $n=6$.* This is the same order as the first paragraph's bound, so the identity does not improve the size estimate, as the file says.
- **"Vanishes on any $h$ whose commutator mass splits evenly", CONFIRMED**, immediate.
- **"What the identity adds is antisymmetry under $E_0\leftrightarrow E_2$ pointwise in $h$", overstated.** $\tfrac a\theta(Q_2-Q_0)$ is already antisymmetric under relabelling. The content the identity adds is that the $\mathop{\mathrm{tr}}(A_ch^2)$ terms, each $O(1)$ by the first paragraph, cancel exactly by Ricci-flatness, so the correction is a difference of two nonnegative commutator masses.

## Corrections owed to the working file

1. In both paragraphs, $\langle h,\mathring eh\rangle=-\tfrac a\theta(Q_2-Q_0)=\tfrac a{2\theta}(C_0-C_2)$ in L234's convention, or state that the record's line-137 $\mathring W$ is minus L234's pairing.
2. The swap cancellation: add that criticality with $\theta\neq0$ excludes any isometry swapping $E_0$ and $E_2$ ($Q(-W)=Q(W)$ against $Q(gWg^{\mathsf T})=-\theta W$), so the whole-family cancellation has no instance and "a certificate space that is swap-symmetric" is empty.
3. Replace "what the identity adds is antisymmetry" with "the $\mathop{\mathrm{tr}}(A_ch^2)$ parts cancel".
