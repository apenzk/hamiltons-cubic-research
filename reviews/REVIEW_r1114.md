# Reviewer r1114: L238, the Gaussian form of a seven-frame's bracket total and the isotropic bound 42

*Gate 2 review of [L238](../findings/second-order.md) at commit 129ccf08. Analysis first, screens of seconds on constructed objects, reported as screens. Log: [r1114-L238.log](../agent_logs/r1114-L238.log). Scratch scripts in the session scratchpad, uncommitted.*

| # | Claim | Verdict |
|---|---|---|
| 1 | Per-pair identity, both equalities | CONFIRMED |
| 2 | Isserlis step and the constant 168 | CONFIRMED |
| 3 | Restriction to ran P | CONFIRMED |
| 4 | Rank bound on G(v) | CONFIRMED, and it holds for every $v$, not only almost every |
| 5 | Arithmetic of (iii), d at most 4 | CONFIRMED, with a correction: $d\le4$ is impossible, but the case list of (iii) omits $d=5$ (bound $37.8$), which occurs, and the proof never argues $d\ge5$ |
| 6 | Equality frames at d=7,8 | CONFIRMED |
| 7 | Star frame figures | CONFIRMED |
| 8 | Literature sentence | CONFIRMED |
| 9 | Unstated hypotheses, and the "What it does" paragraph | PLAUSIBLE, corrected: "both known $42$-frames lie in it" is contradicted by the next sentence, since the star frame is a third known $42$-frame and it is anisotropic. It is the octonion frame moved by the triality automorphism of $\mathfrak{so}(8)$ |
| L1 | bracket_quad | CONFIRMED |
| L2 | (i) Gaussian form, hypothesis hT | CONFIRMED as a recorded gap |
| L3 | sigma2_le | CONFIRMED, docstring glosses a hypothesis the theorem does not carry |
| L4 | (ii) averaged bound, hypothesis hM | PLAUSIBLE, corrected: hM is (ii) already specialised to $\operatorname{tr}P^2=196/d$, not (ii) for general $P$ |
| L5 | isotropic_frame_bound | CONFIRMED, compiles, non-vacuous |
| L6 | isotropic_frame_d7, isotropic_frame_d8 | CONFIRMED as arithmetic of the bound's value. The frames' own $T=42$ is untyped |

**The lemma stands.** Every link of (i), (ii) and (iii) follows from the one above. The corrections are one missing case in (iii), one missing line ($d\ge5$), and one false sentence in the commentary, which changes the reading of what remains open.

## 1. The per-pair identity

- **First form.** $[X,Y]^2=XYXY-XY^2X-YX^2Y+YXYX$, so by cyclicity $\operatorname{tr}[X,Y]^2=2\operatorname{tr}(XYXY)-2\operatorname{tr}(X^2Y^2)$ and $\lVert[X,Y]\rVert^2=-\tfrac12\operatorname{tr}[X,Y]^2=\operatorname{tr}(X^2Y^2)-\operatorname{tr}(XYXY)$.
- For skew $X,Y$, $S^{\mathsf T}=YX+XY=S$, so $\lVert S\rVert_F^2=\operatorname{tr}S^2=2\operatorname{tr}(XYXY)+2\operatorname{tr}(X^2Y^2)$. With $Q_XQ_Y=X^2Y^2$, $2\operatorname{tr}(Q_XQ_Y)-\tfrac12\lVert S\rVert_F^2=\operatorname{tr}(X^2Y^2)-\operatorname{tr}(XYXY)$. Signs and constants right.
- **Second form.** $\lvert x\wedge y\rvert^2$ is read as the Gram determinant $\lvert x\rvert^2\lvert y\rvert^2-\langle x,y\rangle^2$, which is the record norm of $xy^{\mathsf T}-yx^{\mathsf T}$ (the Frobenius norm would double it). So $\lvert X_iv\wedge X_jv\rvert^2=G_{ii}G_{jj}-G_{ij}^2$, and section 2 gives its mean as $4+2\operatorname{tr}Q_iQ_j-\tfrac12\lVert S_{ij}\rVert_F^2=4+\lVert[X_i,X_j]\rVert^2$. The constant $4=\operatorname{tr}Q_i\operatorname{tr}Q_j$ uses $\operatorname{tr}Q_i=-\operatorname{tr}X_i^2=2\lVert X_i\rVert^2=2$.
- Screen: the first equality to $0$ on random skew pairs at $n=5,9$.

## 2. The Isserlis step and 168

- $G_{ii}=\lvert X_iv\rvert^2=v^{\mathsf T}(-X_i^2)v=v^{\mathsf T}Q_iv$, and $\mathbb E[(v^{\mathsf T}Av)(v^{\mathsf T}Bv)]=\operatorname{tr}A\operatorname{tr}B+2\operatorname{tr}AB$ for symmetric $A,B$ gives $\mathbb E[G_{ii}G_{jj}]=4+2\operatorname{tr}Q_iQ_j$.
- $G_{ij}=(X_iv)^{\mathsf T}X_jv=-v^{\mathsf T}X_iX_jv$, and the symmetric part of $X_iX_j$ is $\tfrac12S_{ij}$, so $G_{ij}=-\tfrac12v^{\mathsf T}S_{ij}v$.
- $\operatorname{tr}S_{ij}=2\operatorname{tr}X_iX_j=-4\langle X_i,X_j\rangle=0$, so $\mathbb EG_{ij}^2=\tfrac14\cdot2\operatorname{tr}S_{ij}^2=\tfrac12\lVert S_{ij}\rVert_F^2$.
- Summing $G_{ii}G_{jj}-G_{ij}^2$ over ordered $i\ne j$ gives $(\operatorname{tr}G)^2-\sum_iG_{ii}^2-\sum_{i\ne j}G_{ij}^2=(\operatorname{tr}G)^2-\lVert G\rVert_F^2$, and $42$ ordered pairs times $4$ is $168$.
- Screen, Monte Carlo with $2\times10^5$ samples on random orthonormal frames: $\mathbb E[\cdot]-168=26.96\pm0.63$ against $T=27.46$ at $n=5$, $21.33\pm0.55$ against $21.98$ at $n=6$, $19.07\pm0.47$ against $18.65$ at $n=8$.

## 3. The restriction to $W=\operatorname{ran}P$

- $Q_i=X_i^{\mathsf T}X_i\succeq0$, so $\ker P=\bigcap_i\ker Q_i=\bigcap_i\ker X_i$. Each $X_i$ vanishes on $\ker P$, and $\operatorname{ran}X_i=(\ker X_i^{\mathsf T})^\perp=(\ker X_i)^\perp\subseteq(\ker P)^\perp=W$.
- Writing $v=w+u$ with $w\in W$, $u\in\ker P$ gives $X_iv=X_iw$ and $v^{\mathsf T}Pv=w^{\mathsf T}Pw$, and $w$ is standard Gaussian on $W$. The restriction is exact.

## 4. The rank bound

- $X_iw\in W$ and $X_iw\perp w$ by skewness, so for $w\ne0$ the seven vectors lie in $W\cap w^\perp$, of dimension $d-1$. At $w=0$, $G=0$. So $\operatorname{rank}G(v)\le\min(7,d-1)$ for **every** $v$, and the pointwise inequality holds everywhere.
- Cauchy–Schwarz on the at most $r$ nonzero eigenvalues gives $\sum\lambda^2\ge(\sum\lambda)^2/r$, which is the pointwise step. Nonnegativity of the eigenvalues is not used.
- $\operatorname{tr}G=\sum_iv^{\mathsf T}Q_iv=v^{\mathsf T}Pv$ and Isserlis gives $\mathbb E(v^{\mathsf T}Pv)^2=196+2\operatorname{tr}P^2$. Since $1-\tfrac1r$ increases in $r$, any $r$ at least the rank works, and $\min(7,d-1)$ is the right choice.
- Screen: the rank of $G$ at $d=5,6$ never exceeded $4,5$.

## 5. The arithmetic of (iii), and $d\le4$

- **$d\le4$ is impossible, but the proof never says so.** The frame's span consists of maps vanishing on $\ker P$ with range in $W$ (section 3), so restriction to $W$ is injective on it, and $7\le\dim\mathfrak{so}(d)=\tfrac{d(d-1)}2$ forces $d\ge5$. This also guarantees $r\ge4>0$ in (ii). The Lean statement carries it as `hd : 5 ≤ d`.
- **The values.** Isotropic $P=\tfrac{14}dI_W$, $\operatorname{tr}P^2=\tfrac{196}d$.

| $d$ | $r$ | bound $(1-\tfrac1r)(196+\tfrac{392}d)-168$ |
|---|---|---|
| 5 | 4 | $\tfrac34\cdot274.4-168=37.8$ |
| 6 | 5 | $\tfrac45\cdot261.\overline3-168=41.0\overline6$ |
| 7 | 6 | $\tfrac56\cdot252-168=42$ |
| $\ge8$ | 7 | $\tfrac67(196+\tfrac{392}d)-168=\tfrac{336}d\le42$ |

- **Correction.** Statement (iii) lists $d\ge8$, $d=6$ and $d=7$ only. $d=5$ occurs in the isotropic class: the orthogonal complement of the irreducible $\mathfrak{so}(3)$ in $\mathfrak{so}(5)$ is a seven-frame with $P$ scalar by Schur. Screen: $P=2.8\,I_5$, $T=25.2\le37.8$. Suggested text: *"the bound of (ii) is $336/d$ for $d\ge8$ and $37.8,\ 41.07,\ 42$ at $d=5,6,7$, where $d\ge5$ because the frame restricts injectively to $W$ and $\dim\mathfrak{so}(4)=6<7$."*

## 6. The equality frames

- **Octonion, $d=8$.** Alternativity gives $L_a^2=L_{a^2}=-\lvert a\rvert^2I$ for imaginary $a$ and, polarised, $L_{e_i}L_{e_j}+L_{e_j}L_{e_i}=-2\delta_{ij}I$. So $X_i=L_{e_i}/2$ has $\lVert X_i\rVert^2=-\tfrac12\operatorname{tr}(-\tfrac14I_8)=1$, the $X_i$ are orthogonal, $Q_i=\tfrac14I_8$ and $P=\tfrac74I_8$. $S_{ij}=0$ and $2\operatorname{tr}Q_iQ_j=1$, so every pair is $1$ and $T=42$. $G(v)=\tfrac14\lvert v\rvert^2I_7$ (composition algebra), so Cauchy–Schwarz is tight at rank $7$.
- **$\mathfrak g_2$ complement, $d=7$.** $C_a x=a\times x$ on $\operatorname{Im}\mathbb O$ satisfies $C_a^2=-(\lvert a\rvert^2I-aa^{\mathsf T})$, so $X_i=C_{e_i}/\sqrt3$ is unit, $Q_i=\tfrac13(I-e_ie_i^{\mathsf T})$ and $P=\tfrac13(7I-I)=2I_7$ directly (the $G_2$-irreducibility argument is also valid: $P$ is basis-independent on the complement and commutes with $G_2$). Polarising, $S_{ij}=\tfrac13(e_ie_j^{\mathsf T}+e_je_i^{\mathsf T})$, so each pair is $\tfrac{10}9-\tfrac19=1$ and $T=42$. $G(v)=\tfrac13(\lvert v\rvert^2I-vv^{\mathsf T})$, six equal nonzero eigenvalues, tight at $r=6$.
- Screen: $T=42.000000$, $P=1.75\,I_8$ and $2\,I_7$, bound of (ii) $42.0000$ for both.

## 7. The star frame

- $X_i=u\wedge w_i=uw_i^{\mathsf T}-w_iu^{\mathsf T}$ with $u,w_1,\dots,w_7$ orthonormal: $X_iX_j=-\delta_{ij}uu^{\mathsf T}-w_iw_j^{\mathsf T}$, so the frame is orthonormal, $Q_i=uu^{\mathsf T}+w_iw_i^{\mathsf T}$, $P=7uu^{\mathsf T}+\sum w_iw_i^{\mathsf T}$, $\operatorname{tr}P^2=49+7=56$, $d=8$.
- Each pair: $2\operatorname{tr}Q_iQ_j=2$ and $\tfrac12\lVert S_{ij}\rVert_F^2=1$, so $1$, and $T=42$. The bound of (ii) is $\tfrac67\cdot308-168=96$.
- With $x_i=w_i\cdot v$, $t=u\cdot v$, $G=xx^{\mathsf T}+t^2I$ as stated. Cross-check of (i): $(\operatorname{tr}G)^2-\lVert G\rVert_F^2=12t^2\lvert x\rvert^2+42t^4$ has mean $84+126=210=168+42$.
- Screen: $T=42.000000$, $\operatorname{tr}P^2=56$, bound $96.0000$.

## 8. The literature sentence

- **Ge 2014.** The filed statement sums over all ordered $(r,s)$ in the Frobenius norm. A record-orthonormal frame has $\lVert X_i\rVert_F^2=2$, so $\sum_{r,s}\lVert[X_r,X_s]\rVert_F^2\le\tfrac23\cdot14^2$, and halving to the record norm gives $T\le\tfrac{196}3=65.3$. The equality configurations have three nonzero matrices in a $4\times4$ block, so "sharp at three matrices" is accurate.
- **Ge–Li–Zhou, survey Thm 3.10** (checked against the filed text, p. 13). The $L_{e_i}$ are a Clifford algebra with $m-1=7$ on $\mathbb R^8$, and $\tfrac48(1-\tfrac17)\cdot196=84$ Frobenius is $42$ in the record norm. A seven-dimensional Clifford span needs $l\ge8$, so the theorem gives at most $42$ there and nothing outside one. Accurate.
- **Lu–Wenzel.** For a record-unit $X_0$ and six orthonormal partners, the fundamental conjecture (survey Conj. 4.9) gives $(2+12)\cdot2=28$ Frobenius, $14$ record, Conj. 4.16 gives $16$, and the spectral form (Conj. 4.14, $k=3$) gives $16$. All exceed $\kappa_6=8$. The spectral form is a theorem for normal $X$ (survey Thm 4.18(i)), which covers skew matrices, so "row bounds" is fair. Accurate.
- "None bounds a fixed-size orthonormal frame" is accurate as a reading of the three filed statements.

## 9. What the statement quietly assumes, and the commentary

- Hypotheses: none missing beyond $d\ge5$ (section 5). The bivector norm in (i) must be the record one, which the displayed identity for $T$ fixes. Nothing else is excluded: $n$ is arbitrary and the bound is uniform in $n$.
- **"Both known $42$-frames lie in it" is false as written.** The very next sentence exhibits the star frame with $T=42$ and $\operatorname{tr}P^2=56\ne196/8$, so after L238 three $42$-frames are known and one of them is anisotropic. The anisotropic class is therefore not a strictly lower region: it reaches the same $42$.
- **Why the star frame totals $42$.** $T$ is a function of the span $V$ alone (it is invariant under $O(7)$ changes of frame) and of the bracket and inner product of $\mathfrak{so}(n)$, so it is preserved by any Lie algebra automorphism that preserves $-\tfrac12\operatorname{tr}$. For $n=8$ the triality automorphism does so (it preserves the Killing form, a multiple of the trace form), and it permutes the three $\mathfrak{spin}(7)$ subalgebras of $\mathfrak{so}(8)$ and hence their seven-dimensional orthogonal complements. The complement of the vector $\mathfrak{so}(7)$ is $\operatorname{span}\{u\wedge w_i\}$, and the complement of a spinorial $\mathfrak{spin}(7)$ is $\Lambda^2_7=\operatorname{span}\{L_{e_i}\}$. So the star frame and the octonion frame are one frame up to triality, with $P=\operatorname{diag}(7,1^7)$ in one representation and $\tfrac74I_8$ in the other. Screen corroborating it: both spans satisfy $\lVert[X,Y]\rVert^2=\lVert X\rVert^2\lVert Y\rVert^2-\langle X,Y\rangle^2$ identically (error $3\times10^{-14}$ on random pairs), the curvature identity of the round $S^7$ read at two presentations. A second screen: $[V,V]$ for the octonion span is $21$-dimensional, orthogonal to $V$, and $[[V,V],V]\subseteq V$ (residual $3\times10^{-16}$), so $V$ is the complement in a symmetric pair $(\mathfrak{so}(8),\mathfrak{spin}(7))$, as the triality reading requires.
- **Consequence for the open part.** $T$ is an invariant of $V$ as a subspace of the Lie algebra, while $P$, $d$ and the bound of (ii) depend on the representation. So the "reduction of an arbitrary frame to an isotropic one that does not lower $T$" that the paragraph asks for exists in this example as an automorphism. This does not generalise automatically: $\mathfrak{so}(n)$ has no triality for $n\ne8$, and other faithful representations change the trace form by the Dynkin index.
- **Suggested replacement** for the first sentences of "What it does": *"The isotropic class is closed at $42$, sharp, and the Clifford and $G_2$ frames lie in it. The anisotropic class also reaches $42$: the star frame $X_i=u\wedge w_i$ has $T=42$ and $\operatorname{tr}P^2=56$, and (ii) returns $96$ there, because $G(v)=xx^{\mathsf T}+t^2I$ has one eigenvalue far from the rest. It is the Clifford frame moved by triality, so the defect is in the bound's dependence on the representation, not in $T$."*

## Lean fidelity

File [FrameGaussianBound.lean](../lean/HamiltonsCubic/Results/FrameGaussianBound.lean), compiled with `lake env lean`: exit 0, no warnings, no `sorry`.

- **bracket_quad.** States $\operatorname{tr}(X^2Y^2)-\operatorname{tr}(XYXY)=2\operatorname{tr}(X^2Y^2)-\tfrac12\operatorname{tr}(S^2)$ for all square real matrices. That is the first equality of (i) once $\lVert[X,Y]\rVert^2$ and $\lVert S\rVert_F^2$ are replaced by their skew-matrix trace forms, which the docstring says. No hypotheses, so nothing to be vacuous. CONFIRMED.
- **hT.** `T = M - 168` with $T,M$ free reals, which is exactly the displayed identity of (i) with $M$ naming the expectation. The Isserlis lemma is honestly recorded as untyped. CONFIRMED as a gap.
- **sigma2_le.** $(\sum g)^2-\sum g^2\le(1-\tfrac1r)(\sum g)^2$ for any $g:\mathrm{Fin}\,r\to\mathbb R$, $r>0$. The docstring says "nonnegative reals", a hypothesis the theorem does not need or carry, so the theorem is stronger than its docstring. Suggest deleting "nonnegative". CONFIRMED.
- **hM.** `M ≤ (1 - 1/r) * (196 + 2 * (196 / d))`. This is the bound of (ii) with $\operatorname{tr}P^2=196/d$ already substituted, so it is (ii) specialised to the isotropic case, which is what `isotropic_frame_bound` needs. The row "(ii) averaged bound with rank bound: enters as hypothesis hM" overstates it: (ii) for general $P$ is typed nowhere, not even as a hypothesis. Also $r$ is any natural with $1\le r\le7$, $r+1\le d$, a harmless generalisation of $r=\min(7,d-1)$ since the rank bound gives the smaller $r$ too. Suggested row: *"(ii) specialised to $\operatorname{tr}P^2=196/d$, with $r\le\min(7,d-1)$: hypothesis hM"*. PLAUSIBLE, corrected.
- **isotropic_frame_bound.** Conclusion $T\le42$ from `hd : 5 ≤ d`, the $r$ bounds, hT and hM, by $r\le7$, $d\ge8$ for the tail and case analysis for $d\in\{5,6,7\}$. Non-vacuous: $d=8$, $r=7$, $M=210$, $T=42$ satisfies every hypothesis with hM tight. The $d=5$ case the prose omits is covered here. CONFIRMED.
- **isotropic_frame_d7, isotropic_frame_d8.** $\tfrac56\cdot252-168=42$ and $\tfrac67\cdot245-168=42$, the value of the bound at $(d,r)=(7,6),(8,7)$. They do not type that the $G_2$ or Clifford frame has $T=42$, although the docstrings name the frames. That fact rests on section 6 and the screen. CONFIRMED as arithmetic.
