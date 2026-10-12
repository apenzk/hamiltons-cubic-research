# Verifier v267, Lemma L64 (the transfer mechanism over signed permutation groups), its SO(n) scope remark, its k_B hypothesis, and the Lean file

The brief ([BRIEF_L64.md](BRIEF_L64.md)) was read cold. No numerical work was done, every value below is exact, and no script was written or run. Log: [agent_logs/verify-L64-v267.log](../agent_logs/verify-L64-v267.log).

| # | Claim | Verdict |
|---|---|---|
| C1 | Passage A/B/C: for $n\ge n_0\ge k_B$, the unique $B_n$-invariant extension of an $O(n_0)$-invariant form is $O(n)$-invariant, by steps (i) FFT, (ii) padding, (iii) Proposition 2.9 | CONFIRMED |
| C2 | The hypothesis $n_0\ge k_B$ as typed: "the presentation degree of the sequence $\{B_n\}$" (Passages B, C) | GAP |
| C3 | The hypothesis is satisfiable: a finite $k_B$ exists for the module the statement needs | HYPOTHESIS-DEBT |
| C4 | Passage A: "It is an $O(n)$ statement and is FALSE for $SO(n)$" | REFUTED AS STATED |
| C5 | Passage C: "whether $k_B$ is small enough to reach $n=12$ is a separate, open question" (for the degree-6 certificate of Passage D) | REFUTED AS STATED |
| C6 | Passage C: "The mechanism is what would carry a certificate from $n_0$ to every larger $n$" | HYPOTHESIS-DEBT |
| C7 | Passage E: the Lean file states or proves L64 | REFUTED |
| C8 | Passage E: the arithmetic the Lean file does type | CONFIRMED AS ALGEBRA |

**Summary:** the implication of L64 is correct and its proof is sound once $k_B$ is typed as the presentation degree of $\mathrm{Sym}^d\mathcal W$ over $\{B_n\}$, the hypothesis enters only through injectivity, the SO(n) remark is wrong in the lemma's own range, Passage C calls open a question the record's own generation-degree fact already settles negatively at $d=6$, and no finite $k_B$ is on file.

## 0. Conventions, fixed once

- $V^0=\{\mathbb R^n\}$ with zero-padding, $G_n=B_n$ acting by signed permutation matrices, as in the source's Example 2.8 ([txt.txt](https://arxiv.org/abs/2307.04230) lines 929-947).
- $\mathcal W_n\subset(\mathbb R^n)^{\otimes4}$ is the space of algebraic Weyl tensors (Riemann symmetries, first Bianchi identity, every trace zero), with the inner product restricted from $(\mathbb R^n)^{\otimes4}$. Zero-padding sends $\mathcal W_{n_0}$ into $\mathcal W_n$: a padded tensor keeps its symmetries, and each Ricci entry $\sum_{i\le n}W_{iaib}$ is either a sum over $i\le n_0$ (zero) or has an index beyond $n_0$ (zero).
- A form of degree $d$ on $\mathcal W_n$ is an element of $U_n:=\mathrm{Sym}^d(\mathcal W_n)$, read as the polynomial $p_T(x)=\langle T,x^{\otimes d}\rangle$. For $x\in\mathcal W_{n_0}$, $\langle T,x^{\otimes d}\rangle=\langle P_{U_{n_0}}T,x^{\otimes d}\rangle$, so the source's orthogonal projection $P_{U_{n_0}}$ is restriction of the polynomial. "Extension of $F$" therefore means an element of $U_n^{B_n}$ whose restriction to $\mathcal W_{n_0}$ is $F$, which is Definition 1.4's sense.
- $k_B(d)$ denotes the presentation degree (source Definition 2.7, lines 923-928) of the $V^0$-module $U=\mathrm{Sym}^d\mathcal W$ over $\{B_n\}$. $d_B(d)$ denotes its generation degree (Definition 2.2, lines 860-864).
- "Finite sequence $\{B_n\}$" in Passage A is read as "sequence of finite groups".
- FFT for $O(n)$ (classical, unfiled): for every $n$ and every $N$, the $O(n)$-invariant multilinear forms on $(\mathbb R^n)^{\otimes N}$ are spanned by products of $\delta$ over perfect matchings of the $N$ slots (zero if $N$ is odd). FFT for $SO(n)$ (classical, unfiled): the same span plus, when $n\le N$ and $N-n$ is even, products of one $\epsilon$ on $n$ slots with a $\delta$-matching of the rest.

## Hypothesis inventory

| Hypothesis | Source | Used where | Stated? | Satisfiable? |
|---|---|---|---|---|
| $\{B_n\}$ compact, $B_n\subseteq B_{n+1}$ | Definition 1.3 (lines 248-257) | Proposition 2.9 | implicit | yes |
| $\mathcal W$ a consistent sequence (orthogonal rep, equivariant isometric inclusions) | Definition 1.3 | Proposition 2.9 | no | yes, Section 0 |
| $\mathcal W$ and $\mathrm{Sym}^d\mathcal W$ are $V^0$-modules: $U_m\subseteq U_n^{H_{n,m}}$ | Definition 2.5 (lines 909-911), closure under Sym (line 1022) | Proposition 2.9 | no | yes: $H_{n,m}$ fixes $e_1,\dots,e_m$, so it fixes every tensor with all indices in $[m]$ |
| $U$ presented in degree $k$, finite | Definition 2.7, Proposition 2.9 (lines 950-977) | step (iii) | as "$n_0\ge k_B$", "where presentation degrees exist" | no finite instance on file (C3) |
| $F$ is $O(n_0)$-invariant of a fixed degree $d$ | statement | step (i) | $O(n_0)$ yes, $d$ no | yes |
| FFT for $O(n)$, the form in Section 0 | classical, unfiled | step (i), at $n_0$ only | named, not filed | classical, holds for all $n$ |
| Intra-factor contractions of a Weyl tensor vanish | Weyl tracelessness and antisymmetry | step (ii) | "every slot sits on a Weyl factor" | yes |
| $n\ge n_0$ | statement | step (iii) composite | yes | yes |

**What the argument actually uses of $k_B$.** Step (iii) needs only that the composite projection $U_n^{B_n}\to U_{n_0}^{B_{n_0}}$ is injective. Existence of a preimage of $F$ is supplied by steps (i) and (ii). The source's Proposition 2.3 (lines 866-887) gives that injectivity at every $n\ge n_0\ge d_B(d)$, and Definition 2.7's note (line 928) gives $k_B(d)\ge d_B(d)$. So the hypothesis as written is stronger than what the argument uses, which is a remark on scope and no defect.

## 1. C1, the transfer mechanism: CONFIRMED

Statement checked, with the typing of C2: fix $d\ge1$ and let $k=k_B(d)<\infty$. For $n\ge n_0\ge k$ and $F\in U_{n_0}^{O(n_0)}$, the unique $L\in U_n^{B_n}$ with $L|_{\mathcal W_{n_0}}=F$ is $O(n)$-invariant.

**Step (i).** Let $\pi_{n_0}:(\mathbb R^{n_0})^{\otimes4}\to\mathcal W_{n_0}$ be the orthogonal projection, which is $O(n_0)$-equivariant because $\mathcal W_{n_0}$ is an $O(n_0)$-subrepresentation. Then $F\circ\pi_{n_0}$ is an $O(n_0)$-invariant degree-$d$ polynomial on $(\mathbb R^{n_0})^{\otimes4}$, and its polarisation is an $O(n_0)$-invariant multilinear form on $((\mathbb R^{n_0})^{\otimes4})^{\otimes d}$. By the FFT it is a combination of $\delta$-matchings of the $4d$ slots. Evaluating at $W\in\mathcal W_{n_0}$, where $\pi_{n_0}W=W$, gives $F=\sum_\Gamma c_\Gamma\Gamma_{n_0}$ with $\Gamma_{n_0}(W)$ a complete contraction of $d$ copies of $W$. The projector never enters the diagram, so no $n$-dependent coefficient from trace removal appears. The step follows. It imports the FFT in the form of Section 0, used at $n_0$ only. It does not use $k_B$.

**Step (ii).** A matching of the $4d$ slots contains no closed $\delta$-loop, because every slot is a slot of some $W$, so $\Gamma_n(W)=\sum_{\text{indices in }[n]}\prod W_{\cdots}$ with every summation index attached to Weyl entries. For $W$ padded from $\mathcal W_{n_0}$ every entry with an index above $n_0$ vanishes, so $\Gamma_n|_{\mathcal W_{n_0}}=\Gamma_{n_0}$. Each $\Gamma_n$ is $O(n)$-invariant because $\delta$ is. The step follows, is elementary, and does not use $k_B$.

**Existence.** $L':=\sum_\Gamma c_\Gamma\Gamma_n$ is $O(n)$-invariant, hence $B_n$-invariant, and $L'|_{\mathcal W_{n_0}}=F$ by (ii).

**Step (iii).** Proposition 2.9, read at source, applies: $V^0$ is a consistent sequence of $\{B_n\}$-representations, $U$ is a $V^0$-module presented in degree $k$, so $P_{U_m}:U_{m+1}^{B_{m+1}}\to U_m^{B_m}$ is an isomorphism for every $m\ge k$. Composing for $m=n_0,\dots,n-1$, the restriction $U_n^{B_n}\to U_{n_0}^{B_{n_0}}$ is injective. Hence $L=L'$, which is $O(n)$-invariant. The step follows, and it is the only one that uses $k_B$. It also resolves the one ambiguity of (i): the coefficients $c_\Gamma$ are not unique at $n_0$ (relations among diagrams), and injectivity makes $L'$ independent of the choice.

**Edge $n=n_0$.** The extension is $F$ itself and the claim is the hypothesis. No finding.

**Edge $n_0<k_B$ (the hypothesis is load-bearing).** Take $d=2$, $n_0=3$, $n=4$. Then $\mathcal W_3=0$ (algebraic Weyl tensors vanish for $n\le3$), so $F=0$, and $n_0=3<4\le d_B(2)\le k_B(2)$ because $\mathcal W_4\ne0$ cannot lie in the span of translates of $\mathcal W_3=0$. The forms $0$, $|W|^2$ and $G(W)=\sum_{i,j}W_{ijij}^2$ are all $B_4$-invariant extensions of $F$ ($G$ is $B_4$-invariant because each index appears an even number of times in $W_{ijij}$ and a permutation relabels the sum). $G$ is not $O(4)$-invariant: the degree-2 contractions of $W\otimes W$ reduce by the Riemann symmetries to $\pm|W|^2$ and $\pm W_{abcd}W_{acbd}=\pm\tfrac12|W|^2$, so an $O(4)$-invariant $G$ would equal $c|W|^2$. The Weyl tensor $T_1$ with $W_{1213}=1$, $W_{4243}=-1$ (and symmetry images, all other components zero) has $G(T_1)=0$ and $|T_1|^2>0$, forcing $c=0$. The Weyl tensor $T_2$ with $W_{1212}=W_{3434}=1$, $W_{1313}=W_{2424}=-1$ has $G(T_2)=8$. Both are verified Weyl by hand: the Bianchi sums on index multisets $\{1,1,2,3\}$ and $\{1,1,2,2\}$ are $0+(-1)+1$ and $0+(-1)+1$, and the only Ricci entries touched are $\mathrm{Ric}_{23}=1-1$ for $T_1$ and $\mathrm{Ric}_{aa}=1-1$ for $T_2$. So below the threshold uniqueness fails and a non-$O(n)$ extension exists. This is outside the lemma's range and is recorded as a check of the edge, with no finding against C1.

## 2. C2, what $k_B$ is: GAP

**Location.** Passage C: "with $k_B$ the presentation degree of the sequence $\{B_n\}$ of signed permutation groups". Passage B: "Over the sequence of signed permutation groups $B_n$, where presentation degrees exist". Passage A: "where presentation degrees exist".

**Failure.** Definition 2.7 (lines 923-927) defines a presentation degree for a $V$-module $U$ over a consistent sequence $V$ of $\{G_n\}$-representations. A group sequence has none. The statement also never names $d$, and $k_B$ depends on it: $d_B(d)\ge4d$ (Section 5), so $k_B(d)\ge4d$ grows without bound.

**Charitable reading.** $k_B$ means $k_B(d)$ for the module $\mathrm{Sym}^d\mathcal W$ over $V^0=\{\mathbb R^n\}$, $G_n=B_n$, with $d=\deg F$. Under that reading C1 is proved (Section 1). The candidate "the lemma is false" is therefore withdrawn, and what stands is a typing gap in the canonical statement: the correct hypothesis is $n_0\ge k_B(\deg F)$ with the module named.

## 3. C3, satisfiability of the hypothesis: HYPOTHESIS-DEBT

- **Which sequence.** The statement runs over $\{B_n\}$, a sequence of finite groups, so Section 1.3's finite-index restriction (line 796) and Definition 2.6 are met, and post F30's objection (Passage D) does not reach it. The lemma is the "run over a finite subgroup sequence and bridge back" route that F30 names, with the FFT as the bridge.
- **Finiteness.** Nothing in the brief exhibits a finite $k_B(d)$ for any $d\ge1$. Post F32 gives only lower bounds, and states that Theorem 2.11's image and kernel clause does not apply (the Weyl projector carries $\delta$ trace terms, so it is not a morphism of sequences). The generation degree $d_B(1)=4$ is asserted in F32 by "a coordinate-support argument" that the brief does not display.
- **What would have to be proved.** That $\mathcal W$ is finitely generated over $\{B_n\}$ and that $\mathrm{Sym}^d\mathcal W$ is presented in some explicit finite degree $k$, either by a presentation of $\mathcal W$ over $\{B_n\}$ fed into Theorem 2.11's Sym clause (lines 1040-1042), or by an imported Noetherianity theorem for $B_n$-type sequences, filed and checked against this module.
- **Weaker form.** Section 1's inventory shows the proof needs only $n_0\ge d_B(d)$, so finite generation alone would give a satisfiable instance of the corrected statement. That also is not on file in the brief.

## 4. C4, "FALSE for $SO(n)$": REFUTED AS STATED

**Location.** Passage A: "It is an $O(n)$ statement and is FALSE for $SO(n)$, $\epsilon$-diagrams being neither dimension-free nor padding-compatible". No object is exhibited and no further argument is given.

**Failure, in closed form.** Fix $d$ and work in the lemma's range $n\ge n_0\ge k_B(d)\ge d_B(d)\ge4d$ (Section 5 for the last inequality). For any $m\ge4d$ the $SO(m)$-invariant forms of degree $d$ on $\mathcal W_m$ equal the $O(m)$-invariant ones. By the $SO(m)$ FFT applied to $F\circ\pi_m$ as in step (i), an extra term needs $\epsilon$ on $m$ of the $4d$ slots, so for $m>4d$ none exists. At $m=4d$ the $\epsilon$ takes every slot, each $W$ contributes four slots to it, and the contraction antisymmetrises each $W$ over all four indices, where $W_{[abcd]}=0$ by the first Bianchi identity. So every $\epsilon$-diagram vanishes and the $SO(n)$ version of L64 is word for word the $O(n)$ version, which C1 proves. The object that would make the claim true, an $SO(n_0)$-invariant degree-$d$ form at $n_0\ge k_B(d)$ that is not $O(n_0)$-invariant, does not exist.

**Charitable reading.** The remark may mean that the proof's step (i) does not transfer verbatim to $SO(n)$ where $\epsilon$-diagrams are nonzero, which is true for $n_0<4d$. That range is excluded by the hypothesis, so the reading does not rescue "FALSE for $SO(n)$" as a statement about L64. Impact: none on the record's use, which is $O(12)$, and Passages B and C already carry $O(n)$ throughout, so the canonised statement is correct on this point. The sentence should be deleted or replaced by "the $SO(n)$ version coincides with it in this range".

## 5. C5, "whether $k_B$ is small enough to reach $n=12$ is open": REFUTED AS STATED

**Location.** Passage C, last sentence. The certificate degree is $6$ (Passage D, F32: "The certificate is degree $6$").

**Failure, in closed form.** $d_B(d)\ge4d$ for every $d\ge1$. Let $T_3\in\mathcal W_4$ have $W_{1234}=1$, $W_{1342}=-1$, $W_{1423}=0$ with all Riemann-symmetry images, every other component zero. Its only Bianchi sum is $1-1+0=0$, and it is traceless because each Ricci entry $\sum_iW_{iaib}$ involves a repeated index, whose components are zero. Let $T_3^{(k)}$ be its copy on coordinates $4k-3,\dots,4k$ in $\mathcal W_{4d}$ and $y=T_3^{(1)}\cdots T_3^{(d)}\in U_{4d}=\mathrm{Sym}^d\mathcal W_{4d}$. The component of $y$ at the multi-index $(1,2,3,4,5,\dots,4d)$ is $1/d!\ne0$, since only the identity arrangement places each block's indices on its own factor. For $m<4d$, every element of $R[B_{4d}]U_m$ has all nonzero components indexed inside some $m$-subset (a signed permutation moves supports to supports of the same size), so its component at a multi-index with $4d$ distinct values is zero. Hence $y\notin R[B_{4d}]U_m$, $U$ is not generated in degree $m$, and $d_B(d)\ge4d$. With Definition 2.7's note, $k_B(6)\ge d_B(6)\ge24>12$. This agrees with F32's own headline "$k_B\ge4\cdot6=24>12$".

**Charitable reading.** Passage C may intend a question about whether transfer of some kind reaches $12$ by a weaker route. Its words are "whether $k_B$ is small enough", and for the degree-6 certificate that is settled: L64 as stated never applies with $n_0\le12$. Even the weaker hypothesis of Section 1's inventory, $n_0\ge d_B(6)$, excludes $12$. F32's closing claim that "24 is removed as a proved lower bound on the base, for either route" is consistent only if "base" means where Proposition 2.9's consequent holds, and for L64's hypothesis $24$ is a proved lower bound.

## 6. C6, "would carry a certificate": HYPOTHESIS-DEBT

- **What C1 carries.** An element: $F\mapsto L$, with $O(n)$-invariance. It says nothing about the values of $L$ on $\mathcal W_n\setminus O(n)\cdot\mathcal W_{n_0}$, so nonnegativity, a sum-of-squares identity with a PSD Gram matrix, or any inequality is not transported by the lemma. A linear identity among invariants does lift (injectivity makes lifting linear), a cone membership needs more.
- **Charitable reading.** "is what would carry" is modal and may name a necessary ingredient only. Read as sufficiency it has no argument on file.
- **What would have to be proved.** That the certificate's positivity data lift, for instance compatibility of the cone sequence in the sense of Theorem 3.5(a),(b) of the source, or a direct argument that $L\ge0$ on $\mathcal W_n$ whenever $F\ge0$ on $\mathcal W_{n_0}$ for the forms in question.
- **Search for a falsifier.** A nonnegative $F$ whose lift is negative somewhere. At $d=2$ the $O(n)$-invariants are $\mathbb R|W|^2$ for every $n\ge4$ (Section 1's reduction), so positivity transfers. At $d=3$ every form is odd, so a nonnegative cubic is $0$. No closed-form falsifier was found at $d\ge4$, and none is claimed.

## 7. C7 and C8, the Lean file

**C7: REFUTED.** The file [L64.lean](../lean/HamiltonsCubic/Results/L64.lean) (identical to Passage E) imports no representation theory and types no $\mathcal W_n$, $B_n$, $O(n)$, projection or extension. It neither states nor proves L64. Its docstring says so: "The representation theory stays imported; the counting is here".

**C8: CONFIRMED AS ALGEBRA.** What it types, each proof closing by decide, omega or norm_num: $4\cdot6=24$, $12<24$, $6\cdot4=24$, $2\cdot6=12$, $2\cdot6<6\cdot4$, $24\le2d\Rightarrow12\le d$, $24=2\cdot12$, a strictly increasing $k:\mathbb N\to\mathbb N$ has $k(d)\ne k(d+1)$ and is unbounded, negation on $\mathbb Q$ preserves the trivial predicate while reversing $0\le x$, and $Q\Rightarrow(P\to Q)$. All are true as typed. The monotonicity of $k_B(d)$ is a hypothesis of indexed_not_scalar and unbounded, not a proved fact about $k_B$.

Docstring readings checked (no finding survives, see 7.1).

### 7.1 Withdrawn candidates

- **Candidate W1, support_forces_degree docstring.** Location: "The six-block object is degree $12$ or more, not $6$." Exhibit: the six-block product $y$ of Section 5 at $d=6$ lies in $\mathrm{Sym}^6\mathcal W_{24}$, degree $6$, support $24$, so a six-block object of degree $6$ exists. Charitable reading: the even-multiplicity cap concerns $B_n$-invariants (F32: "a $B_n$-invariant of degree $d$ has support $\le2d$"), and $y$ is a generator, not an invariant, so "the six-block object" read as a support-24 invariant needs degree $\ge12$, which the theorem types correctly. Withdrawn: the docstring is ambiguous rather than false, and it is outside L64's statement.
- **Candidate W2, unbounded docstring.** Location: "no lower bound can ever supply a satisfiable instance: for every $N$ some degree exceeds it". Exhibit: for fixed $d$, a finite $k(d)$ gives the satisfiable instance $n_0=k(d)$, and unboundedness in $d$ does not bear on it. Charitable reading: a lower bound on $k$ never yields an upper bound, hence never exhibits an instance, which is true. Withdrawn.
- **Candidate W3, "the lemma is false because $k_B$ is undefined".** Withdrawn under the charitable reading of Section 2, recorded there as a GAP in the statement.
- **Candidate W4, "Passages B and C drop the $O(n)$ restriction".** Location: Passage A's "the condition belongs in the statement". Both canonical passages read "$O(n_0)$-invariant ... is $O(n)$-invariant". Withdrawn at step (1): nothing is missing.
- **Candidate W5, "the uniqueness in step (iii) has no filed source".** Proposition 2.9 was read at source (lines 950-977) and its hypotheses hold for $\mathrm{Sym}^d\mathcal W$ over $\{B_n\}$ given finite $k$. Withdrawn.

## 8. The standing list, item by item

1. **Hypothesis inventory.** Section "Hypothesis inventory". Used but unstated: the degree $d$, the module $\mathrm{Sym}^d\mathcal W$, the $V$-module property, the FFT's exact form. Satisfiability of finite $k_B(d)$: HYPOTHESIS-DEBT (C3).
2. **Quantifier order and scope.** $\forall d\ \forall n_0\ge k_B(d)\ \forall F\in U_{n_0}^{O(n_0)}\ \forall n\ge n_0$, module $\mathrm{Sym}^d\mathcal W$ over $V^0=\{\mathbb R^n\}$, group sequence $\{B_n\}$. The canonical statement omits $d$ and the module (C2).
3. **Edges.** $n=n_0$: trivial, no finding. $n_0<k_B$: uniqueness fails and a non-$O(4)$ extension exists at $n_0=3$, $n=4$, $d=2$ (Section 1), outside the lemma's range. $SO(n)$ against $O(n)$: coincide in range (C4).
4. **Proven against stated or used.** Proven: C1 under $n_0\ge k_B(d)$, and in fact under $n_0\ge d_B(d)$. Stated beyond proof: "FALSE for $SO(n)$" (C4), "open" at $12$ (C5), certificate carrying (C6). Used: the record's $n=12$, $d=6$ use lies outside the hypothesis (C5).
5. **Lean.** Neither states nor proves L64 (C7).
6. **What to attack.** (1) C2, C3, Section 5. (2) Section 1: (i) follows, imports FFT, no $k_B$; (ii) follows, elementary, no $k_B$; (iii) follows, imports Proposition 2.9 read at source, the only use of $k_B$, and only injectivity is used. (3) Existence is unconditional from (i) and (ii). The hypothesis adds uniqueness only, and Section 1's $n_0=3$ edge shows uniqueness genuinely fails without it. (4) C4, and W4 for the canonical passages. (5) C6: an element, never an inequality. (6) C2: Passage B/C's "presentation degree of the sequence $\{B_n\}$" is ill-typed against Definition 2.7 and against F30/F32's use for modules. (7) C7, C8. (8) Edges above. The degree $d$ is unfixed in the statement and $k_B(d)\ge4d$.
7. **Falsifiers and search.** C1: a $B_n$-invariant $L$, $n\ge n_0\ge k_B(d)$, restricting to an $O(n_0)$-invariant but not $O(n)$-invariant, excluded by the proof. C3: a $d$ with $\mathrm{Sym}^d\mathcal W$ not finitely presented over $\{B_n\}$, not sought beyond noting none is on file. C4: an $SO(n_0)$-but-not-$O(n_0)$ invariant at $n_0\ge k_B(d)$, shown not to exist. C5: a finite $k_B(6)\le12$, shown impossible by $y$. C6: a nonnegative $F$ with a negative lift, none at $d=2,3$ by structure, none sought numerically.

## Overall verdict

**PROVEN (hypotheses corrected).** The mechanism holds with $k_B$ corrected to $k_B(\deg F)$, the presentation degree of $\mathrm{Sym}^{\deg F}\mathcal W$ over $\{B_n\}$ (and $n_0\ge d_B(\deg F)$ already suffices). Separately: the $SO(n)$ remark is refuted in range, Passage C's "open" is refuted at $d=6$ by $k_B(6)\ge24$, finiteness of $k_B$ and certificate carrying are HYPOTHESIS-DEBT, and the Lean file does not state the lemma.
