# Verifier v332, the "i.e." equivalence in the L111 display (step D1)

*Cold brief ([ADJ_L111_D1.md](ADJ_L111_D1.md)). No numerical work, no scripts written, every value below exact and derived by hand. Log: [agent_logs/verify-L111-v332.log](../agent_logs/verify-L111-v332.log).*

| # | Claim | Verdict |
|---|---|---|
| 1 | $M_{kl}=-S_{kl}$ with $S_{kl}=\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta c_{k\alpha\beta}c_{l\alpha\beta}$, and $(W^\#)_{kl}=\tfrac12 S_{kl}$ in the record's halved convention | CONFIRMED AS ALGEBRA |
| 2 | $M_{kl}=2\lambda_k(\lambda_k-\theta)\delta_{kl}$ for all $k,l$ is equivalent to $Q(W)=\theta W$ | CONFIRMED |
| 3 | Matrix form implies $S_{kl}=0$ whenever $\lambda_k\ne\lambda_l$ | CONFIRMED |
| 4 | $S_{kl}=0$ whenever $\lambda_k\ne\lambda_l$ implies the matrix form | REFUTED |
| 5 | The step as written (the two-sided "i.e.") | REFUTED AS STATED |

**Summary: the step FAILS, the bracket condition is exactly $[W,Q(W)]=0$ and misses the diagonal entries and the entries inside an eigenspace, and the unit coordinate-diagonal Weyl tensor with $w_{12}=w_{34}=\tfrac12$, $w_{14}=w_{23}=-\tfrac12$ (all other $w_{ij}=0$) satisfies it in every $n\ge4$ while $S$ at $e_1\wedge e_3$ equals $-1$ against the required $0$.**

## 0. Conventions, fixed once

- $\mathfrak{so}(n)\cong\Lambda^2\mathbb R^n$ with the ad-invariant inner product for which $\{e_i\wedge e_j\}_{i<j}$ is orthonormal, $N=\binom n2$.
- $\{v_k\}$ is an orthonormal eigenbasis of $W$, $Wv_k=\lambda_kv_k$, and $c_{abc}=\langle[v_a,v_b],v_c\rangle$, totally antisymmetric.
- $\mathrm{ad}(v)$ has matrix entries $(\mathrm{ad}\,v_k)_{ba}=\langle[v_k,v_a],v_b\rangle=c_{kab}$ (row $b$, column $a$).
- $(W^\#)_{ab}=\tfrac12\sum_{cdef}c_{acd}c_{bef}W_{ce}W_{df}$, the record's halved convention (Passage B, conventions line 151), $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$.
- "Critical" means $\lVert W\rVert=1$ and $Q(W)=\theta W$ for a scalar $\theta$, which then equals $P(W)$ (Passage B, conventions line 77).
- $S_{kl}:=\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta c_{k\alpha\beta}c_{l\alpha\beta}$, the quantity on the right of the display.
- LHS denotes "$M_{kl}=2\lambda_k(\lambda_k-\theta)\delta_{kl}$ for all $k,l$", RHS denotes "$S_{kl}=0$ whenever $\lambda_k\ne\lambda_l$".

## Hypothesis inventory

- **H0 (standing).** $W\in\mathcal W_n$, $\lVert W\rVert=1$, $\{v_k\}$ an orthonormal eigenbasis, $\theta=P(W)$. Used in every section.
- **H1 (unwritten, needed for the reverse direction).** The diagonal relations $S_{kk}=2\lambda_k(\theta-\lambda_k)$ hold for every $k$ with one common $\theta$. This is relation (C) of Passage B, which the record itself derives from criticality, so it cannot be taken as free.
- **H2 (unwritten, needed for the reverse direction).** $S_{kl}=0$ for every $k\ne l$ with $\lambda_k=\lambda_l$ in the chosen eigenbasis. Equivalently, the eigenbasis is chosen to diagonalise $W^\#$ on each eigenspace of $W$, which RHS makes possible, and then H1 is read in that basis.
- **Simple-spectrum variant.** If every eigenvalue of $W$ is simple, H2 is vacuous and H1 alone suffices.

## 1. The bracket expression for $M$

With $A=\mathrm{ad}(v_k)$, $B=\mathrm{ad}(v_l)$ and $W=\mathrm{diag}(\lambda)$ in the eigenbasis,
$$M_{kl}=\mathop{\mathrm{tr}}(AWBW)=\sum_{a,b}A_{ab}\lambda_bB_{ba}\lambda_a=\sum_{a,b}c_{kba}\,c_{lab}\,\lambda_a\lambda_b=-\sum_{a,b}\lambda_a\lambda_b\,c_{kab}c_{lab}=-S_{kl},$$
using $c_{kba}=-c_{kab}$. The index formula gives $(W^\#)_{kl}=\tfrac12\sum_{cd}c_{kcd}c_{lcd}\lambda_c\lambda_d=\tfrac12S_{kl}$. So $\langle v_k,W^\#v_l\rangle=-\tfrac12M_{kl}$, which is the polarised identity quoted in Passage A, with the $\tfrac12$ of Passage B in place. $M$ is symmetric by cyclicity of the trace. Claim 1 holds.

## 2. LHS is criticality

In the eigenbasis $Q(W)_{kl}=\lambda_k^2\delta_{kl}+\tfrac12S_{kl}$ and $(\theta W)_{kl}=\theta\lambda_k\delta_{kl}$. So $Q(W)=\theta W$ holds if and only if $S_{kl}=2\lambda_k(\theta-\lambda_k)\delta_{kl}$ for all $k,l$, which by section 1 is $M_{kl}=2\lambda_k(\lambda_k-\theta)\delta_{kl}$. If this holds for some scalar $\theta$ then $P(W)=\sum_k\lambda_k(\lambda_k^2+\lambda_k(\theta-\lambda_k))=\theta\sum_k\lambda_k^2=\theta$, so the $\theta$ is forced to be $P(W)$ by H0. Claim 2 holds. This agrees with [matrix_form_is_criticality](../lean/HamiltonsCubic/Results/L111Statement.lean), whose model sets $M=-2W^\#$.

## 3. RHS is exactly $[W,Q(W)]=0$

$[W,W^2]=0$, and $[W,W^\#]_{kl}=(\lambda_k-\lambda_l)(W^\#)_{kl}=\tfrac12(\lambda_k-\lambda_l)S_{kl}$. So $[W,Q(W)]=0$ holds if and only if $S_{kl}=0$ whenever $\lambda_k\ne\lambda_l$, which is RHS. The condition is basis-independent: it says $P_\mu W^\#P_\nu=0$ for the spectral projections of distinct eigenvalues $\mu\ne\nu$. This is the content of [commutes_iff_bracket_form](../lean/HamiltonsCubic/Results/L111Statement.lean).

## 4. The forward direction holds

$\lambda_k\ne\lambda_l$ forces $k\ne l$, so $\delta_{kl}=0$ and LHS gives $S_{kl}=-M_{kl}=0$. Claim 3 holds, matching [critical_imp_bracket_form](../lean/HamiltonsCubic/Results/L111Statement.lean).

## 5. The reverse direction fails, located and exhibited

**Where.** The display line (findings/bounds.md line 656) reads "$M_{kl}=2\lambda_k(\lambda_k-\theta)\,\delta_{kl},\ \text{i.e.}\ \sum_{\alpha\beta}\lambda_\alpha\lambda_\beta\,c_{k\alpha\beta}c_{l\alpha\beta}=0\ \text{ whenever }\lambda_k\ne\lambda_l$". LHS fixes all $N^2$ entries of $S$. RHS constrains only the entries between distinct eigenspaces. Two families of entries are left free: the diagonal $S_{kk}$, which LHS pins to $2\lambda_k(\theta-\lambda_k)$ with a common $\theta$, and the off-diagonal $S_{kl}$ with $k\ne l$, $\lambda_k=\lambda_l$, which LHS pins to $0$.

**Closed-form counterexample, any $n\ge4$.** Let $W$ be coordinate-diagonal with eigenvalue $w_{ij}=w_{ji}$ on $e_i\wedge e_j$, where
$$w_{12}=w_{34}=\tfrac12,\qquad w_{14}=w_{23}=-\tfrac12,\qquad w_{ij}=0\ \text{otherwise}.$$

- *It lies in $\mathcal W_n$.* A symmetric operator on $\Lambda^2$ that is diagonal on coordinate planes has $R_{ijkl}=0$ whenever $i,j,k,l$ are distinct, so its $\Lambda^4$ component vanishes and the first Bianchi identity holds. Ricci-flatness is $\sum_{j\ne i}w_{ij}=0$ for each $i$: rows 1 to 4 give $\tfrac12+0-\tfrac12=0$ and rows $i\ge5$ are zero.
- *It is a unit vector.* $\lVert W\rVert^2=4\cdot\tfrac14=1$.
- *Its bracket data.* In the coordinate basis $[e_i\wedge e_k,e_j\wedge e_k]=\pm e_i\wedge e_j$ and every bracket of two basis elements is $0$ or $\pm$ one basis element, so $c_{abc}\in\{0,\pm1\}$ and $c_{acd}c_{bcd}=0$ for $a\ne b$. Hence $S$ is diagonal in the coordinate basis, with $S_{ij,ij}=2\sum_{k\ne i,j}w_{ik}w_{jk}$ (the factor 2 counts the two orderings of the pair). As a check, $W=\mathrm{id}$ gives $S_{aa}=2(n-2)$, relation (A).
- *RHS holds.* The coordinate basis is an eigenbasis in which $S_{kl}=0$ for all $k\ne l$, and by section 3 the condition is basis-independent, so it holds in every eigenbasis. $W$ commutes with $Q(W)$.
- *LHS fails for every $\theta$.* Take $k=e_1\wedge e_3$, so $\lambda_k=w_{13}=0$. Then $S_{kk}=2(w_{12}w_{32}+w_{14}w_{34})=2\big(\tfrac12\cdot(-\tfrac12)+(-\tfrac12)\cdot\tfrac12\big)=-1$, while LHS requires $S_{kk}=2\lambda_k(\theta-\lambda_k)=0$. Equivalently $M_{kk}=1\ne0=2\lambda_k(\lambda_k-\theta)$, and $Q(W)e_{13}=W^\#e_{13}=-\tfrac12e_{13}\ne0=\theta We_{13}$.

So RHS holds and LHS fails. Claim 4 is refuted and the two-sided "i.e." is refuted as stated (claim 5). The same coordinate-diagonal mechanism makes RHS hold for the whole coordinate-diagonal family, whose dimension is $\binom n2-n=n(n-3)/2$ (symmetric zero-diagonal matrices with zero row sums), matching the dimension quoted in Passage A.

## 6. Arguing the opposite

- *Could an identity on $\mathcal W_n$ force the diagonal entries?* No. Section 5 is a genuine unit Weyl tensor on which a diagonal entry is off by exactly $1$, and relation (C) is itself a consequence of criticality in the record, never an identity of $\mathcal W_n$.
- *Could "i.e." be read as a gloss on the off-diagonal content alone?* Under that reading the diagonal content is carried separately by H1, and the display then also needs H2. With H0, H1 and H2 the reverse direction holds: RHS and H2 give $S_{kl}=0$ for all $k\ne l$, H1 gives the diagonal, and section 2 turns the full matrix identity into $Q(W)=\theta W$. H2 cannot be dropped from that argument: RHS with H1 in a basis that fails to diagonalise $W^\#$ on an eigenspace leaves $P_\lambda W^\#P_\lambda$ with constant diagonal and possibly nonzero off-diagonal, which is not $\lambda(\theta-\lambda)P_\lambda$. Whether a Weyl tensor realises that particular gap is left open here, and nothing in the verdict depends on it. Under this reading the right-hand side is no longer the displayed condition, so the display as written still fails.
- *Could the step mean "whenever $k\ne l$"?* Then RHS is the off-diagonal part of LHS, and H1 is still needed, since section 5 has $S_{kl}=0$ for all $k\ne l$ and fails on the diagonal.
- *Consistency with the block's own note.* The blockquote at line 658 already says the bracket form "is exactly $[W,Q(W)]=0$" and is strictly weaker, and the Lean lemma [bracket_form_strictly_weaker](../lean/HamiltonsCubic/Results/L111Statement.lean) exhibits abstract data ($\lambda=(1,-1)$, $W^\#=0$) that are not tied to a Weyl tensor. Section 5 supplies the gap on an actual element of $\mathcal W_n$ in closed form, and agrees with the note.

## 7. Verdict

**FAILS.** The display's left side is criticality (sections 1 and 2) and its right side is $[W,Q(W)]=0$ (section 3). The forward implication is valid (section 4), and the reverse fails on the unit Weyl tensor of section 5 for every $n\ge4$. A VALID reading needs H0 together with H1 (diagonal relations (C) with a common $\theta$) and H2 (vanishing for $k\ne l$ inside each eigenspace, or an eigenbasis adapted to $W^\#$), or H0 with H1 and simple spectrum. Each of these reading changes the right-hand side into the full matrix identity, so the "i.e." as written is an implication in one direction only.
