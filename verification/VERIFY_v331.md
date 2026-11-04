# Verifier v331, Lemma L111: the polarised identity and M_{kl}, criticality as the matrix form, the bracket form as [W,Q(W)]=0 and its strictness, the coordinate-diagonal family, the N diagonal constraints, and the two Lean files

Cold brief ([BRIEF_L111.md](BRIEF_L111.md)), no numerical work, no scripts written, every value below exact and derived by hand. Log: [agent_logs/verify-L111-v331.log](../agent_logs/verify-L111-v331.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | $\langle v,W^\#v\rangle=-\tfrac12\mathop{\mathrm{tr}}(\mathrm{ad}(v)W\mathrm{ad}(v)W)$, polarised, gives $M_{kl}=-2(W^\#)_{kl}$ | CONFIRMED |
| 2 | Criticality $Q(W)=\theta W$ is equivalent to $M_{kl}=2\lambda_k(\lambda_k-\theta)\delta_{kl}$ | CONFIRMED |
| 3 | The display's "i.e.": the matrix form is equivalent to $\sum\lambda_\alpha\lambda_\beta c_{k\alpha\beta}c_{l\alpha\beta}=0$ whenever $\lambda_k\ne\lambda_l$ | REFUTED AS STATED |
| 4 | The bracket form is exactly $[W,Q(W)]=0$ | CONFIRMED |
| 5 | Criticality forces $M_{kl}=0$ for all $k\ne l$, basis-independently | CONFIRMED |
| 6 | Diagonal entries $M_{kk}=2\lambda_k(\lambda_k-\theta)$ are relation (C) | CONFIRMED |
| 7 | The bracket form is strictly weaker than criticality on $\mathcal W_n$ (heading) | HYPOTHESIS-DEBT |
| 8 | Every (coordinate-)diagonal Weyl tensor satisfies the bracket form | HYPOTHESIS-DEBT |
| 9 | Every diagonal Weyl tensor is "nowhere near critical" | REFUTED AS STATED |
| 10 | The coordinate-diagonal family is $n(n-3)/2$-dimensional | GAP |
| 11 | The diagonal entries are "$N$ constraints where the record used one" | GAP |
| 12 | The off-diagonal entries are "the only place the Jacobi identity can enter a bound on $D$" | GAP |
| 13 | [L111Statement.lean](../lean/HamiltonsCubic/Results/L111Statement.lean) against Passage A | CONFIRMED AS ALGEBRA |
| 14 | [L111.lean](../lean/HamiltonsCubic/Results/L111.lean) multiplicities $(3,3,9)$ and $(1,1,4)$ at the balanced products | REFUTED |

**What the round should do:** keep the matrix-form equivalence, strike the "i.e." from the display, replace the measurement with a closed-form witness of strictness (Section 7 gives one at $n=4$), restrict "nowhere near critical" to a named non-critical member, and correct L111.lean's multiplicities to $(6,9)$ and $(2,4)$.

## 0. Conventions, fixed once

- $\mathfrak{so}(n)\cong\Lambda^2\mathbb R^n$ with an ad-invariant inner product in which $e_i\wedge e_j$ is orthonormal. $\{v_a\}$ orthonormal, $c_{abc}=\langle[v_a,v_b],v_c\rangle$ totally antisymmetric ([conventions.md](../findings/conventions.md) line 61).
- $(W^\#)_{ab}=\tfrac12\sum c_{acd}c_{bef}W_{ce}W_{df}$ ([conventions.md](../findings/conventions.md) line 77), so $\mathrm{id}^\#=(n-2)\mathrm{id}$ and $Q(\mathrm{id})=(n-1)\mathrm{id}$.
- $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$, criticality is $Q(W)=\theta W$ with $\lVert W\rVert=1$, $\theta=P(W)$ ([conventions.md](../findings/conventions.md) line 151).
- $\{\varphi_k\}$ an orthonormal eigenbasis of $W$ on $\Lambda^2$, $W\varphi_k=\lambda_k\varphi_k$, and $c_{k\alpha\beta}$ taken in that basis.
- $(\mathrm{ad}\,v)_{ab}=\langle v_a,[v,v_b]\rangle$. For $v=v_k$ this is $c_{kba}=-c_{kab}$.
- For a coordinate-diagonal $W$, write $W(e_i\wedge e_j)=w_{ij}\,e_i\wedge e_j$ with $w_{ij}=w_{ji}$. Since $[e_i\wedge e_k,e_j\wedge e_k]$ is $\pm e_i\wedge e_j$ and a bracket of two coordinate planes is $\pm$ one coordinate plane or zero, the index formula gives $(W^\#)_{ij,ij}=\sum_{k\ne i,j}w_{ik}w_{jk}$ and $W^\#$ diagonal in the coordinate basis. Check: $w\equiv1$ gives $n-2$.

## Hypothesis inventory

| Hypothesis | Source | Used where | Checked against the object |
|---|---|---|---|
| $W$ symmetric on $\Lambda^2$ | definition of $\mathcal W_n$ | Claims 1, 2 (existence of an orthonormal eigenbasis, $W^T=W$ in the trace) | holds |
| inner product ad-invariant, $c$ totally antisymmetric | conventions line 61 | Claim 1 ($\langle[x,y],z\rangle=-\langle y,[x,z]\rangle$), Claim 6 ($c_{kba}=-c_{kab}$) | holds for $-\tfrac12\mathop{\mathrm{tr}}$ on $\mathfrak{so}(n)$ |
| factor $\tfrac12$ in the index formula for $\#$ | conventions line 77 | Claim 1 (the $-\tfrac12$), Claim 6 (the $2$ in (C)) | consistent, Section 1 |
| $W\in\mathcal W_n$ (Bianchi, Ricci-flat) | ambient | **unused** by Claims 1 to 6. Used by the definition of criticality (the first-order condition on the sphere of $\mathcal W_n$ is $Q(W)=\theta W$ only because $Q(W)\in\mathcal W_n$), by Claims 9, 10, 11 | the fact $Q(\mathcal W_n)\subset\mathcal W_n$ is imported by the definition and has no argument in the brief |
| $\lVert W\rVert=1$, $\theta=P(W)$ | conventions line 151 | **unused** by Claim 2 (the equivalence holds for every $\theta$ and every scale). Used in Claim 11 | a matrix form holding at some $\theta$ forces $\theta=P(W)$ once $\lVert W\rVert=1$, since $\langle W,Q(W)\rangle=\theta\lVert W\rVert^2$ |
| $n\ge4$ | ambient ($\mathcal W_3=0$) | Claims 9, 10 | Section 9 |
| $D$ | undefined in the brief | Claim 12 | cannot be checked |

The two unused hypotheses are benign: Claims 1 to 6 hold for every symmetric $W$ on $\mathfrak{so}(n)$ and every $\theta$. No step uses a hypothesis that is unstated, apart from the imported $Q(\mathcal W_n)\subset\mathcal W_n$ that the record's definition of "critical point" already rests on.

## 1. The polarised identity and $M_{kl}$

Located: "Polarising $\langle v,W^\#v\rangle=-\tfrac12\mathop{\mathrm{tr}}(\mathrm{ad}(v)W\mathrm{ad}(v)W)$ and substituting $W^\#=\theta W-W^2$ gives exactly that. Define $M_{kl}=\mathop{\mathrm{tr}}\big(\mathrm{ad}(\varphi_k)W\,\mathrm{ad}(\varphi_l)W\big)$".

Derivation, directly in bilinear form. From the index formula, $\langle u,W^\#v\rangle=\tfrac12\sum_{ab}\langle[Wv_a,Wv_b],u\rangle\,\langle[v_a,v_b],v\rangle$. By ad-invariance, $\langle[v_a,v_b],v\rangle=\langle v_a,[v_b,v]\rangle=-(\mathrm{ad}\,v)_{ab}$ and likewise $\langle[Wv_a,Wv_b],u\rangle=-\langle Wv_a,\mathrm{ad}(u)Wv_b\rangle=-(W\mathrm{ad}(u)W)_{ab}$. Hence $\langle u,W^\#v\rangle=\tfrac12\sum_{ab}(W\mathrm{ad}(u)W)_{ab}(\mathrm{ad}\,v)_{ab}=\tfrac12\mathop{\mathrm{tr}}\big((W\mathrm{ad}(u)W)^T\mathrm{ad}(v)\big)$. With $\mathrm{ad}(u)^T=-\mathrm{ad}(u)$ and $W^T=W$ this is $-\tfrac12\mathop{\mathrm{tr}}(\mathrm{ad}(u)W\mathrm{ad}(v)W)$. At $u=v$ it is the record's identity, and the form is symmetric in $u,v$ by cyclicity of the trace, so polarisation returns the same bilinear form.

Therefore $M_{kl}=-2\langle\varphi_k,W^\#\varphi_l\rangle=-2(W^\#)_{kl}$. The factor $2$ is exactly the inverse of the $\tfrac12$ in the index formula. Dropping that $\tfrac12$ would give $M_{kl}=-(W^\#)_{kl}$ and the value $\lambda_k(\lambda_k-\theta)$, so the record's $2$ is the one consistent with [conventions.md](../findings/conventions.md) line 77. Hypotheses used: $W$ symmetric, ad-invariance, the $\tfrac12$. Bianchi, Ricci-flatness and the norm are not used.

Candidate "the factor $2$ clashes with the $\tfrac12$": withdrawn at step 2, since the derivation above produces $-\tfrac12$ from the $\tfrac12$ with no residual factor.

## 2. Criticality is the matrix form

Located: "Then **criticality is equivalent to** $M_{kl}=2\lambda_k(\lambda_k-\theta)\,\delta_{kl}$".

In the orthonormal eigenbasis, $(W^2)_{kl}=\lambda_k^2\delta_{kl}$ and $(\theta W)_{kl}=\theta\lambda_k\delta_{kl}$. So $Q(W)=\theta W$ holds iff $(W^\#)_{kl}=\lambda_k(\theta-\lambda_k)\delta_{kl}$ for all $k,l$, iff (Section 1) $M_{kl}=-2\lambda_k(\theta-\lambda_k)\delta_{kl}=2\lambda_k(\lambda_k-\theta)\delta_{kl}$ for all $k,l$. Each step is an equivalence of linear equations entry by entry, so both directions hold. The $\delta_{kl}$ is a **conclusion** in the forward direction (vanishing of every off-diagonal entry) and a **hypothesis** in the reverse direction, and neither direction needs anything beyond Section 1.

Quantifier order: for fixed $W$ and fixed $\theta$, $Q(W)=\theta W$ iff the matrix form holds at that $\theta$ in one orthonormal eigenbasis, iff in every one. With $\lVert W\rVert=1$ the $\theta$ is forced to be $P(W)$.

## 3. The display's "i.e."

Located: "$M_{kl}=2\lambda_k(\lambda_k-\theta)\,\delta_{kl},\qquad\text{i.e.}\qquad \sum_{\alpha\beta}\lambda_\alpha\lambda_\beta\,c_{k\alpha\beta}c_{l\alpha\beta}=0\ \text{ whenever }\lambda_k\ne\lambda_l$".

In coordinates, $M_{kl}=\sum_{ab}(\mathrm{ad}\,\varphi_k)_{ab}\lambda_b(\mathrm{ad}\,\varphi_l)_{ba}\lambda_a=\sum_{ab}c_{kba}c_{lab}\lambda_a\lambda_b=-\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta c_{k\alpha\beta}c_{l\alpha\beta}$. The right side of the display is therefore $M_{kl}=0$ for $\lambda_k\ne\lambda_l$. It drops (i) every diagonal entry, (ii) every off-diagonal entry inside an eigenspace. The matrix form implies it, the converse fails (Section 7). Failure in closed form: the $n=4$ tensor of Section 7 satisfies the right side and violates the left at $\varphi_k=(e_1\wedge e_4)/\lVert\cdot\rVert$, where $M_{kk}=-2(W^\#)_{kk}=4\ne0=2\lambda_k(\lambda_k-\theta)$.

Charitable reading: the block's own blockquote says "the 'equivalently' is false", so the record knows. The display itself still carries "i.e." and "a family of scalar relations correlating the bracket data of distinct eigenvectors" as its gloss, and a reader who stops at the display reads a false equivalence. The finding stands against the display as written: REFUTED AS STATED, conceded in the adjacent text, not yet corrected in it.

## 4. The bracket form is $[W,Q(W)]=0$

Right side of the display $\iff$ $(W^\#)_{kl}=0$ whenever $\lambda_k\ne\lambda_l$ $\iff$ $W^\#$ maps each eigenspace of $W$ into itself $\iff$ $[W,W^\#]=0$ $\iff$ $[W,Q(W)]=0$, the last because $[W,W^2]=0$. Each link is an equivalence for symmetric $W^\#$. The condition is basis-free, so repeated eigenvalues cause no ambiguity. CONFIRMED.

Candidate "for repeated eigenvalues the bracket form depends on the eigenbasis": withdrawn at step 3, since the condition restricts only pairs in distinct eigenspaces and the chain above is basis-free.

## 5. Criticality forces vanishing for all $k\ne l$, basis-independently

At a critical point $W^\#=\theta W-W^2$ acts on the $\lambda$-eigenspace as the scalar $\lambda(\theta-\lambda)$, so it is diagonal in every orthonormal eigenbasis, including inside each eigenspace. CONFIRMED.

## 6. Diagonal entries against relation (C)

By Section 3, $M_{kk}=-\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta c_{k\alpha\beta}^2=-\sum\lambda_\beta\lambda_\gamma T_{k\beta\gamma}$. Then $M_{kk}=2\lambda_k(\lambda_k-\theta)$ reads $\sum\lambda_\beta\lambda_\gamma T_{k\beta\gamma}=2\lambda_k(\theta-\lambda_k)$, which is (C) of [bounds.md](../findings/bounds.md) line 262, sign for sign. Independently from the index formula, $(W^\#)_{kk}=\tfrac12\sum\lambda_\beta\lambda_\gamma T_{k\beta\gamma}=\lambda_k(\theta-\lambda_k)$, the same statement. The same normalisation gives (A): $(\mathrm{id}^\#)_{kk}=\tfrac12\sum T_{k\beta\gamma}=n-2$. The final paragraph of Passage A, "$\sum\lambda_\alpha\lambda_\beta c_{k\alpha\beta}^2=2\lambda_k(\theta-\lambda_k)$", agrees. CONFIRMED.

Candidate "$M_{kk}=2\lambda_k(\lambda_k-\theta)$ and (C)'s $2\lambda_k(\theta-\lambda_k)$ differ in sign": withdrawn at step 2, the minus sign in $M_{kl}=-\sum\lambda\lambda cc$ accounts for it.

## 7. Strictness on $\mathcal W_n$

Located: heading "the bracket form is strictly weaker" and "Measured here on six diagonal elements of $\mathcal W_6$ ... off-diagonal residual $0.000\times10^{0}$ exactly, at criticality residuals $0.527$ to $0.741$".

**What is on file.** A measurement on six elements of $\mathcal W_6$, and the Lean theorem bracket_form_strictly_weaker, whose witness is $\lambda=(1,-1)$ on Fin 2 with Ws $=0$. That witness is a pair of abstract predicates on a 2-element index set. $2$ is not $\binom n2$ for any $n$, Ws is a free matrix unrelated to $W^\#$ of anything, and no Weyl structure is present. So no argument on file shows strictness **inside $\mathcal W_n$**, and the heading's second clause rests on a run. HYPOTHESIS-DEBT.

**What would have to be proved:** one $W\in\mathcal W_n$ with $[W,W^\#]=0$ and $Q(W)\notin\mathbb RW$. Testing the universal "bracket form implies criticality" against the coordinate-diagonal family at $n=4$ produces one in closed form. Take $w_{12}=w_{34}=1$, $w_{13}=w_{24}=-1$, $w_{14}=w_{23}=0$. Row sums vanish, so $W$ is Ricci-flat, and Bianchi holds for every coordinate-diagonal operator (its $\Lambda^4$ component needs four distinct indices). By Section 0, $(W^\#)_{12}=w_{13}w_{23}+w_{14}w_{24}=0$, $(W^\#)_{13}=w_{12}w_{32}+w_{14}w_{34}=0$, $(W^\#)_{14}=w_{12}w_{42}+w_{13}w_{43}=2\cdot1\cdot(-1)=-2$, and the paired planes agree. So $Q(W)=\mathrm{diag}(1,1\,|\,1,1\,|\,-2,-2)$ on $(e_{12},e_{34}\,|\,e_{13},e_{24}\,|\,e_{14},e_{23})$, traceless as it must be. $W^\#$ is diagonal, so the bracket form holds. $Q(W)$ is nonzero on $\ker W\ni e_1\wedge e_4$, so $Q(W)\ne\theta W$ for every $\theta$, and $W/2$ is a non-critical unit Weyl tensor. This discharges the debt once recorded.

**Edge found while testing.** At $n=4$ the bracket form holds on **all** of $\mathcal W_4$. A Weyl tensor preserves $\Lambda^\pm$, the ideals of $\mathfrak{so}(4)=\mathfrak{so}(3)\oplus\mathfrak{so}(3)$, so $c_{acd}\ne0$ forces $a,c,d$ into one ideal and $W^\#$ has no $\Lambda^+\times\Lambda^-$ block. On $\Lambda^+$ in an eigenbasis of $W^+$, relation (A) with $2(n-2)=4$ split over two ordered pairs gives $c_{acd}^2=2$, hence $(W^\#)_{ab}=\tfrac12\sum_{cd}c_{acd}c_{bcd}\lambda_c\lambda_d=2\lambda_c\lambda_d\,\delta_{ab}$ with $\{a,c,d\}=\{1,2,3\}$, that is $W^\#|_{\Lambda^+}=2\,\mathrm{adj}(W^+)$, diagonal. So $[W,W^\#]=0$ identically on $\mathcal W_4$ and the bracket form carries no information there. The record states strictness without saying that at $n=4$ it is strictness against a vacuous condition. This is a scope remark, recorded under Claim 7, and it does not make Claim 7 false.

## 8. Every coordinate-diagonal Weyl tensor satisfies the bracket form

Located: Passage A "every diagonal Weyl tensor satisfies it", [conventions.md](../findings/conventions.md) line 151 "is satisfied by every diagonal Weyl tensor".

On file: a run on six elements of $\mathcal W_6$. A universal over an $n(n-3)/2$-dimensional family is not established by six samples, so HYPOTHESIS-DEBT. What would have to be proved: $W^\#$ is diagonal in the coordinate basis whenever $W$ is. That is the one-line fact in Section 0 (a bracket of two coordinate planes is $\pm$ a single coordinate plane or zero, so $c_{acd}c_{bcd}\ne0$ forces $a=b$), after which $[W,W^\#]=0$ is immediate. Testing against diagonal, padded, and the sphere products found no failure. Reading "diagonal" as "diagonal in some eigenbasis" would make the claim cover every $W$ and contradict the record's own random screen, so the coordinate-diagonal reading of the brief's definitions is the one checked.

## 9. "Nowhere near critical"

Located: "**every diagonal Weyl tensor satisfies it while being nowhere near critical**".

Failure in closed form, two members of the family that are critical.

- $n=4$, $S^2\times S^2$: $w_{12}=w_{34}=2$, $w_{13}=w_{24}=w_{14}=w_{23}=-1$ (the Weyl part of the product up to the factor $\tfrac13$). Then $Q$ on $e_{12}$ is $4+2(-1)(-1)=6=3\cdot2$, on $e_{13}$ is $1+2\cdot2\cdot(-1)=-3=3\cdot(-1)$, on $e_{14}$ likewise $-3$. So $Q(W)=3W$.
- $n=6$, $S^3\times S^3$: $w=3$ on the six in-factor planes, $w=-2$ on the nine mixed planes. On $e_{12}$: $W^\#=w_{13}w_{23}+\sum_{k=4}^6w_{1k}w_{2k}=9+12=21$, $W^2=9$, $Q=30=10\cdot3$. On $e_{14}$: $W^\#=\sum_{k=2,3}w_{1k}w_{4k}+\sum_{k=5,6}w_{1k}w_{4k}=-12-12=-24$, $W^2=4$, $Q=-20=10\cdot(-2)$. So $Q(W)=10W$.

Both are coordinate-diagonal, Ricci-flat (row sums $2-1-1=0$ and $3+3-2\cdot3=0$), hence in the family, and both are critical after normalisation. Padding either by zero gives critical coordinate-diagonal members at every larger $n$ (Section 10). The universal is false.

Charitable reading: "a generic diagonal Weyl tensor is not critical", supported by the six measured residuals. That reading is true (Section 7 gives a member) but it is not what the sentence says, and it is the sentence used to support strictness. REFUTED AS STATED. The residual values $0.527$ to $0.741$ are run-only and are not checked here.

## 10. The dimension $n(n-3)/2$

Located: "That is an $n(n-3)/2$-dimensional family." No argument on file. What would have to be proved: the linear map $w\mapsto(\sum_jw_{ij})_i$ from $\mathbb R^N$ to $\mathbb R^n$ is onto, so that the Ricci-flat coordinate-diagonal operators (Bianchi being automatic) form a subspace of dimension $N-n=n(n-3)/2$. The map is the unsigned incidence matrix of $K_n$, whose rank is $n$ exactly when $K_n$ is non-bipartite, which holds for $n\ge3$. At $n=4$ this is the 2-dimensional family $(x,y,z)$, $x+y+z=0$, used in Sections 7 and 9. The claim is true and the argument is not on the record, so GAP. The count is of the linear family, and on the unit sphere it is $n(n-3)/2-1$.

## 11. "$N$ constraints where the record used one"

Located: "the diagonal entries pin $\sum\lambda_\alpha\lambda_\beta c_{k\alpha\beta}^2=2\lambda_k(\theta-\lambda_k)$ for every $k$, which is $N$ constraints where the record used one".

No argument on file for independence. Dependencies in closed form, following the step's own algebra with $E_k$ the $k$-th equation (C):

- $\sum_k\lambda_kE_k$ is an identity. Its left side is $2\sum_k\lambda_k(W^\#)_{kk}=2\langle W,W^\#\rangle$, its right side is $2\theta\lVert W\rVert^2-2\mathop{\mathrm{tr}}W^3=2\theta-2\mathop{\mathrm{tr}}W^3$, and $\theta=P(W)=\mathop{\mathrm{tr}}W^3+\langle W,W^\#\rangle$ makes them equal. So the $\lambda$-weighted sum restates the definition of $\theta$.
- $\sum_kE_k$ reads $2\mathop{\mathrm{tr}}W^\#=2\theta\mathop{\mathrm{tr}}W-2\lVert W\rVert^2$, which is $\mathop{\mathrm{tr}}Q(W)=0$. It is an identity on $\mathcal W_n$ given the imported fact $Q(\mathcal W_n)\subset\mathcal W_n$ that the definition of criticality already uses.
- At $n=4$, in a $\Lambda^\pm$-adapted eigenbasis, $\sum_{k\in\Lambda^+}E_k$ reads $2\cdot2\sigma_2(W^+)=-2\lVert W^+\rVert^2$, true for every $W\in\mathcal W_4$ and every $\theta$ (Section 7), and likewise for $\Lambda^-$.

So the $N$ diagonal equations carry at most $N-2$ independent constraints for $n\ge5$ (given the import, and since $\lambda$ is orthogonal to $\mathbf 1$ and nonzero) and at most $N-3=3$ at $n=4$ when $W\ne0$, since the weight vectors $\lambda$, $\mathbf 1_{\Lambda^+}$, $\mathbf 1_{\Lambda^-}$ are independent there. Charitable reading: "$N$ scalar equations, one per index". Under that reading the count is right. Under the reading the sentence invites, $N$ constraints of content against one, it overcounts, and the adjacent sentence "a route may not count it as an extra constraint" shows the record cares about exactly that distinction. GAP: the record needs either "N equations" or an independence count with the dependencies above removed.

## 12. The Jacobi identity and the off-diagonal entries

Located: "the off-diagonal entries are the only place the Jacobi identity can enter a bound on $D$". $D$ is not defined in the brief. The half that can be checked: the diagonal entries are functions of $T=c^2$ (Section 6), while $M_{kl}=-\sum\lambda_\alpha\lambda_\beta c_{k\alpha\beta}c_{l\alpha\beta}$ for $k\ne l$ is a sum of products of distinct, sign-bearing structure constants, which is not a function of $T$ in general. The half that cannot: "the only place" is a universal non-existence statement about every bound on $D$, and no argument is on file. What would have to be proved: every consequence of the Jacobi identity for $D$ that is expressible in $(\lambda,\theta,T)$ already follows from (A), (B), (C), which is the completeness statement of [bounds.md](../findings/bounds.md) line 258 applied to $D$. GAP.

## 13. L111Statement.lean against Passage A

- IsCriticalHere lam Ws θ is $\lambda_k^2\delta_{kl}+\mathrm{Ws}_{kl}=\theta\lambda_k\delta_{kl}$, which is $Q(W)=\theta W$ in an eigenbasis when Ws is read as the matrix of $W^\#$. Ws is a free function $\kappa\to\kappa\to\mathbb R$, not required symmetric, not tied to lam through the index formula, and no Weyl, norm, or $\theta=P(W)$ condition is present.
- Mmat Ws $=-2\,$Ws **defines** the identity of Section 1. The polarised identity and the factor $2$ are therefore assumed, not checked, in Lean.
- matrix_form_is_criticality: direction and binders match Claim 2 at fixed $\theta$. True algebra.
- commutes_iff_bracket_form: CommutesWithW is $\lambda_kQ_{kl}=Q_{kl}\lambda_l$, the eigenbasis form of $[W,Q]=0$, and BracketForm is Ws $=0$ off $\lambda_k=\lambda_l$, which is $M_{kl}=0$ there. Matches Claim 4.
- critical_forces_all_offdiagonal and critical_imp_bracket_form match Claim 5 and the implication half of Claim 3.
- bracket_form_strictly_weaker: the witness is not a Weyl tensor (Section 7). It proves strictness of the predicates, not on $\mathcal W_n$.
- The bracket-coordinate form $\sum\lambda\lambda cc$ and relation (C) do not appear. Structure constants are absent from both files.
- dropped_count_identity and counts_at_balanced_products are true, and their multiplicities $(6,9)$ at $n=6$ and $(30,36)$ at $n=12$ are the $\Lambda^2$ spectra of the balanced products (Section 14). These counts have no counterpart in the lemma block as cited.
- dropped_fractions compares $1130/2210$, while counts_at_balanced_products proves $1131$ of $2211$. The two fractions differ, $1131\cdot2210=2499510\ne2498430=1130\cdot2211$, and the $n=6$ fraction $66/120$ subtracts nothing. Both $n=12$ fractions lie in $(0.511,0.512)$, so the stated inequality is true of either, but the theorem does not state the ratio its sibling counts.

Verdict CONFIRMED AS ALGEBRA: every theorem is true of its definitions, and none of them reaches $\mathcal W_n$.

## 14. L111.lean multiplicities at the balanced products

Located: "theorem multiplicities_six : 3 + 3 + 9 = Nat.choose 6 2", "theorem dropped_six : dropped 3 + dropped 3 + dropped 9 = 57", "theorem share_six : (57 : ℚ) / 120 = 19 / 40", "theorem multiplicities_four : 1 + 1 + 4 = Nat.choose 4 2", "theorem dropped_four : dropped 1 + dropped 1 + dropped 4 = 12".

The $\Lambda^2$ spectrum of the Weyl tensor of $S^3(k_1)\times S^3(k_2)$, from $R=W+\tfrac1{n-2}\mathring{\mathrm{Ric}}\owedge g+\tfrac{\mathrm{scal}}{n(n-1)}\mathrm{id}$ with $(\mathring{\mathrm{Ric}}\owedge g)(e_{ij})=(\mathring{\mathrm{Ric}}_{ii}+\mathring{\mathrm{Ric}}_{jj})e_{ij}$: $\mathrm{Ric}=\mathrm{diag}(2k_1^{\times3},2k_2^{\times3})$, $\mathrm{scal}=6(k_1+k_2)$, $\mathring{\mathrm{Ric}}=\mathrm{diag}((k_1-k_2)^{\times3},(k_2-k_1)^{\times3})$. On a factor-1 plane $w=k_1-\tfrac{k_1-k_2}2-\tfrac{k_1+k_2}5=\tfrac{3(k_1+k_2)}{10}$, on a factor-2 plane the same value, on a mixed plane $w=-\tfrac{k_1+k_2}5$. So the spectrum is $\tfrac{k_1+k_2}{10}(3^{\times6},-2^{\times9})$ for every $k_1+k_2\ne0$, multiplicities **$(6,9)$**, never $(3,3,9)$: the two factors share their in-factor eigenvalue at every choice of radii. At $n=4$ the same computation gives $\tfrac{k_1+k_2}{6}(2^{\times2},-1^{\times4})$, multiplicities **$(2,4)$**, not $(1,1,4)$.

With dropped $m=\binom{m+1}2$ counting the entries of $M$ inside one eigenspace, the correct shares are $21+45=66$ of $120$ at $n=6$ (as L111Statement.lean has it) and $3+10=13$ of $21$ at $n=4$. L111.lean's $57/120=19/40$ and $12/21$ undercount by the cross-factor block $3\cdot3=9$ and $1\cdot1=1$, which the bracket form also drops because the eigenvalues coincide. cross_dominates's $45/57$ inherits the wrong denominator. The theorems are true arithmetic, and their multiplicities are not the spectrum. share_in_range places $19/40$ in $(0.45,0.51)$, while the correct $11/20=0.55$ lies outside that interval.

Charitable reading: $(3,3,9)$ counts planes by factor, a finer partition than the eigenspaces, and "split_from_L76" says it comes from that partition. Under that reading the numbers count something, but the quantity the bracket form drops is indexed by eigenvalue coincidence, which is $(6,9)$. REFUTED as a model of the balanced product.

## 15. Boundary

- **$n=4$**, the smallest admissible dimension: Claims 1 to 6 hold. The bracket form is identically true on $\mathcal W_4$ (Section 7). The family has dimension 2 and contains the critical $S^2\times S^2$ and the non-critical witness.
- **$n=5$, odd $n$**: nothing in Claims 1 to 6 depends on parity. The family dimension $5$ follows from the non-bipartite incidence rank. Padding $S^2\times S^2$ by one zero row gives a critical coordinate-diagonal member with a 4-dimensional kernel.
- **Crossover $n=6+2\sqrt7$**: no claim of L111 changes there. The lemma carries no $n$-range.
- **$\ker W\ne0$ and padded objects**: no step divides by $\lambda_k$. Rows with $\lambda_k=0$ read $M_{kl}=0$ for all $l$. For $W$ supported on $\mathfrak{so}(m)\subset\mathfrak{so}(n)$, every $c_{acd}W_{ce}W_{df}\ne0$ has $c,d\in\mathfrak{so}(m)$ and so $a\in\mathfrak{so}(m)$, hence $Q(W\oplus0)=Q(W)\oplus0$ with the same $\theta$. Padding preserves criticality, the bracket form, and non-criticality.
- **Repeated eigenvalues**: Sections 4 and 5.

## Withdrawn candidates

| Candidate | Step failed | Reason |
|---|---|---|
| The factor $2$ in $M_{kl}$ clashes with the $\tfrac12$ of the index formula | exhibit | Section 1 produces exactly $-\tfrac12$ |
| $M_{kk}=2\lambda_k(\lambda_k-\theta)$ has the opposite sign to (C) | exhibit | $M_{kl}=-\sum\lambda\lambda cc$ absorbs the sign |
| The bracket form is basis-dependent under repeated eigenvalues | charitable reading | it is $[W,W^\#]=0$, basis-free |
| Padded objects or $\ker W\ne0$ break the matrix-form equivalence | exhibit | $Q(W\oplus0)=Q(W)\oplus0$, no division by $\lambda$ |
| The Lean sign of Mmat contradicts the record | exhibit | $-2\,$Ws matches Section 1 |

## The falsifying object and the search

- For Claim 2, a falsifier would be a symmetric $W$ and a $\theta$ with the matrix form and $Q(W)\ne\theta W$. None exists, since the equivalence is entrywise linear algebra (Section 2).
- For the heading's strictness, the falsifier would be a proof that $[W,Q(W)]=0$ forces criticality on $\mathcal W_n$. The $n=4$ tensor of Section 7 rules that out.
- For Claim 9, the falsifier is a critical coordinate-diagonal Weyl tensor. Tried: diagonal family at $n=4$ (found $S^2\times S^2$), sphere products at $n=6$ (found $S^3\times S^3$), padded objects (preserve criticality), $\mathbb{CP}^m$ (not coordinate-diagonal, since the Fubini–Study operator couples $e_{12}$ and $e_{34}$, so outside the family).
- For Claim 14, the falsifier is the $\Lambda^2$ Weyl spectrum of $S^3(k_1)\times S^3(k_2)$, computed for all radii in Section 14.

## Overall verdict: HYPOTHESIS-DEBT

The core of L111, criticality as $M_{kl}=2\lambda_k(\lambda_k-\theta)\delta_{kl}$ with $M_{kl}=-2(W^\#)_{kl}$, its diagonal agreement with (C), and the identification of the bracket form with $[W,Q(W)]=0$, is proven. The heading's second clause, strictness on $\mathcal W_n$, rests on a run and on a Lean witness that is not a Weyl tensor. The closed-form witness of Section 7 discharges it, and with that witness recorded, the display's "i.e." struck, "nowhere near critical" corrected, the independence of the $N$ diagonal equations restated, and L111.lean's multiplicities set to $(6,9)$ and $(2,4)$, the lemma would stand as PROVEN (hypotheses corrected).
