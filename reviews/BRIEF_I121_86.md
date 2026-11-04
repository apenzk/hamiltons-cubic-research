# Gate 2 brief, identity (86) and the finite-angle inequality, for I121 (route R52)

**Cold brief. Every passage below is quoted verbatim from [reviews/2026-09-28-I121-MG-audit.md](2026-09-28-I121-MG-audit.md) as it stands at dispatch. You are asked to break the claims.** Verdicts per claim: CONFIRMED, PLAUSIBLE or REFUTED with corrections. **The analysis-only footing applies**: argue from the definitions; a computation is allowed only to refute, as the smallest one that does the job, with the reason the argument could not.

## Definitions and givens

- $\mathcal W_n$ is the space of Weyl curvature operators on $\Lambda^2\mathbb R^n$, Hilbert–Schmidt inner product. Hamilton's $Q(R)=R^2+R^\#$, its symmetric polarisation $Q(X,Y)$ with $Q(X,X)=Q(X)$, $P(X)=\langle Q(X),X\rangle$, and $L_WX=Q(W,X)$. **Given**: $\langle Q(X,Y),Z\rangle$ is totally symmetric, so $L_W$ is self-adjoint; $Q$ is $O(n)$-equivariant.
- **The sign characters of an orthonormal frame**: the sign group $\{\pm1\}^n$ acts on $\Lambda^2$ by $e_i\wedge e_j\mapsto\varepsilon_i\varepsilon_je_i\wedge e_j$ and on operators by conjugation, so $\mathcal W_n=\bigoplus_U\mathcal W_U$ orthogonally over characters $U$. $\pi_{\mathcal D}$ is the orthogonal projection onto the operators diagonal on the basis $e_i\wedge e_j$.
- **Given, [L120](../findings/second-order.md)**: $L_A$ preserves each character space when $A$ is diagonal in the frame.

## The conventions match the record's

- Hamilton's $Q(R)=R^2+R^\#$ with its symmetric polarisation $Q(X,Y)$, $P(X)=\langle Q(X),X\rangle$, Hilbert–Schmidt norms. The author's $\Theta_m^2=2(m-1)(m-2)/m^2$ at even $m$ is the record's $\theta_0(m)^2$, so the normalisations agree.
- The author's $L_W$ is $X\mapsto Q(W,X)$, the record's $W\circ X$: the stated spectrum $-\rho I\le L_W\le\tfrac\rho2I$ on $W^\perp$ at a global maximiser is [L24](../findings/second-order.md)'s cap together with its lower companion.

## Claim 1, identity (86)

## Identity (86), derived here from the definitions

Put $z=(A/t-tW)/b$, $\mathcal U=\tfrac12I+\tfrac12W\otimes W-\rho^{-1}L_W$, $\eta=\langle z,\mathcal Uz\rangle$, $C=(\mathcal U-\eta)z$. Decompose $B=\sum_UB_U$ over the nontrivial sign characters of the frame, $p_U=\lVert B_U\rVert^2$, and write $Q(A)-\tfrac{P(A)}{t^2}A=q_\perp$ and $Q(A,B_U)=\lambda_UB_U+Y_U$ with $Y_U\perp B_U$.

1. **$z$ is a unit vector orthogonal to $W$.** $A/t-tW=\tfrac{b^2}tA-tB$, whose squared norm is $b^4+t^2b^2=b^2$, and $\langle A/t-tW,W\rangle=t-t=0$.
2. **$C\perp W$ and $C\perp z$, hence $C\perp A$ and $C\perp B$.** $\mathcal UW=\tfrac12W+\tfrac12W-\rho^{-1}Q(W)=0$ uses criticality; $\langle C,z\rangle=\langle\mathcal Uz,z\rangle-\eta=0$ is the definition of $\eta$. Since $b\ne0$ and $t\ne0$, $\mathop{\mathrm{span}}\{W,z\}=\mathop{\mathrm{span}}\{A,B\}$.
3. **The components of $C$.** $\mathcal Uz=\tfrac12z-\rho^{-1}Q(W,z)$ because $z\perp W$, and $Q(W,z)=\big(Q(A)+\sum_UQ(A,B_U)\big)/(tb)-\rho tW/b$ by criticality. The trivial character of the sign group on operators on $\Lambda^2$ is exactly the diagonal operators, $Q$ is equivariant, so $Q(A)$ is diagonal and $Q(A,B_U)$ lies in the character $U$. Projecting:
$$\pi_{\mathcal D}C=\Big(\big(\tfrac12-\eta\big)\tfrac bt+\tfrac tb\Big)A-\frac{Q(A)}{\rho tb},\qquad \pi_UC=\frac{t(\tfrac12+\eta)}{b}B_U-\frac{\lambda_UB_U+Y_U}{\rho tb}.$$
4. **The two scalars are forced.** $\langle\pi_{\mathcal D}C,A\rangle=\langle C,A\rangle=0$ gives $(\tfrac12-\eta)b^2+t^2=P(A)/(\rho t^2)$, so $\pi_{\mathcal D}C=-q_\perp/(\rho tb)$. $\sum_U\langle\pi_UC,B_U\rangle=\langle C,B\rangle=0$ gives $\bar\lambda:=\sum_Up_U\lambda_U/b^2=\rho t^2(\eta+\tfrac12)$, which is (86)'s companion, so $\pi_UC=-\big(Y_U+(\lambda_U-\bar\lambda)B_U\big)/(\rho tb)$.
5. **Pythagoras over the orthogonal characters**, with $Y_U\perp B_U$:
$$\rho^2t^2b^2\lVert C\rVert^2=\lVert q_\perp\rVert^2+\sum_U\lVert Y_U\rVert^2+\sum_Up_U(\lambda_U-\bar\lambda)^2 .$$

**Verdict: (86) holds on the record's objects, at every unit critical point with $\rho\ne0$ and $0<t<1$, in every orthonormal frame.** Neither the maximal frame nor global maximality is used, which matches the author's own statement.

## Claim 2, the finite-angle inequality

## The author's two tools, checked

- **The finite-angle inequality**, derived here. For $W=A+\sum_SB_S$ in a maximal frame, every $g\in O(n)$ and every sign twist $h$ (which fixes $A$ and multiplies $B_S$ by $\chi_S(h)$), $gh\in O(n)$ gives $\lVert\pi_{\mathcal D}(gA)+\sum_S\chi_S(h)\pi_{\mathcal D}(gB_S)\rVert^2\le\lVert A\rVert^2$. The left side is $F(h)=c_0+\sum_Uc_U\chi_U(h)$ with $c_0=\lVert a\rVert^2+\sum_S\lVert y_S\rVert^2$ and $c_U=2\langle a,y_U\rangle+\sum_S\langle y_S,y_{S\triangle U}\rangle$, and $\lVert A\rVert^2-F\ge0$ bounds every Fourier coefficient by its mean: $\lvert c_U\rvert\le\lVert A\rVert^2-c_0$. **Correct, and global**: it uses frame maximality at finite angle, where every closed attempt on (b) was second order.

## Claim 3, the classification

## Classified against the record

- **Agreement on the scalar part.** Step 4's $(\tfrac12-\eta)b^2+t^2=P(A)/(\rho t^2)$ is [L214](../findings/second-order.md)'s first relation in the author's coordinates. With $T=t^2$, $\eta\ge0$, which the cap gives, reads $P(A)\le\tfrac\rho2T(1+T)$, L214's inequality exactly. The author's threshold $\eta>\eta_0(t)=\tfrac{1-t}{2(1+t)}\iff P(A)/t^3<\rho$ follows from the same relation.
- **New to the record: the split of $\lVert C\rVert^2$ by sign character.** A grep of [findings/](../findings/) for $q_\perp$, $Y_U$, $\lambda_U$ and the defect returns nothing. The character decomposition it uses is [L120](../findings/second-order.md)'s and [L123](../findings/second-order.md)'s, and $Q$'s equivariance is typed as `Qop2_rotR`.
- **Against [F67](../findings/fence-posts.md).** (86) is an exact identity with the frame split's two terms coupled through $C$, which is F67's clearance. A proof of (MG) that bounds $\lVert q_\perp\rVert$ alone is what the author's own remark rules out, since the other two defects are independent.

## The Lean table

| claim | declaration | what it covers |
|---|---|---|
| 1, the identity | `identity_86` in [MixingGapVariance.lean](../lean/HamiltonsCubic/Results/MixingGapVariance.lean) | over any real inner product space with a bilinear symmetric `m` whose `m x` are self-adjoint; the six character hypotheses `hAB`, `hQB`, `hQQ`, `hBB`, `hLB`, `hLL`; `λ_U` defined by `hlam` |
| 1, steps 2 to 4 | `front_end` | the decomposition $C=c_0+\sum c_U$, $C\perp A$, $C\perp\sum B_U$ |
| 1, step 5 | `variance_core`, `c0_eq`, `cU_norm`, `norm_sq_add_sum` | Pythagoras and the two forced scalars |
| 2 | none: the frame-maximality hypothesis needs the $O(n)$ action with the sign twists on `CurvOp2` and a Fourier inversion over $\{\pm1\}^n$; the averaging step is elementary and is what you check | |
| 3 | none: it is a comparison with [L214](../findings/second-order.md), whose inequality is typed as `L214_frame_cap` | |

`#print axioms identity_86`, `variance_core` and `front_end`: `propext`, `Classical.choice`, `Quot.sound`.

## What to attack

1. **Read the written chain of Claim 1 link by link before re-deriving anything.** For each of steps 1 to 5: does it follow from the step above and the hypotheses stated? Where is $\rho\ne0$ used, where $0<t<1$, where $\lVert W\rVert=1$, where criticality?
2. Step 3's two component formulas: is the trivial character exactly the diagonal operators, and does $Q(A,B_U)$ lie in character $U$?
3. The Lean file: does `identity_86` state Claim 1 (same $q_\perp$, same $\lambda_U$, same $\bar\lambda$, the normalisation $t=\lVert A\rVert$)? Are the six character hypotheses each a consequence of the character decomposition and L120, and are they jointly satisfiable with $0<t<1$ (vacuity)? Is anything assumed that the note's derivation proves?
4. Claim 2: does a sign twist fix $A$ and multiply $B_S$ by $\chi_S(h)$? Is $\lVert\pi_{\mathcal D}(ghW)\rVert^2\le\lVert A\rVert^2$ the right consequence of the frame being maximal? Is the Fourier step, $\lvert c_U\rvert\le\lVert A\rVert^2-c_0$, correct, including the product rule $\chi_S\chi_{S'}=\chi_{S\triangle S'}$?
5. Claim 3: is $\eta\ge0$ exactly L214's inequality under $T=t^2$, and does the threshold $\eta_0(t)=\tfrac{1-t}{2(1+t)}$ follow?

## Protocol

- Log to the path given in your dispatch, first line with your PID and phase plan, a heartbeat at least every three minutes with live state, closing with a line that opens `DONE` or `FAILED`.
- Commit a skeleton report to your `reviews/REVIEW_rN.md` in your first phase (claim table, every verdict `NOT REACHED`), then overwrite rows as you go. **Do not edit [reviews/INDEX.md](INDEX.md)**; the parent writes it after both reports are final. Commit only your own files, naming them after `--`.
