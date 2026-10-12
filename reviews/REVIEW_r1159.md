# REVIEW r1159: the Ricci correction as a difference of commutator masses

*Gate 2 reviewer r1159, 2026-09-25, brief [2026-09-25-commutator-mass-gate2-brief.md](2026-09-25-commutator-mass-gate2-brief.md), claims at 4ca4f921 in [the working file](2026-09-25-I73c-per-vector-rows.md). Analysis by hand, one screen of seconds on a constructed tensor, reported as a screen.*

## Verdicts

| item | verdict |
|---|---|
| 1. Ricci contraction is $\sum_\psi\lambda_\psi\psi\psi^{\mathsf T}$, so $A_0=A_2$ | CONFIRMED, constant exactly $+1$ |
| 2. $Q_c=\tfrac12C_c-\operatorname{tr}(A_ch^2)$ | CONFIRMED |
| 2. $\langle h,\mathring eh\rangle=\tfrac a{2\theta}(C_2-C_0)$ | REFUTED as to sign in the convention the Ricci correction uses: the correct form is $\tfrac a{2\theta}(C_0-C_2)$ |
| 3. swap cancellation (algebra) | CONFIRMED as a conditional |
| 3. swap cancellation (as an available mechanism) | REFUTED: the hypothesis is never met at a critical point with $\theta\ne0$ |
| 3. "$V_+$ does not preserve the swap" | CONFIRMED, and stronger: the swap maps $V_+$ onto the negative eigenspace |
| 4. sizes $O(1)$, $O(n/\kappa)$, antisymmetry, even-split vanishing | CONFIRMED |

## Item 1

- With $\langle X,Y\rangle=\tfrac12\operatorname{tr}X^{\mathsf T}Y$ and $\varphi_{ij}=E_{ij}-E_{ji}$, one has $\langle\varphi_{ij},\psi\rangle=\psi_{ij}$, so in the record's four-tensor convention $R_{ijkl}=\langle\varphi_{ij},R\varphi_{kl}\rangle$ ([the projected-pair note](2026-09-23-I73c-projected-pair.md)) the tensor is $W_{ijkl}=\sum_\psi\lambda_\psi\psi_{ij}\psi_{kl}$. The sign of $\varphi_{ij}$ drops out of the product.
- $\operatorname{Ric}_{ik}=\sum_jW_{ijkj}=\sum_\psi\lambda_\psi(\psi\psi^{\mathsf T})_{ik}$. The constant is $+1$: for $\mathrm{Id}$ both sides give $(n-1)I$.
- Ricci-flatness gives $\sum_\psi\lambda_\psi\psi\psi^{\mathsf T}=0$, and at $\lambda=(-a,0,a)$ with $a\ne0$ this is $A_0=A_2$. For skew $\psi$, $\psi\psi^{\mathsf T}=\psi^{\mathsf T}\psi$, so the first paragraph's $A_c$ and the second's agree.
- Screen: a random Weyl tensor at $n=6$ (Bianchi and Ricci residuals $4\times10^{-16}$) has $\lVert\sum\lambda_\psi\psi\psi^{\mathsf T}\rVert_{\max}=1.7\times10^{-14}$.

## Item 2

- The expansion $\operatorname{tr}([\psi,h]^2)=2\operatorname{tr}(\psi h\psi h)-2\operatorname{tr}(\psi^2h^2)$ gives the typed identity, and `trace_psi_h` in [ClassTraceTest.lean](../lean/HamiltonsCubic/Results/ClassTraceTest.lean) states exactly this for arbitrary square matrices.
- For $\psi^{\mathsf T}=-\psi$, $h^{\mathsf T}=h$: $[\psi,h]^{\mathsf T}=-h\psi+\psi h=[\psi,h]$, so $\operatorname{tr}([\psi,h]^2)=\lVert[\psi,h]\rVert_F^2$, and $\psi^2=-\psi\psi^{\mathsf T}$. Summing over $E_c$ gives $Q_c=\tfrac12C_c-\operatorname{tr}(A_ch^2)$.
- **The sign.** In the convention of the boxed formula, $\langle h,\mathring eh\rangle=\sum e_{ijkl}h_{ik}h_{jl}$, one computes $\sum_{ijkl}\psi_{ij}\psi_{kl}h_{ik}h_{jl}=\operatorname{tr}\big((\psi h)^{\mathsf T}h\psi\big)=-\operatorname{tr}(\psi h\psi h)$. Hence $\langle h,\mathring Wh\rangle=-\sum_c\lambda_cQ_c(h)$ in that convention.
- The record's identity $\sum_c\lambda_cQ_c(h)=\mathring W(h,h)$ (the "Criticality on symmetric directions" paragraph) therefore uses the opposite sign of $\mathring{}$. Its own companion $\sum_cQ_c(h)=\mathring{\mathrm{Id}}(h,h)$ shows it: $\sum_{\text{all }\psi}\operatorname{tr}(\psi h\psi h)=\lvert h\rvert^2-(\operatorname{tr}h)^2$, while $\sum\mathrm{Id}_{ijkl}h_{ik}h_{jl}=(\operatorname{tr}h)^2-\lvert h\rvert^2$ (Hamilton's $\mathring R h=(\operatorname{tr}h)g-h$ on the round sphere). The identity is internally consistent read as $\mathring W(h,h):=\sum_\psi\lambda_\psi\operatorname{tr}(\psi h\psi h)$, which is minus the boxed formula's.
- **Correction.** With $e$ read as in $B_{\mathrm{Ric}}=-\tfrac1{2(n-2)}\big(\langle h_\alpha,\mathring eh_\beta\rangle\big)$ and in the Huisken paragraph,
$$\langle h,\mathring eh\rangle=\frac a\theta\big(Q_0(h)-Q_2(h)\big)=\frac a{2\theta}\big(C_0(h)-C_2(h)\big),\qquad B_{\mathrm{Ric}}\text{ diagonal}=\frac a{4\theta(n-2)}\big(C_2(h)-C_0(h)\big).$$
The first paragraph's $\tfrac a\theta(Q_2-Q_0)$ carries the same sign error. Nothing already concluded depends on the sign (the bounds are in absolute value and the antisymmetry is sign-blind), but any statement about the negative part of $B_{\mathrm{Ric}}$ does.
- Screen, same tensor, random traceless $h$: $\sum W_{ijkl}h_{ik}h_{jl}=-132.224$, $\sum\lambda_cQ_c=+132.224$, $\tfrac12\sum\lambda_\psi\lVert[\psi,h]\rVert^2=+132.224$. For $\mathrm{Id}$: $\sum Q=+61.666=\lvert h\rvert^2$ and $\sum\mathrm{Id}_{ijkl}h_{ik}h_{jl}=-61.666$.

## Item 3

- **The conditional algebra holds.** For $g\in O(n)$, conjugation is an isometry of $\Lambda^2$ preserving brackets. If $gE_0g^{\mathsf T}=E_2$ and $gE_2g^{\mathsf T}=E_0$, then $Q_2(ghg^{\mathsf T})=Q_0(h)$, $g\,h_{uv}g^{\mathsf T}=h_{gvg^{\mathsf T},\,gug^{\mathsf T}}$ with $h_{uv}=h_{vu}$, and $\sum_{u,v}Q_c(h_{uv})$ is basis-independent (a trace of a quadratic form on $E_0\otimes E_2$). So $\sum_{u,v}(Q_2-Q_0)(h_{uv})=0$.
- **The hypothesis is vacuous at every critical point with $\theta\ne0$.** Such a $g$ maps $W=a(P_2-P_0)$ to $-W$. The critical equation $W^2+W^\#=\theta W$ is $O(n)$-equivariant and its left side is even in $W$, so applying $g$ gives $W^2+W^\#=-\theta W$, whence $\theta W=0$. Equivalently $\theta=\langle W,W^2+W^\#\rangle$ is odd in $W$ and conjugation-invariant. The programme works at $\theta\ge\theta_0>0$, so no swap-symmetric spectrum occurs, and the whole-family cancellation is available nowhere.
- **A second, independent obstruction.** Writing $\sigma(u\otimes v)=gvg^{\mathsf T}\otimes gug^{\mathsf T}$, one gets $P_0C\sigma=-gP_2C$ (as maps into $\Lambda^2$ up to the isometry $g$), so $\sigma^{\mathsf T}B_{\mathrm{lead}}\sigma=M_2-M_0=-B_{\mathrm{lead}}$ and $T=\operatorname{tr}B_{\mathrm{lead}}=0$. In the band the record has $T>p/4$, so swap symmetry is excluded there by the leading order too.
- **The $V_+$ reading** is correct and understates the case: $\sigma$ maps $V_+$ onto the negative eigenspace of $B_{\mathrm{lead}}$. "Lives on $P_0C$" is loose ($V_+$ is the positive eigenspace of $M_0-M_2$, of dimension at most $\operatorname{rank}M_0$), but the conclusion stands.
- **Correction.** The paragraph's closing alternative ("a certificate space that is swap-symmetric") and the phrase "the cancellation available is in the whole-family trace" should go: the whole-family trace carries no symmetry-forced cancellation at a critical point. What survives is the pointwise antisymmetry of item 2, which is an identity and needs no $g$.

## Item 4

- $\lvert Q_c(h)\rvert\le\operatorname{tr}(A_ch^2)$ follows from Cauchy–Schwarz, $\lvert\operatorname{tr}(\psi h\psi h)\rvert=\lvert\langle h\psi,\psi h\rangle_F\rvert\le\lVert h\psi\rVert_F\lVert\psi h\rVert_F=\operatorname{tr}(\psi\psi^{\mathsf T}h^2)$. Isotropic $A_c=\tfrac{2p}nI$ since $\operatorname{tr}\psi\psi^{\mathsf T}=2$. Then $\tfrac a\theta\cdot\tfrac{2p}n=\kappa/(\theta^2n)=O(1)$ in the band, where $\kappa\sim n$.
- The full Casimir mass is $\sum_{\text{all }\psi}\lVert[\psi,h]\rVert^2=2n\lvert h\rvert^2-2(\operatorname{tr}h)^2$ (from item 2 with $\sum\psi\psi^{\mathsf T}=(n-1)I$), and $h_{uv}$ is traceless for $u\perp v$. With $a/\theta=1/\kappa$ the bound is $\tfrac n\kappa\lvert h\rvert^2=O(1)$, as stated.
- Antisymmetry under $E_0\leftrightarrow E_2$ and vanishing when $C_0(h)=C_2(h)$ are immediate from the corrected formula and hold with either sign. No conclusion is stated beyond these.
