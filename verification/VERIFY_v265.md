# Verifier v265, Lemma L64: the hypothesis n_0 ≥ k_B, proof steps (i) to (iii), the SO(n) scope remark, the certificate sentence, and the Lean file

Cold brief ([BRIEF_L64.md](BRIEF_L64.md)). No numerical work: no scripts were written or run, and every value below is exact and derived by hand. Quotations were checked against their cited lines only. The imported results were read at source in [references/levin-chandrasekaran-dimension-free/](../references/levin-chandrasekaran-dimension-free/) (text extraction [txt.txt](https://arxiv.org/abs/2307.04230)). Log: [agent_logs/verify-L64-v265.log](../agent_logs/verify-L64-v265.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | The hypothesis $n_0\ge k_B$, with $k_B$ "the presentation degree of the sequence $\{B_n\}$" (Passages B, C), names a defined quantity | GAP |
| 2 | $k_B$ is finite for the module the statement needs, with an instance on file (and, at the record's use, $12\ge k_B$) | HYPOTHESIS-DEBT |
| 3 | Step (i): the first fundamental theorem spans the $O(n)$-invariant forms on $\mathcal W_n$ by contraction diagrams at every $n$ | CONFIRMED |
| 4 | Step (ii): each diagram restricts correctly under zero-padding, no free $\delta$-loop being available | CONFIRMED |
| 5 | Step (iii): Proposition 2.9 forces the unique $B_n$-invariant extension to be the diagram lift | CONFIRMED |
| 6 | Existence against uniqueness: steps (i), (ii) give an $O(n)$-invariant extension with no hypothesis, and $n_0\ge k_B$ adds only uniqueness | CONFIRMED |
| 7 | "It is an $O(n)$ statement and is FALSE for $SO(n)$" (Passage A) | REFUTED |
| 8 | "The mechanism is what would carry a certificate from $n_0$ to every larger $n$" (Passage C) | GAP |
| 9 | The Lean file states or proves L64 | REFUTED |

**Summary.** The written chain (i) to (iii) is correct once $k_B$ is read as the presentation degree of the $\mathcal V$-module $\mathrm{Sym}^d(\mathcal W)$ over $B_n$ with base $\{\mathbb R^n\}$, for the degree $d$ of $F$. Finiteness of that degree has no argument on file, the $SO(n)$ remark is false, the certificate sentence overreaches, and the Lean file types arithmetic only.

**Overall verdict: PROVEN (hypotheses corrected).**

## 0. Conventions, fixed once

- $G_n=B_n$, the signed permutation matrices, embedded $B_n\subset B_{n+1}$ by $g\mapsto\mathrm{blkdiag}(g,1)$ (source, Example 1.5).
- $\mathcal V=\{\mathbb R^n\}$ with zero-padding, the base consistent sequence. Its centralizing subgroups $H_{n,m}$ are the signed permutations fixing $e_1,\dots,e_m$ (source, Example 2.8).
- $\mathcal W_n\subset(\mathbb R^n)^{\otimes4}$ is the space of algebraic Weyl tensors, embedded in $\mathcal W_{n+1}$ by zero-padding, with the Frobenius inner product.
- $d$ is the degree of the homogeneous form $F$. $U^{(d)}=\{U^{(d)}_n\}=\{\mathrm{Sym}^d(\mathcal W_n)\}$, identified with degree-$d$ forms on $\mathcal W_n$ through $T\mapsto(x\mapsto\langle T,x^{\otimes d}\rangle)$.
- $k(d)$ is the presentation degree of $U^{(d)}$ as a $\mathcal V$-module over $\{B_n\}$ (source, Definition 2.7). $\rho_{n,n_0}$ is restriction of forms from $\mathcal W_n$ to the padded copy of $\mathcal W_{n_0}$.
- A contraction diagram $D$ of degree $d$ is a perfect matching of the $4d$ slots of $d$ copies of $W$. $D_n(W)=\sum_{i\in[n]^{2d}}\prod W_{\cdots}$ with matched slots carrying equal indices.
- $r=\mathrm{diag}(-1,1,\dots,1)\in B_{n_0}$, a reflection with $\det r=-1$.

**Projection is restriction.** Padding $\iota:\mathcal W_{n_0}\to\mathcal W_n$ is an isometry, so the orthogonal projection $P$ of $\mathrm{Sym}^d\mathcal W_n$ onto $\mathrm{Sym}^d\mathcal W_{n_0}$ is $(\iota^{\otimes d})^*$, and $\langle PT,x^{\otimes d}\rangle=\langle T,\iota(x)^{\otimes d}\rangle$. So the source's maps $P_{U_n}$ are $\rho_{n+1,n}$ on forms, and "extension" in L64 means a preimage under $\rho_{n,n_0}$. The record leaves this identification unstated. It holds.

## Hypothesis inventory

| Hypothesis | Where stated | Used by | Satisfiable |
|---|---|---|---|
| H1. $G_n=B_n$ acting on $\mathcal W_n$ with zero-padding, forming a consistent sequence and a $\mathcal V$-module | Passage C names zero-padding, and the module structure is unstated | Step (iii), to invoke Proposition 2.9 | Yes. Padding preserves the algebraic Bianchi identity and every trace (the added components are zero), and is a $B_n$-equivariant isometry. $H_{n,m}$ fixes $e_1,\dots,e_m$, so it fixes every padded element of $\mathcal W_m$, which is Definition 2.5. |
| H2. $F$ is $O(n_0)$-invariant, homogeneous of degree $d$ | Passage C ("form"), with the degree unstated everywhere | Step (i) at $n_0$ | Yes, $F=\lvert W\rvert^2$ |
| H3. $n\ge n_0$ | All passages | Step (ii) | Yes |
| H4. $n_0\ge k_B$ with $k_B$ finite | All passages. B and C call $k_B$ a degree "of the sequence $\{B_n\}$" | Step (iii) only, and only through injectivity of $\rho_{n,n_0}$ on $B_n$-invariants | No instance on file (Section 2) |
| H5 (unstated). $B_{n_0}\subset O(n_0)$, so $F\in (U^{(d)}_{n_0})^{B_{n_0}}$ | Nowhere | Step (iii), to place $F$ in Proposition 2.9's codomain | Yes, trivially |
| I1. First fundamental theorem for $O(n)$ (classical, unfiled) | Passage A, C | Step (i) | Holds for every $n\ge1$ over $\mathbb R$ |
| I2 (unstated). Surjectivity of restriction of invariants from $\mathrm{Sym}^d((\mathbb R^n)^{\otimes4})^*$ to $\mathrm{Sym}^d(\mathcal W_n)^*$, from complete reducibility of the compact group $O(n)$ | Nowhere | Step (i), to pass from invariants of the ambient tensor space to invariants of the subrepresentation $\mathcal W_n$ | Holds (Reynolds operator) |
| I3. Proposition 2.9 of Levin and Chandrasekaran: $\mathcal V$ consistent, $U$ a $\mathcal V$-module presented in degree $k$, then $P_{U_n}:U_{n+1}^{G_{n+1}}\to U_n^{G_n}$ is an isomorphism for all $n\ge k$ | Passage A ("projection isomorphism") | Step (iii) | Its hypotheses are H1 and H4. H1 holds. H4 is the open item. |

**The argument uses less than H4.** Step (iii) needs only that $\rho_{n,n_0}$ is injective on $B_n$-invariants, because existence of an extension is supplied by steps (i), (ii) (Section 6). At source, Proposition 2.3 gives injectivity of each $P_{U_m}$ on invariants for $m$ at least the generation degree. The stated hypothesis (presentation degree) is therefore stronger than what the written chain consumes. This is recorded as a fact about the hypothesis. It changes no verdict, and the generation degree of $U^{(d)}$ is itself not on file.

## 1. The hypothesis names a defined quantity (GAP)

**Derivation.** Definition 2.7 at source defines the presentation degree of a $\mathcal V$-module $U$ relative to a base consistent sequence $\mathcal V$ of $\{G_n\}$-representations. A group sequence alone carries no presentation degree. Remark 2.10 at source says the degree depends on the centralizing subgroups $\{H_{n,m}\}$ of the base, so it depends on the base as well as on $U$.

**Candidate: "the presentation degree of the sequence $\{B_n\}$" names no single number.**

1. Location. Passage C: *"with $k_B$ the presentation degree of the sequence $\{B_n\}$ of signed permutation groups"*. Passage B uses $k_B$ with no definition and the clause *"where presentation degrees exist"*.
2. Failure. Over the same group sequence $\{B_n\}$ and base $\{\mathbb R^n\}$, the module $\{\mathrm{Sym}^j\mathbb R^n\}$ has generation degree exactly $j$: the monomial $x_1x_2\cdots x_j$ has $j$ variables, signed permutations preserve the number of variables in a monomial, and a padded element of $\mathrm{Sym}^j\mathbb R^{j-1}$ is a combination of monomials in at most $j-1$ variables. Example 2.12 at source gives presentation degree $j$, so the presentation degree is exactly $j$, which takes every value $1,2,3,\dots$ over one group sequence. For the lemma's own module, Passage D bounds $k_B\ge24$ for the degree-$6$ module only. The number depends on $d$, and a $k_B$ with no $d$ is undefined.
3. Charitable reading. $k_B$ means $k(d)$, the presentation degree of $\mathrm{Sym}^d(\mathcal W)$ over $B_n$ with base $\{\mathbb R^n\}$, for the degree $d$ of $F$. Passage D's use (*"The certificate is degree $6$, so $k_B\ge 4\cdot6=24$"*) supports this. Under it the statement is well formed and the proof goes through (Sections 3 to 5). The finding survives as a defect of the statement only: the corrected hypothesis must name the module, the base and $d$. A non-homogeneous $F$ needs $n_0\ge\max_d k(d)$ over its degrees.

Passage A's *"Over the finite sequence $\{B_n\}$"* is treated in the withdrawn list.

## 2. Finiteness of $k_B$ and an instance on file (HYPOTHESIS-DEBT)

**What is on file, as quoted.**

- Passage B's *"where presentation degrees exist"* makes finiteness an explicit condition. The lemma is therefore a conditional, and proven as one.
- Passage C: *"whether $k_B$ is small enough to reach $n=12$ is a separate, open question."*
- Passage D, F32: *"$\{\mathcal W_n\}$ is generated in degree exactly $4$ over $B_n$, and a coordinate-support argument gives generation degree $4\ell$ for $\mathrm{Sym}^\ell(\mathcal W_n)$, with presentation degree at least generation degree. The certificate is degree $6$, so $k_B\ge 4\cdot6=24>12$."* The last clause (presentation degree at least generation degree) is at source, after Definition 2.7. The generation-degree claims carry a named argument ("coordinate-support") that is not written in the quoted record.
- Passage D, F32: *"Theorem 2.11's calculus yields no $k_B$ here at all"*. Theorem 2.11 at source is the only tool the reference offers for upper bounds, and F32 says it does not apply.
- Passage D, F30: the reference's machinery gives no finite presentation degree over $\{O_n\}$. At source, Section 1.3 restricts induction to finite index and Definition 2.6 builds free modules only from induction, which confirms F30's reading. L64 runs over $\{B_n\}$, which is F30's second admissible route (*"run over a finite subgroup sequence and bridge back"*). F30 is respected, and it offers no $k_B$.

**Finding.** No upper bound on $k(d)$, and no proof that $k(d)<\infty$, is on file for any $d\ge1$. What would have to be proved: that $\mathrm{Sym}^d(\mathcal W)$ is a $\mathcal V$-module over $\{B_n\}$ admitting a surjection from an algebraically free module (Definition 2.6) with both it and the kernel generated in finite degree, with an explicit bound.

**Candidate: at the record's use the hypothesis fails, which contradicts "open" and "nothing breaks".**

1. Location. Passage A: *"the record's actual use is $O(12)$, so nothing breaks"*. Passage C: *"whether $k_B$ is small enough to reach $n=12$ is a separate, open question"*. Passage D: *"$k_B\ge 4\cdot6=24>12$"*.
2. Failure. If Passage D's bound holds, then for the degree-6 certificate $n_0=12<24\le k(6)$, so the hypothesis of L64 is false at the record's use, and the question C calls open is settled negatively for $d=6$.
3. Charitable reading. Passage A's "nothing breaks" concerns only the $O$ against $SO$ restriction, so it makes no claim about $k_B$. Passage C may call the question open because Passage D's lower bound rests on an unwritten generation-degree argument. Under that reading neither sentence is false, but then no bound of either sign is proved.

The candidate is folded into this section's HYPOTHESIS-DEBT rather than reported separately: either the lower bound is proved and L64 is inapplicable at $n_0=12$, $d=6$, or it is not proved and nothing about $k(6)$ is on file. In both cases no satisfiable instance of H4 at the record's use is on file.

## 3. Step (i), spanning by contraction diagrams (CONFIRMED)

**Derivation.** A degree-$d$ form on $(\mathbb R^n)^{\otimes4}$ is the restriction to the diagonal of a multilinear form on $((\mathbb R^n)^{\otimes4})^{\otimes d}=(\mathbb R^n)^{\otimes4d}$. The first fundamental theorem for $O(n)$ (I1) says the $O(n)$-invariant multilinear forms on $(\mathbb R^n)^{\otimes m}$ are spanned by products of $\delta$ over perfect matchings of the $m$ slots, for every $n$, and are zero for odd $m$. Symmetrising over the $d$ copies preserves invariance, so the $O(n)$-invariant degree-$d$ forms on $(\mathbb R^n)^{\otimes4}$ are spanned by the $D_n$. $\mathcal W_n$ is an $O(n)$-subrepresentation, and restriction $\mathrm{Sym}^d((\mathbb R^n)^{\otimes4})^*\to\mathrm{Sym}^d(\mathcal W_n)^*$ is $O(n)$-equivariant and surjective. By averaging over the compact group (I2), the invariants surject. So the $O(n)$-invariant forms on $\mathcal W_n$ are spanned by the $D_n|_{\mathcal W_n}$ at every $n$.

**Imports and exact form needed.** I1 in its multilinear form for every $n$ (the second fundamental theorem is unused, since only spanning is claimed), and I2, which the record does not state. **Use of $k_B$: none.**

## 4. Step (ii), restriction under zero-padding (CONFIRMED)

**Derivation.** Let $W\in\mathcal W_{n_0}$ and $\iota W$ its padding, so $(\iota W)_{abcd}=0$ whenever any index exceeds $n_0$. In $D_n(\iota W)=\sum_{i}\prod_{t=1}^{d}(\iota W)_{i_{t,1}i_{t,2}i_{t,3}i_{t,4}}$, every summation index sits on exactly two slots, both on factors of $\iota W$, because the matching pairs slots of the $W$ factors with each other and nothing else. A term with any index $>n_0$ contains a vanishing factor. The surviving terms are exactly the terms of $D_{n_0}(W)$. So $D_n\circ\iota=D_{n_0}$ for every $n\ge n_0$.

A free $\delta$-loop would be a factor $\delta_{ii}$ with both slots off the $W$ factors, contributing $n$. None occurs because every slot belongs to a $W$ factor, which is Passage C's reason verbatim. The contrast in Passage D ($J_1=I_1+I_2/n$ against $J_2=I_1+I_2/24$) concerns coefficients depending on $n$, which a fixed linear combination of diagrams with constant coefficients does not have. **Use of $k_B$: none.**

## 5. Step (iii), Proposition 2.9 forces the extension (CONFIRMED)

**Derivation.** By step (i) at $n_0$, write $F=\sum_D c_D D_{n_0}$ with constants $c_D$ (a choice, possibly non-unique). Put $G_n=\sum_D c_D D_n$ on $\mathcal W_n$. Then $G_n$ is $O(n)$-invariant, hence $B_n$-invariant, and by step (ii) $\rho_{n,n_0}G_n=F$. By H5, $F$ lies in $(U^{(d)}_{n_0})^{B_{n_0}}$. With $n\ge n_0\ge k(d)$, Proposition 2.9 (read at source) makes each $P_{U_m}:(U^{(d)}_{m+1})^{B_{m+1}}\to(U^{(d)}_m)^{B_m}$, $n_0\le m<n$, an isomorphism, so the composite $\rho_{n,n_0}$ is an isomorphism on $B_n$-invariants. The unique $B_n$-invariant $E$ with $\rho_{n,n_0}E=F$ therefore equals $G_n$, and $E$ is $O(n)$-invariant. Independence from the choice of $c_D$ follows from the same uniqueness.

**Hypotheses of Proposition 2.9 against the object.** "$\mathcal V$ a consistent sequence": $\{\mathbb R^n\}$ with $B_n$, Example 1.5 at source. "$U$ a $\mathcal V$-module": H1, checked in the inventory. "Presented in degree $k$": H4, open (Section 2). **Use of $k_B$: here only, and only for injectivity.**

## 6. Existence against uniqueness (CONFIRMED)

**Derivation.** Section 5's $G_n$ uses steps (i), (ii) and nothing else. For every $n_0\ge1$ and every $n\ge n_0$, an $O(n_0)$-invariant $F$ has an $O(n)$-invariant, hence $B_n$-invariant, extension. H4 adds uniqueness, which is what gives the definite article in "the unique $B_n$-invariant extension" a referent, and it makes $G_n$ independent of the coefficient choice.

**The hypothesis does real work, exhibited below its range.** Weyl tensors vanish identically in dimension at most $3$, so $\mathcal W_3=\{0\}$. Take $n_0=3$, $d=2$, $F=0$, $n=5$. Both $0$ and $\lvert W\rvert^2$ are $O(5)$-invariant, $B_5$-invariant degree-2 forms on $\mathcal W_5\neq\{0\}$ restricting to $F$. Uniqueness fails, and so does independence of the lift from the choice $F=c\lvert W\rvert^2_{(3)}$ for any $c$. Here $n_0=3<4\le k(2)$, since $\mathcal W_3=0$ cannot generate, which is consistent with the lemma's range.

## 7. "FALSE for $SO(n)$" (REFUTED)

**The claim.** Passage A: *"It is an $O(n)$ statement and is FALSE for $SO(n)$, $\epsilon$-diagrams being neither dimension-free nor padding-compatible"*. No further argument is on file.

**Derivation of the $SO(n)$ version.** Read the statement with $SO$ in place of $O$: under H4, the unique $B_n$-invariant extension $E$ of an $SO(n_0)$-invariant $F$ is $SO(n)$-invariant.

- Suppose $E$ exists. For $b\in B_{n_0}$ embedded as $\mathrm{blkdiag}(b,I)$, padding commutes with $b$, so $F(bx)=E(\iota bx)=E(b\,\iota x)=E(\iota x)=F(x)$. So $F$ is $B_{n_0}$-invariant.
- $r\in B_{n_0}$ has $\det r=-1$, so $O(n_0)=SO(n_0)\cup SO(n_0)r$, and $F$ is $O(n_0)$-invariant.
- By L64 (Section 5), $E$ is $O(n)$-invariant, hence $SO(n)$-invariant.
- Suppose $E$ does not exist, which happens exactly when $F\circ r\neq F$. Then the statement has no instance.

So the $SO(n)$ version holds on every instance it has, under the same hypothesis. The $O(n)$ restriction is automatic once the extension is required to be $B_n$-invariant.

**Three-step record.**

1. Location: the quoted sentence of Passage A.
2. Failure: the four bullets above give a closed-form argument that the $SO(n)$ statement is true wherever it applies. What fails for $\epsilon$-invariants is existence of a $B_n$-invariant extension, and the definite article presupposes existence.
3. Charitable readings, each checked.
   - "The proof by diagrams does not extend to $\epsilon$-diagrams." That is a remark about the method, and it does not make the statement FALSE.
   - "An $SO(n_0)$-invariant need not have a $B_n$-invariant extension." That is true, but it makes the $SO(n)$ statement vacuous there, not false.
   - Replace $B_n$ by $B_n^+=B_n\cap SO(n)$. For $n>n_0$, $\mathrm{diag}(-1,1,\dots,1,-1)\in B_n^+$ (the last $-1$ in coordinate $n$) acts on padded $\mathcal W_{n_0}$ as $r$, since every component with index $n$ vanishes. A $B_n^+$-invariant extension again forces $F\circ r=F$, so the same conclusion follows.

   No reading found makes the literal "FALSE" true. The finding survives.

**Whether B and C carry the restriction.** Both are phrased with $O(n_0)$ and $O(n)$, so the restriction is carried. By the derivation it is also harmless and unnecessary.

## 8. "The mechanism is what would carry a certificate" (GAP)

**Derivation.** L64 concludes a predicate ($O(n)$-invariance) about one element $E$. A certificate at $n_0$ asserts an inequality ($F\ge0$ on $\mathcal W_{n_0}$, or a PSD Gram matrix on covariants). Restriction gives $E\ge0\Rightarrow F\ge0$ only, because $\iota\mathcal W_{n_0}\subsetneq\mathcal W_n$.

**Exhibit, same mechanism, exact values.** Take the module $\{\mathrm{Sym}^2(S^n)\}$ of quadratic forms on symmetric matrices, over $\{B_n\}$ with base $\{\mathbb R^n\}$, acting by conjugation with zero-padding.

- **Presentation degree at source.** Example 2.12 presents $S^n=\mathrm{Sym}^2\mathbb R^n$ in degree $2$. Theorem 2.11 (Sym) presents $\mathrm{Sym}^2$ of it in degree $(2-1)\cdot2+2=4$. So $k=4$ is finite, and $n_0=4$ satisfies the analogue of H4.
- **$F$ is nonnegative and SOS at $n_0=4$.** Let $F(X)=\mathrm{tr}(X^2)-\tfrac14(\mathrm{tr}X)^2$ on $S^4$. It is $O(4)$-invariant, and $F(X)=\mathrm{tr}\big((X-\tfrac14\mathrm{tr}X\,I_4)^2\big)\ge0$, since $\mathrm{tr}X^2-2\cdot\tfrac14(\mathrm{tr}X)^2+\tfrac{4}{16}(\mathrm{tr}X)^2=\mathrm{tr}X^2-\tfrac14(\mathrm{tr}X)^2$.
- **The lift.** $\mathrm{tr}(X^2)=X_{ij}X_{ji}$ and $(\mathrm{tr}X)^2=X_{ii}X_{jj}$ are projector-free diagrams with every slot on an $X$ factor. So the mechanism's unique $B_5$-invariant extension is $G_5(X)=\mathrm{tr}(X^2)-\tfrac14(\mathrm{tr}X)^2$ on $S^5$, and it is $O(5)$-invariant, exactly as L64's pattern predicts.
- **The lift is negative.** $G_5(I_5)=5-\tfrac{25}{4}=-\tfrac54<0$.

The mechanism carried the element and its invariance, and it did not carry nonnegativity or the SOS certificate. The certificate's square $\big(X-\tfrac14\mathrm{tr}X\,I\big)^2$ contains the $n_0$-specific projector, which is Passage D's $J_1/J_2$ warning in a second instance.

**Three-step record.**

1. Location. Passage C: *"The mechanism is what would carry a certificate from $n_0$ to every larger $n$"*.
2. Failure. The exhibit above: an instance of the same mechanism, with finite presentation degree read at source, lifts a certified $F\ge0$ to $G_5$ with $G_5(I_5)=-5/4$.
3. Charitable reading. "Would" marks L64 as one ingredient of a future transfer, not the whole of it. Under that reading the sentence is not false. What is missing is the other ingredient, a proof that a PSD certificate at $n_0$ (Gram matrix on covariants, built from projector-free diagrams) lifts to a PSD certificate at $n$. No such argument is on file. The finding survives as a GAP between what L64 proves (element transfer) and the use Passage C assigns it.

## 9. The Lean file (REFUTED that it states or proves L64)

**What it types.** The quoted file ([L64.lean](../lean/HamiltonsCubic/Results/L64.lean)) was checked identical to the brief's Passage E. It contains:

- natural-number identities and inequalities: $4\cdot6=24$, $12<24$, $6\cdot4=24$, $2\cdot6=12$, $2\cdot6<6\cdot4$, $24=2\cdot12$, and $24\le2d\Rightarrow12\le d$;
- two facts about an arbitrary strictly increasing $k:\mathbb N\to\mathbb N$ (consecutive values differ, and the sequence is unbounded);
- the existence of a map $\mathbb Q\to\mathbb Q$ preserving a trivially true predicate and reversing $0\le x$ (negation);
- $Q\to(P\to Q)$.

No Weyl tensor, no $B_n$, no $O(n)$, no invariant, no consistent sequence, no presentation degree and no extension appears. The file neither states nor proves L64, and none of steps (i) to (iii) is formalised.

**Secondary candidates on the file's prose.**

- *Docstring of support_forces_degree, line 91 of the file ("The six-block object is degree 12 or more, not 6").*
  1. Location: quoted.
  2. Failure. The six-block object $W_{1,2,3,4}W_{5,6,7,8}\cdots W_{21,22,23,24}$ is a product of six coordinate functionals, degree $6$ by construction. It is not $B_n$-invariant: the sign flip of $e_1$ negates the first factor and fixes the other five, so it negates the product. The even-multiplicity cap applies to invariants, so it gives no degree bound on this object.
  3. Charitable reading: "a $B_n$-invariant of support 24 has degree at least 12", which is what the theorem's statement encodes. The docstring sentence misdescribes the object. This is a note on prose. It does not bear on L64.
- *Docstring of unbounded, lines 108 to 109 of the file ("no lower bound can ever supply a satisfiable instance").*
  1. Location: quoted.
  2. Failure. The theorem proves $\forall N\,\exists d,\ N<k(d)$. For each fixed $d$, $n_0:=k(d)$ satisfies $n_0\ge k(d)$, so each instance is satisfiable. The hypothesis that $k_B$ is strictly increasing in $d$ is not on file either.
  3. Charitable reading: "no single $n_0$ serves every $d$". That is what the theorem proves. **Withdrawn** as a finding on the theorem, with a note that its premise hmono is an assumption.

## 10. The edge of every range

- **$n=n_0$.** The extension is $F$ itself, and $O(n_0)$-invariance is H2. Holds with no use of H4.
- **$n_0<k_B$.** The statement is silent. Existence of an $O(n)$-invariant extension still holds (Section 6). Uniqueness can fail, with the exact exhibit $n_0=3$, $F=0$, lifts $0$ and $\lvert W\rvert^2$ at $n=5$.
- **$SO(n)$ against $O(n)$.** Section 7: the $SO(n)$ version holds on every instance it has.
- **The degree $d$.** $k_B$ must be $k(d)$ (Section 1). For $d=0$ the statement is trivial. For non-homogeneous $F$ the hypothesis is $n_0\ge\max_d k(d)$ over its degrees.
- **Small $n_0$.** For $n_0\le3$, $\mathcal W_{n_0}=0$ and every $F$ is zero. Step (i) still holds, trivially.

## 11. Quantifier order and scope

The corrected order reads: for every $d\ge0$, if $k(d)<\infty$, then for every $n_0\ge k(d)$, every $O(n_0)$-invariant degree-$d$ form $F$ on $\mathcal W_{n_0}$ and every $n\ge n_0$, the unique $B_n$-invariant $E$ on $\mathcal W_n$ with $\rho_{n,n_0}E=F$ is $O(n)$-invariant. The module is $\mathrm{Sym}^d(\mathcal W)$, the group sequence is $\{B_n\}$ with base $\{\mathbb R^n\}$, and the degree is that of $F$. Passages A, B and C name the group sequence only and quantify over no $d$ (Section 1). Passage C's $F$ is "a form" with no degree.

## 12. Gap between proven, stated and used

- **Proven.** The corrected statement of Section 11, as a conditional on $k(d)<\infty$. Only injectivity is consumed.
- **Stated.** The same with an ill-typed $k_B$ (Section 1), plus a false scope remark (Section 7).
- **Used.**
  - Passage C assigns the lemma the role of carrying a certificate (Section 8, GAP).
  - Passage A places the record's use at $O(12)$, where the only on-file bound, itself unargued in the quoted record, gives $k(6)\ge24$ (Section 2).
  - Passage D cites the lemma as proved with a script. That citation is script-grade, but Passage A carries a written argument, which is what was checked here.

## 13. Brief's "What to attack", numbered as there

1. **The hypothesis $n_0\ge k_B$.** $k_B$ must be $k(d)$, the presentation degree of $\mathrm{Sym}^d(\mathcal W)$ over $B_n$, base $\{\mathbb R^n\}$ (GAP, Section 1). Its finiteness is unproven, and no instance is on file. Passage D's only bound puts $k(6)\ge24>12$, and Passage D itself says Theorem 2.11 yields none (HYPOTHESIS-DEBT, Section 2). F30 is respected by running over $B_n$.
2. **The proof of Passage A.**
   - (i) follows, importing the $O(n)$ FFT and an unstated averaging step, with no $k_B$ (Section 3).
   - (ii) follows by direct index inspection, with no $k_B$ (Section 4).
   - (iii) follows from Proposition 2.9 at source. It is the only step using $k_B$, and it uses only injectivity (Section 5).
3. **Existence against uniqueness.** Steps (i) and (ii) alone give an $O(n)$-invariant extension for every $n_0$. $k_B$ adds uniqueness, which is needed for "the unique extension" to have a referent, with an exact failure below range (Section 6).
4. **"FALSE for $SO(n)$".** The claim is asserted without argument and is refuted: $B_{n_0}$ contains a reflection, so the $SO(n)$ version holds on every instance it has (Section 7). B and C carry the $O(n)$ phrasing.
5. **Certificate.** The lift carries an element only. The exact exhibit $G_5(I_5)=-5/4$ comes from an SOS-certified $F\ge0$ at $n_0=4$ (GAP, Section 8).
6. **Presentation degree "of the sequence $\{B_n\}$".** At source the degree belongs to a $\mathcal V$-module (Definition 2.7). Passage D uses it for the degree-6 module, Passage C for "the sequence". These are inconsistent as written, and the charitable reading is Passage D's (Section 1).
7. **Passage E.** It types arithmetic and abstract monotone-sequence facts, and it does not state L64 (Section 9).
8. **The boundary.** Section 10.

## 14. Falsifying objects and the search for each

| Claim | Object that would falsify it | What was done |
|---|---|---|
| Step (i) | An $O(n)$-invariant form on $\mathcal W_n$ outside the span of diagram restrictions | None exists: FFT plus averaging (Section 3) |
| Step (ii) | A diagram with $D_n\circ\iota\neq D_{n_0}$ | Checked term by term. Every index sits on a $W$ factor, so none exists (Section 4) |
| Step (iii) | $n\ge n_0\ge k(d)$ and two distinct $B_n$-invariant extensions of one $F$ | Excluded by Proposition 2.9 at source (Section 5). Exhibited below range at $n_0=3$ (Section 6) |
| Finiteness of $k(d)$ | A $d$ with $\mathrm{Sym}^d(\mathcal W)$ not finitely presented over $B_n$ | Not decidable from the file. Recorded as debt, with no repair supplied (Section 2) |
| "FALSE for $SO(n)$" | An $SO(n_0)$-invariant $F$ with a $B_n$-invariant extension that is not $SO(n)$-invariant | Shown impossible via the reflection $r$, including under a $B_n^+$ reading (Section 7). Refuted |
| Certificate transfer | A certified $F\ge0$ at $n_0\ge k$ whose lift is somewhere negative | Found in closed form, $\mathrm{Sym}^2(S^n)$ with $G_5(I_5)=-5/4$ (Section 8) |
| Lean states L64 | A declaration mentioning $\mathcal W_n$, $B_n$, $O(n)$ or an extension | Read all 91 lines. There is none (Section 9) |

## 15. Withdrawn candidates

- **"Over the finite sequence $\{B_n\}$" (Passage A).** (1) Quoted. (2) The sequence $\{B_n\}_{n\in\mathbb N}$ is infinite. (3) The charitable reading "sequence of finite groups" is unambiguous and consistent with Passages B and C. Withdrawn as wording.
- **Proposition 2.9 is single-step, while the lemma needs $n$ to $n_0$.** (1) Passage A, "Proposition 2.9's projection isomorphism". (2) Source states $U_{n+1}\to U_n$ only. (3) A composite of isomorphisms for $n_0\le m<n$ is an isomorphism, each $m\ge n_0\ge k$. Withdrawn.
- **Trace removal puts $1/(n-2)$ coefficients into step (ii).** (1) Passage C, "every slot sits on a Weyl factor". (2) The Weyl projector at dimension $n$ carries $n$-dependent coefficients and does not commute with padding. (3) The diagrams are evaluated on $W\in\mathcal W_n$ directly, with no projector, so no such coefficient enters (Section 4). Withdrawn.
- **Passage D supports "proved" only by a script.** (1) *"The transfer mechanism is proved ... (run_bn_transfer_theorem.py)"*. (2) A script citation is not an argument. (3) Passage A carries a written argument, checked in Sections 3 to 5. Withdrawn for L64 itself, noted in Section 12.
- **The unbounded docstring in the Lean file.** Withdrawn under its charitable reading (Section 9).

**Overall verdict: PROVEN (hypotheses corrected).** The corrected hypothesis is $n_0\ge k(d)$, with $k(d)$ the presentation degree of $\mathrm{Sym}^d(\mathcal W)$ over $\{B_n\}$, base $\{\mathbb R^n\}$, assumed finite. Standing beside the verdict: HYPOTHESIS-DEBT on that finiteness, with no instance on file. REFUTED for the "FALSE for $SO(n)$" remark. GAP for the certificate sentence. REFUTED that the Lean file states the lemma.
