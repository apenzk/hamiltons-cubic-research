# Brief, round L100

**Cold brief. Every passage below is quoted verbatim from the record, with its source lines. No prior verdict on this result is included.**

## Passage A, the heading and the statement as the block carries it ([findings/route-a.md](../findings/route-a.md) lines 55 and 69)

#### Lemma L100, the $8\le n\le11$ dichotomy, either $\max P\le\sqrt{3/2}$, or every maximizer sits farther than $0.5748$ from the $\mathbb{CP}^2$ orbit

**A bonus at $9\le n\le11$.** The same machinery, [Lemma L20](route-a.md)'s proof, below, yields, **wherever $\alpha\le\tfrac13$ holds**, a dichotomy below the crossover: either $\max P\le\sqrt{3/2}$, or every maximizer sits farther than $0.5748$ in geodesic angular distance from the $\mathbb{CP}^2$ orbit. *The derivation holds at every $n\ge9$; the crossover is only where the first horn stops surviving.*

## Passage B, the machinery it names, Lemma L20's setting and proof, a given ([findings/route-a.md](../findings/route-a.md) lines 109 and 127-141)

#### Lemma L20, no maximizer lies near the rival maximizer's orbit, for every $n\ge12$

Write $\theta^*=\sqrt{3/2}=P(W_{\mathbb{CP}^2})$ and $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ as fixed in [conventions.md](conventions.md), so that $\theta_0(n)>\theta^*$ exactly when $n>6+2\sqrt7$.

**$d$ is geodesic angular distance on the unit sphere of $\mathrm{Weyl}_n$**, $\cos d(X,Y)=\langle X,Y\rangle$, the expansion below commits the proof to it, and **the radius depends on the choice**: read as a chord, $0.5748$ is the angle $0.5830224$, where $\psi=1.0020125>1$ and the argument reaches no contradiction. *This is the one input the statement cannot be read without, and it is now in [conventions.md](conventions.md).*

*Proof.* The unit sphere of $\mathrm{Weyl}_n$ is compact, so $m:=\sqrt{2/3}\max P$ is attained, at some $W^*$. **Three further hypotheses are used and are stated here rather than assumed**: that $d$ is $SO(n)$-invariant, that the orbit is a compact embedded submanifold so a nearest point exists and its first-variation condition holds, and that $\varphi>0$ for that condition to be non-vacuous, the degenerate branch is treated separately below. Suppose $\varphi:=d(W^*,SO(n).W_{\mathbb{CP}^2})\le0.5748$. Since $P$ is invariant under the conjugation action of $SO(n)$ on $\Lambda^2(\mathbb{R}^n)$, rotate so that the nearest orbit point is $u=W_{\mathbb{CP}^2}$ itself, and write $W^*=\cos\varphi\,u+\sin\varphi\,V$. The vector $V$ is a unit vector orthogonal to $u$, and orthogonal also to $T_u(SO(n).u)$ by the first-variation condition for a nearest point on the orbit. Since $P$ is a cubic form with polarization $T$, and $Q(u)=\theta^*u$ makes $T(u,u,V)=\theta^*\langle u,V\rangle=0$, the expansion is exact and has no linear term:

$$m=\cos^3\varphi+3\cos\varphi\sin^2\varphi\,\alpha+\sin^3\varphi\,\gamma_V,\qquad \alpha=\sqrt{\tfrac23}\langle F_uV,V\rangle,\quad \gamma_V=\sqrt{\tfrac23}P(V),$$

where $F_u(h)=\tfrac12(uh+hu)+u\# h$. The largest eigenvalue of $F_u$ on $u^\perp\cap T_u(SO(n).u)^\perp$ is $\tfrac13\theta^*$, so $\alpha\le1/3$. **This is the lemma's one unproved input, and the citation given for it does not carry it.** [Nienhaus](../references/nienhaus-2023-second-best-einstein/notes.md) Theorem 4.14(c) states *one* eigenvalue on *one* subspace; that it is the largest on $u^\perp\cap T_u\mathcal O^\perp$ needs 4.14(a) and (d)–(g) to be exhaustive **and** Remark 4.16, which identifies the $\tfrac12\theta^*$-eigenspace with $T_u\mathcal O$ and so removes the larger eigenvalue, neither cited here. **Without the first-variation step the bound would be $\alpha\le\tfrac12$, at which the interval is empty and the theorem is vacuous**, so this input is load-bearing rather than a convenience. *And 4.14's own proof runs through a Schur step whose multiplicity-free hypothesis this record's own [Lemma L21](#lemma-l21-the-eigenvalue-bound-alphaletfrac13-structural-at-every-nge9) says fails here.* **What would discharge the debt**: that the four rational $F_\lambda$ matrices have the tabulated spectra, by rank certificates over $\mathbb Q$, and that their entries do not depend on $m=n-4$. And $\gamma_V\le m$ because $V$ is itself a unit Weyl operator and $m$ is the maximum over all of them. Substituting both and using $\cos^3\varphi+\cos\varphi\sin^2\varphi=\cos\varphi$,

$$m\le\cos\varphi+m\sin^3\varphi,\qquad\text{i.e.}\qquad m\le\psi(\varphi):=\frac{\cos\varphi}{1-\sin^3\varphi}.$$

On $[0,0.5748]$ one has $\psi\le\psi(0)=1$. **The reduction is exact**: $\psi\le1\iff\sin\varphi\le s^*$ with $s^*$ the real root of $s^3+s^2+s=1$, and $s^*\in(0.5436,0.5437)$ against $\sin(0.5748)=0.5436669$. The minimum is $0.9785933$, at $\sin\varphi=\tfrac{\sqrt3-1}2$, i.e. $\varphi=0.3747372$. $\psi$ rises again and first exceeds $1$ at $\varphi=0.5748263$, so **the stated radius is the true crossing truncated in the safe direction** and $\psi(0.5748)=0.9999937$. Hence $m\le1$, i.e. $\max P\le\sqrt{3/2}$. **The contradiction needs a unit Weyl operator with $P>\sqrt{3/2}$, and at odd $n$ the balanced sphere product is not one, it does not exist.** The witness is the best split: $\Theta_n^2=\frac{2(n-1)(n-3)}{(n-2)(n+1)}$ at odd $n$, exceeding $\tfrac32$ exactly when $n^2-13n+18>0$, so from $n=13$; at even $n$ it is $\theta_0(n)$, exceeding $\tfrac32$ when $n^2-12n+8>0$, so from $n=12$. **The two parities carry different polynomials and both clear from $n\ge12$.** Therefore $\varphi>0.5748$. $\square$

The degenerate branch $\varphi=0$ is covered: there $W^*$ lies on the orbit, $\max P=\sqrt{3/2}$, and the same contradiction applies. Note that the contradiction is with the *value*, not the location, nothing is assumed about where the sphere product sits, and that it too lies outside the tube follows afterwards.

## Passage C, Lemma L21, a given ([findings/route-a.md](../findings/route-a.md) lines 178, 180 and 196)

#### Lemma L21, the eigenvalue bound $\alpha\le\tfrac13$, structural at every $n\ge9$

**Statement.** Let $n\ge9$, $m=n-4$, and let $u=W_{\mathbb{CP}^2}$ padded to $\mathcal W_n$, of unit norm with $\theta^*=P(u)=\sqrt{3/2}$. Write $F_u(h)=\tfrac12(uh+hu)+u\#h$ and $\alpha=\sqrt{2/3}\,\langle F_uV,V\rangle$ for a unit $V\in u^\perp\cap T_u(SO(n).u)^\perp$. Then $\alpha\le\tfrac13$, and $\tfrac13$ is attained.

**What the consumers may take.** [Lemma L20](#lemma-l20-no-maximizer-lies-near-the-rival-maximizers-orbit-for-every-nge12) takes the **upper bound** $\alpha\le\tfrac13$ and nothing else. [Lemma L134](second-order.md) takes the upper bound **at its numerical value**, since its margin $-\theta^*/2$ is $3\theta^*(\alpha-\tfrac12)$ read at $\alpha=\tfrac13$, a hedge weakening $\tfrac13$ to any $a<\tfrac12$ rescues L20 and not L134. **Attainment governs only the sharpness of the radius $0.5748$**, and no $\tfrac13$-eigenvector is exhibited anywhere on the record. *The bound is the exposed direction: one extra $\tfrac12$ transverse to the orbit collapses it to $\alpha\le\tfrac12$, at which the tube theorem is vacuous.*

## Definitions and sources

- $\mathcal W_n=\mathrm{Weyl}_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$ with the Frobenius inner product, $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$ on the unit sphere. $W_{\mathbb{CP}^2}$ padded to $\mathcal W_n$ has $P=\sqrt{3/2}$ at every $n\ge4$.
- Lemmas L20 and L21 are givens, as quoted, with whatever hypotheses and debts they state.
- **This loop does no numerical work**; a statement supported only by a run is HYPOTHESIS-DEBT.
- The lemma has **no entry in [results.md](../results.md)**. Its Lean files are withheld.

## What to attack, beyond the standing list

1. **What L100 states**: the heading's range $8\le n\le11$ against the body's "A bonus at $9\le n\le11$" and "The derivation holds at every $n\ge9$". Which range does the argument reach, and what covers $n=8$?
2. **The dichotomy's two horns**: whether "either $\max P\le\sqrt{3/2}$, or every maximizer sits farther than $0.5748$" is a case split or one implication, given that padded $W_{\mathbb{CP}^2}$ has $P=\sqrt{3/2}$.
3. **"The same machinery, Lemma L20's proof"**: whether Passage B's argument, stated for $n\ge12$, runs below the crossover $n=6+2\sqrt7$, and which of its steps use $n\ge12$.
4. **The input $\alpha\le\tfrac13$**: what Passage C gives, at which $n$, and with which debts, and whether L100 inherits them.
5. **The constant $0.5748$ and the metric** of "farther than", against Passage B's definition of $d$.
6. **"Wherever $\alpha\le\tfrac13$ holds"**: whether the statement is conditional, and how it reads at the dimensions where the input is not established.
7. **Scope**: what L100 contributes beyond L20 and the padding value, and the odd-$n$ members of the range.
