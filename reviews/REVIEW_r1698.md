# REVIEW r1698: L131's four-set elements span Λ⁴ in Lean (d470ea7e)

**Verdict: CONFIRMED, with three row corrections.** [L131Lam4.lean](../lean/HamiltonsCubic/Results/L131Lam4.lean)'s `lam4_span` states and proves that every linear $R$ preserving bivectors whose coefficient tensor $C_{abcd}=\langle R\varphi_{ab},\varphi_{cd}\rangle$ is totally antisymmetric equals $\tfrac1{24}\sum_{ijkl}C_{ijkl}\,$`lam4 i j k l` on bivectors. The hypotheses are the record's $\Lambda^4$ (the complement of the Bianchi kernel in the symmetric operators on $\Lambda^2$), the $1/24$ is right, and the direction proved, $\Lambda^4\subseteq\mathop{\mathrm{span}}$, is the one [L131](../findings/isotropy-cap.md)'s consequence (i) consumes. The [lean/INDEX.md](../lean/INDEX.md) L131 row omits the new file from its files column (O1), keeps a "hand count" clause the commit half-superseded (O2), and the composite "#I = 2 on every element of $\Lambda^4$" remains a hand composition of `lam4_span` with `sharpCross_lam4_span` (O3).

| # | Claim | Verdict |
|---|---|---|
| 1a | hA1, hA2, hA3 are the adjacent transpositions $(12)$, $(34)$, $(23)$ and generate total antisymmetry | **CONFIRMED** |
| 1b | Totally antisymmetric $C$ at a linear bivector-preserving $R$ is the record's $\Lambda^4$ summand of the symmetric operators on $\Lambda^2$ | **CONFIRMED** |
| 2a | `lam4 i j k l` at distinct indices has coefficient $\mathop{\mathrm{sgn}}\sigma$ at each ordering $\sigma$ of its four-set and $0$ elsewhere, so $1/24$ is the right normalisation | **CONFIRMED** (by hand, and screened) |
| 2b | `lam4_span` is a spanning statement, $\Lambda^4\subseteq\mathop{\mathrm{span}}\{$`lam4`$\}$ on bivectors | **CONFIRMED** |
| 2c | Nothing beyond the record's need is claimed, and nothing owed is missing for consequence (i) | **CONFIRMED** (reverse inclusion and independence unstated, not owed for (i), O4) |
| 3 | Non-vacuous: `lam4 i j k l` at distinct indices meets every hypothesis | **CONFIRMED** (by hand, and screened, no declaration) |
| 4 | Axioms: standard three only | **CONFIRMED** (screen by the repo's audit script) |
| 5 | The INDEX row says exactly what is proved and owed | **ACCURATE ON THE THEOREM, INCOMPLETE ON FILES AND THE COMPOSITE** (O1, O2, O3) |

One line: every operator in $\Lambda^4$ is kernel-checked to be the explicit combination $\tfrac1{24}\sum C_{ijkl}\,$`lam4 i j k l` of four-set elements on bivectors, which is the inclusion L131's fourth eigenvalue entry needs, while its composition with `sharpCross_lam4_span` into "#I = 2 on all of $\Lambda^4$" is still a hand step.

## Attack line 1: is the hypothesis set the record's $\Lambda^4$

- **The three hypotheses.** With $C_{abcd}=$ `inner2 (R (phi a b)) (phi c d)`: hA1 is $C_{bacd}=-C_{abcd}$, the transposition of slots $1,2$; hA2 is $C_{abdc}=-C_{abcd}$, slots $3,4$; hA3 is $C_{acbd}=-C_{abcd}$, slots $2,3$. Each holds for all $a,b,c,d$, so each says $C\circ\tau=-C$ for one adjacent transposition $\tau$.
- **They generate total antisymmetry.** The adjacent transpositions $(12),(23),(34)$ generate $S_4$, and each is odd, so $C\circ\sigma=\mathop{\mathrm{sgn}}(\sigma)\,C$ for every $\sigma\in S_4$ by induction on word length. In particular $C$ vanishes whenever two indices coincide.
- **hA1 and hA2 are free, hA3 carries the content.** $\varphi_{ba}=-\varphi_{ab}$ and linearity of $R$ give hA1, and bilinearity of `inner2` gives hA2, for every linear $R$. The only substantive hypothesis is hA3.
- **It is the record's summand.** The even permutation $(13)(24)$ gives $C_{abcd}=C_{cdab}$, so $R$ is symmetric on bivectors without it being assumed. The cyclic sum $C_{abcd}+C_{bcad}+C_{cabd}$ equals $3C_{abcd}$ (both 3-cycles are even), so totally antisymmetric $C$ is orthogonal to the Bianchi kernel, and conversely the orthogonal complement of the Bianchi kernel in $\mathrm{Sym}^2(\Lambda^2)$ is the totally antisymmetric tensors, of dimension $\binom n4$. That is the "$\Lambda^4\mathbb R^m$, the Bianchi defect" row of [L79](../findings/isotropy-cap.md)'s table and the $\Lambda^4$ of L131 (i). The file's docstring says the same ("the complement of the Bianchi cut").
- **Off bivectors.** $R$ is a function on all matrices and the conclusion is stated on skew $X$ only, which is the layer's convention for `CurvOp` (as in `eq_on_skew_of_phi` and `sharpOp_congr_on_skew`). Nothing is lost.
- **Small $n$.** At $n<4$ every quadruple repeats an index, so $C\equiv0$, the right side is $0$ and the theorem says $R=0$ on bivectors, which is $\Lambda^4=0$. Consistent at every $n$.

## Attack line 2: the normalisation and what is claimed

- **The coefficient of `lam4`.** `rk2 U V X` $=\langle V,X\rangle U+\langle U,X\rangle V$, so $\langle$`rk2 U V`$\varphi_{ab},\varphi_{cd}\rangle=\langle V,\varphi_{ab}\rangle\langle U,\varphi_{cd}\rangle+\langle U,\varphi_{ab}\rangle\langle V,\varphi_{cd}\rangle$ (this is `inner2_rk2_phi`, read and correct). With `inner2_phi_phi`, $\langle\varphi_{ij},\varphi_{ab}\rangle=\delta_{ia}\delta_{jb}-\delta_{ib}\delta_{ja}$. At $(a,b,c,d)=(i,j,k,l)$ only the second term of the first summand survives: $1$. At the even ordering $(i,k,l,j)$ only $\langle\varphi_{ki},\varphi_{ik}\rangle\langle\varphi_{jl},\varphi_{lj}\rangle=(-1)(-1)=1$ survives. The support is the $24$ orderings of $\{i,j,k,l\}$, since each factor needs $\{a,b\}$ and $\{c,d\}$ to be pairs of the four-set in one of the three pairings.
- **So $1/24$ is right.** Pairing the right side at $\varphi_{ab},\varphi_{cd}$ with $a,b,c,d$ distinct gives $\tfrac1{24}\sum_{\sigma\in S_4}C_{\sigma(abcd)}\mathop{\mathrm{sgn}}\sigma=\tfrac1{24}\cdot24\,C_{abcd}$. With a repeated index the left side is $0$ by antisymmetry and every surviving term on the right carries a vanishing $C$. The kernel accepted the same count through `linarith` over the $72$ instances of hA1 to hA3 at the $24$ orderings.
- **The proof route.** `eq_on_skew_of_phi` reduces to $\varphi_{ab}$, `eq_of_pairings` (from `phi_expand`, $Z=\tfrac12\sum\langle Z,\varphi_{ab}\rangle\varphi_{ab}$) reduces to pairings against every $\varphi_{cd}$, and the skewness of both sides is supplied (`hsk`, `lam4_skew`). Each step is the standard coordinate argument.
- **What is claimed.** A spanning statement in explicit form: every element of $\Lambda^4$ is a combination of `lam4` over all ordered quadruples. It does not state that each `lam4` lies in $\Lambda^4$ (the reverse inclusion), that the subfamily over $i<j<k<l$ already spans, or linear independence. The L131Four header's "standard basis" is therefore still a hand claim in its independence and reverse-inclusion halves (O4).

## Attack line 3: non-vacuity

- **Witness.** $R=$ `lam4 i j k l` at distinct $i,j,k,l$, $n\ge4$. `lam4_lin` gives `hR`, `lam4_skew` gives `hsk` (for every $X$), and the coefficient table of attack line 2, $\mathop{\mathrm{sgn}}\sigma$ on the orderings and $0$ off them, is totally antisymmetric, giving hA1 to hA3. It is nonzero: $C_{ijkl}=1$.
- **Screen.** A five-second floating-point check at $n=5$ with the layer's definitions transcribed ($\varphi_{ij}=E_{ji}-E_{ij}$, half-trace pairing): `lam4 0 1 2 3` satisfies hA1 to hA3 at all $625$ index quadruples, has $24$ nonzero coefficients equal to $\mathop{\mathrm{sgn}}\sigma$, and a random totally antisymmetric $R$ is recovered by the $\tfrac1{24}$ formula on a random bivector. Reported as a screen of the hand computation, never as evidence for the theorem, which the kernel checked.
- **No Lean witness.** No declaration shows `lam4 i j k l` meets hA3. The hand computation above is short, and this is the same missing fact as the reverse inclusion of O4.

## Attack line 4: axioms

- **Screen.** `python3 scripts/misc/axiom_audit.py --only L131Lam4.lean`: "auditing 3 declarations across 1 files, 3/3 clean -- resting on the standard three alone", matching d470ea7e's message. Reported as a screen of the build.

## Attack line 5: the INDEX row

- **Proved.** *"The four-set elements span $\Lambda^4$, PROVED in L131Lam4.lean: `lam4_span`, … equals $\tfrac1{24}\sum_{ijkl}C_{ijkl}\,$`lam4 i j k l` on bivectors … standard three axioms."* Exactly what the file proves. The owed item it retires (*"that the four-set elements over $i<j<k<l$ span $\Lambda^4$, as a declaration"*) is discharged over all ordered quadruples, which spans the same space once `lam4` is alternating in its indices, a hand step.
- **O1: the files column.** The row's second column lists L131.lean through L131Whole.lean and omits [L131Lam4.lean](../lean/HamiltonsCubic/Results/L131Lam4.lean), which is linked only from the prose. Add it to the column.
- **O2: a half-stale clause.** *"$\Lambda^4$ on the span of the four-set elements by `sharpCross_lam4_span`, that span being $\Lambda^4$ by a hand count"* now precedes the sentence declaring $\Lambda^4\subseteq$ span. Suggested: *"that span containing $\Lambda^4$ by `lam4_span` below, the reverse inclusion by hand"*. The parenthesis *"(the elements over $i<j<k<l$ are totally antisymmetric with disjoint supports, checked by hand and not declared)"* stays accurate and is the reverse inclusion.
- **O3: the composite is undeclared.** "#I = 2 on every $R\in\Lambda^4$" needs `lam4_span` fed into `sharpCross_lam4_span`, and they do not compose directly. `sharpCross_lam4_span` requires distinct indices for every term (`hd`), while `lam4_span` sums over all $n^4$ quadruples. The repeated-index terms vanish twice over: $C$ is zero there, and `lam4` itself is zero there on bivectors (at each of the six coincidences one `rk2` term has a zero factor and the other two cancel, `rk2` being symmetric in $U,V$ with $\varphi_{ji}=-\varphi_{ij}$, checked by hand at all six and screened at three). The first slot of `sharpCross` also needs its congruence on bivectors to swap $R$ for the expansion. Each step is routine, and together they make a one-declaration corollary (e.g. `sharpCross_lam4_all`, hypotheses of `lam4_span`, conclusion $R\#I=2R$ on bivectors) that would close L131 (i)'s fourth entry on the whole summand in Lean. Until then the row should say that composition is by hand.
- **O4: basis claims.** Linear independence and the reverse inclusion are unstated and are not owed for consequence (i), which needs only $\Lambda^4\subseteq$ span. They would be owed by any Lean consumer of the dimension $\binom n4$ (L79's trace closure, $\sum\dim\times\mathcal A$), which the row imports from L79 rather than proving here. Cosmetic: L131Four.lean's and L131Lin.lean's headers still say "standard basis" without qualification.

## What would break the claims, and what I did to look for it

- **A hypothesis set weaker than total antisymmetry**, e.g. three transpositions generating a proper subgroup such as $\langle(12),(34)\rangle$ with a non-adjacent third. I read the argument order of hA1 to hA3 and found slots $(1,2)$, $(3,4)$, $(2,3)$, which generate $S_4$.
- **A normalisation off by a factor** from the half-trace pairing or the double sum in `phi_expand`. I computed the `lam4` coefficient at two orderings by hand, confirmed `inner2_phi_phi` gives $\pm1$, and screened all $625$ entries at $n=5$ plus the full reconstruction identity.
- **An $R$ in $\Lambda^4$ outside the hypotheses**, e.g. one needing symmetry stated separately. Total antisymmetry implies pair symmetry, so no symmetric-operator condition is missing.
- **A vacuous hypothesis set.** `lam4 0 1 2 3` meets it (hand, screened), nonzero.
- **A consumer that cannot use the statement.** Reading `sharpCross_lam4_span` exposed its distinctness hypothesis, which is O3.
