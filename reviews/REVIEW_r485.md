# REVIEW r485, Lemma L20, the tube theorem

**Verdict: CONFIRMED as a theorem, with one measured input. The epithet "unconditional" is earned in the circularity sense and REFUTED as unqualified.** Reviewer r485, cold brief, [REVIEW_r484.md](REVIEW_r484.md) unread.

| attack | outcome |
| --- | --- |
| the analytic argument (expansion, bootstrap, $\psi\le1$, contradiction) | **CONFIRMED**, re-derived line by line, no gap |
| free of circular inputs | **CONFIRMED**, no a priori cap, no [Observation L22](../findings/route-a.md), no [Observation L102](../findings/route-a.md) |
| input-complete | **REFUTED**, $\alpha\le\tfrac13$ ends in four $F_\lambda$ spectra, floating-point at the dimensions the lemma claims |
| the radius $0.5748$ | **CONFIRMED and recomputed**; sharp for the *method*, far from sharp for the geometry; **its metric is unstated and load-bearing** |
| the self-bootstrap $\gamma_V\le m$ | **CONFIRMED non-circular**, it is the definition of a maximum, nothing more |
| block contains its proof | **YES** for even $n$; **NO** for odd $n$, the block's contradiction step names an object that does not exist at odd $n$ |
| the block's own citation | **STALE**, it cites Nienhaus 4.14(c), the source the record replaced, and never names [Lemma L21](../findings/route-a.md) |
| vacuity | **NOT vacuous**, but the tube is $\sim10^{-424}$ of the sphere at $n=12$ |

---

## 1. What the proof actually consumes, the list, so a fourth wrong description does not follow

Read from [route-a.md](../findings/route-a.md), Lemma L20's block, nothing else. In order of use:

1. **Compactness** of the unit sphere of $\mathcal W_n$ and continuity of $P$, the maximum $m=\sqrt{2/3}\max P$ is attained.
2. **$SO(n)$-invariance of $P$**, lets the nearest orbit point be rotated to $u=W_{\mathbb{CP}^2}$.
3. **Total symmetry of the cubic's polarisation**, $T(X,Y,Z)=\langle X\circ Y,Z\rangle$, equivalently $\nabla P=3Q$. This is what makes $F_u=u\circ(\cdot)$ self-adjoint and makes $\alpha$ a Rayleigh quotient. *Unstated in the block and genuinely needed.*
4. **$u$ is a critical point with $Q(u)=\theta^*u$, $\theta^*=\sqrt{3/2}$, $\lVert u\rVert=1$**, kills the linear term. On the record at [target.md:654](../findings/target.md).
5. **First-variation at a nearest orbit point**, gives $V\perp T_u\mathcal O$.
6. **$\alpha\le\tfrac13$**, the transverse spectral bound. This is [Lemma L21](../findings/route-a.md)'s statement verbatim; the block cites Nienhaus 4.14(c) instead.
7. **$\gamma_V\le m$**, because $V$ is a unit Weyl operator.
8. **Elementary calculus on $\psi(\varphi)=\cos\varphi/(1-\sin^3\varphi)$.**
9. **A sphere product of unit norm with $P>\sqrt{3/2}$ at every $n\ge12$**, $\theta_0(n)$ at even $n$, $\Theta_n$ at odd.

**It consumes neither [Observation L22](../findings/route-a.md) nor [Observation L102](../findings/route-a.md) nor any a priori cap.** Confirmed by reading the block: L22 appears nowhere in the chain, and the only place a cap could enter (the bound on $\gamma_V$), is filled by $m$ itself.

**A fourth wrong description is already on disk.** [plan-maximizer.md:62](plan-maximizer.md) states *"Lemma L20's proof (route-a.md) has three inputs: … the inner trust-region estimate (Lemma L22), which is orbit-independent in form"*, the same false L22 dependency [r463](REVIEW_r463.md) removed from the canon, still standing in the plan review that [I10](../plan.md) rests on. And [plan.md:133](../plan.md) links **[Lemma L20](findings/target.md)**, the wrong file; [target.md](../findings/target.md) contains no L20.

## 2. The argument, re-derived

Writing $W^*=\cos\varphi\,u+\sin\varphi\,V$ with $\lVert V\rVert=1$, $V\perp u$:

$$P(W^*)=\cos^3\varphi\,P(u)+3\cos^2\varphi\sin\varphi\,T(u,u,V)+3\cos\varphi\sin^2\varphi\,T(u,V,V)+\sin^3\varphi\,P(V).$$

$T(u,u,V)=\langle Q(u),V\rangle/1=\theta^*\langle u,V\rangle=0$, and $T(u,V,V)=\langle u\circ V,V\rangle=\langle F_uV,V\rangle$ since $F_u(h)=\tfrac12(uh+hu)+u\#h$ **is** $u\circ h$ in [conventions.md](../findings/conventions.md)'s $\circ$. Dividing by $\theta^*$ reproduces the block's display exactly. Both substituted coefficients, $3\cos\varphi\sin^2\varphi$ and $\sin^3\varphi$, are $\ge0$ on $[0,\pi/2]$, so both upper bounds may be inserted; $1-\sin^3\varphi>0$ there, so the division is legitimate. **No step is missing.**

**$V$ really is a unit Weyl operator** (it is a linear combination of $W^*$ and $u$) so step 7 is sound, and **it really is transverse** ($W^*\perp T_u\mathcal O$ at a nearest point and $u\perp T_u\mathcal O$ on the sphere) so step 6 applies where L21 proves it. The transverse space is $F_u$-invariant ($\mathbb Ru$ and $T_u\mathcal O$ are eigenspaces), so "largest eigenvalue on it" is well posed.

**The self-bootstrap is not circular.** $m$ is introduced as *the attained maximum*, an existing real number; no value is assumed for it, and the conclusion drawn about it ($m\le1$) is the one contradicted. The step that would be circular (Nienhaus's $P\le\theta^*$, true only while $\mathbb{CP}^2$ is the global maximiser), is exactly the one removed. **This is the lemma's real content and it survives the attack.**

## 3. The radius, recomputed

Screening run (mpmath, seconds, objects constructed for the purpose):

| quantity | value |
| --- | --- |
| $\varphi_c$, root of $\sin^3\varphi=1-\cos\varphi$ | $0.5748262975155554$ |
| $\psi(0.5748)$ | $0.9999937155910329$ |
| $\psi(\varphi_c)$ | $1.000000000000000$ |
| $\min\psi$ and its argument | $0.9785932166759137$ at $\varphi=0.3747344327087401$ |
| $\psi(0.3927)$ | $0.9787302214147448$ |

**The radius is $\varphi_c$ rounded down.** $0.5748<\varphi_c$, so the block's interval is strictly inside the region where $\psi\le1$, conservative, correct. It is *sharp for the method*: at $\varphi>\varphi_c$ the bound $\psi>1$ draws no contradiction, so this argument cannot reach further, and the statement could equally be made on the closed $[0,\varphi_c]$ since $\psi(\varphi_c)=1$ still gives $m\le1$.

**Two cosmetic errors in the block.** It says $\psi$ "falls to $0.9787$ near $\varphi=0.3927$": $0.3927=\pi/8$ is not the minimiser ($0.37473$ is) and $0.9787$ is the value there, not the minimum ($0.97859$). And "first exceeding $1$ at $\varphi=0.5748$" is off by $2.6\times10^{-5}$, it exceeds $1$ at $\varphi_c$. Neither touches the conclusion.

### The one place the exact value bites: $d$ is not defined anywhere

**The block writes $\varphi:=d(W^*,SO(n).W_{\mathbb{CP}^2})\le0.5748$ and never says which metric $d$ is.** [conventions.md](../findings/conventions.md) has no row for it. The proof's own parametrisation $\cos\varphi\,u+\sin\varphi\,V$ forces the *angular* reading, and [results.md:664](../results.md) does say "angular distance", but the findings block, which is the canonical proof, does not.

**Under the chord (Frobenius) reading the proof does not cover the stated radius.** A chord of $0.5748$ is an angle of $0.5830224$, where $\psi=1.0020125>1$ and no contradiction follows. So a reader who measures $\lVert W^*-g\cdot u\rVert$ (the natural thing to do, since the whole record works in Frobenius norms), gets a false statement out of a true one. *Chord at $\varphi_c$ is $0.56694$; that is the radius the Frobenius statement would have to carry.* **Repair: write "angular distance" in the block, or add a row to [conventions.md](../findings/conventions.md).**

## 4. Is it unconditional? Trace to the leaves

**Every input above is a proved statement except 6.** Input 6, $\alpha\le\tfrac13$, is [Lemma L21](../findings/route-a.md), and L21's chain is:

- **Equivariance under $G=SO(n-4)$**, structural, because $W_{\mathbb{CP}^2}\subset\Lambda^2(\mathbb R^4)$. *Proved.* (The record adds a $3.9\times10^{-15}$ commutator check, which is a screen of something already argued.)
- **Schur without multiplicity-freeness**, $F_u=\bigoplus_\lambda F_\lambda\otimes\mathrm{Id}_{V_\lambda}$. *Proved*, and correctly, multiplicities live in $M_\lambda$.
- **$n$-stability of the decomposition.** $\mathrm{Weyl}_n\subset S^2(\Lambda^2\mathbb R^n)$ has four $\mathbb R^n$ factors, so at most $k\le4$ factors of $\mathbb R^{n-4}$, and $\otimes^k$ of the vector representation of $SO(m)$ has $m$-independent decomposition for $m\ge2k$. **This is a classical fact, not a measurement**, [route-a.md:114](../findings/route-a.md) calling it "the remaining formal obligation" understates it. *And the range it gives, $n-4\ge8$ i.e. $n\ge12$, is exactly the range L20 claims.*
- **The four matrices $F_\lambda$ and their spectra.** **This is the measurement.** They come from a floating-point diagonalisation; the exact (finite-field) verification of the kernel identity is recorded at $n=6,8,10$ (**all three below the stable range and below L20's own range**) while at $n=12,14$ the evidence is $\lVert\Pi_E-\Pi_T\rVert_2\le1.4\times10^{-14}$.

**So the honest statement is:** L20 is unconditional in the sense that matters (*no input assumes the conclusion, at any $n$*) and it is not input-complete, because one finite, $n$-independent, exactly-rational computation on four matrices of dimensions $20,20,6,10$ has been done only in floating point at the dimensions where the lemma is claimed. **The brief's premise, that the input is "four $F_\lambda$ spectra tabulated at $n=10,12,14$ and asserted stable beyond", is confirmed as to the spectra and overstated as to the stability**, which has a standard proof the record does not cite.

**The gap is small and closeable.** Every eigenvalue in the tables is a rational multiple of $\theta^*$ ($\{1,\tfrac12,\tfrac13,0,-\tfrac16,-\tfrac12,-1\}$) so an exact characteristic-polynomial computation at one dimension $n\ge12$ would retire the last input outright.

### Consistency checks on the tables, since they carry the weight

They pass four independent arithmetic tests I ran by hand.

- **Dimensions.** $\dim\mathrm{Weyl}_{12}=1638$; minus $\mathbb Ru$ and $\dim\mathcal O=4n-14=34$ leaves $1603$, the "full $1603$-dimensional complement" the numerical hunt sweeps, and $1637=\dim T_uS$ appears in [Lemma L17](../findings/route-a.md)'s audit. All consistent.
- **The orbit dimension against the stabiliser.** $\dim SO(12)-\dim(U(2)\times SO(8))=66-(4+28)=34=4\cdot12-14$. ✓
- **The orbit's $G$-type against the $\tfrac12$-eigenspace.** $2\cdot(\text{trivial})+4\cdot(\text{vector})$ gives $2+4(n-4)$, and $\tfrac12$ occurs with multiplicity $2$ in the trivial block and $4$ per vector copy **and in no other block**, so the coincidence $E(\tfrac12\theta^*)=T_u\mathcal O$ is forced by the table, not assumed.
- **The unlisted remainder.** The four blocks account for $430/698/1030$ dimensions at $n=10/12/14$, leaving $340/940/2050$ for the "two higher types". That is consistently $1\cdot\dim\mathrm{Weyl}_{n-4}+4\cdot\dim V_{(2,1)}(SO(n-4))$, $84{+}4{\cdot}64$, $300{+}4{\cdot}160$, $770{+}4{\cdot}320$. **The table is internally coherent to the last dimension**, which is real evidence it was computed rather than assembled.

**The "(c)" worry is answered.** [ELIM-canon.md:212](ELIM-canon.md) flags that the block cites Nienhaus 4.14**(c)** while the corrections list retracts the six-case reading for (a)–(g). The trivial block's seven eigenvalues in decreasing order are $1,\tfrac12,\tfrac13,0,-\tfrac16,-\tfrac12,-1$, and the corrections identify $-1$ (multiplicity $2$) as case (g), so (c) is $\tfrac13$ and the citation is coherent with the seven-case reading. *No defect here.*

## 5. Does the block contain its proof? Yes at even $n$, no at odd $n$

Unlike [Lemma L17](../findings/route-a.md), the block carries a complete argument. **But its closing step reads: "the balanced sphere product is a unit Weyl operator with $P=\theta_0(n)$, which exceeds $\sqrt{3/2}$ for $n\ge12$."** At odd $n$ there is no balanced sphere product, and $\theta_0(n)$ is **not attained**: at $n=13$, $\theta_0(13)=1.249850$ while the best split gives $\Theta_{13}=1.2483756$. *So at odd $n$ the block's final sentence names a value no Weyl operator has.*

The repair, correction 4, "using $\max_pP(S^p\times S^{n-p})$ in place of $\theta_0(n)$", marked "Applied throughout", sits fifty lines above, in the Gate 2 section, and **was not applied to the canonical block**. The claim is still true; I checked the odd family by hand:

- $\Theta_n^2=2(n-1)(n-3)/((n+1)(n-2))=2\big(1-(3n-5)/(n^2-n-2)\big)$, and $(3n-5)/(n^2-n-2)$ has derivative of sign $-3n^2+10n-11<0$ for every $n$ (discriminant $100-132<0$), so **$\Theta_n$ is strictly increasing**, a proof, not a check at two dimensions.
- $\Theta_{11}=1.2171612<\sqrt{3/2}=1.2247449<1.2483756=\Theta_{13}$, so the odd family crosses between $11$ and $13$, matching the even crossover $n>6+2\sqrt7=11.2915$.
- Even: $\theta_0(n)^2=2-6/n+4/n^2$ has derivative $6/n^2-8/n^3>0$ for $n>4/3$, so $\theta_0$ increases and $\theta_0(12)=1.2360331>\sqrt{3/2}$ suffices.

**So "for every $n\ge12$" is true, and the block as written proves it only for even $n$.** This is the same failure mode as the three wrong descriptions: a repair recorded in the discussion and not carried into the canonical text.

## 6. Would it be true vacuously?

**No, but the tube is tiny.** Two measurements of the content:

- **Measure.** The tube is an angular $0.5748$-neighbourhood of a $34$-dimensional orbit inside $S^{1636}$ at $n=12$. Its cap factor alone is $(\sin0.5748)^{1603}\approx10^{-424}$. **As a fraction of the sphere the result is negligible**, and any localisation programme built on it needs a covering argument or a growing radius, which [Conjecture D](../results.md) supplies conditionally and nothing supplies outright.
- **Content.** It is *not* vacuous, for two reasons. The tube **contains the $\mathbb{CP}^2$ orbit itself** (the record's highest catalogued non-diagonal critical value, the one named rival) so the lemma kills the only competitor anyone has produced. And the radius is far beyond what continuity gives for free: since $u$ is a strict local maximum with $P(u)=\sqrt{3/2}$ and $\max P\ge\theta_0(12)$, Lipschitz continuity alone excludes maximisers only within $(\theta_0(12)-\sqrt{3/2})/\mathrm{Lip}(P)\approx0.0113/\mathrm{Lip}$, a radius that **shrinks to zero as $n\downarrow12$** and is two orders of magnitude smaller. **L20's radius is $n$-uniform and does not degenerate at the crossover, that is its real gain.**

The record's own numerics agree the bound is loose: the tube-constrained hunt tops out at $\psi=0.99999$ against $\max f=0.9147$, "far from sharp". *Which also means no sharpening of $\alpha$ or $\gamma$ can push the radius past $\varphi_c$, the barrier is the $\psi=1$ crossing, not the constants.*

## 7. What cites it, and is the use inside the hypotheses

| citer | use | inside hypotheses? |
| --- | --- | --- |
| [results.md:232](../results.md), the canon entry | statement + the L21/bootstrap description | **yes**, and the description now matches what I traced |
| [results.md:80](../results.md), Conjecture D | composes with a $\gamma\le0.5748$ localisation | **yes**, the constants are stated to match; *the metric ambiguity of §3 is the only way this composition breaks* |
| [Lemma L134](../findings/route-a.md) | reads $\lambda_{\max}(L_e)\le\tfrac13$ off the orbit | **yes**, it borrows L21's input, not L20's conclusion, and says so |
| [plan.md:51](../plan.md) | "at the padded $\mathbb{CP}^2$ competitor only" | **yes**, correctly fenced |
| [plan.md:133](../plan.md), I10 | reuses the bootstrap at $W_{\mathbb{HP}^2}$ | **mechanism transfers, and the item flags the transverse-eigenvalue step UNSCREENED, correct**, since the generalised bound is $\max P\le\theta_u\psi_a(\varphi)$ with $\theta_u=\sqrt{56/45}$ and $a$ the $\mathbb{HP}^2$ transverse eigenvalue, and neither $a$ nor the criticality is on the record. **But the link points at [target.md](../findings/target.md), which has no L20.** |
| [plan-maximizer.md:62](plan-maximizer.md) | "three inputs … the inner trust-region estimate (Lemma L22)" | **NO, the fourth wrong description, still standing** |
| [LEDGER.md:20](../findings/LEDGER.md) | "excludes the tube unconditionally at $n\ge12$; it says nothing about anywhere else" | **yes**, the most accurate sentence about L20 in the record |

## Verdict

**CONFIRMED.** The proof is correct as mathematics and I found no gap in it. The hypotheses it actually needs are: $n\ge12$; $Q(W_{\mathbb{CP}^2})=\sqrt{3/2}\,W_{\mathbb{CP}^2}$ at unit norm; total symmetry of the cubic's polarisation; a unit Weyl operator with $P>\sqrt{3/2}$ at each $n\ge12$ (proved above for both parities); **and $\alpha\le\tfrac13$, which is a finite rational computation verified in floating point at $n=12,14$ and exactly only at $n=6,8,10$.**

**"Unconditional" is earned in the sense the canon's first sentence means it**, nothing in the chain assumes Conjecture A or any cap that presupposes the conclusion, and the self-bootstrap is the definition of a maximum. **It is not earned as "every input traced to a proved statement".** The canon's current qualifier says this; my one correction to it is that the *stability* half of the qualifier is a classical fact needing a citation rather than an open obligation, so the residue is smaller than the record admits: **four fixed matrices, one exact diagonalisation away from a fully proved theorem.**

**Repairs, in priority order.**

1. **Say "angular" in the block, or add $d$ to [conventions.md](../findings/conventions.md).** Under the chord reading the stated radius is false, and $\psi=1.00201$ there.
2. **Carry correction 4 into the block.** As written the final step is empty at odd $n$; the monotonicity proof in §5 makes it a two-line fix for both parities.
3. **Fix [plan-maximizer.md:62](plan-maximizer.md)**, the L22 dependency [r463](REVIEW_r463.md) retired is still there, and [I10](../plan.md) rests on that page.
4. **Repoint [plan.md:133](../plan.md)** from [findings/target.md](../findings/target.md) to [findings/route-a.md](../findings/route-a.md).
5. **Cite the stable-range fact** at [route-a.md:114](../findings/route-a.md) instead of calling it an open obligation, and **state that the block's Nienhaus 4.14(c) citation is superseded by [Lemma L21](../findings/route-a.md)**, the stale citation is the root cause of all four wrong descriptions.
6. Cosmetic: the $\psi$ minimum is $0.978593$ at $0.374734$, and $\psi$ first exceeds $1$ at $0.5748263$.
