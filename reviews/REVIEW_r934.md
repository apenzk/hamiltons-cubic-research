# Reviewer 934: Lemma L217, the value bootstrap at a gapped critical orbit

Log: [agent_logs/review-r934.log](../agent_logs/review-r934.log)

| # | Claim | Verdict | Reason |
|---|---|---|---|
| 1 | Expansion in step (2) | CONFIRMED | $X\circ X=Q(X)$ makes $P=T(X,X,X)$, the binomial coefficients follow from total symmetry, and $Q(u_1)=\theta_uu_1$ with $V\perp u_1$ kills the linear term |
| 2 | First-variation step (1) | CONFIRMED | compact orbit, $\arccos$ differentiable on $(0,\pi)$, and $O(n)$ acts by isometries commuting with $Q$, so the gap transfers with the same $\gamma$ |
| 3 | Global comparison (3) | CONFIRMED | $V$ is a unit Weyl tensor, $s^3\ge0$, and $c\ge0$ is genuinely needed because $\alpha$ can be very negative |
| 4 | Envelope (4) | CONFIRMED | $c\le1-s^2/2$ is exact algebra, and each case uses exactly the binding half of $\min(3\gamma,\tfrac12)$ |
| 5 | Corollary (a) | CONFIRMED | $\gamma=1/(n-2)$ is the minimum from $n\ge8$, the hypotheses of L27 hold, $\arcsin0.3=0.30469$, and the citation of L0 is redundant since $m\ge P(u)$ trivially |
| 6 | Corollary (b) | CONFIRMED | the exclusion is valid on its stated hypotheses, and the bold label "every sub-maximal sphere product" is broader than the italic range, which omits $p\le2$ and $(3,3)$ |
| 7 | Corollary (c) | PLAUSIBLE | normalisation $\alpha=\langle L_eV,V\rangle$ and $\pi/6<0.5748$ check, but it drops L21's open debt and the range $n\ge12$, and "gives $\varphi\le\tfrac\pi6$" states the exclusion backwards |
| 8 | How it sits against the record | REFUTED | the radius factor over L216 is $27(1+\sqrt{n-2})/(4\theta_u)$, three times the stated $27(1+\sqrt{n-2})/(12\theta_u)$, and L147's cap is misquoted as $c_p/\theta_0\le3/(n-2)$ |
| 9 | Scope | CONFIRMED | only $P(V)\le m$ uses maximality and no step uses criticality of $W^\ast$, with the note that the conclusion is equivalent to $u$ being a global maximiser |
| 10 | Boundary cases | CONFIRMED | $\varphi=0$, $\gamma=0$, $\gamma=\tfrac16$, $s=\tfrac12$, non-unique nearest points and $\ker u\ne0$ all pass, the last because no step inverts $u$ |

**Summary: the lemma and corollaries (a) and (b) stand as written, and the cycle should correct the comparison factor against L216 to $27(1+\sqrt{n-2})/(4\theta_u)$, requote L147's cap as $c_p/S\le c_p/\theta_0=3/(n-2)$, and give (c) its range $n\ge12$, L21's debt and the direction of its exclusion.**

## 1. The expansion in step (2)

The $\circ$ product is $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$. Since $Q$ is homogeneous quadratic, $X\circ X=\tfrac12(Q(2X)-2Q(X))=\tfrac12(4Q(X)-2Q(X))=Q(X)$. So $T(X,X,X)=\langle Q(X),X\rangle=P(X)$ under the convention $P(X)=\langle X,Q(X)\rangle$.

$T$ is trilinear and fully symmetric (Given 2). Expanding $T(cu_1+sV,cu_1+sV,cu_1+sV)$ into eight terms and collecting by symmetry gives $c^3T(u_1,u_1,u_1)+3c^2sT(u_1,u_1,V)+3cs^2T(u_1,V,V)+s^3T(V,V,V)$, which is the displayed $1,3,3,1$ expansion. No truncation occurs because $P$ is exactly cubic.

The linear term. By symmetry $DP_{u_1}[H]=3T(u_1,u_1,H)=3\langle Q(u_1),H\rangle$, so the ambient gradient is $3Q(u_1)$ (using that $Q$ maps $\mathcal W_n$ to itself, [README.md](../README.md)). Criticality on the sphere makes $3Q(u_1)$ a multiple of $u_1$, and pairing with $u_1$ fixes the multiple, $\langle Q(u_1),u_1\rangle=P(u_1)=\theta_u$, so $Q(u_1)=\theta_uu_1$. Then $T(u_1,u_1,V)=\theta_u\langle u_1,V\rangle=0$. This uses criticality and $V\perp u_1$, both of which the proof has, and nothing else.

The quadratic term. $T(u_1,V,V)=\langle u_1\circ V,V\rangle=\langle L_{u_1}V,V\rangle$ with $L_x=x\circ(\cdot)$, and $L$ is linear in its subscript because $\circ$ is bilinear, so $L_{u_1}=\theta_uL_{e_1}$ with $e_1=u_1/\theta_u$. The identification $\alpha=\langle L_{e_1}V,V\rangle\le\tfrac12-\gamma$ then needs $V$ unit, $V\perp u_1$ and $V\perp T_{u_1}\mathcal O$, which item 2 supplies. **CONFIRMED.**

## 2. The first-variation step (1)

Existence. $\mathcal O=O(n)\cdot u$ is the image of a compact group under a continuous map, hence compact, and $x\mapsto d(W^\ast,x)$ is continuous, so the minimum $\varphi$ is attained at some $u_1=g\cdot u$. $\mathcal O$ is an embedded submanifold, being an orbit of a compact Lie group acting smoothly. It may have two components, one per coset of $SO(n)$, which changes nothing.

The velocity. For $0<\varphi<\pi$ the minimising great circle from $u_1$ to $W^\ast$ is unique, and $V=(W^\ast-\cos\varphi\,u_1)/\sin\varphi$ is a unit vector with $V\perp u_1$, giving $W^\ast=cu_1+sV$ exactly. For a curve $x(t)\subset\mathcal O$ with $x(0)=u_1$ and $x'(0)=\xi\in T_{u_1}\mathcal O$, $d(W^\ast,x(t))=\arccos\langle W^\ast,x(t)\rangle$ is differentiable at $t=0$ because $\langle W^\ast,u_1\rangle=\cos\varphi\in(-1,1)$, with derivative $-\langle W^\ast,\xi\rangle/\sin\varphi$. Minimality forces this to vanish. Since $\xi\perp u_1$ (the orbit lies in the sphere), $\langle W^\ast,\xi\rangle=s\langle V,\xi\rangle$, so $V\perp\xi$ for every $\xi$, which is $V\perp T_{u_1}\mathcal O$. The statement restricts to $\varphi\le\tfrac\pi2$, inside the differentiable range.

The transfer. $O(n)$ acts on $\mathcal W_n$ by isometries, and $Q$ is $O(n)$-equivariant: $W^2$ is conjugation-equivariant, and $W^\#$ is built from the structure constants of $\mathfrak{so}(n)$, which every $g\in O(n)$ preserves because $\mathrm{Ad}(g)$ is a Lie algebra automorphism for either sign of $\det g$. So $\circ$ is equivariant, $P(g\cdot X)=P(X)$, $L_{g\cdot x}=gL_xg^{-1}$, $u_1$ is critical with $P(u_1)=\theta_u$, and $T_{u_1}\mathcal O=g\,T_u\mathcal O$, $u_1^\perp=g\,u^\perp$. For unit $H\perp u_1$, $H\perp T_{u_1}\mathcal O$, the vector $g^{-1}H$ is unit and orthogonal to $u$ and $T_u\mathcal O$, and $\langle L_{e_1}H,H\rangle=\langle L_eg^{-1}H,g^{-1}H\rangle\le\tfrac12-\gamma$. The gap transfers with the same $\gamma$. **CONFIRMED.**

## 3. The global comparison (3)

$V$ is a combination of $W^\ast$ and $u_1$, both in $\mathcal W_n$, and has unit norm, so it lies on the unit sphere and $P(V)\le\max P=m$. The multiplier of $P(V)$ is $s^3\ge0$, so $s^3P(V)\le s^3m$.

The coefficient of $\alpha$ is $3cs^2\theta_u$, nonnegative because $c\ge0$ and $\theta_u>0$, so $\alpha\le\tfrac12-\gamma$ may be substituted upward. **The hypothesis $c\ge0$ is load-bearing**: for $\varphi\in(\tfrac\pi2,\pi)$ the coefficient is negative, and $\alpha$ has no lower bound supplied (at the sphere products it reaches $-\mu$ on $S^2_0\otimes S^2_0$, and in general any negative value the spectrum carries), so the substitution would run the wrong way. The statement's restriction $\varphi\in[0,\tfrac\pi2]$ is what makes it valid, and it is not implied by $\sin\varphi\le\tfrac12$ alone, which also admits $\varphi\ge\tfrac{5\pi}6$. The statement carries both conditions, so there is no gap.

The algebra. $c^3+3cs^2(\tfrac12-\gamma)=c-cs^2+\tfrac32cs^2-3\gamma cs^2=c+(\tfrac12-3\gamma)cs^2$, using $c^2=1-s^2$. Moving $s^3m$ left gives the display. **CONFIRMED.**

## 4. The envelope (4)

$c\le1-\tfrac{s^2}2$: $(1-\tfrac{s^2}2)^2=1-s^2+\tfrac{s^4}4=c^2+\tfrac{s^4}4\ge c^2$, and both $c$ and $1-\tfrac{s^2}2\ge\tfrac12$ are nonnegative, so the square roots compare.

Case $\gamma\le\tfrac16$. The coefficient $\tfrac12-3\gamma\ge0$ and $c\le1$ give $(\tfrac12-3\gamma)cs^2\le(\tfrac12-3\gamma)s^2$. Adding $c\le1-\tfrac{s^2}2$ gives bracket $\le1-3\gamma s^2$. Then $1-3\gamma s^2\le1-s^3$ is $s^2(3\gamma-s)\ge0$, which is $s\le3\gamma$. In this case $3\gamma\le\tfrac12$, so $\min(3\gamma,\tfrac12)=3\gamma$ is the half used.

Case $\gamma>\tfrac16$. The coefficient is negative and $cs^2\ge0$, so the middle term is at most $0$ and bracket $\le c\le1-\tfrac{s^2}2$. Then $1-\tfrac{s^2}2\le1-s^3$ is $s^2(\tfrac12-s)\ge0$, which is $s\le\tfrac12$. Here $3\gamma>\tfrac12$, so $\min=\tfrac12$ is the half used.

So $s\le\min(3\gamma,\tfrac12)$ is exactly the hypothesis consumed, each case taking its binding branch, and step (5) uses $s\le\tfrac12$ once more for $1-s^3\ge\tfrac78>0$. The Lean statement [envelope_le_one](../lean/HamiltonsCubic/Results/L217.lean) is the same inequality with $s^3$ moved left, and its hypotheses ($s,c,\gamma\ge0$, $c^2=1-s^2$, $s\le3\gamma$, $s\le\tfrac12$) are the ones the prose uses. The envelope is lossy (case 1 discards $1-c$ on the middle term and $c\le1-\tfrac{s^2}2$ is not tight), which item 7 quantifies at $\gamma=\tfrac16$. **CONFIRMED.**

## 5. Corollary (a)

The gap. At $p=q=k=n/2$: $\frac1{2(p-1)}=\frac1{2(q-1)}=\frac1{n-2}$, and $\mu=\frac{n-2}{2(k-1)^2}=\frac{n-2}{2(n-2)^2/4}=\frac2{n-2}$, so $\tfrac12-\mu=\frac{n-6}{2(n-2)}$. Then $\tfrac12-\mu\ge\frac1{n-2}$ is $n-6\ge2$, which is $n\ge8$, with a tie at $n=8$. So $\gamma=1/(n-2)$ at every even $n\ge8$, in particular at $n\ge12$.

Given 1's hypotheses. $n\ge12$ gives $k\ge6$, so $p,q\ge3$ and $(p,q)\ne(3,3)$. The formula for $\gamma_{p,q}$ is the Rayleigh maximum over the complement of $\langle W\rangle\oplus T_W\mathcal O$, and that is the largest eigenvalue there because L27 makes the $\tfrac12$-eigenspace exactly the orbit tangent, so the complement is $L_e$-invariant. The ten values are $1,\tfrac12,\lambda_p,\lambda_q,\pm\mu,0^{\times4}$, and $\tfrac12-\lambda_m=\frac1{2(m-1)}$, so the minimum is the stated one (the zero summands and $-\mu$ never bind). $\theta_u=\theta_0(n)>0$ and $u$ is critical by Given 3's $W^2+W^\#=\theta W$.

The lower bound. Given 3 gives $\sup P\ge\Theta_n$, and $\Theta_n=\theta_0(n)$ at even $n$. **The citation is correct but unnecessary**: $u$ is itself a unit Weyl tensor with $P(u)=\theta_0(n)$, so $m\ge\theta_u$ holds by definition of the maximum. With L217's $m\le\theta_u$ this gives $\sup P=\theta_0(n)$.

The range. $3\gamma=\frac3{n-2}\le\tfrac12$ is $n\ge8$, so $\arcsin\frac3{n-2}$ is the correct angle and $\sin\varphi\le\min(3\gamma,\tfrac12)$ holds. At $n=12$, $\arcsin0.3=0.3046927$, which rounds to the stated $0.3047$. The restriction $n\ge12$ is stronger than the argument needs (it runs at $n=8,10$ too, where it becomes an exclusion since padded $\mathbb{CP}^2$ exceeds $\theta_0$), which is harmless. **CONFIRMED.**

## 6. Corollary (b)

The exclusion. If a global maximiser lay within the stated angle, L217 would give $m\le\theta_{p,q}$, and Given 3 gives $\Theta_n\le m$, contradicting $\theta_{p,q}<\Theta_n$. Valid.

Hypotheses. Every product in the italic statement has $p,q\ge3$, $(p,q)\ne(3,3)$, which is L27's and L216's range, so $\gamma_{p,q}$ is a valid gap. $\theta_{p,q}>0$ and criticality come from Given 3. At $(3,4)$, $\mu=\tfrac5{12}$ binds and $\gamma=\tfrac1{12}$, which the $\min$ formula carries correctly. $\gamma_{p,q}>0$ throughout this range, though L217 would accept $\gamma=0$.

The label. The bold words "every sub-maximal sphere product" read wider than the italic range. $S^2\times S^{n-2}$ is excluded ($p=2$, where L27's decomposition is false) and so is $S^3\times S^3$ (degenerate, $\gamma=0$). These are exactly the products whose gap is unavailable, so the italic clause is right and only the label overreaches. Also, by item 9, the comparison with $\Theta_n$ could be any $\theta_{p,q}<\max P$, which covers the balanced product at $n\le11$ as well. **CONFIRMED**, with the label to be narrowed to the italic range.

## 7. Corollary (c)

Normalisation. Given 4 defines $\alpha=\sqrt{2/3}\,\langle F_uV,V\rangle$ with $F_u(h)=\tfrac12(uh+hu)+u\#h$. Polarising $Q=X^2+X^\#$ gives $F_u=u\circ(\cdot)=\theta^\ast L_e$ with $\theta^\ast=\sqrt{3/2}$ ([L134](../findings/route-a.md)'s proof of (a) records the same identification). So L20's $\alpha=\sqrt{2/3}\sqrt{3/2}\langle L_eV,V\rangle=\langle L_eV,V\rangle$, and $\alpha\le\tfrac13=\tfrac12-\tfrac16$ is $\gamma=\tfrac16$. Correct.

The radius. At $\gamma=\tfrac16$, $\min(3\gamma,\tfrac12)=\tfrac12$ and $\arcsin\tfrac12=\tfrac\pi6=0.5235988<0.5748$. The explanation is right and can be made exact: at $\gamma=\tfrac16$ the bracket is $c^3+cs^2=c$ with no loss, identical to L20's, and L20 solves $c\le1-s^3$ exactly ($s\le s^\ast$, the root of $s^3+s^2+s=1$), whereas L217 replaces $c$ by $1-\tfrac{s^2}2$, which cuts $s$ to $\tfrac12$.

Three defects, none touching the lemma.

- **L21's debt is dropped.** The gap $\tfrac16$ rests on L21's four $F_\lambda$ spectra being $m$-free, which L21's own box records as owed, and L216 marks its own padded-$\mathbb{CP}^2$ corollary "CONDITIONAL on L21's one unproved input". (c) states $\gamma=\tfrac16$ unconditionally.
- **The range is missing.** L21 needs $n\ge9$, and "(b)'s device" needs $\sqrt{3/2}<\Theta_n$, which L20 places at $n\ge12$. At $n\le11$ padded $\mathbb{CP}^2$ is not sub-maximal and the device yields nothing.
- **The direction is reversed in words.** "(b)'s device gives $\varphi\le\tfrac\pi6$" reads as locating the maximiser within $\tfrac\pi6$. The device excludes that, giving $\varphi>\tfrac\pi6$ for every global maximiser, to be set against L20's $\varphi>0.5748$.

Correction: *"(c) At $n\ge12$ and conditionally on L21's $m$-free spectra, its gap $\gamma=\tfrac16$ makes (b)'s device give $\varphi>\tfrac\pi6$ for every global maximiser, weaker than L20's $\varphi>0.5748$."* **PLAUSIBLE.**

## 8. How it sits against the record

The factor. L216's radius is $r=\frac{4\theta_u\gamma}{9M}$ with $M=1+\sqrt{n-2}$. L217's radius is $\arcsin3\gamma$ in the regime $3\gamma\le\tfrac12$, and $\arcsin3\gamma\ge3\gamma$. So
$$\frac{3\gamma}{r}=\frac{3\gamma\cdot9M}{4\theta_u\gamma}=\frac{27M}{4\theta_u},$$
and $\arcsin3\gamma/r\ge27M/(4\theta_u)$. The record writes $27M/(12\theta_u)$, which is $\gamma/r$, a factor $3$ too small. It likely came from reading L216's $r=\frac{12\theta_u\gamma}{27M}$ against $\gamma$ rather than $3\gamma$.

The record refutes itself. Corollary (a) prints $0.3047$ against $0.0132$ at $n=12$, a ratio of about $23.1$. The corrected factor is $\frac{27(1+\sqrt{10})}{4\theta_0(12)}=\frac{81(1+\sqrt{10})}{\sqrt{220}}\approx22.73$, times $\arcsin(0.3)/0.3=1.0156$, giving $23.09$. The stated factor gives $\frac{27(1+\sqrt{10})}{12\theta_0(12)}=\frac{27(1+\sqrt{10})}{\sqrt{220}}\approx7.58$. This is arithmetic on constants already on the page, needed only to show the two printed numbers disagree with the printed factor. The argument above is the refutation.

Also, "near" holds only while $3\gamma\le\tfrac12$. Above it the L217 radius is pinned at $\tfrac\pi6$ and the factor is $\frac{9\pi M}{24\theta_u\gamma}$, smaller.

Correction: *"gains a factor at least $27(1+\sqrt{n-2})/(4\theta_u)$ in the radius while $3\gamma\le\tfrac12$"*.

L147. L147 reads "$c_p/S\le c_p/\theta_0=3/(n-2)$", with $S=\sup\lvert P\rvert$. L217 quotes this as "$c_p/\theta_0\le3/(n-2)$", which moves the inequality and drops $S$. The quantity that caps the branch is $c_p/S$. Since $P$ is odd, $\sup\lvert P\rvert=\sup P=m$, so "the maximiser's value is what that branch lacked" is exactly right: with $S=m=\theta_0$ the cap $c_p/S$ equals $3/(n-2)=3\gamma$, which is L217's $\sin\varphi$ bound on the nose, not just in scale. The comparison is between a penalised-functional radius and the sine of an angle, so "the scale agrees" is the right strength. It is also worth recording that L217's radius is $\Theta(n^{-1})$, which is the ceiling L147 proves for its route.

Correction: *"whose $P$-side branch caps a penalised-functional radius at $c_p/S\le c_p/\theta_0=3/(n-2)$ with $S=\sup\lvert P\rvert$ unknown"*. **REFUTED** as to the factor, with the L147 comparison sound once requoted.

## 9. Scope

Maximality of $W^\ast$ enters once, as $P(V)\le m$ in step (3). Criticality of $W^\ast$ is never used: step (1) uses only minimality of the distance, step (2) only criticality of $u_1$. The proof has no reference to L143, Bernstein or a frame. The "What is used" list is accurate.

A sharpening the record should carry. $m\ge P(u)=\theta_u$ always holds, so the conclusion $m\le\theta_u$ is equivalent to $m=\theta_u$, which is to say $u$ is itself a global maximiser. Read that way the lemma is: *a global maximiser within $\arcsin\min(3\gamma,\tfrac12)$ of a gapped critical orbit forces that orbit to be a global-maximum orbit*. So (b) holds for every gapped critical orbit with $\theta_u<\max P$, with Given 3 needed only to certify that inequality, and (a) needs no lower bound at all.

"What it does not give". The first sentence is accurate. "The tubes about the rigid orbits do not cover the sphere" is asserted without argument. It is very plausible (finitely many orbits of dimension at most $\max pq$ in a sphere of dimension $\dim\mathcal W_n-1$, tubes of angle at most $\tfrac\pi6$, so a volume comparison fails at every $n$ in range), but no such argument is on the page. "Conjecture A follows from (a) only under the localisation" is fair read as a statement about what (a) delivers. **CONFIRMED.**

## 10. The boundary

- **$\varphi=0$.** $W^\ast\in\mathcal O$, so $m=P(W^\ast)=\theta_u$ by invariance. Covered in step (1), and the Lean `example` checks the expansion degenerates correctly at $s=0$, $c=1$.
- **$\gamma=0$.** $s\le0$ forces $\varphi=0$ inside $[0,\tfrac\pi2]$, and the conclusion is the tautology of the previous line. Correct and content-free. It admits degenerate orbits such as $S^3\times S^3$, harmlessly.
- **$\gamma=\tfrac16$.** Case 1 applies with coefficient $0$, the bracket is $c\le1-\tfrac{s^2}2$, and $s\le\tfrac12=3\gamma$. Both branches of the case split agree here, so there is no seam.
- **$s=\tfrac12$.** $1-s^3=\tfrac78>0$ and case 2's last inequality $1-\tfrac{s^2}2\le1-s^3$ is an equality ($\tfrac78=\tfrac78$), so the chain holds with no slack. The conclusion still follows.
- **Non-unique nearest point.** Every minimiser $u_1$ supplies its own $V$ with both orthogonalities, and the argument needs only one. Uniqueness of the minimising great circle for a fixed $u_1$ holds on $(0,\pi)$.
- **$\ker u\ne0$.** No step inverts $u$ or uses a spectral gap of $u$ as an operator on $\Lambda^2$. Padded $\mathbb{CP}^2$ has $\dim\ker u=3$ and is covered, in contrast to L147, whose branches do not exist there.
- **$\theta_u>0$.** Needed in step (3) and step (5). $-u$ is critical with value $-\theta_u$ and is excluded by the statement.

**CONFIRMED.**

## Overall verdict

- **Lemma L217: CONFIRMED.** Every step follows from the stated hypotheses, and the Lean file settles the real-variable part with hypotheses matching the prose.
- **Corollary (a): CONFIRMED.** The citation of L0's lower half may be replaced by $m\ge P(u)$.
- **Corollary (b): CONFIRMED.** The bold label should be narrowed to the italic range $p,q\ge3$, $(p,q)\ne(3,3)$.
- **Corollary (c): PLAUSIBLE.** It needs $n\ge12$, L21's conditionality, and the exclusion stated as $\varphi>\tfrac\pi6$.
- **"How it sits against the record": REFUTED** in the factor, which is $27(1+\sqrt{n-2})/(4\theta_u)$, and the L147 cap is to be requoted as $c_p/S\le c_p/\theta_0=3/(n-2)$.

Files staged or modified by other sessions at the time of review, left untouched: findings/INDEX-results.md, findings/second-order.md, lean/HamiltonsCubic/Results/L217.lean, lean/INDEX.md, plan.md, results.md, reviews/BRIEF_L217.md, reviews/REVIEW_r933.md.
