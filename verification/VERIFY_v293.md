# Verifier v293, Lemma L85: the count $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$, its Weyl-integration method applied to $O(5)$, the hand rungs, the degree sequence against the stable range, and the Lovelock remark

Cold brief ([verification/BRIEF_L85.md](BRIEF_L85.md)), no numerical work, every value exact, no scripts written or run. Quotations were checked at source by displaying only the cited lines ([findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 52 and 66-71, [results.md](../results.md) lines 288 and 956) and all are verbatim. Log: [agent_logs/verify-L85-v293.log](../agent_logs/verify-L85-v293.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$ (heading, Passage A, Passage B) | HYPOTHESIS-DEBT |
| 2a | $\dim V^G=\tfrac1{\lvert W\rvert}\mathrm{CT}[\chi\prod_\alpha(1-t^\alpha)]$ with $\mathrm{Sym}^k$ characters by Newton from $p_j(t)=\chi(t^j)$ | CONFIRMED AS ALGEBRA |
| 2b | Applying that connected-group formula to $O(5)$ at every degree | GAP |
| 3 | "three hand-checkable rungs" (A), "three hand checks" (B) | HYPOTHESIS-DEBT |
| 4a | The values $1,1,4,5,14$ at $n=5$ and $1,2,7,19,89$ in the stable range | HYPOTHESIS-DEBT |
| 4b | "Every entry is strictly smaller" | REFUTED AS STATED |
| 4c | "which is the syzygies" | HYPOTHESIS-DEBT |
| 5 | "degree $3$ being $1$ reproduces the Lovelock collapse by a method sharing nothing with the contraction identity" | HYPOTHESIS-DEBT |
| 6a | Passage B, "The $14$ is measured rather than derived" | CONFIRMED |
| 6b | Passage B, degree-two clause: false at degree two and forced, since $\mathcal W_n$ is absolutely irreducible, count $1$ at every $n$ | CONFIRMED |
| 7 | Boundary: degree $2$, odd degrees, $n=5$ against $n\ge6$ | CONFIRMED |

Summary: nothing on file derives the $14$, which rests on an unfiled script, the method's transfer from $SO(5)$ to $O(5)$ is true at $n=5$ but unwritten, the "strictly smaller" clause of Passage A fails at degree two as Passage B already records, and Passage B is an accurate account of what is on file.

## 0. Conventions, fixed once

- $\mathcal W_n$ is the real space of algebraic Weyl tensors on $\mathbb R^n$ (curvature symmetries, first Bianchi identity, totally trace-free), $\dim\mathcal W_5=35$. $(\mathrm{Sym}^k\mathcal W_n)^{G}$ is the space of $G$-invariant homogeneous polynomials of degree $k$ on $\mathcal W_n$ for $G=O(n)$ or $SO(n)$. Real dimensions equal complex dimensions of the complexified invariants.
- $SO(5)$ has type $B_2$, maximal torus $T$ of rank $2$, roots $\pm e_1\pm e_2,\ \pm e_1,\ \pm e_2$ (eight roots), Weyl group of order $8$. $\mathcal W_5\otimes\mathbb C$ has highest weight $(2,2)$, and the Weyl dimension formula gives $1\cdot3\cdot\tfrac73\cdot5=35$, matching the brief.
- "CT" is the constant term of a Laurent polynomial in the torus coordinates. "$\prod_\alpha$" is read over all roots (see 2a).
- $I_1=W_{ab}{}^{cd}W_{cd}{}^{ef}W_{ef}{}^{ab}$ and $I_2=W_a{}^c{}_b{}^dW_c{}^e{}_d{}^fW_e{}^a{}_f{}^b$ are the two classical cubic Weyl contractions.
- "Stable range" is read as the brief defines it, invariant dimensions for large $n$.
- Screens below are short hand arguments on objects I construct, reported as screens and never as evidence credited to the record.

## Hypothesis inventory

| Hypothesis | Where | Stated? | Used by | Status |
|---|---|---|---|---|
| $G$ compact and connected, $T$ a maximal torus, $W$ its Weyl group | Weyl integration formula | Unstated in A and B | the formula as written | $O(5)$ is disconnected. Holds for $SO(5)$ (see 2b) |
| Product over all roots, factor $1/\lvert W\rvert$ | formula in A | Implicit ("$\prod_\alpha$") | the count | Correct on the all-roots reading (2a) |
| $O(5)$-invariants equal $SO(5)$-invariants on $\mathrm{Sym}^k\mathcal W_5$ | needed to compute the $O(5)$ count with $B_2$ tools | Unstated | every degree of the sequence | True at $n=5$, unwritten (2b) |
| $\mathrm{Sym}^k$ character by Newton from $p_j(t)=\chi(t^j)$ | A | Stated | the count | Correct (2a) |
| The script's output is $14$ and the listed sequence | A, link to [run_n5_constraint_count.py](../scripts/runs/run_n5_constraint_count.py) | Stated as a run | claims 1, 4a, 5 | Unfiled as argument, not opened by rule |
| Stable-range values $1,2,7,19,89$ | A | Stated without source or argument | claim 4 | Degrees 2, 3 screened, degrees 4-6 unfiled |
| $\mathcal W_n$ absolutely irreducible under $O(n)$ | B | Stated as fact, unfiled | claim 6b | Classical for $n\ge4$, and $\mathcal W_n=0$ for $n\le3$ |
| The Lovelock identity at $n=5$ (antisymmetrisation over six indices vanishes) | A ("the contraction identity that first gave it") | Referred to, not quoted in the brief | claim 5 | Classical, the record's own derivation not in the brief |
| An SOS certificate's equations are indexed by a basis of invariant sextics | A, first sentence | Stated | the motivation "constraint count", outside the lemma's statement | Requires a symmetry-reduced (invariant) Gram matrix, which is unstated. Without it the equations are indexed by all sextic monomials. Recorded as an unstated hypothesis of the application, not of L85 |

## 1. The statement $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$

**Verdict: HYPOTHESIS-DEBT.**

The chain on file is: the formula (a classical theorem, unfiled), the Newton recursion for $\mathrm{Sym}^6$ characters (classical, correct), then "**the answer is $14$**" followed by a link to a script. No expansion, no intermediate constant term, no basis of fourteen sextics, no relation count against the stable $89$ is written. Passage B says so itself: "*The $14$ is measured rather than derived.*"

The discrepancy protocol for the debt:

1. Location: [findings/sym3-blocks.md](../findings/sym3-blocks.md) line 68, "with $\mathrm{Sym}^k$ characters from the power sums $p_j(t)=\chi(t^j)$ by Newton, **the answer is $14$**. [run_n5_constraint_count.py](../scripts/runs/run_n5_constraint_count.py)."
2. Concrete failure: the step from the formula to the integer $14$ is the constant term of a Laurent polynomial of total degree in the thousands of monomials (the character of $\mathrm{Sym}^6$ of a $35$-dimensional representation times an eight-factor product), and it appears on file only as the output of a run. A reader cannot check it from the record.
3. Charitable reading: the lemma is labelled "a machine count", so it claims a computation, not a derivation. That reading describes the status accurately but does not discharge the debt under this loop's rule that a statement supported only by a script is HYPOTHESIS-DEBT.

What would have to be proved: either the constant term written out (for example, the $B_2$ plethysm $\mathrm{Sym}^6(V_{(2,2)})$ decomposed to its trivial multiplicity), or an explicit list of $14$ invariant sextics shown independent at $n=5$ together with a proof that they span, for instance the stable $89$ contractions reduced modulo the $n=5$ antisymmetrisation identities with the rank of the relation module computed.

## 2. The method

### 2a. The formula and the character recursion

**Verdict: CONFIRMED AS ALGEBRA.**

- For compact connected $G$ with maximal torus $T$, Weyl's integration formula reads $\int_Gf=\tfrac1{\lvert W\rvert}\int_Tf(t)\prod_{\alpha\in\Phi}(1-t^\alpha)\,dt$ for class functions $f$. With $f=\chi_V$ and $\dim V^G=\int_G\chi_V$, integration over $T$ is the constant term, giving the written formula when $\alpha$ ranges over all roots.
- Newton: $\sum_kh_ks^k=\exp\big(\sum_{j\ge1}p_js^j/j\big)$ gives $k\,h_k=\sum_{j=1}^kp_jh_{k-j}$, and for $t\in T$ acting with eigenvalues $x_i$ on $V$, $p_j=\sum x_i^j=\chi_V(t^j)$ and $h_k=\chi_{\mathrm{Sym}^kV}(t)$. This is what the passage states.

Withdrawn candidate, the range of $\prod_\alpha$ (see section 8).

### 2b. Applying a connected-group formula to $O(5)$

**Verdict: GAP.** The step that makes the $SO(5)$ computation an $O(5)$ count is absent from both passages. It is true at $n=5$ at every degree.

1. Location: line 68, "$\dim V^G=\tfrac1{\lvert W\rvert}\mathrm{CT}\big[\chi\prod_\alpha(1-t^\alpha)\big]$", with $G$ never named, applied to "$\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$" in the same sentence and to the sequence "at $n=5$" in line 70.
2. Concrete failure of the step as an unstated principle: the principle "compute the $O(n)$ count with the connected group's torus" gives the wrong answer at $n=4$, degree $2$. There $\mathcal W_4=\mathcal W^+\oplus\mathcal W^-$ under $SO(4)$, so $\lvert W^+\rvert^2$ and $\lvert W^-\rvert^2$ are independent $SO(4)$-invariant quadratics and the connected count is $2$. An orientation-reversing reflection swaps $\mathcal W^\pm$, so $\lvert W^+\rvert^2-\lvert W^-\rvert^2$ is not $O(4)$-invariant and the $O(4)$ count is $1$. The formula as written therefore needs a hypothesis relating $O(n)$ to $SO(n)$ that the passage does not state.
3. Charitable reading, which I checked and which holds at the lemma's $n$: for $n$ odd, $O(n)=SO(n)\times\{\pm I\}$, and $-I$ acts on a covariant $4$-tensor by $(-1)^4=1$, so trivially on $\mathcal W_5$ and hence on every $\mathrm{Sym}^k\mathcal W_5$. So $(\mathrm{Sym}^k\mathcal W_5)^{O(5)}=(\mathrm{Sym}^k\mathcal W_5)^{SO(5)}$ for every $k$, and the $B_2$ computation, if carried out correctly, is the $O(5)$ count at degrees $2$ through $6$.

The finding stands as GAP rather than a defect in the value: the omitted sentence is the reason the method applies, and it is specific to odd $n$ (item 7).

## 3. "Three hand-checkable rungs" and "three hand checks"

**Verdict: HYPOTHESIS-DEBT.**

1. Location: heading line 52, "a machine count with three hand-checkable rungs"; [results.md](../results.md) line 288, "A machine count with three hand checks"; line 956, "machine-counted with three hand checks".
2. Concrete failure: neither passage names the three rungs, and neither writes a hand check. Passage A contains no hand computation of any entry. Passage B contains one reason, for degree two ("$\mathcal W_n$ is absolutely irreducible, so that count is $1$"), and that reason is offered to retract a claim, not as a rung of the count. The degree-three entry is linked to the Lovelock collapse in line 70, but as a consistency remark about the machine output, not as a hand derivation of $1$ (which needs a spanning statement, a nontrivial relation and a nonvanishing witness, none written). A third rung is not identifiable from the text at all. "Three hand checks" (B) claims they were done, which the brief's passages do not show.
3. Charitable reading: the rungs are degrees $2$ and $3$ at $n=5$ and one further entry (perhaps a stable-range value), each checkable in principle. Degrees $2$ and $3$ are indeed checkable by short argument (screened in 4a and 5). The third remains unnamed, and "checkable" (A) is weaker than "checks" (B). Neither reading supplies a written check.

What would have to be written: the identity of the three rungs and, for each, the hand argument that fixes its value.

## 4. The sequence and "every entry is strictly smaller, which is the syzygies"

### 4a. The values

**Verdict: HYPOTHESIS-DEBT** for degrees $4,5,6$ in both columns. Degrees $2$ and $3$ agree with a hand screen.

- Degree $2$, both columns, screen: an invariant quadratic form on a real representation $V$ with an invariant inner product is $\langle v,Av\rangle$ for a symmetric $A\in\mathrm{End}_G(V)$. When $V$ is absolutely irreducible, $\mathrm{End}_G(V)=\mathbb R$, so the count is $1$. $\mathcal W_5$ is absolutely irreducible under $SO(5)$ (highest weight $(2,2)$, real) and $\mathcal W_n$ under $O(n)$ for large $n$. Both entries are $1$.
- Degree $3$, $n=5$, screen: see section 5, giving $1$. Degree $3$ stable, screen: complete contractions of three trace-free tensors with the Weyl symmetries reduce to $I_1,I_2$, independent for large $n$ (classical). Entry $2$.
- Degrees $4,5,6$: $4,5,14$ and $7,19,89$ appear with no source and no argument. The $n=5$ values are run output. The stable values carry no citation.

Location: line 70, "The sequence at $n=5$ is $1,1,4,5,14$ for degrees $2$ through $6$, against the stable-range $1,2,7,19,89$." Charitable reading: the stable values are standard counts of Weyl scalar invariants in the literature. That may be so, but nothing is filed or cited, so the debt stands.

### 4b. "Every entry is strictly smaller"

**Verdict: REFUTED AS STATED.**

1. Location: line 70, "Every entry is strictly smaller, which is the syzygies".
2. Concrete failure: at degree $2$ the $n=5$ entry is $1$ and the stable entry is $1$, both from the passage's own list and both confirmed by the screen in 4a. $1<1$ is false.
3. Charitable reading: "every entry" means degrees $3$ to $6$. The sentence says "every entry" of lists that begin at degree $2$, so the reading changes the claim. On that reading the strictness at degree $3$ ($1<2$) survives the screen, and degrees $4$-$6$ inherit the debt of 4a. The refutation is of the clause as stated. Passage B records the same failure and its forced nature (6b), so the record already carries the correction.

### 4c. "which is the syzygies"

**Verdict: HYPOTHESIS-DEBT.**

- Location: line 70.
- The clause attributes every deficit to syzygies, with no argument. The drops at $n=5$ come from dimension-dependent linear relations among complete contractions at fixed degree (antisymmetrisation over more than $n$ indices, the second fundamental theorem for $O(n)$). Whether each drop is exactly accounted for by those relations, and whether "syzygies" is meant in that sense or in the sense of relations among ring generators, is not stated. At degree $2$ there is no drop to attribute (4b).
- Charitable reading: "syzygies" is loose shorthand for the $n$-dependent identities. That reading makes the clause plausible, but it remains an unargued attribution at degrees $4$-$6$.

## 5. Degree $3$ and the Lovelock collapse

**Verdict: HYPOTHESIS-DEBT.** At the level of dimension the two are the same fact, the degree-three value is on file only as run output, and the independence is asserted rather than argued.

Screen of the value, by short argument, not credited to the record:

- Upper bound. Every cubic $O(5)$-invariant on $\mathcal W_5$ is a combination of $I_1$ and $I_2$ (first fundamental theorem plus the Weyl symmetries, and $-I$ acts trivially so $SO(5)$ adds nothing). The Lovelock identity, antisymmetrisation of $W\otimes W\otimes W$ over six lower and six upper indices, vanishes identically in dimension $5$ and expands to a combination $c_1I_1+c_2I_2$ with $(c_1,c_2)\ne0$ (it is the Weyl part of the six-dimensional Euler density, which is not identically zero on $\mathcal W_6$). So the count is at most $1$.
- Lower bound. Take a trace-free symmetric $3\times3$ matrix $A=\mathrm{diag}(1,1,-2)$ acting on $\Lambda^2_+\mathbb R^4$, set $W^+=A$, $W^-=0$. This is an algebraic Weyl tensor on $\mathbb R^4$. Extended by zero to $\mathbb R^5$ it keeps the Bianchi identity (componentwise) and is trace-free (the added index contributes $0$ to each trace). As an operator on $\Lambda^2$, $\mathrm{tr}\,\hat W^3=\mathrm{tr}A^3=1+1-8=-6\ne0$, and $I_1$ is a nonzero multiple of this trace. So the count is at least $1$.

Now the claim.

1. Location: line 70, "**degree $3$ being $1$ reproduces the Lovelock collapse by a method sharing nothing with the contraction identity that first gave it**".
2. Concrete failure, two parts.
   - Same fact: given the stable value $2$, the statement "the $n=5$ degree-three count is $1$" is equivalent to "exactly one independent relation holds between $I_1$ and $I_2$ at $n=5$ and they do not both vanish". The Lovelock collapse is that relation. The count reproduces the rank drop, and since the relation space is one-dimensional it forces the relation to be Lovelock's up to scale, but it does not reproduce the coefficients $(c_1,c_2)$ or the identity itself. "Reproduces" is therefore true only as a dimension statement.
   - Independence unargued: "sharing nothing" is asserted with no argument. Both routes rest on the same inputs, the complete-contraction description of invariants and $n=5$ (the torus rank $2$ in one, the six-index antisymmetrisation vanishing in dimension $5$ in the other), and the character route's value is on file only as a run, so the "reproduction" is not checkable from the record.
3. Charitable reading: the remark is methodological, meaning the character integral never writes down an index identity, so agreement is a genuine cross-check. That reading is fair as a description of the two computations. It still leaves the degree-three value as run output and the equivalence of the two facts unstated, which is why the verdict is HYPOTHESIS-DEBT and not REFUTED.

What would have to be written: the degree-three value by hand (as in the screen, or from the constant term), and a statement that the count and the collapse are the same dimension fact, with "reproduces" restricted accordingly.

## 6. Passage B's additions

### 6a. "machine-counted with three hand checks" and "The $14$ is measured rather than derived"

- "machine-counted with three hand checks": HYPOTHESIS-DEBT, the same finding as section 3.
- "*The $14$ is measured rather than derived.*" **CONFIRMED.** It is an accurate description of Passage A (section 1). It also means the landscape line 288's "The invariant dimension at degree six is fourteen", stated as a Lemma without qualification, rests on that measurement. B makes the status visible, which is correct, and does not change the verdict of claim 1.
- B's gap against A: B retracts only degree two. It leaves standing "which is the syzygies" (4c), the Lovelock independence remark (5), the unstated $O(5)$ to $SO(5)$ reduction (2b), and the unidentified rungs (3).

### 6b. The degree-two clause

**Verdict: CONFIRMED** for every $n$ at which $\mathcal W_n\ne0$.

- "**"Every entry is strictly smaller" is false at degree two and forced to be**": correct, by 4b.
- "$\mathcal W_n$ is absolutely irreducible, so that count is $1$ at every $n$": the implication is the argument in 4a (absolutely irreducible real representation with invariant inner product gives a one-dimensional space of invariant quadratic forms). The premise is classical and unfiled. At $n=4$ it holds under $O(4)$ though not under $SO(4)$ (2b), and "that count" is the $O(n)$ count, so the clause is right as written there. "Forced" follows: both columns equal $1$ whatever $n\ge4$.

Scope candidate at $n\le3$ withdrawn (section 8).

## 7. The boundary: degree $2$, odd degrees, $n=5$ against $n\ge6$

**Verdict: CONFIRMED** (no finding beyond 4b and 2b).

- Degree $2$: covered by 4b and 6b.
- Odd degrees: $-I\in O(5)$ acts trivially on $\mathcal W_5$, so there is no parity obstruction to odd-degree invariants, and the nonzero entries at degrees $3$ and $5$ are not contradicted by any sign argument. Degree $3$ is screened at $1$. No finding: degree $5$'s value $5$ is debt under 4a, not a boundary defect.
- $n=5$ against $n\ge6$: the lemma states only $n=5$, where the $O$ to $SO$ reduction holds. The reduction fails in general for even $n$ (the $n=4$ example in 2b). The Lovelock collapse at degree three is specific to $n\le5$, since for $n\ge6$ the six-index antisymmetrisation need not vanish and the stable value $2$ applies. No finding: nothing in either passage extends the count or the method to $n\ge6$, so the transfer risk is recorded against 2b rather than as a scope error.
- Stability threshold: the brief gives the stable column as "large $n$" without a threshold. No claim on file depends on a threshold, so no finding.

## 8. Withdrawn candidates

- **Range of $\prod_\alpha$.** (1) Line 68 writes $\prod_\alpha$ with no range. (2) Over positive roots only, $\tfrac1{\lvert W\rvert}\mathrm{CT}[\chi\prod_{\alpha>0}(1-t^\alpha)]$ is $\tfrac18$ of the true invariant dimension, a wrong formula. (3) Charitable reading: over all roots, which is the standard form and the one matching the factor $1/\lvert W\rvert$. Withdrawn: the notation admits the correct reading and nothing in the text forces the wrong one.
- **"at every $n$" in B at small $n$.** (1) Line 956, "that count is $1$ at every $n$". (2) For $n\le3$, $\mathcal W_n=0$ and $(\mathrm{Sym}^2\mathcal W_n)^{O(n)}=0$. (3) Charitable reading: the premise "$\mathcal W_n$ is absolutely irreducible" already restricts to $n$ where $\mathcal W_n\ne0$, that is $n\ge4$, since the zero space is not irreducible. Withdrawn.
- **The $O(5)$ count could exceed or fall short of the $SO(5)$ count.** (1) Line 68. (2) Looked for an element of $O(5)\setminus SO(5)$ acting nontrivially on an $SO(5)$-invariant. (3) $O(5)\setminus SO(5)=-I\cdot SO(5)$ and $-I$ acts trivially. No such element exists. Withdrawn as a value defect, retained as the GAP of 2b for the missing sentence.

## 9. Falsifying objects and the search for each

| Claim | Object that would falsify it | What I did |
|---|---|---|
| 1, $=14$ | A fifteenth invariant sextic independent of a basis, or a linear relation among a claimed basis of $14$ | No basis is on file to test, and constructing one is building the proof. Not searched, reported as debt |
| 2b, $O(5)$ via $SO(5)$ | An element of $O(5)\setminus SO(5)$ moving an $SO(5)$-invariant | Shown none exists ($-I$ trivial). At $n=4$ exhibited the pseudoscalar $\lvert W^+\rvert^2-\lvert W^-\rvert^2$ as the object that breaks the unstated principle at even $n$ |
| 3, three hand checks | The absence of a written check | Read both passages for any hand computation. Found one reason, for degree two, in B only |
| 4b, strictly smaller | Any degree with equal entries | Degree $2$, $1=1$, exhibited |
| 4a, 4c, degrees $4$-$6$ | A different value or a drop not explained by $n$-dependent identities | Out of reach without computation. Reported as debt |
| 5, degree $3=1$ | A second cubic invariant independent of $I_1$ at $n=5$, or $I_1\equiv I_2\equiv0$ on $\mathcal W_5$ | Excluded the first by the Lovelock relation and the second by the explicit tensor $W^+=\mathrm{diag}(1,1,-2)$, $W^-=0$, extended by zero, with $\mathrm{tr}\,\hat W^3=-6$ |
| 6b, degree-two clause | An $n\ge4$ with a second independent $O(n)$-invariant quadratic | Excluded by absolute irreducibility, and checked $n=4$ separately under $O(4)$ against $SO(4)$ |

## Overall verdict

**HYPOTHESIS-DEBT.** The lemma's value $14$ has no argument on file beyond an unfiled run, which Passage B concedes. The method is correct as algebra, its application to $O(5)$ is a GAP (true at $n=5$ because $-I$ acts trivially, not written), the "three hand checks" are neither identified nor written, and Passage A's "every entry is strictly smaller" is REFUTED AS STATED at degree two, a failure Passage B already records correctly.
