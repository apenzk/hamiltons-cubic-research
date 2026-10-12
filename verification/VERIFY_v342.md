# Verifier v342, the Λ² multiplicities and dropped-condition counts of L111 at S³×S³ and S²×S²

**Cold brief ([ADJ_L111_D8.md](ADJ_L111_D8.md)), no numerical work, no scripts written, every value exact and derived by hand. Log: [agent_logs/verify-L111-v342.log](../agent_logs/verify-L111-v342.log).**

| # | Claim | Verdict |
|---|---|---|
| 1 | The Λ² spectrum of the unit Weyl tensor of S³×S³ has multiplicities (3,3,9) | REFUTED AS STATED: the eigenvalues are $\tfrac35 c$ with multiplicity 6 and $-\tfrac25 c$ with multiplicity 9, so the multiplicities are (6,9) |
| 2 | So the bracket form drops 57 of 120 conditions at S³×S³ | REFUTED: it drops $\binom72+\binom{10}2=21+45=66$ of 120 |
| 3 | The Λ² spectrum of the unit Weyl tensor of S²×S² has multiplicities (1,1,4) | REFUTED AS STATED: the eigenvalues are $\tfrac23 c$ with multiplicity 2 and $-\tfrac13 c$ with multiplicity 4, so (2,4) |
| 4 | So the bracket form drops 12 of 21 conditions at S²×S² | REFUTED: it drops $\binom32+\binom52=3+10=13$ of 21 |
| 5 | $3+3+9=15$, $\binom42+\binom42+\binom{10}2=57$, $\binom{16}2=120$, $1+1+4=6$, $1+1+10=12$, $\binom72=21$ | CONFIRMED AS ALGEBRA |
| 6 | (3,3,9) and (1,1,4) are the dimensions of the product's block decomposition $\Lambda^2\mathbb R^p\oplus\Lambda^2\mathbb R^q\oplus(\mathbb R^p\otimes\mathbb R^q)$ | CONFIRMED, but these blocks are not eigenspaces of distinct eigenvalues |

**Summary: the two factor blocks $\Lambda^2\mathbb R^p$ and $\Lambda^2\mathbb R^q$ carry the same Weyl eigenvalue for every choice of radii, so they merge into one eigenspace, and the bracket form, which is keyed to eigenvalue equality, drops 66 of 120 and 13 of 21, not 57 and 12. The step FAILS.**

## 0. Conventions, fixed once

- $n=p+q$, $N=\binom n2$, $\{e_i\}$ an orthonormal frame adapted to $\mathbb R^p\oplus\mathbb R^q$, and $\Lambda^2$ spanned by $e_i\wedge e_j$, $i<j$.
- A curvature tensor is read as a symmetric operator on $\Lambda^2$ and decomposed as $R=W+P\owedge g$, with Schouten tensor $P=\frac1{n-2}\big(\mathrm{Ric}-\frac{\mathrm{scal}}{2(n-1)}g\big)$. For diagonal $P$, the operator $P\owedge g$ acts on $e_i\wedge e_j$ by $P_{ii}+P_{jj}$. Check on the unit round $S^n$: $\mathrm{Ric}=(n-1)g$, $\mathrm{scal}=n(n-1)$, so $P=\frac1{n-2}\big((n-1)-\frac n2\big)g=\frac12 g$, and $P_{ii}+P_{jj}=1$ is the sectional curvature, with $W=0$. The normalisation is right.
- Any other convention (a factor 2 on the operator, the opposite sign, the "unit" rescaling to $\lVert W\rVert=1$) multiplies all eigenvalues by one nonzero constant $c$ and leaves multiplicities unchanged. Multiplicities are the only thing the step reads.
- "The bracket form" is [BracketForm](../lean/HamiltonsCubic/Results/L111Statement.lean) as Passage C gives it, $\lambda_k\ne\lambda_l\Rightarrow (W^\#)_{kl}=0$, and "criticality" is IsCriticalHere, one condition per entry of $Q(W)-\theta W$ in the eigenbasis.
- "Conditions" are counted as the entries of a symmetric $N\times N$ matrix on and above the diagonal, $\binom{N+1}2$ of them. This is the only count giving the step's totals, $\binom{16}2=120$ for $N=15$ and $\binom72=21$ for $N=6$.

## 1. Hypothesis inventory

- **H1 (symmetry of $W^\#$).** $W^\#$ is a symmetric operator on $\Lambda^2$, so the $(k,l)$ and $(l,k)$ conditions coincide and the total is $\binom{N+1}2$. True for the record's $\#$. The Lean Ws is an arbitrary function, so H1 is an unwritten hypothesis of the count.
- **H2 (dropped means "imposed by criticality, not by the bracket form").** The bracket form imposes the entries with $\lambda_k\ne\lambda_l$ and nothing else. It drops every diagonal entry and every off-diagonal entry inside one eigenspace, so an eigenvalue of multiplicity $m$ contributes $\binom{m+1}2=\frac{m(m+1)}2$, which is dropped in L111.lean.
- **H3 (the object).** The unit Weyl tensor of a Riemannian product $S^p(r_1)\times S^q(r_2)$ at a point, in an adapted orthonormal frame. The step names unit spheres. Section 3 treats arbitrary radii to close the reading in which the author meant a non-Einstein product.
- **H4 (the reading of "multiplicities").** The multiplicities of the distinct eigenvalues of $W$ on $\Lambda^2$. This is what "Λ² spectrum" means and what BracketForm depends on. The step fails under H4. The one reading that makes (3,3,9) true, block dimensions of the product decomposition, is examined in section 5 and does not deliver the counts under BracketForm.

## 2. The curvature operator of a product of spheres

On $S^p(r_1)\times S^q(r_2)$ put $a=r_1^{-2}$, $b=r_2^{-2}$. The curvature operator is diagonal on the adapted $e_i\wedge e_j$:

- $a$ on the $\binom p2$ planes inside the first factor,
- $b$ on the $\binom q2$ planes inside the second factor,
- $0$ on the $pq$ mixed planes $e_i\wedge e_j$, $i\le p<j$, since a product has zero mixed sectional curvature and no off-diagonal curvature terms between these planes.

So $\mathrm{Ric}=(p-1)a$ on the first factor, $(q-1)b$ on the second, and $\mathrm{scal}=p(p-1)a+q(q-1)b$.

## 3. The Weyl eigenvalues of S³(r₁)×S³(r₂)

Here $p=q=3$, $n=6$, $\mathrm{Ric}=2a$ and $2b$ on the factors, $\mathrm{scal}=6(a+b)$, and $\frac{\mathrm{scal}}{2(n-1)}=\frac{3(a+b)}5$.

- Schouten on the first factor: $P_1=\frac14\big(2a-\frac{3(a+b)}5\big)=\frac{7a-3b}{20}$. On the second: $P_2=\frac{7b-3a}{20}$.
- First-factor planes: $W=a-2P_1=a-\frac{7a-3b}{10}=\frac{3(a+b)}{10}$.
- Second-factor planes: $W=b-2P_2=b-\frac{7b-3a}{10}=\frac{3(a+b)}{10}$.
- Mixed planes: $W=0-(P_1+P_2)=-\frac{4(a+b)}{20}=-\frac{a+b}5$.

Checks. Trace: $6\cdot\frac{3(a+b)}{10}-9\cdot\frac{a+b}5=\frac{18(a+b)}{10}-\frac{18(a+b)}{10}=0$, as a Weyl tensor needs. Ricci contraction on $e_1$: the planes through $e_1$ are two first-factor planes and three mixed planes, $2\cdot\frac{3(a+b)}{10}-3\cdot\frac{a+b}5=0$. Same on $e_4$. So $W$ is an algebraic Weyl tensor.

**The two first-factor and second-factor eigenvalues are equal for every $a,b>0$.** With $a=b=1$ the eigenvalues are $\frac35$ on $6$ planes and $-\frac25$ on $9$ planes, so $\lVert W\rVert^2=6\cdot\frac9{25}+9\cdot\frac4{25}=\frac{18}5$, and the unit Weyl tensor is $W/\sqrt{18/5}$, which has the same eigenspaces. **The Λ² spectrum has two distinct eigenvalues, with multiplicities (6,9).** The multiplicities (3,3,9) would need $\frac{3(a+b)}{10}\ne\frac{3(a+b)}{10}$.

## 4. The Weyl eigenvalues of S²(r₁)×S²(r₂)

Here $p=q=2$, $n=4$, $\mathrm{Ric}=a$ and $b$ on the factors, $\mathrm{scal}=2(a+b)$, and $\frac{\mathrm{scal}}{2(n-1)}=\frac{a+b}3$.

- $P_1=\frac12\big(a-\frac{a+b}3\big)=\frac{2a-b}6$, $P_2=\frac{2b-a}6$.
- $e_1\wedge e_2$: $W=a-\frac{2a-b}3=\frac{a+b}3$.
- $e_3\wedge e_4$: $W=b-\frac{2b-a}3=\frac{a+b}3$.
- The four mixed planes: $W=-(P_1+P_2)=-\frac{a+b}6$.

Checks. Trace: $2\cdot\frac{a+b}3-4\cdot\frac{a+b}6=0$. Ricci contraction on $e_1$: one factor plane and two mixed planes, $\frac{a+b}3-2\cdot\frac{a+b}6=0$. With $a=b=1$: $\frac23$ on $2$ planes, $-\frac13$ on $4$. **The multiplicities are (2,4).** The dimension-4 refinement does not restore (1,1,4): $e_{12}\pm e_{34}\in\Lambda^\pm$ both have eigenvalue $\frac23$, so $W^+$ and $W^-$ each have spectrum $(\frac23,-\frac13,-\frac13)$, and the pooled multiplicities on $\Lambda^2$ are again (2,4).

## 5. The counts, and the opposite argued

**Under H1, H2, H4.** With multiplicities $m_i$ summing to $N$, the bracket form drops $\sum_i\binom{m_i+1}2$ of $\binom{N+1}2$ conditions (dropped_count_identity in Passage C is this sum).

- S³×S³: $\binom72+\binom{10}2=21+45=66$ of $120$. This is exactly the value the sibling file already records, counts_at_balanced_products ($6\cdot7/2+9\cdot10/2=66$) and dropped_fractions ($66/120=11/20$) in [L111Statement.lean](../lean/HamiltonsCubic/Results/L111Statement.lean). The step's 57 contradicts it by $66-57=9=3\cdot3$, the entries between the two $3$-planes blocks.
- S²×S²: $\binom32+\binom52=3+10=13$ of $21$. The step's 12 is short by $1=1\cdot1$, the entry between $e_{12}$ and $e_{34}$.

**The line that fails.** "the $\Lambda^2$ spectrum of the unit Weyl tensor of $S^3\times S^3$ has multiplicities $(3,3,9)$", and in [L111.lean](../lean/HamiltonsCubic/Results/L111.lean) the use of `dropped 3 + dropped 3 + dropped 9` in place of `dropped 6 + dropped 9`. The theorem multiplicities_six proves only $3+3+9=\binom62$, which (6,9) satisfies equally, and split_from_L76 proves only $\binom32=3$ and $3\cdot3=9$. Neither theorem says anything about eigenvalues, so the Lean check leaves the mathematical claim unconstrained.

**Arguing the opposite.** Four readings could save (3,3,9), and each is closed.

1. *Unequal radii.* Sections 3 and 4 hold for all $a,b>0$, and the factor-block eigenvalues are identically equal. No product metric on $S^3\times S^3$ or $S^2\times S^2$ separates them.
2. *A different normalisation or sign of $W$ or of "unit".* Every such change is a global nonzero scalar (section 0) and preserves eigenvalue equality.
3. *Block dimensions of the symmetry.* Under $SO(p)\times SO(q)$ the decomposition $\Lambda^2\mathbb R^p\oplus\Lambda^2\mathbb R^q\oplus(\mathbb R^p\otimes\mathbb R^q)$ is into pairwise non-isomorphic irreducibles for $p=q=3$ (the adjoint of either factor, and $\mathbb R^3\boxtimes\mathbb R^3$). By Schur, $Q(W)$ is block diagonal with a scalar on each block, so the $9$ cross entries between the two $3$-blocks vanish at this $W$ identically. That is a true statement about the product, and (3,3,9) is its true block count. It is a statement about which entries are zero at one point, and it gives the step's 57 only if "dropped" is redefined to "entries the bracket form leaves free and the product's symmetry does not force". BracketForm is keyed to $\lambda_k\ne\lambda_l$, the two $3$-blocks share an eigenvalue, and so BracketForm leaves those $9$ entries free. Under the brief's definitions this reading does not reach 57. For $p=q=2$ the analogous argument fails outright: $\Lambda^2\mathbb R^2$ is trivial for both factors, the two $1$-blocks are isomorphic representations, and Schur does not force the $e_{12},e_{34}$ entry to vanish.
4. *A different operator.* If "spectrum" meant $W^\#$ or $Q(W)$, the factor-swap isometry (available when $r_1=r_2$, which "unit" spheres give) exchanges the two factor blocks and commutes with $W$, so $Q(W)$ takes the same scalar on both. The multiplicities are again at most (6,9).

**Downstream note, recorded for the tracer.** share_six ($57/120=19/40$) inherits the error, the correct share is $66/120=11/20$. The inequality in cross_dominates, $45\cdot100>78\cdot57$ (that is $4500>4446$), becomes $45\cdot100=4500<5148=78\cdot66$ at the corrected count, so its conclusion reverses. share_four_above survives at $13/21$, since $51\cdot21=1071<1300=100\cdot13$.

## 6. Verdict

**FAILS.** The Λ² spectrum of the unit Weyl tensor has multiplicities (6,9) on S³×S³ and (2,4) on S²×S², because the two factor blocks carry the common eigenvalue $\frac{3(a+b)}{10}$, respectively $\frac{a+b}3$, for all radii. Under H1 (symmetric $W^\#$), H2 (dropped counts diagonal and same-eigenvalue entries) and H4 (multiplicities of distinct eigenvalues), the bracket form drops **66 of 120** and **13 of 21**. The step's arithmetic is correct, and its input multiplicities are the product's block dimensions, which BracketForm does not see.
