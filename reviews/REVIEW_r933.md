# Reviewer 933: Lemma L217, the value bootstrap at a gapped critical orbit

Log: [agent_logs/review-r933.log](../agent_logs/review-r933.log). Brief: [BRIEF_L217.md](BRIEF_L217.md). Context files opened: [second-order.md](../findings/second-order.md) (L216, L217, L147), [route-a.md](../findings/route-a.md) (L20, L21), [conventions.md](../findings/conventions.md), [L217.lean](../lean/HamiltonsCubic/Results/L217.lean).

| # | Claim | Verdict | Reason |
|---|---|---|---|
| 1 | The expansion in step (2) | CONFIRMED | $P(X)=T(X,X,X)$ with $T$ symmetric gives $1,3,3,1$ exactly, $Q(u_1)=\theta_uu_1$ kills the linear term using only $V\perp u_1$, and $T(u_1,V,V)=\theta_u\langle L_{e_1}V,V\rangle$ by bilinearity |
| 2 | The first-variation step (1) | CONFIRMED | a nearest point exists by compactness, $\langle W^\ast,\xi u_1\rangle=0$ and skewness of $\xi$ give $V\perp T_{u_1}\mathcal O$, and $L_{gx}=gL_xg^{-1}$ with $T_{gu}\mathcal O=gT_u\mathcal O$ carries the gap |
| 3 | The global comparison (3) | CONFIRMED | $P(V)\le m$ is the definition of $m$, $c\ge0$ and $s^3\ge0$ are exactly the two signs used, and $c\ge0$ is genuinely needed |
| 4 | The envelope (4) | CONFIRMED | both cases re-derived, $c\le1-s^2/2$ holds for $c\ge0$, the case split uses exactly $s\le\min(3\gamma,\frac12)$, and the radius $3\gamma$ is sharp for the method to leading order |
| 5 | Corollary (a) | CONFIRMED | $\gamma_{k,k}=\frac1{n-2}$ is the minimum from $n\ge8$, $k\ge6$ meets Given 1, $\theta_u=\theta_0(n)=\Theta_n\le m$ at even $n$, and $\arcsin0.3=0.30469$ |
| 6 | Corollary (b) | CONFIRMED | the exclusion is valid and every product it names meets Given 1, but its bold heading "every sub-maximal sphere product" overclaims, since $S^2\times S^{n-2}$ is outside the body's $p,q\ge3$ |
| 7 | Corollary (c) | PLAUSIBLE | the normalisation $\alpha=\langle L_eV,V\rangle$ and $\frac\pi6<0.5748$ check, but $\gamma=\frac16$ rests on L21's owed $m$-freeness of four blocks (I54), which (c) does not disclose, and the device needs $n\ge12$, unstated |
| 8 | How it sits against the record | REFUTED | the radius gain is $27(1+\sqrt{n-2})/(4\theta_u)$, a factor $3$ larger than the stated $27(1+\sqrt{n-2})/(12\theta_u)$, which is $\gamma/r$ rather than $3\gamma/r$, while the L147 agreement is exact |
| 9 | Scope | CONFIRMED | only $P(V)\le m$ uses maximality, criticality of $W^\ast$ is unused, and since $m\ge P(u)=\theta_u$ always, the conclusion is in fact $m=\theta_u$ |
| 10 | The boundary | CONFIRMED | $\varphi=0$, $\gamma=0$, $\gamma=\frac16$, $s=\frac12$, a non-unique nearest point and $\ker u\ne0$ all pass, none of them touching a step that could fail |

**Summary: the lemma and corollaries (a) and (b) stand as written, and the cycle owes three text repairs: the radius-gain factor is $27(1+\sqrt{n-2})/(4\theta_u)$, not $/(12\theta_u)$, corollary (c) must carry L21's I54 condition and $n\ge12$, and (b)'s heading must say $p,q\ge3$.**

## 1. The expansion in step (2)

Conventions give $P(W)=\langle W,Q(W)\rangle$ and $X\circ Y=\frac12(Q(X+Y)-Q(X)-Q(Y))$. Since $Q$ is homogeneous quadratic, $X\circ X=\frac12(4Q(X)-2Q(X))=Q(X)$, so $T(X,X,X)=\langle Q(X),X\rangle=P(X)$. With $T$ fully symmetric (Given 2), $P(cu_1+sV)=T(cu_1+sV,cu_1+sV,cu_1+sV)$ expands multinomially to $c^3T(u_1,u_1,u_1)+3c^2sT(u_1,u_1,V)+3cs^2T(u_1,V,V)+s^3T(V,V,V)$. The coefficients $1,3,3,1$ are therefore correct.

Symmetry is load-bearing here and it is supplied. Expanding without it gives $P(cu_1+sV)=c^3\langle Q(u_1),u_1\rangle+c^2s\big(\langle Q(u_1),V\rangle+2\langle u_1\circ V,u_1\rangle\big)+cs^2\big(2\langle u_1\circ V,V\rangle+\langle Q(V),u_1\rangle\big)+s^3P(V)$, and it is exactly $\langle u_1\circ V,u_1\rangle=\langle u_1\circ u_1,V\rangle$ and $\langle V\circ V,u_1\rangle=\langle u_1\circ V,V\rangle$ that collapse these into $3T(u_1,u_1,V)$ and $3T(u_1,V,V)$.

The linear term. Criticality of $P$ on the sphere at $u$ means $\nabla P(u)=3Q(u)$ is parallel to $u$ (the gradient formula is again symmetry of $T$), so $Q(u)=\lambda u$ and pairing with $u$ gives $\lambda=P(u)=\theta_u$. By equivariance $Q(u_1)=gQ(u)=\theta_uu_1$. Then $T(u_1,u_1,V)=\langle Q(u_1),V\rangle=\theta_u\langle u_1,V\rangle=0$. Only $V\perp u_1$ is used, and orthogonality to the orbit tangent plays no role in this step.

The quadratic term. $T(u_1,V,V)=\langle u_1\circ V,V\rangle=\langle L_{u_1}V,V\rangle$ by the definition $L_x=x\circ(\cdot)$, and bilinearity of $\circ$ gives $L_{u_1}=\theta_uL_{e_1}$ for $e_1=u_1/\theta_u$. So the display $m=\theta_u(c^3+3cs^2\alpha)+s^3P(V)$ with $\alpha=\langle L_{e_1}V,V\rangle$ is exact. The bound $\alpha\le\frac12-\gamma$ applies because $V$ is a unit vector orthogonal to $u_1$ and to $T_{u_1}\mathcal O$ (item 2). No gap found.

## 2. The first-variation step (1)

Existence. $O(n)$ is compact and acts continuously, so $\mathcal O$ is compact (possibly two $SO(n)$-components, which changes nothing) and $x\mapsto d(W^\ast,x)$ attains its minimum at some $u_1=gu$. No submanifold structure is needed for what follows.

Orthogonality. On the unit sphere $\cos d(X,Y)=\langle X,Y\rangle$, and $\arccos$ is decreasing, so $u_1$ maximises $x\mapsto\langle W^\ast,x\rangle$ on $\mathcal O$. For $\xi\in\mathfrak{so}(n)$ the curve $t\mapsto\exp(t\xi)u_1$ lies in $\mathcal O$, so $\langle W^\ast,\xi u_1\rangle=0$, where $\xi u_1$ denotes the infinitesimal action. Define $c=\langle W^\ast,u_1\rangle=\cos\varphi$, $s=\sin\varphi>0$ for $\varphi\in(0,\frac\pi2]$, and $V=(W^\ast-cu_1)/s$. Then $\lVert V\rVert^2=(1-c^2)/s^2=1$, $\langle V,u_1\rangle=0$, and $\langle V,\xi u_1\rangle=(\langle W^\ast,\xi u_1\rangle-c\langle u_1,\xi u_1\rangle)/s=0$, because the action is orthogonal and so $\xi$ acts skew-adjointly, giving $\langle u_1,\xi u_1\rangle=0$. Since $T_{u_1}\mathcal O=\{\xi u_1:\xi\in\mathfrak{so}(n)\}$, $V\perp T_{u_1}\mathcal O$. This is the lemma's step made explicit, and it agrees with the maximising-frame computation recorded above L216.

Transfer of the gap. $O(n)$ acts on $\mathcal W_n$ by orthogonal maps commuting with $Q$: the $W^2$ part is a tensor contraction, and the $\#$ part is built from the bracket of $\Lambda^2\cong\mathfrak{so}(n)$, which conjugation by any $g\in O(n)$, including $\det g=-1$, preserves. Polarising, $g(X\circ Y)=gX\circ gY$, so $L_{gx}=gL_xg^{-1}$ and $P(gx)=P(x)$. Also $T_{gu}\mathcal O=\{\xi gu\}=g\{(g^{-1}\xi g)u\}=gT_u\mathcal O$, since $\mathrm{Ad}_{g^{-1}}$ is onto $\mathfrak{so}(n)$. So $H'\perp u_1,\ H'\perp T_{u_1}\mathcal O$ iff $g^{-1}H'\perp u,\ g^{-1}H'\perp T_u\mathcal O$, and then $\langle L_{e_1}H',H'\rangle=\langle L_eg^{-1}H',g^{-1}H'\rangle\le\frac12-\gamma$. The transfer holds with the same $\gamma$ and $\theta_u$. No gap found.

## 3. The global comparison (3)

$V$ is a unit element of $\mathcal W_n$ and $m=\max_{\lVert X\rVert=1}P(X)$, so $P(V)\le m$ by definition. This is the only use of maximality. Two signs are used and both hold: $3cs^2\theta_u\ge0$ (from $c\ge0$ and $\theta_u>0$) licenses replacing $\alpha$ by $\frac12-\gamma$, and $s^3\ge0$ licenses replacing $P(V)$ by $m$. The algebra $c^3+3cs^2(\frac12-\gamma)=c-cs^2+\frac32cs^2-3\gamma cs^2=c+(\frac12-3\gamma)cs^2$ is correct, and it uses $c^2=1-s^2$.

The need for $c\ge0$ is real. For $c<0$ the coefficient of $\alpha$ is negative and $\alpha$ has no lower bound in the hypothesis, so the inequality would run the wrong way. Within the lemma $c\ge0$ is secured by the hypothesis $\varphi\in[0,\frac\pi2]$, and in both corollaries by $\varphi\le\arcsin\frac12=\frac\pi6$. No sign of $m$ is used anywhere, and the final division is by $1-s^3>0$. No gap found.

## 4. The envelope (4)

The bound $c\le1-\frac{s^2}2$: $(1-\frac{s^2}2)^2=1-s^2+\frac{s^4}4=c^2+\frac{s^4}4\ge c^2$, and both $c$ and $1-\frac{s^2}2$ are nonnegative (the second since $s\le1$), so taking square roots is legitimate. The goal is $c+(\frac12-3\gamma)cs^2+s^3\le1$.

Case $\gamma\le\frac16$. The coefficient $\frac12-3\gamma\ge0$ and $c\le1$ give middle term $\le(\frac12-3\gamma)s^2$. So the bracket is at most $1-\frac{s^2}2+\frac{s^2}2-3\gamma s^2=1-3\gamma s^2$, and $s^3\le3\gamma s^2$ is $s\le3\gamma$ (trivially true at $s=0$). Here $\min(3\gamma,\frac12)=3\gamma$, and $s\le\frac12$ follows, which step (5) needs.

Case $\gamma>\frac16$. The coefficient is negative and $cs^2\ge0$, so the middle term is at most $0$, the bracket at most $1-\frac{s^2}2$, and $s^3\le\frac{s^2}2$ is $s\le\frac12$. Here $\min(3\gamma,\frac12)=\frac12$.

So the hypothesis used is exactly $s\le\min(3\gamma,\frac12)$, which is the conjunction $s\le3\gamma$ and $s\le\frac12$ carried by the Lean hypotheses hs and hshalf. The Lean block in the brief is identical, line for line after removing docstrings, to [L217.lean](../lean/HamiltonsCubic/Results/L217.lean), which contains no sorry, admit or axiom. Run here with `lake env lean` from the lean folder, it compiles with exit $0$ and two linter warnings only, hs0 and hγ0 unused in envelope_le_one, which is correct since $0\le s\le3\gamma$ already forces $\gamma\ge0$.

A remark the record may want, derived by hand. For small $\gamma$, $c=1-\frac{s^2}2+O(s^4)$ gives bracket $+\,s^3-1=s^2(s-3\gamma)+O(s^4)$. So the exact envelope threshold is $s=3\gamma+O(\gamma^2)$, and $3\gamma$ is the method's true radius to leading order rather than a lossy bound. The loss appears only at $\gamma$ near $\frac16$, which is corollary (c).

## 5. Corollary (a)

Gap. At $p=q=k$, $n=2k$: $\frac1{2(k-1)}=\frac1{n-2}$, and $\mu=\frac{n-2}{2(k-1)^2}=\frac{2(k-1)}{2(k-1)^2}=\frac2{n-2}$, so $\frac12-\mu=\frac{n-6}{2(n-2)}$. This is $\ge\frac1{n-2}$ iff $n\ge8$, with equality at $n=8$. So $\gamma_{k,k}=\frac1{n-2}$ for every even $n\ge8$, and in particular at $n\ge12$.

Hypotheses of Given 1. $k\ge6\ge3$ and $(k,k)\ne(3,3)$. The sign convention ("the unit Weyl tensor" is fixed up to sign, and $P(-u)=-P(u)$) must select $P(u)>0$, which L216's corollary already presupposes, so this is a reading and not a defect.

Lower bound. At even $n$, conventions set $\Theta_n=\theta_0(n)$, the value at the balanced product. Given 3 gives a unit $W_{S_{k,k}}$ with $P=\theta_0(n)$, so $\theta_0(n)\le m$. Combined with the lemma, $m\le\theta_u=\theta_0(n)$, hence $\sup P=\theta_0(n)$. As item 9 notes, the lower bound is also just $m\ge P(u)$ for this same $u$.

Radius. $3\gamma=\frac3{n-2}\le\frac12$ iff $n\ge8$, so $\min(3\gamma,\frac12)=\frac3{n-2}$ and at $n=12$ the angle is $\arcsin\frac3{10}=0.304693$, which rounds to $0.3047$. The restriction $n\ge12$ is harmless. At $n=8,10$ the conditional is vacuously true, because $m\ge\sqrt{3/2}>\theta_0(n)$ there (padded $\mathbb{CP}^2$), so no maximiser lies in that tube at all.

## 6. Corollary (b)

The exclusion. Suppose a global maximiser lies within $\arcsin\min(3\gamma_{p,q},\frac12)\le\frac\pi6$ of the orbit of $u=W_{S^p\times S^q}$. Then $\varphi\in[0,\frac\pi2]$ and $\sin\varphi\le\min(3\gamma_{p,q},\frac12)$, $u$ is critical with $\theta_{p,q}>0$ by Given 3's $W^2+W^\#=\theta W$, and the gap holds by Given 1 with $\gamma_{p,q}>0$. The lemma gives $m\le\theta_{p,q}<\Theta_n\le m$, where the last inequality is Given 3 at $n=p+q$. That is a contradiction, so the argument is valid.

Hypotheses. Every product the italic body names has $p,q\ge3$ and $(p,q)\ne(3,3)$, which are exactly Given 1's. Note that $(3,3)$ is balanced at $n=6$, so it is not sub-maximal and the exclusion costs nothing.

The defect is in the bold heading "Every sub-maximal sphere product". Given 3 supplies $W_{S_{k,l}}$ for every split, and $S^2\times S^{n-2}$ is an Einstein product with nonzero Weyl tensor and $\theta_{2,n-2}<\Theta_n$, yet it lies outside $p,q\ge3$ and outside Given 1's corollary, so (b) says nothing about it. Correction: retitle "(b) Every sub-maximal sphere product with both factors of dimension at least three."

## 7. Corollary (c)

Normalisation. L20 and L21 write $\alpha=\sqrt{2/3}\langle F_uV,V\rangle$ with $F_u(h)=\frac12(uh+hu)+u\#h$. L134's proof records $F_u=u\circ(\cdot)=\theta^\ast L_e$ with $\theta^\ast=\sqrt{3/2}$, so $\alpha=\sqrt{2/3}\sqrt{3/2}\langle L_eV,V\rangle=\langle L_eV,V\rangle$. The two $\alpha$'s coincide, the domain $u^\perp\cap T_u\mathcal O^\perp$ is the lemma's, and $\alpha\le\frac13=\frac12-\frac16$ gives $\gamma=\frac16$. Likewise L20's $m=\sqrt{2/3}\max P$ and $\gamma_V=\sqrt{2/3}P(V)$ make its "$\gamma_V\le m$" identical to L217's $P(V)\le m$ (a letter clash with L217's gap $\gamma$ worth a footnote).

Numbers. At $\gamma=\frac16$, $\min(3\gamma,\frac12)=\frac12$ and $\arcsin\frac12=\frac\pi6=0.523599<0.5748$. At $\gamma=\frac16$ the lemma's inequality reads $m\le\theta^\ast c/(1-s^3)$, which is L20's $\psi$ exactly. L20 solves $\psi\le1$ to $s\le s^\ast$, $s^\ast\approx0.5437$, while step (4) bounds $c\le1-\frac{s^2}2$ and reaches only $s\le\frac12$. "Weaker, which solves the envelope exactly rather than bounding it" is accurate.

Two omissions make this PLAUSIBLE rather than CONFIRMED.

- **L21's debt.** L21 itself records "WHAT IS OWED: THE FOUR $F_\lambda$ HAVE $m$-FREE ENTRIES AT THREE DIMENSIONS AND NO ARGUMENT ANYWHERE", with exact in-range evidence at $n=10$ only. L20 calls $\alpha\le\frac13$ "the lemma's one unproved input", and L216's own remark says the padded $\mathbb{CP}^2$ corollary "is CONDITIONAL on L21's one unproved input … which is I54". L217(c) states "Its gap $\gamma=\frac16$ is L21's $\alpha\le\frac13$" with no condition. Correction: append "conditional, as in L216, on L21's owed $m$-freeness of the four blocks $F_\lambda$ (I54)."
- **The dimension.** "(b)'s device" needs $\theta^\ast<\Theta_n$. By L20's own computation, $\Theta_n^2>\frac32$ holds from $n=12$ at even $n$ and from $n=13$ at odd $n$, and fails at $n=11$, where $\Theta_{11}^2=\frac{40}{27}<\frac32$. Correction: state $n\ge12$ in (c).

Being "for comparison only", (c) carries no downstream weight, so neither omission propagates.

## 8. How it sits against the record

The factor is wrong by $3$. Given 1's radius is $r=\frac{4\theta_u\gamma}{9M}=\frac{12\theta_u\gamma}{27M}$ with $M=1+\sqrt{n-2}$. In the regime $3\gamma\le\frac12$, L217's radius is $\arcsin3\gamma\ge3\gamma$, so the gain is at least $\frac{3\gamma}r=\frac{27M}{4\theta_u}$. The record's $\frac{27M}{12\theta_u}$ equals $\frac\gamma r$: it compares $r$ with $\gamma$ rather than with $3\gamma$.

The record's own numbers witness this. Corollary (a) quotes $0.3047$ against $0.0132$ at $n=12$, a ratio of $23.09$. With $\theta_0(12)=\frac{\sqrt{55}}6$ and $M=1+\sqrt{10}$, $\frac{27M}{4\theta_0}=22.73$, which is $\frac{3\gamma}r$, while the stated $\frac{27M}{12\theta_0}=7.58$. This is the minimal computation, and an argument alone would not settle which of the two printed quantities is the misprint, so it is included.

Correction: "gains a factor of at least $27(1+\sqrt{n-2})/(4\theta_u)$ in the radius while $3\gamma\le\frac12$". When $3\gamma>\frac12$ the gain is $\frac{\pi/6}r=\frac{9\pi M}{8\theta_u\gamma}$ instead.

The L147 agreement is exact, not merely of scale. L147's hypotheses box records "The $\Theta(n^{-1})$ ceiling is proved, by $c_p/S\le c_p/\theta_0=3/(n-2)$", so $c_p=\frac{3\theta_0}{n-2}=3\theta_0\gamma$. That is half of L216's second-variation margin $6\theta_0\gamma$. L217 at the balanced orbit gives $\sin\varphi\le3\gamma=\frac3{n-2}=\frac{c_p}{\theta_0}$, the same number. The brief's "$c_p/\theta_0\le3/(n-2)$" is true with equality. "The maximiser's value is what that branch lacked" is a fair reading: the branch divides by $S=\sup\lvert P\rvert\ge\theta_0$, and the bootstrap replaces the unknown $S$ by $m$, which cancels against the $s^3m$ term. The comparison is between different functionals ($\Phi$ against $P$), which the text says. CONFIRMED on this half.

## 9. Scope

The statement speaks of global maximisers, and the proof uses maximality once, in $P(V)\le m$. Criticality of $W^\ast$ appears nowhere, and neither does L143, Bernstein or a frame. "What is used" is accurate. The argument does not extend to local maximisers or to critical points, because $V$ is far from $W^\ast$ and $P(V)\le P(W^\ast)$ is a global statement. That is the trade against L216 the text describes.

A sharpening the record should state. $u$ is itself a unit vector, so $m\ge P(u)=\theta_u$ always. The lemma's conclusion is therefore $m=\theta_u$: any global maximiser inside the tube forces $u$'s orbit to be a global-maximum orbit. Corollary (a) is this statement at the balanced orbit, and (b) is its contrapositive. The Lean theorem balanced_value_eq assumes hlow separately, which is harmless.

"What it does not give" is correct. The first sentence, that a maximiser outside every tube is untouched, is immediate. The second, that the tubes about the rigid orbits do not cover the sphere, is asserted without argument but is true. The rigid orbits are finitely many, of dimension at most $\dim O(n)=\frac{n(n-1)}2$ ($66$ at $n=12$), inside a sphere of dimension $\dim\mathcal W_n-1$ ($1637$ at $n=12$). A tube of angular radius at most $\frac\pi6$ about a compact $d$-dimensional submanifold of $S^{N-1}$ has volume fraction at most a constant depending on the submanifold times $(\sin\frac\pi6)^{N-1-d}$, up to polynomial factors, which is far below $1$ once $N-d$ is large. A sentence to that effect would close it. The localisation named as I100's target is the right residual.

## 10. The boundary

- **$\varphi=0$.** $W^\ast\in\mathcal O$, $V$ undefined, and $m=P(W^\ast)=\theta_u$ by invariance. Step (1) treats it separately, correctly.
- **$\gamma=0$.** $\sin\varphi\le0$ with $\varphi\in[0,\frac\pi2]$ forces $\varphi=0$, reducing to the case above. Unlike L216, which needs $\gamma>0$, L217 allows $\gamma\ge0$ with no harm.
- **$\gamma=\frac16$.** $3\gamma=\frac12$ and the middle coefficient $\frac12-3\gamma$ is $0$. Case 1 applies and gives bracket $\le1-\frac{s^2}2$, the same as case 2, so the split is continuous.
- **$s=\frac12$.** $1-s^3=\frac78>0$, and $s^3\le\frac{s^2}2$ holds with equality. The bracket is at most $1-\frac18=1-s^3$ with at worst equality, and the conclusion $m\le\theta_u$ survives.
- **Non-unique nearest point.** Step (1) takes any minimiser. Existence, orthogonality and gap transfer hold at each, so nothing depends on uniqueness.
- **$\ker u\ne0$.** No step uses invertibility of $u$ as an operator on $\Lambda^2$. A kernel enlarges the stabiliser and shrinks $T_u\mathcal O$, which enlarges the set on which the gap must hold. That is a matter for the input $\gamma$ (for padded $\mathbb{CP}^2$ with $\dim\ker u=3$, item 7's I54), and it is where L147 needed $\ker W^\ast=0$ and L217 does not.

## Overall verdict

- **Lemma L217: CONFIRMED.** Every step of the written chain follows from the stated hypotheses. The two inputs the kernel does not see, the exact expansion and $V\perp T_{u_1}\mathcal O$ with gap transfer, were re-derived from the definitions without a gap. The conclusion can be strengthened to $m=\theta_u$.
- **Corollary (a): CONFIRMED** as a conditional, with $\gamma=\frac1{n-2}$ minimal from $n\ge8$ and the angle $0.3047$ correct.
- **Corollary (b): CONFIRMED** in its body. Its heading needs "$p,q\ge3$".
- **Corollary (c): PLAUSIBLE.** Correct given L21's upper bound, but it must state that bound's I54 condition and $n\ge12$.
- **"How it sits against the record": REFUTED in the factor.** Replace $27(1+\sqrt{n-2})/(12\theta_u)$ by $27(1+\sqrt{n-2})/(4\theta_u)$. The L147 agreement is exact and stands.

Other files staged or modified in the working tree and left untouched by this review: [findings/INDEX-results.md](../findings/INDEX-results.md), [findings/second-order.md](../findings/second-order.md), [lean/HamiltonsCubic/Results/L217.lean](../lean/HamiltonsCubic/Results/L217.lean), [lean/INDEX.md](../lean/INDEX.md), [plan.md](../plan.md), [results.md](../results.md), [reviews/BRIEF_L217.md](BRIEF_L217.md).
