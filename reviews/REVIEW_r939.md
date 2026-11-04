# Reviewer 939: Lemma L220, the diagonal theorem on a four-set subalgebra

Log: [agent_logs/review-r939.log](../agent_logs/review-r939.log)

| # | Claim | Verdict | Reason |
|---|---|---|---|
| 1 | Step 1, subalgebra and criticality | CONFIRMED | claim holds at every $n\ge4$ by a flip in $Q'\setminus Q$, the written witness (a flip outside $Q\cup Q'$) witnesses nothing and needs replacing |
| 2 | Step 2, three products | CONFIRMED | support lemma holds, pattern exact, diagonality of $\nu\circ\nu$ needs $\chi_Q^2=1$, which the text omits |
| 3 | Steps 3 and 4, split and $L_r\nu=0$ | CONFIRMED | every link follows from L120, the symmetry of $T$ and step 2 |
| 4 | Step 5, eigenvalue fixes $\lVert q\rVert$ | CONFIRMED | $L_q\vert_{V_Q}=\tfrac12G$ rederived in the self-dual basis, $\tfrac\theta2$ is forced to be the positive root |
| 5 | Step 6, pairing with $q$ | CONFIRMED | each pairing is the symmetry of $T$ plus step 2 or 4, the cross term lacks its factor $2$ and vanishes anyway |
| 6 | Step 7, $P(q)=18xyz$ and bound | CONFIRMED | four triangles give $12xyz$, cubes give $6xyz$, the upper bound is the direction step 9 consumes |
| 7 | Step 8, the coupling bound | CONFIRMED | the form rederived from the index formula term by term, $K_Q$ is the Klein-four matrix, the column bound is its top eigenvalue |
| 8 | Step 9, equality, $n\ge12$ conclusion | CONFIRMED | the chain and necessity of $W_{\mathbb{CP}^2}$ hold, the converse of "exactly" is owed one sentence, $\Theta_n^2>\tfrac32$ holds exactly from $n=12$ |
| 9 | Scope | PLAUSIBLE | "closes inequality (J)" claims more than the proof gives, the maximiser corollary needs "nonzero", no duplicate on the record |

**Record L220 as proved, with no step refuted, and make six repairs: step 1's separating flip, step 2's diagonality of $\nu\circ\nu$, step 6's factor $2$, the converse of the equality case, the attainment of $\Theta_n$ inside $\mathcal D_n$, and the two overreaching sentences of What it gives.**

## 1. Step 1, the subalgebra and the criticality of its maximum

**Link: $\Gamma$ acts by automorphisms of $\circ$.** $Q$ is $O(n)$-equivariant and $\Gamma\subset O(n)$, so $g(X\circ Y)=gX\circ gY$ for $g\in\Gamma$. The fixed space of any subgroup is then closed under $\circ$. This follows.

**Link: $\mathcal S_Q$ is the fixed space of $H=\ker\chi_Q$.** With the full sign group, L120's summands are exactly the character-isotypic pieces, carrying $1$ on $\mathcal D_n$, $\chi_{Q'}$ on $V_{Q'}$ and $\varepsilon_j\varepsilon_k$ on $V_{jk}$, all pairwise distinct. The fixed space of $H$ is the sum of the summands whose character is trivial on $H$, and by annihilator duality for a finite abelian group those characters are $\{1,\chi_Q\}$. The claim is therefore true at every $n\ge4$, and a direct witness exists at every $n$:

- for $Q'\ne Q$ take $a\in Q'\setminus Q$ and flip $\varepsilon_a$, which lies in $H$ and gives $\chi_{Q'}=-1$,
- for a pair $\{j,k\}\not\subset Q$ flip $\varepsilon_j$ with $j\notin Q$, and for $\{j,k\}\subset Q$ flip $\varepsilon_j\varepsilon_l$ with $l\in Q\setminus\{j,k\}$, which lies in $H$ and gives $\varepsilon_j\varepsilon_k=-1$.

**The written witness is wrong.** The parenthetical says the four-set characters are separated "at $n\ge9$ by a flip outside $Q\cup Q'$". A flip $\varepsilon_m$ with $m\notin Q\cup Q'$ leaves both $\chi_Q$ and $\chi_{Q'}$ at $+1$, so it separates nothing. The phrase reads as a residue of L120's fusion note for $\Gamma\cap SO(n)$, which is a different group. The claim survives through the flip in $Q'\setminus Q$, and the restriction to $n\ge9$ and its fallback clause disappear. **Correction:** replace the parenthetical by "a flip at an index of $Q'\setminus Q$, or of $\{j,k\}\setminus Q$, or $\varepsilon_j\varepsilon_l$ with $l\in Q$ for a pair inside $Q$, at every $n$".

**Link: the maximum on the unit sphere of $\mathcal S_Q$ is critical in $\mathcal W_n$.** The gradient of $P=T(W,W,W)$ is $3Q(W)$. Lagrange on the subspace gives $\pi_{\mathcal S_Q}Q(W)=\lambda W$, and $Q(W)\in\mathcal W_n$ by L209 and $\in\mathcal S_Q$ by the subalgebra property, so $Q(W)=\lambda W$ with $\lambda=\langle Q(W),W\rangle=\theta$. This follows. The same argument shows that the statement's "critical point of $P$ in $\mathcal S_Q$" means the same thing read on $\mathcal S_Q$ or on $\mathcal W_n$, so that reading carries no ambiguity.

**Link: the $\nu=0$ branch.** A maximiser with $\nu=0$ lies in $\mathcal D_n$ and L57 bounds it. This follows.

## 2. Step 2, the three products

**Support lemma, rederived.** Let $W$ be supported on $S^2(\Lambda^2\mathbb R^Q)$. Then $W^2$ is supported there, and $(W^\#)_{\alpha\beta}=\tfrac12\sum c_{\alpha\gamma\delta}c_{\beta\varepsilon\zeta}W_{\gamma\varepsilon}W_{\delta\zeta}$ needs $\gamma,\delta\in\Lambda^2\mathbb R^Q$ with $c_{\alpha\gamma\delta}\ne0$, which forces $\alpha$ to be the bracket direction of two pairs inside $Q$, hence inside $Q$. So $Q(W)$ is supported on $\Lambda^2\mathbb R^Q$. This covers both $q\circ q$ and $\nu\circ\nu$, and it is also what makes zero-padding commute with $Q$ for a tensor supported on $\Lambda^2\mathbb R^Q$.

**$\Pi_Q$ is a subalgebra.** A hollow $K$ supported on $Q$ with zero row sums has the six entries constrained by four row equations of rank $4$ ($K_4$ is not bipartite), leaving the two-dimensional plane with opposite pairs equal and $x+y+z=0$. $\mathcal D_n$ is closed under $\circ$ (a diagonal $W^\#$ has $(W^\#)_{\alpha\beta}\ne0$ only when $\alpha=\beta$), so $q\circ q$ is diagonal, Weyl and supported on $Q$, hence in $\Pi_Q$. The record's $S^{\circ2}+S^2$ phrasing is the same fact in sectional form. This follows.

**$\nu\circ\nu\in\Pi_Q$: the diagonality link is missing from the text.** The record argues only about the diagonal entries $(\nu\#\nu)_{\alpha\alpha}$. Membership in $\Pi_Q$ also needs the off-diagonal entries of $\nu\circ\nu$ to vanish. That is supplied by the character: $\nu\circ\nu$ has character $\chi_Q^2=1$, so it lies in the trivial isotypic summand $\mathcal D_n$, and the support lemma puts it in $\Pi_Q$. **Correction:** add "$\nu\circ\nu$ has character $\chi_Q^2=1$, so it lies in $\mathcal D_n$" before the support sentence.

**The pattern, rederived independently.** On $\Lambda^2\mathbb R^Q=\Lambda^+\oplus\Lambda^-$ take $f_1=(e_{ij}+e_{kl})/\sqrt2$ and its partners, and $g_1=(e_{ij}-e_{kl})/\sqrt2$ and its partners, with the orientation signs absorbed. The bracket constant in the orthonormal $f$ basis is $\sqrt2$, so for a diagonal $d$ on $\Lambda^+$ the map is $Q(d)_1=d_1^2+2d_2d_3$ and cyclically, and $\Lambda^\pm$ do not mix under $\#$. Checks against the record's controls: $d=(2,-1,-1)/\sqrt6$ on $\Lambda^+$ alone gives $P=9d_1d_2d_3=\sqrt{3/2}$, and the same shape on both halves at total norm $1$ gives $\sqrt3/2$, which are Given 4's two anchors. In this basis:

- $\Pi_Q=\{W^+=W^-=\mathop{\mathrm{diag}}(x,y,z)\}$,
- $V_Q=\{W^+=\mathop{\mathrm{diag}}(\alpha),\ W^-=-\mathop{\mathrm{diag}}(\alpha),\ \mathop{\mathrm{tr}}\alpha=0\}$ with $\alpha=(\pm a,\pm b,\pm c)$ under $u\odot v=u\otimes v+v\otimes u$, Bianchi being $\mathop{\mathrm{tr}}W^+=\mathop{\mathrm{tr}}W^-$,
- $\nu\circ\nu$ has both halves equal to $(2\alpha_1^2-\alpha_2^2-\alpha_3^2,\dots)$, since $\alpha_1^2+2\alpha_2\alpha_3=2\alpha_1^2-\alpha_2^2-\alpha_3^2$ on $\mathop{\mathrm{tr}}\alpha=0$.

So $x=2a^2-b^2-c^2$ exactly, cyclically. The pattern is never used downstream, only the membership.

**$D\circ\nu\in V_Q$.** L120 at the diagonal $D$, whose block-diagonality needs only that $D$ is $\Gamma$-fixed. This follows.

## 3. Steps 3 and 4, the split and $L_r\nu=0$

**Step 3.** $Q(D+\nu)=D\circ D+2D\circ\nu+\nu\circ\nu$ by bilinearity of $\circ$ and $X\circ X=Q(X)$. By step 2, $D\circ D+\nu\circ\nu\in\mathcal D_n$ and $2D\circ\nu\in V_Q$, and $\mathcal D_n\perp V_Q$. Comparing components of $Q(W)=\theta W$ gives $D\circ D+\nu\circ\nu=\theta D$ and $L_D\nu=\tfrac\theta2\nu$. This follows.

**Step 4.** $L_r\nu\in V_Q$ by L120 at the diagonal $r$. $\langle L_r\nu,\nu'\rangle=T(r,\nu,\nu')=\langle r,\nu\circ\nu'\rangle$ by the full symmetry of $T$ (conventions). $\nu\circ\nu'\in\Pi_Q$ by polarising step 2 over the linear space $V_Q$. $r\perp\Pi_Q$ by definition. So $L_r\nu$ is orthogonal to all of $V_Q$ while lying in it, hence zero, and $L_q\nu=L_D\nu=\tfrac\theta2\nu$ by linearity of $M\mapsto L_M$. Every link follows.

## 4. Step 5, the eigenvalue fixes $\lVert q\rVert$

**L121 applies to $q$.** L121 needs a pair-diagonal $M$ and nothing else, and $q$ is diagonal. With $M_{ij}+M_{kl}=2x$ the sums are $A=2x$, $B=2y$, $C=2z$. This follows.

**The arithmetic.** $E=A^2+B^2+C^2-AB-BC-CA=4(s-xy-yz-zx)$ with $s=x^2+y^2+z^2$, and $(x+y+z)^2=0$ gives $xy+yz+zx=-\tfrac s2$, so $E=6s$. Given 4 gives $\lVert q\rVert^2=\sum_{a<b}K_{ab}^2=2s$, so $E=3\lVert q\rVert^2$. This follows.

**Independent check of L121's normalisation on $\Pi_Q$.** In the basis of section 2, $(u\circ w)_1=u_1w_1+u_2w_3+u_3w_2$ on each half, so $L_q$ acts on $\alpha$ by $H=\begin{pmatrix}x&z&y\\z&y&x\\y&x&z\end{pmatrix}$, which is L121's $\tfrac12G$ entry for entry. $H\mathbf 1=0$, $\mathop{\mathrm{tr}}H=0$ and $\mathop{\mathrm{tr}}H^2=3s$, so on $\mathbf 1^\perp$ the eigenvalues are $\pm\sqrt{3s/2}=\pm\tfrac{\sqrt3}2\lVert q\rVert=\pm\tfrac12\sqrt E$. The record's value and my rederivation agree, including the factor carried by $L_M=M\circ(\cdot)$.

**Must $\tfrac\theta2$ be the positive root?** Yes. $\nu\ne0$ is an eigenvector of $L_q\vert_{V_Q}$ with eigenvalue $\tfrac\theta2>0$. If $q=0$ then $L_q=0$, a contradiction, so $\sqrt E>0$ and the only positive eigenvalue is $+\tfrac12\sqrt E$. Hence $\tfrac\theta2=\tfrac{\sqrt3}2\lVert q\rVert$ and $\lVert q\rVert^2=\theta^2/3$. This follows.

## 5. Step 6, pairing the $\mathcal D_n$ equation with $q$

**Left side.** $\langle\theta D,q\rangle=\theta\lVert q\rVert^2=\theta^3/3$, using $r\perp q$ and step 5. This follows.

**Expansion.** $D\circ D=q\circ q+2\,q\circ r+r\circ r$. The record writes the middle pairing as $\langle q\circ r,q\rangle$ without its factor $2$. The omission is harmless because the term is zero, but the display should carry the $2$.

**Each pairing.**

- $\langle q\circ q,q\rangle=P(q)$ by definition.
- $\langle q\circ r,q\rangle=T(q,r,q)=\langle r,q\circ q\rangle=0$, since $q\circ q\in\Pi_Q$ (step 2) and $r\perp\Pi_Q$. Symmetry of $T$ used, follows.
- $\langle r\circ r,q\rangle=T(r,r,q)=\langle L_qr,r\rangle=:\kappa$. Symmetry of $T$ used, follows.
- $\langle\nu\circ\nu,q\rangle=T(\nu,\nu,q)=\langle L_q\nu,\nu\rangle=\tfrac\theta2\lVert\nu\rVert^2$ by step 4. Follows.

So $P(q)+\kappa+\tfrac\theta2\lVert\nu\rVert^2=\tfrac{\theta^3}3$, which is the Lean hypothesis `hpair` with $a=\theta^2/3$ and $N=\lVert\nu\rVert^2$. **Correction:** write $2\langle q\circ r,q\rangle$.

## 6. Step 7, $P$ on $\Pi_Q$

**The value.** Given 4's formula is $P=\sum_{a<b}K_{ab}^3+3\sum_{a<b<c}K_{ab}K_{bc}K_{ca}$. The six edges give $2(x^3+y^3+z^3)$, and $x+y+z=0$ gives $x^3+y^3+z^3=3xyz$, so the cubes contribute $6xyz$. Each of the four triangles of $Q$ contains exactly one edge from each opposite pair, so each product is $xyz$ and the triangles contribute $12xyz$. $P(q)=18xyz$, which agrees with the self-dual computation of section 2, where each half contributes $9xyz$. Triangles through an index outside $Q$ contain an edge with $K=0$. This follows.

**The inequality and its direction.** On $x+y+z=0$ at fixed $s$, $x^2y^2z^2$ is maximal when two entries coincide, $x=y=t$, $z=-2t$, $s=6t^2$, $x^2y^2z^2=4t^6=s^3/54$. So $\lvert18xyz\rvert\le18\sqrt{s^3/54}=\sqrt6\,s^{3/2}=\tfrac{\sqrt3}2(2s)^{3/2}$, which is Lean's `pattern_cubic_sq_le`. Step 9 needs an upper bound on $P(q)$, because $P(q)$ enters `hpair` with a plus sign against the lower bound on $\kappa$. $P(q)\le\lvert P(q)\rvert$ gives it, including for negative $P(q)$. Then $\tfrac{\sqrt3}2(\theta/\sqrt3)^3=\theta^3/6$. This follows.

**Equality.** Two entries equal and $xyz>0$, so $(x,y,z)$ is a permutation of $(2t,-t,-t)$ with $t>0$, which is the padded $S^2\times S^2$ matrix of the screen's control. This follows.

## 7. Step 8, the coupling

**The form, rederived from the index formula.** For diagonal $r$ with sectional matrix $R$, $(r^\#)_{ab,ab}=\tfrac12\sum c^2_{ab,\gamma\delta}r_\gamma r_\delta$ runs over the ordered pairs $(\gamma,\delta)\in\{(ac,cb),(cb,ac)\}$, $c\notin\{a,b\}$, so $Q(r)$ has sectional entries $R_{ab}^2+(R^2)_{ab}$. Then $\kappa=\langle Q(r),q\rangle=\sum_{a<b\in Q}K_{ab}\big(R_{ab}^2+\sum_{c\ne a,b}R_{ac}R_{cb}\big)$. Splitting $c$:

- the squares give $x(p^2+p'^2)+y(a'^2+b'^2)+z(c'^2+d'^2)$,
- $c\in Q$: on $ij$ the terms are $R_{ik}R_{kj}+R_{il}R_{lj}=a'd'+c'b'$, on $kl$ they are $R_{ki}R_{il}+R_{kj}R_{jl}=a'c'+d'b'$, summing to $x(a'+b')(c'+d')$, and the $y$ and $z$ terms follow by the same count, which is $\Sigma$ exactly as written,
- $c=m\notin Q$: $\sum_{a<b\in Q}K_{ab}R_{am}R_{bm}=\tfrac12c_m^{\mathsf T}K_Qc_m$.

Doubling gives the record's display, with $q$ in place of $\hat q$ by homogeneity. **Entries outside $Q$'s rows do not enter**, since every $r$-entry in the expansion has an index in $Q$ adjacent to a nonzero $K_{ab}$. This follows.

**$\Sigma=0$.** $\langle r,q'\rangle=x'(p+p')+y'(a'+b')+z'(c'+d')$ vanishes for all $x'+y'+z'=0$ exactly when the three sums coincide. Then $\Sigma=s^2(x+y+z)=0$, Lean's `internal_cross_zero`. This follows.

**Spectrum of $K_Q$.** In the order $(i,j,k,l)$, $K_Q$ is the hollow matrix of the Klein four-group with weights $x,y,z$ on its three involutions. Its eigenvectors are the four characters, with eigenvalues $x+y+z=0$, $x-y-z=2x$, $2y$ and $2z$. This follows.

**The bound.** Let $M=\max(x,y,z)$, which is $\ge0$ because $x+y+z=0$. The squares are at most $M$ times the internal mass. Each $c_m^{\mathsf T}K_Qc_m\le\max(0,2x,2y,2z)\lVert c_m\rVert^2=2M\lVert c_m\rVert^2$. So $2\kappa\le2M(\text{internal mass}+\sum_m\lVert c_m\rVert^2)\le2M\lVert r\rVert^2$, since $\lVert r\rVert^2=\sum_{a<b}R_{ab}^2$ counts every pair with one index in $Q$ once, inside its column. Orthogonality to $\Pi_Q$ is used only for $\Sigma$, and no row sum of $r$ enters. At unit $\hat q$, $3\hat x^2\le2\sum\hat x^2=1$ (Lean's `pattern_entry_sq_le`), so $M\le\lVert q\rVert/\sqrt3$ and $\kappa\le\tfrac\theta3\lVert r\rVert^2$, Lean's `hκ` with $R=\lVert r\rVert^2$. Every link follows.

## 8. Step 9, the equality case and the conclusion at $n\ge12$

**The scalar chain.** $\Pi_Q$, $\mathcal D_n\ominus\Pi_Q$ and $V_Q$ are mutually orthogonal, so $\lVert q\rVert^2+\lVert r\rVert^2+\lVert\nu\rVert^2=1$. The five hypotheses of `theta_sq_le` are then steps 5 to 8 verbatim, and the kernel settles $\theta^2\le\tfrac32$. The intermediate display $\tfrac5{18}\theta^2\le\tfrac13+\tfrac16\lVert\nu\rVert^2$ also checks by hand. This follows.

**Necessity in the equality case.** `equality_case` gives $r=0$ and $\lVert\nu\rVert^2=\tfrac12$. With $\kappa=0$, `hpair` gives $P(q)=\theta(\tfrac{\theta^2}3-\tfrac14)=\tfrac\theta4=\tfrac{\theta^3}6$, so step 7 is tight and $q$ has the shape $(2t,-t,-t)$, $t>0$, $2\cdot6t^2=\tfrac12$. The $+\lambda$ eigenvector of $H$ at this $q$ is $\alpha\propto(2,-1,-1)$, simple because $\lambda=3t>0$, and $\lVert\nu\rVert^2=\tfrac12$ gives $\alpha=\pm t(2,-1,-1)$. So $W^+=(4t,-2t,-2t)$ and $W^-=0$, or the reverse, with $24t^2=1$. That is $W_{\mathbb{CP}^2}$ of either orientation, zero-padded from $\Lambda^2\mathbb R^Q$, with one choice per pairing. This follows.

**Sufficiency is not argued.** "Equality exactly at padded $W_{\mathbb{CP}^2}$" also asserts that this tensor is a critical point in $\mathcal S_Q$ with $\theta=\sqrt{3/2}$, and the proof never says so. It is true and short: $Q(d)=(24t^2,-12t^2,-12t^2)=6t\,d$ on $\Lambda^+$ gives $\theta=6t=\sqrt{3/2}$ at $n=4$, and the support lemma of section 2 makes zero-padding commute with $Q$. **Correction:** add that sentence, citing the support argument rather than the conventions' unproved operator identity for padding.

**The conclusion at $n\ge12$.** The maximum of $P$ on the compact unit sphere of $\mathcal S_Q$ is at least $\Theta_n>0$, since the balanced product lies in $\mathcal D_n\subset\mathcal S_Q$. It is critical by step 1. If $\nu\ne0$ the lemma gives $\theta\le\sqrt{3/2}$, and if $\nu=0$ L57 gives $\theta\le\Theta_n$. So $\sup P=\Theta_n$, attained only on $\mathcal D_n$, provided $\Theta_n>\sqrt{3/2}$. That comparison is exact rather than numerical:

| parity | $\Theta_n^2>\tfrac32$ reduces to | holds from |
|---|---|---|
| even, $\Theta_n^2=2(n-1)(n-2)/n^2$ | $n^2-12n+8>0$, root $6+2\sqrt7\approx11.29$ | $n=12$ |
| odd, $\Theta_n^2=\frac{2(n-1)(n-3)}{(n+1)(n-2)}$ | $n^2-13n+18>0$, root $\approx11.42$ | $n=13$ |

At $n=12$, $\Theta_{12}^2=\tfrac{220}{144}>\tfrac{216}{144}$, so the margin $0.0113$ is a strict rational inequality and no precision question arises. At $n=11$, $\Theta_{11}^2=\tfrac{160}{108}<\tfrac32$, so $12$ is the sharp threshold for this use of the lemma. **One unstated input:** the conclusion needs $\Theta_n$ to be attained inside $\mathcal D_n$, which Given 3 does not state (L57 is only the upper bound). The balanced product supplies it, and the proof should cite it.

## 9. Scope

**Hypotheses.** Every hypothesis used is stated or is on the record: L120, L121, L57, L209, the $O(n)$-equivariance of $Q$ and the symmetry of $T$. The attainment of $\Theta_n$ in $\mathcal D_n$ (section 8) is the only input used and not named. $n\ge5$ is never used: at $n=4$, $\mathcal D_4=\Pi_Q$, $r=0$, and the argument runs unchanged. That restriction is harmless.

**"It closes I101 and inequality (J)" claims more than the proof gives.** (J), as the screen script states it, is a whole-sphere inequality over every unit diagonal $d$ with $e(d)>\Theta_n/2$. L220 is a statement about critical points in $\mathcal S_Q$, and its lever (step 5) is available only at a critical point. It reaches the conclusion (J) was introduced to reach, the single-four-set case of I100, by a route that bypasses (J), and it proves nothing about arbitrary $d$. (J) is tight at padded $S^2\times S^2$ exactly when $\Theta_n^2=\tfrac32$, which is consistent with L220 but is no derivation of it. **Correction:** "It closes I101 by a critical-point route that supersedes (J), which remains unproved as a whole-sphere inequality."

**The maximiser corollary needs "nonzero".** Read literally, "no global maximiser at $n\ge12$ has its off-diagonal part, in any frame, inside a single four-set block" fails at every diagonal maximiser, whose off-diagonal part is $0\in V_Q$. With "nonzero" it follows: a global maximiser lying in some frame's $\mathcal D_n\oplus V_Q$ is critical in $\mathcal W_n$ with $\theta\ge\Theta_n>\sqrt{3/2}$, so $\nu=0$. The frame enters only through which $\mathcal D_n$ and $V_Q$ are meant, and the lemma holds in each, so "in any frame" is justified. **Correction:** "no global maximiser at $n\ge12$ has a nonzero off-diagonal part, in any frame, lying inside a single four-set block".

**Duplication.** A search of findings/ for $\mathcal S_Q$, $\mathcal D_n\oplus V_Q$, "four-set subalgebra" and "four-set component" returns only L220 and its row in findings/INDEX-results.md. The result is new on the record.

**Where a hole would have mattered, and why there is none.** The closure of a far-region case turns on three facts the kernel does not see: the eigenvalue normalisation of step 5, the column bound of step 8 and the orthogonality that kills $\Sigma$. Each was rederived here from the index formula and the self-dual basis, independently of L121's text, and each agrees with the record to the constant. No numerical work was done.
