# Verifier v295, Lemma L85: the count 14, the Weyl-integration method on O(5), the degree sequence 1,1,4,5,14 against 1,2,7,19,89, the Lovelock clause, and the hand checks

Cold brief ([BRIEF_L85.md](BRIEF_L85.md)). No numerical work was done: no scripts were written or run, and every value in this report is exact and argued in closed form. The quotations in the brief were checked against [findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 52 and 66-71 and [results.md](../results.md) lines 288 and 956 (only those lines displayed), and they match verbatim. Log: [agent_logs/verify-L85-v295.log](../agent_logs/verify-L85-v295.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$ (Passages A and B) | HYPOTHESIS-DEBT |
| 2 | The method: connected-group Weyl integration yields the $O(5)$ count at every degree | HYPOTHESIS-DEBT (dischargeable, value unaffected) |
| 3 | "Three hand-checkable rungs" (A), "three hand checks" (B) | HYPOTHESIS-DEBT |
| 4a | "Every entry is strictly smaller" (A), at degree 2 | REFUTED AS STATED (corrected in B) |
| 4b | The sequence values at degrees 3-6, the stable-range values, "which is the syzygies" | HYPOTHESIS-DEBT |
| 5 | Degree 3 being 1 reproduces the Lovelock collapse by an independent method | CONFIRMED AS ALGEBRA (conditional on the values 1 and 2, which are debt under 4b) |
| 6a | B: "The 14 is measured rather than derived" | CONFIRMED |
| 6b | B: degree-two clause, "$\mathcal W_n$ is absolutely irreducible, so that count is 1 at every n" | CONFIRMED (for $n\ge4$, the classical irreducibility import unfiled) |

Summary: the 14 rests on a computation only, as Passage B itself concedes, so the lemma stands as HYPOTHESIS-DEBT. The canonical Passage B correctly repairs A's degree-2 error, and no written hand check reaches degree 6.

## 0. Conventions, fixed once

- $\mathcal W_n$: algebraic Weyl tensors on $\mathbb R^n$ (Riemann symmetries, first Bianchi, totally trace-free), with $O(n)$ acting by the tensor action on four indices. $\dim\mathcal W_5=35$.
- $h_k(n):=\dim(\mathrm{Sym}^k\mathcal W_n)^{O(n)}$, the dimension of the space of $O(n)$-invariant polynomials of degree $k$ on $\mathcal W_n$ (identified with $\mathrm{Sym}^k\mathcal W_n$ through the invariant inner product, $\mathcal W_n\cong\mathcal W_n^*$).
- Real and complex dimensions of invariant spaces agree: the invariants are the solution space of a linear system with real coefficients, so the dimension is unchanged by complexification. The character formula computes the complex dimension.
- "Stable range": $h_k(n)$ for $n$ large. The brief gives $1,2,7,19,89$ for $k=2,\dots,6$.
- $SO(5)$ has root system $B_2$ in the coordinates $e_1,e_2$ of a maximal torus: roots $\pm e_1\pm e_2,\pm e_1,\pm e_2$ (eight roots), Weyl group of order $8$.
- Under $SO(5)$, $\mathcal W_5$ is the irreducible representation of highest weight $2e_1+2e_2$. Check by the Weyl dimension formula with $\rho=(\tfrac32,\tfrac12)$, $\lambda+\rho=(\tfrac72,\tfrac52)$: the factors over positive roots $e_1-e_2,e_1+e_2,e_1,e_2$ are $1,\,3,\,\tfrac73,\,5$, product $35$, matching the brief. This identification is used by the method but is not written in either passage.

## 1. Hypothesis inventory

**Of the statement.**

| Hypothesis | Stated | Used | Note |
|---|---|---|---|
| $n=5$ | yes, in the symbol | yes | |
| degree $k=6$ | yes | yes | |
| group $O(5)$ | yes | the computation is for the connected group | see Section 3 |
| field | no | yes | harmless, Section 0 |

**Of the imported results.**

| Import | Filed | Hypotheses | Checked against the object |
|---|---|---|---|
| Weyl integration formula, $\dim V^G=\tfrac1{\lvert W\rvert}\mathrm{CT}[\chi\prod_{\alpha}(1-t^\alpha)]$ | unfiled (brief: classical) | $G$ compact **connected**, product over all roots | the formula is correct for $SO(5)$: $\lvert\Delta\rvert^2=\prod_{\alpha>0}(1-t^\alpha)(1-t^{-\alpha})=\prod_{\alpha\in\Phi}(1-t^\alpha)$. $O(5)$ is disconnected, and the passages never state the reduction |
| $B_2$ character of $\mathcal W_5$ | unfiled | highest weight $2e_1+2e_2$ | dimension consistent (Section 0), identification unwritten |
| $\mathrm{Sym}^k$ character from power sums, $p_j(t)=\chi(t^j)$, by Newton | unfiled | none beyond eigenvalues | correct: $\chi_{\mathrm{Sym}^k}=h_k(\text{eigenvalues})$ and $k\,h_k=\sum_{j=1}^k p_j h_{k-j}$, with $p_j$ the trace of $g^j$ |
| Stable-range values $1,2,7,19,89$ | unsourced in the passages | large $n$ | only the degree-2 value has an argument (Passage B) |
| First and second fundamental theorems of invariant theory for $O(n)$ | uncited | none | needed to read "which is the syzygies" (Section 5) |
| Absolute irreducibility of $\mathcal W_n$ under $O(n)$ | unfiled | $n\ge4$ | used by Passage B, Section 8 |
| The "contraction identity that first gave" the Lovelock collapse | referred to, not quoted | $n\le5$ | Section 7 |
| [run_n5_constraint_count.py](../scripts/runs/run_n5_constraint_count.py) | a script, not opened under the brief's rules | none | carries the only support for the values at degrees 3-6 |

**Used but unstated:** (i) $(\mathrm{Sym}^k\mathcal W_5)^{O(5)}=(\mathrm{Sym}^k\mathcal W_5)^{SO(5)}$ for every $k$ in the sequence; (ii) the highest weight of $\mathcal W_5$; (iii) the equality of real and complex invariant dimensions; (iv) for the framing sentence, that the SOS programme is symmetry-reduced (Section 10, withdrawn).

## 2. Claim 1, the count 14 (attack item 1)

**The written chain.** Passage A line 68: "By Weyl integration in exact Laurent polynomials, [formula], with $\mathrm{Sym}^k$ characters from the power sums $p_j(t)=\chi(t^j)$ by Newton, **the answer is $14$**. [run_n5_constraint_count.py]". The chain names a method and a script and states the output. No step of the constant-term computation is displayed: the character of $\mathcal W_5$ is not written, $\chi_{\mathrm{Sym}^6}$ is not written, the constant term is not written.

**Discrepancy record.**
1. Locate: line 68 of [findings/sym3-blocks.md](../findings/sym3-blocks.md), quoted above, and [results.md](../results.md) line 956, "*The $14$ is measured rather than derived.*"
2. Exhibit: the number 14 appears in the record only as the output of a run. The brief's rule makes a statement supported only by a script HYPOTHESIS-DEBT.
3. Charitable reading: the method named is correct (Section 1), so the passage can be read as a complete recipe whose execution is routine. A recipe is not an argument a reader can check without performing the computation, and Passage B states in terms that the value is measured. The finding stands.

**What would have to be proved.** That the trivial representation of $SO(5)$ occurs with multiplicity exactly $14$ in $\mathrm{Sym}^6 V_{2e_1+2e_2}$, together with the $O(5)$ reduction of Section 3. Either route suffices: the constant-term computation written out in exact terms, or an explicit list of $14$ sextic contractions with a proof of independence on $\mathcal W_5$ and a proof that the remaining stable-range contractions reduce to them at $n=5$.

**Screen (not evidence).** Multiplication by the nonzero quadratic invariant $I_2=\lvert W\rvert^2$ is injective in the polynomial ring (an integral domain), so $h_{k+2}(5)\ge h_k(5)$. The listed values satisfy $4\ge1$, $5\ge1$, $14\ge4$. The first fundamental theorem gives $h_k(5)\le h_k(\text{stable})$ once the stable values count formal contractions, and $14\le89$. The screen raises no contradiction and proves nothing about the value.

Verdict: **HYPOTHESIS-DEBT**.

## 3. Claim 2, the method on $O(5)$ (attack items 2 and 7)

**The written chain.** The formula is stated for "$G$" with Weyl group $W$ and roots $\alpha$. These data belong to a connected compact group. The heading and line 68 speak of $O(5)$, which has two components. No sentence on file passes from one to the other.

**Discrepancy record.**
1. Locate: line 68, "the constraint count is $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$. By Weyl integration ... $\dim V^G=\tfrac1{|W|}\mathrm{CT}[\chi\prod_\alpha(1-t^\alpha)]$".
2. Exhibit: the connected-group formula returns the identity-component count, which differs from the $O(n)$ count in general. Closed-form instance at $n=4$, $k=2$: under $SO(4)$, $\mathcal W_4=\mathcal W^+\oplus\mathcal W^-$, and $\lvert W^+\rvert^2,\lvert W^-\rvert^2$ are two independent $SO(4)$-invariant quadratics. An orientation-reversing element of $O(4)$ exchanges $\mathcal W^+$ and $\mathcal W^-$, so $\lvert W^+\rvert^2-\lvert W^-\rvert^2$ changes sign and $h_2(4)=1$ while the $SO(4)$ count is $2$. The step from $SO(n)$ tools to $O(n)$ counts therefore needs an argument.
3. Charitable reading: at $n=5$ the step is valid at every degree. Since $5$ is odd, $O(5)=SO(5)\times\{\pm I\}$, and $-I$ acts on a four-index tensor by $(-1)^4=1$, hence trivially on $\mathrm{Sym}^k\mathcal W_5$ for every $k$, odd degrees included. So the $O(5)$ and $SO(5)$ invariant spaces coincide and no value in the sequence changes. The charitable reading rescues the numbers but not the written chain, which applies a connected-group formula to a disconnected group without the reduction.

**What would have to be proved (one line).** $(\mathrm{Sym}^k\mathcal W_5)^{O(5)}=(\mathrm{Sym}^k\mathcal W_5)^{SO(5)}$ for all $k$, which is the fact in step 3. It is recorded here as the missing sentence, and its absence changes no value.

**Edges.** Odd degrees: $-I$ acts trivially, so it imposes no vanishing, and the odd entries $1$ and $5$ are not forced to $0$. $n\ge6$: the passages make no claim at $n=6,\dots$ except the stable-range values, where $O(n)$ and $SO(n)$ counts agree for $n>4k$ (an $SO(n)$-only invariant needs an $\varepsilon$ with $n$ indices among $4k$). No finding at $n\ge6$.

Verdict: **HYPOTHESIS-DEBT** (dischargeable in one sentence, value unaffected).

## 4. Claim 3, the hand checks (attack item 3)

**The written chain.** A's heading promises "three hand-checkable rungs". B (lines 288 and 956) says "three hand checks" and "machine-counted with three hand checks", which asserts that checks were performed. Neither passage says which entries they are.

**What is written, entry by entry.**

| Entry | Hand argument in the passages | Status |
|---|---|---|
| $h_2(5)=1$ | B line 956: absolute irreducibility, so the count is 1 | written, correct (Section 8) |
| $h_3(5)=1$ | A line 71 refers to "the contraction identity that first gave it", not quoted, not argued here | pointer only |
| a third | none identified | absent |
| $h_4,h_5,h_6$ | none | machine only |

**Discrepancy record.**
1. Locate: line 52, "a machine count with three hand-checkable rungs", and line 956, "machine-counted with three hand checks".
2. Exhibit: one of the three has an argument in the passages, a second is a pointer to a result not quoted, and the third is not named.
3. Charitable reading: the rungs are degrees 2 and 3, argued elsewhere in the record, plus some third check filed elsewhere. Even on that reading the rungs test the method at low degree and carry no implication for degree 6: no recurrence, induction or bound on file connects $h_2,h_3$ to $h_6$. "Rungs" describes a ladder that is not written. The finding stands.

**What would have to be proved.** Name the three entries and write each check. Separately, the record should state that these checks validate the computation at low degree and say nothing about the degree-6 value.

Verdict: **HYPOTHESIS-DEBT**.

## 5. Claim 4, the sequence clause (attack items 4 and 7)

The clause, line 71: "The sequence at $n=5$ is $1,1,4,5,14$ for degrees $2$ through $6$, against the stable-range $1,2,7,19,89$. Every entry is strictly smaller, which is the syzygies".

**4a, "Every entry is strictly smaller", degree 2.**
1. Locate: line 71, as quoted.
2. Exhibit: the passage's own lists give $h_2(5)=1$ and stable $h_2=1$, and $1<1$ is false. Both values are correct by the argument of Section 8.
3. Charitable reading: "every entry" could mean the entries where the counts differ, or degrees 3 onward. The sentence lists degree 2 first and says "every". Passage B line 956 records the correction ("false at degree two and forced to be"). The finding stands against Passage A as written. The canonical Passage B carries the correction.

Verdict: **REFUTED AS STATED** (in A, corrected in B).

**4b, the remaining clauses, degree by degree.**

| Degree | $n=5$ | stable | "strictly smaller" | support on file |
|---|---|---|---|---|
| 2 | 1 | 1 | false (4a) | both values by B's argument |
| 3 | 1 | 2 | true if the values hold | $n=5$: machine and the Lovelock pointer. Stable: unsourced (classical) |
| 4 | 4 | 7 | true if the values hold | machine only. Stable unsourced |
| 5 | 5 | 19 | true if the values hold | machine only. Stable unsourced |
| 6 | 14 | 89 | true if the values hold | machine only. Stable unsourced |

"Which is the syzygies": reading the gap $h_k(\text{stable})-h_k(5)$ as the number of independent dimension-dependent relations needs three inputs that the passages do not state: the first fundamental theorem for $O(5)$ (every invariant is a complete contraction, so the formal contraction space surjects onto the $n=5$ invariants), the identification of the stable values with the dimension of formal contractions modulo dimension-independent identities, and the second fundamental theorem to call the kernel "syzygies". With those inputs the reading is correct. The word "syzygies" is also used loosely: in invariant theory it names relations among generators, and here it names linear relations among contractions in a fixed degree. No argument for the clause is on file.

Verdict: **HYPOTHESIS-DEBT** (values at degrees 3-6 at $n=5$ and all stable values except degree 2 are unsupported by argument, and the syzygy interpretation is unargued).

## 6. Claim 1 across A and B, stated against proven (standing item 4)

- Stated (A heading, B landscape and detail): $h_6(5)=14$ as a lemma.
- Proven in the passages: $h_2(5)=1$ and stable $h_2=1$ (B's degree-two clause), and the correctness of the named method for $SO(5)$ (Section 1).
- Between them: the $O(5)$ reduction (Section 3), every value at degrees 3-6, the stable values at degrees 3-6, the three hand checks, and the syzygy interpretation.
- B is honest about the gap ("measured rather than derived"). The "Lemma" label on a measured value is the gap between statement and proof.

## 7. Claim 5, the Lovelock clause (attack item 5)

The clause, line 71: "degree $3$ being $1$ reproduces the Lovelock collapse by a method sharing nothing with the contraction identity that first gave it".

**Are they the same fact.** Let $A,B$ be the two stable-range cubic contractions (stable value $2$).
- Count $\Rightarrow$ collapse: if $h_3(5)=1$ then any two cubic invariants on $\mathcal W_5$ are linearly dependent, so $A,B$ satisfy a nontrivial linear relation at $n=5$. Since they are independent in the stable range, the relation is dimension-dependent. This direction needs only the two values.
- Collapse $\Rightarrow$ count: a single relation between $A$ and $B$ gives $h_3(5)\le1$ only if $A,B$ span the $n=5$ cubic invariants (first fundamental theorem plus the stable value 2), and $h_3(5)\ge1$ needs a cubic invariant that does not vanish identically on $\mathcal W_5$.
- So, given the classical inputs, the count and the collapse are the same dimensional fact. The count carries less than the identity: it gives the number of relations and not their coefficients. "Reproduces" is correct in that dimensional sense.

**Is the independence argued.** It is asserted, not argued. By inspection of the method as stated (characters, power sums, a constant term), no contraction identity enters, so the assertion is true of the method as described. The comparison itself (reading the count as the collapse) uses the stable value 2, which is a fact of contraction calculus, so the cross-check is independent in the count and shares an input in the interpretation.

**Discrepancy record (candidate: the two routes share an input, so "sharing nothing" is false).**
1. Locate: "by a method sharing nothing with the contraction identity".
2. Exhibit: interpreting $h_3(5)=1$ as a collapse requires the stable value $h_3=2$, which comes from reducing cubic contractions under the Weyl symmetries.
3. Charitable reading: "method" refers to how the number $1$ is obtained, and the character computation uses no contraction identity. On that reading the claim is true. Candidate withdrawn (Section 10).

Verdict: **CONFIRMED AS ALGEBRA**. The logical relation holds, conditional on $h_3(5)=1$ and stable $h_3=2$, which remain debt under 4b.

## 8. Claim 6, Passage B's additions (attack item 6)

**6a, "The 14 is measured rather than derived".** This accurately describes the support on file (Section 2) and is consistent with the HYPOTHESIS-DEBT verdict on Claim 1. Verdict: **CONFIRMED**.

**"Machine-counted with three hand checks".** Machine-counted: consistent with line 68. Three hand checks: see Section 4, HYPOTHESIS-DEBT.

**6b, the degree-two clause.** "**'Every entry is strictly smaller' is false at degree two and forced to be**: $\mathcal W_n$ is absolutely irreducible, so that count is $1$ at every $n$."
- Link 1: $(\mathrm{Sym}^2\mathcal W_n)^{O(n)}\subseteq(\mathcal W_n\otimes\mathcal W_n)^{O(n)}\cong\mathrm{Hom}_{O(n)}(\mathcal W_n^*,\mathcal W_n)\cong\mathrm{End}_{O(n)}(\mathcal W_n)$, using $\mathcal W_n\cong\mathcal W_n^*$ through the inner product.
- Link 2: absolute irreducibility gives $\mathrm{End}_{O(n)}(\mathcal W_n)=\mathbb R$, so the count is at most $1$. "Absolutely" is the right hypothesis: for a real irreducible of complex type the endomorphism algebra is $\mathbb C$ and the quadratic count can be $2$.
- Link 3: $\lvert W\rvert^2$ is a nonzero invariant quadratic, so the count is at least $1$. This link is unwritten but immediate.
- Link 4: the same argument at large $n$ gives the stable value $1$, so equality at degree 2 is forced, which is the clause.
- Import: absolute irreducibility of $\mathcal W_n$ under $O(n)$, classical, unfiled. It holds for $n\ge4$, including $n=4$, where $\mathcal W^\pm$ are non-isomorphic under $SO(4)$ and exchanged by a reflection, so the $O(4)$ commutant is $\mathbb R$.

Verdict: **CONFIRMED** for $n\ge4$ (edge candidates in Section 10).

## 9. Falsifying objects and the search (standing item 6)

| Claim | Falsifier | What was done |
|---|---|---|
| 1 | a fifteenth $O(5)$-invariant sextic on $\mathcal W_5$ independent of a basis of 14, or a relation cutting 14 to 13 | the passages contain no basis to test. The screen $h_{k+2}\ge h_k$ and the upper bound from the first fundamental theorem were checked, and both pass. The search stops at the numerical-work line |
| 2 | an $O(5)$ element outside $SO(5)\times\{\pm I\}$, or $-I$ acting nontrivially on $\mathcal W_5$ | neither exists: $O(5)=SO(5)\times\{\pm I\}$ and $(-1)^4=1$. At $n=4$ the analogous object exists, as shown in Section 3 |
| 3 | an entry declared hand-checkable with no hand argument | exhibited: the third rung, and degree 3 within these passages |
| 4a | an entry not strictly smaller | exhibited: degree 2, $1=1$ |
| 4b | an $n=5$ value exceeding its stable value (would contradict the first fundamental theorem) | none among the listed values |
| 5 | $A,B$ independent on $\mathcal W_5$ (would make $h_3(5)\ge2$) | not exhibitable without computation, and it would contradict the Lovelock identity referred to |
| 6b | $n\ge4$ with $\mathcal W_n$ reducible under $O(n)$, or a second invariant quadratic | none. At $n\le3$, $\mathcal W_n=0$ (Section 10) |

## 10. Withdrawn candidates

- **"That count is 1 at every $n$" fails at $n\le3$.** (1) Line 956. (2) $\mathcal W_3=0$, so $\mathrm{Sym}^2\mathcal W_3=0$ and the count is $0$. (3) The clause's own premise, "$\mathcal W_n$ is absolutely irreducible", holds only for a nonzero representation, so the sentence restricts itself to $n\ge4$. Withdrawn.
- **"Absolutely irreducible" fails at $n=4$.** (1) Line 956. (2) Under $SO(4)$, $\mathcal W_4=\mathcal W^+\oplus\mathcal W^-$. (3) The group throughout is $O(n)$, and under $O(4)$ the representation is absolutely irreducible (Section 8). Withdrawn.
- **"Sharing nothing" is false because the interpretation uses the stable value.** Section 7, step 3: "method" refers to the computation of the number. Withdrawn.
- **"The constraint count is $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$" fails for an SOS programme.** (1) Line 68, "An SOS certificate faces one equation per basis invariant sextic". (2) An SOS programme with an unrestricted Gram matrix matches coefficients of every monomial of degree 6 in 35 variables, $\binom{40}{6}$ equations. (3) For an invariant target, averaging a Gram matrix over the compact group preserves positivity, so the Gram matrix may be taken invariant, and the coefficient equations then reduce to one per basis invariant. The sentence is framing for the symmetry-reduced programme and not part of L85. Withdrawn.

## Overall verdict

**HYPOTHESIS-DEBT.** The value $14$ has no argument on file: it is a machine count, and Passage B says so. The degree-2 error in Passage A is REFUTED AS STATED and correctly repaired in the canonical Passage B. The $O(5)$-to-$SO(5)$ reduction is missing but true at every degree by one sentence. The Lovelock clause is correct as algebra, conditional on unargued values. None of the three announced hand checks reaches degree 6, and only the degree-2 check is written.
