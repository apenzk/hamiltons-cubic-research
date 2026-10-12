# Review r675, Observation L144, no DGK point in the band except the balanced product

**Reviewer A of an independent pair on identical briefs. Target: [Observation L144](../findings/diagonal-half.md), `findings/diagonal-half.md` line 523. Derived cold from [conventions.md](../findings/conventions.md) and the criticality equation; the block's own reasoning was read only after the derivation closed.**

**Standing rule observed: analysis only.** Nothing below rests on a computation. Every number quoted is either evaluated by hand from a closed form derived here, or is a number already on the record which I re-derive analytically. No sweep, census or screened range was extended.

## VERDICT: GAP

**Everything mathematical in the block is correct, and its self-assessment of its two halves is accurate, which after the day this record has had is worth saying plainly.** The closed form is right, the absolute value in it is *necessary* and is what makes this the record's good copy, the structural claim is right and I re-derive it, the imprimitive inequality is right, and the primitive half genuinely is screened rather than proved, I give the reason the obvious closing argument fails.

Two defects, one in a statement and one in a word:

| # | defect | grade |
| --- | --- | --- |
| 1 | *"maximised uniquely at $g=n/2$"* omits **$n$ even**. At odd $n$ there is no such $g$, and the imprimitive maximum is a different, strictly smaller number. This is the omission [L96](../findings/diagonal-half.md) was refuted for today, one screen further up the same file | **statement defect, conclusion unharmed** |
| 2 | *"the band"* carries **two incompatible senses** on the record and is in neither [conventions.md](../findings/conventions.md) nor [INDEX-traps.md](../findings/INDEX-traps.md). Under [target.md](../findings/target.md)'s sense the block's headline sentence is false in both directions; under [plan.md](../plan.md)'s sense it is true | **GAP, repairable in one clause** |

Plus one false provenance claim and one stale copy in another file, below.

---

## Readings adopted, stated before the derivation

- **$\|W\|=1$ means $\sum_{a<b}M_{ab}^2=1$**, equivalently $\|M\|_F^2=\sum_{a\ne b}M_{ab}^2=2$, [conventions.md](../findings/conventions.md), *The vertex matrix*, the ordered-pair reading, which that file boxes as "the whole of the normalisation".
- **Criticality on the diagonal locus is $(M^{\circ2})_{ij}+(M^2)_{ij}=\theta M_{ij}$ for $i\ne j$**, [conventions.md](../findings/conventions.md)'s *"critical point" is $Q(W)=\theta W$*, compressed as at [diagonal-half.md](../findings/diagonal-half.md) line 26. Consistency check I ran before using it: pairing that with $M$ over $i\ne j$ gives $\langle M^{\circ2}+M^2,M\rangle=2\theta$, which is the block's own $2\theta=\langle M^{\circ2}+M^2,M\rangle$, so the normalisation and the equation agree.
- **$\theta_0(n)^2=2(n-1)(n-2)/n^2$ and nothing more**, per the repair to [conventions.md](../findings/conventions.md), the balanced-product value **at even $n$ only**. I use $\theta_0$ as the closed form throughout and never as "the value at the balanced split".
- **On the diagonal locus the $\Lambda^2$ spectrum is the multiset of entries of $M$**, not its eigenvalues, [conventions.md](../findings/conventions.md), the $M$-collision row. This is what makes the two-eigenvalue class the two-entry-value class, and I use it only there.
- **$\mu$ here is the strongly-regular parameter**, not either of the three senses [conventions.md](../findings/conventions.md) tables. Said because this file's own $\mu$ collision is live.
- **SRG means $0<k<v-1$**, so the complete and empty graphs are excluded. The block does not say so; the construction needs it, since $k=v-1$ leaves no non-edge class and $k=0$ gives $M=0$.

---

## 1. The closed form, derived cold

Let $\Gamma$ be strongly regular with parameters $(v,k,\lambda,\mu)$, adjacency $A$, complement adjacency $\bar A=J-I-A$, and write $w=v-1-k$, $t=k/w$.

**The ansatz.** $M$ is constant on edges and on non-edges, $M=a(A-t'\bar A)$; zero row sums give $a(k-t'w)=0$, so $t'=t$. Put $N=A-t\bar A$, so $N$ has entry $1$ on edges, $-t$ on non-edges, $0$ on the diagonal.

**The normalisation.** $\|M\|_F^2=a^2(vk+vwt^2)=a^2vk(w+k)/w=a^2vk(v-1)/w=2$, so
$$a^2=\frac{2w}{vk(v-1)}.$$
Nothing from [DGK](../references/deninger-grundhoefer-kramer-2023-srg-quadratic/notes.md) enters. **The block's "pinned from criticality alone" is confirmed, and it is the cheapest of its claims:** the ansatz is fixed by regularity, $t$ by Ricci-flatness, $a$ by the record's own unit norm.

**The two criticality equations.** With $A^2=kI+\lambda A+\mu\bar A$, $A\bar A=\bar AA=(k-1-\lambda)A+(k-\mu)\bar A$ and $\bar A^2=wI+(w-k+1+\lambda)A+(w-1-k+\mu)\bar A$, the coefficients of $N^2$ on $A$ and on $\bar A$ are
$$P=\lambda-2t(k{-}1{-}\lambda)+t^2(w{-}k{+}1{+}\lambda),\qquad Q=\mu-2t(k{-}\mu)+t^2(w{-}1{-}k{+}\mu).$$
Criticality reads $\theta/a=1+P$ on edges and $\theta/a=-(t^2+Q)/t$ on non-edges, so the constant equation is $t(1+P)+t^2+Q=0$.

**It is the graph identity, exactly.** Writing $E=k-1-\lambda$ and clearing $w^3$, every $E$-term collects as $-kE(w+k)^2$, every $\mu$-term as $+\mu w(w+k)^2$, and the eleven $\mu$- and $E$-free terms cancel identically. So
$$t(1+P)+t^2+Q=-\frac{(v-1)^2}{w^3}\Big[k(k-1-\lambda)-w\mu\Big].$$
**Claim confirmed.** The bracket is the standard strongly-regular identity, which every strongly regular graph satisfies by double counting, so the constant equation imposes nothing further and **every strongly regular graph is a diagonal critical point**.

**The value.** $F:=1+P=1+\lambda-Et(2+t)+t^2w$; substituting $E=w\mu/k$ and $t=k/w$ gives $F=(1+\lambda-2\mu)+k(k-\mu)/w$, and the identity in the form $k^2=w\mu+k(1+\lambda)$ collapses this to
$$F=(1+\lambda-\mu)\frac{v-1}{w},\qquad\text{whence}\qquad \boxed{\ \theta=\lvert1+\lambda-\mu\rvert\sqrt{\frac{2(n-1)}{nk(n-1-k)}}\ }$$
with $n=v$. **The block's display is confirmed, character for character.**

**The absolute value is load-bearing, and this is where the record's copies part company.** Criticality is odd in $M$, so $\pm M$ are both critical with $\theta\mapsto-\theta$; the positive root $a>0$ selects one branch, and at $K_{m,m}=\mathrm{SRG}(2m,m,0,m)$ that branch has $1+\lambda-\mu=1-m<0$. So the unsigned form returns $-\theta_0(2m)$ at the balanced product, and its named maximiser is its minimiser, exactly what the companion audit reported. **L144's $\lvert\cdot\rvert$ is the repair, and it is correct**: the DGK locus is closed under $M\mapsto-M$, so $\theta(\Gamma)$ is well defined as the value on whichever branch is positive.

**Sanity of the branch, by hand.** At $K_{m,m}$: $\lvert1-m\rvert=m-1$, $w=m-1$, so $\theta=(m-1)\sqrt{(2m-1)/(m^2(m-1))}=\sqrt{(m-1)(2m-1)}/m$, and $\theta_0(2m)^2=2(2m-1)(2m-2)/(4m^2)=(m-1)(2m-1)/m^2$. **Equal.** At the octahedron $\mathrm{SRG}(6,4,2,4)$: $\lvert1+2-4\rvert=1$, $w=1$, $\theta=\sqrt{10/24}=\sqrt{5/12}=0.645497$, the record's catalogued $n=6$ maximal torus, and my $F=(1+\lambda-\mu)(v-1)/w=-5$ reproduces [L74](../findings/diagonal-half.md)'s $F=-5$ on the nose. At every conference graph $1+\lambda-\mu=1+(v-5)/4-(v-1)/4=0$, so $\theta=0$ exactly, [L74](../findings/diagonal-half.md)'s subfamily confirmed from the L144 parametrisation.

## 2. The three copies now agree, and the fourth does not

**[L74](../findings/diagonal-half.md)'s numerator is algebraically identical to mine.** Expanding $w^2=(v-1)^2-2k(v-1)+k^2$,
$$(v-1)^2\lambda+2k(v-1)-k^2v+w^2=(v-1)\big[(v-1)(\lambda+1)-k^2\big],$$
and eliminating $\mu$ from my $F$ by the identity gives $F=(v-1)[(v-1)(\lambda+1)-k^2]/w^2$. **Same expression.** So of the three copies in [diagonal-half.md](../findings/diagonal-half.md), [L74](../findings/diagonal-half.md) at line 465, the L96 refutation note at line 387, and L144 at line 529, **all three agree**, with the one difference that L74 states the signed branch and L144 states the absolute value.

**That difference is not cosmetic in one sentence of L74.** L74 asserts of the saturating pair that "$\lambda_{\min}+(n-2)\lambda_{\max}=\sqrt{(2m-1)(m-1)}/m=\theta_0(2m)$, which the closed form returns as $\theta$". Its closed form returns $-\theta_0(2m)$ there, since $(v-1)(\lambda+1)-k^2=(2m-1)-m^2=-(m-1)^2$. L74 is *aware* of the branch (it says so for the octahedron and calls the two families "the two sign branches of one point") so this is a sentence to fix rather than a result to withdraw. **But the L96 note's parenthesis "L96 is the only wrong copy of the three" overstates by one:** L74's display disagrees in sign with L144's at precisely the point both are about.

**The fourth copy is in another file and is wrong.** [problem.md](../findings/problem.md) line 155 still asserts "$Q(W)=\theta W$ with $\theta=\lambda-\mu+1$", that is [DGK](../references/deninger-grundhoefer-kramer-2023-srg-quadratic/notes.md)'s unnormalised $\theta$ at $z=1$, not this record's unit-norm $\theta$, and at the octahedron it returns $-1$ against the true $0.645497$. **[LEDGER.md](../findings/LEDGER.md) line 1626 records catching and correcting this exact assertion in [90-appendix.tex](../report/sections/90-appendix.tex), and the copy in findings/ survived the repair.** The same line also carries "largest value found: $0.417$" for the primitive maximum over $n\le200$, against L144's $0.4758$ for what reads as the same screen. **Two numbers on the record for one screened maximum; one of them is stale.** Deciding which is a computation and is blocked.

**External agreement, and it costs nothing.** [DGK](../references/deninger-grundhoefer-kramer-2023-srg-quadratic/notes.md) Theorem 5.1 gives $\hat\theta=\lvert\lambda-\mu+1\rvert\sqrt{(n-1)/(nrr^c)}$, and that file's own conversion $\theta_{\text{record}}=\sqrt2\,\hat\theta$ turns it into L144's display exactly. So the closed form now has three independent derivations and a published source.

## 3. What "every strongly regular graph is a diagonal critical point" consumes

| ingredient | what it buys |
| --- | --- |
| **regularity** (constant $k$) | a two-valued $M$ can have zero row sums at all; fixes $t=k/w$ |
| **the two-class structure** ($\lambda,\mu$ constant) | $M^2$ lies in $\mathrm{span}\{I,A,J\}$, so off-diagonal criticality is **two** scalar equations rather than $\binom n2$ |
| **the strongly-regular identity** | makes those two agree, and it is free, holding in every strongly regular graph |
| **$0<k<v-1$** | the non-edge class is non-empty and $M\ne0$. Unstated in the block |
| **criticality alone** for the constant | no DGK transcription; the block's claim, confirmed |

**Is a converse claimed, and does it hold?** L144 claims only the forward direction and is right to. The converse is true **only inside the two-entry-value class**, [DGK](../references/deninger-grundhoefer-kramer-2023-srg-quadratic/notes.md) Theorem 5.1 hypothesises "the off-diagonal entries assume precisely two different values", which on the diagonal locus is two $\Lambda^2$ eigenvalues by [conventions.md](../findings/conventions.md)'s entries-not-eigenvalues rule. [routes.md](../routes.md)'s R15 row states the correspondence with that restriction intact. **The scope point this buys, and it matters for §5:** an unbalanced $S^p\times S^q$ has *three* entry values, so it is not a DGK point at all, and $S^5\times S^7$ at $\theta=1.228239$ is a pure critical point sitting in the band. The DGK family being falsifier-free does not make the band falsifier-free, and the block is careful to claim only the former.

## 4. The imprimitive half, the inequality is right, "uniquely at $g=n/2$" needs $n$ even

**Classification, consumed silently by the block.** An imprimitive strongly regular graph is $mK_g$ or its complement $K_{m\times g}$, $v=n=mg$, $m\ge2$, $g\ge2$. The block states neither the classification nor the constraint $g\mid n$, both of which its formula needs.

**Both members, evaluated.** $mK_g=\mathrm{SRG}(n,g-1,g-2,0)$ gives $1+\lambda-\mu=g-1$ and $w=n-g$; $K_{m\times g}=\mathrm{SRG}(n,n-g,n-2g,n-g)$ gives $\lvert1+\lambda-\mu\rvert=g-1$ and $w=g-1$. Both return
$$\theta(g)=\sqrt{\frac{2(n-1)(g-1)}{n(n-g)}},$$
**confirming the block's display.**

**Complement invariance, and why "uniquely" survives it.** In general $1+\bar\lambda-\bar\mu=-(1+\lambda-\mu)$ and $\bar k\bar w=kw$, so $\theta(\bar\Gamma)=\theta(\Gamma)$ **for every strongly regular graph**. More than that: $\bar a=a k/w$ and a two-line check gives $M(\bar\Gamma)=-M(\Gamma)$ **exactly**. So the complement is not a second maximiser, it is the same critical point on the other sign branch, which is what [L74](../findings/diagonal-half.md) already says of $K_{m,m}$ and $2K_m$. **The brief's worry about a missing "up to" is answered: the "up to" is complementation, it equals $M\mapsto-M$, and the record states it one screen above.** L144 inherits it silently and should say so in three words.

**The maximum.** $\frac{d}{dg}\frac{g-1}{n-g}=\frac{n-1}{(n-g)^2}>0$, so $\theta(g)$ is **strictly** increasing on $(1,n)$ and the maximum is at the *largest* admissible $g$. Admissible means $g\mid n$ with $m=n/g\ge2$, i.e. $g\le n/2$. Hence:

- **$n$ even:** the maximum is $g=n/2$, $m=2$, and $\theta(n/2)^2=\frac{2(n-1)(n/2-1)}{n\cdot n/2}=\frac{2(n-1)(n-2)}{n^2}=\theta_0(n)^2$. Uniquely in $g$, by strict monotonicity; the pair $\{2K_{n/2},K_{n/2,n/2}\}$ is one point up to sign. **The block's claim, correct.**
- **$n$ odd:** there is no $g=n/2$. Every admissible $g$ has $m\ge3$, so $g\le n/3$ and
$$\theta^2\le\frac{2(n-1)(n/3-1)}{n(n-n/3)}=\frac{(n-1)(n-3)}{n^2}<1 .$$
**The block's statement is unattainable here as written**, and this is the omission for which [L96](../findings/diagonal-half.md) was refuted today, four hundred lines earlier in the same file.

**The conclusion is unharmed, and in fact the odd case strengthens it.** The same bound applies to every $m\ge3$ member at even $n$ too, so:

> **Repair, and it proves more than the block claims.** *Every imprimitive DGK point other than the balanced product satisfies $\theta^2\le(n-1)(n-3)/n^2<1<\sqrt{3/2}$, at every $n$, odd and even alike; at even $n$ the balanced product attains $\theta_0(n)$ and is the unique imprimitive maximiser up to complementation; at odd $n$ the whole imprimitive family lies below $1$.*

That is a **uniform** statement with no attainability clause to get wrong, and it is what the discharge in §5 actually needs. It is also not new to the record: [r393](REVIEW_r393.md) line 187 has "the runner-up $t=3$ gives $\sqrt{(n-1)(n-3)}/n\to1$, below $\sqrt{3/2}$ at every $n$". **The migration into L144 dropped it**, keeping the maximum and discarding the bound on everything else, which is why the surviving sentence has to carry a parity hypothesis it does not state.

**Arithmetic checks, by hand.** $g=n/3$ at $n=12$ is $K_{4,4,4}$: $\lvert1+4-8\rvert=3$, $w=3$, $\theta=3\sqrt{22/288}=0.829156$, the block's own runner-up figure at line 400. $K_{3,3,3,3}$: $\lvert1+6-9\rvert=2$, $w=2$, $\theta=2\sqrt{22/216}=0.638285$, likewise. $2K_3=\mathrm{SRG}(6,2,1,0)$: $\theta=2\sqrt{10/36}=1.054093=\theta_0(6)$. $2K_6=\mathrm{SRG}(12,5,4,0)$: $\theta=\sqrt{110/72}=1.236033=\theta_0(12)$. All four fall out of both the general and the imprimitive display, agreeing.

## 5. The primitive half, the grade is right, and I can say why the obvious argument fails

**The convexity observation is correct.** Eliminating $\lambda$ by the identity gives $1+\lambda-\mu=k-(n-1)\mu/k$, so at fixed $(n,k)$
$$\theta^2(\mu)=\frac{2(n-1)}{nk^3(n-1-k)}\big(k^2-(n-1)\mu\big)^2$$
is a **convex parabola in $\mu$** with vertex $\mu=k^2/(n-1)$, where $\theta=0$. Since primitivity is exactly $1\le\mu\le k-1$, the maximum over $\mu$ at fixed $k$ sits at an endpoint. **The companion reviewer's claim is confirmed.**

**It does not close the half, and here is the witness for why.** Take $\mu=1$, $\lambda=k-2$, $v=2k+1$. The identity holds ($k(k-1-\lambda)=k=v-1-k$) and $\lambda\ge0$, $1\le\mu\le k-1$, so this parameter set is primitive and sits at the endpoint the convexity argument hands you. Its value is
$$\theta^2=\frac{4(k-2)^2}{k(2k+1)},\qquad \frac{\theta^2}{\theta_0(v)^2}=\frac{(k-2)^2(2k+1)}{k^2(2k-1)}\longrightarrow1 .$$
**So the endpoint family runs to the band ceiling**: $0.707$ of $\theta_0^2$ at $k=10$, $0.970$ at $k=100$, $\to1$. What kills it is neither convexity nor the identity but **multiplicity integrality**, the discriminant $(\lambda-\mu)^2+4(k-\mu)=(k-1)^2+4$ is a perfect square only at $k=1$, and the conference alternative forces $2k(k-2)=0$. **Therefore the parabola argument leaves the whole of the primitive half open, and L144's "screened and not proved, evidence rather than a theorem" is an accurate grade, not a pessimistic one.** Recording this as the answer to the brief's item 4: the outcome that would have converted the Observation into a Lemma is not available by that route.

*This also re-confirms the block's own warning at line 400 that a "superset satisfying integrality and the identity" is only a superset if integrality means the multiplicities, the point the L96 audit made with $(k,k-1,0)$, reached here from the opposite end.*

**What would close it, stated so a successor can start.** In integral eigenvalues $r\ge1$, $s=-m\le-2$ (primitive), with $\mu=k-rm$, $\lambda-\mu=r-m$, $w=k(r+1)(m-1)/\mu$ and $v-1=k(k+m-r-1)/\mu$, the closed form becomes
$$\theta^2=\frac{2(r-m+1)^2\,\mu\,(k+m-r-1)}{k(k-r)(k+m)(r+1)(m-1)} .$$
*Checked against the Schläfli graph $(27,16,10,8)$, $r=4$, $m=2$: $2\cdot9\cdot8\cdot13/(16\cdot12\cdot18\cdot5)=0.108\overline{3}$, matching the general display.* Complementation swaps $(r,m)\mapsto(m-1,r+1)$ and preserves $\theta$, so one may assume $r\ge m-1$. Then $\mu\le k$ and $k\ge rm+1$ give
$$\theta^2\le\frac{2(r-m+1)^2}{(k-r)(r+1)(m-1)}\le\frac{2r^2}{\big(r(m{-}1)+1\big)(r+1)(m-1)},$$
which is $<\tfrac12$ already for every $m\ge3$. **The whole residue is $m=2$**, where $\theta^2=\frac{2(r-1)^2\mu(r+\mu+1)}{(2r+\mu)(r+\mu)(2r+\mu+2)(r+1)}\sim\mu/(2r)$, small as soon as $\mu$ is bounded against $r$. Neumaier's classification of primitive strongly regular graphs by smallest eigenvalue bounds $\mu$ by a function of $m$ alone (Steiner graphs $\mu=m^2$, Latin-square graphs $\mu=m(m-1)$, otherwise a $\mu$-bound polynomial in $m$), which would reduce the primitive half to a finite explicit range.

> **BLOCKED, and I stop rather than write it.** **The record holds no Neumaier entry**, [references/INDEX.md](../references/INDEX.md) lists sixty sources and none of them is it, so the exact form of the $\mu$-bound is not checkable here, and a lemma resting on a constant quoted from memory is the failure mode this programme keeps paying for. *What acquiring it would decide:* with the bound in hand the primitive half becomes a proof modulo a finite check whose range the bound itself names, and L144 becomes a Lemma; without it the half stays a screen. **This needs a source, not a computation.**

## 6. Scope, what "the band" means, and the one place the block is wrong in both directions

**The word carries two senses and is in neither [conventions.md](../findings/conventions.md) nor [INDEX-traps.md](../findings/INDEX-traps.md).**

| sense | where | is the balanced product in it? |
| --- | --- | --- |
| the **middle band** $\{S=0,\ 3\le\dim\mathfrak m<\lfloor n^2/4\rfloor\}$ | [target.md](../findings/target.md) line 614, [INDEX.md](../findings/INDEX.md) line 27 | **no**, $S^{n/2}\times S^{n/2}$ has $\dim\mathfrak m=n^2/4$ exactly, failing the strict upper cut |
| the **$\theta$-interval** $[\sqrt{3/2},\Theta_n]$ | [plan.md](../plan.md), I18: *"this item's domain is the band $[\sqrt{3/2},\Theta_n]$, width $0.0113$ at $n=12$"* | **yes**, at even $n\ge12$, where $\theta_0(n)=\Theta_n\ge\theta_0(12)=1.236033>\sqrt{3/2}$ |

**L144 needs the second sense and is stated in the first's vocabulary.** Read in the first sense the headline is false twice over: the balanced product is *not* in the middle band, so it cannot be the exception; and DGK points satisfy its dimension condition, the Clebsch graph $\mathrm{SRG}(16,5,0,2)$ on the branch whose minimum entry sits on the $40$ edges has $\dim\mathfrak m=40$ against $\lfloor256/4\rfloor=64$, so $3\le\dim\mathfrak m<\lfloor n^2/4\rfloor$ holds there at $\theta=\sqrt{30/800}=0.193649$. *(Whether $S=0$ at that point is a second condition I have not checked; the dimension cut alone already breaks the "except" clause, since it also puts the balanced product outside.)* Read in the second sense the sentence is exactly right. **Repair is one clause: "no DGK point has $\theta\ge\sqrt{3/2}$ except the balanced product at even $n\ge12$".** And the word belongs in [conventions.md](../findings/conventions.md), this is the same class of collision as the $B$, $M$, $d$ and $\mu$ rows that file already tables.

**Does the conclusion bear on $n\ge12$? Yes, and only there.** $\Theta_n<\sqrt{3/2}$ for $n\le11$, $\Theta_{10}=\theta_0(10)=1.2$, so the interval is empty below $12$ and the statement is vacuous there. At $n\ge12$: at odd $n$ every DGK point is below $1$ by §4 and the intersection is **empty**; at even $n$ the imprimitive family contributes $\theta_0(n)=\Theta_n$ at the balanced product and nothing else above $1$, and the primitive family contributes nothing above $\tfrac12$ **on the screen**. **So the discharge is exactly as strong as the screen, and the block says so**, *"the discharge inherits the status of its weakest input, which is the screen"* is the correct grading and is the sentence I would keep unchanged.

## 7. Provenance, and the pointers

**The provenance claim is false.** L144's note reads *"Migrated from [I18](../plan.md)(a) on 2026-09-03, where it was the sub-step's whole content and the record's only copy."* Checking with `git log -S`:

- the plan text landed in **ae6fdf39, 2026-09-02**, *"docs(plan): IS-2's sub-step (a) is answered and R15 is largely closed"*, and the diff of that commit contains the closed form, the imprimitive display, "maximised uniquely at $g=n/2$" and the headline sentence, so the migrated text is faithful to its source;
- **but the same commit also wrote [routes.md](../routes.md)'s R15 row**, which carries "no DGK point is in the band except the balanced product" and the closed form. `git log -S 'no DGK point is in the band' -- routes.md` returns ae6fdf39 and nothing else. So on 2026-09-03, when the migration ran, **the record held two copies, not one**, and both were a day old.

That is a **half-false provenance note**: the migration is real and faithful, the exclusivity is not. Separately, [problem.md](../findings/problem.md)'s line 155 has carried a third, wrongly normalised copy of the same conclusion since the 2026-08-24 file split, which makes "the record's only copy" false by a further ten days.

**Pointers.** All the links resolve: [L74](../findings/diagonal-half.md)'s anchor matches its heading at line 465; [r393](REVIEW_r393.md) and [r394](REVIEW_r394.md) both exist and both contain the closed form; [R15](../routes.md) and the [DGK notes](../references/deninger-grundhoefer-kramer-2023-srg-quadratic/notes.md) resolve. **One referent is stale:** the citation is written "[I18](../plan.md)(a)", and after c6902f8f made I18 a pointer, [plan.md](../plan.md)'s I18 no longer has a sub-step (a), the link lands on the file but names a part of it that the migration itself removed.

## 8. Every hedging clause, adjudicated

| clause | verdict |
| --- | --- |
| *"pinned from criticality alone"* | **true**, and cheaply, regularity fixes the ansatz, Ricci-flatness fixes $t$, the record's own unit norm fixes $a$ |
| *"the constant equation **is** the strongly-regular identity"* | **true**, with the factor: the constant equation equals $-(v-1)^2\big[k(k-1-\lambda)-w\mu\big]/w^3$ |
| *"every strongly regular graph is a diagonal critical point"* | **true**, given $0<k<v-1$, which is unstated |
| *"the imprimitive half, **proved**"* | **true of the inequality; the maximiser statement needs $n$ even.** With the $m\ge3$ cap restored it is proved outright and uniformly |
| *"maximised **uniquely** at $g=n/2$"* | **unique in $g$ by strict monotonicity, and unique up to complementation, which is $M\mapsto-M$**, the "up to" is real, is already on the record at L74, and is not stated here |
| *"the primitive half, **screened** and not proved"* | **accurate, and correctly cautious**, §5 exhibits an endpoint family the parabola argument cannot exclude and only integrality does |
| *"$\theta<\tfrac12$ over the range examined"*, *"screened to $n\le200$"*, *"evidence rather than a theorem"*, *"a uniform bound is owed"* | **each honest**, and the "owed" is the right word, §5 names what is owed |
| *"the discharge inherits the status of its weakest input"* | **correct, and the model for how the rest of the record should grade a discharge** |
| *"no DGK point lies in the band"* | **the one wrong sentence**, and only because of the word "band" |

## 9. What I would change, in order

1. **Add "$n$ even" to the imprimitive maximiser, and restore [r393](REVIEW_r393.md)'s $m\ge3$ cap**, replace "maximised uniquely at $g=n/2$" by the boxed statement in §4, which is uniform in $n$ and proves the thing the discharge uses.
2. **Fix "the band"**, say $\theta\ge\sqrt{3/2}$, and table the word in [conventions.md](../findings/conventions.md) with both senses and the file each belongs to.
3. **Correct the provenance note** to name [routes.md](../routes.md)'s R15 as the sibling copy.
4. **Repair [problem.md](../findings/problem.md) line 155**, its $\theta=\lambda-\mu+1$ is the same defect [LEDGER.md](../findings/LEDGER.md) line 1626 recorded as corrected in the report appendix, and it is still live in findings/. Its $0.417$ and L144's $0.4758$ cannot both be the screened maximum.
5. **Add the branch clause to [L74](../findings/diagonal-half.md)** (its display returns $-\theta_0(2m)$ where its prose says $\theta_0(2m)$) and soften the L96 note's "the only wrong copy of the three" accordingly.
6. **Acquire Neumaier** into [references/](../references/), which is the single step between the primitive half and a Lemma.

---

**Closing note the brief asked for explicitly.** L144 grades its own two halves correctly. The imprimitive half is proved (modulo one parity hypothesis it forgot to write), the primitive half is a screen and says so, the discharge is stated as inheriting the screen's status, and the wider range it grades as "not proved" is the same range a neighbouring block graded as "settled" on weaker evidence. **This is the copy the record should keep.**
