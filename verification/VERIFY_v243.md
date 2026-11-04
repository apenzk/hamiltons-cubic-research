# Verifier v243, Lemma L49: the eigenframe display, linearity of the collapse condition, the dimension count and its link to irreducible summands, the unrealisability of constant T, the n >= 5 and n = 4 consequences, and the Lean statement

Cold brief ([verification/BRIEF_L49.md](BRIEF_L49.md)). No numerical work was done, every value is exact, no scripts were written, and no Lean build was run. Log: [agent_logs/verify-L49-v243.log](../agent_logs/verify-L49-v243.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | Eigenframe display $\theta=\sum\lambda_\alpha^3+3\sum_{\alpha<\beta<\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$ | CONFIRMED AS ALGEBRA (at the Böhm–Wilking normalisation, derivation absent from A–C) |
| 2 | The collapse condition is linear in $T$, so the collapsing configurations form a subspace | CONFIRMED |
| 3 | The dimension is governed by the number of independent trace conditions, which is the number of irreducible summands of $\mathcal W_n$ under $O(n)$ | REFUTED AS STATED (under $O(4)$, $\mathcal W_4$ is irreducible), and HYPOTHESIS-DEBT for the link itself |
| 4 | Under the single condition $\sum\lambda=0$ the collapse space is exactly one-dimensional, $T$ constant, at every $N\ge4$ | CONFIRMED (holds at every $N\ge3$, with the quantifier $\exists c\,\forall\lambda$) |
| 5 | Constant $T$ is realised by no $\mathfrak{so}(n)$ | HYPOTHESIS-DEBT |
| 6 | For $n\ge5$ the cubic is a function of the spectrum alone at no critical point | GAP |
| 7 | At $n=4$ the cubic is spectral | HYPOTHESIS-DEBT |
| 8 | Passage D types claims 2 and 4 | CONFIRMED (as the characterisation on the abstract hyperplane, $hN$ unused) |
| 9 | Passage D docstring, lines 62–63: the condition at one fixed $\lambda$ is codimension $1$ in $T$ | REFUTED AS STATED |

**What the round should do:** keep the proven core (claims 2, 4, 8), replace "under $O(n)$" by "under $SO(n)$" and say which labelling of the spectrum makes the $n=4$ count two, then either file arguments for claims 5 and 7 or strip them, and restate claim 6 as the frozen-$T$ statement it actually is. It should also add the display's derivation with its normalisation, restore $\alpha<\beta<\gamma$ in Passage B, and correct the Lean docstring's codimension sentence.

## 0. Conventions, fixed once

- $n\ge4$, $N=\binom n2$, $\mathfrak{so}(n)$ with the product $\langle A,B\rangle=-\tfrac12\mathop{\mathrm{tr}}(AB)$, and $S^2(\mathfrak{so}(n))$ with the trace product $\langle R,S\rangle=\mathop{\mathrm{tr}}(RS)$.
- $\#$ as in Böhm–Wilking eq. (4), read at source in [references/boehm-wilking-2008-space-forms/](https://arxiv.org/abs/math/0606187) lines 166–183: $\langle(R\#S)h,h\rangle=\tfrac12\sum_{\alpha,\beta}\langle[Rb_\alpha,Sb_\beta],h\rangle\langle[b_\alpha,b_\beta],h\rangle$ for an orthonormal basis $b_\alpha$, with the remark that the $\tfrac12$ stems from using $-\tfrac12\mathop{\mathrm{tr}}$ in place of Hamilton's $-\mathop{\mathrm{tr}}$. $W^\#=W\#W$.
- $P(W)=\langle W,W^2+W^\#\rangle$, $\theta=P(W)$ at unit norm (brief's definition).
- $c_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle$, totally antisymmetric, $T_{\alpha\beta\gamma}=c_{\alpha\beta\gamma}^2$.
- $p_k=\sum_\alpha\lambda_\alpha^k$, $e_k$ the elementary symmetric polynomials in $\lambda_1,\dots,\lambda_N$, $H=\{\lambda\in\mathbb R^N:\ p_1=0\}$, $C_T(\lambda)=\sum_{\alpha<\beta<\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$.
- Readings of "collapse": (U) uniform, $\exists c\ \forall\lambda\in H:\ p_3+3C_T=c\,p_3$ (Passage D's `Collapses`); (P) pointwise, at one fixed $\lambda$, $\exists c:\ p_3(\lambda)+3C_T(\lambda)=c\,p_3(\lambda)$; (Q) swapped, $\forall\lambda\in H\ \exists c$.

Quotation check: Passage A matches [findings/target.md](../findings/target.md) line 775 (heading line 759), Passage B matches [results.md](../results.md) line 188, Passage C matches results.md line 655 (heading line 653), and Passage D is byte-identical to [L49Statement.lean](../lean/HamiltonsCubic/Results/L49Statement.lean) (the file has 343 lines, the brief says 344, an off-by-one in the count only). The imported [L42Statement.lean](../lean/HamiltonsCubic/Results/L42Statement.lean) definitions `objective`, `distinctSum`, `increasingSum`, `objective_eq_increasingSum` and `distinctSum_eq_six` (lines 92–165) were read at source and say what [three_e3](../lean/HamiltonsCubic/Results/L49Statement.lean#L254) uses them for. A build artefact `L49Statement.olean` newer than the source exists under `lean/.lake/build`, which is evidence of a past successful build and nothing more.

## Hypothesis inventory

| Hypothesis | Where stated | Checked against the object | Used by the proof |
|---|---|---|---|
| $W$ symmetric on $\Lambda^2\mathbb R^n$ with an orthonormal eigenframe | A, C ("in an eigenframe") | Holds, spectral theorem | Claim 1 only |
| Normalisation of $\#$ and of $\langle\,,\rangle$ on $\mathfrak{so}(n)$ | Nowhere in A–D | Coefficient $3$ holds only at the BW pair ($-\tfrac12\mathop{\mathrm{tr}}$, factor $\tfrac12$), see §1 | Claim 1, **used but unstated** |
| Quantifier over spectra | C ("for every spectrum obeying the trace conditions"), D (`∀ lam`), absent in A and B | Load-bearing, see §2 | Claims 2, 4 |
| "Spectrum obeying the trace conditions" means every $\lambda\in H$, not only realised spectra | D encodes it, C ambiguous | Under the realised-spectra reading one needs the realised spectra to be Zariski-dense in $H$, no argument on file | Claim 4, **used but unstated in C** |
| Labelling of the spectrum by irreducible summand of $\Lambda^2$ | Nowhere | Needed for the $n=4$ count to be two, see §3 | Claim 3, **used but unstated** |
| $\mathcal W_n$ irreducible for $n\ge5$ | C, parenthesis | Standard, but no source filed (the [references/INDEX.md](../references/INDEX.md) has no entry for it) | Claim 3 |
| Group $O(n)$ | C | Wrong at $n=4$, see §3 | Claim 3 |
| $N\ge4$ | A, C, D (`hN`) | Unused, the proof works at $N\ge3$ | None |
| $T$ constant "on distinct triples" | Absent from A–C | Needed for claim 5 to be non-trivial, see §5 | Claim 5 |
| L42 `distinctSum_eq_six` hypotheses `s12`, `s23` | Lean | Discharged by `hsym12`, `hsym23` for $g=\lambda_\alpha\lambda_\beta\lambda_\gamma$, correct | `three_e3` |
| $\ker W\ne0$, repeated eigenvalues | Nowhere | Display still holds, $T$ becomes frame-dependent, see §9 | Claim 6 |

## 1. The eigenframe display (attack item 1)

**Derivation.** In an eigenframe, $W$ is diagonal, so $\langle W,W^2\rangle=\mathop{\mathrm{tr}}W^3=p_3$. By BW eq. (4) with $b_\alpha=v_\alpha$ and $Wv_\alpha=\lambda_\alpha v_\alpha$, $\langle W^\#v_\gamma,v_\gamma\rangle=\tfrac12\sum_{\alpha,\beta}\lambda_\alpha\lambda_\beta c_{\alpha\beta\gamma}^2$. Hence $\langle W,W^\#\rangle=\sum_\gamma\lambda_\gamma\langle W^\#v_\gamma,v_\gamma\rangle=\tfrac12\sum_{\alpha,\beta,\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma T_{\alpha\beta\gamma}$. Antisymmetry makes $c$ vanish unless the indices are distinct, and the summand is symmetric under the six permutations, so the sum is $6C_T$ and $\langle W,W^\#\rangle=3C_T$. This gives $P(W)=p_3+3C_T$.

**Normalisation.** Under Hamilton's $-\mathop{\mathrm{tr}}$ and no $\tfrac12$, an orthonormal basis is $v'_\alpha=v_\alpha/\sqrt2$, and $T'_{\alpha\beta\gamma}=\big(2\langle[v_\alpha,v_\beta]/2,v_\gamma/\sqrt2\rangle\big)^2=T_{\alpha\beta\gamma}/2$, while $\langle W,W^\#\rangle=6C_{T'}$. The quantity is the same, but the display written with $T$ computed in the ambient product reads with coefficient $6$ at that normalisation. So the coefficient $3$ is correct exactly for the BW pair. The collapse results (claims 2, 4) are insensitive to the coefficient, since any positive multiple of $C_T$ gives the same subspace.

**Verdict.** CONFIRMED AS ALGEBRA. A derivation is needed, since the coefficient is normalisation-dependent and Passages A–C fix no normalisation. The record would have to supply it in the L49 block or cite the conventions file where $\#$ and the $\mathfrak{so}(n)$ product are fixed.

## 2. The quantifier, and linearity (attack item 2, standing items 2 and 4)

**Linearity under (U).** The set $\{(T,c): p_3+3C_T=c\,p_3 \text{ on } H\}$ is cut out by equations linear in $(T,c)$, so it is a subspace of $\mathbb R^{\binom N3}\times\mathbb R$, and its projection to $T$ is a subspace. Passage D's `collapse_add` (witness $c+d-1$) and `collapse_smul` (witness $rc-r+1$) check this link by link: $p_3+3(C_T+C_S)=(c+d-1)p_3$ follows from adding the two identities and subtracting $p_3$, and $p_3+3rC_T=p_3+r(c-1)p_3$. CONFIRMED.

**Dimension under each reading.**

- (U): the constants on increasing triples, dimension $1$ for $N\ge3$ (§4).
- (P) at a fixed $\lambda$ with $p_3(\lambda)\ne0$: every $T$ collapses, with $c=1+3C_T(\lambda)/p_3(\lambda)$. Dimension $\binom N3$. Closed form: $N=4$, $\lambda=(1,1,1,-3)$, $p_1=0$, $p_3=-24$.
- (P) at a fixed $\lambda$ with $p_3(\lambda)=0$: the condition is $C_T(\lambda)=0$, a hyperplane when some distinct-triple monomial is nonzero, and all of $\mathbb R^{\binom N3}$ when $\lambda$ has at most two nonzero entries. Closed forms at $N=4$: $\lambda=(1,-1,1,-1)$ has $p_1=p_3=0$ and monomials $(\lambda_1\lambda_2\lambda_3,\lambda_1\lambda_2\lambda_4,\lambda_1\lambda_3\lambda_4,\lambda_2\lambda_3\lambda_4)=(-1,1,-1,1)$, giving the hyperplane $-T_{123}+T_{124}-T_{134}+T_{234}=0$, codimension $1$. And $\lambda=(1,-1,0,0)$ gives all $T$, codimension $0$.
- (Q): contains the constants, and whether it equals them is not settled by the spike argument, since every spike has $p_3=-6\ne0$. No argument is on file for (Q), and none is needed if the record adopts (U).

Passage C carries (U) in words ("for every spectrum obeying the trace conditions", with "a multiple" read as one multiple). Passage A and Passage B are silent, and on the (P) reading their dimension claim is false. This is a statement-level defect of A and B, recorded under item 8.

### 2a. Candidate: Passage D docstring, "the same condition at one fixed λ is codimension 1 in T"

1. **Locate.** [L49Statement.lean](../lean/HamiltonsCubic/Results/L49Statement.lean) lines 43–44 of the file (Passage D lines 62–63): "*the same condition at one fixed `λ` is codimension `1` in `T`, and would give a different and false statement.*" The same claim appears in the quoted Gate 2 verdict at Passage D line 50.
2. **Exhibit.** $N=4$, $\lambda=(1,1,1,-3)\in H$, $p_3=-24$. For every $T$, $c=1-C_T(\lambda)/8$ satisfies the condition. The collapsing set at this $\lambda$ is all of $\mathbb R^4$, codimension $0$.
3. **Charitable reading.** The set of pairs $(T,c)$ is a hyperplane in $\mathbb R^{\binom N3+1}$, codimension $1$, and at a fixed $c$ the set of $T$ is an affine hyperplane. The text says "in `T`" and "the same condition", which includes $\exists c$, so the charitable reading changes the object. It survives only at $\lambda$ with $p_3(\lambda)=0$.

Finding stands, REFUTED AS STATED. It is commentary and leaves the typed theorem untouched. The conclusion it draws, that the pointwise reading "would give a different and false statement", is correct.

## 3. Trace conditions and irreducible summands (attack item 4)

**Is the link argued?** No argument is quoted in A, B or C for either "dimension governed by the number of independent trace conditions" or "that number is the number of irreducible summands". Neither sentence states a formula, so "governed" has no checkable content beyond claims 4 and 7. HYPOTHESIS-DEBT: the record would have to define "independent trace conditions" (linear functionals on which labelled spectrum), prove the count equals the number of irreducible summands, and state the dimension as a function of that count.

**The labelling decides the count.** A spectrum as an unordered multiset admits only permutation-invariant linear conditions, i.e. multiples of $p_1$, so the count is $1$ at every $n\ge4$, including $n=4$. The count reaches two at $n=4$ only when the eigenvalues are labelled by $\Lambda^+$ and $\Lambda^-$, with $a_1+a_2+a_3=0$ and $b_1+b_2+b_3=0$ in an adapted eigenframe. The record states neither reading.

**The group, checked at $n=4$.**

### 3a. Candidate: "the number of irreducible summands of $\mathcal W_n$ under $O(n)$" with "At $n=4$, where $\mathcal W_4$ is reducible"

1. **Locate.** results.md line 655: "which is the number of irreducible summands of $\mathcal W_n$ under $O(n)$. Under a single condition ($n\ge5$, where $\mathcal W_n$ is irreducible) ... At $n=4$, where $\mathcal W_4$ is reducible, the cubic is spectral."
2. **Exhibit.** $\mathcal W_4=\mathcal W^+\oplus\mathcal W^-$ with $\mathcal W^\pm=S^2_0(\Lambda^\pm)$. Under $SO(4)\to SO(\Lambda^+)\times SO(\Lambda^-)$ each $\mathcal W^\pm$ is irreducible (it is $S^2_0\mathbb R^3$ of $SO(3)$), and they are non-isomorphic because $SO(\Lambda^-)$ acts trivially on $\mathcal W^+$ and nontrivially on $\mathcal W^-$. So the $SO(4)$-invariant subspaces are $0,\mathcal W^+,\mathcal W^-,\mathcal W_4$. The reflection $r:x_4\mapsto-x_4$ lies in $O(4)\setminus SO(4)$ and sends $e_{12}+e_{34}\mapsto e_{12}-e_{34}$, $e_{13}-e_{24}\mapsto e_{13}+e_{24}$, $e_{14}+e_{23}\mapsto -e_{14}+e_{23}$, so $r\Lambda^+=\Lambda^-$ and $r\mathcal W^+=\mathcal W^-$. Hence neither summand is $O(4)$-invariant and $\mathcal W_4$ is $O(4)$-irreducible. Under $O(n)$ the count at $n=4$ is $1$, the same as at $n\ge5$, and Passage C's own contrast between $n=4$ and $n\ge5$ disappears.
3. **Charitable reading.** "Reducible" at $n=4$ is standard shorthand for $SO(4)$, and the sentence probably intends $SO(n)$. But the group is written explicitly in the sentence that defines the count, so the charitable reading replaces a stated hypothesis. At $n\ge5$ the two groups agree and nothing changes.

Finding stands, REFUTED AS STATED. The correction is $SO(n)$ together with the $\Lambda^\pm$ labelling.

**What the two-condition count gives at $n=4$.** Under the labelled reading, $H_4=H_A\times H_B$ with $\dim H_4=4$, and the collapse space under (U) has dimension $7$, so "one-dimensional under one condition" has no analogue of the form "$k$-dimensional under $k$ conditions". Lower bound, closed form: $T\equiv1$ collapses since $3e_3=p_3$ on $H_4\subset H$, and for each pair $i<j$ in $A=\{1,2,3\}$ the tensor $T_{ijk}=1$ for $k\in B=\{4,5,6\}$, zero elsewhere, has $C_T=a_ia_j(b_1+b_2+b_3)=0$ on $H_4$, and likewise for the three $B$-pairs with $a_1+a_2+a_3$. These seven have linearly independent restrictions to increasing triples (six disjoint supports on mixed triples, and $T\equiv1$ is the only one nonzero on $\{1,2,3\}$). Upper bound: on $H_4$, $C_T$ splits by bidegree in $(a,b)$, and the bidegrees are independent. Bidegree $(3,0)$ and $(0,3)$ must equal $(c-1)e_3(a)$ and $(c-1)e_3(b)$, forcing $T_{123}=T_{456}=c-1$. In bidegree $(2,1)$, $\sum_{i<j}a_ia_j\sum_kT_{ijk}b_k$ vanishes on $H_4$ only if each $\sum_kT_{ijk}b_k$ vanishes on $H_B$ (the three $a_ia_j$ restrict to the independent quadratics $a_1a_2$, $-a_1^2-a_1a_2$, $-a_1a_2-a_2^2$), so $T_{ijk}$ is independent of $k$. The same holds in $(1,2)$. Total $1+3+3=7$. Passage C assigns no dimension at $n=4$, so there is nothing to contradict, but this is a screen showing the unstated "governed by" is no simple count.

## 4. The dimension claim (attack item 3, standing item 3)

**Collapse forces a constant.** Spike $s=e_i+e_j-2e_k$, $i<j<k$: $p_1=0$, $p_3=1+1-8=-6$, and the only increasing triple with all three entries nonzero is $(i,j,k)$, so $C_T(s)=T_{ijk}\cdot1\cdot1\cdot(-2)$. Under (U), $-6-6T_{ijk}=-6c$, so $T_{ijk}=c-1$ on every increasing triple. Lean: `spike_sum`, `spike_cube`, `spike_triple` (the 64-way case split closes by `omega` on order contradictions or by evaluation), then `linarith` on $-6+3(-2T)=c(-6)$. Correct link by link.

**A constant collapses.** On $H$, the ordered distinct-triple sum of $\lambda_\alpha\lambda_\beta\lambda_\gamma$ equals $6e_3$ (L42 `distinctSum_eq_six`), and inclusion–exclusion $[\text{distinct}]=1-[\alpha=\beta]-[\alpha=\gamma]-[\beta=\gamma]+2[\alpha=\beta=\gamma]$ (checked on the three coincidence patterns: $1$, $0$, $1-3+2=0$) gives $p_1^3-3p_1p_2+2p_3=2p_3$. So $3e_3=p_3$ and $T\equiv d$ gives $\theta=(1+d)p_3$. Lean `three_e3` and the reverse direction of `collapse_space_is_the_constants` carry exactly this. Correct.

**Threshold.** Neither direction uses $N\ge4$. At $N=3$ there is one increasing triple and every $T$ is constant, so the space is $\mathbb R$, dimension $1$, and the claim holds trivially. At $N\le2$ there are no triples and the space is $0$. Since $N=\binom n2\ge6$ for $n\ge4$, the threshold $N\ge4$ is harmless and never binds. "Exactly one-dimensional" follows from the characterisation with $d=1$ giving a nonzero tensor on increasing triples, which exist for $N\ge3$.

**Scope.** The proof treats $T$ as a free vector and $\lambda$ as ranging over all of $H$. Under Passage C's words "every spectrum obeying the trace conditions" read as realised Weyl spectra, the spike $e_i+e_j-2e_k$ must be a realised spectrum (up to scaling) for the argument to apply verbatim, or the realised spectra must be Zariski-dense in $H$. No argument for either is on file. Under the reading "every $\lambda\in H$", which Passage D encodes, the claim is proven.

Verdict CONFIRMED, under (U) with $\lambda$ ranging over $H$.

## 5. Constant T realised by no so(n) (attack item 5)

**What it quantifies over.** If "constant" ranges over all index triples, antisymmetry forces $T_{\alpha\alpha\beta}=0$, so constant means $T\equiv0$, i.e. an abelian $\mathfrak{so}(n)$, false for $n\ge3$. The claim is then trivially true and says nothing. The substantive reading is "constant on distinct triples", which A–C do not write, and which matches the display's range.

**Is an argument quoted?** None in A, B or C. Passage D's docstring quotes a Gate 2 verdict that a partial parity argument exists for $n\equiv2,3\pmod4$ with $n=8,9,12$ open, and explicitly leaves the claim untyped. HYPOTHESIS-DEBT: the record must prove that no orthonormal basis of $\mathfrak{so}(n)$, $n\ge5$ (or $n\ge4$), has $\langle[v_\alpha,v_\beta],v_\gamma\rangle^2$ equal on all distinct triples.

**Hand-checkable cases.** $n=3$: $N=3$, one distinct triple, and any orthonormal basis realises constant $T$.

### 5a. Candidate (withdrawn): "realised by no $\mathfrak{so}(n)$" fails at $n=3$

1. **Locate.** results.md line 655, "constant $T$ is realised by no $\mathfrak{so}(n)$", and target.md line 775, "not realised by any $\so(n)$".
2. **Exhibit.** $\mathfrak{so}(3)$ with any orthonormal basis has one distinct triple, so $T$ is constant.
3. **Charitable reading.** The sentence sits inside the range $n\ge5$ of Passage C ("Under a single condition ($n\ge5$ ...)") and the lemma concerns $\mathcal W_n$, which is $0$ at $n=3$. The scope $n\ge4$ is implicit.

Withdrawn: the charitable reading holds. The record should still write the range.

At $n=4$ the question reduces to a $6\times6$ orthogonal matrix whose complementary $3\times3$ minors satisfy $|m_S\pm m_{S^c}|$ constant over all $20$ triples (from $\mathfrak{so}(4)=\mathfrak{so}(3)\oplus\mathfrak{so}(3)$). I did not settle it, since settling it would mean building the missing argument.

## 6. The n >= 5 consequence (attack item 6)

**The inference.** Passage C: "So for $n\ge5$ the cubic is a function of the spectrum alone at no critical point." The premises available are claim 4 (under (U), $T$ collapses iff constant) and claim 5 (constant $T$ is unrealised, itself HYPOTHESIS-DEBT).

**Tracking the quantifier.** From 4 and 5 one gets: for every $W$ and every eigenframe, the frozen $T_W$ fails (U), i.e. there is some $\lambda\in H$ with $p_3(\lambda)+3C_{T_W}(\lambda)\ne c\,p_3(\lambda)$ for each $c$. This is a statement about $\lambda$ other than $W$'s own spectrum, paired with $W$'s frame.

"The cubic is a function of the spectrum alone at a critical point $W$" is a statement about $P$ on $\mathcal W_n$: either that $P$ is constant on the isospectral set through $W$ (near $W$ or globally), or pointwise that $\theta(W)=c\,p_3(\lambda_W)$.

- On the pointwise reading, at every $W$ with $p_3(\lambda_W)\ne0$ the identity holds with $c=\theta/p_3$, whatever $T_W$ is. So the conclusion is false on this reading as soon as one critical point has $p_3(\lambda_W)\ne0$, and the record cannot intend it.
- On the isospectral reading, non-spectrality needs two isospectral Weyl tensors with $C_{T_W}(\lambda)\ne C_{T_{W'}}(\lambda)$. A frozen $T_W$ failing a polynomial identity on all of $H$ gives no such pair: it changes $\lambda$ and keeps the frame, whereas an isospectral family keeps $\lambda$ and changes the frame, and only realisable frames count.
- At any $W$ whose spectrum has at most two nonzero eigenvalues, $C_T(\lambda_W)=0$ for every $T$, so $P(W)=p_3(\lambda_W)$ is spectral on the whole isospectral set. Closed form of such a Weyl tensor at $n=5$: $W=\mu(v\otimes v-w\otimes w)$ with $v=(e_{12}+e_{34})/\sqrt2$, $w=(e_{13}-e_{24})/\sqrt2$, which lies in $\mathcal W^+(\mathbb R^4)$ (trace-free on $\Lambda^+$, $v\wedge v=w\wedge w$) and extends by zero to a Ricci-free algebraic curvature tensor on $\mathbb R^5$ with spectrum $(\mu,-\mu,0,\dots,0)$. This shows the conclusion is false at such $W$ if one of them is critical. I did not decide whether any such $W$ is critical, so this is recorded as the falsifier to look for and not as a refutation.

No argument on file bridges the frozen-$T$ statement to either reading. Verdict GAP. The secondary clause "any bound through the spectrum alone carries alignment slack" inherits the gap. At $n=5$ nothing special happens: $N=10$, $\mathcal W_5$ is irreducible under both groups, and the same gap applies.

## 7. The n = 4 claim (attack item 7)

**What it claims.** $P(W)$ depends only on the spectrum of $W\in\mathcal W_4$.

**Does it follow?** It does not follow from claims 2–5, which concern the one-condition case. No argument is quoted. What would have to be proved: (a) an eigenframe of $W$ can be chosen adapted to $\Lambda^+\oplus\Lambda^-$ (true since $W$ preserves both); (b) $[\Lambda^+,\Lambda^-]=0$, so $T=0$ on mixed triples; (c) $T_{123}=T_{456}=t$, the common value of $\langle[u_1,u_2],u_3\rangle^2$ for orthonormal bases of the two $\mathfrak{so}(3)$ ideals; and then (d) $3e_3=p_3$ on each ideal's trace-free spectrum. With these, $T$ lies in the seven-dimensional $n=4$ collapse space of §3 and $P=(1+t)p_3$. I found no falsifier and the named facts are standard, but none is on file in A–C. Verdict HYPOTHESIS-DEBT. The phrase "where $\mathcal W_4$ is reducible" carries the $O(n)$ defect of §3a.

## 8. Passage D against the record (standing item 5, attack items 3 and 8)

**Binders.** `T : Fin N → Fin N → Fin N → ℝ` is an arbitrary real array: no nonnegativity, no symmetry, no realisability. `lam` ranges over all of $\mathbb R^N$ with `∑ lam = 0`, i.e. $H$. `N` is any natural with `4 ≤ N`, not tied to $\binom n2$ and not tied to $n\ge5$. `c` is existential outside `∀ lam`, reading (U).

**Trace condition encoded.** Exactly one, $p_1=0$. The record's "trace conditions" in Passage C are "the conditions the spectrum obeys", which at $n=4$ under the labelled reading are two. Passage D therefore types the $n\ge5$ single-condition case only, and says so in its docstring.

**Statement.** `Collapses T ↔ ∃ d, ∀ α β γ, α < β → β < γ → T α β γ = d`. This is claim 4 as a characterisation: "constant on increasing triples". It says nothing about entries off increasing triples, which the display never reads, so as a subspace of `Fin N → Fin N → Fin N → ℝ` the collapse set has dimension $N^3-\binom N3+1$, and the "one-dimensional" reading is correct only after restricting to increasing triples. No `finrank` is constructed, as the docstring says.

**Does a hypothesis exclude anything?** `hN : 4 ≤ N` excludes $N=3$, where the result also holds, and is unused. No hypothesis makes the statement vacuous: `zero_collapses` exhibits a collapsing $T$, and at $N\ge3$ the spike instances are non-trivial. No `sorry` appears in the file.

**Omissions, declared.** Claims 3, 5, 6, 7 and the display (claim 1) are untyped. `thetaOf` is a definition of the right-hand side of the display, so the link from $P(W)$ to `thetaOf` is outside the Lean file.

Verdict CONFIRMED for what it types. The docstring defect is §2a.

**The three forms against each other (attack item 8).**

| Clause | A (target.md 775) | B (results.md 188) | C (results.md 655) |
|---|---|---|---|
| Range $\alpha<\beta<\gamma$ in the display | yes | **no** | yes |
| Definition of $T$ | yes | no | yes |
| "of $W$" for the eigenframe | no | no | yes |
| Quantifier "for every spectrum obeying the trace conditions" | **no** | **no** | yes |
| "linear in $T$" | yes | implicit ("form a subspace") | yes |
| Dimension governed by number of trace conditions | yes | no | yes |
| Equals number of irreducible summands | yes, no group | no | yes, "under $O(n)$" |
| $n\ge5$ named for the single condition | no | no | yes |
| "at every $N\ge4$" | yes | no | yes |
| "spanned by constant $T$" | "$T$ constant" | "$T$ constant" | yes |
| Constant $T$ unrealised | yes | yes | yes |
| $n\ge5$ consequence, alignment slack | no | no | yes |
| $n=4$ spectral | no | no | yes |

### 8a. Candidate (withdrawn): Passage B's display has the wrong coefficient

1. **Locate.** results.md line 188: "$\theta=\sum\lambda_\alpha^3+3\sum T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$", no index range.
2. **Exhibit.** Read over all ordered $(\alpha,\beta,\gamma)$, §1 gives $\langle W,W^\#\rangle=\tfrac12\sum_{\alpha\beta\gamma}T\lambda\lambda\lambda$, so the coefficient would be $\tfrac12$, not $3$.
3. **Charitable reading.** B is the landscape abbreviation of C, which carries $\alpha<\beta<\gamma$, and B's $T$ is undefined without C.

Withdrawn. The round should still restore the range in B.

## 9. The boundary (standing item 3, attack item 9)

- **$n=4$:** §3 (group defect, dimension $7$ under the labelled reading), §7 (HYPOTHESIS-DEBT).
- **$n=5$:** $N=10$, claim 4 applies, claim 5 is open on the record's own account, claim 6 is a GAP (§6).
- **$N=3$:** claim 4 holds trivially (§4), and claim 5 fails at $n=3$ unless the range is implicit (§5a, withdrawn).
- **$\ker W\ne0$:** the display holds unchanged, since zero eigenvalues are admissible in §1. Repeated eigenvalues (in particular a kernel of dimension $\ge2$) make the eigenframe non-unique and $T_W$ frame-dependent, so "the $T$ of $W$" in claims 5 and 6 needs "for some eigenframe" or "for every eigenframe". At spectra with at most two nonzero entries, $C_T(\lambda)=0$ for all $T$ and $P$ is spectral there (§6).

## 10. Falsifiers named, and what was done (standing item 7)

| Claim | Falsifying object | What I did |
|---|---|---|
| 1 | A normalisation pair under which $\langle W,W^\#\rangle\ne3C_T$ | Derived at BW and Hamilton normalisations: coefficient $3$ at BW, $6$ in $T'$ at Hamilton |
| 2 | Two collapsing $T,S$ with $T+S$ non-collapsing | Checked the witnesses $c+d-1$, $rc-r+1$ |
| 3 | $n$ with count $\ne$ number of summands under the stated group | Exhibited $n=4$ under $O(4)$ in closed form (§3a) |
| 4 | Non-constant collapsing $T$ at some $N\ge4$ | Spike argument read link by link, none can exist under (U) |
| 5 | An orthonormal basis of $\mathfrak{so}(n)$, $n\ge4$, with $T$ constant on distinct triples | $n=3$ trivial (withdrawn), reduced $n=4$ to a minor condition, not settled |
| 6 | A critical $W$, $n\ge5$, at which $P$ is constant on its isospectral set, e.g. one with at most two nonzero eigenvalues | Exhibited a Weyl tensor on $\mathbb R^5$ with spectrum $(\mu,-\mu,0,\dots)$, criticality not decided |
| 7 | Two isospectral $W,W'\in\mathcal W_4$ with $P(W)\ne P(W')$ | Named the four facts that exclude it, none on file |
| 8 | A `T` satisfying the Lean iff but failing the record's claim | Checked binders, $N\le3$, off-triple entries |
| 9 | $\lambda$ where (P) has codimension $\ne1$ | $N=4$, $\lambda=(1,1,1,-3)$ (§2a) |

## Overall verdict: GAP

- The core, that under $\exists c\,\forall\lambda\in H$ the collapse space is exactly the constants on increasing triples, is proven by hand and in Lean at every $N\ge3$.
- The statement also carries: a clause refuted as stated ("under $O(n)$", with "$\mathcal W_4$ reducible"); two clauses with no argument on file (constant $T$ unrealised, and $n=4$ spectral); and one inference that does not follow from its premises (the $n\ge5$ "function of the spectrum alone at no critical point"), whose premises include the unproved clause.
- Passages A and B omit the quantifier, and on the pointwise reading their dimension claim is false. The display's coefficient $3$ is correct at the Böhm–Wilking normalisation, which the record must state.
