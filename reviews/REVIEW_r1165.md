# REVIEW r1165: the band's Ricci requirement and the product reduction

Brief: [2026-09-25-ricci-requirement-gate2-brief.md](2026-09-25-ricci-requirement-gate2-brief.md). Claims read at 35c6a7eb in [the working file](2026-09-25-I73c-per-vector-rows.md), the two paragraphs "What the band needs from the Ricci correction, quantitatively" and "The Ricci part of a pair combination is what its product leaves after the bracket". Analysis by hand from the definitions and the audited givens. One screen of seconds on random matrices (n = 7) checked two normalisations and is reported as a screen only.

## Verdicts

| item | verdict |
|---|---|
| 1. Ricci size $n/(4\kappa)$ and margin $(\kappa-n+5)/(32\kappa)$ | CONFIRMED (arithmetic), with the ratio sharpened |
| 1'. "the band closes only through one of two facts" | PLAUSIBLE, overstated: correction below |
| 2. skew part $\tfrac12Cx$, symmetric part $-h_x$, Frobenius identity | CONFIRMED, with a units note for $Cx$ |
| 3a. the equivalence with $\lVert X_x\rVert_F^2\le\tfrac14\lVert Cx\rVert_F^2+O(1)$ | CONFIRMED (tautological from the identity) |
| 3b. "$Cx$ is large on $V_+$" from $x^{\mathsf T}M_0x>x^{\mathsf T}M_2x$ | REFUTED as argued, true on the certificate's vectors by a different argument |
| 4. conclusions beyond support | yes, three, listed below |

## Item 1

**The Ricci bound.** $G$ is a Gram matrix, so $G\succeq0$, and with $G=\tfrac12I-H/(n-2)-\Omega$, $\Omega\succeq0$ ([r1146](REVIEW_r1146.md)) this gives $H\preceq\tfrac{n-2}2I$. For a unit coefficient vector $x$ (Euclidean norm on the coefficients over the orthonormal bases of $E_0$ and $E_2$, the units in which $G$ has diagonal about $\tfrac12$), $x^{\mathsf T}Hx=\lvert h_x\rvert^2\le\tfrac{n-2}2$. With [r1160](REVIEW_r1160.md)'s bound, $\lvert x^{\mathsf T}B_{\mathrm{Ric}}x\rvert\le\tfrac1{2(n-2)}\cdot\tfrac n\kappa\cdot\tfrac{n-2}2=\tfrac n{4\kappa}$. In the band $n-5\le\kappa\lesssim(n-2)(1+\delta)$, so this is about $\tfrac14$. CONFIRMED.

**The norm of $h$.** The record's $\lvert h\rvert$ is the Frobenius norm: the projected-pair note's $\lVert k\owedge g\rVert^2=(n-2)\lvert k\rvert^2$ on diagonal traceless $k$ reads $\sum_{i<j}(k_i+k_j)^2=(n-2)\sum k_i^2$, which is Frobenius. So $\lvert h\rvert=\lvert h\rvert_F$ throughout, and $H_{\alpha\beta}=\langle h_\alpha,h_\beta\rangle_F$.

**The margin's units.** Since $x^{\mathsf T}Gx\le\tfrac12\lvert x\rvert^2$, $\lambda_{\max}(L_e)\ge2\max_{\lvert x\rvert=1}x^{\mathsf T}B_{\mathrm{full}}x$ whenever that maximum is positive, so the exclusion $\lambda_{\max}(L_e)>\tfrac12$ follows from one unit $x$ with $x^{\mathsf T}B_{\mathrm{full}}x>\tfrac14$. The certificate gives a unit $x$ (a top eigenvector of $B_{\mathrm{lead}}$) with $x^{\mathsf T}B_{\mathrm{lead}}x\ge T/p$, and L247's $2T/p-\tfrac12\ge(\kappa-n+5)/(16\kappa)$ halves to $T/p-\tfrac14\ge(\kappa-n+5)/(32\kappa)$. The factor between $\lambda_{\max}(L_e)$ and $\lambda_{\max}(B)$ is exactly $2$, so the margin in $B$ units is $(\kappa-n+5)/(32\kappa)$, at leading order as L247 states. Near $\theta_0$, $\kappa-n+5\lesssim3$ and $\kappa\approx n-2$, giving $\lesssim3/(32n)$. CONFIRMED.

**Sharpening.** The ratio of the a priori Ricci size to the margin is $\tfrac n{4\kappa}\big/\tfrac{\kappa-n+5}{32\kappa}=\tfrac{8n}{\kappa-n+5}$, which is at least about $\tfrac83n$ near $\theta_0$ and unbounded at the band's lower edge. "About $n$ times too large" holds as an order statement. The record would be more exact as "at least $8n/3$ times, and without bound at the lower edge".

## Item 1': the dichotomy

The sentence "the band closes only through one of two facts about $V_+$" is correct as the diagnosis of what the per-vector route needs, with three corrections.

- **The threshold is a small constant, vanishing at the lower edge.** Through the Casimir bound, the Ricci term is below the margin on $x$ once $\tfrac n{2(n-2)\kappa}\lvert h_x\rvert^2<\tfrac{\kappa-n+5}{32\kappa}$, i.e. $\lvert h_x\rvert^2<\tfrac{(n-2)(\kappa-n+5)}{16n}\approx\tfrac{\kappa-n+5}{16}\lesssim\tfrac3{16}$. "$O(1)$ rather than $O(n)$" states the scale correctly and leaves out that the constant is at most about $3/16$ and goes to $0$ at $\kappa=n-5$.
- **The balance condition is one-sided.** With the corrected sign, $x^{\mathsf T}B_{\mathrm{Ric}}x=\tfrac a{4\theta(n-2)}\big(C_2-C_0\big)(h_x)$, which is harmless or helpful whenever $C_2(h_x)\ge C_0(h_x)$. The requirement is that the excess $C_0(h_x)-C_2(h_x)$ be small, and a mass leaning to $E_2$ satisfies it. "Nearly balance" is sufficient and narrower than needed.
- **"Only" holds for this route, given what is on file.** The exclusion needs one unit $x$, anywhere, with $x^{\mathsf T}B_{\mathrm{full}}x>\tfrac14$. It does not need the Ricci term small on all of $V_+$, and a vector where $x^{\mathsf T}B_{\mathrm{lead}}x$ exceeds $T/p$ (the certificate's bound is attained only when the positive eigenvalues are equal) or where $x^{\mathsf T}B_{\Lambda^4}x>0$ carries a larger margin. The two facts are what the band needs when $B_{\mathrm{lead}}$ is known only through $T/p$ and the $\Lambda^4$ term only through its size, which is the state of the record.

The closing sentence, that neither fact follows from the rows on file, is consistent with everything I read.

## Item 2

The pair family's $u\in E_0$, $v\in E_2$ are skew matrices, so $(uv)^{\mathsf T}=v^{\mathsf T}u^{\mathsf T}=vu$. The skew part of $X_x=\sum x_{uv}uv$ is $\tfrac12\sum x_{uv}(uv-vu)=\tfrac12Cx$ and its symmetric part is $\tfrac12\sum x_{uv}\{u,v\}=-\sum x_{uv}h_{uv}=-h_x$ with $h_{uv}=-\tfrac12\{u,v\}$, exactly. Skew and symmetric matrices are Frobenius-orthogonal, and [skew_sym_split](../lean/HamiltonsCubic/Results/ClassTraceTest.lean#L99) states $\operatorname{tr}(X^{\mathsf T}X)=\lVert\tfrac12(X-X^{\mathsf T})\rVert_F^2+\lVert\tfrac12(X+X^{\mathsf T})\rVert_F^2$, which is the identity used. So $\lvert h_x\rvert_F^2=\lVert X_x\rVert_F^2-\tfrac14\lVert Cx\rVert_F^2$. CONFIRMED. Screen: random skew $u,v$ at $n=7$, both sides agree to $10^{-12}$ relative.

**Units note.** The record's unit $u\in\Lambda^2$ has $\lVert u\rVert_F^2=2$ (basis $\varphi_{ij}=E_{ij}-E_{ji}$). This is what makes [r1160](REVIEW_r1160.md)'s Casimir mass $2n\lvert h\rvert^2$, and the screen returns exactly $2$ for $\sum_\psi\lVert[\psi,h]\rVert_F^2/(n\lvert h\rvert_F^2)$ in that basis. So the $\Lambda^2$ norm in which $M_c=\tfrac a{4\theta}(P_cC)^{\mathsf T}(P_cC)$ is written is half the Frobenius square: $x^{\mathsf T}M_cx=\tfrac a{4\theta}\lVert P_cCx\rVert_{\Lambda^2}^2=\tfrac a{8\theta}\lVert P_cCx\rVert_F^2$. The identity itself is internally consistent because it writes $\lVert Cx\rVert_F$ explicitly. A reader combining it with $M_c$ needs the factor $2$, and the paragraph should say so.

## Item 3

**3a, the equivalence.** From the identity, $\lvert h_x\rvert^2\le K$ if and only if $\lVert X_x\rVert_F^2\le\tfrac14\lVert Cx\rVert_F^2+K$, with the same constant $K$, for every $x$. It needs nothing about $Cx$ and nothing about $V_+$. CONFIRMED, as a restatement. With item 1', $K$ is about $(\kappa-n+5)/16$ rather than an unspecified $O(1)$.

**3b, "$Cx$ is large on $V_+$".** The cited reason fails: $x^{\mathsf T}M_0x>x^{\mathsf T}M_2x$ says $\lVert P_0Cx\rVert>\lVert P_2Cx\rVert$, a comparison, and it holds for $x\in V_+$ with $\lVert Cx\rVert$ arbitrarily small relative to $\lvert x\rvert$ (any vector of $V_+$ with a tiny positive Rayleigh quotient). REFUTED as argued.

**Repair.** On the vectors the certificate actually uses, magnitude does follow: $x^{\mathsf T}M_0x\ge x^{\mathsf T}B_{\mathrm{lead}}x\ge T/p\ge\tfrac14$, so $\lVert P_0Cx\rVert_{\Lambda^2}^2\ge\theta/a=\kappa$, i.e. $\tfrac14\lVert Cx\rVert_F^2\ge\tfrac14\lVert P_0Cx\rVert_F^2\ge\kappa/2$ (using $\kappa=\theta/a$, the relation that turns the Casimir bound $\tfrac a{2\theta}\cdot2n$ into $\tfrac n\kappa$). This is of order $n$, the same order as the a priori ceiling $\lvert h_x\rvert^2\le\tfrac{n-2}2$. So on those vectors the requirement $\lvert h_x\rvert^2\lesssim(\kappa-n+5)/16$ does say the product is almost entirely skew, with symmetric fraction $\lvert h_x\rvert^2/\lVert X_x\rVert_F^2\lesssim(\kappa-n+5)/(8\kappa)$. The sentence should read "on the certificate's top vectors ($x^{\mathsf T}B_{\mathrm{lead}}x\ge T/p$) the bracket satisfies $\tfrac14\lVert Cx\rVert_F^2\ge\kappa/2$", in place of "on $V_+$ ... since $x^{\mathsf T}M_0x>x^{\mathsf T}M_2x$".

The final remark, that the rows constrain these products through $P_0[E_0,E_2]=E_0$ without bounding them, is a description of the record's state and I found nothing against it.

## Item 4: conclusions beyond support

1. "The band closes only through one of two facts": holds for the per-vector route with $B_{\mathrm{lead}}$ known only through $T/p$ and the $\Lambda^4$ term signless. As a statement about the band it is too strong (item 1').
2. "Nearly balance" in place of the one-sided "$C_0(h_x)-C_2(h_x)$ small" (item 1').
3. "$Cx$ is large on $V_+$" from the comparison $M_0>M_2$: false on $V_+$ as a whole, true with the bound $\tfrac14\lVert Cx\rVert_F^2\ge\kappa/2$ on the certificate's top vectors (item 3b).

Beyond these, "$O(1)$" in both paragraphs should carry its constant, about $(\kappa-n+5)/16\lesssim3/16$. Nothing in either paragraph claims a bound the givens do not supply, and both are correctly labelled as scale arithmetic and algebra with no computation.
