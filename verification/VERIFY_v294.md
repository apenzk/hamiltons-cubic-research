# Verifier v294, Lemma L85: the O(5)-invariant count 14 at degree six, its Weyl-integration method, its hand-checkable rungs, the degree sequence at n = 5 and the Lovelock cross-check

The brief was cold. No numerical work was done, every value is exact, and no scripts were written or run. Quotations were checked against [findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 52 and 66-71 and [results.md](../results.md) lines 288 and 956 only, and match verbatim. Log: [agent_logs/verify-L85-v294.log](../agent_logs/verify-L85-v294.log).

| # | Claim | Verdict |
|---|---|---|
| C1 | $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$ (Passage A heading, Passage B) | HYPOTHESIS-DEBT |
| C2 | Method: $\dim V^G=\tfrac1{\lvert W\rvert}\mathrm{CT}[\chi\prod_\alpha(1-t^\alpha)]$ with Newton for $\mathrm{Sym}^k$, applied to $O(5)$ | GAP |
| C3 | "Three hand-checkable rungs" (A) and "three hand checks" (B) | HYPOTHESIS-DEBT |
| C4 | Sequence $1,1,4,5,14$ at $n=5$ and stable range $1,2,7,19,89$, degrees 2-6 | HYPOTHESIS-DEBT (degree 2 CONFIRMED) |
| C5 | "Every entry is strictly smaller, which is the syzygies" | REFUTED AS STATED |
| C6 | "Degree 3 being 1 reproduces the Lovelock collapse by a method sharing nothing with the contraction identity" | HYPOTHESIS-DEBT |
| C7 | Passage B: degree-two clause, "$\mathcal W_n$ is absolutely irreducible, so that count is 1 at every $n$" | CONFIRMED |
| C8 | Passage B: "The 14 is measured rather than derived" | CONFIRMED |

Summary: no argument on file establishes the 14, the method as written omits the O(5) to SO(5) reduction (true at n = 5, unwritten), Passage A's strict-inequality clause fails at degree 2 and Passage B records that correctly, and the three rungs are neither named nor written.

Overall verdict: **HYPOTHESIS-DEBT**.

## 0. Conventions, fixed once

- $\mathcal W_n$: algebraic Weyl tensors on $\mathbb R^n$ (algebraic curvature tensors with every Ricci trace zero), $\dim\mathcal W_n=n(n+1)(n+2)(n-3)/12$, so $\dim\mathcal W_5=35$, $\dim\mathcal W_4=10$, $\dim\mathcal W_3=0$.
- $O(n)$ acts on $\mathcal W_n$ by the tensor action on four indices. $c_k(n):=\dim(\mathrm{Sym}^k\mathcal W_n)^{O(n)}$. "Stable range" $s_k:=c_k(n)$ for $n$ large, as the brief defines it.
- $G$ in the Weyl integration formula is a compact connected Lie group, $T$ a maximal torus, $W$ (roman) its Weyl group, $\alpha$ ranging over all roots, $\mathrm{CT}$ the constant term of a Laurent polynomial in the torus coordinates. For $SO(5)$: rank 2, type $B_2$, $\lvert W\rvert=8$, roots $\pm e_1,\pm e_2,\pm e_1\pm e_2$.
- Roman $W$ (Weyl group) and calligraphic $\mathcal W_5$ (Weyl tensors) are different objects. The collision is notational and carries no finding.
- Candidates are recorded with the three-step protocol: (1) location and quoted line, (2) concrete failure, (3) most charitable reading.

## Hypothesis inventory

Statement hypotheses (C1): $n=5$, degree $k=6$, group $O(5)$ (full orthogonal group, disconnected), invariants taken as polynomial functions, real coefficients.

Imported results, all unfiled:

| Import | Hypotheses | Applied to | Hypotheses met? | Used by |
|---|---|---|---|---|
| Weyl integration formula | $G$ compact connected, $\chi$ the character of a finite-dimensional rep restricted to $T$ | $O(5)$, per the passage | Connectedness fails for $O(5)$. Met by $SO(5)$. The reduction is unwritten (C2). | C1, C2, C4 |
| $B_2$ character theory, weights of $\mathcal W_5\otimes\mathbb C$ | $\mathcal W_5\otimes\mathbb C$ identified with a specific $SO(5)$-module (the character $\chi$) | the input $\chi$ | The character used is not written on file. | C1, C4 |
| Newton identity $kh_k=\sum_{j=1}^k p_jh_{k-j}$, $p_j(t)=\chi(t^j)$ | none beyond characters being class functions | $\mathrm{Sym}^k$ characters | Met. The identity as described is correct. | C2 |
| Absolute irreducibility of $\mathcal W_n$ | $\mathcal W_n\neq0$, i.e. $n\ge4$, and group $O(n)$ (under $SO(4)$, $\mathcal W_4=\mathcal W^+\oplus\mathcal W^-$) | degree-2 clause | Met for $n\ge4$ under $O(n)$. The range is implicit (C7). | C4 (degree 2), C5, C7 |
| Schur's lemma (real form): absolutely irreducible real $V$ has $\dim(\mathrm{Sym}^2V^*)^G=1$ | $V$ absolutely irreducible, $G$ compact | $\mathcal W_n$ | Met. | C7 |
| First (and second) fundamental theorem for $O(n)$: invariants of tensors are spanned by complete contractions, relations come from antisymmetrisation over $n+1$ indices | $O(n)$, tensor representations | "which is the syzygies", "reproduces the Lovelock collapse" | Used but unstated. | C5, C6 |
| The Lovelock relation among cubic Weyl contractions at $n=5$ | not quoted in the brief | C6 | Not readable from the passages. | C6 |
| Stable-range values $1,2,7,19,89$ | no source cited | C4, C5 | Unsourced. | C4, C5 |

Used but unstated: the reduction $O(5)\to SO(5)$ (C2), the fundamental theorems for $O(n)$ (C5, C6), the input character of $\mathcal W_5$ (C1), the range $n\ge4$ in "every $n$" (C7), and the source of the stable-range figures (C4).

The opening sentence of Passage A ("An SOS certificate faces one equation per basis invariant sextic, so the constraint count is ...") is motivation for why the count matters. The SOS set-up is not quoted in the brief and that identification is outside this round's scope.

## 1. C1, the statement $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$ (brief item 1)

Location: [findings/sym3-blocks.md](../findings/sym3-blocks.md) line 68, "**the answer is $14$**. [run_n5_constraint_count.py](../scripts/runs/run_n5_constraint_count.py)."

The chain as written has three links: (i) the Weyl integration formula, (ii) $\mathrm{Sym}^k$ characters by Newton from power sums, (iii) evaluation, giving 14. Links (i) and (ii) are correct statements of classical facts (checked in section 2). Link (iii) is a script output. The character $\chi$ of $\mathcal W_5$ on the torus, the expansion of $h_6$, the product over the eight roots and the constant term are not written anywhere in the passages. Passage B confirms this reading: "*The $14$ is measured rather than derived.*"

Under this loop's rules a statement supported only by a run is HYPOTHESIS-DEBT. What would have to be proved: that the multiplicity of the trivial $SO(5)$-module in $\mathrm{Sym}^6(\mathcal W_5\otimes\mathbb C)$ is 14, with $\mathcal W_5\otimes\mathbb C$ identified as a named $B_2$-module, together with the reduction of section 2. Equivalently, an exhibited basis of 14 invariant sextics plus a proof of spanning.

Gap between statement and proof across A and B: Passage B line 956 labels the value as measured. The landscape line 288, "The invariant dimension at degree six is fourteen", and the heading at line 52 state it flat as a Lemma. The debt is recorded in the detail line and absent from the landscape line.

Falsifier: 15 linearly independent $O(5)$-invariant sextics on $\mathcal W_5$, or an exact trivial-multiplicity computation for $\mathrm{Sym}^6$ differing from 14. What I did: confirmed no derivation is on file to test link by link. Producing either object is computation and out of scope.

## 2. C2, the method applied to $O(5)$ (brief item 2, standing item 2)

Location: line 68, "By Weyl integration in exact Laurent polynomials, $\dim V^G=\tfrac1{|W|}\mathrm{CT}\big[\chi\prod_\alpha(1-t^\alpha)\big]$".

Reading the formula. For compact connected $G$ with maximal torus $T$, Weyl integration gives $\int_G f=\tfrac1{\lvert W\rvert}\int_T f(t)\prod_{\alpha}(1-t^\alpha)\,dt$ for class functions $f$, the product over all roots. With $f=\chi_V$ and $\dim V^G=\int_G\chi_V$, and $\int_T$ of a Laurent polynomial equal to its constant term, the displayed formula is correct for connected $G$. The Newton step is correct: the character of $\mathrm{Sym}^kV$ at $t$ is $h_k$ of the eigenvalues of $t$ on $V$, $p_j$ of those eigenvalues is $\chi_V(t^j)$, and $kh_k=\sum_{j=1}^kp_jh_{k-j}$.

Hypothesis check against the object. The passage names the target as $O(5)$ and the formula's $G$ is unspecified. $O(5)$ is disconnected, so the formula's hypothesis fails for the group in the statement. The Laurent-polynomial computation is necessarily an $SO(5)$ computation (the torus and roots of $B_2$).

Candidate C2-a, the method computes the wrong group.
1. Location: line 68 as quoted, with the statement's group $O(5)$ at line 52.
2. Concrete failure sought: an element of $O(5)\setminus SO(5)$ acting nontrivially on some $(\mathrm{Sym}^k\mathcal W_5)^{SO(5)}$, which would make the $SO(5)$ count exceed the $O(5)$ count. Since $5$ is odd, $-I\in O(5)\setminus SO(5)$ and $O(5)=SO(5)\times\{\pm I\}$. $-I$ acts on a 4-index tensor by $(-1)^4=+1$, hence trivially on $\mathcal W_5$ and on every $\mathrm{Sym}^k\mathcal W_5$. So $(\mathrm{Sym}^k\mathcal W_5)^{O(5)}=(\mathrm{Sym}^k\mathcal W_5)^{SO(5)}$ at every degree $k$, odd and even. No failure exists.
3. Charitable reading: the passage intends the $SO(5)$ computation and takes the equality of the two counts as evident.

The candidate as a refutation is withdrawn at step 2. What remains is that the step is not written. The passages never state the reduction, and the justification is specific to odd $n$ (for even $n$, $-I\in SO(n)$ and the component of reflections can act by $-1$ on $SO(n)$-invariants: at $n=4$, $c_2$ is 2 for $SO(4)$ and 1 for $O(4)$). Verdict GAP: the method as written applies a connected-group formula to a disconnected group without the reduction, which holds at $n=5$ for every degree.

Falsifier: an orientation-reversing element acting by $-1$ on an $SO(5)$-invariant polynomial on $\mathcal W_5$. Excluded by the argument in step 2.

## 3. C3, "three hand-checkable rungs" (brief item 3)

Location: line 52, "a machine count with three hand-checkable rungs"; line 288, "A machine count with three hand checks"; line 956, "machine-counted with three hand checks".

Candidate C3-a, the rungs are unnamed and unwritten.
1. Location: the three lines above. No passage says which three entries or facts are the rungs.
2. Concrete failure: reading lines 66-71 and 956 for any hand argument, I find (a) the degree-2 value 1, with a reason ("$\mathcal W_n$ is absolutely irreducible") given in Passage B as a reason why the strict inequality fails, not as a check of the count; (b) the degree-3 value 1, asserted to agree with the Lovelock collapse, whose argument is elsewhere and is not quoted (section 6); (c) nothing identifiable as a third rung. Plausible third candidates (the dimension $\chi(1)=35$, or the stable value $s_2=1$) are not mentioned.
3. Charitable reading: the rungs are degrees 2 and 3 and a third check the author considered routine. Even so, two of three are at most referenced, and none checks the degree-6 value. Agreement at low degree validates the script's inputs, and no passage argues that it certifies the value at degree 6.

The candidate survives all three steps. Verdict HYPOTHESIS-DEBT. What would have to be proved: the identity of the three rungs, a written hand argument for each, and (if the rungs are meant to support 14) a statement of what they certify.

Falsifier: a written list of three rungs with their arguments in the quoted passages. Looked for in lines 52, 66-71, 288, 956: absent.

## 4. C4, the sequence at $n=5$ and the stable range (brief item 4, standing item 3)

Location: line 70, "The sequence at $n=5$ is $1,1,4,5,14$ for degrees $2$ through $6$, against the stable-range $1,2,7,19,89$."

Degree 2, both sides. $c_2(5)=1$: $\mathcal W_5$ is absolutely irreducible under $SO(5)$ (its complexification is the irreducible $B_2$-module of highest weight $(2,2)$, whose Weyl dimension $\frac{(2+\frac32)(2+\frac12)(4+2)(0+1)}{\frac32\cdot\frac12\cdot2\cdot1}=35$ matches $\dim\mathcal W_5$, with the irreducibility itself the unfiled classical import). By Schur, $\mathrm{End}_{G}(\mathcal W_5)=\mathbb R$, the invariant bilinear forms form a line spanned by the positive-definite restriction of the tensor inner product, which is symmetric, so $c_2(5)=1$. The same argument at large $n$ gives $s_2=1$. Degree 2 CONFIRMED on both sides.

Degrees 3-6 at $n=5$: script-only, HYPOTHESIS-DEBT (as C1). Degree 3 has a hand route through the Lovelock relation, examined in section 6, and that route is not written in the passages.

Stable range $1,2,7,19,89$: no source, script or argument is cited for these values in the passages, and "large $n$" has no threshold stated. HYPOTHESIS-DEBT. What would have to be proved: the count of linearly independent complete contractions of $k$ copies of a Weyl tensor for $k=3,\dots,6$ together with the statement that these are independent for $n$ above a stated bound.

Odd degrees ($k=3,5$): the parity of $k$ imposes nothing, since $-I$ acts trivially (section 2). No finding at odd degrees beyond the debt already recorded.

Falsifier: an exact invariant count at $n=5$ differing at some degree, or a published or derived stable contraction count differing. Neither is on file to compare, and producing one is computation.

## 5. C5, "Every entry is strictly smaller, which is the syzygies" (brief items 4 and 7, standing item 4)

Location: line 70, "Every entry is strictly smaller, which is the syzygies".

Candidate C5-a, degree 2 violates strict inequality.
1. Location: the quoted sentence, read against "$1,1,4,5,14$ ... against the stable-range $1,2,7,19,89$".
2. Concrete failure: at degree 2, $c_2(5)=1=s_2$, both established by hand in section 4. $1<1$ is false.
3. Charitable reading: "every entry" means the entries from degree 3 on. The sentence says "every entry" of a sequence explicitly indexed from degree 2, and the record's own Passage B (line 956) says the clause "is false at degree two and forced to be". The charitable reading is a correction, not a reading of the text.

The candidate survives. Verdict REFUTED AS STATED. The corrected form "strictly smaller at degrees 3 through 6" follows arithmetically from the listed values, which are themselves HYPOTHESIS-DEBT (section 4).

"Which is the syzygies". The clause attributes the drop $s_k-c_k(5)$ to relations. This needs two unstated imports: the first fundamental theorem for $O(5)$ (every invariant at $n=5$ is a combination of complete contractions, so $c_k(5)\le$ the number of formally independent contractions $=s_k$) and the second fundamental theorem (the kernel consists of relations from antisymmetrisation over 6 indices). At $n=5$ the $SO(5)$ pseudo-invariants built with one $\varepsilon$ would add to the count, and they are excluded because $4k+5$ indices cannot be fully contracted (consistent with section 2). None of this is written. Sub-verdict HYPOTHESIS-DEBT for the attribution.

Across A and B: Passage B corrects the degree-2 failure and gives a correct reason (section 7). The "which is the syzygies" clause is left standing in A without argument.

Falsifier: degree 2, exhibited above.

## 6. C6, degree 3 and the Lovelock collapse (brief item 5)

Location: line 70, "**degree $3$ being $1$ reproduces the Lovelock collapse by a method sharing nothing with the contraction identity that first gave it**".

Are they the same fact? The Lovelock-type identity at $n=5$ (vanishing of an antisymmetrisation over six indices contracted with three Weyl tensors) yields a linear relation among the two stable cubic contractions. A relation among contractions gives $c_3(5)\le1$ only when combined with (a) the first fundamental theorem (the two contractions span the cubic invariants), (b) nontriviality of the relation's coefficients. The equality $c_3(5)=1$ additionally needs (c) one cubic invariant not identically zero on $\mathcal W_5$. Conversely, $c_3(5)=1$ with (a) and $s_3=2$ implies a one-dimensional relation space, so the relation is unique up to scale and is the Lovelock relation whenever that relation is nontrivial. With (a), (b), (c) the two statements are the same fact about the cubic invariant space. Without (a) the count and the identity are statements about different objects (a dimension against a relation among two named polynomials), and "reproduces" does not follow.

Independence of method: the character computation uses Weyl integration and Newton, and uses neither the contraction identity nor the fundamental theorems. As a description of methods the independence is accurate. Its evidential force as a cross-check rests on the degree-3 count, which is a script output (section 4).

Candidate C6-a, the cross-check is argued nowhere.
1. Location: the quoted clause.
2. Concrete failure: the passages give no degree-3 derivation from the character, cite no statement of the Lovelock relation, and state none of (a), (b), (c). The Lovelock identity and its coefficients are not in the brief, so (b) cannot be read.
3. Charitable reading: "reproduces" means "agrees numerically with the dimension the Lovelock collapse predicts", with the prediction taken from its home file. That reading still needs (a) to turn a relation into a dimension, and the numerical agreement still rests on a run.

The candidate survives. Verdict HYPOTHESIS-DEBT. What would have to be proved: $c_3(5)=1$ by a written argument, which by the route above is the first fundamental theorem for $O(5)$, the nontrivial Lovelock relation on $\mathcal W_5$ and one nonvanishing cubic, or a written character computation for $\mathrm{Sym}^3$.

Falsifier: $c_3(5)=2$ (the Lovelock relation vanishing identically on $\mathcal W_5$ as a formal identity) or $c_3(5)=0$ (every cubic invariant zero on $\mathcal W_5$). Not constructible from the passages. I did not build either.

## 7. C7, Passage B's degree-two clause (brief items 6 and 7)

Location: line 956, "**"Every entry is strictly smaller" is false at degree two and forced to be**: $\mathcal W_n$ is absolutely irreducible, so that count is $1$ at every $n$."

Derivation read link by link. (i) $\mathcal W_n$ absolutely irreducible as a real $O(n)$-module (unfiled classical). (ii) For a compact group and an absolutely irreducible real module, $\mathrm{End}_G=\mathbb R$, so invariant bilinear forms are a line, spanned by the invariant inner product, which is symmetric: $\dim(\mathrm{Sym}^2)^G=1$. (iii) This holds at $n=5$ and at every large $n$, so $c_2(5)=s_2=1$ and strict inequality is impossible. Each link is correct, and "forced" is justified by the $n$-independence of the argument.

Withdrawn candidate C7-w1, "at every $n$" fails at small $n$: see section 9.

Boundary $n=4$ against the group: under $SO(4)$, $\mathcal W_4=\mathcal W^+\oplus\mathcal W^-$ and the degree-2 count is 2. The clause's group is $O(n)$, for which a reflection exchanges $\mathcal W^\pm$ and the complexification stays irreducible, so the count is 1. No finding under $O(n)$.

Verdict CONFIRMED, conditional on the unfiled irreducibility import and read over $n\ge4$.

## 8. C8, "The 14 is measured rather than derived" (brief item 6)

Location: line 956, "*The $14$ is measured rather than derived.*"

The passages hold a script link and no derivation (section 1). The sentence describes the evidential status accurately. "Machine-counted with three hand checks" in the same line is examined as C3. Verdict CONFIRMED as a description, and it is the reason C1 is HYPOTHESIS-DEBT.

## 9. Withdrawn candidates

C2-a (method computes the wrong group). Withdrawn at step 2: $O(5)=SO(5)\times\{\pm I\}$ with $-I$ trivial on 4-tensors, so the $O(5)$ and $SO(5)$ counts agree at every degree. The unwritten reduction is recorded as GAP in section 2.

C7-w1 ("that count is 1 at every $n$" fails for $n\le3$).
1. Location: line 956, "that count is $1$ at every $n$".
2. Concrete failure: $\dim\mathcal W_3=3\cdot4\cdot5\cdot0/12=0$, so $\mathrm{Sym}^2\mathcal W_3=0$ and the count is 0 (likewise $n=1,2$).
3. Charitable reading: the sentence's own reason, "$\mathcal W_n$ is absolutely irreducible", presupposes $\mathcal W_n\neq0$, so its range is $n\ge4$, and the comparison concerns $n=5$ against large $n$. This reading dissolves the discrepancy. Withdrawn at step 3, with the implicit range $n\ge4$ recorded in the hypothesis inventory.

## 10. Standing list, answered

1. Hypothesis inventory: given above. Used but unstated: the $O(5)\to SO(5)$ reduction, the fundamental theorems for $O(n)$, the input character of $\mathcal W_5$, the range $n\ge4$, the source of the stable-range values.
2. Quantifier order and scope: the statement is fixed $n=5$, fixed $k=6$, group $O(5)$. The computation is an $SO(5)$ computation. The two agree at $n=5$ for all $k$ (section 2), and the agreement is unwritten (GAP). The degree-2 clause quantifies over $n$ under $O(n)$ and is correct for $n\ge4$. No finding on quantifier order beyond these.
3. Edges: degree 2 refutes Passage A's strict inequality (C5), corrected by Passage B (C7). Odd degrees: no finding, $-I$ acts trivially and no parity vanishing or pseudo-invariant arises at $n=5$. $n=5$ against $n\ge6$: the reduction of section 2 is specific to odd $n$ and the method would need a separate treatment of the reflection component at even $n$. The statement is at $n=5$ only, so this is a scope note, not a finding against it.
4. Proven against stated across A and B: proven by hand on file is $c_2(5)=s_2=1$ (B) and the correctness of the formula and Newton step as statements. Stated beyond that: 14, the sequence at degrees 3-6, the stable values, "three hand-checkable rungs", the syzygy attribution and the Lovelock cross-check. The landscape line 288 states 14 without the "measured" label that line 956 carries.
5. Brief items: 1 in section 1, 2 in section 2, 3 in section 3, 4 in sections 4 and 5, 5 in section 6, 6 in sections 7 and 8, 7 in sections 4, 5, 7 and 10.3.
6. Falsifiers: C1, 15 independent invariant sextics or an exact count $\ne14$ (none on file, construction is computation). C2, an orientation-reversing element acting by $-1$ on an $SO(5)$-invariant (excluded by $-I$). C3, a written list of three rungs (searched the quoted lines, absent). C4, an exact count differing at any degree (none on file). C5, degree 2 (exhibited). C6, $c_3(5)\in\{0,2\}$ (not constructible from the passages, not built). C7, $n\le3$ (withdrawn at step 3) and $SO(4)$ (outside the clause's group). C8, a written derivation of 14 in the passages (absent).

## Overall verdict

**HYPOTHESIS-DEBT.** The lemma's value 14 rests on a run and no argument on file establishes it. The method is correct for $SO(5)$ and transfers to $O(5)$ by an unwritten reduction valid at odd $n$. Passage A's "every entry is strictly smaller" is refuted at degree 2 and corrected by Passage B with a correct reason. The three hand-checkable rungs, the degree 3-6 values, the stable-range figures, the syzygy attribution and the Lovelock cross-check all lack written arguments.
