# Verifier v411, Lemma L84: Casimir separation by $(C_2,C_4)$, the $21$ values of $c_2$ on the $24$ labels, the six $p_4$ values, the necessity of the generator condition, and the Lean statements

The brief was cold and I worked from its definitions and the quoted passages only, following no link out of it. No numerical work was done and every value below is exact and computed by hand. No scripts were written and no Lean build was run: the Lean declarations are checked as statements. The log is at [agent_logs/verify-L84-v411.log](../agent_logs/verify-L84-v411.log).

| # | Claim attacked | Verdict | Reason |
|---|---|---|---|
| 1 | Statement (Passage A): $\lambda\mapsto(\chi_\lambda(C_2),\chi_\lambda(C_4))$ is injective on dominant weights for every central $C_4$ of degree four with $C_4\notin\mathbb R[C_2]$ | CONFIRMED | every step follows from the filtered Harish-Chandra theorem, Chevalley's invariants for $W(B_2)$, and $\ell_1>\ell_2>0$ |
| 2 | $\chi_\lambda(C_2)=p_2(\ell)-\tfrac52=c_2(\lambda)$ | CONFIRMED AS ALGEBRA | $p_2(\ell)-\tfrac52=c_2(\lambda)$ identically, the first equality holds in the normalisation where $e_1,e_2$ are orthonormal, which is unnamed and immaterial to the lemma |
| 3 | $\gamma(C_4)=a\,p_4+b\,p_2^2+c\,p_2+d$ with $a\ne0$ | CONFIRMED | the invariants of degree at most four are spanned by $1,p_2,p_2^2,p_4$, and $a=0$ gives $C_4\in\mathbb R[C_2]$ by injectivity |
| 4 | $(p_2,p_4)$ recovers $\ell$ and $\lambda$ | CONFIRMED | $p_2^2-p_4=2\ell_1^2\ell_2^2$, and $\ell_1>\ell_2>0$ holds at every dominant weight including $(0,0)$ |
| 5 | $c_2$ takes $21$ values on the $24$ labels, colliding exactly at the three named pairs | CONFIRMED | all $24$ values computed by hand |
| 6 | The six $p_4$ values $7361/8,\ 4481/8,\ 8521/8,\ 14281/8,\ 17561/8,\ 25625/8$ | CONFIRMED | $p_4=\big((2a+3)^4+(2b+1)^4\big)/16$ evaluated at each label |
| 7 | The generator condition is needed, $C_2^2$ reads $(30,900)$ on $(4,1)$ and $(3,3)$ | CONFIRMED | $C_2^2$ is central of degree four in $\mathbb R[C_2]$ and its eigenvalue is a function of $c_2$ |
| 8 | Passage C against Passages A and B | CONFIRMED | every clause matches, "any quartic central generator" is a subcase of the proven hypothesis |
| 9 | Passage E: casimir_pair_separates and its companions | CONFIRMED | states injectivity of $(p_2,p_4)$ on $\{b\le a\}\subset\mathbb N^2$, the Harish-Chandra step stands outside the file, one declaration name overstates its type |
| 10 | Boundary: $\lambda=(0,0)$, $b=0$, $a=b$, $SO(5)$ against $O(5)$ | CONFIRMED | $\ell_2=b+\tfrac12>0$ and $\ell_1-\ell_2=a-b+1>0$ throughout, and the statement is scoped to $SO(5)$ labels |

**Summary: Lemma L84 is proven as stated for every dominant weight, all table-level readings check by hand, and the only surviving remarks are an unnamed (and immaterial) normalisation of $C_2$ and a Lean declaration whose name claims more than its type.**

## 0. Conventions, fixed once

Quoted from the brief:

- "$B_2$ weights are written $\lambda=ae_1+be_2=(a,b)$, dominant when $a\ge b\ge0$ are integers, with $\rho=(\tfrac32,\tfrac12)$ and $\ell=\lambda+\rho$. $W(B_2)$ is the group of signed permutations of $(\ell_1,\ell_2)$. $\chi_\lambda(z)$ is the scalar by which a central $z\in U(\mathfrak{so}(5))$ acts on the irreducible $V_\lambda$."
- Passage D: "$c_2(\lambda)=\lambda_1(\lambda_1+3)+\lambda_2(\lambda_2+1)$."
- Passage B: "$p_{2k}(\ell)=\ell_1^{2k}+\ell_2^{2k}$."

A notational note: Passage B uses $a,b,c,d$ for the coefficients of $\gamma(C_4)$ while the definitions use $(a,b)$ for the label. In this report the coefficients are written $a,b,c,d$ only in Section 3, and labels are $(a,b)$ everywhere else. The clash has no mathematical effect inside Passage B, which writes the weight as $\lambda$ and $\ell$.

The positive roots of $B_2$ in these coordinates are $e_1-e_2,\ e_1+e_2,\ e_1,\ e_2$, with sum $3e_1+e_2$, so $\rho=(\tfrac32,\tfrac12)$ as stated. The simple roots are $e_1-e_2$ and $e_2$, so dominance is $a\ge b\ge 0$ as stated.

## 1. Hypothesis inventory

### 1.1 Hypotheses of the statement (Passage A)

| Hypothesis | Where the proof uses it |
|---|---|
| H1. $C_2$ is the quadratic Casimir of $\mathfrak{so}(5)$ | "$\chi_\lambda(C_2)=p_2(\ell)-\tfrac52$", and through it $p_2=\gamma(C_2)+\tfrac52$ in the step $a=0\Rightarrow C_4\in\mathbb R[C_2]$ |
| H2. $C_4$ is central in $U(\mathfrak{so}(5))$ | the Harish-Chandra step, which applies only to central elements |
| H3. $C_4$ has degree four | the form $\gamma(C_4)=a\,p_4+b\,p_2^2+c\,p_2+d$, via the filtration bound $\deg\gamma(z)\le n$ for $z\in U_n$ |
| H4. $C_4\notin\mathbb R[C_2]$ | $a\ne0$ |
| H5. $\lambda$ is a dominant $B_2$ weight | $\ell_1>\ell_2>0$ in the recovery step |

Every hypothesis is used. No step uses a hypothesis of the statement that is absent from this list, apart from the normalisation of H1 (Section 2.2) which the conclusion does not need.

### 1.2 Imported theorems, with their hypotheses checked against the object

- **Harish-Chandra isomorphism.** For $\mathfrak g$ complex semisimple with Cartan $\mathfrak h$ and Weyl group $W$, there is an algebra isomorphism $\gamma:Z(U(\mathfrak g))\to S(\mathfrak h)^W$ (the $\rho$-shifted projection) such that $z$ acts on every highest weight module of highest weight $\lambda$ by $\gamma(z)(\lambda+\rho)$, and $\gamma$ carries $Z\cap U_n$ into polynomials of degree at most $n$ (its associated graded map is the Chevalley restriction $S(\mathfrak g)^{\mathfrak g}\to S(\mathfrak h)^W$). Checked against the object: $\mathfrak{so}(5)$ is simple, its complexification is $B_2$, $Z(U(\mathfrak{so}(5)))\otimes\mathbb C=Z(U(\mathfrak{so}(5,\mathbb C)))$, and $V_\lambda$ is a finite-dimensional irreducible highest weight module. The proof uses four pieces of it: (i) the $\rho$-shifted evaluation formula, (ii) $W$-invariance of $\gamma(z)$, (iii) that $\gamma$ is an injective algebra homomorphism, (iv) the filtration bound. Pieces (i) to (iii) are named in Passage B. Piece (iv) is used in writing $\gamma(C_4)$ with degree at most four and is not named. It is part of the classical theorem, so this is a naming remark and carries no debt.
- **Chevalley's theorem for $W(B_2)$.** The invariants of the signed permutation group on $(\ell_1,\ell_2)$ in characteristic zero are the symmetric polynomials in $\ell_1^2,\ell_2^2$, which are $\mathbb R[e_1,e_2]$ with $e_1=\ell_1^2+\ell_2^2$, $e_2=\ell_1^2\ell_2^2$, and equal $\mathbb R[p_2,p_4]$ because $p_2=e_1$ and $p_4=e_1^2-2e_2$. Hypotheses (finite reflection group, characteristic zero) hold. Used as "the $W(B_2)$-invariants are $\mathbb R[p_2,p_4]$".
- **The Casimir eigenvalue formula.** With respect to an invariant form $(\,,)$, the Casimir acts on $V_\lambda$ by $(\lambda,\lambda+2\rho)$. This is what "So $\chi_\lambda(C_2)=p_2(\ell)-\tfrac52$" needs beyond Harish-Chandra: Harish-Chandra alone gives $\gamma(C_2)=\alpha\,p_2+\beta$, and the formula fixes $\alpha=1$, $\beta=-|\rho|^2$ in the form for which $e_1,e_2$ are orthonormal. Not cited in Passage B, classical.
- **Reconstruction of a multiset from its elementary symmetric functions.** $\{\ell_1^2,\ell_2^2\}$ is the root multiset of $t^2-e_1t+e_2$. No hypotheses beyond a field.

### 1.3 Which the written proof actually uses

All of 1.1 and all of 1.2. No stated hypothesis is idle, and no used hypothesis is unstated except the two classical facts named above (filtration bound, Casimir eigenvalue formula), which are standard mathematics and not debt.

## 2. Claims 1 and 2: the Harish-Chandra step

### 2.1 The chain

1. $C_2,C_4$ are central (H2), so by Harish-Chandra (i) $\chi_\lambda(C_j)=\gamma(C_j)(\ell)$ with $\ell=\lambda+\rho$. Follows.
2. $\gamma(C_j)\in S(\mathfrak h)^{W}=\mathbb R[p_2,p_4]$ by (ii) and Chevalley. Follows.
3. $\gamma(C_2)=p_2-\tfrac52$. Needs the Casimir eigenvalue formula and a normalisation (2.2).
4. The form of $\gamma(C_4)$ and $a\ne0$ (Section 3).
5. $p_2(\ell)=\chi_\lambda(C_2)+\tfrac52$ and $p_4(\ell)=\big(\chi_\lambda(C_4)-b\,p_2(\ell)^2-c\,p_2(\ell)-d\big)/a$, where $a,b,c,d$ are fixed by $C_4$ and independent of $\lambda$. So the pair of eigenvalues determines $(p_2(\ell),p_4(\ell))$. Follows, and uses $a\ne0$.
6. Recovery of $\ell$ and $\lambda$ (Section 4).

Quantifier order: $C_4$ is fixed first, its coefficients $a,b,c,d$ are then fixed, and the injectivity is over $\lambda$. The statement's "determines every dominant $B_2$ weight" is exactly this order. No finding.

### 2.2 The identity $\chi_\lambda(C_2)=p_2(\ell)-\tfrac52=c_2(\lambda)$

The second equality is algebra: $(a+\tfrac32)^2+(b+\tfrac12)^2-\tfrac52=a^2+3a+\tfrac94+b^2+b+\tfrac14-\tfrac52=a(a+3)+b(b+1)$, which is Passage D's $c_2$. Also $|\rho|^2=\tfrac94+\tfrac14=\tfrac52$. Confirmed.

The first equality is $(\lambda,\lambda+2\rho)=|\ell|^2-|\rho|^2$ in the form for which $e_1,e_2$ are orthonormal (long roots $\pm e_1\pm e_2$ of squared length $2$). This is the normalised form. See candidate W2 in Section 11 for the record: the normalisation is unnamed, and the lemma's conclusions are invariant under it.

Real against complex coefficients: see candidate W1 in Section 11.

## 3. Claim 3: the form of $\gamma(C_4)$ and $a\ne0$

- By the filtration bound, $\deg\gamma(C_4)\le4$. Because $-1\in W(B_2)$, every invariant is even. The homogeneous invariants are: degree $0$, spanned by $1$; degree $2$, symmetric linear forms in $\ell_1^2,\ell_2^2$, spanned by $p_2$; degree $4$, symmetric quadratic forms in $\ell_1^2,\ell_2^2$, a space of dimension $2$ spanned by $\ell_1^4+\ell_2^4=p_4$ and $(\ell_1^2+\ell_2^2)^2=p_2^2$ (these are independent, since $p_2^2-p_4=2\ell_1^2\ell_2^2\ne0$). So every invariant of degree at most four is $a\,p_4+b\,p_2^2+c\,p_2+d$. Confirmed.
- If $a=0$ then, with $p_2=\gamma(C_2)+\tfrac52$ and $\gamma$ an algebra homomorphism, $\gamma(C_4)=\gamma\big(b(C_2+\tfrac52)^2+c(C_2+\tfrac52)+d\big)$, and injectivity gives $C_4=b(C_2+\tfrac52)^2+c(C_2+\tfrac52)+d\in\mathbb R[C_2]$. The contrapositive is $a\ne0$ under H4. The step uses "$\gamma$ is a homomorphism" implicitly in "$\gamma(\mathbb R[C_2])$", and that is part of the named theorem. Confirmed.
- The converse also holds (a $C_4$ with $a\ne0$ is not in $\mathbb R[C_2]$, since every element of $\gamma(\mathbb R[C_2])=\mathbb R[p_2]$ has zero $p_4$ coefficient), so the hypothesis H4 is exactly $a\ne0$ on degree-four central elements. The proof needs only the direction it proves.
- What "a central element of degree four" must mean for the step: an element of $Z\cap U_4$ in the PBW filtration. Any reasonable reading (filtration degree exactly four, or the symmetrisation of a quartic invariant of $S(\mathfrak g)$) lies in $Z\cap U_4$, so the step covers all of them. A central element of filtration degree at most three has $\gamma$ of degree at most three, hence in $\mathrm{span}\{1,p_2\}$, hence in $\mathbb R[C_2]$, so H4 already forces filtration degree exactly four. No finding.

## 4. Claim 4: recovering $\lambda$

- $e_1=p_2$ is the definition. $p_2^2=\ell_1^4+2\ell_1^2\ell_2^2+\ell_2^4=p_4+2e_2$, so $e_2=(p_2^2-p_4)/2$. Confirmed.
- $e_1,e_2$ determine the multiset $\{\ell_1^2,\ell_2^2\}$ as the roots of $t^2-e_1t+e_2$. Confirmed.
- For dominant $\lambda=(a,b)$: $\ell_2=b+\tfrac12\ge\tfrac12>0$ and $\ell_1-\ell_2=a-b+1\ge1>0$. So $\ell_1^2$ is the larger root and $\ell_2^2$ the smaller, and both square roots are the positive ones. So $\ell$, and $\lambda=\ell-\rho$, are determined. Passage B asserts "$\ell_1>\ell_2>0$" without this one-line derivation. The derivation is immediate from the definitions and the brief's dominance condition, so I record no debt. The step would go through with $\ell_1\ge\ell_2\ge0$, so strictness is more than is needed.
- Passage B's phrase "For a dominant weight $\ell_1>\ell_2>0$" reads "for $\lambda$ dominant, $\ell$ satisfies $\ell_1>\ell_2>0$". That is the reading used above.

## 5. Claim 5: $21$ distinct values of $c_2$ on Passage D's $24$ labels

Passage D lists $2+1+9+12=24$ labels. With $c_2(a,b)=a(a+3)+b(b+1)$:

| label | $c_2$ | label | $c_2$ | label | $c_2$ |
|---|---|---|---|---|---|
| $(4,2)$ | $28+6=34$ | $(3,1)$ | $18+2=20$ | $(6,0)$ | $54$ |
| $(2,2)$ | $10+6=16$ | $(4,0)$ | $28$ | $(5,4)$ | $40+20=60$ |
| $(3,2)$ | $18+6=24$ | $(2,1)$ | $10+2=12$ | $(5,3)$ | $40+12=52$ |
| $(5,2)$ | $40+6=46$ | $(3,0)$ | $18$ | $(5,1)$ | $40+2=42$ |
| $(4,3)$ | $28+12=40$ | $(2,0)$ | $10$ | $(5,0)$ | $40$ |
| $(4,4)$ | $28+20=48$ | $(6,6)$ | $54+42=96$ | $(3,3)$ | $18+12=30$ |
| $(4,1)$ | $28+2=30$ | $(6,4)$ | $54+20=74$ | $(1,0)$ | $4$ |
| $(6,3)$ | $54+12=66$ | $(6,2)$ | $54+6=60$ | $(0,0)$ | $0$ |

Sorted: $0,4,10,12,16,18,20,24,28,30,30,34,40,40,42,46,48,52,54,60,60,66,74,96$. The distinct values are $0,4,10,12,16,18,20,24,28,30,34,40,42,46,48,52,54,60,66,74,96$, which is $21$. The repeated values are exactly $30$ on $(4,1),(3,3)$, $40$ on $(4,3),(5,0)$ and $60$ on $(5,4),(6,2)$, each repeated once, with no triple. Confirmed. The count $21$ is invariant under any affine rescaling $c_2\mapsto s\,c_2+t$ with $s\ne0$, so it does not depend on the normalisation of $C_2$.

Screen of the collision claim through $p_2$: at $(4,1)$, $\ell=(\tfrac{11}2,\tfrac32)$ and $p_2=\tfrac{121+9}4=\tfrac{65}2=30+\tfrac52$. At $(3,3)$, $\ell=(\tfrac92,\tfrac72)$ and $p_2=\tfrac{81+49}4=\tfrac{65}2$. Consistent.

## 6. Claim 6: the six $p_4$ values

$p_4(\ell)=(a+\tfrac32)^4+(b+\tfrac12)^4=\big((2a+3)^4+(2b+1)^4\big)/16$.

| label | $(2a+3)^4$ | $(2b+1)^4$ | sum$/16$ | stated |
|---|---|---|---|---|
| $(4,1)$ | $11^4=14641$ | $3^4=81$ | $14722/16=7361/8$ | $7361/8$ |
| $(3,3)$ | $9^4=6561$ | $7^4=2401$ | $8962/16=4481/8$ | $4481/8$ |
| $(4,3)$ | $14641$ | $2401$ | $17042/16=8521/8$ | $8521/8$ |
| $(5,0)$ | $13^4=28561$ | $1$ | $28562/16=14281/8$ | $14281/8$ |
| $(5,4)$ | $28561$ | $6561$ | $35122/16=17561/8$ | $17561/8$ |
| $(6,2)$ | $15^4=50625$ | $5^4=625$ | $51250/16=25625/8$ | $25625/8$ |

All six confirmed, and each pair differs. For an arbitrary admissible $C_4$ the eigenvalue difference on a pair with equal $p_2$ is $a\,\Delta p_4\ne0$, which is what "every one serves" needs. Confirmed.

## 7. Claim 7: the generator condition is needed

- $C_2^2$ is central, lies in $U_4$ (indeed has filtration degree exactly four, as $\gamma(C_2^2)=(p_2-\tfrac52)^2$ has degree four), and lies in $\mathbb R[C_2]$. Confirmed.
- $\chi_\lambda(C_2^2)=c_2(\lambda)^2$, so any two labels with equal $c_2$ have equal readings. On the three pairs the readings are $(30,900)$, $(40,1600)$, $(60,3600)$, each shared by both members. "Separates none of the three colliding pairs" is confirmed, and $(30,900)$ is confirmed.
- The witness suffices for "is needed". The claim holds for every $C_4\in\mathbb R[C_2]$, since its eigenvalue is a polynomial in $c_2$, though the passage states only the witness. No finding.

## 8. Claim 8: Passage C against Passages A and B

| Passage C clause | Against A and B | Result |
|---|---|---|
| "$C_2$ and any quartic central generator $C_4\notin\mathbb R[C_2]$ together separate every dominant $B_2$ weight" | A proves this for every central degree-four $C_4\notin\mathbb R[C_2]$. A quartic generator not in $\mathbb R[C_2]$ is such an element, so the landscape claim is a subcase of what is proven | matches |
| "through the Harish-Chandra isomorphism onto $\mathbb R[p_2,p_4]$" | B | matches |
| "On the $24$ labels of Observation L83, $C_2$ alone takes $21$ values" | B's header, Section 5 | matches |
| detail: "the Harish-Chandra isomorphism carries both to $W(B_2)$-invariants of $\ell=\lambda+\rho$, in which $\chi_\lambda(C_4)$ carries $p_4$ with a nonzero coefficient, and $\ell_1>\ell_2>0$ lets $(p_2,p_4)$ recover $\ell$" | B, Sections 2 to 4 | matches |
| detail: "The condition is needed: $C_2^2$ reads $(30,900)$ on both $(4,1)$ and $(3,3)$" | B, Section 7 | matches |
| detail: "$c_2$ takes $21$ values with collisions at $30$, $40$ and $60$, which $p_4$ separates" | B, Sections 5 and 6 | matches |
| detail: "The separation holds for every dominant weight and does not depend on the table's multiplicities" | A. The proof never reads the multiplicity column | matches |

The word "generator" deserves one remark. In the presence of $C_2$, a central $C_4\in U_4$ with $a\ne0$ generates the centre with $C_2$, because $\gamma(\mathbb R[C_2,C_4])\ni(\gamma(C_4)-b\,p_2^2-c\,p_2-d)/a=p_4$. So "quartic generator" and "degree four, not in $\mathbb R[C_2]$" describe the same class. The passages do not state this equivalence, and nothing depends on it, because the hypothesis actually proven is the larger-looking one. No finding.

## 9. Claim 9: the Lean files against Passages A to C

- **casimir_pair_separates.** Binders: naturals $a,b,a',b'$ with $b\le a$ and $b'\le a'$. Hypotheses: p2 a b = p2 a' b' and p4 a b = p4 a' b' over $\mathbb Q$, with ell1 a = a + 3/2 and ell2 b = b + 1/2. Conclusion: $a=a'$ and $b=b'$. This is exactly Section 4 on the brief's dominant weights, the integral pairs with $a\ge b\ge0$. It carries no Lie algebra, no centre, no $\gamma$ and no $C_4$.
- **pair_separates.** The same over $\mathbb Q$ for any $0<l_2<l_1$, $0<m_2<m_1$. It would cover half-integral (spin) labels too, though casimir_pair_separates instantiates it on $\mathbb N$ only.
- **quartic_shift_still_separates.** Injectivity of $(p_2,\ p_4+\alpha p_2^2+\beta p_2+\gamma)$. This is Section 2.1 step 5 with the $p_4$ coefficient normalised to $1$. The general $a\ne0$ case reduces to it by dividing by $a$, a reduction the file does not state.
- **p2_eq_c2_add, c2Q.** The algebraic identity of Section 2.2. The eigenvalue statement $\chi_\lambda(C_2)=p_2-\tfrac52$ is not in the file.
- **c2_distinct_21, c2_distinct, three_merges, no_triple, colliding_values.** Together they state that $c_2$ on table has $21$ distinct values, the repeated values are $[60,40,30]$, and no value occurs three times. That is Section 5, conditional on table in L83 matching Passage D, which the brief does not quote and I did not open.
- **three_collisions, collision_thirty, collision_forty, collision_sixty.** Evaluate $c_2$ on constructed blocks $\langle a,b,m\rangle$. The multiplicity fields $2,1,2,1,1,1$ agree with Passage D's rows for $(4,1),(3,3),(4,3),(5,0),(5,4),(6,2)$. They do not assert membership in table. Membership is supplied by Section 5 by hand.
- **p4_splits_the_collisions, p4_collision_values.** Section 6 exactly.
- **alpha_half_collides.** $p_4-\tfrac12p_2^2$ equals $18$ at both $(2,2)$ and $(1,0)$, with $c_2=16$ and $4$. Checked by hand: $p_4-\tfrac12p_2^2=\tfrac12(\ell_1^2-\ell_2^2)^2$, and $\ell_1^2-\ell_2^2=\tfrac{49-25}4=6$ at $(2,2)$ and $\tfrac{25-1}4=6$ at $(1,0)$, giving $18$ in both. $c_2(2,2)=16$ and $c_2(1,0)=4$ agree with Section 5. This concerns a single quartic without $C_2$ and is outside Passages A to C.
- **c2_sq_distinct, sq_injective_nat.** $C_2^2$ takes $21$ values on table, consistent with Section 7.
- **single_quartic_worse.** Its type is $18<21\wedge21<24$, an inequality between numerals. See Section 11, remark R1.

What stands outside the files: the Harish-Chandra theorem and all of its pieces (i) to (iv), Chevalley's invariants, the Casimir eigenvalue formula, the definition of $C_4$ and the deduction $a\ne0$, and the general-$a$ division. The files state the recovery step and the table arithmetic, which are the parts carrying data. That split is consistent with Passage A's claim, and no Lean declaration states more than the prose.

## 10. Claim 10: the boundary

- $\lambda=(0,0)$: $\ell=(\tfrac32,\tfrac12)$, $\ell_1>\ell_2>0$, $p_2=\tfrac52$, $c_2=0$, $p_4=\tfrac{81+1}{16}=\tfrac{41}8$. The recovery step applies. In Lean, $b\le a$ holds with $a=b=0$. No finding.
- $b=0$: $\ell_2=\tfrac12>0$, so the positive square root is the right one. No finding.
- $a=b$: $\ell_1-\ell_2=1>0$, so the two roots $\ell_1^2,\ell_2^2$ are distinct and correctly ordered. No finding.
- $SO(5)$ against $O(5)$: $-I\in O(5)$ is central with $O(5)=SO(5)\times\{\pm I\}$, so each $V_\lambda$ extends to two $O(5)$ irreducibles, $V_\lambda$ and $V_\lambda\otimes\det$, on which every element of $Z(U(\mathfrak{so}(5)))$ acts by the same scalar. The pair does not separate $O(5)$ labels. Passage A scopes itself as "an $SO(5)$ statement about labels", and Passage C speaks of "dominant $B_2$ weights", which are $\mathfrak{so}(5)$ labels. No finding.
- $\mathrm{Spin}(5)$: half-integral dominant weights have $\ell_1>\ell_2>0$ too, so the prose proof covers them. The brief's definition restricts to integers, so the statement is not wider than the proof. No finding.

## 11. Candidates

### W1, withdrawn: real against complex coefficients of $\gamma$

1. Locate: Passage B, "the $W(B_2)$-invariants are $\mathbb R[p_2,p_4]$". $\mathfrak{so}(5)$ here is the compact real form, which is not split, and Harish-Chandra is a statement over $\mathbb C$, so a priori $\gamma(C_4)\in\mathbb C[p_2,p_4]$.
2. Exhibit: with $C_2'=\sum X_i^2$ over an orthonormal basis of the compact form, $\chi_\lambda(C_2')=-c_2(\lambda)$, so signs and factors of $i$ enter the identification of $\mathfrak h_{\mathbb R}^*$ with weights.
3. Opposite: the argument never needs real coefficients. With $a,b,c,d\in\mathbb C$, $a\ne0$ still gives $p_4$ from the eigenvalues, and $a=0$ gives $C_4\in\mathbb C[C_2]\cap U(\mathfrak{so}(5))=\mathbb R[C_2]$, because the powers of the real element $C_2$ are linearly independent and a real element in their complex span has real coordinates. The sign of $C_2'$ is a nonzero scalar. Withdrawn: no step fails.

### W2, withdrawn as a defect, recorded as a convention: the normalisation of $C_2$

1. Locate: Passage B, "So $\chi_\lambda(C_2)=p_2(\ell)-\tfrac52=c_2(\lambda)$". H1 says "the quadratic Casimir" without naming the invariant form, and Harish-Chandra alone fixes $\gamma(C_2)$ only up to $\alpha\,p_2+\beta$.
2. Exhibit: for the Casimir defined through the Killing form, which is $2h^\vee=6$ times the normalised form for $B_2$, the eigenvalue is $(\lambda,\lambda+2\rho)/6$. At $(1,0)$ this is $4/6=2/3$, against $c_2(1,0)=4$. At the adjoint $(1,1)$ it is $6/6=1$, the known value, which confirms the scale.
3. Opposite: Passage D defines $c_2$ by formula and Passage B's equation fixes the normalised form in which $e_1,e_2$ are orthonormal, so the convention is stated by the equation itself. Every conclusion of L84 is invariant under $C_2\mapsto s\,C_2+t$ with $s\ne0$: injectivity, the count $21$, the three pairs, and the necessity witness, where $C_2^2$ then reads $(30s+t,(30s+t)^2)$ on both $(4,1)$ and $(3,3)$. No trap of "normalisation taken from the wrong source" applies, as no external source is used. Withdrawn as a defect. The literal readings $30$, $40$, $60$ and $900$ are eigenvalues only in the normalised form, and one clause naming it would make that explicit.

### R1, surviving remark (Lean hygiene, outside the claims of Passages A to C): single_quartic_worse

1. Locate: [L84.lean](../lean/HamiltonsCubic/Results/L84.lean) as quoted in Passage E, theorem single_quartic_worse : 18 < 21 ∧ 21 < 24.
2. Exhibit: the type mentions no quartic, no table and no count. It is true of numerals alone, so the declaration checks nothing about "a single quartic takes $18$ values", which its name suggests.
3. Opposite: the docstrings were removed from the brief, and the declaration may be an anchor for a figure recorded elsewhere. Passages A to C never claim a figure of $18$, so L84 does not depend on it. The remark survives as a naming issue and does not bear on the verdict. If the figure $18$ is cited anywhere in the record, it has no argument in these passages and would be HYPOTHESIS-DEBT there.

## 12. What would break it

- **A falsifier of the statement** would be two distinct dominant weights $\lambda\ne\mu$ with $p_2(\lambda+\rho)=p_2(\mu+\rho)$ and $p_4(\lambda+\rho)=p_4(\mu+\rho)$, or a central degree-four $C_4\notin\mathbb R[C_2]$ whose $\gamma$ has zero $p_4$ coefficient. The first is excluded by Section 4, since equal $(e_1,e_2)$ force equal root multisets and positivity with ordering then forces $\ell=\ell'$. The second is excluded by Section 3. I looked for the first on every colliding pair of Passage D's table (Section 6) and at the boundary labels (Section 10), and found no coincidence.
- **A falsifier of the recovery step** would need $\ell_2\le0$ or $\ell_1\le\ell_2$ at a dominant weight, and $\ell_2=b+\tfrac12$ and $\ell_1-\ell_2=a-b+1$ rule both out. On a non-dominant $\lambda$, such as $(0,-1)$ with $\ell=(\tfrac32,-\tfrac12)$, the pair agrees with $(0,0)$, which shows that dominance is load-bearing and correctly hypothesised.
- **A falsifier of the table claims** would be an arithmetic slip in Sections 5 and 6, which I recomputed label by label.
- **A falsifier of the necessity claim** would need $C_2^2$ to separate a colliding pair, which is impossible since its eigenvalue is $c_2^2$.

## 13. Verdict

**PROVEN.** Lemma L84 holds as stated, for every dominant weight and every central degree-four $C_4\notin\mathbb R[C_2]$. The written proof reaches the stated conclusion from hypotheses that are all stated and all used, together with classical facts: the filtered Harish-Chandra isomorphism, Chevalley's invariants for $W(B_2)$, and the Casimir eigenvalue formula. The table readings ($21$ values, three pairs, six $p_4$ values, $(30,900)$) check exactly by hand. The Lean files state the recovery step and the table arithmetic without overreaching. The remarks for the round: name the normalised form for $C_2$ in one clause (W2), and give single_quartic_worse a type that states what its name says, or rename it (R1). Neither changes the result.

Index note: git status showed no other staged file at the time of this commit.
