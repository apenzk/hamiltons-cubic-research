# Review r915, Lemma L209, does the written derivation establish closure of the Fox product on the Weyl module?

Reviewer r915, Gate 2, cold brief on the L209 block of [curvature-invariants.md](../findings/curvature-invariants.md). **I re-derived all four steps by hand from the record's normalisation before running anything**, expanding the sixteen bracket terms of Step 2 term by term, writing out the twelve terms of Step 3's cyclic sum as permutation patterns, and carrying out Step 4's Bianchi rewriting and dummy swap independently. I then ran a screen of a few hundredths of a second at $n=4$ and $n=5$ on [weyl.py](../scripts/lib/weyl.py)'s structure constants and [rsharp_basis_free.py](../scripts/lib/rsharp_basis_free.py)'s `Rsharp_full`, checking every INTERMEDIATE identity of the chain rather than only the conclusion, plus the off-locus controls and the teeth on $\mathcal W_n$. I read [L209FoxClosure.lean](../lean/HamiltonsCubic/Results/L209FoxClosure.lean), [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean), [StructureConstants.lean](../lean/HamiltonsCubic/Base/StructureConstants.lean) and [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean). *Numerics here screen and localise. Every verdict below rests on the hand derivation.* Log: [gate2-l209-r915.log](../agent_logs/gate2-l209-r915.log).

| # | Item | Verdict | Reason |
|---|---|---|---|
| 1 | Step 1, compact form of $\#$ and the Casimir anchor | CONFIRMED | the basis expansion is exact with the $\tfrac12$ intact, $\sum_\gamma\mathrm{ad}_{\varphi_\gamma}^2=-2(n-2)$ re-derived from $K=(n-2)\operatorname{tr}$ and checked by hand at $n=3$, returning $(n-2)\mathrm{id}$ on the nose |
| 2 | Step 2, the four-index $\#$ form and its $\mathrm{id}$ value | CONFIRMED | the sixteen terms fall into four classes of four equal terms, $\tfrac18\cdot4=\tfrac12$, giving $B_{ijkl}-B_{ijlk}$ with the record's index order exactly, and $B$ at $\mathrm{id}$ is $(n-2)\delta_{ik}\delta_{jl}+\delta_{ij}\delta_{kl}$ |
| 3 | Step 2, the $R^2$ form via two Bianchi rewritings | CONFIRMED | both rewritings and both signs are right and the four products collapse to two, Bianchi entering at each rewriting and pair exchange at the collapse |
| 4 | Step 3, the Bianchi half and the twelve-term cancellation | CONFIRMED | all six permutation patterns appear with coefficients $+1$ and $-1$ and cancel, no symmetry of $B$ used, and the identity survives off $S^2_B$ in the screen |
| 5 | Step 4, the four contractions of $\operatorname{Ric}(R^\#)$ | CONFIRMED | $\sum_cB_{acbc}=A_1$ and $\sum_cB_{accb}=-A_2$, and the $\tfrac12$ of the $C$-decomposition turns $2A_1+2A_2$ into $A_1+A_2$ |
| 6 | Step 4's load-bearing Bianchi and dummy swap | CONFIRMED | the rewriting is first Bianchi at $(c;q,r,b)$ verbatim, the factor $2$ is the ordered-pair sum over $(c,r)$, and $c\leftrightarrow r$ with one pair exchange and two pair antisymmetries gives $X=A_2$, so $2A_2=-2\operatorname{Ric}(R^2)$ |
| 7 | Hypothesis inventory | CONFIRMED | all four named hypotheses are used and located, nothing unnamed is used, and Ricci-flatness enters nowhere |
| 8 | Vacuity and teeth | CONFIRMED | on $\mathcal W_5$, $\operatorname{Ric}(W^2)$ is positive definite with eigenvalues $13.2$ to $31.9$ and $b(W^2)$ reaches $8.93$, both cancelled to $5\times10^{-15}$ |
| 9 | Normalisation and reach | CONFIRMED | the compact form equals $-\tfrac12\operatorname{tr}(A_aRA_bR)$, the polarisation needs only that $\mathcal W_n$ is a linear subspace, and the BW index-order sign is a convention the adjacent block resolves |
| 10 | The Lean statement | CONFIRMED | `ric_Qop_eq` types the Ricci half over the record's own `Ric`, `Qop` and `bianchi` with the same four hypotheses and the same right-hand side, and the two $\mathrm{id}$ anchors are non-vacuous at $(n-1)^2\delta$ |
| 11 | What would break it | CONFIRMED | the falsifier is the sign in $X=A_2$ and the normalisation of $\#$, and both were attacked |

**Summary.** *Both halves of L209 follow from what is written, every constant and index order is the record's, and the three prose elisions I found are each one line from hypotheses the block already states.*

## 1. Step 1, the compact form and the anchor

**The basis expansion is exact.** $\{\varphi_\delta\}$ over unordered pairs is $\langle\ ,\ \rangle$-orthonormal and $[\varphi_\alpha,\varphi_\gamma]\in\mathfrak{so}(n)$, so $[\varphi_\alpha,\varphi_\gamma]=\sum_\delta\langle[\varphi_\alpha,\varphi_\gamma],\varphi_\delta\rangle\varphi_\delta=\sum_\delta c_{\alpha\gamma\delta}\varphi_\delta$ by definition of $c$. **No finding.**

**The contraction keeps the $\tfrac12$.** Substituting twice,
$$\big\langle R[\varphi_\alpha,\varphi_\gamma],[\varphi_\beta,\varphi_\varepsilon]\big\rangle=\sum_{\delta,\zeta}c_{\alpha\gamma\delta}c_{\beta\varepsilon\zeta}R_{\delta\zeta},$$
so $\tfrac12\sum_{\gamma\varepsilon}R_{\gamma\varepsilon}$ of that is the index definition letter for letter. The $\tfrac12$ is the definition's own and picks up nothing. **No finding.**

**The Casimir anchor is right, and it returns $(n-2)\mathrm{id}$ rather than a multiple.** Ad-invariance makes $\mathrm{ad}_{\varphi_\gamma}$ skew and $\mathrm{ad}_{\varphi_\gamma}^2$ self-adjoint, so $\langle[\varphi_\alpha,\varphi_\gamma],[\varphi_\beta,\varphi_\gamma]\rangle=-\langle\mathrm{ad}_{\varphi_\gamma}^2\varphi_\alpha,\varphi_\beta\rangle$. For a $B$-orthonormal basis, $\sum_\gamma\mathrm{ad}_{\varphi_\gamma}^2=\kappa\,\mathrm{id}$ with $K=\kappa B$ by taking traces, and on $\mathfrak{so}(n)$, $K(X,Y)=(n-2)\operatorname{tr}(XY)=-2(n-2)\langle X,Y\rangle$, so $\kappa=-2(n-2)$. **I checked the Killing normalisation by hand at $n=3$**: $\mathrm{ad}_{e_{12}}$ rotates the plane $\operatorname{span}(e_{13},e_{23})$, so $\operatorname{tr}(\mathrm{ad}_{e_{12}}^2)=-2=\operatorname{tr}(e_{12}^2)$, which is $(n-2)=1$. Then $(\mathrm{id}^\#)_{\alpha\beta}=-\tfrac12\langle-2(n-2)\varphi_\alpha,\varphi_\beta\rangle=(n-2)\delta_{\alpha\beta}$, an equality and not a proportionality. **No finding.**

*The same Killing normalisation is typed and `sorry`-free in Lean* as [sum_inner2_ad2](../lean/HamiltonsCubic/Base/StructureConstants.lean), $\sum_{i,j}\langle\mathrm{ad}_X\mathrm{ad}_Y\varphi_{ij},\varphi_{ij}\rangle=2(n-2)\operatorname{tr}(XY)$, which is the ordered-pair-doubled form of the same fact. Step 1's anchor therefore rests on a machine-checked identity.

## 2. Step 2, the four-index form of $\#$

**Reading the compact form of Step 1 in the $e$ basis is legitimate**, and for a cleaner reason than the one given: in the compact form $\varphi$ appears twice inside each bracket and twice as an outer slot, and $R_{\gamma\varepsilon}$ is unchanged, so every $\varphi\to e$ sign cancels in pairs. **This is stronger than the block's parenthetical about $c$, which covers the two structure constants and not the outer pair.** *That is an improvement to the prose and not a defect: the conclusion is the same and the block's route reaches it too, since the outer indices enter $(R^\#)_{\alpha\beta}$ through $c_{\alpha\gamma\delta}$ and $c_{\beta\varepsilon\zeta}$ as well.*

**The sixteen terms do reduce to four, and the prefactor is $\tfrac12$.** Both doublings are licensed: $R_{pq,rs}[e_{ij},e_{pq}]$ is even under $p\leftrightarrow q$ because each factor is odd, and likewise in $(r,s)$, so $(R^\#)_{ij,kl}=\tfrac18\sum_{p,q,r,s}R_{pq,rs}\langle R[e_{ij},e_{pq}],[e_{kl},e_{rs}]\rangle$. Writing the first bracket's terms as $a_1=+\delta_{jp}e_{iq}$, $a_2=+\delta_{iq}e_{jp}$, $a_3=-\delta_{jq}e_{ip}$, $a_4=-\delta_{ip}e_{jq}$ and the second's as $b_1\dots b_4$ by the same pattern, the map $p\leftrightarrow q$ carries $a_1\mapsto-a_3$ and $a_2\mapsto-a_4$ against $R_{pq,rs}\mapsto-R_{pq,rs}$, so the $a_1$ and $a_3$ contributions are equal and likewise $a_2$ and $a_4$. The same in $(r,s)$. **Four classes of four equal terms, so $\tfrac18\cdot4=\tfrac12$ times the four representatives.** Those four are
$$C_{11}=\sum_{q,s}R_{iq,ks}R_{jq,ls}=B_{ijkl},\quad C_{12}=-B_{ijlk},\quad C_{21}=-B_{ijlk},\quad C_{22}=B_{ijkl},$$
each after one or two pair antisymmetries, giving $\tfrac12(2B_{ijkl}-2B_{ijlk})=B_{ijkl}-B_{ijlk}$. **The index order is the record's exactly**, with $B_{ijkl}=\sum_{p,q}R_{ip,kq}R_{jp,lq}$ pairing $i$ with $k$ and $j$ with $l$. **No finding.** *The block's phrase "turns the sixteen bracket terms into four" is terse about which factor of two comes from where, and the arithmetic behind it is the above.*

**The $\mathrm{id}$ value of $B$ is right.** With $R_{ip,kq}=\delta_{ik}\delta_{pq}-\delta_{iq}\delta_{pk}$ the four products give $n\delta_{ik}\delta_{jl}-\delta_{ik}\delta_{jl}-\delta_{ik}\delta_{jl}+\delta_{ij}\delta_{kl}$, that is $(n-2)\delta_{ik}\delta_{jl}+\delta_{ij}\delta_{kl}$, and the $\delta_{ij}\delta_{kl}$ term is symmetric in $(k,l)$ so it cancels in $B_{ijkl}-B_{ijlk}$, leaving $(n-2)\mathrm{id}_{ij,kl}$. **The second route to the anchor is independent of the first and agrees.** **No finding.**

**Step 2's $\#$ form needs neither Bianchi nor self-adjointness**, only pair antisymmetry and linearity. The screen confirms it off $S^2_B$ as well as on it, to $4\times10^{-16}$.

## 3. Step 2, the $R^2$ form

**Both rewritings are first Bianchi with the right sign.** At $(i;j,p,q)$, $R_{ij,pq}+R_{ip,qj}+R_{iq,jp}=0$ and $R_{ip,qj}=-R_{ip,jq}$ give $R_{ij,pq}=R_{ip,jq}-R_{iq,jp}$. The second is the same identity at $(p;q,k,l)$. **No finding.**

**The collapse is right and it uses pair exchange.** The four products are
$$\tfrac12\!\sum_{pq}\!\big[R_{ip,jq}R_{pk,ql}-R_{ip,jq}R_{pl,qk}-R_{iq,jp}R_{pk,ql}+R_{iq,jp}R_{pl,qk}\big],$$
and relabelling $p\leftrightarrow q$ in the third and fourth turns them into the second and first **only after $R_{qk,pl}=R_{pl,qk}$**, which is self-adjointness. Two pair antisymmetries then give $R_{pk,ql}=R_{kp,lq}$ and $R_{pl,qk}=R_{lp,kq}$, so the two surviving sums are $B_{ikjl}$ and $B_{iljk}$ and the $\tfrac12$ is consumed by the doubling. **$(R^2)_{ij,kl}=B_{ikjl}-B_{iljk}$ exactly.**

**Finding, prose only, not a gap.** *The step needs pair exchange as well as Bianchi and names only Bianchi.* Self-adjointness is one of the four hypotheses the block's own inventory lists, so nothing unstated is used and the step follows. **Where Bianchi is needed is exactly here and at Step 4's $A_2$**, which the screen localises: off $S^2_B$ this identity fails by $6.0$ at $n=5$ while the $\#$ form of Step 2 stays exact.

*Both Bianchi applications sit under sums where indices may coincide.* The record states first Bianchi for all four-index tuples without a distinctness hypothesis, so the rewriting is licensed at coincidences directly. **It would also be free there**: at $i=j$ the three terms are $0+R_{ik,li}+R_{il,ik}$ and pair exchange plus antisymmetry kill them, and at $k=l$ likewise, which is also why [weyl.py](../scripts/lib/weyl.py)'s `bianchi_constraint_matrix` imposing the relation on distinct quadruples alone genuinely lands in $S^2_B$ and the screen tests the right set.

## 4. Step 3, the Bianchi half

**All twelve terms cancel, and no symmetry of $B$ is used.** Every term of $Q(R)_{ij,kl}$ is a $B$ whose first slot is $i$ and whose remaining three slots carry a permutation of $(j,k,l)$, so label each by that permutation. Substituting $(j,k,l)\to(k,l,j)$ and $(j,k,l)\to(l,j,k)$ into $B_{ijkl}-B_{ijlk}+B_{ikjl}-B_{iljk}$:

| pattern | from $Q_{ij,kl}$ | from $Q_{ik,lj}$ | from $Q_{il,jk}$ | total |
|---|---|---|---|---|
| $(jkl)$ | $+1$ | $-1$ | | $0$ |
| $(jlk)$ | $-1$ | | $+1$ | $0$ |
| $(kjl)$ | $+1$ | $-1$ | | $0$ |
| $(ljk)$ | $-1$ | | $+1$ | $0$ |
| $(klj)$ | | $+1$ | $-1$ | $0$ |
| $(lkj)$ | | $+1$ | $-1$ | $0$ |

Each of the six patterns appears exactly twice with opposite signs. **The cancellation is a formal identity in the symbol $B$**, so the claim "with no symmetry of $B$ used" is exact. *The screen confirms this the sharpest way available: $b(B_{ijkl}-B_{ijlk})+b(B_{ikjl}-B_{iljk})$ vanishes to $4\times10^{-16}$ even at $R\notin S^2_B$, where $b(Q(R))$ itself is $5.6$ at $n=5$, so the failure off the locus comes entirely from $R^2$ losing its $B$-form and not from Step 3.* **No finding.**

**The symmetries of $B_{ijkl}-B_{ijlk}$ hold, and each needs a named hypothesis.** Antisymmetry in $(k,l)$ is the definition. Antisymmetry in $(i,j)$ follows from $B_{jikl}=B_{ijlk}$, which is commutativity of multiplication and needs nothing of $R$. Self-adjointness follows from $B_{klij}=B_{ijkl}$, which needs pair exchange twice and one dummy relabel, so it needs self-adjointness of $R$. *"By inspection" is generous for the last of these, which is one line rather than none.*

**Finding, prose only, not a gap.** *The sentence establishes the three symmetries for $B_{ijkl}-B_{ijlk}$, which is $R^\#$, and then concludes $Q(R)\in S^2_B$, leaving the $R^2$ half unremarked.* That half is immediate: $R^2$ is the composition of a bivector-preserving operator with itself, so it preserves bivectors and its four-index reading is antisymmetric in each pair, and the square of a self-adjoint operator is self-adjoint. **One line from stated hypotheses, so the conclusion stands.**

## 5. Step 4, the four contractions

**Derived independently from the $B$-form.** $(R^\#)_{ac,bc}=B_{acbc}-B_{accb}$, and
$$\sum_cB_{acbc}=\sum_{p,q}R_{ap,bq}\sum_cR_{cp,cq}=\sum_{p,q}R_{ap,bq}\operatorname{Ric}(R)_{pq}=A_1,$$
using $R_{cp,cq}=R_{pc,qc}$, two pair antisymmetries. And $\sum_cB_{accb}=\sum_{c,p,q}R_{ap,cq}R_{cp,bq}=-A_2$ after one antisymmetry on the second factor. So $\operatorname{Ric}(R^\#)_{ab}=A_1+A_2$. **No finding.**

**The block's "four contractions with the $\tfrac12$" reading is the same statement.** Contracting the $C$-decomposition of item 2 rather than its collapsed form, $C_{11}$ and $C_{22}$ each contract to $A_1$ and $C_{12}$ and $C_{21}$ each to $A_2$, and the $\tfrac12$ turns $2A_1+2A_2$ into $A_1+A_2$. **Exactly two of the four give each, as claimed.** *The two descriptions agree, which is a consistency check on Step 2 as much as on Step 4.* Screened exact at $1.8\times10^{-15}$ and $7.1\times10^{-15}$, on and off $S^2_B$ alike, since this step uses no Bianchi.

## 6. The load-bearing step

**The Bianchi application is verbatim.** At $(c;q,r,b)$, $R_{cq,rb}+R_{cr,bq}+R_{cb,qr}=0$, so $R_{cq,rb}=-R_{cr,bq}-R_{cb,qr}$. **No finding.**

**The first resulting term is $-2\operatorname{Ric}(R^2)_{ab}$ and the factor $2$ is the ordered-pair sum.** $-\sum_{c,q,r}R_{aq,cr}R_{cr,bq}=-\sum_q\big[\sum_{c,r}R_{aq,cr}R_{cr,bq}\big]$, and the inner bracket is $2(R^2)_{aq,bq}$ because $(R^2)_{\alpha\beta}=\sum_\gamma R_{\alpha\gamma}R_{\gamma\beta}$ over unordered $\gamma$ while $(c,r)$ runs ordered and the summand is even. Summing over $q$ gives $-2\operatorname{Ric}(R^2)_{ab}$. **The second is $-X$ by definition.** **No finding.**

**The swap gives $X=A_2$, and it needs three symmetries.** Relabelling the dummies $c\leftrightarrow r$,
$$X=\sum_{c,q,r}R_{aq,rc}R_{rb,qc}=-\sum_{c,q,r}R_{aq,cr}R_{qc,rb}=+\sum_{c,q,r}R_{aq,cr}R_{cq,rb}=A_2,$$
the first equality by antisymmetry in $(r,c)$ of the first factor, the second by $R_{rb,qc}=R_{qc,rb}$ which is **pair exchange**, and the third by antisymmetry in $(q,c)$. *The block names pair exchange and leaves the two antisymmetries implicit, which is fair since they are the operator's own.* **No finding.**

**The conclusion follows.** $A_2=-2\operatorname{Ric}(R^2)_{ab}-A_2$ gives $A_2=-\operatorname{Ric}(R^2)_{ab}$, so
$$\operatorname{Ric}(Q(R))_{ab}=\operatorname{Ric}(R^2)_{ab}+A_1+A_2=A_1=\sum_{c,d}R_{ac,bd}\operatorname{Ric}(R)_{cd}.$$
**This is the block's identity with the record's $+$.** *That $\operatorname{Ric}$ is additive in the operator, which the last step uses, is a contraction and needs nothing.* **The screen confirms $X=A_2$ to $7\times10^{-15}$ on and OFF $S^2_B$, and $A_2=-\operatorname{Ric}(R^2)$ only on it, which localises the single Bianchi use to the rewriting and nowhere else in this step.**

## 7. Hypothesis inventory

| Hypothesis | Where it is used |
|---|---|
| Linearity | Step 1's basis expansion of $R[\varphi_\alpha,\varphi_\gamma]$ and Step 2's expansion of the two brackets |
| $R$ maps bivectors to bivectors | Step 1 throughout, Step 2's two doublings, item 5's $\sum_cR_{cp,cq}=\operatorname{Ric}_{pq}$, item 6's swap |
| Self-adjointness | Step 2's collapse of the $R^2$ products, Step 3's pair-exchange symmetry of $B_{ijkl}-B_{ijlk}$, Step 4's swap $X=A_2$, and the agreement of the compact form with `Rsharp_full` |
| First Bianchi | twice in Step 2's $R^2$ form, once in Step 4's $A_2$ |

**Nothing outside the four is used.** *Symmetry of $\operatorname{Ric}$ is never invoked*: $A_1$ is written with both slots free and the final identity carries $\operatorname{Ric}(R)_{cd}$ under a double sum. *It would be free anyway, since pair exchange gives $\operatorname{Ric}_{ab}=\operatorname{Ric}_{ba}$, which is precisely why the block does not need it.* **No named hypothesis is unused.** **Ricci-flatness is used nowhere**, and I checked every step for an unacknowledged vanishing: $\operatorname{Ric}(R)$ appears only as a factor in $A_1$, which is carried to the conclusion rather than dropped, and the screen's random $R\in S^2_B$ has $\lVert\operatorname{Ric}\rVert$ of $5.8$ and $12.5$ with the identity exact, so the derivation is being exercised at $\operatorname{Ric}\ne0$. **The block's claim that Ricci-flatness enters nowhere is correct and is what makes the identity read off closure rather than assume it.**

*Three prose elisions, all one line from stated hypotheses and none a gap*: pair exchange unnamed at Step 2's collapse and at Step 3's "by inspection", the $R^2$ half's membership in $S^2_B$ unremarked in Step 3, and symmetry of $R$ unnamed in the `Rsharp_full` reconciliation of item 9.

## 8. Vacuity and teeth

**The identity is not true for a reason unrelated to the argument.** Both sides are generically nonzero off $\mathcal W_n$ and the content on $\mathcal W_n$ is a cancellation between two nonzero halves. **At a random $W\in\mathcal W_5$ of norm $7.77$** from the joint null space of the Bianchi and Ricci constraints: $\operatorname{Ric}(W^2)$ is positive definite with eigenvalues $13.18$, $19.98$, $24.93$, $30.72$, $31.89$, and $b(W^2)$ reaches $8.93$, while $\operatorname{Ric}(Q(W))$ is $5.3\times10^{-15}$ and $b(Q(W))$ is $1.8\times10^{-15}$. **At $n=4$, $\operatorname{Ric}(W^2)=17.22\,I$ exactly and $b(W^2)$ reaches $6.18$, both cancelled to $3\times10^{-15}$.** *So $\operatorname{Ric}(W^\#)=-\operatorname{Ric}(W^2)$ and $b(W^\#)=-b(W^2)$ hold at full size, and a screen of the halves separately would conclude the sum fails, which is the block's own warning.*

**Off $S^2_B$ the identity fails and the defect is the recorded form.** At a random symmetric operator with $\lvert b(R)\rvert_{\max}$ of $1.49$ and $1.75$: the Ricci defect is $2.216$ at $n=4$ and $6.187$ at $n=5$, matching $\tfrac32\sum_{klm}\operatorname{Alt}(R)_{iklm}\operatorname{Alt}(R)_{jklm}$ to $1.3\times10^{-15}$ and $2.2\times10^{-15}$, and $b(Q(R))$ is $0.281$ and $5.59$. **Both halves have teeth, and the Bianchi hypothesis is load-bearing in both.**

*Every screen figure above is a residual of a few hundredths of a second of arithmetic on objects built for the purpose, reported as a screen. The verdicts rest on sections 1 to 7.*

## 9. Normalisation and reach

**The compact form agrees with `Rsharp_full`, sign and factor.** With $(A_a)_{\gamma\delta}=c_{a\gamma\delta}$,
$$\operatorname{tr}(A_aRA_bR)=\sum c_{a\gamma\delta}R_{\delta\zeta}c_{b\zeta\varepsilon}R_{\varepsilon\gamma}=-\sum c_{a\gamma\delta}c_{b\varepsilon\zeta}R_{\gamma\varepsilon}R_{\delta\zeta},$$
using symmetry of $R$ once and $c_{b\zeta\varepsilon}=-c_{b\varepsilon\zeta}$ once, so $-\tfrac12\operatorname{tr}(A_aRA_bR)=(R^\#)_{ab}$. **The block's "by one antisymmetry of $c$" is right and incomplete by one clause**, since symmetry of $R$ is used too. The implementation matches: `Rsharp_full` computes $-\tfrac12\sum_{m,p}(A_aR)_{mp}(A_bR)_{pm}$, and the screen puts $B_{ijkl}-B_{ijlk}$ against it at $4\times10^{-16}$.

**The polarisation is valid and needs almost nothing of $Q$.** $\mathcal W_n$ is cut out by linear conditions, so it is a linear subspace: $X,Y\in\mathcal W_n$ gives $X+Y\in\mathcal W_n$, all three of $Q(X+Y)$, $Q(X)$, $Q(Y)$ land in $\mathcal W_n$ by the closure just proved, and the subspace absorbs $\tfrac12(\cdot-\cdot-\cdot)$. **It needs only $Q(\mathcal W_n)\subseteq\mathcal W_n$ and linearity of the subspace, not that $Q$ is quadratic.** *That $X\circ Y$ is the bilinear Fox product rather than some other combination is a separate matter and is not what closure needs.*

**The BW corroboration claim is right, with the index-order caveat resolved next door.** BW08 eq. (6)'s $\sum_k\operatorname{Ric}_{kk}R_{kijk}$ read in the record's four-index order is $\sum_k\operatorname{Ric}_{kk}R_{ki,jk}=-\sum_k\operatorname{Ric}_{kk}R_{ik,jk}$, so it is minus the record's right-hand side in a Ricci eigenframe. **I checked the comparison at $\mathrm{id}$**: the record's side is $(n-1)^2\delta_{ab}$ and the BW-ordered expression is $-(n-1)^2\delta_{ab}$, both to $0$ exactly in the screen. *The resolution is on the record*, in the [L208](../findings/curvature-invariants.md) block's sign paragraph, which pins the $+$ against `Qop_id_eq` and `Ric_id_eq` and concludes the disagreement is an index-order convention. **So the L209 block is entitled to call itself corroboration**, and the one thing it leaves to the reader is the pointer: it asserts the eigenframe reading without flagging the sign, and the flag sits in the block below rather than in this one. *The record's sign does not depend on BW either way, being pinned at $\mathrm{id}$ from the record's own definitions.*

## 10. The Lean statement

**`ric_Qop_eq` states the Ricci half and nothing weaker or wider.** Its conclusion is `Ric (Qop R) a b = ∑ c, ∑ d, R4 R a c b d * Ric R c d`, over [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean)'s `Ric R a b = ∑ c, inner2 (R (phi a c)) (phi b c)`, which is $\sum_cR_{ac,bc}$, and `R4 R i j k l = inner2 (R (phi i j)) (phi k l)`, which is $R_{ij,kl}$. **The right-hand side is $\sum_{c,d}R_{ac,bd}\operatorname{Ric}(R)_{cd}$, the block's, with the record's index order.** Its hypotheses are `IsLinOp R`, `∀ X, IsSkew X → IsSkew (R X)`, self-adjointness quantified over bivectors, and `∀ i j k l, bianchi R i j k l = 0` with `bianchi` the record's $R_{ij,kl}+R_{ik,lj}+R_{il,jk}$. **Those are `IsWeyl` minus its Ricci clause plus linearity, exactly the four the prose uses, and Ricci-flatness is absent.** **No finding.**

**The anchors are non-vacuous.** `ric_Qop_id` and `rhs_id` both evaluate to $(n-1)^2\delta_{ab}$, nonzero for $n\ge2$, so `anchors_agree` is a genuine instance of the identity and not $0=0$. *It is also independent of the `sorry`*: it rewrites with the two anchor lemmas rather than instantiating `ric_Qop_eq`, so the pin does not borrow from the gap. **The hypothesis set is inhabited by more than the zero operator**, $\mathrm{id}$ satisfying all four, though the file does not type that discharge and so does not itself certify it.

**What the file leaves out.** The proof, as a named `sorry`. The Bianchi half $b(Q(R))=0$, which is the half my section 4 finds cleanest and which is a formal cancellation in $B$, so it is the more typable of the two. The polarisation to $X\circ Y\in\mathcal W_n$. **And the one that matters most for reading the typed statement as the block's statement**: `Qop` is built from `sharpOp`, the basis reassembly of `sharpBil`, itself the polarisation of `sharpQF`, while Steps 1 and 2 are written over the structure-constant $\#$. *No structure constants exist in the Lean layer at all*, and the only bridge between the two is [sharpOp_id](../lean/HamiltonsCubic/Base/StructureConstants.lean) at $R=\mathrm{id}$. **The file's own docstring says exactly this, so the gap is disclosed rather than hidden**, and outside Lean the bridge is the record's conventions table plus the screen against `Rsharp_full`. *I checked the two normalisations agree at the anchor by hand: `sharpQF` at $\mathrm{id}$ is $-\tfrac12\operatorname{tr}(\mathrm{ad}_\eta^2)=(n-2)\lVert\eta\rVert^2$ through the same Killing constant Step 1 uses, so the $\tfrac14$ of `sharpQF` is the $\tfrac12$ of the definition times the doubling, as its docstring says.*

## 11. What would break L209, and what I did to look for it

**The falsifier is the sign in $X=A_2$.** Had the dummy swap returned $X=-A_2$, Step 4 would read $A_2=-2\operatorname{Ric}(R^2)+A_2$, that is $\operatorname{Ric}(R^2)=0$, false at every $R\ne0$ since $\operatorname{Ric}(R^2)_{ab}=\tfrac12\sum_{c,k,l}R_{ac,kl}R_{bc,kl}$ is a Gram matrix, measured positive definite in section 8. **So the whole Ricci half turns on one pair exchange and two antisymmetries**, and I performed that swap independently in section 6 before reading the block's sentence about it, then screened it at $7\times10^{-15}$ on and off $S^2_B$.

**The second falsifier is the normalisation of $\#$.** Any factor $\lambda\ne1$ against the record's $\#$ would give $\operatorname{Ric}(Q)=(1-\lambda)\operatorname{Ric}(R^2)+\lambda A_1$, and the residual $(1-\lambda)\operatorname{Ric}(R^2)$ is nonzero at every $R\ne0$, **so a wrong factor makes the lemma false rather than vacuous.** I attacked the factor three ways: the Casimir route of Step 1, the independent $B$ route of Step 2, and by hand at $n=3$ on the Killing constant, all returning $(n-2)$.

**What I looked for and did not find**: a step needing symmetry of $\operatorname{Ric}$, a hidden use of $\operatorname{Ric}=0$, a Bianchi application invalid at coinciding indices, an index-order slip in $B$ between Step 2's two uses, and a doubling counted once or thrice. *The one discrepancy my screen first reported, $R^2\ne B_{ikjl}-B_{iljk}$ at residual $9.6$, I chased to my own numpy transpose convention rather than to the record: rebuilt with einsum labels that spell the definition, and again with an explicit quadruple loop, it is exact at $1.8\times10^{-15}$, and an exhaustive search over all $24\times24$ signed pairs of relabellings returns the record's pair among the matches.* **Reporting it would have been a false positive, and the triple check is what caught it.**

## Verdict

**CONFIRMED.** *Both halves of Lemma L209 follow from what is written, at every $n$, from the four named hypotheses and no others, in the record's own normalisation with the record's $+$.* The Bianchi half is a formal cancellation of twelve $B$ terms that uses no property of $B$, and the Ricci half turns on one Bianchi rewriting and one dummy swap, both of which I carried out independently. **Three prose elisions are worth repairing and none affects the verdict**: pair exchange goes unnamed where Step 2 collapses the $R^2$ products and where Step 3 says "by inspection", Step 3 establishes the symmetries for the $\#$ half alone before concluding $Q(R)\in S^2_B$, and item 9's reconciliation with `Rsharp_full` uses symmetry of $R$ besides the antisymmetry of $c$ it names. **What remains owed is Lean, in the order the work is easiest**: the Bianchi half, which is the cancellation table of section 4 and needs no analysis, and the bridge from `sharpOp` to the structure-constant $\#$, without which `ric_Qop_eq` is the block's statement only by a reconciliation the layer makes at $\mathrm{id}$ alone.
