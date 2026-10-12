# Reviewer r1113: L238, the Gaussian form of a seven-frame's bracket total and the isotropic bound 42

*Gate 2 review of [L238](../findings/second-order.md) at commit 129ccf08. Analysis first, then one screen of two seconds on eight constructed frames, reported as a screen. Log: [r1113-L238.log](../agent_logs/r1113-L238.log). Scratch script in the session scratchpad, uncommitted.*

| # | Claim | Verdict |
|---|---|---|
| 1 | Per-pair identity, both equalities | CONFIRMED, for $i\ne j$ (the $-4$ form fails at $i=j$, which "for each pair" should exclude in words) |
| 2 | Isserlis step and the constant 168 | CONFIRMED |
| 3 | Restriction to $\operatorname{ran}P$ | CONFIRMED |
| 4 | Rank bound $\min(7,d-1)$ | CONFIRMED, for every $v$ |
| 5 | Arithmetic of (iii), and $d\le4$ | CONFIRMED. $d\ge5$ holds since $\dim\mathfrak{so}(4)=6<7$ but the prose never says so, and $d=5$ (bound $37.8$) is omitted from the case list |
| 6 | Equality frames at $d=7,8$ | CONFIRMED |
| 7 | Star frame figures | CONFIRMED |
| 8 | Literature sentence | PLAUSIBLE, corrected: the figures are right, "None bounds a fixed-size orthonormal frame" contradicts the $65.3$ two clauses earlier, and the Lu–Wenzel statements are conjectures |
| 9 | Unstated hypotheses and quiet exclusions | REFUTED in one sentence: "both known $42$-frames lie in it" is false, the star frame of the same paragraph is a known $42$-frame with anisotropic $P$ |
| L1 | bracket_quad | CONFIRMED as the trace form |
| L2 | sigma2_le | CONFIRMED |
| L3 | isotropic_frame_bound, hypotheses hT, hM | CONFIRMED as the closing arithmetic, non-vacuous, hT and hM match the prose |
| L4 | isotropic_frame_d7, isotropic_frame_d8 | CONFIRMED as the bound's value at $d=7,8$, with the frames' $T=42$ is untyped |

**The mathematics of L238 is correct throughout.** One sentence of "What it does" is false and the literature sentence contradicts itself. Both are text corrections, and neither touches (i) to (iii).

## 1. The per-pair identity

- **First equality.** For skew $X,Y$, $[X,Y]^2=XYXY-XY^2X-YX^2Y+YXYX$, so $\operatorname{tr}[X,Y]^2=2\operatorname{tr}(XYXY)-2\operatorname{tr}(X^2Y^2)$ and $\lVert[X,Y]\rVert^2=-\tfrac12\operatorname{tr}[X,Y]^2=\operatorname{tr}(X^2Y^2)-\operatorname{tr}(XYXY)$. $S=XY+YX$ is symmetric ($S^{\mathsf T}=YX+XY$), so $\lVert S\rVert_F^2=\operatorname{tr}S^2=2\operatorname{tr}(XYXY)+2\operatorname{tr}(X^2Y^2)$. With $\operatorname{tr}(Q_iQ_j)=\operatorname{tr}(X^2Y^2)$, $2\operatorname{tr}(Q_iQ_j)-\tfrac12\lVert S\rVert_F^2=\operatorname{tr}(X^2Y^2)-\operatorname{tr}(XYXY)$. Signs and constants right.
- **Second equality.** $\lvert a\wedge b\rvert^2=\lvert a\rvert^2\lvert b\rvert^2-\langle a,b\rangle^2=G_{ii}G_{jj}-G_{ij}^2$. With section 2's moments, $\mathbb E\lvert X_iv\wedge X_jv\rvert^2=4+2\operatorname{tr}Q_iQ_j-\tfrac12\lVert S_{ij}\rVert_F^2=4+\lVert[X_i,X_j]\rVert^2$. Right.
- **Needs $i\ne j$.** At $i=j$ the wedge is zero and the bracket is zero, so "$=\mathbb E\lvert\cdot\rvert^2-4$" would read $0=-4$. The first equality does hold at $i=j$. Suggested text: *"(i) For each pair $i\ne j$, ..."*.

## 2. The Isserlis step and 168

- $G_{ii}=\lvert X_iv\rvert^2=v^{\mathsf T}X_i^{\mathsf T}X_iv=v^{\mathsf T}Q_iv$, $\operatorname{tr}Q_i=-\operatorname{tr}X_i^2=2\lVert X_i\rVert^2=2$. Isserlis gives $\mathbb E[G_{ii}G_{jj}]=2\cdot2+2\operatorname{tr}Q_iQ_j$. Right.
- $G_{ij}=v^{\mathsf T}X_i^{\mathsf T}X_jv=-v^{\mathsf T}X_iX_jv=-\tfrac12v^{\mathsf T}S_{ij}v$ (a quadratic form sees only the symmetric part). $\operatorname{tr}S_{ij}=2\operatorname{tr}X_iX_j=-4\langle X_i,X_j\rangle=0$. So $\mathbb EG_{ij}^2=\tfrac14\big((\operatorname{tr}S)^2+2\operatorname{tr}S^2\big)=\tfrac12\lVert S_{ij}\rVert_F^2$. Right.
- **The sum.** $\sum_{i\ne j}(G_{ii}G_{jj}-G_{ij}^2)=(\operatorname{tr}G)^2-\sum_iG_{ii}^2-\sum_{i\ne j}G_{ij}^2=(\operatorname{tr}G)^2-\lVert G\rVert_F^2$, and $42$ ordered pairs times $4$ is $168$. Right.

## 3. The restriction to $W=\operatorname{ran}P$

- $Q_i=X_i^{\mathsf T}X_i\succeq0$, so $\ker P=\bigcap_i\ker Q_i=\bigcap_i\ker X_i$. Every $X_i$ vanishes on $\ker P$.
- $\operatorname{ran}X_i=(\ker X_i^{\mathsf T})^\perp=(\ker X_i)^\perp\subseteq(\ker P)^\perp=\operatorname{ran}P$. Every $X_i$ maps into $W$.
- $G(v)$ depends only on the $W$-component $v_W$, which is standard Gaussian on $W$. $\mathbb E(v^{\mathsf T}Pv)^2=(\operatorname{tr}P)^2+2\operatorname{tr}P^2=196+2\operatorname{tr}P^2$ is the same computed in $\mathbb R^n$ or in $W$. The restriction is used only for the rank.

## 4. The rank bound

- $X_iv=X_iv_W\perp v_W$ by skewness, and $X_iv\in W$. So the seven vectors lie in $W\cap v_W^\perp$, of dimension $d-1$ when $v_W\ne0$. When $v_W=0$ all seven vanish, $G=0$, and the pointwise inequality reads $0\le0$. **So it holds for every $v$**, and "almost every" is not needed.
- The pointwise step: with at most $r$ nonzero eigenvalues $g_k$, $(\sum g_k)^2\le r\sum g_k^2$ by Cauchy–Schwarz, which is the stated inequality. It needs $r\ge1$, i.e. $d\ge2$, and $1-\tfrac1r\ge0$ for the averaging, both guaranteed by section 5.

## 5. The arithmetic of (iii)

- **$d\ge5$.** The $X_i$ restrict to seven linearly independent elements of $\mathfrak{so}(W)$, and $\dim\mathfrak{so}(4)=6$, so $d\ge5$. The prose does not state this, while [isotropic_frame_bound](../lean/HamiltonsCubic/Results/FrameGaussianBound.lean) assumes it as `hd : 5 ≤ d`. Suggested addition to (iii): *"($d\ge5$ since $\dim\mathfrak{so}(4)=6$)"*. The bound is at most $42$ at every $d\ge2$ anyway ($28$ at $d=4$, negative below), so the conclusion does not depend on it.
- **Isotropic.** $P=cI_W$, $cd=14$, $\operatorname{tr}P^2=196/d$. The bound is $(1-\tfrac1r)(196+\tfrac{392}d)-168$:
  - $d=5$, $r=4$: $\tfrac34\cdot274.4-168=37.8$. **Omitted from the statement's case list.**
  - $d=6$, $r=5$: $\tfrac45\cdot261.\overline3-168=41.0\overline6$. Right.
  - $d=7$, $r=6$: $\tfrac56\cdot252-168=42$. Right.
  - $d\ge8$, $r=7$: $\tfrac67(196+\tfrac{392}d)-168=\tfrac{336}d\le42$. Right.
- Suggested text: *"the bound of (ii) is $336/d$ for $d\ge8$ and $37.8,\ 41.07,\ 42$ at $d=5,6,7$"*.
- **The $d=5$ class is not empty.** The orthogonal complement of the irreducible $\mathfrak{so}(3)\subset\mathfrak{so}(5)$ (spin $2$) is a seven-frame with $P=\tfrac{14}5I_5$ by Schur. Screen: $T=25.2$ there, below $37.8$.

## 6. The equality frames

- **Octonion, $d=8$.** $L_x^2=L_{x^2}=-\lvert x\rvert^2I$ for imaginary $x$ by alternativity, so the $L_{e_i}$ pairwise anticommute and square to $-I$. $X_i=L_{e_i}/2$ has $\lVert X_i\rVert^2=-\tfrac12\operatorname{tr}(-I_8/4)=1$, $Q_i=\tfrac14I_8$, $P=\tfrac74I_8$. For $i\ne j$, $[X_i,X_j]=\tfrac12L_{e_i}L_{e_j}$ with $(L_{e_i}L_{e_j})^2=-I$, so $\lVert[X_i,X_j]\rVert^2=\tfrac14\cdot4=1$ and $T=42$. Right.
- **$\mathfrak g_2$ complement, $d=7$.** $\mathfrak{so}(7)=\mathfrak g_2\oplus\mathfrak m$ with $\mathfrak m=\{C_a:v\mapsto a\times v\}$. $C_a^2v=-\lvert a\rvert^2v+\langle a,v\rangle a$, so $\lVert C_{e_i}\rVert^2=3$, $X_i=C_{e_i}/\sqrt3$, $Q_i=\tfrac13(I-e_ie_i^{\mathsf T})$, $P=\tfrac13(7I-I)=2I_7$. The $G_2$-irreducibility argument gives the same by Schur. $T=42$ by [r1112](REVIEW_r1112.md) section 3 and the screen below.
- **Screen** (exact, not Monte Carlo): $T=42.000000$, $P$ eigenvalues exactly $\tfrac74$ and $2$, $\operatorname{tr}P^2=24.5$ and $28$, and the (ii) bound $42.0000$ in both. Sampled $\operatorname{rank}G(v)$ is $7$ and $6$, the stated $r$.

## 7. The star frame

- $X_i=u\wedge w_i=uw_i^{\mathsf T}-w_iu^{\mathsf T}$. For $i\ne j$, $X_iX_j=-w_iw_j^{\mathsf T}$, so $[X_i,X_j]=w_j\wedge w_i$, unit, and $T=42$.
- $Q_i=uu^{\mathsf T}+w_iw_i^{\mathsf T}$, $P=7uu^{\mathsf T}+\sum_iw_iw_i^{\mathsf T}$, $d=8$, $\operatorname{tr}P^2=49+7=56$. The (ii) bound: $\tfrac67(196+112)-168=264-168=96$. Right.
- $X_iv=x_iu-tw_i$ with $x_i=\langle w_i,v\rangle$, $t=\langle u,v\rangle$, so $G=xx^{\mathsf T}+t^2I$. Right.

## 8. The literature sentence

- **Ge, $65.3$.** A record-unit $B$ has $\lVert B\rVert_F^2=2$, so $\sum_r\lVert B_r\rVert_F^2=14$, Ge's bound is $\tfrac23\cdot196=130.\overline6$ over ordered pairs in Frobenius norm, and halving the bracket norms gives $65.\overline3$. Right. "Sharp at three matrices" matches the filed equality case ([notes](../references/ge-2014-ddvv-skew-symmetric/notes.md)): three nonzero matrices in a $\mathfrak{so}(4)$ block.
- **Ge–Li–Zhou, $42$.** The $L_{e_i}$ are a Clifford system on $\mathbb R^8$ ($l=8$, $m-1=7$). Seven record-unit $B_r$ give $\tfrac48(1-\tfrac17)\cdot196=84$ in Frobenius, $42$ in the record norm. "Only inside a Clifford span" is right.
- **Lu–Wenzel.** In the record norm Conjecture 2 (or 6) gives a row of at most $\tfrac12(2+12)\cdot2=14$, and Conjecture 4 at $k=3$ gives a top-six sum of $-\mathrm{ad}_X^2$ at most $2\cdot8=16$. Both are weaker than $\kappa_6=8$. Right. **They are conjectures**, proved in special cases, which "row bounds" does not say.
- **"None bounds a fixed-size orthonormal frame" is false as written**: Ge bounds every seven-frame by $65.3$, as the sentence itself says. Suggested text: *"None bounds a seven-frame below $54.064$."* and *"the Lu–Wenzel row conjectures (proved in special cases)"*.

## 9. What the statement quietly excludes

- **"Both known $42$-frames lie in it": REFUTED.** The star frame of the next sentence has $T=42$ and $P$ with eigenvalues $7,1^7$, so at least three $42$-frames are known and one is anisotropic. [r1112](REVIEW_r1112.md)'s gradient screens also ended at $42$ at $n=9,10,12$, with no record of whether those frames are isotropic. **So the anisotropic remainder contains frames at the conjectured maximum**, and closing it at $42$ is the whole equality question, not a residue. Suggested text: *"The isotropic class is closed at $42$, sharp, and contains the octonion and $G_2$ frames. What remains is anisotropic $P$, which also reaches $42$ (the star frame) and where step (ii) loses: ..."*.
- **$i\ne j$ in (i)**, section 1.
- **$d\ge5$**, section 5.
- Nothing else. The orthonormality that fixes the constant $4$ and $\operatorname{tr}S_{ij}=0$ is in the Setting, and (ii) holds for every $v$, section 4.

## Lean

[FrameGaussianBound.lean](../lean/HamiltonsCubic/Results/FrameGaussianBound.lean) compiles clean in 16 s, no warnings. All five declarations depend on `propext`, `Classical.choice`, `Quot.sound` only.

- **bracket_quad.** Types $\operatorname{tr}(XXYY)-\operatorname{tr}(XYXY)=2\operatorname{tr}(XXYY)-\tfrac12\operatorname{tr}(SS)$ for all square matrices, by cyclicity. The two skew-dependent links, $\lVert[X,Y]\rVert^2$ equal to the left side and $\lVert S\rVert_F^2=\operatorname{tr}S^2$, are untyped, which the row's "trace form" already says.
- **sigma2_le.** Types $(\sum g)^2-\sum g^2\le(1-\tfrac1r)(\sum g)^2$ for any $r\ge1$ reals, sign-free. The passage to $G$'s spectrum (padding to $r$ nonzero eigenvalues) is untyped and is one line.
- **isotropic_frame_bound.** Pure arithmetic on reals $T,M$, with `hT : T = M - 168` being (i) summed and `hM` being (ii) with $\operatorname{tr}P^2=196/d$ substituted. It allows any $1\le r\le\min(7,d-1)$, a harmless generalisation since $1-\tfrac1r$ increases in $r$. **Non-vacuous**: the instance $d=8$, $r=7$, $M=210$, $T=42$ was compiled. `hd : 5 ≤ d` is section 5's unargued step.
- **isotropic_frame_d7, isotropic_frame_d8.** Type $\tfrac56\cdot252-168=42$ and $\tfrac67\cdot245-168=42$, the bound's value. That the two frames reach $T=42$ is untyped, and the docstrings naming them are commentary.

## Screen

Two seconds, eight frames (octonion, $G_2$, star, the $\mathfrak{so}(3)$-irreducible complement in $\mathfrak{so}(5)$, random frames at $n=5,6,9,12$). The per-pair identity and $\operatorname{tr}S_{ij}=-4\langle X_i,X_j\rangle$ hold to $5\times10^{-16}$, and the exact Isserlis value of $\mathbb E[(\operatorname{tr}G)^2-\lVert G\rVert_F^2]-168$ equals $T$ to machine precision in all eight. A Monte Carlo average agrees within sampling noise, and sampled $\operatorname{rank}G(v)$ never exceeds $\min(7,d-1)$. Reported as a screen.
