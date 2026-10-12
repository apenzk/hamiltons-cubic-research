# Verifier v412, Lemma L84: the Casimir pair $(C_2,C_4)$ separates every dominant $B_2$ weight, the $21$-value count with three collisions, the six $p_4$ values, the necessity of the generator condition, Passage C, and the Lean declarations

The brief [BRIEF_L84r2.md](BRIEF_L84r2.md) was read cold, and the audit worked from its definitions and quoted passages alone, with no other file of the repository opened. No numerical work was done: every value below is exact and was computed by hand, and no scripts were written. The log is at `agent_logs/verify-L84-v412.log`.

| # | Claim attacked | Verdict | Reason |
|---|---|---|---|
| 1 | Passage A: $(\chi_\lambda(C_2),\chi_\lambda(C_4))$ determines every dominant $\lambda$ | CONFIRMED | each step closes from the Harish-Chandra theorem for the real form, the only reading under which $\mathbb R[C_2]$ is the right exclusion |
| 2 | The Harish-Chandra step: $\chi_\lambda(z)=\gamma(z)(\lambda+\rho)$, $\gamma$ injective, invariants $\mathbb R[p_2,p_4]$ | CONFIRMED | classical, and the proof also uses two unnamed parts of the theorem: $\gamma$ an algebra homomorphism and $\gamma(Z\cap U_n)$ of degree at most $n$ |
| 3 | $\chi_\lambda(C_2)=p_2(\ell)-\tfrac52=c_2(\lambda)$ | CONFIRMED AS ALGEBRA | the identity is exact, and its scale is the convention Passage D fixes, which the Harish-Chandra theorem leaves open |
| 4 | $\gamma(C_4)=a\,p_4+b\,p_2^2+c\,p_2+d$ with $a\ne0$ | CONFIRMED | the invariants of degree at most four are spanned by $1,p_2,p_2^2,p_4$, and $a=0$ puts $C_4$ in $\mathbb R[C_2]$ |
| 5 | $e_1,e_2$ recover $\{\ell_1^2,\ell_2^2\}$, hence $\ell$ and $\lambda$, with $\ell_1>\ell_2>0$ at every dominant weight | CONFIRMED | $\ell_1-\ell_2=a-b+1\ge1$ and $\ell_2=b+\tfrac12\ge\tfrac12$ |
| 6 | $c_2$ takes $21$ values on the $24$ labels, colliding exactly at $30$, $40$, $60$ on the named pairs | CONFIRMED | all $24$ values computed by hand |
| 7 | The six $p_4$ values $7361/8$, $4481/8$, $8521/8$, $14281/8$, $17561/8$, $25625/8$ | CONFIRMED | each computed by hand from $2\ell=(2a+3,2b+1)$ |
| 8 | "No quartic generator is distinguished, and every one serves" | CONFIRMED | on a $c_2$-collision the $C_4$ readings differ by $a\,\Delta p_4$ with $a\ne0$ |
| 9 | "The generator condition is needed": $C_2^2$ reads $(30,900)$ on $(4,1)$ and $(3,3)$ and separates none of the pairs | CONFIRMED | $\chi(C_2^2)=c_2^2$ is a function of $c_2$, and the reading $900$ holds in Passage D's normalisation |
| 10 | Passage C against Passages A and B | CONFIRMED | every clause is a restatement of A or B |
| 11 | Lean: `casimir_pair_separates`, `quartic_shift_still_separates` | CONFIRMED AS ALGEBRA | they state the recovery step on integer dominant weights with rational coefficients, while the Harish-Chandra step and $a\ne0$ stand outside the files |
| 12 | Lean: `single_quartic_worse` | CONFIRMED AS ALGEBRA | its type is the numeral fact $18<21<24$, which carries none of the content its name describes, and no passage relies on it |

**Summary: Lemma L84 is proven as written under the real-form reading of $U(\mathfrak{so}(5))$ that its $\mathbb R[C_2]$ already implies, every hand-checkable number agrees with the table, and the only surviving remarks are presentational (the scale of $C_2$ is a convention and should be said to be one, and the proof's citation of the Harish-Chandra theorem omits the homomorphism and degree parts it uses).**

## 0. Conventions, fixed once

Quoted from the brief:

- "$B_2$ weights are written $\lambda=ae_1+be_2=(a,b)$, dominant when $a\ge b\ge0$ are integers, with $\rho=(\tfrac32,\tfrac12)$ and $\ell=\lambda+\rho$. $W(B_2)$ is the group of signed permutations of $(\ell_1,\ell_2)$. $\chi_\lambda(z)$ is the scalar by which a central $z\in U(\mathfrak{so}(5))$ acts on the irreducible $V_\lambda$."
- "The Harish-Chandra isomorphism is a classical theorem the passages cite by name. Where a step uses it, say which statement of it the step needs."
- Passage D: "$c_2(\lambda)=\lambda_1(\lambda_1+3)+\lambda_2(\lambda_2+1)$", and $p_{2k}(\ell)=\ell_1^{2k}+\ell_2^{2k}$ from Passage B.

## 1. Hypothesis inventory

### 1.1 Hypotheses of the statement (Passage A)

| Hypothesis | Where the proof uses it |
|---|---|
| H1. $C_2$ is the quadratic Casimir of $\mathfrak{so}(5)$ | "So $\chi_\lambda(C_2)=p_2(\ell)-\tfrac52$". The separation uses only that $\gamma(C_2)$ has nonzero $p_2$ coefficient. The readings $30$, $40$, $60$, $900$ use the specific scale of Passage D. |
| H2. $C_4$ is central in $U(\mathfrak{so}(5))$ | the Harish-Chandra step applies to $C_4$ |
| H3. $C_4$ has degree four | the form $\gamma(C_4)=a\,p_4+b\,p_2^2+c\,p_2+d$ |
| H4. $C_4\notin\mathbb R[C_2]$ | $a\ne0$ |
| H5. $\lambda$ dominant ($a\ge b\ge0$ integers) | $\ell_1>\ell_2>0$ |

Every stated hypothesis is used. The multiplicities of Passage D are never used, as Passage A says.

### 1.2 The imported theorem, and which statement of it each step needs

The Harish-Chandra theorem for $\mathfrak g=\mathfrak{so}(5)$, stated for what the proof uses. Let $Z=Z(U(\mathfrak g))$ and $U_n$ the filtration of $U(\mathfrak g)$ by degree. There is a map $\gamma:Z\to S(\mathfrak h)^{W}$ with

- (HC1) $z$ acts on $V_\lambda$ by $\gamma(z)(\lambda+\rho)$ for every dominant integral $\lambda$,
- (HC2) $\gamma$ is injective,
- (HC3) $\gamma$ is an algebra homomorphism with $\gamma(1)=1$,
- (HC4) $\gamma(Z\cap U_n)$ consists of polynomials of degree at most $n$,
- (HC5) together with Chevalley's theorem for $B_2$: $S(\mathfrak h)^W=\mathbb R[p_2,p_4]$ in the coordinates where $W$ acts by signed permutations of $(\ell_1,\ell_2)$.

For the compact real form, $\gamma$ restricts to an injective $\mathbb R$-algebra homomorphism from $Z(U(\mathfrak{so}(5)_{\mathbb R}))$ into the real invariants $\mathbb R[p_2,p_4]$, which is the version the proof writes. Surjectivity is never used.

| Step | Parts needed | Named in the proof |
|---|---|---|
| $\chi_\lambda(C_2)=p_2(\ell)-\tfrac52$ | HC1, HC4, HC5, plus the scale of $C_2$ | HC1, HC5 named. HC4 is used silently. The scale is unstated (section 3). |
| $\gamma(C_4)=a\,p_4+b\,p_2^2+c\,p_2+d$ | HC4, HC5 | HC5 named. HC4 used silently. |
| $a=0\Rightarrow\gamma(C_4)\in\gamma(\mathbb R[C_2])$ | HC3, and $b,c,d$ real | HC3 used silently. Reality comes from HC5 as written over $\mathbb R$. |
| $\gamma$ injective $\Rightarrow C_4\in\mathbb R[C_2]$ | HC2 | named |
| eigenvalue pair determines $(p_2,p_4)$ | HC1 | named |

HC3 and HC4 are parts of the classical theorem, so their use is sound. The citation "By the Harish-Chandra isomorphism" covers them only by the name of the theorem, which the brief allows. This is recorded as a presentational remark and carries no grade.

The recovery step imports the elementary fact that a monic quadratic determines its roots as a multiset, applied to $t^2-e_1t+e_2$ with roots $\ell_1^2,\ell_2^2$. Its only hypothesis is working over a field, satisfied.

### 1.3 Stated but unused, used but unstated

- No finding for stated-but-unused: each of H1 to H5 enters a step.
- Used but unstated: the scale of $C_2$ (section 3, a surviving presentational finding) and the ground field of $U(\mathfrak{so}(5))$ (section 11.1, withdrawn under the real reading).

## 2. Claim 2, the Harish-Chandra step

Passage B: "a central element $z$ acts on $V_\lambda$ by $\gamma(z)(\ell)$, $\ell=\lambda+\rho$, $\rho=(\tfrac32,\tfrac12)$, where $\gamma(z)$ is a $W(B_2)$-invariant polynomial, $\gamma$ is injective, and the $W(B_2)$-invariants are $\mathbb R[p_2,p_4]$".

- $\rho$-shift. Positive roots of $B_2$ in these coordinates are $e_1-e_2$, $e_1+e_2$, $e_1$, $e_2$. Their sum is $(3,1)$, so $\rho=(\tfrac32,\tfrac12)$. The shifted form $\gamma(z)(\lambda+\rho)$ with invariance under the ordinary $W$-action is the standard normalisation of HC1. No finding.
- Injectivity is HC2. No finding.
- Invariants. $W(B_2)$ contains every sign change, so an invariant is a polynomial in $\ell_1^2,\ell_2^2$, symmetric under their swap, hence a polynomial in $\ell_1^2+\ell_2^2=p_2$ and $\ell_1^2\ell_2^2=(p_2^2-p_4)/2$. Over a field of characteristic $0$ this is $\mathbb R[p_2,p_4]$. No finding.

## 3. Claim 3, $\chi_\lambda(C_2)=p_2(\ell)-\tfrac52=c_2(\lambda)$

Algebra, followed step by step. $p_2(\ell)=(a+\tfrac32)^2+(b+\tfrac12)^2=a^2+3a+\tfrac94+b^2+b+\tfrac14$, so $p_2(\ell)-\tfrac52=a(a+3)+b(b+1)=c_2(\lambda)$, matching Passage D. At $\lambda=(0,0)$ this is $0$, the eigenvalue of any Casimir on the trivial representation. Screen on the vector representation $(1,0)$: $c_2=4$, which is the eigenvalue of $-\sum_{i<j}X_{ij}^2$ with $X_{ij}=E_{ij}-E_{ji}$ on $\mathbb R^5$. The identity is exact.

### 3.1 Candidate: the scale of $C_2$ is a convention the proof presents as a consequence

1. Location. Passage B, "So $\chi_\lambda(C_2)=p_2(\ell)-\tfrac52=c_2(\lambda)$". The word "So" follows the Harish-Chandra sentence, but HC1 to HC5 give only $\gamma(C_2)=s\,p_2+t$ with $s\ne0$, and $\chi_{(0,0)}(C_2)=0$ gives $t=-\tfrac52 s$. The value $s=1$ needs a choice of invariant form defining "the quadratic Casimir", which Passage A does not state.
2. Exhibit. The Casimir of the Killing form of $\mathfrak{so}(5)$ acts by $1$ on the adjoint representation $(1,1)$, where $c_2(1,1)=4+2=6$. So it acts by $c_2/6$, and on $(4,1)$ and $(3,3)$ the pair $(C_2,C_2^2)$ reads $(5,25)$, not $(30,900)$.
3. Argue the opposite. The separation claim is invariant under $C_2\mapsto sC_2$ with $s\ne0$, since $\mathbb R[sC_2]=\mathbb R[C_2]$ and the eigenvalue map is injective for one scale if and only if for all. The counts "21 values" and the collision pairs are scale-free. The numerals $30$, $40$, $60$ are stated as values of $c_2$, which Passage D defines. Only the literal reading "$(30,900)$" as an eigenvalue pair of $(C_2,C_2^2)$ depends on the scale, and it is correct in the one normalisation the record defines.

Result: survives only as a presentational finding. Passage A or B should say that $C_2$ is normalised to act by $c_2(\lambda)$, equivalently by the form in which $e_1,e_2$ are orthonormal. No claim of the lemma changes.

## 4. Claim 4, $\gamma(C_4)=a\,p_4+b\,p_2^2+c\,p_2+d$ with $a\ne0$

- Form. By H3 and HC4, $\gamma(C_4)$ has degree at most $4$. By HC5 it lies in $\mathbb R[p_2,p_4]$, where $p_2$ has degree $2$ and $p_4$ degree $4$. The monomials $p_2^ip_4^j$ of degree $2i+4j\le4$ are $1$, $p_2$, $p_2^2$, $p_4$, and these are linearly independent: they are homogeneous of degrees $0,2,4,4$, and $p_2^2$ and $p_4$ are not proportional (their ratio reads $1$ at $\ell=(1,0)$ and $2$ at $\ell=(1,1)$). So every invariant of degree at most four has the stated form. No finding.
- $a=0$. Then $\gamma(C_4)=b\,p_2^2+c\,p_2+d$. With $\gamma(C_2)=p_2-\tfrac52$ and HC3, $\gamma\big(b(C_2+\tfrac52)^2+c(C_2+\tfrac52)+d\big)=\gamma(C_4)$, and HC2 gives $C_4=b(C_2+\tfrac52)^2+c(C_2+\tfrac52)+d\in\mathbb R[C_2]$, contradicting H4. The step needs $b,c,d$ real, supplied by HC5 in the real form. The step closes. No finding beyond the unnamed HC3 noted in section 1.2.
- Degree interpretations (brief item 1). $U(\mathfrak{so}(5))$ is filtered. "Degree four" read as $C_4\in U_4$, as $C_4\in U_4\setminus U_3$, or as the symmetrisation of a homogeneous quartic invariant, always places $C_4$ in $U_4$, which is all the proof uses. No finding.
- "Quartic generator" (heading and Passage C). With $a\ne0$, $\mathbb R[\gamma(C_2),\gamma(C_4)]=\mathbb R[p_2,p_4]$, so $C_4\notin\mathbb R[C_2]$ in degree four is the same as $C_4$ being a quartic generator of $Z$ together with $C_2$. The passages do not argue this equivalence, but the statement body uses the precise condition H4, and the heading and Passage C landscape add the word "generator" beside it. No finding.

## 5. Claim 5, recovering $\lambda$

- $(\chi_\lambda(C_2),\chi_\lambda(C_4))$ determines $(p_2,p_4)$: $p_2=\chi_\lambda(C_2)+\tfrac52$ and $p_4=\big(\chi_\lambda(C_4)-b\,p_2^2-c\,p_2-d\big)/a$, for the fixed $a,b,c,d$ of the given $C_4$. Closes.
- $e_1=\ell_1^2+\ell_2^2=p_2$. $p_2^2=p_4+2\ell_1^2\ell_2^2$, so $e_2=\ell_1^2\ell_2^2=(p_2^2-p_4)/2$. Closes.
- The multiset $\{\ell_1^2,\ell_2^2\}$ is the root multiset of $t^2-e_1t+e_2$. With $\ell_1>\ell_2>0$ the larger root is $\ell_1^2$ and positive square roots give $\ell$, then $\lambda=\ell-\rho$. Closes.
- $\ell_1>\ell_2>0$ at every dominant weight: $\ell_1-\ell_2=a-b+1\ge1$ and $\ell_2=b+\tfrac12\ge\tfrac12$. Closes, and the step would close with $\ell_1\ge\ell_2\ge0$.

## 6. Claims 6 and 7, the collisions and the six $p_4$ values

$a(a+3)$ for $a=0,\dots,6$: $0,4,10,18,28,40,54$. $b(b+1)$ for $b=0,1,2,3,4,6$: $0,2,6,12,20,42$.

| label | $c_2$ | label | $c_2$ | label | $c_2$ |
|---|---|---|---|---|---|
| $(4,2)$ | $34$ | $(3,0)$ | $18$ | $(5,3)$ | $52$ |
| $(2,2)$ | $16$ | $(2,0)$ | $10$ | $(5,1)$ | $42$ |
| $(3,2)$ | $24$ | $(6,6)$ | $96$ | $(5,0)$ | $40$ |
| $(5,2)$ | $46$ | $(6,4)$ | $74$ | $(3,3)$ | $30$ |
| $(4,3)$ | $40$ | $(6,3)$ | $66$ | $(1,0)$ | $4$ |
| $(4,4)$ | $48$ | $(6,2)$ | $60$ | $(0,0)$ | $0$ |
| $(4,1)$ | $30$ | $(6,0)$ | $54$ | | |
| $(3,1)$ | $20$ | $(5,4)$ | $60$ | | |
| $(4,0)$ | $28$ | | | | |
| $(2,1)$ | $12$ | | | | |

Sorted: $0,4,10,12,16,18,20,24,28,30,30,34,40,40,42,46,48,52,54,60,60,66,74,96$. That is $24$ entries and $21$ distinct values, with the repeats exactly $30=\{(4,1),(3,3)\}$, $40=\{(4,3),(5,0)\}$, $60=\{(5,4),(6,2)\}$ and no triple. Claim 6 CONFIRMED.

With $2\ell=(2a+3,2b+1)$, $p_4=\big((2a+3)^4+(2b+1)^4\big)/16$:

| label | $2\ell$ | fourth powers | $p_4$ | stated |
|---|---|---|---|---|
| $(4,1)$ | $(11,3)$ | $14641+81=14722$ | $7361/8$ | $7361/8$ |
| $(3,3)$ | $(9,7)$ | $6561+2401=8962$ | $4481/8$ | $4481/8$ |
| $(4,3)$ | $(11,7)$ | $14641+2401=17042$ | $8521/8$ | $8521/8$ |
| $(5,0)$ | $(13,1)$ | $28561+1=28562$ | $14281/8$ | $14281/8$ |
| $(5,4)$ | $(13,9)$ | $28561+6561=35122$ | $17561/8$ | $17561/8$ |
| $(6,2)$ | $(15,5)$ | $50625+625=51250$ | $25625/8$ | $25625/8$ |

Cross-check on one pair: $p_2(4,1)=(121+9)/4=\tfrac{65}{2}=30+\tfrac52$ and $p_2(3,3)=(81+49)/4=\tfrac{65}{2}$. All six values and the three inequalities CONFIRMED.

## 7. Claim 8, "every one serves"

On a pair with equal $c_2$, $p_2$ is equal, so $\chi(C_4)$ differs by $a\,(p_4-p_4')$. With $a\ne0$ and the three $p_4$ differences $2880/8$, $-5760/8$, $-8064/8$ all nonzero, every admissible $C_4$ separates each pair. This is a special case of claim 1. CONFIRMED.

## 8. Claim 9, the generator condition is needed

- $C_2^2$ is central, lies in $U_4$, and lies in $\mathbb R[C_2]$. CONFIRMED.
- $\chi_\lambda(C_2^2)=c_2(\lambda)^2$, so the pairs read $(30,900)$, $(40,1600)$, $(60,3600)$ on both members. "Separates none of the three colliding pairs" CONFIRMED.
- As a witness that H4 cannot be dropped, one element of $\mathbb R[C_2]\cap U_4$ failing on one collision suffices, and it is supplied. The universal behind it (every element of $\mathbb R[C_2]$ is constant on $c_2$-fibres) is immediate. CONFIRMED. The reading $900$ is in Passage D's scale (section 3.1).

## 9. Claim 10, Passage C against Passages A and B

| Clause of Passage C | Against A and B |
|---|---|
| landscape: "$C_2$ and any quartic central generator $C_4\notin\mathbb R[C_2]$ together separate every dominant $B_2$ weight" | A's statement, with "generator" as in section 4. No finding. |
| "through the Harish-Chandra isomorphism onto $\mathbb R[p_2,p_4]$" | B's proof. "Onto" is surjectivity, true and unused. No finding. |
| "On the $24$ labels of Observation L83, $C_2$ alone takes $21$ values" | B and section 6. Scale-free. No finding. |
| detail: "a central element of degree four not in $\mathbb R[C_2]$" | A's H2 to H4. No finding. |
| "$\chi_\lambda(C_4)$ carries $p_4$ with a nonzero coefficient" | $a\ne0$, section 4. No finding. |
| "$\ell_1>\ell_2>0$ lets $(p_2,p_4)$ recover $\ell$" | section 5. No finding. |
| "The condition is needed: $C_2^2$ reads $(30,900)$ on both $(4,1)$ and $(3,3)$" | section 8. No finding. |
| "$c_2$ takes $21$ values with collisions at $30$, $40$ and $60$, which $p_4$ separates" | section 6. No finding. |
| "holds for every dominant weight and does not depend on the table's multiplicities" | the proof never uses multiplicities. No finding. |

## 10. Claims 11 and 12, the Lean files (brief item 8, standing item 5)

- `casimir_pair_separates`: binders `a b a' b' : ℕ`, hypotheses `b ≤ a`, `b' ≤ a'`, `p2 a b = p2 a' b'`, `p4 a b = p4 a' b'`, conclusion `a = a' ∧ b = b'`, with `p2`, `p4` evaluated at $\ell=(a+\tfrac32,b+\tfrac12)$ over `ℚ`. This is exactly the recovery step of section 5, over all integer dominant weights, including the boundary. It matches the domain of Passage A under the brief's integer definition of dominance.
- `quartic_shift_still_separates`: the same with the second coordinate $p_4+\alpha p_2^2+\beta p_2+\gamma$, that is $\gamma(C_4)/a$, with $\alpha,\beta,\gamma\in\mathbb Q$. It covers the case $a=1$ and rational coefficients. The statement has real $b,c,d$ and any $a\ne0$. The rescaling by $a$ and the passage from $\mathbb Q$ to $\mathbb R$ are outside the file (the proof is linear cancellation and would carry over, but the file does not state it).
- `p2_eq_c2_add` states $p_2=c_2+\tfrac52$. No theorem composes it with `casimir_pair_separates`, so the file states separation by $(p_2,p_4)$ and never by $(c_2,\cdot)$.
- Outside the files entirely: $U(\mathfrak{so}(5))$, its centre, $\chi_\lambda$, the Harish-Chandra theorem (HC1 to HC5), H3, H4 and the deduction $a\ne0$. The files formalise the elementary layer only.
- `c2_distinct_21`, `c2_distinct`, `three_merges`, `no_triple`, `colliding_values` depend on `table` from L83, which the brief does not quote. Whether `table` is Passage D's list is outside what I can check. The hand values of section 6 agree with each statement. `three_collisions` and `collision_*` evaluate `c2` at six blocks without stating that they lie in `table`, and their third fields (multiplicities $2,1,2,1,1,1$) agree with Passage D.
- `p4_splits_the_collisions` and `p4_collision_values` agree with section 6.
- `alpha_half_collides`: $p_4-\tfrac12p_2^2=\tfrac12(\ell_1^2-\ell_2^2)^2$. At $(2,2)$, $\ell_1^2-\ell_2^2=\tfrac{49-25}{4}=6$, at $(1,0)$ it is $\tfrac{25-1}{4}=6$, so both read $18$, while $c_2$ reads $16$ and $4$. True, and it is not claimed in Passages A to C.
- `single_quartic_worse`: its type is `18 < 21 ∧ 21 < 24`, a numeral fact. The name describes a comparison between a single quartic and $C_2$, which the type does not contain. No passage relies on it. Recorded as a Lean naming finding with no effect on the lemma.
- `c2_sq_distinct` (21 values of $c_2^2$) agrees with section 8. `sq_same_fibres`, `c2Q_nonneg`, `rho_norm_sq`, `rho_strictly_decreasing`, `c2_nonneg`, `sq_injective_nat` are true auxiliaries, and `sq_same_fibres` and `c2Q_nonneg` are unused by the other declarations.

## 11. Standing list and the brief's items

### 11.1 Withdrawn candidate: the ground field

1. Location. Passage A, "$C_4$ a central element of degree four in $U(\mathfrak{so}(5))$ with $C_4\notin\mathbb R[C_2]$", and Passage B, "$a=0$ would put $\gamma(C_4)$ in $\gamma(\mathbb R[C_2])$". Neither passage says whether $\mathfrak{so}(5)$ is the real or complex Lie algebra.
2. Exhibit. If $U(\mathfrak{so}(5))$ is the complex enveloping algebra, $C_4=iC_2^2$ is central, lies in $U_4$ and is not in $\mathbb R[C_2]$, yet $\chi(C_4)=i\,c_2^2$ reads $900i$ on both $(4,1)$ and $(3,3)$, so the pair does not separate them. Here $\gamma(C_4)=i(p_2-\tfrac52)^2$ has $a=0$ with complex $b,c,d$.
3. Argue the opposite. The passages write $\mathbb R[C_2]$, $\mathbb R[p_2,p_4]$ and call the lemma "an $SO(5)$ statement", which is the compact real form with real enveloping algebra. Under that reading $C_4=iC_2^2$ is not an element of $U(\mathfrak{so}(5))$, $\gamma$ lands in real invariants, $b,c,d$ are real, and section 4 closes.

Withdrawn: the real reading is the one the notation already fixes. Saying "real" in the statement would remove the ambiguity.

### 11.2 The standing list

1. Hypothesis inventory: section 1. All stated hypotheses used. HC3 and HC4 used and unnamed but classical. The scale of $C_2$ unstated (section 3.1).
2. Quantifier order and scope. The statement reads: for every $C_4$ satisfying H2 to H4, for all dominant $\lambda,\mu$, equal eigenvalue pairs imply $\lambda=\mu$. The proof fixes $C_4$ (hence $a,b,c,d$) before $\lambda$, and the recovery formulas use those fixed coefficients. Order matches. No finding.
3. Range edges. $\lambda=(0,0)$: $\ell=(\tfrac32,\tfrac12)$, $\ell_1>\ell_2>0$, $c_2=0$, $p_2=\tfrac52$. $b=0$: $\ell_2=\tfrac12>0$. $a=b$: $\ell_1-\ell_2=1>0$, and the table's $(2,2)$, $(3,3)$, $(4,4)$, $(6,6)$ sit there. No finding.
4. Proven versus used. Proven for every dominant weight, used on the $24$ labels, all of which satisfy $a\ge b\ge0$. No subfamily gap. No finding.
5. Lean: section 10.

Traps, by name.

- Range boundaries: no finding (item 3).
- Subfamily used in general: no finding (item 4). The Lean layer covers all integer dominant weights.
- Hypothesis stated but unused, or used but unstated: the scale of $C_2$ (section 3.1, presentational) and the ground field (section 11.1, withdrawn).
- A universal claim with no witness: "the generator condition is needed" has its witness $C_2^2$. "Every one serves" follows from the proof. No finding.
- An imported theorem whose hypotheses were never checked: the Harish-Chandra theorem applies to any complex semisimple Lie algebra or its compact real form, and $\mathfrak{so}(5)$ is simple of type $B_2$. Chevalley's theorem needs a finite reflection group in characteristic $0$, and $W(B_2)$ is one. No finding.
- A normalisation taken from the wrong source: the scale of $C_2$ matches Passage D's $c_2$ and the vector-representation screen, so the source is consistent. The finding is that it is not stated (section 3.1).

### 11.3 The brief's items

1. Statement's hypotheses. "Degree four" means membership of $U_4$ under every reading, which is what the proof uses (section 4). $C_4\notin\mathbb R[C_2]$ is right for the real enveloping algebra (section 11.1). "Determines every dominant $B_2$ weight" means injectivity of $\lambda\mapsto(\chi_\lambda(C_2),\chi_\lambda(C_4))$ on dominant weights, which is what the proof delivers, and constructively for fixed $C_4$.
2. Harish-Chandra step. $\rho$-shift, injectivity and invariants confirmed (section 2). $\chi_\lambda(C_2)=p_2-\tfrac52=c_2$ matches Passage D exactly, with the scale a convention (section 3.1).
3. Form of $\gamma(C_4)$. Every invariant of degree at most four has the form, and $a=0$ puts $C_4$ in $\mathbb R[C_2]$ via HC3 and HC2 (section 4).
4. Recovery. $e_1=p_2$, $e_2=(p_2^2-p_4)/2$ correct, the multiset is recovered, and $\ell_1>\ell_2>0$ holds at every dominant weight (section 5).
5. Collisions. $21$ values with exactly the three named pairs, and all six $p_4$ values, by hand (section 6).
6. Generator condition. $C_2^2$ central, degree four, in $\mathbb R[C_2]$, separates none of the pairs, reads $(30,900)$ in Passage D's scale (section 8).
7. Passage C. Every clause agrees with A and B, "any quartic central generator" is equivalent to H3 with H4, and "$C_2$ alone takes $21$ values" is correct (section 9).
8. Passage E. `casimir_pair_separates` states the recovery step over integer dominant weights. The Harish-Chandra step, H4 and $a\ne0$, the rescaling by $a$, and real coefficients stand outside the files. `single_quartic_worse` carries none of the content its name describes (section 10).
9. Boundary. $(0,0)$, $b=0$, $a=b$ all satisfy $\ell_1>\ell_2>0$ (item 3 above). $SO(5)$ against $O(5)$: an $O(5)$ irreducible $V_\lambda\otimes\det^{\varepsilon}$ restricts to the same $\mathfrak{so}(5)$-module for $\varepsilon=0,1$, so the Casimir pair separates $SO(5)$ labels and cannot see $\varepsilon$. Passage A calls it "an $SO(5)$ statement about labels", which is exactly what is proven. No finding. Spin weights with $a,b\in\tfrac12+\mathbb Z$ lie outside the brief's definition of dominant, and the proof's steps never use integrality, so the claim would hold there as well. No finding.

## 12. What would break it

- An object that would falsify the statement: two distinct dominant weights $\lambda\ne\mu$ with $p_2(\lambda+\rho)=p_2(\mu+\rho)$ and $p_4(\lambda+\rho)=p_4(\mu+\rho)$, or a central $C_4\in U_4\setminus\mathbb R[C_2]$ whose $\gamma$-image has $a=0$.
- What I did to look. The first is ruled out by the algebra of section 5, which I followed step by step, and in particular it would need $\{\ell_1^2,\ell_2^2\}=\{\mu_1^2,\mu_2^2\}$ with both in the region $\ell_1>\ell_2>0$. I checked the three $c_2$-collisions of the table directly (section 6) and the $\alpha=-\tfrac12$ collision of `alpha_half_collides`, which differs in $c_2$. For the second, I followed the $a=0$ deduction (section 4) and constructed the one object that escapes it, $iC_2^2$, which exists only under the complex reading (section 11.1). A third route, a normalisation that made $\gamma(C_2)$ constant, is impossible because $C_2$ acts by $4\ne0$ on $(1,0)$.

## 13. Verdict

**PROVEN**

The lemma holds as written for the real enveloping algebra that its own notation fixes. Presentational remarks for the round, none of which changes a claim: state that $C_2$ is normalised to act by $c_2(\lambda)$, name the homomorphism and degree-filtration parts of the Harish-Chandra theorem where the proof uses them, and consider renaming or removing the Lean declaration `single_quartic_worse`.
