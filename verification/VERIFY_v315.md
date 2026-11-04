# Verifier v315, the $n=8$ endpoint of Lemma L100's heading

**Cold brief ([ADJ_L100_A1.md](ADJ_L100_A1.md)). No numerical work was done and no scripts were written. Every value used is exact, and the only decimals below are quoted from the record. Log at [agent_logs/verify-L100-v315.log](../agent_logs/verify-L100-v315.log).**

| # | Claim | Verdict |
| --- | --- | --- |
| 1 | The quoted passages supply $\alpha\le\tfrac13$ only at $n\ge9$ ([L21](../findings/route-a.md) statement, the block's "$9\le n\le11$", [Nienhaus](../references/nienhaus-2023-second-best-einstein/notes.md) 4.14 "for $n\ge9$"), so none of them reaches $n=8$ directly | CONFIRMED |
| 2 | Every input of [Lemma L20](../findings/route-a.md)'s proof other than $\alpha\le\tfrac13$ holds at $n=8$ with the same argument | CONFIRMED |
| 3 | The dichotomy consumes only the conclusion $m\le1$ of the supposition, never the sphere-product witness, so the witness's failure at $n=8$ is harmless | CONFIRMED |
| 4 | Zero-padding $\iota:\mathcal W_8\to\mathcal W_9$ is an isometry fixing $u$, preserving $\langle u\circ h,h\rangle$, and mapping $u^\perp\cap T_u\mathcal O_8^\perp$ into $u^\perp\cap T_u\mathcal O_9^\perp$ | CONFIRMED |
| 5 | Hence $\alpha\le\tfrac13$ at $n=8$ follows from [L21](../findings/route-a.md) at $n=9$ | CONFIRMED |
| 6 | The heading's dichotomy at $n=8$ holds on exactly the input the block carries at $9\le n\le11$, namely L21 at $n=9$, with no further debt specific to $n=8$ | CONFIRMED |
| 7 | L20's written bracket "$s^*\in(0.5436,0.5437)$ against $\sin(0.5748)=0.5436669$" decides $\sin(0.5748)\le s^*$ (dimension-free, outside the step) | REFUTED AS STATED |

**Summary: the step is VALID, because a padding lemma reduces $\alpha\le\tfrac13$ at $n=8$ to Lemma L21 at $n=9$ and the rest of L20's argument is dimension-free.**

## 0. Conventions, fixed once

- $\mathcal W_n=\mathrm{Weyl}_n$ with the Frobenius inner product. $Q(W)=W^2+W^\#$ with $\#$ the halved Böhm–Wilking product, $(W^\#)_{ab}=\tfrac12\sum c_{acd}c_{bef}W_{ce}W_{df}$ over structure constants of $\mathfrak{so}(n)$ in an orthonormal basis ([conventions.md](../findings/conventions.md)). $P(W)=\langle W,Q(W)\rangle$ and $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ is its fully symmetric polarisation, $X\circ Y=\tfrac12(XY+YX)+X\#Y$.
- $u=W_{\mathbb{CP}^2}$ padded, unit, $Q(u)=\theta^*u$, $\theta^*=\sqrt{3/2}$. $F_uh=u\circ h$. $\mathcal O_n=SO(n).u$ and $T_u\mathcal O_n=\{X\cdot u:X\in\mathfrak{so}(n)\}$ with $X\cdot u=\tfrac{d}{dt}\big|_0\exp(tX)\,u\,\exp(-tX)$.
- $\alpha(V)=\sqrt{2/3}\,\langle F_uV,V\rangle$ for unit $V\in u^\perp\cap T_u\mathcal O_n^\perp$. $\bar\alpha_n$ denotes its supremum over that set.
- $d$ is geodesic angular distance, $\cos d(X,Y)=\langle X,Y\rangle$ ([conventions.md](../findings/conventions.md)). $m=\sqrt{2/3}\max P$ is the attained maximum, never $n-4$ in this report.
- $\iota$ is zero-padding along $\mathbb R^8\subset\mathbb R^9$ (last coordinate $e_9$): an operator $R$ on $\Lambda^2\mathbb R^8$ becomes $R\oplus0$ on $\Lambda^2\mathbb R^9=\Lambda^2\mathbb R^8\oplus(\mathbb R^8\wedge e_9)$.

## Hypothesis inventory

| Input used at $n=8$ | Source | Depends on $n$? |
| --- | --- | --- |
| H1. Unit sphere of $\mathcal W_8$ compact, so $m$ attained | finite dimension | no |
| H2. $d$ is $SO(n)$-invariant | conjugation is orthogonal on $\mathcal W_n$ | no |
| H3. $\mathcal O_8$ compact embedded submanifold, nearest point exists, first variation holds | orbit of a compact Lie group | no |
| H4. $u\in\mathcal W_8$ unit and critical, $Q(u)=\theta^*u$ | brief's Definitions ("padded $W_{\mathbb{CP}^2}$ lies in $\mathcal W_n$ for every $n\ge4$"), criticality by §3 (P2) | no |
| H5. $T$ fully symmetric, $T(u,V,V)=\langle F_uV,V\rangle$ | [conventions.md](../findings/conventions.md) row $T$ | no |
| H6. $\gamma_V\le m$ | definition of $m$ | no |
| H7. $\alpha\le\tfrac13$ on $u^\perp\cap T_u\mathcal O_8^\perp$ | **not in the passages at $n=8$**, supplied by §3 from [L21](../findings/route-a.md) at $n=9$ | yes, reduced |
| H8. $\psi\le1$ on $[0,0.5748]$ | L20's reduction to $s^3+s^2+s\le1$ | no |
| H9. Witness with $P>\sqrt{3/2}$ | L20's contradiction step | **not used by the dichotomy** |

## 1. What the passages supply, and where they stop

The heading ([route-a.md:55](../findings/route-a.md#L55)) reads "the $8\le n\le11$ dichotomy". The block's own statement ([route-a.md:69](../findings/route-a.md#L69)) reads "A bonus at $9\le n\le11$" and "The derivation holds at every $n\ge9$". [Lemma L21](../findings/route-a.md#L180) opens "Let $n\ge9$". Nienhaus's Theorem 4.14 opens "For $n\ge9$", and his Remark 4.12 records only the $n=8$ decomposition, with no eigenvalue statement. So the heading's lower endpoint is not carried by any quoted sentence, and heading and statement disagree by one dimension. The question is whether standard mathematics closes that one dimension.

The dichotomy itself has a fixed logical shape. Padding gives $M(n)\ge\sqrt{3/2}$ at every $n\ge4$, so the first horn is $M(8)=\sqrt{3/2}$ and the content is the implication "if some maximiser lies within $0.5748$ of $\mathcal O_8$ then $m\le1$". That implication is exactly L20's proof up to "Hence $m\le1$". The following sentences (the best-split witness, "Therefore $\varphi>0.5748$") convert $m\le1$ into a contradiction at $n\ge12$ and play no part in the dichotomy. At $n=8$ the witness is absent, since $\theta_0(8)^2=\tfrac{84}{64}<\tfrac32$, and nothing requires it (claim 3).

## 2. The L20 argument at $n=8$, input by input

Let $W^*$ be any maximiser in $\mathcal W_8$ with $\varphi=d(W^*,\mathcal O_8)\le0.5748$.

- **Degenerate branch.** If $\varphi=0$ then $W^*\in\mathcal O_8$ and $m=\sqrt{2/3}\,P(u)=1$, which is the first horn.
- **Rotation and first variation (H2, H3).** For $\varphi\in(0,0.5748]$ pick a nearest point and rotate it to $u$. Maximising $Y\mapsto\langle W^*,Y\rangle$ over $\mathcal O_8$ at $Y=u$ gives $W^*\perp T_u\mathcal O_8$. Since $\mathcal O_8$ lies in the unit sphere, $T_u\mathcal O_8\perp u$. Writing $W^*=\cos\varphi\,u+\sin\varphi\,V$ with $V$ unit and $V\perp u$, the two orthogonalities give $V\perp T_u\mathcal O_8$ because $\sin\varphi\ne0$.
- **Expansion (H4, H5).** $P(W^*)=\cos^3\varphi\,P(u)+3\cos^2\varphi\sin\varphi\,T(u,u,V)+3\cos\varphi\sin^2\varphi\,T(u,V,V)+\sin^3\varphi\,P(V)$. Criticality gives $T(u,u,V)=\langle Q(u),V\rangle=\theta^*\langle u,V\rangle=0$. Multiplying by $\sqrt{2/3}$ gives $m=\cos^3\varphi+3\cos\varphi\sin^2\varphi\,\alpha+\sin^3\varphi\,\gamma_V$, with nothing depending on $n$.
- **Bounds (H6, H7).** With $\cos\varphi\ge0$ and $\sin\varphi\ge0$ on the interval, $\alpha\le\tfrac13$ and $\gamma_V\le m$ give $m\le\cos\varphi+m\sin^3\varphi$, and $1-\sin^3\varphi>0$ gives $m\le\psi(\varphi)$.
- **Reduction (H8).** For $s=\sin\varphi\in(0,1)$ and $c=\cos\varphi>0$: $\psi\le1\iff s^3\le1-c=\tfrac{s^2}{1+c}\iff s(1+c)\le1\iff c\le\tfrac{1-s}s\iff s^2(1-s^2)\le(1-s)^2\iff s^2(1+s)\le1-s\iff s^3+s^2+s\le1$, the squaring being reversible because both sides are positive. This is dimension-free (its final numerical comparison is discussed in §5).

So every input except H7 is identical at $n=8$ and at $n=9$ (claim 2).

## 3. The padding lemma: $\alpha\le\tfrac13$ at $n=8$ from $\alpha\le\tfrac13$ at $n=9$

**Lemma.** $\bar\alpha_8\le\bar\alpha_9$. In particular [L21](../findings/route-a.md#L180) at $n=9$ gives $\alpha\le\tfrac13$ at $n=8$.

*(P1) $\iota$ is an isometry $\mathcal W_8\to\mathcal W_9$.* It preserves $\mathop{\mathrm{tr}}(RS)$, hence the Frobenius product. A component of $\iota R$ carrying the index $9$ vanishes and every other component equals that of $R$, so the first Bianchi identity transfers componentwise, and $\mathrm{Ric}(\iota R)_{ik}=\sum_{j\le9}(\iota R)_{ijkj}$ has its $j=9$ term zero, so $\mathrm{Ric}(\iota R)=\iota\,\mathrm{Ric}(R)=0$.

*(P2) $\iota$ intertwines $\circ$.* Clearly $\iota(R)\iota(S)=\iota(RS)$. For $\#$, take an orthonormal basis of $\mathfrak{so}(9)$ extending one of $\mathfrak{so}(8)$. In $(\iota R\,\#\,\iota S)_{ab}=\tfrac12\sum c_{acd}c_{bef}(\iota R)_{ce}(\iota S)_{df}$ only $c,d,e,f$ in $\mathfrak{so}(8)$ contribute, and since $\mathfrak{so}(8)$ is a subalgebra, $c_{acd}=0$ whenever $c,d\in\mathfrak{so}(8)$ and $a\notin\mathfrak{so}(8)$. So the result vanishes outside $\mathfrak{so}(8)$ and equals the $n=8$ formula inside it, the structure constants of $\mathfrak{so}(8)$ being the restriction of those of $\mathfrak{so}(9)$ and the normalisation being the same at every $n$. Hence $\iota R\circ\iota S=\iota(R\circ S)$. With $u$ itself a padding, this gives $Q(\iota u)=\iota Q(u)$ (criticality is inherited) and $\langle\iota u\circ\iota h,\iota h\rangle=\langle u\circ h,h\rangle$. Only this quadratic form enters $\alpha$, so the conclusion is the same whether or not $F_u$ is read with a projection onto $\mathcal W_n$.

*(P3) $\iota$ preserves transversality.* Let $V\in\mathcal W_8$ be unit with $V\perp u$ and $V\perp T_u\mathcal O_8$. Then $\langle\iota u,\iota V\rangle=\langle u,V\rangle=0$. Split $X\in\mathfrak{so}(9)$ as $X'+X''$ with $X'\in\mathfrak{so}(8)$ and $X''\in\mathbb R^8\wedge e_9$.

- For $X'$: $\exp(tX')=\mathrm{diag}(g_t,1)$ with $g_t\in SO(8)$, and conjugating a padding by $\mathrm{diag}(g,1)$ pads the conjugate, so $X'\cdot\iota u=\iota(X'\cdot u)$ and $\langle X'\cdot\iota u,\iota V\rangle=\langle X'\cdot u,V\rangle=0$.
- For $X''$: let $\sigma=\mathrm{diag}(1,\dots,1,-1)\in O(9)$. Conjugation by $\sigma$ is orthogonal on $\mathcal W_9$ and fixes every padded operator (it flips the sign of components with an odd number of indices equal to $9$, and a padding has none). Equivariance of the infinitesimal action gives $\sigma\cdot(X''\cdot\iota u)=(\mathrm{Ad}_\sigma X'')\cdot(\sigma\cdot\iota u)=-X''\cdot\iota u$, since $\mathrm{Ad}_\sigma(e_i\wedge e_9)=-e_i\wedge e_9$. Therefore $\langle X''\cdot\iota u,\iota V\rangle=\langle\sigma\cdot(X''\cdot\iota u),\sigma\cdot\iota V\rangle=-\langle X''\cdot\iota u,\iota V\rangle$, which is $0$.

So $\iota V$ is a unit vector in $u^\perp\cap T_u\mathcal O_9^\perp$ with $\alpha_9(\iota V)=\alpha_8(V)$, and L21 at $n=9$ gives $\alpha_8(V)\le\tfrac13$. $\square$

Substituting into §2 yields $m\le1$ at $n=8$, the dichotomy (claims 4 to 6). The group-theoretic defect that the block's Gate 2 note attaches to $n=8$ ($\mathfrak{so}(4)$ not simple, three types reducible) is a defect of running L21's isotypic argument at $m=4$. The padding lemma never runs that argument at $m=4$, it uses L21 only where L21 is stated.

## 4. Arguing the opposite

- **Could a transverse direction at $n=8$ carry a larger Rayleigh quotient?** Its padding would be transverse at $n=9$ with the same quotient by (P2) and (P3), contradicting L21 at $n=9$. So any failure at $n=8$ is a failure of L21 at $n=9$, and is no failure of the step.
- **Could the orbit at $n=8$ be "too small", leaving a $\tfrac12\theta^*$ eigenvector of $F_u$ outside $T_u\mathcal O_8$?** The same padding argument excludes it on the same terms: such a vector would pad to a transverse $\tfrac12$ at $n=9$.
- **Could the heading need the witness at $n=8$?** No. As §1 shows, the dichotomy is the implication ending at $m\le1$, and the witness only appears afterwards to rule out the first horn at $n\ge12$.
- **Is the heading unconditional?** It carries no hypothesis, while [route-a.md:69](../findings/route-a.md#L69) says "wherever $\alpha\le\tfrac13$ holds" and L20 calls $\alpha\le\tfrac13$ "the lemma's one unproved input". The strongest reading the words support is the block's own: the dichotomy holds on that input. Under that reading $n=8$ owes exactly what $n=9$ owes (L21's four $F_\lambda$ spectra at $n=9$) and nothing more, so the one-dimensional discrepancy between heading and statement is a matter of the statement being written too narrowly.

## 5. A remark outside the step: the radius bracket

L20 writes "$s^*\in(0.5436,0.5437)$ against $\sin(0.5748)=0.5436669$". The quoted value $0.5436669$ itself lies in $(0.5436,0.5437)$, so the bracket as written does not separate $\sin(0.5748)$ from $s^*$ and does not by itself decide $\psi(0.5748)\le1$ (claim 7). The record also states $\psi(0.5748)=0.9999937$ and a crossing at $0.5748263$, which would decide it, but I did not check them. **The exact quantity that settles it is the sign of $p(\sin 0.5748)-1$ with $p(s)=s^3+s^2+s$, equivalently of $\sin^3(0.5748)+\cos(0.5748)-1$. Negative confirms the stated radius.** This is identical at every $n$, so it does not bear on the $n=8$ endpoint.

## 6. Verdict

**VALID.** The heading's dichotomy at $n=8$ follows from L20's argument, every input of which is dimension-free except $\alpha\le\tfrac13$, and that input at $n=8$ follows from Lemma L21 at $n=9$ by the padding lemma of §3. So $n=8$ is covered on exactly the terms the block states for $9\le n\le11$. The block's statement "A bonus at $9\le n\le11$" and "The derivation holds at every $n\ge9$", and the Gate 2 note's "Only floating point covers $n=8$", understate the reach by one dimension.
