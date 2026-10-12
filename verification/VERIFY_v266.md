# Verifier v266, Lemma L64 (the transfer mechanism over the signed permutation groups), its hypothesis $n\ge n_0\ge k_B$, the "FALSE for $SO(n)$" remark, the certificate sentence, and L64.lean

The brief ([BRIEF_L64.md](BRIEF_L64.md)) was read cold. No numerical work was done: no scripts, no runs, no builds, and every value below is exact. Log: [agent_logs/verify-L64-v266.log](../agent_logs/verify-L64-v266.log).

| # | Claim | Verdict |
|---|---|---|
| C1 | Passage C: "$k_B$ the presentation degree of the sequence $\{B_n\}$ of signed permutation groups" names a well-defined number | REFUTED AS STATED |
| C2 | The hypothesis $n_0\ge k_B$ is satisfiable: $k_B$ is finite for the module the statement needs | HYPOTHESIS-DEBT |
| C3 | Step (i): the first fundamental theorem spans the $O(n)$-invariants by contraction diagrams at every dimension | CONFIRMED |
| C4 | Step (ii): each diagram restricts correctly under zero-padding, no free $\delta$-loop being available | CONFIRMED |
| C5 | Step (iii): Proposition 2.9 forces the unique $B_n$-invariant extension to be the diagram lift | CONFIRMED AS ALGEBRA |
| C6 | Lemma L64 as a conditional, with $k_B$ read as the presentation degree $k(d)$ of the degree-$d$ module | CONFIRMED |
| C7 | Passage A: "It is an $O(n)$ statement and is FALSE for $SO(n)$, $\epsilon$-diagrams being neither dimension-free nor padding-compatible" | REFUTED AS STATED |
| C8 | Passage C: "The mechanism is what would carry a certificate from $n_0$ to every larger $n$" | HYPOTHESIS-DEBT |
| C9 | L64.lean: the typed theorems hold (the file does not state L64) | CONFIRMED AS ALGEBRA |
| C10 | L64.lean lines 49-51: "The six-block object is degree 12 or more, not 6" | REFUTED AS STATED |

**Summary.** The three-step proof is correct algebra once $k_B$ is read as the presentation degree of $\mathrm{Sym}^d\mathcal W$ for the degree $d$ of $F$, and it uses that hypothesis only for uniqueness. The statement names $k_B$ as a degree of a group sequence, no argument on file makes it finite, the $SO(n)$ remark is false as stated, the certificate sentence has no argument, and the Lean file types arithmetic only.

**Overall verdict: PROVEN (hypotheses corrected).**

## 0. Conventions, fixed once

- $V=\mathbb R^n$ with the standard inner product. $\mathcal W_n\subset V^{\otimes4}$ is the space of algebraic Weyl tensors (curvature symmetries, first Bianchi identity, zero Ricci contraction). Zero-padding $\iota:\mathcal W_{n_0}\hookrightarrow\mathcal W_n$ is an isometry: a padded tensor keeps the curvature symmetries, and its Ricci contraction over $[n]$ equals the one over $[n_0]$, padded, so it is still trace-free.
- $B_n$ is the group of signed permutation matrices, embedded in $B_{n+1}$ as fixing $e_{n+1}$. $V_0=\{\mathbb R^n\}$ is the base consistent sequence of the paper's Example 1.5 and 2.8.
- A form of degree $d$ on $\mathcal W_n$ is identified with a symmetric tensor $T\in\mathrm{Sym}^d\mathcal W_n$ by $F_T(x)=\langle T,x^{\otimes d}\rangle$. For $x\in\mathcal W_{n_0}$, $\langle T,x^{\otimes d}\rangle=\langle P^{\otimes d}T,x^{\otimes d}\rangle$ with $P$ the orthogonal projection onto $\mathcal W_{n_0}$. So **restriction of forms is the paper's projection $P_{U_{n_0}}$** on $U=\mathrm{Sym}^d\mathcal W$, and "extension of $F$" means a preimage under it.
- $U^{(d)}:=\{\mathrm{Sym}^d\mathcal W_n\}$ with padding embeddings. $k(d)$ denotes its presentation degree over $V_0$ with $G_n=B_n$ (Definition 2.7), and $g(d)$ its generation degree (Definition 2.2).
- For a perfect matching $\pi$ of the $4d$ slots of $x^{\otimes d}$, $C^{(n)}_\pi(x)$ is the complete contraction of $x^{\otimes d}$ along $\pi$ with indices summed over $[n]$.
- Sources read: [paper txt](https://arxiv.org/abs/2307.04230) lines 248-275 (Definitions 1.3, 1.4), 793-806 (Section 1.3, induction), 866-1050 (Definition 2.2 through Theorem 2.11), 2775-2800 (the $O_n$ example), 2826-2840 (Section 7). The Lean file [L64.lean](../lean/HamiltonsCubic/Results/L64.lean) in full. Passages A to D were checked against the cited lines only (fence-posts 197-203, 215-225, 227, 241, results 224, 763, 765) and match verbatim. Passage E matches the Lean file (the brief's block adds one trailing blank line, so the file has 91 lines, not 92, and file line = brief line minus 41).

## 1. Hypothesis inventory

| Hypothesis | Where | Used by | Satisfiable |
|---|---|---|---|
| $F$ is an $O(n_0)$-invariant form on $\mathcal W_{n_0}$ | statement | step (i) | yes ($F=\lvert W\rvert^2$) |
| $F$ homogeneous of a degree $d$ | implicit in "form" | step (iii), through $k(d)$ | yes, but $d$ is never bound in the statement |
| $n\ge n_0$ | statement | steps (ii), (iii) | yes |
| $n_0\ge k_B$ | statement | step (iii) only | unknown, see C2 |
| "where presentation degrees exist" | Passages A, B | nothing checks it | it is the finiteness in C2, stated as a hedge |
| FFT for $O(n)$: $(V^{\otimes 2m})^{O(n)}$ is spanned by the pairing tensors, for every $n\ge1$ | imported, unfiled | step (i) | classical, holds for every $n$ |
| $U^{(d)}$ is a consistent sequence (Definition 1.3) | used, unstated | step (iii) | yes: $\mathrm{Sym}^d\iota$ is a $B_n$-equivariant isometry |
| $U^{(d)}$ is a $V_0$-module (Definition 2.5) | used, unstated | step (iii) | yes: $H_{n,m}$ for $V_0$ is the copy of $B_{n-m}$ on the last $n-m$ coordinates, which fixes every padded element of $\mathrm{Sym}^d\mathcal W_m$ |
| $U^{(d)}$ presented in degree $k\le n_0$ (Proposition 2.9) | imported, filed | step (iii) | unknown, see C2 |
| Lift coefficients $a_\pi$ independent of $n$ | used, unstated | steps (ii), (iii) | yes, by construction (see C4) |

Every hypothesis of Proposition 2.9 was read at source (txt lines 950-966) and checked against $U^{(d)}$ above. The only one not known to hold is "presented in degree $k$".

## 2. Quantifiers and scope

The statement that the proof supports is: for each $d\ge1$, for each $n_0\ge k(d)$, for each $F\in(\mathrm{Sym}^d\mathcal W_{n_0}^*)^{O(n_0)}$, and for each $n\ge n_0$, the unique $B_n$-invariant $G$ on $\mathcal W_n$ with $G|_{\mathcal W_{n_0}}=F$ is $O(n)$-invariant. The module is $U^{(d)}$ over $V_0$, the group sequence is $\{B_n\}$, and the degree is that of $F$. Passages B and C bind none of $d$, the module or the base, see C1.

## 3. C1, what $k_B$ names

**Record.** Passage C, results.md line 765: "with $k_B$ the presentation degree of the sequence $\{B_n\}$ of signed permutation groups". Passage B, line 224: "Over the sequence of signed permutation groups $B_n$, where presentation degrees exist". (The brief's item 6 attributes "presentation degree of the sequence $\{B_n\}$" to Passage B. The phrase is in Passage C. Passage B has the plural hedge.)

**Source.** Definition 2.7 (txt 923-927) attaches the presentation degree to a $V$-module $U$ over a base consistent sequence $V$ of representations. A sequence of groups carries no such number. Remark 2.10 (txt 979-983) says the number depends on the base through its centralizing subgroups.

**Three-step record.**

1. *Location.* results.md line 765 as quoted.
2. *Failure, exhibited.* (a) The degree matters. For $U^{(d)}$ over $V_0$ with $B_n$, take the Weyl tensor $R\in\mathcal W_4$ whose only nonzero components are those with four distinct indices, $R_{1234}=1$, $R_{1342}=-1$, $R_{1423}=0$, extended by the curvature symmetries. Bianchi holds since $1-1+0=0$, and every Ricci component $\sum_a R_{abad}$ has a repeated index, so $\mathrm{Ric}=0$. Place $d$ copies on disjoint $4$-subsets of $[4d]$ and symmetrise. The result lies in $\mathrm{Sym}^d\mathcal W_{4d}$ and has a nonzero coefficient on a monomial $e_{i_1}\otimes\dots\otimes e_{i_{4d}}$ with all $4d$ indices distinct. Every element of $B_{4d}\cdot\mathrm{Sym}^d\mathcal W_{4d-1}$ is supported on $4d-1$ coordinates, so its coefficient on every such monomial is zero, and so is that of their span. Hence $g(d)\ge4d$, and $k(d)\ge g(d)\ge 4d$ by the note after Definition 2.7. No single number serves every $d$. (b) The base matters. With base $\mathcal W$ in place of $V_0$, the centralizing subgroup $H_{n,m}$ contains $(-I_m)\oplus I_{n-m}$, since each component of a $4$-tensor on $[m]$ picks up $(-1)^4=1$. That element is outside the $V_0$ centralizer $B_{n-m}$. By Remark 2.10 the two bases define presentation degrees through different subgroups.
3. *Charitable reading.* The paper itself writes "the presentation degree of the sequence" for a consistent sequence of representations (txt 267-268), and the intended object is plainly $k(d)$ for $U^{(d)}$. Under that reading the lemma is correct (C6), and Proposition 2.9 applies over any base for which $U^{(d)}$ is a module, so the base ambiguity does not affect truth. The reading is not in the text: it supplies $d$, the module and the base, which Passage C names as a property of a group sequence.

**Verdict: REFUTED AS STATED.** The correction is a statement edit, "$k_B=k(d)$, the presentation degree of the $V_0$-module $\mathrm{Sym}^d\mathcal W$ over $\{B_n\}$, $d$ the degree of $F$". The Lean file's own docstring at line 59-61 makes the same point ("a bare $k_B$ names nothing").

## 4. C2, finiteness of $k(d)$

**What would have to be proved.** That $U^{(d)}$ over $V_0$ with $\{B_n\}$ admits an algebraically free $V_0$-module $F$ generated in finite degree and a surjective morphism $F\to U^{(d)}$ whose kernel is generated in finite degree (Definition 2.7), for the degree $d$ in use.

**What is on file.** Passage C calls whether $k_B$ reaches $12$ "a separate, open question". Passage D, post F32, gives only lower bounds ($k\ge 4\cdot6$ at $d=6$), and states that Theorem 2.11's calculus "yields no $k_B$ here at all" because its images-and-kernels clause needs the adjoint to be a morphism. Theorem 2.11 (txt 1033-1045) confirms that clause's hypothesis. The paper's own $O_n$ example (txt 2794-2796) guarantees a unique $B_n$-invariant extension only for description spaces built from $\{\mathbb R^n\}$ by the Theorem 2.11 operations, and $\mathcal W$ is a Weyl projection, which is not among them with a morphism adjoint. No instance $n_0\ge k(d)$ for any $d\ge1$ is on file.

**Given Passage D, post F30.** F30 concerns modules over $\{O_n\}$. L64 runs over the finite groups $B_n$, where Definition 2.6 induction has finite index, so F30 does not obstruct Definition 2.7 here. F30's closing clause ("run over a finite subgroup sequence and bridge back") describes exactly L64's route.

**Verdict: HYPOTHESIS-DEBT.** If $k(d)=\infty$ for the degree in use, L64 is vacuous there.

## 5. C3, step (i)

**Derivation.** Let $F$ be an $O(n_0)$-invariant form of degree $d$ on $\mathcal W_{n_0}$ and let $P_{n_0}:V^{\otimes4}\to\mathcal W_{n_0}$ be the $O(n_0)$-equivariant orthogonal projection. The multilinear form $\Phi(y_1,\dots,y_d)=\tilde F(P_{n_0}y_1,\dots,P_{n_0}y_d)$, $\tilde F$ the polarization, is an $O(n_0)$-invariant element of $(V^{\otimes4d})^*$. By the FFT for $O(n_0)$ it is a combination $\sum_\pi a_\pi\,\delta_\pi$ of pairing tensors. On $x^{\otimes d}$ with $x\in\mathcal W_{n_0}$, $P_{n_0}x=x$, so $F(x)=\sum_\pi a_\pi C^{(n_0)}_\pi(x)$. The same argument holds at every $n$.

**Import.** The FFT is classical and unfiled. The exact form needed: for every $n\ge1$ and every $m$, $((\mathbb R^n)^{\otimes2m})^{O(n)}$ is spanned by the pairing tensors, and $(\mathbb R^n)^{\otimes\mathrm{odd}}$ has no nonzero $O(n)$-invariant. The spanning statement is dimension-uniform, while the linear relations among the $\delta_\pi$ (second fundamental theorem) depend on $n$. The proof uses only spanning.

**Verdict: CONFIRMED.** It uses no $k_B$.

## 6. C4, step (ii)

**Derivation.** Fix the coefficients $a_\pi$ of section 5 and set $G=\sum_\pi a_\pi C^{(n)}_\pi$ on $\mathcal W_n$. Each $C^{(n)}_\pi$ is $O(n)$-invariant. For $x\in\mathcal W_{n_0}$ padded, every component of $\iota x$ with an index above $n_0$ vanishes. Every one of the $4d$ summation slots sits on a factor $\iota x$, since $\pi$ matches slots of $x^{\otimes d}$ with each other and a closed $\delta$-loop with no tensor factor (which would contribute a factor $n$) does not occur. So the sum over $[n]$ reduces to the sum over $[n_0]$, and $C^{(n)}_\pi(\iota x)=C^{(n_0)}_\pi(x)$. Hence $G|_{\mathcal W_{n_0}}=F$.

**Unstated but used.** The coefficients $a_\pi$ must be independent of $n$. A lift written with $n$-dependent coefficients, such as the $1/n$ that trace removal produces, breaks the restriction identity. Post F32 records exactly this ($J_1=I_1+I_2/n$ against $J_2=I_1+I_2/24$). Passage A's "that lift" reads naturally as the fixed-coefficient lift, and the derivation above uses it.

**Verdict: CONFIRMED.** It uses no $k_B$.

## 7. C5, step (iii), and existence against uniqueness

**Derivation.** Assume $U^{(d)}$ presented in degree $k\le n_0$. Proposition 2.9 gives that $P_{U_m}:U_{m+1}^{B_{m+1}}\to U_m^{B_m}$ is an isomorphism for each $m\ge k$. Composing from $m=n-1$ down to $m=n_0$, restriction $(\mathrm{Sym}^d\mathcal W_n^*)^{B_n}\to(\mathrm{Sym}^d\mathcal W_{n_0}^*)^{B_{n_0}}$ is an isomorphism. $F$ is $O(n_0)$-invariant, so $B_{n_0}$-invariant, and it has exactly one $B_n$-invariant extension. The lift $G$ of section 6 is $O(n)$-invariant, hence $B_n$-invariant, and restricts to $F$. So the unique extension is $G$, which is $O(n)$-invariant.

**What the hypothesis adds.** Steps (i) and (ii) already give an $O(n)$-invariant lift at every $n\ge n_0\ge1$ with no hypothesis. The hypothesis enters only in step (iii), and there only through **injectivity** of the composite restriction, which makes every $B_n$-invariant extension equal $G$. Surjectivity of Proposition 2.9 is not used. Injectivity at each step $m\ge g(d)$ is already the content of Proposition 2.3 (txt 876-893). So the argument as written uses less than it assumes, and $n_0\ge g(d)$ would carry it. That is a remark on the hypothesis inventory, not part of the verdict, and finiteness of $g(d)$ is itself asserted on file (F32, "generated in degree exactly $4$") without an argument in the quoted passages.

**The boundary object showing some bound is needed.** At $n_0=3$, $\mathcal W_3=\{0\}$ (classical), so $F=0$ is an $O(3)$-invariant form of degree $2$. At $n=4$, both $0$ and $\lvert W\rvert^2$ are $O(4)$-invariant, hence $B_4$-invariant, forms on $\mathcal W_4$ restricting to $F$, and $\lvert W\rvert^2\ne0$ because $\mathcal W_4$ contains the nonzero tensor $R$ of section 3. So at $n_0=3$ the $B_4$-invariant extension is **not unique**, and the lemma's "the unique extension" presupposes a lower bound on $n_0$. This is consistent with $k(2)\ge g(2)\ge8>3$.

**Verdict: CONFIRMED AS ALGEBRA**, conditional on C2.

## 8. C6, the lemma as a conditional

Sections 5 to 7 give the conclusion for every $d$, $n_0\ge k(d)$, $F$ and $n\ge n_0$. Edges: at $n=n_0$ the extension is $F$ itself and the claim is the hypothesis. At $n_0<k(d)$ the lemma asserts nothing, and section 7's object shows uniqueness can fail there. The degree $d$ is the degree of $F$, and a non-homogeneous $F$ would need $n_0\ge\max k(d)$ over the degrees present, which "form" excludes. The $O(n)$ restriction is carried by Passages B and C, which say "$O(n_0)$-invariant" and "$O(n)$-invariant".

**Verdict: CONFIRMED** with $k_B$ read as $k(d)$.

## 9. C7, "FALSE for $SO(n)$"

**Argued?** Passage A gives one clause, "$\epsilon$-diagrams being neither dimension-free nor padding-compatible". No object is named and no derivation follows.

**Three-step record.**

1. *Location.* fence-posts.md line 241: "**It is an $O(n)$ statement and is FALSE for $SO(n)$**, $\epsilon$-diagrams being neither dimension-free nor padding-compatible".
2. *Failure, exhibited.* The $SO(n)$ version reads: the unique $B_n$-invariant extension of an $SO(n_0)$-invariant is $SO(n)$-invariant. Let $F$ be $SO(n_0)$-invariant and suppose it has a $B_n$-invariant extension $G$. $B_{n_0}\subset B_n$ preserves $\mathcal W_{n_0}$ and its orthogonal complement, so $F=G|_{\mathcal W_{n_0}}$ is $B_{n_0}$-invariant. The reflection $r=\mathrm{diag}(-1,1,\dots,1)$ lies in $B_{n_0}$ and $O(n_0)=SO(n_0)\cup r\,SO(n_0)$, so $F$ is $O(n_0)$-invariant. L64 (C6) then makes $G$ $O(n)$-invariant, so $SO(n)$-invariant. Hence **no object falsifies the $SO(n)$ conclusion**: whenever the extension exists it is $SO(n)$-invariant. For odd $n_0$ the two versions coincide outright, since $-I\in O(n_0)\setminus SO(n_0)$ acts trivially on $V^{\otimes4d}$. The $SO(n)$ version fails only in **existence**, for even $n_0$. The exact object is $n_0=4$, $d=2$, $F(W)=\langle W,{*W}\rangle$, which is $SO(4)$-invariant, a positive multiple of $\lvert W^+\rvert^2-\lvert W^-\rvert^2$ (classical), nonzero on any nonzero self-dual $W$, and negated by $r$. So $F$ is not $B_4$-invariant and has no $B_n$-invariant extension at all.
3. *Charitable reading.* "FALSE for $SO(n)$" may mean only that the hypothesis "$O(n_0)$-invariant" cannot be weakened to "$SO(n_0)$-invariant". That reading is true for even $n_0$, by the object above. It is false for odd $n_0$, and the stated mechanism is not the one that operates: the failure is that $F$ is not $B_{n_0}$-invariant, which involves no padding of $\epsilon$-diagrams.

**Verdict: REFUTED AS STATED.** The conclusion transfers for $SO(n)$ whenever it has content, and the reason given is not an argument. Passages B and C do not carry the $SO(n)$ remark, and they do carry the $O(n)$ restriction, so the canon is unaffected.

## 10. C8, "would carry a certificate"

**Record.** Passage C, line 765: "The mechanism is what would carry a certificate from $n_0$ to every larger $n$".

**What the lemma transfers.** An element ($F\mapsto G$) and the predicate "$O(n)$-invariant". A certificate is an inequality $G\ge0$ on $\mathcal W_n$, or an identity $G=\sum_i q_i^2$ with $q_i$ on $\mathcal W_n$. Nothing in steps (i) to (iii) addresses either. $F\ge0$ on $\mathcal W_{n_0}$ controls $G$ only on $\mathcal W_{n_0}$ and its $O(n)$-orbit, and that orbit has dimension at most $\dim\mathcal W_{n_0}+\dim O(n)-\dim(O(n_0)\times O(n-n_0))$, which is below $\dim\mathcal W_n$ once $n$ is large, so pointwise positivity on $\mathcal W_n$ does not follow from it. An SOS identity at $n_0$ lifts only if each $q_i$ extends compatibly and $\sum_i\tilde q_i^2$ restricts to $\sum_i q_i^2$, which concerns covariants, not the invariants L64 treats.

**What would have to be proved.** That the unique extension of a nonnegative (or SOS-certified) $O(n_0)$-invariant is nonnegative (or SOS) on $\mathcal W_n$, for the $n_0\ge k(d)$ in use, for instance by a compatible lift of the certificate's covariant factors.

**Falsifier sought.** A nonnegative $F$ at an $n_0\ge k(d)$ whose extension is negative somewhere on $\mathcal W_n$. No closed-form instance exists on file or was constructed, and none can be placed under a verified instance of the hypothesis while C2 is open. The Lean theorem transfer_not_order (negation on $\mathbb Q$) concerns a different map and falsifies nothing about this one.

**Verdict: HYPOTHESIS-DEBT.** The "would" makes the sentence a claim of mechanism, and no argument for it is on file.

## 11. C9 and C10, the Lean file

**What it types.** Nat arithmetic closed by decide (4·6=24, 12<24, 6·4=24, 2·6=12, 2·6<6·4, 24=2·12), the omega lemma "24 ≤ 2d implies 12 ≤ d", two lemmas about an arbitrary strictly increasing $k:\mathbb N\to\mathbb N$ (consecutive values differ, and the range is unbounded, via $d\le k(d)$ by induction), transfer_not_order (negation on $\mathbb Q$ preserves the predicate True and sends $1\ge0$ to $-1<0$), and conditional_of_free ($Q$ implies $P\to Q$). Each proof term was read and each is correct. Nothing mentions $\mathcal W_n$, $B_n$, $O(n)$, a presentation degree, an extension or an invariant. The hypothesis hmono is satisfiable ($k(d)=4d$), and strict monotonicity of the actual $k(d)$ is not on file (only $k(d)\ge4d$, which alone gives unboundedness).

**C9 verdict: CONFIRMED AS ALGEBRA. L64.lean neither states nor proves Lemma L64**, and its module docstring says the representation theory "stays imported".

**C10, three-step record.**

1. *Location.* L64.lean lines 49-51: "a support-`24` invariant needs `2d ≥ 24`, so `d ≥ 12`. The six-block object is degree `12` or more, not `6`, which is the quantitative form of the correction."
2. *Failure, exhibited.* The six-block object of post F32 is the symmetrised product of six copies of the tensor $R$ of section 3 on disjoint $4$-subsets of $[24]$. It lies in $\mathrm{Sym}^6\mathcal W_{24}$, so its degree is exactly $6$, and its support is $24$. It is not $B_{24}$-invariant: flipping $e_1$ negates its coefficient on the all-distinct monomial. The even-multiplicity cap (support at most $2d$) holds for $B_n$-invariants, where every coordinate index has even multiplicity because sign flips kill odd-multiplicity coefficients, and it does not apply to this generator.
3. *Charitable reading.* The sentence before it speaks of "a support-24 invariant", for which $d\ge12$ is correct. The sentence at issue names "the six-block object", which F32 defines as the degree-$6$ generator, so the charitable reading has to rename the object.

**C10 verdict: REFUTED AS STATED**, a docstring error. The typed theorem support_forces_degree is true and does not depend on it.

## 12. Withdrawn candidates

- **Passage D, F30: "no nonzero module over $\{O_n\}$ has a finite presentation degree".** (1) fence-posts.md line 201. (2) With $d=0$, $H_{n,0}=O(n)$ and $G_0$ trivial, so Definition 2.6 induction has index $1$, and the constant trivial sequence $U_n=\mathbb R$ is algebraically free and presented in degree $0$. (3) Withdrawn: Definition 1.3 indexes by $n\in\mathbb N$ and the paper fixes no convention on file that $0\in\mathbb N$, the charitable reading "nonzero module with a nontrivial generator in positive degree" makes F30 correct, and L64 does not use F30.
- **Step (ii) uses a lift with $n$-dependent coefficients.** (1) Passage A, "that lift". (2) A lift using trace-removal coefficients $1/n$ would not restrict to $F$. (3) Withdrawn: "that lift" refers back to the diagrams of step (i) with their coefficients, and section 6 shows the fixed-coefficient lift works.
- **Proposition 2.9 needs $U$ to be a $V$-module and the record never checks it.** (1) Passage A, step (iii). (2) Definition 2.5 requires $U_m\subseteq U_n^{H_{n,m}}$. (3) Withdrawn: it holds, section 1 row "$U^{(d)}$ is a $V_0$-module". Recorded there as used but unstated.
- **A $B_4$-invariant extension of $F=0$ at $n_0=3$ that is not $O(4)$-invariant, $Q(W)=\sum_{i,j,k,l\ \mathrm{distinct}}W_{ijkl}^2$.** (1) Section 7, boundary. (2) $Q$ is $B_4$-invariant, positive on $R$, and zero on a Weyl tensor with only $\{i,j,i,j\}$-type components. (3) Withdrawn: (2) shows $Q$ is not a multiple of $\lvert W\rvert^2$, but concluding that $Q$ is not $O(4)$-invariant needs the import that every $O(4)$-invariant quadratic on $\mathcal W_4$ is a multiple of $\lvert W\rvert^2$, and that import is unfiled. Non-uniqueness at $n_0=3$ is established by $0$ against $\lvert W\rvert^2$, and that suffices for the boundary point.

## 13. Falsifiers named and what was done

| Claim | Falsifying object | Search |
|---|---|---|
| C1 | a single number serving every $d$ | exhibited $k(d)\ge4d$ and the base-dependent centralizer $(-I_m)\oplus I_{n-m}$ |
| C2 | a finite presentation of $U^{(d)}$, or proof none exists | read Definitions 2.6, 2.7, Theorem 2.11 and the $O_n$ example at source, and the record's passages. Neither is on file |
| C3 | an $O(n)$-invariant form on $\mathcal W_n$ outside the span of complete contractions | none possible under the FFT |
| C4 | a matching with a free $\delta$-loop, or a component of $\iota x$ with index above $n_0$ that survives | none: every slot sits on a factor $\iota x$ |
| C5 | a second $B_n$-invariant extension for $n_0\ge k(d)$ | excluded by Proposition 2.9, read with its proof. At $n_0=3$ one exists ($0$ against $\lvert W\rvert^2$) |
| C7 | an $SO(n_0)$-invariant with a $B_n$-invariant extension that is not $SO(n)$-invariant | proved none exists via $r\in B_{n_0}$. Existence fails at $n_0=4$ for $\langle W,{*W}\rangle$ |
| C8 | a nonnegative $F$ at $n_0\ge k(d)$ with an extension negative somewhere | none constructible while C2 is open |
| C9 | a false typed theorem | read every proof term |
| C10 | a degree-$6$ element of support $24$ | the six-block generator, exhibited |

## Overall verdict

**PROVEN (hypotheses corrected).** The corrected hypothesis is: $d$ the degree of $F$, and $n\ge n_0\ge k(d)$ with $k(d)$ the presentation degree of the $\{\mathbb R^n\}$-module $\mathrm{Sym}^d\mathcal W$ over $\{B_n\}$. Its finiteness is HYPOTHESIS-DEBT (C2), so the lemma may be vacuous at every degree. The "FALSE for $SO(n)$" remark is refuted as stated (C7), the certificate sentence is HYPOTHESIS-DEBT (C8), and L64.lean types arithmetic only, with one false docstring sentence (C10).
