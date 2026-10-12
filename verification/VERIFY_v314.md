# Verifier v314, whether Lemma L100's dichotomy holds at n=8

The brief [ADJ_L100_A1.md](ADJ_L100_A1.md) was read cold. No numerical work was done and no scripts were written. Every value below is exact: closed forms, or terminating decimals compared by hand as rational numbers. Log: [agent_logs/verify-L100-v314.log](../agent_logs/verify-L100-v314.log).

| # | claim | verdict |
| --- | --- | --- |
| C1 | No quoted passage states $\alpha\le\tfrac13$ at $n=8$: the block's statement says $9\le n\le11$, [Lemma L21](../findings/route-a.md) is stated for $n\ge9$, and Nienhaus Theorem 4.14 for $n\ge9$ | CONFIRMED |
| C2 | Every input of [Lemma L20](../findings/route-a.md)'s proof other than $\alpha\le\tfrac13$ holds at $n=8$ word for word | CONFIRMED |
| C3 | $\alpha\le\tfrac13$ at $n=8$ follows from L21 at $n=9$ by padding $\mathcal W_8\hookrightarrow\mathcal W_9$ | CONFIRMED |
| C4 | $\psi(\varphi)\le1$ on $[0,0.5748]$, via $\psi\le1\iff s^3+s^2+s\le1$ | CONFIRMED |
| C5 | The splitting of $\Lambda^2\mathbb R^4$ under $SO(4)$ makes the $n=8$ case fail (route-a.md line 59) | REFUTED AS STATED |

**Summary: the $n=8$ endpoint is VALID. It rests on exactly the input the $9\le n\le11$ range rests on, L21 read at $n=9$, and a padding argument the text leaves unwritten supplies it.**

## 0. Conventions, fixed once

- $\mathcal W_n$ is the space of algebraic Weyl operators on $\Lambda^2\mathbb R^n$ with the half-trace (pair-basis Frobenius) inner product, as fixed in [conventions.md](../findings/conventions.md).
- $Q(W)=W^2+W^\#$, $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))=\tfrac12(XY+YX)+X\#Y$, $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ totally symmetric, $P(W)=T(W,W,W)$.
- $(W^\#)_{ab}=\tfrac12\sum c_{acd}c_{bef}W_{ce}W_{df}$ with $c_{abc}=\langle[v_a,v_b],v_c\rangle$ over the orthonormal pair basis $v_{ij}$, $i<j$.
- $u=W_{\mathbb{CP}^2}$ padded, unit norm, $Q(u)=\theta^*u$ with $\theta^*=\sqrt{3/2}$. $F_u(h)=u\circ h$.
- $\alpha=\sqrt{2/3}\,\langle F_uV,V\rangle$ for a unit $V\in u^\perp\cap T_u(SO(n).u)^\perp$. $\mathcal O_n=SO(n).u$.
- $d$ is geodesic angular distance, $\cos d(X,Y)=\langle X,Y\rangle$. In the proof, $m=\sqrt{2/3}\max P$ (the attained maximum, never $n-4$). I write $n-4$ for the dimension.
- $\iota:\mathcal W_8\to\mathcal W_9$ is extension by zero: $(\iota W)_{abcd}=W_{abcd}$ when all indices are $\le8$, and $0$ when any index is $9$.

## 1. Hypothesis inventory

The dichotomy at a given $n$ is the implication "if some maximizer $W^*$ has $\varphi=d(W^*,\mathcal O_n)\le0.5748$ then $\max P\le\sqrt{3/2}$", applied to every maximizer. L20's proof uses the following, each checked at $n=8$ in the section named.

| # | input | $n$-dependence | where checked |
| --- | --- | --- | --- |
| H1 | the unit sphere of $\mathcal W_8$ is compact, so $\max P$ is attained | none | §2 |
| H2 | $P$ and $d$ are $SO(8)$-invariant | none | §2 |
| H3 | $\mathcal O_8$ is a compact embedded submanifold, so a nearest point exists | none | §2 |
| H4 | first variation at a nearest point with $\varphi>0$ gives $V\perp T_u\mathcal O_8$ | none | §2 |
| H5 | $Q(u)=\theta^*u$ in $\mathcal W_8$, so the cubic expansion has no linear term | padding | §2 |
| H6 | $\alpha\le\tfrac13$ on $u^\perp\cap T_u\mathcal O_8^\perp$ | the step's whole content | §3 |
| H7 | $\gamma_V=\sqrt{2/3}P(V)\le m$ | none | §2 |
| H8 | $\psi\le1$ on $[0,0.5748]$ | none | §4 |
| H9 | the branch $\varphi=0$ | none | §2 |

The closing contradiction of L20 (the witness with $P>\sqrt{3/2}$ from $n\ge12$) is no part of L100's dichotomy and is never used below.

## 2. The inputs that carry over unchanged (C1, C2)

**C1.** The block's statement (route-a.md line 69) opens "A bonus at $9\le n\le11$" and says "The derivation holds at every $n\ge9$". L21's statement (line 180) begins "Let $n\ge9$". The Nienhaus notes quote Theorem 4.14 as "For $n\ge9$". So the heading's "$8\le n\le11$" (line 55) reaches one dimension below every written support, and as written the $n=8$ case of H6 has no source. The rest of this section and §3 decide whether that is a gap in the writing or in the mathematics.

**H1 to H4, H7, H9.** The unit sphere of the finite-dimensional space $\mathcal W_8$ is compact and $P$ is continuous. $SO(8)$ acts on $\mathcal W_8$ by conjugation, orthogonally for the Frobenius pairing, and $Q$ is equivariant, so $P$ and $d$ are invariant. An orbit of a compact Lie group acting smoothly is a compact embedded submanifold, so $X\mapsto\langle W^*,X\rangle$ attains its maximum on $\mathcal O_8$ and, after rotating, at $u$. For a curve $g(t).u$ in $\mathcal O_8$ with velocity $\xi\in T_u\mathcal O_8$, stationarity gives $\langle W^*,\xi\rangle=0$. Writing $W^*=\cos\varphi\,u+\sin\varphi\,V$ with $V\perp u$ and using $\xi\perp u$ (the orbit lies on the unit sphere), this is $\sin\varphi\langle V,\xi\rangle=0$, so $V\perp\xi$ once $0<\varphi\le0.5748<\pi$. $\gamma_V\le m$ holds because $V$ is a unit element of $\mathcal W_8$. At $\varphi=0$, $W^*\in\mathcal O_8$ and $\max P=P(u)=\sqrt{3/2}$, which is the first horn. None of these steps mentions $n$.

**H5.** $u$ is supported on $\Lambda^2\mathbb R^4$. The product $u^2$ is supported there. In $(u^\#)_{ab}=\tfrac12\sum c_{acd}c_{bef}u_{ce}u_{df}$ the summation indices $c,d,e,f$ lie in $\mathfrak{so}(4)$, and $c_{acd}=\langle[v_c,v_d],v_a\rangle$ vanishes for $a\notin\mathfrak{so}(4)$ because $[\mathfrak{so}(4),\mathfrak{so}(4)]\subseteq\mathfrak{so}(4)$. For $a,b\in\mathfrak{so}(4)$ the constants are those of $\mathfrak{so}(4)$. So $Q_n(u)$ is the padding of $Q_4(W_{\mathbb{CP}^2})=\theta^*W_{\mathbb{CP}^2}$ at every $n\ge4$, in particular at $n=8$. Then $T(u,u,V)=\langle Q(u),V\rangle=\theta^*\langle u,V\rangle=0$, and the expansion

$$m=\cos^3\varphi+3\cos\varphi\sin^2\varphi\,\alpha+\sin^3\varphi\,\gamma_V$$

is the trinomial expansion of the cubic form $P$ with $T$ totally symmetric, $\sqrt{2/3}P(u)=1$, and $T(u,V,V)=\langle u\circ V,V\rangle=\langle F_uV,V\rangle$. It holds at $n=8$ exactly as at $n=9$.

## 3. The eigenvalue bound at n=8 from L21 at n=9 (C3, C5)

**Claim.** Let $V\in\mathcal W_8$ be a unit vector with $V\perp u$ and $V\perp T_u\mathcal O_8$. Then $\iota V$ is a unit vector of $\mathcal W_9$ with $\iota V\perp u$, $\iota V\perp T_u\mathcal O_9$, and $\langle F_u^{(9)}\iota V,\iota V\rangle=\langle F_u^{(8)}V,V\rangle$. Hence L21 at $n=9$ gives $\alpha\le\tfrac13$ at $n=8$.

**Step 1, $\iota$ lands in $\mathcal W_9$ and is an isometry.** The pair symmetries and the first Bianchi identity are identities among components with a common index set, so they survive extension by zero. The Ricci contraction $\sum_{k\le9}(\iota W)_{ikjk}$ equals $\sum_{k\le8}W_{ikjk}=0$ for $i,j\le8$, and vanishes identically when $i$ or $j$ is $9$. So $\iota W$ is Weyl. The pair basis of $\Lambda^2\mathbb R^8$ is a sub-basis of that of $\Lambda^2\mathbb R^9$, so $\iota$ preserves the inner product. Also $\iota u=u$ (both are the padding of $W_{\mathbb{CP}^2}$), so $\iota V\perp u$.

**Step 2, the Rayleigh quotient is unchanged.** $\langle F_u^{(9)}\iota V,\iota V\rangle=\sum_{a,b}(u\circ\iota V)_{ab}(\iota V)_{ab}$ receives contributions only from $a,b\in\mathfrak{so}(8)$, since $\iota V$ vanishes elsewhere. For such $a,b$: $\tfrac12(u\,\iota V+\iota V\,u)_{ab}$ sums over an intermediate index where both factors are nonzero only inside $\mathfrak{so}(8)$, and in $(u\#\iota V)_{ab}=\tfrac12\sum c_{acd}c_{bef}u_{ce}(\iota V)_{df}$ the support of $u$ and $\iota V$ forces $c,d,e,f\in\mathfrak{so}(8)$, where the structure constants of $\mathfrak{so}(9)$ restrict to those of $\mathfrak{so}(8)$ because $\mathfrak{so}(8)$ is a subalgebra spanned by a sub-basis. So each entry equals the $\mathcal W_8$ entry, and the pairing is $\langle F_u^{(8)}V,V\rangle$. Whether $F_u$ is read with or without a projection onto the Weyl space is immaterial, since $\iota V$ is Weyl and a projection is self-adjoint.

**Step 3, orthogonality to the larger orbit.** $T_u\mathcal O_9=\{X\cdot u:X\in\mathfrak{so}(9)\}$ with $X\cdot u$ the derivation action, $(X\cdot u)_{abcd}=-(X_{ap}u_{pbcd}+X_{bp}u_{apcd}+X_{cp}u_{abpd}+X_{dp}u_{abcp})$. Split $\mathfrak{so}(9)=\mathfrak{so}(8)\oplus\mathrm{span}\{e_i\wedge e_9:i\le8\}$.

- For $X\in\mathfrak{so}(8)$ the action preserves index support in $\{1,\dots,8\}$, so $X\cdot u=\iota(X\cdot_8u)$ with $X\cdot_8u\in T_u\mathcal O_8$, and $\langle\iota V,X\cdot u\rangle=\langle V,X\cdot_8u\rangle=0$ by hypothesis.
- For $X=e_i\wedge e_9$ the only nonzero entries are $X_{i9}$ and $X_{9i}$. In each of the four terms, $u$ needs all of its own indices in $\{1,\dots,4\}$, so the summed index is $p=i$ and the free index it replaces is $9$. Every nonzero component of $X\cdot u$ therefore has exactly one index equal to $9$, while every nonzero component of $\iota V$ has none. The componentwise pairing is $0$.

By linearity $\iota V\perp T_u\mathcal O_9$. Step 1 to Step 3 place $\iota V$ in the domain of L21 at $n=9$, which gives $\sqrt{2/3}\langle F_u^{(9)}\iota V,\iota V\rangle\le\tfrac13$, and Step 2 converts that into $\alpha\le\tfrac13$ at $n=8$. $\square$

**Arguing the opposite (C5).** Route-a.md line 59 says that at $n=8$ "the failure is structural rather than bookkeeping", because $\mathfrak{so}(4)$ is not simple and $\Lambda^2\mathbb R^4$ splits under $SO(n-4)=SO(4)$. That is a correct description of why L21's own isotypic proof does not run at $n-4=4$: the multiplicity-space factorisation needs absolutely irreducible $SO(n-4)$-types. It is a statement about a method. The inequality at $n=8$ is a Rayleigh-quotient bound over a subset of the $n=9$ constraint set, so it inherits the $n=9$ bound whatever the $SO(4)$ representation theory does. Read as "the $n=8$ case of the dichotomy fails or is unsupported", the line is refuted as stated. Read as "L21's proof does not reach $n=8$ directly", it is correct and harmless.

**What the $n=8$ case consumes.** It consumes L21 at $n=9$ and nothing else. The $n=9$ instance is already consumed by the $9\le n\le11$ range, so extending to $n=8$ adds no new debt. Whatever L21's recorded obligation on the four $F_\lambda$ spectra is, $n=8$ stands or falls with $n=9$.

## 4. The radius (C4)

With $s=\sin\varphi$, $c=\cos\varphi$ and $\varphi\in[0,\pi/2)$, $\psi(\varphi)\le1$ is $c\le1-s^3$. Both sides are nonnegative, so this is $1-s^2\le1-2s^3+s^6$, that is $s^2(s^4-2s+1)\ge0$. The identity $s^4-2s+1=(s-1)(s^3+s^2+s-1)$ and $s<1$ reduce it to $g(s):=s^3+s^2+s-1\le0$. $g$ is strictly increasing on $[0,1]$ with $g(0)=-1$ and $g(1)=2$, so its real root $s^*$ in $(0,1)$ exists and $\psi\le1\iff s\le s^*$. Since $\sin$ increases on $[0,0.5748]$, it suffices that $g(\sin0.5748)\le0$.

- **Upper bound for the sine.** For $x\ge0$, $\sin x\le x-\tfrac{x^3}6+\tfrac{x^5}{120}$. At $x=0.5748$: $x^2=0.33039504$ and $x^3=0.189911068992$ exactly, so $x^3/6=0.031651844832$. Also $x^5=x^3x^2\le0.18992\times0.3304=0.062749568$, so $x^5/120\le0.00052292$. Hence $\sin0.5748\le0.5748-0.031651844832+0.00052292=0.543671075168<0.543672$.
- **The sign of $g$ there.** $0.543672^2=0.295579243584$ exactly (from $543672^2=295579243584$), so $s^2\le0.29558$ and $s^3\le0.29558\times0.543672=0.16069856976\le0.160699$. Then $g(0.543672)\le0.160699+0.29558+0.543672-1=-0.000049<0$.

So $\sin0.5748<0.543672<s^*$, and $\psi\le1$ on $[0,0.5748]$. With H6 and H7, and $\cos\varphi>0$, $\sin\varphi\ge0$, the display gives $m\le\cos\varphi+m\sin^3\varphi$, and $1-\sin^3\varphi>0$ gives $m\le\psi(\varphi)\le1$, that is $\max P\le\sqrt{3/2}$. None of this depends on $n$.

## 5. Verdict for the step

**VALID.** At $n=8$ every input of the L20 derivation holds as at $n=9$ (§2, §4). The single dimension-sensitive input $\alpha\le\tfrac13$, which no quoted passage states at $n=8$, follows from L21 at $n=9$ because extension by zero embeds the $n=8$ constraint set isometrically into the $n=9$ one with the same Rayleigh quotient (§3). The heading's range $8\le n\le11$ is therefore correct as mathematics, conditional on L21 at $n=9$ exactly as the $9\le n\le11$ range is. The text as written leaves the $n=8$ endpoint unargued, and the block's own sentence "A bonus at $9\le n\le11$" contradicts its heading, so the fix is to write the padding reduction into the block rather than to shrink the range.
