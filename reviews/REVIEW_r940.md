# Reviewer 940: Lemma L220, the diagonal theorem on a four-set subalgebra

Log: [agent_logs/review-r940.log](../agent_logs/review-r940.log)

| # | Claim | Verdict | Reason |
|---|---|---|---|
| 1 | Step 1, $\mathcal S_Q$ is the fixed space of $\ker\chi_Q$, a subalgebra, its maximum critical | CONFIRMED | true at every $n\ge4$ by a single flip in $Q'\setminus Q$, the written reason (a flip outside $Q\cup Q'$) separates nothing and must be replaced |
| 2 | Step 2, $\Pi_Q$ closed, $\nu\circ\nu\in\Pi_Q$ with $x=2a^2-b^2-c^2$, $D\circ\nu\in V_Q$ | CONFIRMED | $(\nu\#\nu)_{ij,ij}=2bc=a^2-b^2-c^2$ rederived, off-diagonal vanishing needs the character argument the text leaves out |
| 3 | Steps 3 and 4, parity split and $L_r\nu=0$ | CONFIRMED | isotypic split and polarised $\nu\circ\nu'\in\Pi_Q\perp r$ |
| 4 | Step 5, $E=3\lVert q\rVert^2$ and $\lVert q\rVert^2=\theta^2/3$ | CONFIRMED | $(q\circ\nu)_{ij,kl}=xa+zb+yc$ rederived, which is L121's $\tfrac12G$ at $A=2x$ in this normalisation |
| 5 | Step 6, the pairing with $q$ | CONFIRMED | each term by symmetry of $T$ and $q\circ q\in\Pi_Q$, a harmless dropped factor $2$ |
| 6 | Step 7, $P(q)=18xyz\le\theta^3/6$ | CONFIRMED | four triangles each $xyz$, $x^3+y^3+z^3=3xyz$, direction as used |
| 7 | Step 8, the coupling $\kappa\le\tfrac\theta3\lVert r\rVert^2$ | CONFIRMED | form, cross term, column term and spectrum $\{0,2x,2y,2z\}$ all rederived |
| 8 | Step 9, equality at padded $W_{\mathbb{CP}^2}$, $\sup P=\Theta_n$ on $\mathcal S_Q$ at $n\ge12$ | CONFIRMED | arithmetic kernel-checked, equality point identified by hand, $\Theta_n>\sqrt{3/2}$ at every $n\ge12$ of both parities |
| 9 | Scope | PLAUSIBLE | lemma and proof hold, "closes inequality (J)" claims beyond the proof and the maximiser corollary needs "nonzero" |

**The record should pass L220 on statement and proof, replace step 1's flip argument, add the character reason for the off-diagonal part of $\nu\circ\nu$, and reword the "What it gives" paragraph as set out in section 9.**

## 1. Step 1, the subalgebra and criticality

**The claim is true at every $n\ge4$, and the written justification is wrong.** The characters of $\Gamma\cong(\mathbb Z/2)^n$ are $\chi_S(\varepsilon)=\prod_{s\in S}\varepsilon_s$, one per subset $S$, all distinct. $\ker\chi_Q$ is a subgroup of index $2$, so the characters trivial on it form a group of order $2$, namely $\{1,\chi_Q\}$. Concretely, for another four-set $Q'\ne Q$ pick $s\in Q'\setminus Q$ and flip $s$ alone: $\chi_Q=+1$, $\chi_{Q'}=-1$. For a pair $\{j,k\}\not\subset Q$ flip whichever of $j,k$ lies outside $Q$. For $\{j,k\}\subset Q$ flip $j$ and one $m\in Q\setminus\{j,k\}$, which fixes $\chi_Q$ and negates $\chi_{jk}$. None of this needs an index outside $Q\cup Q'$.

**The record's reason fails as written.** A flip of an index $m\notin Q\cup Q'$ has $\chi_Q=\chi_{Q'}=+1$, so it lies in $\ker\chi_Q$ and cannot show that $\chi_{Q'}$ is nontrivial there. The brief's worry about $5\le n\le8$ is therefore a worry about a wrong argument, and the claim has no gap in that range. (The phrase reads like an argument for a determinant-one subgroup, which $\Gamma$ is not: [L120](../findings/second-order.md#lemma-l120-l_m-is-block-diagonal-over-the-sign-characters-at-every-diagonal-critical-point) takes the full sign group.) **Correction**: "since the only characters trivial on the index-two subgroup $\ker\chi_Q$ are $1$ and $\chi_Q$, a single flip in $Q'\setminus Q$ separating $\chi_{Q'}$ and a flip at an index of the pair outside $Q$, or at one index of the pair and one further index of $Q$, separating $\chi_{jk}$."

**The two isotypic components are $\mathcal D_n$ and $V_Q$.** The entry $W_{ab,cd}$ transforms by $\varepsilon_a\varepsilon_b\varepsilon_c\varepsilon_d$, so the trivial component is the operators diagonal in the pair basis, whose Weyl condition is $K\mathbf1=0$ with Bianchi automatic, which is $\mathcal D_n$. The $\chi_Q$ component is spanned by the three entries on disjoint pairs of $Q$ under Bianchi, which is $V_Q$, and it is Ricci-free because every Ricci entry carries a trivial or a pair character. So $\mathcal S_Q=\mathrm{Fix}(\ker\chi_Q)$ holds.

**Subalgebra and criticality follow.** $\Gamma\subset O(n)$ acts by automorphisms of $Q$, so $Q$ maps a fixed space into itself. On the unit sphere of $\mathcal S_Q$ the Lagrange condition reads $\pi_{\mathcal S_Q}Q(W)=\theta W$ with $\theta=P(W)$, and $\pi_{\mathcal S_Q}Q(W)=Q(W)$ because $Q(W)\in\mathcal S_Q$. So the maximiser is a critical point in $\mathcal W_n$, and likewise every critical point of $P|_{\mathcal S_Q}$ is one, which is the reading of "critical point of $P$ in $\mathcal S_Q$" the statement needs. The maximum is positive because $P$ is odd. The $\nu=0$ branch is diagonal and [L57](../findings/problem.md) applies. Each link follows.

## 2. Step 2, the three products

**$\Pi_Q$ is closed.** For $q$ in $\Pi_Q$ and $r'$ in $\Pi_Q$, $(q\circ r')_{ab}=q_{ab}r'_{ab}+\tfrac12\sum_c(q_{ac}r'_{bc}+r'_{ac}q_{bc})$ vanishes when $a$ or $b$ lies outside $Q$, since every term then has a factor with an index outside $Q$. The result lies in $\mathcal D_n$ because $Q(\mathcal W_n)\subseteq\mathcal W_n$ and a product of $\Gamma$-fixed elements is $\Gamma$-fixed, so it is a hollow symmetric matrix supported on $Q$ with zero row sums, and every such matrix has the pattern $x,x,y,y,z,z$ with $x+y+z=0$: row $i$ gives $K_{ij}+K_{ik}+K_{il}=0$, row $j$ gives $K_{ij}+K_{jk}+K_{jl}=0$, row $k$ gives $K_{ik}+K_{jk}+K_{kl}=0$, and these force $K_{kl}=K_{ij}$ and so on. The text asserts zero row sums without this reason, which is a one-clause omission.

**$\nu\circ\nu$ is diagonal by character, which step 2 does not say.** Step 2 argues only about the diagonal entries $(\nu\#\nu)_{\alpha\alpha}$. Membership in $\Pi_Q$ also needs the off-diagonal entries to vanish, and they do because $\chi_Q^2=1$ puts $\nu\circ\nu$ in the trivial component. **Correction**: add "$\nu\circ\nu$ is $\Gamma$-fixed since $\chi_Q^2=1$, so diagonal".

**The pattern, rederived.** Take $\varphi_{ab}=E_{ab}-E_{ba}$, entries antisymmetric in each pair, and $c_{\alpha\gamma\delta}=\langle[\varphi_\gamma,\varphi_\delta],\varphi_\alpha\rangle$ with $[\varphi_{ab},\varphi_{bc}]=\varphi_{ac}$. From $(A\#B)_{\alpha\beta}=\tfrac12\sum c_{\alpha\gamma\delta}c_{\beta\varepsilon\zeta}A_{\gamma\varepsilon}B_{\delta\zeta}$, whose value at the identity is $n-2$ as [conventions.md](../findings/conventions.md) requires,
$$(A\#A)_{ij,ij}=\sum_{k,m}\big(A_{ik,im}A_{jk,jm}-A_{ik,jm}A_{jk,im}\big).$$
Write the signed coordinates as $a=\nu_{ij,kl}$, $b=\nu_{ik,lj}$, $c=\nu_{il,jk}$, the three Bianchi orientations, so $a+b+c=0$ is first Bianchi. For $\nu$ the first sum vanishes (an entry on two pairs sharing an index), and the second has the two terms $(k,m)=(k,l),(l,k)$, namely $-\nu_{ik,jl}\nu_{jk,il}-\nu_{il,jk}\nu_{jl,ik}=-(-b)(c)-(c)(-b)=2bc$. With $(\nu^2)_{ij,ij}=a^2$, $(\nu\circ\nu)_{ij}=a^2+2bc$, and $2bc=(b+c)^2-b^2-c^2=a^2-b^2-c^2$ gives $x=2a^2-b^2-c^2$. A uniform sign change of the convention leaves $bc$ unchanged. For a pair $\alpha$ with an index $m\notin Q$ every term carries $m$ in a factor of $\nu$, as the text says. **Confirmed.**

**$D\circ\nu\in V_Q$** is L120's block preservation at the diagonal $D$, equivalently the character $1\cdot\chi_Q$. Follows.

## 3. Steps 3 and 4, the split and $L_r\nu=0$

**Step 3.** $Q(D+\nu)=D\circ D+2D\circ\nu+\nu\circ\nu$ by bilinearity of $\circ$. By step 2, $D\circ D$ and $\nu\circ\nu$ lie in $\mathcal D_n$ and $D\circ\nu$ in $V_Q$, and the two are orthogonal, so $Q(W)=\theta W$ splits into $D\circ D+\nu\circ\nu=\theta D$ and $2L_D\nu=\theta\nu$. Follows.

**Step 4.** $L_r\nu\in V_Q$ by L120. For $\nu'\in V_Q$, $\langle L_r\nu,\nu'\rangle=T(r,\nu,\nu')=\langle r,\nu\circ\nu'\rangle$ by the full symmetry of $T$, and $\nu\circ\nu'=\tfrac12\big((\nu+\nu')\circ(\nu+\nu')-\nu\circ\nu-\nu'\circ\nu'\big)\in\Pi_Q$ by step 2. As $r\perp\Pi_Q$ in the norm of $\mathcal W_n$, the pairing vanishes for every $\nu'$, so $L_r\nu=0$ and $L_q\nu=\tfrac\theta2\nu$. Follows.

## 4. Step 5, the eigenvalue fixes $\lVert q\rVert$

**L121's normalisation matches, checked by computing $L_q$ on $V_Q$ directly.** $(\tfrac12(q\nu+\nu q))_{ij,kl}=xa$. For $q\#\nu$ at $(ij,kl)$, $q$ diagonal forces $\gamma=\varepsilon\in\{ik,il,jk,jl\}$, each with one $\delta$ and one $\zeta$:

| $\gamma$ | $q_\gamma$ | $c_{ij,\gamma,\delta}$ | $c_{kl,\gamma,\zeta}$ | $\nu_{\delta\zeta}$ | term |
|---|---|---|---|---|---|
| $\varphi_{ik}$ | $y$ | $+1$ at $\varphi_{kj}$ | $-1$ at $\varphi_{il}$ | $\nu_{kj,il}=-c$ | $yc$ |
| $\varphi_{jk}$ | $z$ | $+1$ at $\varphi_{ik}$ | $-1$ at $\varphi_{jl}$ | $\nu_{ik,jl}=-b$ | $zb$ |
| $\varphi_{il}$ | $z$ | $+1$ at $\varphi_{lj}$ | $+1$ at $\varphi_{ik}$ | $\nu_{lj,ik}=b$ | $zb$ |
| $\varphi_{jl}$ | $y$ | $-1$ at $\varphi_{li}$ | $+1$ at $\varphi_{jk}$ | $\nu_{li,jk}=-c$ | $yc$ |

So $(q\#\nu)_{ij,kl}=\tfrac12(2yc+2zb)$ and $(q\circ\nu)_{ij,kl}=xa+zb+yc$, which is the first row of $\tfrac12G$ at $A=2x$, $B=2y$, $C=2z$ acting on $(a,b,c)$. The pair-diagonal $M$ of [L121](../findings/second-order.md#lemma-l121-the-4-set-block-its-spectrum-and-one-necessary-condition-per-4-subset) is therefore the sectional matrix in Given 4's normalisation.

**$E=3\lVert q\rVert^2$.** $E=4(x^2+y^2+z^2-xy-yz-zx)$ and $xy+yz+zx=\tfrac12\big((x+y+z)^2-\sum x^2\big)=-\tfrac12\sum x^2$ give $E=6\sum x^2$, and $\lVert q\rVert^2=\sum_{a<b}K_{ab}^2=2\sum x^2$, so $E=3\lVert q\rVert^2$. Follows.

**The sign.** $\nu\ne0$ lies in $\mathbf1^\perp$ (Bianchi), which L121 makes invariant with spectrum $\pm\tfrac12\sqrt E$. So $\tfrac\theta2$ is one of these, and $\theta>0$ selects $+\tfrac12\sqrt E$, which also excludes $q=0$. Then $\theta^2=E=3\lVert q\rVert^2$. Follows.

## 5. Step 6, the pairing

$\langle D\circ D,q\rangle=\langle q\circ q,q\rangle+2\langle q\circ r,q\rangle+\langle r\circ r,q\rangle$. The middle term is $2\langle r,q\circ q\rangle=0$ by symmetry of $T$ and $q\circ q\in\Pi_Q\perp r$ (the text omits the factor $2$, which multiplies zero). $\langle r\circ r,q\rangle=\langle L_qr,r\rangle$ by symmetry of $T$. $\langle\nu\circ\nu,q\rangle=\langle L_q\nu,\nu\rangle=\tfrac\theta2\lVert\nu\rVert^2$ by symmetry of $T$ and step 5. The right side is $\theta\langle D,q\rangle=\theta\lVert q\rVert^2=\theta^3/3$, using $r\perp q$. $\langle q\circ q,q\rangle=P(q)$ by definition. Each link follows.

## 6. Step 7, $P$ on $\Pi_Q$

The six entries give $\sum K^3=2(x^3+y^3+z^3)$. The four triangles of $Q$ each carry one entry of each letter: $ijk$ gives $K_{ij}K_{jk}K_{ki}=xzy$, $ijl$ gives $xyz$, $ikl$ gives $yxz$, $jkl$ gives $zxy$, so $3\cdot4xyz=12xyz$. With $x+y+z=0$, $x^3+y^3+z^3=3xyz$, so $P(q)=18xyz$. The inequality $(18xyz)^2\le\tfrac34\lVert q\rVert^6$ is kernel-checked, it gives $P(q)\le|P(q)|\le\tfrac{\sqrt3}2\lVert q\rVert^3$ in both signs of $xyz$, and $\lVert q\rVert^3=\theta^3/(3\sqrt3)$ turns it into $\theta^3/6$. Equality needs $xyz>0$ and $x^2y^2z^2=\tfrac1{54}(\sum x^2)^3$, which on $x+y+z=0$ is a permutation of $(2t,-t,-t)$ with $t>0$, the padded $S^2\times S^2$ shape. The direction is the one step 9 consumes, an upper bound on $P(q)$ that becomes a lower bound on $\kappa$. Follows.

## 7. Step 8, the coupling

**The form.** For diagonal $r$, $(r\circ r)_{ab}=r_{ab}^2+\sum_{c\ne a,b}r_{ac}r_{bc}$, so $\kappa=\sum_{a<b\in Q}q_{ab}(r\circ r)_{ab}$ involves only entries $r_{ab}$ with $a\in Q$ or $b\in Q$. Splitting $c$ into $Q$ and its complement:

- the squares give $x(p^2+p'^2)+y(a'^2+b'^2)+z(c'^2+d'^2)$,
- $c\in Q$ gives, at $ij$ and $kl$, $x(a'd'+b'c'+a'c'+b'd')=x(a'+b')(c'+d')$, at $ik$ and $jl$, $y(pd'+p'c'+pc'+p'd')=y(p+p')(c'+d')$, at $il$ and $jk$, $z(pb'+p'a'+pa'+p'b')=z(p+p')(a'+b')$, which is $\Sigma$,
- $c=m\notin Q$ gives $\sum_{a<b\in Q}q_{ab}r_{am}r_{bm}=\tfrac12c_m^{\mathsf T}qc_m$.

So $\kappa=S_1+\Sigma+\tfrac12\sum_mc_m^{\mathsf T}qc_m$, which is the record's $2\langle L_{\hat q}r,r\rangle$ display after scaling by $\lVert q\rVert$. Entries with both indices outside $Q$ do not enter. Follows.

**$\Sigma=0$.** $\langle r,q'\rangle=x'(p+p')+y'(a'+b')+z'(c'+d')$ vanishes for all $x'+y'+z'=0$ exactly when the three sums are equal, and then $\Sigma=s^2(x+y+z)=0$ (kernel-checked). Follows.

**The spectrum.** $\hat q=xP_1+yP_2+zP_3$ with $P_1,P_2,P_3$ the three perfect-matching involutions of $Q$, which commute and share the eigenvectors of the Klein four-group, with eigenvalues $x+y+z=0$ and $x-y-z=2x$, $2y$, $2z$. Follows.

**The bound.** $S_1\le\max(x,y,z)\cdot(\text{internal squares})$ entrywise, and $\tfrac12c_m^{\mathsf T}\hat qc_m\le\tfrac12\cdot2\max(x,y,z)\lVert c_m\rVert^2$ since $\max(x,y,z)\ge0$ on $x+y+z=0$. The internal entries and the column entries are distinct pairs of $r$, so the total is at most $\max(x,y,z)\lVert r\rVert^2$. $3x^2\le2\sum x^2=1$ is kernel-checked, giving $\max\le1/\sqrt3$, and $\kappa\le\tfrac1{\sqrt3}\lVert q\rVert\lVert r\rVert^2=\tfrac\theta3\lVert r\rVert^2$. The discarded row-sum constraints of $r$ only loosen an upper bound. Follows.

## 8. Step 9, equality and the $n\ge12$ conclusion

**Arithmetic.** $q$, $r$, $\nu$ are mutually orthogonal, so $\lVert q\rVert^2+\lVert r\rVert^2+\lVert\nu\rVert^2=1$, and the five scalar hypotheses of the Lean theorem are exactly steps 5 to 8 with $a=\lVert q\rVert^2$, $R=\lVert r\rVert^2$, $N=\lVert\nu\rVert^2$, $p=P(q)$. I take theta_sq_le and equality_case as settled. By hand: $\tfrac{\theta^2}6-\tfrac N2\le\tfrac13(1-\tfrac{\theta^2}3-N)$ is $\tfrac5{18}\theta^2\le\tfrac13+\tfrac N6$, and $N\le1-\tfrac{\theta^2}3$ gives $\tfrac13\theta^2\le\tfrac12$.

**The equality case, which the kernel does not settle, identified by hand.** $\theta^2=\tfrac32$ forces $N=\tfrac12$, $R=0$ and equality in step 7, so $q=(2t,-t,-t)$ up to a permutation of the pairings, with $12t^2=\lVert q\rVert^2=\tfrac12$. Then $\nu$ is a $+\tfrac12\sqrt E$ eigenvector of $\tfrac12G$ at $(A,B,C)=(4t,-2t,-2t)$, where $E=36t^2$ and $G(2,-1,-1)^{\mathsf T}=6t(2,-1,-1)^{\mathsf T}$, a simple eigenvalue since $E>0$. So $\nu=s(2,-1,-1)$ in signed coordinates with $\lVert\nu\rVert^2=2(a^2+b^2+c^2)=12s^2=\tfrac12$, $s=\pm t$. The point is critical: $q\circ q$ has $x$-entry $x^2+2yz=6t^2$ and $y$-entry $y^2+2xz=-3t^2$, so $q\circ q=3tq$, and $\nu\circ\nu$ has $x=8s^2-2s^2=6t^2$, $y=2s^2-4s^2-s^2=-3t^2$, so $\nu\circ\nu=3tq$, and the sum is $6tq=\theta q$ with $\theta=6t=\sqrt{3/2}$. The Fubini-Study Weyl tensor has diagonal $(2,2,-1,-1,-1,-1)$ after removing the constant-curvature part $2$ from $(4,4,1,1,1,1)$, and four-set entries of magnitudes $2,1,1$ that satisfy Bianchi, hence signed $\pm(2,-1,-1)$, and its two parts have equal norm $12$. So the equality set is padded $W_{\mathbb{CP}^2}$ in the frames obtained by permuting $Q$, with $s\mapsto-s$ realised by the flip of one index of $Q$ (orientation reversal). "Exactly at padded $W_{\mathbb{CP}^2}$ on $Q$" holds with that reading of "on $Q$". The written step says only "which is padded $W_{\mathbb{CP}^2}$", and the record should carry the identification in one sentence.

**$n\ge12$.** $\Theta_{12}^2=\tfrac{220}{144}>\tfrac32$, and $\Theta_n^2$ increases in $n$ on each parity: $2(n-1)(n-2)/n^2=2(1-3/n+2/n^2)$ is increasing for $n\ge2$, and at odd $n$, $\Theta_n^2=2\big(1-\tfrac{3n-5}{n^2-n-2}\big)$ with $\tfrac{3n-5}{n^2-n-2}$ decreasing for $n\ge3$, while $\Theta_{13}^2=\tfrac{240}{154}>\tfrac32$ and $\Theta_{11}^2=\tfrac{160}{108}<\tfrac32$. So $n\ge12$ is the exact threshold of this argument. The maximiser on $\mathcal S_Q$ is critical with $\theta\ge\Theta_n$ (the balanced product lies in $\mathcal D_n\subset\mathcal S_Q$), and $\nu\ne0$ would give $\theta\le\sqrt{3/2}<\Theta_n$, so $\nu=0$ and L57 caps it at $\Theta_n$. The margin $0.0113$ at $n=12$ enters only as a strict inequality between two closed forms. Follows.

## 9. Scope

- **Hypotheses.** Nothing unstated is used. $n\ge5$ is never used and the lemma holds at $n=4$, where $r=0$. $\theta>0$ is used at step 5 and at the division in step 9. The reading "critical in $\mathcal S_Q$ equals critical in $\mathcal W_n$" is supplied by step 1.
- **Not on the record under another name.** A search of [findings/](../findings/) for $V_Q$, the four-set block and $\mathcal D_n\oplus V_Q$ returns only L120, L121, L218's use of the block at a diagonal point, and L220's own index row.
- **The maximiser corollary needs "nonzero".** "No global maximiser at $n\ge12$ has its off-diagonal part, in any frame, inside a single four-set block" is literally false as printed, since a diagonal maximiser has off-diagonal part $0\in V_Q$. With "nonzero" it follows: such a $W$ lies in $\mathcal S_Q$ in that frame, is critical in $\mathcal W_n$ with $\theta=\sup P\ge\Theta_n>\sqrt{3/2}$, contradicting L220. **Correction**: "no global maximiser at $n\ge12$ has a nonzero off-diagonal part lying, in some frame, inside a single four-set block."
- **"It closes inequality (J)" claims beyond the proof.** (J), as quoted in [screen_J_fourset.py](../scripts/runs/screen_J_fourset.py), is a whole-sphere inequality on $\mathcal D_n$, $P(d)<3e(d)-4e(d)^3/\Theta_n^2$ for $e(d)>\Theta_n/2$. L220 bounds critical points of $\mathcal S_Q$ and proves no statement about an arbitrary unit $d\in\mathcal D_n$. It closes I101, whose route ran through (J), by replacing (J). **Correction**: "It closes I101 without (J), which remains unproved and is no longer needed for the single-four-set case."
- **The lever paragraph** is an accurate description: both bounds are read at the same $q$, and the only coupling between them is the equality $\lVert q\rVert^2=\theta^2/3$.
