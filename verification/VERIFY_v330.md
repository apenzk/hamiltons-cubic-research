# Verifier v330, Lemma L111: the polarised identity and M = -2W^#, criticality as the matrix form, the bracket form as [W,Q(W)]=0 and its strict weakness, the diagonal family, the constraint counts, and the two Lean files

*Cold brief ([BRIEF_L111.md](BRIEF_L111.md)). No numerical work, no scripts written, no computation run. Every value below is exact and every object is given in closed form. Log: [agent_logs/verify-L111-v330.log](../agent_logs/verify-L111-v330.log).*

| # | Claim (source) | Verdict |
|---|---|---|
| 1 | Polarising $\langle v,W^\#v\rangle=-\tfrac12\mathop{\mathrm{tr}}(\mathrm{ad}(v)W\mathrm{ad}(v)W)$ gives $M_{kl}=-2(W^\#)_{kl}$ (bounds 656) | CONFIRMED |
| 2 | Criticality is equivalent to $M_{kl}=2\lambda_k(\lambda_k-\theta)\delta_{kl}$ (heading 636, display 658) | CONFIRMED |
| 3a | "i.e." $\sum\lambda_\alpha\lambda_\beta c_{k\alpha\beta}c_{l\alpha\beta}=0$ whenever $\lambda_k\ne\lambda_l$, as an equivalent of the matrix form (display 658) | REFUTED AS STATED (the record's own blockquote at 662 already retracts it, the display still carries the "i.e.") |
| 3b | The bracket form is exactly $[W,Q(W)]=0$, and the restriction $\lambda_k\ne\lambda_l$ is lost information, since criticality forces vanishing for all $k\ne l$ in every orthonormal eigenbasis (662, conventions 151) | CONFIRMED AS ALGEBRA |
| 4 | Diagonal entries $M_{kk}=2\lambda_k(\lambda_k-\theta)$ are relation (C) (662 against 262) | CONFIRMED |
| 5 | The bracket form is strictly weaker than criticality (heading 636) | HYPOTHESIS-DEBT (on file only as a measurement, dischargeable in closed form, witness in section 5) |
| 6a | Every (coordinate-)diagonal Weyl tensor satisfies the bracket form (662, conventions 151) | HYPOTHESIS-DEBT (true, no argument on file, the missing argument is named in section 6) |
| 6b | "... while being nowhere near critical" (662) | REFUTED AS STATED (the Weyl tensors of $S^2\times S^2$ and $S^3\times S^3$ are coordinate-diagonal and critical) |
| 6c | The diagonal family is $n(n-3)/2$-dimensional (662) | CONFIRMED AS ALGEBRA (for $n\ge3$, no argument on file) |
| 7a | The diagonal entries are "$N$ constraints where the record used one" (662) | GAP (their sum is an identity on every unit Weyl tensor, so at most $N-1$ carry criticality, and independence has no argument) |
| 7b | Off-diagonal entries are the only place the Jacobi identity can enter a bound on $D$ (662) | GAP for "only place" (no argument on file). The sub-claim that they are not functions of $T=c^2$ is CONFIRMED |
| 8 | "A change of language, not new information" (662) | CONFIRMED |
| 9 | [L111Statement.lean](../lean/HamiltonsCubic/Results/L111Statement.lean) against Passage A | CONFIRMED AS ALGEBRA (the file proves a linear rearrangement over a free matrix, the polarisation step and the Weyl witness are outside it) |
| 10 | [L111.lean](../lean/HamiltonsCubic/Results/L111.lean) counts at $n=6$: multiplicities $(3,3,9)$, $57$ of $120$ | REFUTED AS STATED (the $\Lambda^2$ spectrum of the Weyl tensor of $S^3\times S^3$ has multiplicities $(6,9)$, giving $66$ of $120$, as the Statement file has) |
| 11 | Statement file `dropped_fractions`, $1130/2210$ beside the $1131$ of $2211$ it counts | CONFIRMED AS ALGEBRA (both fractions lie in $(0.511,0.512)$, the off-by-one is unexplained and inconsistent with the $66/120$ case) |

**What the round should do:** keep the matrix form as proven, delete the "i.e." from the display, replace the measurement behind "strictly weaker" with the two-line closed-form argument of sections 5 and 6, correct "nowhere near critical" to "includes non-critical members", restate "$N$ constraints" as at most $N-1$, and fix the multiplicities in [L111.lean](../lean/HamiltonsCubic/Results/L111.lean) to $(6,9)$ and $(2,4)$.

## 0. Conventions, fixed once

- $\mathfrak{so}(n)\cong\Lambda^2\mathbb R^n$ with $\langle A,B\rangle=-\tfrac12\mathop{\mathrm{tr}}(AB)$, so $e_i\wedge e_j=E_{ij}-E_{ji}$ is orthonormal. $N=\binom n2$.
- $\{v_a\}$ orthonormal, $c_{abc}=\langle[v_a,v_b],v_c\rangle$, totally antisymmetric (conventions 61). The matrix of $\mathrm{ad}(v_k)$ is $(\mathrm{ad}\,v_k)_{\alpha\beta}=c_{k\beta\alpha}$, antisymmetric.
- $(W^\#)_{ab}=\tfrac12\sum c_{acd}c_{bef}W_{ce}W_{df}$ (conventions 77). With this factor $\mathrm{id}^\#=(n-2)\mathrm{id}$, since $\sum_{cd}c_{acd}c_{bcd}=2(n-2)\delta_{ab}$, which is relation (A).
- $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$, critical means $Q(W)=\theta W$ on $\lVert W\rVert=1$, whence $\theta=P(W)$ (conventions 151, brief definitions).
- In an orthonormal eigenbasis $\{\varphi_k\}$, $W_{\alpha\beta}=\lambda_\alpha\delta_{\alpha\beta}$ and $M_{kl}=\mathop{\mathrm{tr}}(\mathrm{ad}(\varphi_k)W\mathrm{ad}(\varphi_l)W)$.
- **Coordinate-diagonal:** $W(e_i\wedge e_j)=w_{ij}\,e_i\wedge e_j$. For such $W$ the only nonzero structure constants in the coordinate basis are $c_{(ij)(jm)(im)}=\pm1$ for distinct $i,j,m$, and $W$ is Weyl iff $\sum_{j\ne i}w_{ij}=0$ for every $i$ (Bianchi holds automatically, as every term of $R_{ijkl}+R_{jkil}+R_{kijl}$ with a nonzero diagonal entry cancels in pairs, and trace-freeness follows from the vertex sums).
- From the index formula, for coordinate-diagonal $W$: $(W^\#)_{(ij)(ij)}=\sum_{m\ne i,j}w_{im}w_{jm}$.

## Hypothesis inventory

| Hypothesis | Where stated | Used by | Checked against the object |
|---|---|---|---|
| H1. $\{\varphi_k\}$ orthonormal for an ad-invariant inner product | brief definitions, conventions 61 | claim 1 (antisymmetry of $\mathrm{ad}(v)$), claim 2 (the M matrix is the matrix of $W^\#$) | holds for $-\tfrac12\mathop{\mathrm{tr}}$ on $\mathfrak{so}(n)$ |
| H2. $W$ symmetric on $\Lambda^2$ | brief definitions | claim 1 (the step $W_{df}=W_{fd}$), existence of the eigenbasis (spectral theorem) | holds on $\mathcal W_n$ |
| H3. The $\tfrac12$ in the index formula for $\#$ | conventions 77 | claim 1, fixes the factor $2$ in $M=-2W^\#$ | checked by $\mathrm{id}^\#=(n-2)\mathrm{id}$ |
| H4. $\lVert W\rVert=1$ | brief definitions, conventions 151 | only to identify the $\theta$ of the matrix form with $P(W)$ | not stated on lines 636 to 662, supplied by the convention |
| H5. $W\in\mathcal W_n$ (Bianchi, Ricci-flat, trace-free) | heading, "Weyl tensor" | **not used by claims 1, 2, 3b, 4, 8.** Used by 6a to 6c and 7a | every identity in claims 1 to 4 holds for any symmetric operator on $\mathfrak{so}(n)$ |
| H6 (imported). $Q(\mathcal W_n)\subseteq\mathcal W_n$ | presupposed by conventions 151, where $Q(W)=\theta W$ is the first-order condition with no projection | 7a (gives $\mathop{\mathrm{tr}}Q(W)=0$) | standard for the Böhm–Wilking product. On the coordinate-diagonal family it is checked in closed form in section 7 |
| H7 (imported). Killing form of $\mathfrak{so}(n)$ is $(n-2)\mathop{\mathrm{tr}}$ | behind relation (A) | 0 (factor check) only | $\sum_{cd}c_{acd}c_{bcd}=-\mathop{\mathrm{tr}}(\mathrm{ad}v_a\mathrm{ad}v_b)=2(n-2)\delta_{ab}$ |

- **Stated but unused:** H5 for the core equivalence. This is a benign over-restriction, the lemma holds verbatim for every symmetric $W$ on $\mathfrak{so}(n)$, and it is recorded as a finding of scope, not a defect.
- **Used but unstated on the lemma's lines:** H4 (for $\theta=P(W)$). The brief's conventions supply it.
- **Imported theorems whose hypotheses were never checked on file:** H6 is not invoked by the written proof, only by my check of 7a. The measurement attributed to [Reviewer 326](../reviews/REVIEW_r326.md) is the only support on file for claims 5 and 6a.

## 1. The polarised identity and $M=-2W^\#$

- **Step (a).** With $X=\mathrm{ad}(v)$, $[v,u]_d=\sum_{a,c}v_au_cc_{acd}$, so $X_{dc}=\sum_av_ac_{acd}$. Then $\langle v,W^\#v\rangle=\tfrac12\sum X_{dc}X_{fe}W_{ce}W_{df}$.
- **Step (b).** H1 gives $X_{fe}=-X_{ef}$, and H2 gives $W_{df}=W_{fd}$. So the sum is $-\tfrac12\sum X_{dc}W_{ce}X_{ef}W_{fd}=-\tfrac12\mathop{\mathrm{tr}}(XWXW)$. The identity at line 656 holds.
- **Step (c), polarisation.** $W^\#$ is symmetric (swap $a,b$ and rename $c\leftrightarrow e$, $d\leftrightarrow f$, using H2). With $q(v)=-\tfrac12\mathop{\mathrm{tr}}(\mathrm{ad}v\,W\mathrm{ad}v\,W)$, $q(u+v)-q(u-v)=-2\mathop{\mathrm{tr}}(\mathrm{ad}u\,W\mathrm{ad}v\,W)$ by cyclicity, so $\langle u,W^\#v\rangle=-\tfrac12\mathop{\mathrm{tr}}(\mathrm{ad}u\,W\mathrm{ad}v\,W)$.
- **Conclusion.** $M_{kl}=-2(W^\#)_{kl}$ in any orthonormal basis, eigenbasis or not.
- **The factor against Passage B.** With the $\tfrac12$ of conventions 77 the factor is $-2$. Had the $\tfrac12$ been dropped, $W^\#$ doubles and $M=-W^\#$, giving $\lambda_k(\lambda_k-\theta)$. The record's $2$ is the one consistent with its own convention.
- **Direct index check.** $M_{kl}=\sum_{\alpha\beta}c_{k\beta\alpha}\lambda_\beta c_{l\alpha\beta}\lambda_\alpha=-\sum\lambda_\alpha\lambda_\beta c_{k\alpha\beta}c_{l\alpha\beta}$, and the index formula gives $(W^\#)_{kl}=\tfrac12\sum\lambda_\alpha\lambda_\beta c_{k\alpha\beta}c_{l\alpha\beta}$. The two agree.
- Hypotheses used: H1, H2, H3 only.

## 2. Criticality is equivalent to the matrix form

- **Forward.** $Q(W)=\theta W$ gives $W^\#=\theta W-W^2$, which in any orthonormal eigenbasis is $\mathop{\mathrm{diag}}(\theta\lambda_k-\lambda_k^2)$. By section 1, $M_{kl}=-2(\theta\lambda_k-\lambda_k^2)\delta_{kl}=2\lambda_k(\lambda_k-\theta)\delta_{kl}$.
- **Backward.** If $M_{kl}=2\lambda_k(\lambda_k-\theta)\delta_{kl}$ for all $k,l$ in one orthonormal eigenbasis, then $W^\#$ has matrix $\mathop{\mathrm{diag}}(\theta\lambda_k-\lambda_k^2)$ there, which is the matrix of $\theta W-W^2$. So $Q(W)=\theta W$. Pairing with $W$ and using H4 gives $\theta=P(W)$.
- **$\delta_{kl}$.** It is a conclusion in the forward direction and part of the hypothesis in the backward direction. Both directions need all $N^2$ entries, including $k\ne l$ inside a repeated eigenspace.
- **Scope.** Without H4 the backward direction gives $Q(W)=\theta W$ for a non-unit $W$, which is criticality of $W/\lVert W\rVert$ with multiplier $\theta/\lVert W\rVert$. The record's convention fixes the unit sphere, so this is not a defect.

## 3. The bracket display

- **3a, the "i.e.".** By section 1, $\sum\lambda_\alpha\lambda_\beta c_{k\alpha\beta}c_{l\alpha\beta}=2(W^\#)_{kl}$. The display's second form says $(W^\#)_{kl}=0$ when $\lambda_k\ne\lambda_l$ and says nothing about the diagonal or the repeated eigenspaces. It is not equivalent to the first form (section 5 exhibits the failure).
  - Locate: line 658, "$M_{kl}=2\lambda_k(\lambda_k-\theta)\,\delta_{kl},\qquad\text{i.e.}\qquad \sum_{\alpha\beta}\lambda_\alpha\lambda_\beta\,c_{k\alpha\beta}c_{l\alpha\beta}=0\ \text{ whenever }\lambda_k\ne\lambda_l$".
  - Exhibit: $W_C$ of section 5 satisfies the second form and not the first.
  - Charitable reading: the blockquote at 662 retracts the "i.e." in capitals, and the heading at 636 states the corrected relation. The mathematics of the record is therefore right, but the display on the lemma's own line still asserts the retracted equivalence. The finding stands as a presentation defect.
- **3b, the bracket form is $[W,Q(W)]=0$.** $[W,W^\#]_{kl}=(\lambda_k-\lambda_l)(W^\#)_{kl}$, and $[W,W^2]=0$. So $[W,Q(W)]=0$ iff $(W^\#)_{kl}=0$ whenever $\lambda_k\ne\lambda_l$. Confirmed, basis-free.
- **The restriction.** Criticality makes $W^\#=\theta W-W^2$ scalar on each eigenspace, so $(W^\#)_{kl}=0$ for all $k\ne l$ in every orthonormal eigenbasis. The record's sentence is right.
- The [commutes_iff_bracket_form](../lean/HamiltonsCubic/Results/L111Statement.lean) theorem states exactly 3b with $W^\#$ as a free matrix.

## 4. Diagonal entries against relation (C)

- $M_{kk}=-\sum\lambda_\alpha\lambda_\beta c_{k\alpha\beta}^2=-\sum\lambda_\alpha\lambda_\beta T_{k\alpha\beta}$ (section 1).
- So $M_{kk}=2\lambda_k(\lambda_k-\theta)$ iff $\sum\lambda_\alpha\lambda_\beta T_{k\alpha\beta}=2\lambda_k(\theta-\lambda_k)$, which is (C) at line 262. The signs agree through the antisymmetry of $c$. One statement.
- At $\lambda_k=0$ ($\ker W\ne0$) both read $\sum\lambda_\alpha\lambda_\beta T_{k\alpha\beta}=0$. No division occurs anywhere, so the kernel is harmless.

## 5. "The bracket form is strictly weaker"

- **Argument on file.** Line 662 gives the direction criticality implies bracket form implicitly (3b), and for the converse failure it gives a measurement: "Measured here on six diagonal elements of $\mathcal W_6$ ... off-diagonal residual $0.000\times10^{0}$ exactly, at criticality residuals $0.527$ to $0.741$". That is a run. HYPOTHESIS-DEBT.
- **What would have to be proved:** (i) every coordinate-diagonal Weyl tensor satisfies the bracket form (section 6a), and (ii) one coordinate-diagonal Weyl tensor is not critical for any $\theta$.
- **Test of (ii) against a closed-form object.** $W_C$: $w_{12}=w_{34}=1$, $w_{13}=w_{24}=-1$, all other $w_{ij}=0$, any $n\ge4$.
  - Weyl: vertex sums are $1-1$, $1-1$, $-1+1$, $-1+1$, and $0$ for $i\ge5$.
  - $(W_C^\#)_{(12)(12)}=\sum_{m\ne1,2}w_{1m}w_{2m}=w_{13}w_{23}+w_{14}w_{24}=0$. Criticality there needs $0=\theta\cdot1-1$, so $\theta=1$.
  - $(W_C^\#)_{(13)(13)}=w_{12}w_{32}+w_{14}w_{34}=0$. Criticality there needs $0=\theta\cdot(-1)-1$, so $\theta=-1$.
  - Contradiction. $W_C/2$ is a unit Weyl tensor that is not critical, at every $n\ge4$, odd $n$ included.
- **Kernel-free witness at $n=4$.** $(w_{12},w_{13},w_{14})=(1,2,-3)$ with $w_{34}=w_{12}$, $w_{24}=w_{13}$, $w_{23}=w_{14}$. Then $(W^\#)_{(12)}=2w_{13}w_{14}=-12$ forces $\theta=-11$, and $(W^\#)_{(13)}=2w_{12}w_{14}=-6=2\theta-4$ forces $\theta=-1$. No eigenvalue is zero. So the gap is not an artefact of padding.
- The claim is true. The record carries a run where a four-line argument is available.

## 6. The coordinate-diagonal family

- **6a, "every diagonal Weyl tensor satisfies it".** No argument on file. What would have to be proved: $W^\#$ is diagonal in the coordinate basis. Following the index formula: $(W^\#)_{ab}=\tfrac12\sum_{cd}c_{acd}c_{bcd}w_cw_d$. A nonzero term needs $\{c,d\}=\{(im),(jm)\}$ for $a=(ij)$ and $\{c,d\}=\{(km'),(lm')\}$ for $b=(kl)$. Two planes sharing exactly one index determine that index and the other two, so $m=m'$ and $\{i,j\}=\{k,l\}$, hence $a=b$. So $W^\#$ and $W$ are simultaneously diagonal and commute. The universal survives the test, and the check never uses the Weyl condition.
  - **Wording.** "Diagonal" without "coordinate" is vacuous, since every symmetric $W$ is diagonal in its own eigenbasis, and under that reading the claim would be false (a generic $W$ fails the bracket form, as the record's own random control shows). The brief's definitions fix "coordinate-diagonal". Lines 662 and conventions 151 should carry the qualifier.
- **6b, "while being nowhere near critical".**
  - Locate: line 662, "**every diagonal Weyl tensor satisfies it while being nowhere near critical**", and conventions 151, "satisfied by every diagonal Weyl tensor".
  - Exhibit 1, $S^2\times S^2$: $w_{12}=w_{34}=2$, other four $-1$ (vertex sums $2-1-1=0$). $(W^\#)_{(12)}=w_{13}w_{23}+w_{14}w_{24}=1+1=2=\theta\cdot2-4$, so $\theta=3$. $(W^\#)_{(13)}=w_{12}w_{32}+w_{14}w_{34}=-2-2=-4=-\theta-1$, so $\theta=3$. By the symmetry of the pattern every plane gives $\theta=3$. Critical, with unit multiplier $3/\sqrt{12}=\sqrt3/2$.
  - Exhibit 2, $S^3\times S^3$ (the balanced product): factor planes $w=3$, mixed planes $w=-2$ (vertex sums $2\cdot3+3\cdot(-2)=0$). Factor plane $(12)$: $w_{13}w_{23}+\sum_{m=4}^6w_{1m}w_{2m}=9+12=21=3\theta-9$, so $\theta=10$. Mixed plane $(14)$: four terms each $3\cdot(-2)$, total $-24=-2\theta-4$, so $\theta=10$. Critical, unit multiplier $10/\sqrt{90}=\sqrt{10}/3$. $\ker W=0$.
  - Charitable reading: "every" governs only "satisfies it", and "nowhere near critical" describes the six measured tensors. The grammar puts both predicates under "every", and conventions 151 generalises the first half only. Under the charitable reading the sentence is still a measurement. The finding stands as REFUTED AS STATED, with no effect on the heading, which needs only one non-critical member.
- **6c, the dimension.** Coordinate-diagonal Weyl tensors are edge weights on $K_n$ with zero vertex sums. The unsigned incidence map $\mathbb R^{N}\to\mathbb R^n$ has rank $n$ for $n\ge3$ ($K_n$ contains a triangle, so it is not bipartite). Dimension $N-n=n(n-3)/2$: $2$ at $n=4$ (the pattern $w_{12}=w_{34}$, $w_{13}=w_{24}$, $w_{14}=w_{23}$, sum zero), $5$ at $n=5$, $0$ at $n=3$. The unit ones form a sphere of one dimension less. Confirmed as algebra, no argument on file.

## 7. The constraint counts and the Jacobi identity

- **7a, "$N$ constraints where the record used one".**
  - Locate: line 662, "the diagonal entries pin $\sum\lambda_\alpha\lambda_\beta c_{k\alpha\beta}^2=2\lambda_k(\theta-\lambda_k)$ for every $k$, which is $N$ constraints where the record used one".
  - Exhibit: summing over $k$, the left side is $2\mathop{\mathrm{tr}}W^\#$ and the right side is $2\theta\mathop{\mathrm{tr}}W-2\lVert W\rVert^2=-2$. By H6, $\mathop{\mathrm{tr}}Q(W)=0$ on $\mathcal W_n$, so $\mathop{\mathrm{tr}}W^\#=-\lVert W\rVert^2=-1$ for every unit Weyl tensor, critical or not. The summed equation is $-2=-2$ identically, and $\theta$ drops out. Closed-form check on the coordinate-diagonal family without H6: $\mathop{\mathrm{tr}}W^\#=\sum_m\tfrac12\big[(\sum_iw_{im})^2-\sum_iw_{im}^2\big]=-\lVert W\rVert^2$.
  - Charitable reading: "$N$ constraints" counts equations, and "the one" the record used may be a single $k$ rather than the trace. Even so, the $N$ equations carry at most $N-1$ independent pieces of criticality information, and their independence as constraints on the basis has no argument on file.
- **7b, off-diagonal entries and $T$.** Replacing $\varphi_k$ by $-\varphi_k$ flips every $c_{k\alpha\beta}$ and hence $M_{kl}$ for $l\ne k$, while $T$ is unchanged. So off-diagonal entries are not functions of $T$ (outside the critical locus where they vanish), and the sign-sensitive Jacobi identity cannot be seen through $T$. Confirmed. "The only place the Jacobi identity can enter a bound on $D$" is a universal over all bounds on $D$, with $D$ undefined in the brief and no argument on file. GAP. What would have to be proved: every relation among the $c_{k\alpha\beta}$ that enters $D$ and is not a function of $T$ factors through the off-diagonal entries of $W^\#$.

## 8. "A change of language, not new information"

- Section 1 shows $M=-2W^\#$ is an identity for every symmetric $W$. The matrix form therefore restates $W^\#=\theta W-W^2$ and adds no relation. Confirmed.

## 9. [L111Statement.lean](../lean/HamiltonsCubic/Results/L111Statement.lean) against Passage A

- **Types and binders.** `lam : κ → ℝ` models the spectrum, `Ws : κ → κ → ℝ` models $W^\#$ as an arbitrary matrix, with `[DecidableEq κ]` only (no `Fintype`, no symmetry, no link between `Ws` and `lam`).
- `Mmat Ws k l := -2 * Ws k l` **defines** $M=-2W^\#$. The polarisation step of section 1, which is the lemma's content, is outside the file.
- `IsCriticalHere` is $Q=\theta W$ entrywise in the eigenbasis, with no $\lVert W\rVert=1$ and no $\theta=P(W)$. It is the record's criticality only once `Ws` is the $W^\#$ of a Weyl tensor with spectrum `lam`.
- `matrix_form_is_criticality`: direction `↔`, correct, a linear rearrangement. Matches claim 2 modulo the definition of `Mmat`.
- `critical_forces_all_offdiagonal` and `critical_imp_bracket_form`: match 3b and the forward half of claim 5.
- `bracket_form_strictly_weaker`: witness `lam = ![1, -1]` on `Fin 2`, `Ws = 0`. Not a Weyl tensor: $N=2$ is no $\binom n2$, and `Ws = 0` is not $W^\#$ of $\mathop{\mathrm{diag}}(1,-1)$ on any $\mathfrak{so}(n)$. It separates the two predicates, not the record's two conditions on $\mathcal W_n$. The mathematical strictness (section 5) is unformalised.
- `dropped_count_identity`, `counts_at_balanced_products`: correct arithmetic. The $(6,9)$ and $(30,36)$ inputs are the spectral multiplicities of $S^3\times S^3$ and $S^6\times S^6$ (for the latter, vertex sums $5\alpha+6\beta=0$ in both factors force equal factor eigenvalues).
- `dropped_fractions`: uses $1130/2210$ where the file counts $1131$ of $2211$, while the $n=6$ case uses the unshifted $66/120$. Both $1130/2210=113/221$ and $1131/2211=377/737$ lie in $(0.511,0.512)$ ($1131000>1129821$ and $1131000<1132032$). The inequality holds either way. The shift by one has no stated reason.

## 10. [L111.lean](../lean/HamiltonsCubic/Results/L111.lean): which multiplicities are the spectrum

- **The object.** The Weyl tensor of $S^3(r_1)\times S^3(r_2)$ is $O(3)\times O(3)$-invariant, so coordinate-diagonal with values $\alpha_1$, $\alpha_2$ on the two factors' planes and $\beta$ on mixed planes. Vertex sums give $2\alpha_1+3\beta=0=2\alpha_2+3\beta$, so $\alpha_1=\alpha_2$ for every choice of radii. Normalised: eigenvalue $3$ on $3+3=6$ planes, $-2$ on $9$.
- **The spectrum has multiplicities $(6,9)$.** The bracket form drops the pairs with $\lambda_k=\lambda_l$, which number $\binom72+\binom{10}2=21+45=66$ of $\binom{16}2=120$, share $11/20$.
- **The file's input.** `multiplicities_six` and `split_from_L76` take $(3,3,9)$, the $O(3)\times O(3)$ plane split, and `dropped_six` gets $6+6+45=57$, share $19/40$. It omits the $3\cdot3=9$ pairs between the two factors' planes, which share the eigenvalue $3$.
  - Locate: `theorem multiplicities_six : 3 + 3 + 9 = Nat.choose 6 2` and `theorem dropped_six : dropped 3 + dropped 3 + dropped 9 = 57`.
  - Exhibit: the eigenvalue computation above, exact.
  - Charitable reading: `dropped` counts pairs inside an invariance block rather than inside an eigenspace. The bracket form's restriction is eigenvalue equality ($\lambda_k\ne\lambda_l$), and the Statement file uses $(6,9)$ for the same object, so under that reading the file measures something other than the bracket form. The finding stands.
- **Downstream in the file.** `share_in_range` ($0.45<19/40<0.51$) fails at the correct $11/20$. `cross_dominates` ($45\cdot100>78\cdot57$) fails at the correct count, since $78\cdot66=5148>4500$.
- **At $n=4$.** $S^2\times S^2$: vertex sums $\alpha_i+2\beta=0$ force $\alpha_1=\alpha_2$, spectrum $(2,4)$, dropped $3+10=13$ of $21$, against the file's $(1,1,4)$ and $12$. `share_four_above` ($0.51<12/21$) still holds at $13/21$.
- The theorems are true arithmetic. The input they encode is not the spectrum.

## Edges of every range

- **Smallest dimension.** $n=4$: all of sections 1 to 4 hold, $W_C$ and the $(1,2,-3)$ tensor witness claim 5, $S^2\times S^2$ refutes 6b. $n=3$: $\mathcal W_3=0$ and the unit sphere is empty, so the lemma is vacuous there.
- **Odd $n$.** $n=5$: $W_C$ padded is a non-critical coordinate-diagonal Weyl tensor, the family has dimension $5$. Nothing in L111 depends on parity.
- **Crossover $n=6+2\sqrt7$.** No step of L111 carries an $n$-dependent inequality, so the crossover does not enter.
- **$\ker W\ne0$.** Sections 1, 2, 4 divide by nothing. $W_C$ at $n\ge5$ is a padded object with a kernel and behaves as in section 5.
- **Repeated eigenvalues.** Section 2's backward direction needs the entries inside each eigenspace, and section 3b's forward direction delivers them in every eigenbasis. The bracket form sees none of them. $S^3\times S^3$ is the extreme case, two eigenvalues.

## Traps, by name

- **ker W ≠ 0:** checked, harmless (edges above).
- **Boundary of every range:** $n=3,4,5$ checked. The dimension count $n(n-3)/2$ needs $n\ge3$.
- **Proven on a subfamily, stated in general:** 6b, the coordinate-diagonal family contains critical points, so "every ... nowhere near critical" overreaches. L111.lean's counts are made on the block split and stated as the bracket form's.
- **Hypothesis stated but unused:** H5 (Weyl) for claims 1 to 4. **Used but unstated:** H4 on the lemma's lines.
- **Universal with no witness:** 6a has no argument on file and survives the test (section 6). 7a's "$N$ constraints" fails by one. 7b's "only place" has no argument.
- **Imported theorem unchecked:** H6 is presupposed by the convention and used only in my check. The Reviewer 326 measurement is the sole support on file for claims 5 and 6a.

## Withdrawn candidates

- **"The restriction $\lambda_k\ne\lambda_l$ is wrong" implies dropping it restores the equivalence.** Withdrawn at the charitable-reading step: the sentence names a second defect and claims no repair. (Dropping the restriction still loses the diagonal, and $W_C$ satisfies $(W^\#)_{kl}=0$ for all $k\ne l$ in the coordinate basis while failing criticality.)
- **The factor $2$ in $M$ contradicts the $\tfrac12$ of conventions 77.** Withdrawn at the exhibit step: section 1 derives exactly $-2$ with the $\tfrac12$ in place.
- **Relation (C) has the opposite sign to $M_{kk}$.** Withdrawn at the exhibit step: section 4, the sign flip is the antisymmetry of $c$.
- **The display "whenever $\lambda_k\ne\lambda_l$" is false as a consequence of criticality.** Withdrawn at the charitable-reading step: it is true, only not equivalent, and 3a records that.

## What would falsify the statement, and the search

- **The heading's first half** would fall to a unit Weyl tensor whose $M$ in some orthonormal eigenbasis has the matrix form while $Q(W)\ne\theta W$, or the converse. Section 1 makes $M=-2W^\#$ an identity, so no such object exists. I followed the algebra twice (trace form and index form).
- **The heading's second half** would fall if every Weyl tensor satisfying $[W,Q(W)]=0$ were critical. I tested the coordinate-diagonal family, padded objects, both balanced sphere products and a kernel-free $n=4$ member. $W_C$ and $(1,2,-3)$ satisfy the bracket form and are not critical, so the half is true, with the argument missing from the file. $\mathbb{CP}^m$ lives at $n=4m\ge8$ with a non-coordinate-diagonal Weyl tensor and is not needed once a witness exists.

## Overall verdict

**HYPOTHESIS-DEBT.** The matrix form (claims 1, 2, 4, 8) is proven on file and holds for every symmetric $W$. The strict weakness in the heading, and the universal behind it, rest on a measurement, although a closed-form discharge exists (sections 5 and 6a). Separately, "nowhere near critical" is refuted by $S^2\times S^2$ and $S^3\times S^3$, "$N$ constraints" overcounts by at least one, the display still carries the retracted "i.e.", and [L111.lean](../lean/HamiltonsCubic/Results/L111.lean) encodes the block split $(3,3,9)$ in place of the spectrum $(6,9)$.
