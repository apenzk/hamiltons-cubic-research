# Verifier v244, L49: the eigenframe display, the collapse space and its dimension, the trace-condition count, non-realisation of constant T, and the n = 4 and n >= 5 corollaries

The brief was cold: I worked from verification/BRIEF_L49.md and the definitions alone, and opened no round file, plan, ledger, review or other verifier's log. No numerical work was done, no scripts were written, every value below is exact, and the Lean file was read by hand (not built). Sources opened: findings/target.md line 775 only, results.md lines 188, 653 and 655, lean/HamiltonsCubic/Results/L49Statement.lean (identical to the brief's block, 343 lines against the brief's stated 344), the definitions of `objective`, `distinctSum`, `increasingSum`, `objective_eq_increasingSum` and `distinctSum_eq_six` in lean/HamiltonsCubic/Results/L42Statement.lean, and Böhm and Wilking, references/boehm-wilking-2008-space-forms/ lines 40 to 75 and 170 to 190. Log: agent_logs/verify-L49-v244.log

| # | Claim | Verdict |
|---|---|---|
| C1 | Eigenframe display $\theta=\sum\lambda^3+3\sum_{\alpha<\beta<\gamma}T\lambda\lambda\lambda$, coefficient 3 | HYPOTHESIS-DEBT |
| C2 | The collapse condition is linear in $T$ and the collapsing set is a subspace | CONFIRMED |
| C3 | Under one trace condition the collapse space is one-dimensional, $T$ constant, at every $N\ge4$ | CONFIRMED AS ALGEBRA |
| C4a | The number of independent trace conditions equals the number of irreducible summands of $\mathcal W_n$ | HYPOTHESIS-DEBT |
| C4b | Passage C: summands counted "under $O(n)$", with $\mathcal W_4$ "reducible" | REFUTED AS STATED |
| C5 | Constant $T$ is realised by no $\mathfrak{so}(n)$ | HYPOTHESIS-DEBT |
| C6 | For $n\ge5$ the cubic is a function of the spectrum alone at no critical point | GAP |
| C7 | At $n=4$ the cubic is spectral | HYPOTHESIS-DEBT |
| C8a | Passage D's theorem types C2 and C3 with the quantifier the canon states | CONFIRMED |
| C8b | Passage D's docstring: "the same condition at one fixed $\lambda$ is codimension $1$ in $T$" | REFUTED AS STATED |

**What the round should do:** keep L49 as the typed algebraic characterisation (collapse over $\sum\lambda=0$ with $\exists c\,\forall\lambda$, constants on distinct triples, valid at $N\ge3$), replace "under $O(n)$" by $SO(n)$ with an eigenframe adapted to $\Lambda^+\oplus\Lambda^-$, file the derivation and normalisation of the display, and carry non-realisation and both corollaries as open.

## 0. Conventions, fixed once

- $\mathfrak{so}(n)$ carries $\langle A,B\rangle=-\tfrac12\operatorname{tr}(AB)$, under which $E_{ij}=e_ie_j^{\mathsf T}-e_je_i^{\mathsf T}$ ($i<j$) is orthonormal. $N=\binom n2$.
- $\#$ is Böhm and Wilking's, their eq. (4) (source line 173 onward): $\langle(R\#S)(h),h\rangle=\tfrac12\sum_{\alpha,\beta}\langle[R b_\alpha,S b_\beta],h\rangle\langle[b_\alpha,b_\beta],h\rangle$ for an orthonormal basis $b$, and $R^\#=R\#R$. The source states the factor $\tfrac12$ is tied to the scalar product $-\tfrac12\operatorname{tr}$.
- Operators on $\mathfrak{so}(n)$ are paired by $\langle A,B\rangle=\operatorname{tr}(A^{\mathsf T}B)$, so $\langle W,W^2\rangle=\sum\lambda_\alpha^3$.
- $c_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle$, $T=c^2$. $p_k=\sum\lambda^k$, $e_3=\sum_{\alpha<\beta<\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$, $C_T(\lambda)=\sum_{\alpha<\beta<\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$, $V=\{\lambda\in\mathbb R^N:p_1=0\}$.
- "Collapse" in the canonical reading (Passage C, Lean `Collapses`): $\exists c\ \forall\lambda\in V:\ p_3+3C_T=c\,p_3$.

## Hypothesis inventory

| Hypothesis | Where | Checked against the object | Used by the proof |
|---|---|---|---|
| $W\in\mathcal W_n$ symmetric on $\mathfrak{so}(n)$ with orthonormal eigenframe | A, C, definitions | Holds, spectral theorem | C1 only |
| Inner product on $\mathfrak{so}(n)$ and the normalisation of $\#$ | Unstated in A, B, C | The coefficient 3 depends on it (section 1) | C1, silently |
| $c$ totally antisymmetric | Unstated | Holds for any ad-invariant inner product: $\operatorname{tr}([X,Y]Z)=\operatorname{tr}(X[Y,Z])$ | C1 (kills repeated-index terms) |
| "The trace conditions", a single one $\sum\lambda=0$ | C ("$n\ge5$"), Lean `Collapses` | Under the brief's definition, a single condition at every $n\ge4$ including $n=4$ (section 4) | C3 |
| $T$ fixed while $\lambda$ ranges over $V$ | Implicit in A, C and the Lean | Frame-diagonal operators with arbitrary $\lambda\in V$ are not Weyl tensors in general (section 3.3) | C3, and it is what C6 would need to transfer |
| $N\ge4$ | A, C, Lean `hN` | $N\in\{1,3,6,10,\dots\}$, so $N\ge4\iff n\ge4$ | Not used: the proof needs three distinct indices, $N\ge3$ |
| $n\ge5$, $\mathcal W_n$ irreducible | C | Imported fact, no source filed in references/ | Not used by C3's proof. Used only as the label for "single condition" |
| $\mathcal W_4=\mathcal W^+\oplus\mathcal W^-$ | C, brief item 4 | Standard SO(4) splitting, no source filed. Taken as the brief's premise | C4b, C7 |
| L42 `distinctSum_eq_six`: $g$ symmetric in slots (1,2) and (2,3) | Lean `three_e3` | $g=\lambda_\alpha\lambda_\beta\lambda_\gamma$ satisfies both, discharged by `ring` | Yes |
| L42 `objective_eq_increasingSum` | Lean `three_e3` | No hypotheses | Yes |
| Non-realisation "on distinct triples", $n\ge4$ | Needed by C5 and C6, stated nowhere in A to C | Section 5 | C6 |

Used but unstated: the normalisation of $\#$ and of the inner product (C1), and the independence of $T$ from $\lambda$ (C3 to C6).

## 1. C1, the eigenframe display

**Verdict: HYPOTHESIS-DEBT.** No derivation is quoted in Passages A to C, and none of them states the inner product or the normalisation of $\#$ on which the coefficient depends.

Check of whether it holds. With Böhm and Wilking (4) polarised at $h=v_\gamma$ and $b=v$: $\langle W^\#v_\gamma,v_\gamma\rangle=\tfrac12\sum_{\alpha,\beta}\lambda_\alpha\lambda_\beta c_{\alpha\beta\gamma}^2$. Hence $\langle W,W^\#\rangle=\sum_\gamma\lambda_\gamma W^\#_{\gamma\gamma}=\tfrac12\sum_{\alpha,\beta,\gamma}c_{\alpha\beta\gamma}^2\lambda_\alpha\lambda_\beta\lambda_\gamma$. Total antisymmetry of $c$ removes every term with a repeated index, and the remaining ordered sum is six times the increasing one, so $\langle W,W^\#\rangle=3\sum_{\alpha<\beta<\gamma}T\lambda\lambda\lambda$. With $\langle W,W^2\rangle=p_3$ the display holds, coefficient 3, in the normalisation of section 0.

Dependence on normalisation, closed form. Rescale to $\langle\cdot,\cdot\rangle'=-\operatorname{tr}=2\langle\cdot,\cdot\rangle$ with the same operator $W^\#$. Then $v'=v/\sqrt2$, $c'=2\cdot2^{-3/2}c=c/\sqrt2$, $T'=T/2$, and the same identity reads $\theta=p_3+6\sum_{\alpha<\beta<\gamma}T'\lambda\lambda\lambda$. The coefficient 3 is therefore a statement about the pair ($-\tfrac12\operatorname{tr}$, the $\tfrac12$ in (4)), and the record would have to fix both where $\theta$, $\#$ and $T$ are defined. The collapse statement (C3) and constancy of $T$ (C5) are invariant under this rescaling, so the debt does not reach them.

## 2. C2, linearity and the subspace

**Verdict: CONFIRMED.** The collapse set is $\{T:\ C_T|_V\in\mathbb R\,p_3|_V\}$, the preimage of a line under the linear map $T\mapsto C_T|_V$, hence a subspace. The Lean proofs match: `collapse_add` with constant $c+d-1$ gives $p_3+(c-1)p_3+(d-1)p_3$, `collapse_smul` with $rc-r+1$ gives $p_3+r(c-1)p_3$, `zero_collapses` with $c=1$. Each step checked by hand.

## 3. C3, the dimension

**Verdict: CONFIRMED AS ALGEBRA.** For $T$ a function on index triples, collapse over $V$ holds iff $T$ is constant on increasing triples, at every $N\ge3$. The connection to a Weyl tensor, where $T$ and $\lambda$ come from the same $W$, is not part of the proof.

### 3.1 Forward direction (Lean `spike_*`)

For $i<j<k$, $\lambda=e_i+e_j-2e_k\in V$. $p_3=1+1-8=-6$. A product $\lambda_\alpha\lambda_\beta\lambda_\gamma$ with $\alpha<\beta<\gamma$ is nonzero only for $(\alpha,\beta,\gamma)=(i,j,k)$, value $-2$, so $C_T=-2T_{ijk}$ (`spike_triple`). Collapse gives $-6-6T_{ijk}=-6c$, so $T_{ijk}=c-1$. Needs exactly three distinct indices, so $N\ge3$. The `rcases` case split in `spike_triple` covers all $4^3$ assignments, and the tactic alternatives are consistent with the arithmetic of each case (I did not build the file).

### 3.2 Converse (Lean `three_e3`)

The indicator identity `hind`, $[\alpha,\beta,\gamma\text{ distinct}]=1-[\alpha=\beta]-[\alpha=\gamma]-[\beta=\gamma]+2[\alpha=\beta=\gamma]$, checks on the three coincidence patterns ($0=1-3+2$, $0=1-1$, $1=1$). On $p_1=0$ each of the three pair sums and the full sum vanish, leaving the distinct ordered sum $=2p_3$. With `distinctSum_eq_six`, $6e_3=2p_3$, so $3e_3=p_3$ (Newton's $p_3=e_1^3-3e_1e_2+3e_3$ at $e_1=0$ agrees). Then $T\equiv d$ gives $\theta=(1+d)p_3$.

### 3.3 Gap between what is proven and what is used

- **Dimension.** The theorem constrains $T$ only on increasing triples. As a subspace of $\mathbb R^{\binom N3}$ (coordinates on distinct triples) it is the line $\mathbb R\mathbf 1$. As a subspace of all $T:\mathrm{Fin}\,N^3\to\mathbb R$ it has dimension $1+N^3-\binom N3$. "One-dimensional" is true only in the first ambient space, which the record never names. The Lean says it constructs no `finrank`.
- **At $N=3$** the line is the whole space, so the collapse space is one-dimensional but not proper. The statement's $N\ge4$ excludes this, and the proof does not need the exclusion.
- **$T$ fixed while $\lambda$ ranges over $V$.** The spike spectra used in 3.1 are, in a frame that actually occurs, generally not the spectra of any Weyl tensor diagonal in that frame. Closed form: $n=5$, frame $\{E_{ij}\}$, $\lambda=e_{(12)}+e_{(13)}-2e_{(14)}$. The operator $E_{ij}\mapsto\lambda_{(ij)}E_{ij}$ satisfies first Bianchi, and its Ricci entry at $e_2$ is proportional to $\lambda_{(12)}=1\ne0$, so it is not in $\mathcal W_5$. The theorem is a statement about the polynomial $\lambda\mapsto\theta_T(\lambda)$ on $V$, which is what C3 says. It becomes a statement about $W$ only through an argument not on file (see C6).

### 3.4 Falsifier sought

A non-constant $T$ on distinct triples with $C_T|_V\in\mathbb R p_3|_V$. The spike argument excludes it at every $N\ge3$. None exists.

## 4. C4, the trace-condition count

### 4.1 C4a: count equals number of irreducible summands

**Verdict: HYPOTHESIS-DEBT.** No argument is quoted, and "governed by" is not made into a statement for more than one condition.

What would have to be proved is sensitive to how eigenvalues are labelled. Under the brief's definition ("linear conditions on the spectrum that every $W$ obeys", eigenframe labelling arbitrary) the count is 1 at every $n\ge4$. Closed form at $n=4$: $W$ with $W^+$ spectrum $(1,-1,0)$ on $\Lambda^+$ and $W^-=0$ lies in $\mathcal W_4$ (it is an element of $\mathcal W^+$). Its spectrum is $\{1,-1,0,0,0,0\}$, every coordinate ordering occurs for some labelling of an eigenframe, and the orderings of $(1,-1,0,0,0,0)$ span $V$. So any linear functional vanishing on all spectra in all labellings is a multiple of $p_1$. The count 2 at $n=4$ exists only for eigenframes adapted and labelled by $\Lambda^+\oplus\Lambda^-$ ($\lambda_1+\lambda_2+\lambda_3=0=\lambda_4+\lambda_5+\lambda_6$). The record would have to define "trace conditions" relative to such a labelling and prove the count against it.

### 4.2 C4b: "under $O(n)$" with $\mathcal W_4$ reducible

**Verdict: REFUTED AS STATED.**

1. Location: Passage C, results.md line 655: "the number of irreducible summands of $\mathcal W_n$ under $O(n)$ ... At $n=4$, where $\mathcal W_4$ is reducible, the cubic is spectral."
2. Failure, closed form: $\mathcal W_4$ is irreducible under $O(4)$. Under $SO(4)$ it is $\mathcal W^+\oplus\mathcal W^-$, the two summands non-isomorphic, since the right $SU(2)$ factor of $\mathrm{Spin}(4)$ acts trivially on $\mathcal W^+$ and nontrivially on $\mathcal W^-$. So the only $SO(4)$-invariant subspaces are $0,\mathcal W^+,\mathcal W^-,\mathcal W_4$. The reflection $r=\operatorname{diag}(-1,1,1,1)$ satisfies $r^*\star=-\star r^*$, so it maps $\Lambda^+$ to $\Lambda^-$ and $\mathcal W^+$ to $\mathcal W^-$. Neither summand is $O(4)$-invariant, so $\mathcal W_4$ has one $O(4)$ summand. Passage C's own rule then gives a single condition at $n=4$, its "under a single condition ... exactly one-dimensional" applies at $n=4$, and that contradicts its "$\mathcal W_4$ is reducible" and treats $n=4$ as the exception.
3. Charitable reading: "under $SO(n)$" was meant. That reading is consistent with Passage A (no group named) and with "$\mathcal W_4$ reducible", and it gives 2 at $n=4$ only with the labelled frame of 4.1. The text as written says $O(n)$, so the finding stands as stated, corrected by $SO(n)$ plus an adapted labelling.

## 5. C5, constant $T$ realised by no $\mathfrak{so}(n)$

**Verdict: HYPOTHESIS-DEBT.** No argument is quoted in Passages A to C. The Gate 2 text quoted in Passage D's docstring records it as unproved, closed by a parity argument at $n\equiv2,3\pmod4$ and open at $n=8,9,12$, with the middle elided ("[…]") in the brief.

- **Quantifier.** Over all index triples the claim is trivially true and useless: $T_{\alpha\alpha\beta}=0$, and $T\equiv0$ would make $\mathfrak{so}(n)$ abelian. The collapse space of C3 constrains only distinct triples, so the claim C6 needs is "no orthonormal basis of $\mathfrak{so}(n)$ has $T$ constant on distinct triples". None of A, B, C says "on distinct triples".
- **Scope in $n$.** The visible quotation lists $n=8,9,12$ as open and is silent on $n=4,5$ and on $n\equiv0,1\pmod4$ beyond 12. $n=5\equiv1\pmod 4$, so the $n\ge5$ corollary rests at its first case on a residue class the visible record does not close.
- **Hand-checkable cases.** Constancy on distinct triples is basis-quantified and scale-invariant. The residue classes $n\equiv2,3\pmod4$ ($N$ odd) admit a determinant-parity check, which is the route the record names. I did not settle $n=4$ or $n=5$ by hand.

### 5.1 Falsifier sought

An orthonormal basis of $\mathfrak{so}(n)$, $n\ge4$, with $c_{\alpha\beta\gamma}^2$ equal on all distinct triples. At $n=4$ ($\mathfrak{so}(3)\oplus\mathfrak{so}(3)$) every basis vector would need both components nonzero. I found no construction and no obstruction there, and did not hunt further (unbounded).

## 6. C6, "for $n\ge5$ the cubic is a function of the spectrum alone at no critical point"

**Verdict: GAP.**

1. Location: Passage C, results.md line 655: "So for $n\ge5$ the cubic is a function of the spectrum alone at no critical point, and any bound through the spectrum alone carries alignment slack."
2. Failure of the inference, closed form. The collapse condition quantifies over all $\lambda\in V$ with the frame's $T$ frozen. A critical point fixes one $W$, hence one $\lambda$ and a frame. The step from "the frame's $T$ is not in the single-condition collapse space" to "$\theta$ is not spectral" is invalid in general, and $n=4$ exhibits it. In a frame adapted to $\Lambda^+\oplus\Lambda^-$, $[\Lambda^+,\Lambda^-]=0$ gives $T=0$ on every mixed distinct triple, and $T=\kappa^2\neq0$ on the two pure triples ($\Lambda^\pm\cong\mathfrak{so}(3)$ nonabelian). This $T$ is non-constant on distinct triples, so by C3 at $N=6$ it does not collapse over $V$ with one condition. Yet $\theta_T(\lambda)=p_3+3\kappa^2(\lambda_1\lambda_2\lambda_3+\lambda_4\lambda_5\lambda_6)$, and on every actual spectrum ($\lambda_1+\lambda_2+\lambda_3=0=\lambda_4+\lambda_5+\lambda_6$) this is $(1+\kappa^2)p_3$. The escape at $n=4$ is that realised spectra in the adapted frame obey more linear conditions than $p_1=0$. At $n\ge5$ the passages give no argument excluding frame-dependent conditions of the same kind, and section 3.3 shows they occur: Weyl tensors diagonal in $\{E_{ij}\}$ obey the $n$ row-sum conditions $\sum_j\lambda_{(ij)}=0$, cutting a subspace of dimension $N-n$.
3. Charitable reading: "a function of the spectrum alone" means "$\lambda\mapsto\theta_T(\lambda)$ is a multiple of $p_3$ on all of $V$ for the frame's $T$". Under that reading C6 follows from C3 and C5 (on distinct triples, at every $n\ge5$), and "critical point" does no work since it then holds at every $W$. It inherits C5's debt, including at $n=5$. Under the natural reading (θ determined by the spectrum on a neighbourhood or on the isospectral set) no argument is on file. The finding stands as a GAP. "Alignment slack" is not defined in the passages and has no argument.

Quantifier tracked (brief item 2). Collapse at one fixed $\lambda$ with $\exists c$: if $p_3(\lambda)\ne0$ every $T$ qualifies (codimension 0). If $p_3(\lambda)=0$ and some distinct-triple product is nonzero, the set is the hyperplane $C_T(\lambda)=0$ (codimension 1). If $\lambda=s(e_i-e_j)$ every $T$ qualifies. Over all $\lambda\in V$ it is the line of C3.

$\ker W\ne0$: repeated eigenvalues, including a kernel of dimension $\ge2$, make the eigenframe and hence $T$ non-unique, and triples through kernel indices are invisible to $\theta$. C5 quantifies over all orthonormal bases, so under the charitable reading the choice of frame does not matter. Under the natural reading it adds to the gap, since the frame is not a function of $W$.

## 7. C7, "at $n=4$ the cubic is spectral"

**Verdict: HYPOTHESIS-DEBT.** Passage C asserts it with only "where $\mathcal W_4$ is reducible" as a reason, and it does not follow from the collapse-space statement, which is stated for a single condition. The record would have to supply: an adapted eigenframe exists for every $W\in\mathcal W_4$, $T$ in it vanishes on mixed triples and is one constant on pure triples, and $3\lambda_1\lambda_2\lambda_3=\sum_{\Lambda^+}\lambda^3$ on each trace-free block. Falsifier sought: a $W\in\mathcal W_4$ with $\theta(W)\neq(1+\kappa^2)p_3$. The adapted-frame computation of section 6 excludes one, and $\theta$ is frame-independent, so degenerate spectra add nothing.

## 8. C8, the Lean statement

### 8.1 C8a, the theorem

**Verdict: CONFIRMED.**

- Binders: `T : Fin N → Fin N → Fin N → ℝ` is an arbitrary real array (no symmetry, no sign, no $T=c^2$). This is more general than the record's $T$, and so harmless for an iff about the collapse set.
- `Collapses T := ∃ c, ∀ lam, ∑ lam = 0 → thetaOf T lam = c * ∑ lam³`: $c$ outside, $\lambda$ inside, which is Passage C's quantifier and the one C3 needs.
- The trace condition encoded is the single condition $p_1=0$. This matches "under a single condition" and does not encode $n=4$'s labelled pair (not claimed).
- `hN : 4 ≤ N` excludes $N\le3$ and is unused. It excludes nothing the record needs.
- Conclusion `∃ d, ∀ α < β < γ, T α β γ = d`: "exactly the constants on increasing triples". The one-dimensionality is not typed as a `finrank`, as the docstring states.
- Absent, and declared absent: C1 (`thetaOf` is a definition, so the display is assumed, not proved), C4, C5, C6, C7.

### 8.2 C8b, docstring remark on the fixed-$\lambda$ reading

**Verdict: REFUTED AS STATED** (commentary only, no effect on the theorem).

1. Location: Passage D, docstring: "the same condition at one fixed `λ` is codimension `1` in `T`, and would give a different and false statement."
2. Failure: $N=4$, $\lambda=(3,-1,-1,-1)\in V$, $p_3(\lambda)=27-3=24\neq0$. For every $T$, $c=\theta_T(\lambda)/24$ satisfies the condition, so the set is all of $T$-space, codimension 0.
3. Charitable reading: $c$ fixed in advance, or $\lambda$ on $\{p_3=0\}$. Then the codimension is 1 (for $\lambda$ with a nonzero distinct-triple product). "The same condition" carries $\exists c$, so the remark is right only on the locus $p_3(\lambda)=0$. Its conclusion that the fixed-$\lambda$ reading gives a false count survives.

## 9. Brief items, numbered as there

1. Display: section 1, HYPOTHESIS-DEBT. A derivation is needed, with $\#$ and the inner product fixed, where $\theta$ and $T$ are defined.
2. Quantifier: section 6 and 8.2. Over all of $V$ the space is a line (dimension 1 on distinct triples). At one $\lambda$ it has codimension 0 or 1 by the sign of $p_3(\lambda)$.
3. Dimension: section 3. The Lean statement is that claim in characterisation form, and its proof establishes it at $N\ge3$. The threshold $N\ge4$ is stronger than needed.
4. Count and group: section 4. It is unargued. Under $O(4)$ it is 1, contradicting "reducible". Under $SO(4)$ it is 2 only with a labelled adapted frame. Under the brief's definition it is 1.
5. Non-realisation: section 5. It needs "on distinct triples" and $n\ge4$, no argument is quoted, and the visible record closes only $n\equiv2,3\pmod4$.
6. $n\ge5$ corollary: section 6, GAP. At $n=5$ it rests on C5 in an unclosed residue class.
7. $n=4$ spectral: section 7, true in the adapted frame, no argument on file.
8. Clause differences:

| Clause | A (target 775) | B (results 188) | C (results 655) | D (Lean) |
|---|---|---|---|---|
| $T=\langle[v_\alpha,v_\beta],v_\gamma\rangle^2$ | yes | no | yes | no (arbitrary array) |
| Index range $\alpha<\beta<\gamma$ in display | yes | no | yes | yes |
| "for every spectrum obeying the trace conditions" | no | no | yes | yes |
| Count = irreducible summands | yes, no group | no | yes, "under $O(n)$" | no |
| "$n\ge5$, $\mathcal W_n$ irreducible" | no | no | yes | no |
| $N\ge4$ | yes | no | yes | yes (unused) |
| Constant $T$ realised by no $\mathfrak{so}(n)$ | yes | yes | yes | no, declared absent |
| "on distinct triples" | no | no | no | increasing triples in conclusion |
| $n\ge5$ corollary, alignment slack | no | no | yes | no |
| $n=4$ spectral | no | no | yes | no |
| Linearity proved | asserted | asserted | asserted | proved |

9. Boundary: $n=4$ in sections 4, 6, 7. $n=5$ in sections 5, 6. $N=3$ in section 3.3 (collapse space is the whole line, the proof works, the statement excludes it). $\ker W\ne0$ in section 6.

## 10. Falsifying objects, per claim

| Claim | Object that would falsify it | What I did |
|---|---|---|
| C1 | A normalisation in force under which the coefficient differs | Read (4) at source. Coefficient is 6 under $-\operatorname{tr}$ with $T'$ |
| C2 | $T,S$ collapsing with $T+S$ not collapsing | Checked the constants $c+d-1$, $rc-r+1$ |
| C3 | Non-constant $T$ on distinct triples collapsing over $V$ | Spike argument excludes it at $N\ge3$ |
| C4a | A labelling convention under which the count is not the summand count | $n=4$ with arbitrary labelling gives 1 against 2 |
| C4b | $\mathcal W_4$ irreducible under $O(4)$ | Exhibited via $r=\operatorname{diag}(-1,1,1,1)$ |
| C5 | Orthonormal basis of $\mathfrak{so}(n)$, $n\ge4$, with $c^2$ constant on distinct triples | Screened $n=4$ structure by hand, not settled. $n=3$ is realised but out of scope (withdrawn, 11.2) |
| C6 | Critical $W$, $n\ge5$, with $\theta$ determined by the spectrum near $W$ | Showed the inference pattern fails at $n=4$. Did not search for critical points (unbounded) |
| C7 | $W\in\mathcal W_4$ with $\theta\ne(1+\kappa^2)p_3$ | Adapted-frame computation excludes it |
| C8a | A binder or hypothesis changing the content | Read every binder |
| C8b | Fixed $\lambda$ with $p_3\ne0$ | $\lambda=(3,-1,-1,-1)$ |

## 11. Withdrawn candidates

### 11.1 Passage B's display lacks the index range

1. Location: results.md line 188, "$\theta=\sum\lambda_\alpha^3+3\sum T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$".
2. Failure: read as a sum over all ordered triples the coefficient is off by 6. At $n=4$ with $W^+$ spectrum $(1,1,-2)$ and $W^-=0$ in an adapted frame, the true value is $-6-6\kappa^2$ and the all-ordered reading gives $-6-36\kappa^2$.
3. Charitable reading: B is the landscape summary of C, which carries $\alpha<\beta<\gamma$. Withdrawn for that reason. B should carry the range.

### 11.2 Constant $T$ at $n=3$

1. Location: Passage A, "constant $T$ is not realised by any $\mathfrak{so}(n)$".
2. Failure: $\mathfrak{so}(3)$ has $N=3$ and one distinct triple, so $T$ is constant on distinct triples for every orthonormal basis.
3. Charitable reading: the clause follows "at every $N\ge4$", and $\mathcal W_3=0$. Withdrawn. The statement should carry $n\ge4$.

### 11.3 File length

The brief says 344 lines. `wc -l` gives 343 and the diff is empty, so the difference is a trailing-newline count. Withdrawn, no content.

## Overall verdict

**GAP.** The algebraic core (C2, C3) is proven and matches its Lean statement. The statement carries hypothesis debt on the display's normalisation (C1), the trace-condition count (C4a) and non-realisation (C5), and states the group wrongly at $n=4$ (C4b). Passage C's $n\ge5$ corollary (C6) does not follow from the collapse space as written.
