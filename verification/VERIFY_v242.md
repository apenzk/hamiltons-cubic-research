# Verifier v242, L49: the eigenframe display, linearity of the collapse condition, the one-dimensional collapse space, the trace-condition count, non-realisation of constant T, the n >= 5 and n = 4 corollaries, and the Lean statement

The brief was cold: I worked from verification/BRIEF_L49.md, the definitions, the Lean files it names and the Böhm–Wilking source under references/. No numerical work was done, every value below is exact, and no scripts were written. The Lean file was read, not compiled. Log: agent_logs/verify-L49-v242.log.

| # | Claim | Verdict |
|---|---|---|
| 1 | Eigenframe display $\theta=\sum\lambda_\alpha^3+3\sum_{\alpha<\beta<\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$ | CONFIRMED AS ALGEBRA (at the scalar product $-\tfrac12\mathop{\mathrm{tr}}(AB)$ and Böhm–Wilking's $\#$, neither stated in the passages) |
| 2 | The collapse condition is linear in $T$, the collapsing configurations form a subspace | CONFIRMED |
| 3 | Under the single condition $\sum\lambda=0$ the collapse space is exactly the constants, one-dimensional, at every $N\ge4$ | CONFIRMED (proof reaches every $N\ge3$) |
| 3a | Lean docstring and quoted Gate 2 text: at one fixed $\lambda$ the condition is "codimension 1 in $T$" | REFUTED AS STATED (commentary only, the theorem is unaffected) |
| 4 | The number of independent trace conditions equals the number of irreducible summands of $\mathcal W_n$ "under $O(n)$" | REFUTED AS STATED (under $O(4)$, $\mathcal W_4$ is irreducible), and HYPOTHESIS-DEBT for the count under $SO(n)$ |
| 5 | Constant $T$ is realised by no $\mathfrak{so}(n)$ | HYPOTHESIS-DEBT |
| 6 | For $n\ge5$ the cubic is a function of the spectrum alone at no critical point, spectral bounds carry alignment slack | GAP |
| 7 | At $n=4$ the cubic is spectral | HYPOTHESIS-DEBT |
| 8 | Passage D types claims 2 and 3 faithfully | CONFIRMED (with a wording note on "one-dimensional") |

**Round action:** keep claims 2 and 3 as proven, replace "under $O(n)$" by "under $SO(n)$", fix the "codimension 1" commentary, and mark claims 4 (count), 5, 6 and 7 as unproved in the canonical forms.

## 0. Conventions, fixed once

- $n\ge2$, $N=\binom n2$, $\{v_\alpha\}$ an orthonormal basis of $\mathfrak{so}(n)$ for a fixed ad-invariant scalar product, $c_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle$, $T_{\alpha\beta\gamma}=c_{\alpha\beta\gamma}^2$.
- $p_k=\sum_\alpha\lambda_\alpha^k$, $e_3=\sum_{\alpha<\beta<\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$, $C_T(\lambda)=\sum_{\alpha<\beta<\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$, so the display reads $\theta_T=p_3+3C_T$.
- $V=\{\lambda\in\mathbb R^N:\ p_1(\lambda)=0\}$, the single trace condition of the brief's definitions.
- "Collapse, $\forall$ reading": $\exists c\ \forall\lambda\in V:\ \theta_T(\lambda)=c\,p_3(\lambda)$. "Collapse, fixed-$\lambda$ reading": $\exists c:\ \theta_T(\lambda_0)=c\,p_3(\lambda_0)$ at one $\lambda_0$.
- The configuration space of the record is $\mathbb R^{\binom N3}$, one real number per unordered distinct triple.
- Quotations were checked against source: Passage A equals findings/target.md line 775 verbatim, Passage B equals results.md line 188, Passage C equals results.md line 655, Passage D is identical to lean/HamiltonsCubic/Results/L49Statement.lean (whole-file diff empty, the file has 343 lines where the brief says 344).

## 1. Hypothesis inventory

| Hypothesis | Where stated | Checked against the object | Used by |
|---|---|---|---|
| H1. $W\in\mathcal W_n$ symmetric on $\mathfrak{so}(n)$, orthonormal eigenframe | Definitions | Holds, every symmetric operator has one | Claim 1 |
| H2. The scalar product on $\mathfrak{so}(n)$ is $-\tfrac12\mathop{\mathrm{tr}}(AB)$ and $\#$ is Böhm–Wilking's (4) | **Unstated** in A to D | Read at source, see section 2 | Claim 1 (the coefficient 3) |
| H3. $T$ totally symmetric and zero on repeated indices | Implicit in the display summing only $\alpha<\beta<\gamma$ | Holds by ad-invariance: $c$ is totally antisymmetric | Claim 1 |
| H4. A single trace condition, namely $p_1=0$ | Definitions, Passages A, C | The Lean `Collapses` encodes exactly $p_1=0$ | Claims 3, 8 |
| H5. $N\ge4$ | Passages A, C, Lean `hN` | Unused by the proof, which needs $N\ge3$ for content and is vacuous-true below | Nothing |
| H6. $n\ge5$ as the "single condition" range | Passage C | Rests on claim 4 | Claim 6 |
| H7. A labelling convention for the spectrum under which "trace conditions" are counted | **Unstated** | Needed for claim 4 to have content, see section 5 | Claim 4 |
| H8. What "at a critical point the cubic is a function of the spectrum" means, and over which spectra | **Unstated** | See section 7 | Claim 6 |
| I1. L42 `distinctSum_eq_six`, hypotheses `s12`, `s23` | L42Statement.lean line 150 | Supplied as `hsym12`, `hsym23` for $g=\lambda_\alpha\lambda_\beta\lambda_\gamma$, both hold by `ring` | Lean `three_e3` |
| I2. L42 `objective_eq_increasingSum`, no hypotheses | L42Statement.lean line 135 | Unfolds `Ioi` sums to guarded full sums, same as `ioi_sum_eq` | Lean `three_e3` |
| I3. $\mathcal W_n$ irreducible for $n\ge5$, $\mathcal W_4=\mathcal W^+\oplus\mathcal W^-$ under $SO(4)$ | Passage C, no source cited | Not read at source (no filed source named). Used below only through Passage C's own assertion | Claims 4, 6, 7 |

Used but unstated: H2, H7, H8.

## 2. Claim 1, the eigenframe display

**Derivation.** Böhm–Wilking, references/boehm-wilking-2008-space-forms/, eq. (4), read at source: $\langle(R\#S)(h),h\rangle=\tfrac12\sum_{\alpha,\beta}\langle[R b_\alpha,S b_\beta],h\rangle\langle[b_\alpha,b_\beta],h\rangle$ for an orthonormal basis, "using the scalar product $-1/2\mathop{\mathrm{tr}}(AB)$ instead of $-\mathop{\mathrm{tr}}(AB)$ as in [H2]", with $R^\#=R\#R$.

- In the eigenframe, $\langle W^\#v_\gamma,v_\gamma\rangle=\tfrac12\sum_{\alpha,\beta}\lambda_\alpha\lambda_\beta T_{\alpha\beta\gamma}$.
- $\langle W,W^\#\rangle=\sum_\gamma\lambda_\gamma\langle W^\#v_\gamma,v_\gamma\rangle=\tfrac12\sum_{\alpha,\beta,\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$.
- $T$ vanishes unless the indices are distinct and is symmetric, so the ordered sum is $6\sum_{\alpha<\beta<\gamma}$, giving $3\sum_{\alpha<\beta<\gamma}T\lambda\lambda\lambda$.
- $\langle W,W^2\rangle=p_3$. With the brief's $P(W)=\langle W,W^2+W^\#\rangle$ (no factor $\tfrac13$, unlike Böhm–Wilking's $P$), $\theta=p_3+3C_T$. The coefficient 3 is confirmed.

**Normalisation.** Böhm–Wilking state that $\#$ is the same operator in both scalar products. Under $-\mathop{\mathrm{tr}}(AB)$ the orthonormal basis is $b/\sqrt2$, so $c'=c/\sqrt2$ and $T'=T/2$, and the same $\langle W,W^\#\rangle$ reads $6\sum T'\lambda\lambda\lambda$. So the coefficient 3 holds exactly when $T$ is computed at $-\tfrac12\mathop{\mathrm{tr}}$.

**Is a derivation needed.** Passages A to C give none, and the brief's definitions do not define $\#$ or the scalar product. The record should state H2 where $\theta$ and $T$ are defined. The collapse space (claims 2, 3) and constancy of $T$ (claim 5) are invariant under $T\mapsto T/2$, so no downstream claim changes.

Verdict: CONFIRMED AS ALGEBRA at H2.

## 3. Claim 2, linearity

**Derivation checked.** Under the $\forall$ reading, $\theta_T=c\,p_3$ on $V$ iff $3C_T|_V=(c-1)p_3|_V$, i.e. $C_T|_V\in\mathbb R\,p_3|_V$. $T\mapsto C_T|_V$ is linear, so the collapse set is the preimage of a line under a linear map, a subspace. The Lean proofs `collapse_add` (constant $c+d-1$) and `collapse_smul` (constant $rc-r+1$) were checked line by line: $p_3+3(C_T+C_S)=(c+d-1)p_3$ and $p_3+3rC_T=(rc-r+1)p_3$, and the `linear_combination r * h3` residual is $r(3C_T-(c-1)p_3)$, which vanishes.

- Under the fixed-$\lambda$ reading the set is also a subspace (all of $\mathbb R^{\binom N3}$ or the kernel of one functional), so linearity holds under both readings.
- Literally, "$\theta=c\,p_3$" is affine in $(T,c)$. Substituting $c'=c-1$ makes it linear, so the statement is correct.

No finding: the subspace claim holds under every reading.

## 4. Claim 3, the dimension, and 3a

**Derivation checked (forward).** For $i<j<k$ take the spike $s=e_i+e_j-2e_k\in V$ (exists iff $N\ge3$).
- $p_3(s)=1+1-8=-6$.
- In $C_T(s)$ only increasing triples inside $\{i,j,k\}$ survive, and there is exactly one, giving $T_{ijk}\cdot1\cdot1\cdot(-2)=-2T_{ijk}$.
- Collapse gives $-6-6T_{ijk}=-6c$, so $T_{ijk}=c-1$ for every increasing triple.

**Converse.** On $V$, Newton's identity $p_3=e_1^3-3e_1e_2+3e_3$ gives $p_3=3e_3$. With $T\equiv d$, $\theta=p_3+3d\,e_3=(1+d)p_3$.

**Lean.** `spike_sum`, `spike_cube`, `spike_triple` and `three_e3` match the above. In `three_e3` the inclusion–exclusion `hind` is $[\text{distinct}]=1-[\alpha{=}\beta]-[\alpha{=}\gamma]-[\beta{=}\gamma]+2[\alpha{=}\beta{=}\gamma]$, checked on all three coincidence patterns (all distinct gives 1, exactly one pair equal gives $1-1=0$, all equal gives $1-3+2=0$). The four sums `S_all`, `S_ab`, `S_ag`, `S_bg` are each a multiple of $p_1=0$, and `S_eq` is $p_3$. So `distinctSum` $=2p_3=6e_3$ and $3e_3=p_3$.

**Edges.**
- $N=3$: one triple, every $T$ is constant and every $T$ collapses, dimension 1. Consistent.
- $N\le2$: no triples, the space is $\{0\}$, $\theta=p_3$ collapses with $c=1$, the right side of the Lean iff is vacuously true. Dimension 0, so "exactly one-dimensional" needs $N\ge3$, which $N\ge4$ secures.
- $n=4$ ($N=6$) and $n=5$ ($N=10$): covered.
- $\ker W\ne0$: the lemma quantifies over all of $V$, zeros included. No effect.
- The threshold $N\ge4$ is stronger than the $N\ge3$ the proof needs. Nothing is lost.

Verdict on 3: CONFIRMED.

**Fixed-$\lambda$ reading, item 2 of the brief.** Under it, the collapse set at $\lambda_0\in V$ is all of $\mathbb R^{\binom N3}$ when $p_3(\lambda_0)\ne0$ (take $c=\theta_T(\lambda_0)/p_3(\lambda_0)$). It is the hyperplane $\{C_T(\lambda_0)=0\}$ when $p_3(\lambda_0)=0$ and some distinct-index monomial of $\lambda_0$ is nonzero, and all of it otherwise. The $\forall$ reading gives dimension 1.

**Candidate 3a, three-step record.**
1. Located: Passage D, Lean lines 62–63, "the same condition at one fixed `λ` is codimension `1` in `T`", and the quoted Gate 2 text (Lean line 50), "at one fixed $\lambda$ it gives codimension $1$".
2. Exhibited: $N=4$, $\lambda_0=e_1+e_2-2e_3$, $p_3(\lambda_0)=-6\ne0$. For every $T\in\mathbb R^4$, $\theta_T(\lambda_0)=-6-6T_{123}=(1+T_{123})\,p_3(\lambda_0)$. So every $T$ collapses at $\lambda_0$ and the set has codimension 0.
3. Charitable reading: "codimension 1" is right for the set of pairs $(T,c)$, a graph over $T$ of codimension 1 in $\mathbb R^{\binom N3+1}$, or for $\lambda_0$ with $p_3(\lambda_0)=0$. The docstring says "in `T`" and "the same condition", which carries $\exists c$, so the charitable reading does not match the words.

Verdict on 3a: REFUTED AS STATED, commentary only. Replacement wording: "at one fixed $\lambda$ with $p_3(\lambda)\ne0$ every $T$ collapses".

## 5. Claim 4, the trace-condition count

**Is it argued.** No argument is quoted in A to C for "the number of independent trace conditions is the number of irreducible summands", nor for how the collapse dimension is "governed" by that number. No formula for the dimension under two conditions is stated, so there is nothing to check at $n=4$ against a stated dimension.

**Candidate 4a, the group, three-step record.**
1. Located: Passage C, "which is the number of irreducible summands of $\mathcal W_n$ under $O(n)$", and "At $n=4$, where $\mathcal W_4$ is reducible".
2. Exhibited: take $r=\mathop{\mathrm{diag}}(-1,1,1,1)\in O(4)\setminus SO(4)$ acting on $\Lambda^2\mathbb R^4$. Then $r(e_1\wedge e_2+e_3\wedge e_4)=-(e_1\wedge e_2-e_3\wedge e_4)$, which maps $\Lambda^+$ to $\Lambda^-$, and conjugation by $r$ maps $\mathcal W^+$ to $\mathcal W^-$. Take Passage C's own $SO(4)$ splitting $\mathcal W_4=\mathcal W^+\oplus\mathcal W^-$. The two summands are non-isomorphic irreducibles, since $SO(3)\times SO(3)$ acts on them through different factors. So the only $SO(4)$-invariant subspaces are $0$, $\mathcal W^\pm$ and $\mathcal W_4$. Every $O(4)$-invariant subspace is among these, and $r$ moves $\mathcal W^\pm$, so $\mathcal W_4$ is $O(4)$-irreducible. Under $O(n)$ the count is therefore 1 at $n=4$. Passage C's own chain would then put $n=4$ in the single-condition case, contradicting its "At $n=4$ ... the cubic is spectral".
3. Charitable reading: "under $O(n)$" means "under $SO(n)$". That makes the $n=4$ clause consistent (two summands, matching $\sum_{\alpha\le3}\lambda_\alpha=0=\sum_{\alpha\ge4}\lambda_\alpha$ in a frame adapted to $\Lambda^+\oplus\Lambda^-$). But the text names $O(n)$ explicitly, so the words are refuted.

Verdict on 4a: REFUTED AS STATED. Correction: $SO(n)$.

**Candidate 4b, what "trace condition" counts (H7).** The brief defines trace conditions as linear conditions on $(\lambda_\alpha)$ that every $W$ obeys. At $n=4$, $W^+=\mathop{\mathrm{diag}}(2,-1,-1)$ and $W^-=\mathop{\mathrm{diag}}(1,1,-2)$ in adapted frames give $\lambda=(2,-1,-1,1,1,-2)$. Relabelling $v_1\leftrightarrow v_4$ gives $\lambda=(1,-1,-1,2,1,-2)$, where $\lambda_1+\lambda_2+\lambda_3=-1\ne0$. So the second condition holds only under an adapted labelling. Charitable reading: the record means adapted labellings. This is plausible, but the convention is stated nowhere. Recorded as part of the debt, not as a separate refutation.

**Debt named.** The record would have to prove: (i) for a stated labelling convention, the linear conditions obeyed by all spectra of $\mathcal W_n$ number exactly the $SO(n)$-summands, in particular only $p_1=0$ at $n\ge5$; (ii) a statement of how the collapse dimension depends on that number.

Verdict on 4: REFUTED AS STATED (group), HYPOTHESIS-DEBT (count).

## 6. Claim 5, constant $T$ realised by no $\mathfrak{so}(n)$

- **Quantifier.** Over all index triples the claim is trivially true for $n\ge3$: $T_{\alpha\alpha\beta}=0$ forces the constant to be 0, hence $[v_\alpha,v_\beta]=0$ for all pairs, which is false in the nonabelian $\mathfrak{so}(n)$. The substantive reading is "on distinct triples", which Passages A to C do not say.
- **Argument quoted.** None in A to C. The Lean docstring (lines 86–91) records it as unproved, with a parity argument for $n\equiv2,3\pmod4$ mentioned and not quoted. I cannot check an argument that is not quoted.
- **Hand checks.** At $n=2$ ($N=1$) and $n=3$ ($N=3$) constant $T$ on distinct triples is realised: at $n=3$ there is one triple and $T_{123}=\langle[v_1,v_2],v_3\rangle^2>0$ is constant.
  - Candidate 5a, three-step record. (1) Located: Passage C, "constant $T$ is realised by no $\mathfrak{so}(n)$". (2) Exhibited: $\mathfrak{so}(3)$ with any orthonormal basis. (3) Charitable reading: the lemma concerns $\mathcal W_n$, which is zero for $n\le3$, and the sentence carries $N\ge4$. **Withdrawn**: the charitable reading restricts to $n\ge4$. The clause should carry $n\ge4$ explicitly.
- At $n=4$ a falsifier would be an orthonormal basis of $\mathfrak{so}(3)\oplus\mathfrak{so}(3)$ with all 20 distinct-triple values of $T$ equal. A necessary consequence is $|[v_\alpha,v_\beta]|^2=(N-2)t$ for every pair, so no two basis vectors commute. The adapted basis fails ($T_{124}=0\ne T_{123}$). I did not search further, since that would be a hunt with no bound.

Debt named: for every $n\ge4$, no orthonormal basis of $\mathfrak{so}(n)$ has $T$ constant on distinct triples. For claim 6 only the weaker statement for eigenframes of $W\in\mathcal W_n$ is needed.

Verdict: HYPOTHESIS-DEBT.

## 7. Claim 6, "for $n\ge5$ the cubic is a function of the spectrum alone at no critical point"

**Quantifier tracked.** Claims 3 and 5 give: for any frame $F$, $\theta_{T_F}$ is not a multiple of $p_3$ on all of $V$. The conclusion concerns a critical point $W_0$, which is one spectrum $\lambda_0$ and one (possibly non-unique) frame.

- Under the fixed-$\lambda$ reading, every $T$ collapses at $\lambda_0$ when $p_3(\lambda_0)\ne0$ (section 4). The lemma then says nothing about $T$ at $W_0$, so this reading cannot carry the inference.
- Under the $\forall$ reading, the relevant domain for frame $F$ is the set $L_F\subseteq V$ of spectra of Weyl tensors diagonal in $F$, not all of $V$. $L_F$ can be a proper subspace. Exhibit, $n=5$, $F=\{e_i\wedge e_j\}$: a curvature operator diagonal in this frame satisfies Bianchi automatically (the Bianchi map lands in $\Lambda^4$, which needs four distinct indices), and it is Weyl iff $\mathop{\mathrm{Ric}}=0$, i.e. $\sum_j\lambda_{ij}=0$ for each $i$. These are 5 independent conditions ($K_5$ is not bipartite), so $\dim L_F=5<9=\dim V$. Non-collapse on $V$ does not decide collapse on $L_F$.
- "Critical point" and "alignment slack" are not defined in the passages, and no argument links them to the collapse space.
- $\ker W\ne0$ or any repeated eigenvalue: the frame at $W_0$ is not unique, so "the $T$ of the critical point" is not defined. The conclusion would need "for no frame", which claim 5 over all bases would supply if proved.

At $n=5$: $\mathcal W_5$ is irreducible under $O(5)$ and $SO(5)$ (per Passage C, not read at source), so claim 4's defect does not reach $n=5$, but the GAP above does.

Named: the inference needs collapse on $L_F$ (or a defined notion of "spectral at a point"), which the lemma does not supply. Verdict: GAP.

## 8. Claim 7, "At $n=4$ the cubic is spectral"

It asserts that $\theta(W)$ is a function of the spectrum of $W$ for every $W\in\mathcal W_4$ (charitably, $\theta=\kappa\,p_3$ for a constant $\kappa$). No argument is quoted. It does not follow from the collapse lemma, which concerns a single condition. "Where $\mathcal W_4$ is reducible" gives no mechanism, and under the stated $O(4)$ it is false (section 5).

Debt named: in a frame adapted to $\Lambda^+\oplus\Lambda^-$, $T$ is supported on $\{1,2,3\}$ and $\{4,5,6\}$ with equal values, the spectrum obeys both block trace conditions, and blockwise $3e_3=p_3$ then gives proportionality. Non-adapted frames (repeated eigenvalues across blocks) must be covered by frame-independence of $\theta$. I screened for a falsifier (a $W\in\mathcal W_4$ with $\theta$ not proportional to $p_3$) only against this outline and found none. That is a screen, not evidence.

Verdict: HYPOTHESIS-DEBT.

## 9. Claim 8, the Lean statement (Passage D)

- **Binders.** `T : Fin N → Fin N → Fin N → ℝ` is an arbitrary function. `thetaOf` reads only increasing triples, matching the display under H3. `lam` ranges over all of `Fin N → ℝ` with `∑ lam = 0`, which is $V$. `hN : 4 ≤ N` is unused and excludes nothing needed ($N\ge3$ is where content starts).
- **Quantifier.** `Collapses` is $\exists c\,\forall\lambda$, the $\forall$ reading of Passage C, correct.
- **Trace condition.** Exactly the one condition $p_1=0$, the "single condition" case. The Lean does not connect `thetaOf` to $P(W)$ or $\mathcal W_n$, and does not type claims 1, 4, 5, 6 or 7. The docstring says so for claim 5 and describes `thetaOf` as a definition. Honest.
- **Proof.** Read link by link in sections 3 and 4, correct. Not compiled by me.
- **Candidate 8a, three-step record.** (1) Located: Lean line 335, "The collapse space is exactly the constants, hence one-dimensional." (2) Exhibited: at $N=4$, the indicator of the non-increasing triple $(0,0,0)$, the zero function and the all-ones function all collapse. The first and third are linearly independent, so the collapse set in the Lean type has dimension $64-4+1=61$. (3) Charitable reading: the record's configuration space is $\mathbb R^{\binom N3}$. The iff characterises the restriction to increasing triples, where the collapse set is the line of constants, and lines 93–95 say `finrank` is not constructed. **Withdrawn** as a defect. Suggested wording: "one-dimensional on increasing triples".

Verdict: CONFIRMED.

## 10. Items of the brief, answered in order

1. Display: holds with coefficient 3 at $-\tfrac12\mathop{\mathrm{tr}}$ and Böhm–Wilking (4). The record must state H2 where $\theta$ is introduced (section 2).
2. Quantifier: $\forall$ reading gives dimension 1. Fixed-$\lambda$ reading gives full dimension $\binom N3$ when $p_3(\lambda)\ne0$ and codimension $\le1$ otherwise. Passage A's "reduce to a multiple of $\sum\lambda^3$" reads charitably as an identity of cubic forms on $V$. That candidate is withdrawn, but Passage A should carry the quantifier (sections 4, 3a).
3. Lean is that claim on increasing triples, the proof establishes it, and $N\ge4$ is unused (sections 4, 9).
4. Unargued. Wrong under $O(n)$ at $n=4$, consistent under $SO(n)$ in adapted labellings (section 5).
5. Distinct triples is the substantive reading, no argument is quoted, and the hand checks at $n=2,3$ realise constant $T$ (withdrawn by scope) (section 6).
6. Does not follow, quantifier domain $V$ versus $L_F$ (section 7).
7. Unargued, does not follow from the lemma (section 8).
8. Clauses carried by one form and not another:
   - A has, and C lacks: no mathematical clause. A's wording "the independent trace conditions the spectrum obeys" is C's count without the group.
   - C has, and A lacks: "in an eigenframe of $W$"; "for every spectrum obeying the trace conditions"; "under $O(n)$"; "($n\ge5$, where $\mathcal W_n$ is irreducible)"; "spanned by constant $T$"; the $n\ge5$ corollary on critical points and alignment slack; the $n=4$ spectral clause.
   - B lacks: the definition of $T$, the restriction $\alpha<\beta<\gamma$ on the sum, the quantifier, the link between the dimension and the number of conditions, the irreducible-summand count, $N\ge4$, and both corollaries.
   - D lacks: claims 1, 4, 5, 6, 7 and any link to $\mathcal W_n$. D adds `collapse_add`, `collapse_smul`, `zero_collapses`.
9. Boundary: $n=4$ (sections 5, 8), $n=5$ (section 7), $N=3$ and $N\le2$ (section 4), $\ker W\ne0$ (sections 4, 7).

## 11. Falsifiers named, and what I did

| Claim | Falsifying object | Search |
|---|---|---|
| 1 | A convention for $\#$ and scalar product under which the coefficient is not 3 | Found: $-\mathop{\mathrm{tr}}$ gives 6. Resolved by stating H2 |
| 2 | Two collapsing $T$ whose sum does not collapse | None possible, the proof is a linear preimage |
| 3 | A nonconstant $T$ collapsing on $V$ at $N\ge3$ | Excluded by the spike argument |
| 3a | $\lambda_0$ with every $T$ collapsing | Found: $e_1+e_2-2e_3$ |
| 4 | $n$ where the group count and the trace count disagree | Found: $n=4$ under $O(4)$ |
| 5 | Orthonormal basis of $\mathfrak{so}(n)$, $n\ge4$, with $T$ constant on distinct triples | Adapted $n=4$ basis checked and fails. No bounded search available by hand |
| 6 | A frame at $n\ge5$ with $T_F$ nonconstant yet $\theta$ proportional to $p_3$ on $L_F$ | Identified $L_F\subsetneq V$ at $n=5$. Did not decide proportionality (would be a derivation the record owes) |
| 7 | $W\in\mathcal W_4$ with $\theta$ not proportional to $p_3$ | Screened against the adapted-frame outline, none |
| 8 | A Lean binder admitting a model outside the record's claim | Off-triple values, withdrawn as wording |

## 12. Overall verdict

**HYPOTHESIS-DEBT.** Claims 2 and 3, the core of L49, are proven and faithfully typed. Claim 1 holds at a normalisation the record must state. Claim 4 is refuted as stated through $O(n)$ and is unargued under $SO(n)$. Claims 5 and 7 have no argument on file, and claim 6's inference has a GAP in its domain of spectra.
