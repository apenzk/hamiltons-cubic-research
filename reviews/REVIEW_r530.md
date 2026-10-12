# REVIEW r530, Lemma L27, "sphere products are Morse–Bott nondegenerate"

**Target.** `findings/nondegeneracy.md`, `#### Lemma L27` (line 457) through the next heading.

**Statement under audit.** Let $p,q\ge3$ with $(p,q)\ne(3,3)$ and $n=p+q$. Then $\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$ at $W_{p,q}$, attained exactly on the orbit tangent, so $\dim E(\tfrac12)=pq=\dim(\text{orbit})$ and $S^p\times S^q$ is Morse–Bott nondegenerate.

**Footing.** Analysis only. No searches, sweeps, censuses or falsifier hunts. Screening of a claim about to be recorded is permitted and is labelled as a screen.

**Phase plan.**

1. P1, fix conventions against the record's anchors.
2. P2, read L27 verbatim.
3. P3, Nienhaus Prop 4.6 via the record's notes (never a PDF); check the ten dimensions sum to $\dim\mathcal W_n$ identically in $p,q$.
4. P4, multiplicity-freeness, especially at $p=q$.
5. P5, the Schur step.
6. P6, the ten eigenvalues; derive the orbit's $\tfrac12$, the $\Lambda^2\otimes\Lambda^2$ value, and the largest of the rest.
7. P7, the excluded $(3,3)$ and the hypothesis $p,q\ge3$.
8. P8, sample the load-bearing citations; grep `findings/` for contradicting restatements, including later sections of the target file.
9. P9, verdict.

**VERDICT: CONFIRMED**, see the verdict section at the foot of this report.

---

## Findings

### F1, The ten dimensions sum to $\dim\mathcal W_n$ identically in $p,q$. **Confirmed, exactly.**

With $\dim S^2_0(\mathbb R^m)=\tfrac{m(m+1)}2-1$, $\dim\Lambda^2(\mathbb R^m)=\tfrac{m(m-1)}2$, $\dim X_m=\tfrac{m(m^2-4)}3$ and $\dim\mathcal W_m=\tfrac{m(m-3)(m+1)(m+2)}{12}$,

$$1+\mathcal W_p+\mathcal W_q+pq+S^2_0(p)+S^2_0(q)+S^2_0(p)S^2_0(q)+\Lambda^2(p)\Lambda^2(q)+qX_p+pX_q-\mathcal W_{p+q}=0$$

as a polynomial identity in $p,q$ (screen: one `sympy` `factor(simplify(...))`, difference literally $0$; the two sides both factor as $\frac{(p+q)(p+q-3)(p+q+1)(p+q+2)}{12}$). This is the cheapest available check and it closes.

### F2, The decomposition is stated as the block has it. **Confirmed against the record's own notes and extraction.**

[references/nienhaus-2023-second-best-einstein/notes.md](../references/nienhaus-2023-second-best-einstein/notes.md) §"Proposition 4.6 (L3761)", and the extraction it indexes at [nienhaus-2311.02404.txt](https://arxiv.org/abs/2311.02404) lines 3805–3815 (no PDF opened), carry the *summary display* the block quotes:

> $\mathrm{Weyl}_n=\langle W_{S^k\times S^l}\rangle\oplus\mathrm{Weyl}_k\oplus\mathrm{Weyl}_l\oplus(\mathbb R^k\otimes\mathbb R^l)\oplus S^2_0(\mathbb R^k)\oplus S^2_0(\mathbb R^l)\oplus(S^2_0(\mathbb R^k)\otimes S^2_0(\mathbb R^l))\oplus(\Lambda^2(\mathbb R^k)\otimes\Lambda^2(\mathbb R^l))\oplus(X_k\otimes\mathbb R^l)\oplus(X_l\otimes\mathbb R^k)$
>
> "This decomposition is orthogonal and irreducible under the $SO(k)\times SO(l)$-action for any $k,l\ge5$. Furthermore, it is irreducible under the action of $O(k)\times O(l)$ for any $k,l\ge3$."

Ten summands, matching the block term for term and in the same order. Two corrections to how the block describes its own source:

- The block says "the $p,q\ge5$ case is proved in the source". The source's **$O(k)\times O(l)$ clause is stated for $k,l\ge3$**, not $\ge5$; the $\ge5$ restriction is on the $SO$ clause and on the eighteen-summand $S^2(\mathfrak{so}(n))$ statement of 4.6 proper, whose hypothesis is "$k,l\ge5$, $k,l\ne6$". The block's use is therefore *inside* the source's stated range, and its own remark that the low range is "asserted rather than proved" is the accurate reading.
- The **$k\ne6$** exclusion in Proposition 4.6's hypothesis line does not propagate to the summary display and is not needed by the block. It attaches to the Appendix I irreducibility proof for $\Lambda^2(\mathbb R^k)\otimes\mathbb R^k$, "for any $k\ge3$ with $k\ne4,6$" (extraction L3750–3753), a space that does not appear in the ten-summand display. **Checked there rather than inferred.**

### F3, Multiplicity-freeness, including at $p=q$. **Confirmed; the brief's worry is unfounded, and the block's proof can be made analytic.**

As $O(p)\times O(q)$-representations the ten summands carry the Young-label *pairs*

| summand | label pair |
| --- | --- |
| $\langle W\rangle$ | $([\,],[\,])$ |
| $\mathrm{Weyl}_p$, $\mathrm{Weyl}_q$ | $([2,2],[\,])$, $([\,],[2,2])$ |
| $\mathbb R^p\otimes\mathbb R^q$ | $([1],[1])$ |
| $S^2_0(\mathbb R^p)$, $S^2_0(\mathbb R^q)$ | $([2],[\,])$, $([\,],[2])$ |
| $S^2_0\otimes S^2_0$ | $([2],[2])$ |
| $\Lambda^2\otimes\Lambda^2$ | $([1,1],[1,1])$ |
| $X_p\otimes\mathbb R^q$, $X_q\otimes\mathbb R^p$ | $([2,1],[1])$, $([1],[2,1])$ |

Ten pairwise distinct **ordered** pairs. The pairs stay distinct at $p=q$ because the two factors of $O(p)\times O(q)\subset O(n)$ are distinguishable subgroups regardless of $p=q$, the swap that would identify $([2],[\,])$ with $([\,],[2])$, or $([2,1],[1])$ with $([1],[2,1])$, lies in $O(n)$ but **not** in $O(p)\times O(q)$, which is the group the argument uses. So no $2\times2$ Schur block arises at the balanced product, and the case the programme cares about is safe. *Checked the record first: [findings/nondegeneracy.md](../findings/nondegeneracy.md) line 718 names the same group, and every citing site does too.*

Two further points the block leaves implicit and that hold:

- Each label is **admissible** for its group in the stated range: a partition $\lambda$ labels an $O(m)$-irreducible iff $\lambda'_1+\lambda'_2\le m$, so $[2,1]$ and $[1,1]$ need $m\ge3$ and $[2,2]$ needs $m\ge4$, which is why $\mathrm{Weyl}_3=0$ and why the ten-summand list degenerates gracefully rather than breaking at $p=3$.
- **The block's "exact $O(m)$-commutant computation at $m=3,4$" is corroboration, not the only route.** Distinct admissible Young labels give non-isomorphic $O(m)$-irreducibles, so multiplicity-freeness follows from the source's irreducibility clause by pure representation theory at every $p,q\ge3$. The computation's real content is the two dimension coincidences it names ($\dim S^2_0(\mathbb R^3)=\dim X_3=5$ and $\dim\mathbb R^3=\dim\Lambda^2(\mathbb R^3)=3$) where the labels differ by $\det$ ($X_3\cong S^2_0(\mathbb R^3)\otimes\det$, $\Lambda^2(\mathbb R^3)\cong\mathbb R^3\otimes\det$) and the pairs would fuse under $SO(3)$. **This is exactly why the group must be $O$ and not $SO$**, and the block's own $(3,3)$ paragraph says so with the right numbers ($\dim\mathrm{Comm}_{O(3)^2}=2$ against $\dim\mathrm{Comm}_{SO(3)^2}=4$, two irreducibles with $\mathrm{End}=\mathbb R$ and no cross-$\mathrm{Hom}$, against one isotypic component of multiplicity two).

### F4, The Schur step. **The conclusion is right; the block's stated reason is misphrased, and the correct one-line reason is supplied.**

The block writes: *"since $L_e$ is symmetric the $\mathbb C$ and $\mathbb H$ Schur cases cannot occur"* (line 718 repeats it). Read literally this is a non-sequitur: whether $\mathrm{End}_G(V)$ is $\mathbb R$, $\mathbb C$ or $\mathbb H$ is a property of the representation, and no property of $L_e$ can change it. **But the conclusion the block draws (that $L_e$ is a real scalar on each summand), follows from symmetry alone**, and here is the step that is actually needed:

> $\mathrm{End}_G(V)$ is a real division algebra. A **symmetric** operator has real eigenvalues. A non-real element $A=a+b\mathbf i+c\mathbf j+d\mathbf k$ of $\mathbb C$ or $\mathbb H$ satisfies $A^2-2aA+\lvert A\rvert^2=0$ with discriminant $-4(b^2+c^2+d^2)<0$, so it has no real eigenvalue. Hence a symmetric element of $\mathrm{End}_G(V)$ lies in $\mathbb R$, whichever of the three cases holds.

So symmetry *is* the right ingredient; what it rules out is a **non-scalar** equivariant symmetric operator, not the occurrence of the $\mathbb C$/$\mathbb H$ cases. Independently the cases genuinely do not occur, every irreducible complex representation of a full orthogonal group $O(m)$ is of real type, hence absolutely irreducible, and a tensor product of two such is too. **This is a wording defect with no consequence**: both routes give a scalar, and the record already carries the sharper phrasing at line 718 ("Absolute irreducibility is what Schur needs").

Self-adjointness of $L_e$ itself is not in doubt: $\langle e\circ X,Y\rangle$ is the polarisation of the cubic $P$ and is totally symmetric ([conventions.md](../findings/conventions.md), the $\circ$-product bullet).

### F5, The orbit's $\tfrac12$. **Derived independently; confirmed, and it needs no property of $W_{p,q}$ beyond criticality.**

$Q$ is quadratic, so $Q(W+tV)=Q(W)+2t\,W\circ V+t^2Q(V)$ and $DQ_W(V)=2\,W\circ V$. Along $W_t=g_tWg_t^{\mathsf T}$ the value $\theta$ is constant, so $Q(W_t)=\theta W_t$ for all $t$; differentiating at $t=0$ gives $2W\circ\dot W=\theta\dot W$, and with $e=W/\theta$, $L_e\dot W=\tfrac12\dot W$. Same computation gives $L_ee=Q(e)=e$, the $1$ on $\langle W\rangle$, **which is outside $W^\perp$, so it does not compete**, and the block's restriction to $L_e\vert_{W^\perp}$ is doing real work.

The orbit's dimension is $\binom n2-\binom p2-\binom q2=pq$, matching $\dim(\mathbb R^p\otimes\mathbb R^q)$ and the source's own clause (b). So $\dim E(\tfrac12)\ge pq$ unconditionally, and the lemma's content is the reverse inequality.

### F6, Two invariant-theoretic identities confirm the whole ten-value list at once. **New here, and the strongest check in this audit.**

$\mathcal W_n$ is $O(n)$-irreducible and non-trivial (label $[2,2]$), so:

1. **$W\mapsto\operatorname{tr}(L_W\vert_{\mathcal W_n})$ is an $O(n)$-invariant linear functional on $\mathcal W_n$, hence identically zero.** (Robust to whether $Q$ preserves $\mathcal W_n$ or is followed by the projection $\pi$, either way the map is built $O(n)$-equivariantly.) Substituting the block's ten (value, multiplicity) pairs:
 $$1+\tfrac{pq}2+d_p\lambda_p+d_q\lambda_q-d_pd_q\,\mu+e_pe_q\,\mu\;=\;0\quad\text{identically in }p,q,$$
 with $d_m=\dim S^2_0$, $e_m=\dim\Lambda^2$. Verified exactly. **This is one non-trivial linear relation the ten values satisfy on the nose.**
2. **$W\mapsto\operatorname{tr}(L_W^2\vert_{\mathcal W_n})$ is an invariant quadratic form on an irreducible, hence a multiple of $\lVert W\rVert^2$**, so $\theta^2\operatorname{tr}(L_e^2)$ must depend on $n$ alone. It does:
 $$\theta_{p,q}^2\Big(1+\tfrac{pq}4+d_p\lambda_p^2+d_q\lambda_q^2+(d_pd_q+e_pe_q)\mu^2\Big)=\frac{(n-1)(2n-1)}4,$$
 using $\theta_{p,q}^2=\frac{2(p-1)(q-1)(n-1)}{pq(n-2)}$ (Nienhaus Prop. 2.25, and $\theta_0(6)=\sqrt{10}/3$ recovers the anchor). The $p$-derivative at fixed $n$ is $0$. **And the constant is $\kappa_n=\frac{(2n-1)(n-1)}4$, the record's own "algebra's Killing constant" in [conventions.md](../findings/conventions.md)**, which the block never claims and which no arithmetic slip would produce by accident.

*(The cubic analogue is not a test: invariant cubics on $\mathcal W_n$ form a space of dimension $>1$, and $\theta^2\operatorname{tr}(L_e^3)$ is duly split-dependent. Reported so the omission is not read as a suppressed failure.)*

### F7, Test 1 supplies the value the record's own ledger records as unsourced.

[findings/LEDGER.md](../findings/LEDGER.md) line 771: *"L27 cites L26 for '$-\mu$ and $+\mu$ on the two tensor summands', where L26 supplies **one** eigenvector on $\Lambda^2\otimes\Lambda^2$ only; … the other summand's value now has no source."* Correct, [Lemma L26](../findings/nondegeneracy.md) exhibits $X=\phi_\pi\odot\phi_\rho$ with its $\Lambda^4$ part removed, which is one vector in $\Lambda^2\otimes\Lambda^2$.

**The trace identity closes that hole.** Taking the other nine values as given, $\operatorname{tr}L_e=0$ has the unique solution
$$\text{value on }S^2_0\otimes S^2_0=\frac{1-\tfrac p2-\tfrac q2}{(p-1)(q-1)}=-\frac{n-2}{2(p-1)(q-1)}=-\mu .$$
Solved, not assumed. The same identity, run the other way with $\pm\mu$ given, forces $\lambda_m=\frac{m-2}{2(m-1)}$ uniquely: if $f$ and $\tilde f$ both satisfied $d_pf(p)+d_qf(q)=g(p,q)$ for all $p,q\ge3$ then $d_p(f-\tilde f)(p)=-d_q(f-\tilde f)(q)$ would be a constant equal to its own negative, hence $0$. **So the block's $\lambda_m$ is derived here rather than taken on trust.**

### F8, The largest of the rest, and "attained exactly". **Confirmed.**

On $W^\perp$ the nine remaining values are $\tfrac12$ (orbit), $\lambda_p$, $\lambda_q$, $+\mu$, $-\mu$, and four zeros.

- $\lambda_m=\frac{m-2}{2(m-1)}<\tfrac12$ for every $m$, since $m-2<m-1$. No hypothesis needed.
- $\tfrac12-\mu=\frac{(p-1)(q-1)-(n-2)}{2(p-1)(q-1)}=\frac{pq-2p-2q+3}{2(p-1)(q-1)}=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$, the block's own numerator, re-expanded and confirmed. For $p,q\ge3$ this is $>0$ except at $(3,3)$, where it is $0$.
- $-\mu<0$ and the zeros are $<\tfrac12$.

So $\lambda_{\max}(L_e\vert_{W^\perp})=\tfrac12$ with the eigenspace exactly $\mathbb R^p\otimes\mathbb R^q$, of dimension $pq=\dim(\text{orbit})$. **Nothing ties.** The four zero summands matter here (if any secretly carried $\tfrac12$ the claim would fall) and they are pinned three ways: the block's index computation, the trace identity above, and the recorded spectra of F10 whose zero multiplicities match $\dim\mathcal W_p+\dim\mathcal W_q+q\dim X_p+p\dim X_q$ exactly.

### F9, The two boundaries. **Both confirmed, and $p=2$ fails for a second reason the block does not state here.**

**$(3,3)$.** $\mu=\frac{6-2}{2\cdot2\cdot2}=\tfrac12$ exactly, on $\Lambda^2(\mathbb R^3)\otimes\Lambda^2(\mathbb R^3)$ of dimension $3\times3=9$; the orbit is $pq=9$. So $\dim E(\tfrac12)=9+9=18$ against an orbit of $9$, **the record's figure, derived here from the ten values as the brief asked.** The excess sits on $\Lambda^2\otimes\Lambda^2$ (dimension $9$), not on $S^2_0\otimes S^2_0$ (dimension $25$), which is a third independent fix on the sign assignment of F11, and it agrees with [second-order.md](../findings/second-order.md) line 637's count of $\binom32^2=9$ four-subsets of $(2,2)$-split type.

**$p=2$.** Two independent failures.
1. *The eigenvalue.* $\tfrac12-\mu=\frac{(0)(q-2)-1}{2(q-1)}=-\frac1{2(q-1)}<0$, so $\mu>\tfrac12$ and $\lambda_{\max}>\tfrac12$. $S^2\times S^q$ is then not a local maximum.
2. *The decomposition itself.* $\dim\mathcal W_2=\frac{2(-1)(3)(4)}{12}=-2$, the formula returns a **negative** number, so the identity of F1 cannot be an identity of dimensions at $p=2$. The true $\mathcal W_2=0$, so the ten summands over-count by exactly $2$. At $(2,4)$: $1+0+10+8+2+9+18+6+0+32=86$ against $\dim\mathcal W_6=84$. *This matches what the record already records* at [second-order.md](../findings/second-order.md) lines 720 and 785 ("$86$ against $84$ at $S^2\times S^4$"), so the arithmetic is cross-checked rather than merely mine.

Note the two failures are logically separate: the eigenvalue statement survives (L26's eigenvector is exhibited directly and needs no decomposition), while the *summand route* to an upper bound does not reach $p=2$ at all. **The hypothesis $p,q\ge3$ is load-bearing for the decomposition, and $(p,q)\ne(3,3)$ for the strict inequality.** Both are correctly stated.

### F10, The five recorded spectra reproduce exactly from the ten values.

Reconstructing $\sigma(L_e)$ from the block's ten (value, dimension) pairs and comparing with the table at [findings/nondegeneracy.md](../findings/nondegeneracy.md) lines 680–685:

| split | reconstructed | recorded | |
| --- | --- | --- | --- |
| $3{+}5$ | $-\tfrac38^{70},0^{165},\tfrac14^{5},\tfrac38^{44},\tfrac12^{15},1^{1}$ | identical | ✓ |
| $4{+}4$ | $-\tfrac13^{81},0^{148},\tfrac13^{54},\tfrac12^{16},1^{1}$ | identical | ✓ |
| $3{+}7$ | $-\tfrac13^{135},0^{518},\tfrac14^{5},\tfrac13^{63},\tfrac5{12}^{27},\tfrac12^{21},1^{1}$ | identical | ✓ |
| $4{+}6$ | $-\tfrac4{15}^{180},0^{446},\tfrac4{15}^{90},\tfrac13^{9},\tfrac25^{20},\tfrac12^{24},1^{1}$ | identical | ✓ |
| $5{+}5$ | $-\tfrac14^{196},0^{420},\tfrac14^{100},\tfrac38^{28},\tfrac12^{25},1^{1}$ | identical | ✓ |

Every multiplicity, including the fusions ($\tfrac38^{44}=14+30$ at $(3,5)$, $\tfrac13^{54}=18+36$ at $(4,4)$), and every total against $\dim\mathcal W_8=300$, $\dim\mathcal W_{10}=770$.

### F11, DEFECT, outside the block: [findings/nondegeneracy.md](../findings/nondegeneracy.md) line 686 reverses the $\pm\mu$ assignment.

> "the eigenvalues are $\pm\mu$ at multiplicities $s_ps_q$ and $c_pc_q$", with $s_m=\tfrac{(m+2)(m-1)}2$, $c_m=\tfrac{m(m-1)}2$.

$s_m=\dim S^2_0(\mathbb R^m)$ and $c_m=\dim\Lambda^2(\mathbb R^m)$, so read in order this puts $+\mu$ on $S^2_0\otimes S^2_0$ and $-\mu$ on $\Lambda^2\otimes\Lambda^2$, **the opposite of Lemma L27 and of this same file's line 715** ("$-\mu$ on $S^2_0\otimes S^2_0$; $+\mu$ on $\Lambda^2\otimes\Lambda^2$"). This is a contradiction below the block, in the block's own file, of exactly the kind the brief warned about.

**The block is right and line 686 is wrong**, on three independent grounds:

1. The trace identity of F6 gives $0$ under the block's assignment and $\frac{(n-2)(n+2)}2$ under line 686's, $16$ at $(3,3)$, $30$ at $(4,4)$. It **discriminates**, and it selects the block.
2. The $(3,3)$ excess is $9$, which is $\dim(\Lambda^2\otimes\Lambda^2)$, not $25=\dim(S^2_0\otimes S^2_0)$.
3. [Lemma L127](../findings/second-order.md)'s $\mathcal D_n$ row (line 735) independently carries $(-\mu)^{(p-1)(q-1)}$ on the diagonal locus, which meets $S^2_0\otimes S^2_0$.

Line 686 is a compressed restatement in a survey passage, not a load-bearing derivation, and no citation was found taking it. **Recommended fix**: write "$+\mu$ at multiplicity $c_pc_q$ and $-\mu$ at $s_ps_q$", or name the summands as line 715 does. *Recorded, not applied, this reviewer does not edit the record.*

### F12, The 58 citations. **Sampled; none takes a strengthening.**

45 mentions of L27 across [findings/](../findings/), [results.md](../results.md), [plan.md](../plan.md) and [routes.md](../routes.md). The load-bearing ones:

| site | what it takes | verdict |
| --- | --- | --- |
| [Lemma L3](../findings/second-order.md) line 39 | "$\lambda_{\max}=\tfrac12$ attained exactly on the orbit tangent for $p,q\ge3$, $(p,q)\ne(3,3)$", at $p=q=n/2\ge4$ | inside range; $(4,4)\ne(3,3)$ ✓ |
| same, line 41 | $n=6$ is the case L27 refuses | ✓, correctly excluded |
| [Lemma L69](../findings/graded-half.md) via line 754 | nondegeneracy at every $p,q\ge3$, $(p,q)\ne(3,3)$; flagship $S^5\times S^7$ | inside range ✓ |
| [Lemma L127](../findings/second-order.md) line 735, 741 | the $\mathcal D_n$ spectrum from L27's summands; explicitly says it is a refinement, not a replacement | ✓, and its $-\mu$ corroborates F11 |
| [Corollary L128.1](../findings/second-order.md) line 785 | "assume $p,q\ge3$ … at $p=2$ it over-counts, $86$ against $84$" | ✓, states the boundary correctly |
| [Lemma L133](../findings/second-order.md) line 894 | "$\lambda_{\max}=\tfrac12$ attained exactly", covering every $n=2m\ge12$ | inside range ✓ |
| [second-order.md](../findings/second-order.md) line 720 | *declines* to use L27 at $p=2$, citing the over-count | ✓ correct restraint |
| [second-order.md](../findings/second-order.md) line 1168 | smallest off-orbit margin is the $+\mu$ one, $3\theta_0\frac{m-3}{2(m-1)}$, zero at $m=3$ | ✓, equals $3\theta_0(\tfrac12-\mu)$ at $p=q=m$, recomputed here |
| [second-order.md](../findings/second-order.md) line 1103 | $L_e$ scalar $\lambda_m$ on the two $S^2_0(\mathbb R^m)$ summands | ✓ |

The **one** thing worth flagging is not a strengthening of L27 but a live correction sitting on top of it: [nondegeneracy.md](../findings/nondegeneracy.md) line 740 records that the *spectral* second-largest eigenvalue is $\lambda_{\max(p,q)}$, giving gap $\frac1{2(M-1)}$, and **not** $\tfrac12-\mu$, except at $(3,4)$, where $\mu=\tfrac5{12}$ overtakes $\lambda_4=\tfrac13$ ([r527](REVIEW_r527.md)). Recomputed here: for $p=3$, $\mu>\lambda_q\iff q<5$, with equality at $q=5$; for $p,q\ge4$, $\mu\le\lambda_M$ with equality only at $(4,4)$. **L27's own conclusion is untouched** (it needs only $\max(\lambda_M,\mu)<\tfrac12$, which holds throughout) but any consumer that spends the *margin* must take the line-740 quantity. That is already flagged in the record and is not a defect of this block.

### F13, Residual, named rather than left implicit

The block's sentence *"The multiplicity-freeness at $p,q\le4$, asserted rather than proved in the source, is supplied by exact $O(m)$-commutant computation at $m=3,4$"* is the only place the proof of L27 rests on a computation. **F3 removes that dependence**: distinctness of admissible Young labels gives multiplicity-freeness at every $p,q\ge3$ by representation theory alone, given the source's irreducibility clause. Adopting that argument would make L27 fully analytic. *Nothing here needs a run to settle.*

---

## VERDICT: CONFIRMED

**Lemma L27 is correct as stated, and its hypotheses are exactly the right ones.** Every step was rederived cold: the dimension identity closes exactly; the source says what the block says it says (checked in the record's notes and its text extraction, no PDF); the decomposition is multiplicity-free including at $p=q$; the Schur conclusion holds; the orbit's $\tfrac12$ follows from criticality alone; $\lambda_m<\tfrac12$ always and $\mu<\tfrac12$ exactly off $(3,3)$ in the range $p,q\ge3$; and $\dim E(\tfrac12)=pq=\dim(\text{orbit})$. Two invariant-theoretic trace identities, which the block does not use, confirm the entire ten-value list simultaneously and reproduce $\kappa_n$.

Three things to carry back, none of which touches the verdict:

- **A defect in a later passage of the same file**, [findings/nondegeneracy.md](../findings/nondegeneracy.md) line 686, which reverses which tensor summand carries $+\mu$ (F11). Three independent arguments settle it in the block's favour.
- **A wording defect inside the block**, "since $L_e$ is symmetric the $\mathbb C$ and $\mathbb H$ Schur cases cannot occur" (F4). Symmetry does not exclude those cases; it makes them harmless. The conclusion stands and the correct one-line reason is given.
- **A gap the record itself flagged is now closed**: the value $-\mu$ on $S^2_0\otimes S^2_0$, which [LEDGER.md](../findings/LEDGER.md) line 771 records as having no source, is forced by $\operatorname{tr}L_e=0$ (F7), as is $\lambda_m$.

Because L27 stands, [Lemma L3](../findings/second-order.md) and [Lemma L69](../findings/graded-half.md) keep the support they take from it; both cite it inside its stated range.
