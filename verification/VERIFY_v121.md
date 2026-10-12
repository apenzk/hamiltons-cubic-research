# VERIFY v121, Lemma L20's tube: the metric $d$, the input $\alpha\le\tfrac13$, and the odd-$n$ witness

**Cold brief.** I was given the proof text of [Lemma L20](../findings/route-a.md#lemma-l20-no-maximizer-lies-near-the-rival-maximizers-orbit-for-every-nge12) and its canonical statement, with provenance stripped, and three pre-registered questions. **No numerical work was done: no script was run, and every value below is a hand evaluation, each shown.** Log: [agent_logs/verify-L20-v121.log](../agent_logs/verify-L20-v121.log). Sources read on disk: [findings/route-a.md](../findings/route-a.md), [results.md](../results.md), [findings/conventions.md](../findings/conventions.md), [findings/problem.md](../findings/problem.md), [findings/LEDGER.md](../findings/LEDGER.md), [lean/INDEX.md](../lean/INDEX.md), [reviews/REVIEW_r484.md](../reviews/REVIEW_r484.md), [reviews/REVIEW_r485.md](../reviews/REVIEW_r485.md), [report/sections/90-appendix.tex](../report/sections/90-appendix.tex), and the Nienhaus thesis in [references/nienhaus-2023-second-best-einstein/](../references/nienhaus-2023-second-best-einstein/).

## Claim table

| # | Claim, as a consumer would read it | Verdict |
| --- | --- | --- |
| 1 | The compactness step: a maximizer $W^*$ exists and $m:=\sqrt{2/3}\max P$ is attained | **CORRECT** |
| 2 | The first-variation step: $V\perp u$ and $V\perp T_u(SO(n).u)$ at a nearest orbit point | **CORRECT, HYPOTHESES UNSTATED**, needs $\varphi>0$, an $SO(n)$-invariant $d$, and smooth orbit curves; none is stated |
| 3 | The cubic expansion is exact and has no linear term | **CORRECT** |
| 4 | $\alpha\le\tfrac13$, cited as *"Nienhaus Theorem 4.14(c), valid for $n\ge9$"* | **MISCITED, AND NOT PROVED ANYWHERE**, 4.14(c) states one eigenvalue on one subspace; the bound needs (a)–(g) exhaustive plus $E(\tfrac12\theta^*)=T_u(SO(n).u)$, and the record's own replacement [Lemma L21](../findings/route-a.md) rests on four $F_\lambda$ spectra in floating point at the dimensions in range |
| 5 | The bootstrap $\gamma_V\le m$ because $V$ is a unit Weyl operator | **CORRECT, AND NOT CIRCULAR** |
| 6 | $m\le\psi(\varphi)$ and $\psi\le1$ on $[0,0.5748]$ | **CORRECT**, verified by hand through the cubic $s^3+s^2+s=1$ |
| 7 | *"$\psi$ … first exceeding $1$ at $\varphi=0.5748$"* | **FALSE AS WRITTEN, HARMLESS**, $\psi(0.5748)=0.9999937<1$; the crossing is at $0.5748263$. The sentence contradicts its own first clause |
| 8 | *"$\psi$ falls to $0.9787$ near $\varphi=0.3927$"* | **FALSE AS WRITTEN, HARMLESS**, the minimiser is $\arcsin\tfrac{\sqrt3-1}2=0.374734$ and the minimum $0.978595$ |
| 9 | The final step's witness: *"the balanced sphere product … with $P=\theta_0(n)$"*, for every $n\ge12$ | **BROKEN AT ODD $n$**, no such object exists at odd $n$; $\theta_0(13)=1.2498520$ is attained by nothing, the balanced split giving $\Theta_{13}=1.2483756$ |
| 10 | The conclusion *"for every $n\ge12$"*, both parities | **TRUE, BY AN ARGUMENT THE BLOCK DOES NOT CARRY**, the repair is $\Theta_n$, on record at [problem.md](../findings/problem.md):469 and [OddWitness.lean](../lean/HamiltonsCubic/Results/OddWitness.lean), and absent from the proof and from the canonical statement |
| 11 | The metric of $d$, and the radius $0.5748$ | **UNDEFINED IN THE BLOCK AND IN [conventions.md](../findings/conventions.md)**, the expansion commits the proof to geodesic angular distance; under the chord reading $0.5748$ is angle $0.5830223$, where $\psi=1.002012>1$ and the proof does not reach its own radius |
| 12 | *"Proven unconditionally"* ([results.md](../results.md):232) and *"closes the tube itself unconditionally"* (:48) | **OVERSTATED**, free of circular inputs, but resting on an input established in floating point |
| 13 | The named trap | **CONFIRMED AT THREE SITES**, [route-a.md](../findings/route-a.md):35 says the odd-$n$ correction was *"Applied throughout"* and it is not applied at line 119 of the same file |

**Verdict: `HYPOTHESIS-DEBT`.** The chain from the expansion to $\max P\le\sqrt{3/2}$ is valid and I re-derived every step; it is conditional on $\alpha\le\tfrac13$, which no argument on the record proves, the exact rational diagonalisation is still listed as owed in [LEDGER.md](../findings/LEDGER.md). Independently, the block's final step is false at odd $n$ as written, and the repair that exists elsewhere has not landed in either canonical text.

## 0. Conventions, fixed once

- $\mathrm{Weyl}_n=\mathcal W_n$ is the space of Weyl curvature operators on $\mathbb R^n$, a real inner-product space under the Frobenius form; $\mathrm{Weyl}^1_n$ its unit sphere.
- $P$ is the cubic potential, $T$ its full polarization, totally symmetric; $Q(R,S)=\tfrac12(R\circ S+S\circ R)+R\# S$, and $Q(W)=Q(W,W)$. $F_u(h)=Q(u,h)=\tfrac12(uh+hu)+u\#h$, self-adjoint.
- $u=W_{\mathbb{CP}^2}$, padded into $\mathrm{Weyl}_n$ inside $\Lambda^2(\mathbb R^4)$; $\theta^*=\sqrt{3/2}=P(u)$ and $Q(u)=\theta^*u$.
- $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$. $\Theta_n$ is the diagonal maximum: $\Theta_n=\theta_0(n)$ at even $n$, and $\Theta_n=\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$ ([conventions.md](../findings/conventions.md):18–19).
- $m=\sqrt{2/3}\max\{P(W):\lVert W\rVert=1\}$, so $m\le1\iff\max P\le\theta^*$.
- $\psi(\varphi)=\cos\varphi/(1-\sin^3\varphi)$; $s=\sin\varphi$, $c=\cos\varphi$.
- Throughout, $\varphi\in[0,\pi/2)$, so $1-s^3>0$ and division by it preserves the sense of an inequality.

**A convention the record does not fix.** $d(\cdot,\cdot)$ has no row in [conventions.md](../findings/conventions.md). Section 4 below establishes what the proof's own algebra commits it to.

## 1. The hypothesis inventory

Everything the written proof consumes, with its status. *A pass without this table is not a pass, so it is given in full, including the inputs that turn out to be free.*

| Input | Where it is used | Status |
| --- | --- | --- |
| $\mathrm{Weyl}_n$ is finite-dimensional and $P$ continuous, so the unit sphere is compact and $\max P$ attained | first sentence | **free**, standard, and stated |
| $P$ is $SO(n)$-invariant under conjugation on $\Lambda^2(\mathbb R^n)$ | *"rotate so that the nearest orbit point is $u$"* | **proved elsewhere on the record and in the source**, $Q$ is $SO(n)$-equivariant, Nienhaus (4.6); stated in the block |
| $d$ is $SO(n)$-invariant | the same rotation | **unstated**; true under both readings of §4, since both come from the $SO(n)$-invariant Frobenius form |
| $SO(n)$ is compact, so a nearest orbit point exists | *"the nearest orbit point"* | **unstated**; true |
| $t\mapsto\exp(tX)u$ is a smooth curve in the orbit | the first-variation condition | **unstated**; true, and it is all that is needed, smoothness of the orbit *as a manifold* is not required (§2) |
| $\varphi>0$, so that $V$ is defined | the whole expansion | **unstated in the dispatched text**; the $\varphi=0$ branch is handled in the source file at [route-a.md](../findings/route-a.md):121, one line past the excerpt (§5) |
| $T$ totally symmetric | the expansion and the identity $T(V,V,u)=\langle F_uV,V\rangle$ | **imported**, Nienhaus's $\mathrm{tri}(R,S,T)$ symmetry, source on file; used implicitly, never stated |
| $Q(u)=\theta^*u$, i.e. $u$ is a critical point with eigenvalue $\theta^*$ | killing the linear term | **imported**, Nienhaus Theorem 4.14(a) (*"computed in Chapter 2.4"*), source on file; stated in the block |
| $\alpha=\sqrt{2/3}\langle F_uV,V\rangle\le\tfrac13$ | the substitution | **NOT PROVED**, §3. Cited to Nienhaus 4.14(c), which does not state it; the record's replacement is [Lemma L21](../findings/route-a.md), whose four $F_\lambda$ spectra are floating-point at $n=12,14$ |
| $\gamma_V=\sqrt{2/3}P(V)\le m$ | the substitution | **free**, $V$ is a unit vector of $\mathrm{Weyl}_n$, so $P(V)\le\max P$ by definition (§3) |
| $\psi\le1$ on $[0,0.5748]$ | the contradiction | **proved here, and re-derived below** (§6) |
| A unit Weyl operator with $P>\theta^*$ exists at every $n\ge12$ | the contradiction | **proved for even $n$** (Nienhaus Proposition 2.25, source on file); **false as the block names it at odd $n$** (§7) |
| The eigenvalue bound applies at $n\ge12$, inside its own stated range $n\ge9$ | the substitution | **free**, $12\ge9$; and per [TubeInputs.lean](../lean/HamiltonsCubic/Results/TubeInputs.lean) the $n\ge9$ threshold never binds, the range coming from the crossover |

**Two imports, both from one source, and the source is on file.** [references/nienhaus-2023-second-best-einstein/](../references/nienhaus-2023-second-best-einstein/) holds the thesis as PDF and text; I read Lemma 4.13, Theorem 4.14 with its proof, Theorem 4.17, and Proposition 2.25 there. **No claim below rests on an unread source.** The one hypothesis-check that fails is 4.14's: its proof runs through Lemma 4.13, which requires the representation to be *irreducible*, and the record itself records ([route-a.md](../findings/route-a.md):128) that this holds only on multiplicity-free isotypic components, so the import's hypothesis is not verified at the object it is applied to.

## 2. The first-variation step

**The line.** *"The vector $V$ is a unit vector orthogonal to $u$, and orthogonal also to $T_u(SO(n).u)$ by the first-variation condition for a nearest point on the orbit."*

**What a nearest point gives.** Let $g\mapsto\Phi(g)=\lVert W^*-g\cdot u\rVert^2$ on $SO(n)$. $SO(n)$ is compact and $\Phi$ continuous, so $\Phi$ attains a minimum; after the rotation the minimum is at the identity, i.e. at $u$. For $X\in\mathfrak{so}(n)$ the curve $t\mapsto\exp(tX)\cdot u$ is smooth, with velocity $[X,u]\in T_u(SO(n).u)$, and

$$0=\tfrac{d}{dt}\Big|_{t=0}\lVert W^*-\exp(tX)u\rVert^2=-2\langle W^*,[X,u]\rangle .$$

So $W^*\perp T_u(SO(n).u)$. The orbit lies in the unit sphere, so $u\perp T_u(SO(n).u)$ as well; substituting $W^*=\cos\varphi\,u+\sin\varphi\,V$ gives $\sin\varphi\,\langle V,[X,u]\rangle=0$, hence $V\perp T_u(SO(n).u)$ **provided $\sin\varphi\ne0$**. And $\langle V,u\rangle=0$ with $\lVert V\rVert=1$ is forced by $\lVert W^*\rVert=1$ together with $\cos\varphi=\langle W^*,u\rangle$, which is itself the metric commitment of §4.

**Verdict: the step is correct, and three of its hypotheses are unstated.**

- **Compactness of $SO(n)$** is what makes *"the nearest orbit point"* a definite article. The block asserts compactness of the unit sphere of $\mathrm{Weyl}_n$ and never of the group. *Charitable reading:* the orbit is a continuous image of a compact group, hence compact, hence the distance is attained, one clause the block does not write.
- **Smoothness of the orbit is not needed**, and this is worth stating positively rather than as a gap: the argument varies along $\exp(tX)u$, a smooth curve in the ambient space, so it needs the smoothness of the *action*, not of the orbit as a submanifold. The orbit is in fact a smooth compact homogeneous manifold ($SO(n)/\mathrm{Stab}(u)$) but nothing here consumes that.
- **$\varphi>0$** is required, and the dispatched text does not say so; see §5.

**No finding on the definition of $T_u(SO(n).u)$:** the block uses it as the image of $\mathfrak{so}(n)\to\mathrm{Weyl}_n$, $X\mapsto[X,u]$, which is the only reading under which $\dim=4n-14$ ([route-a.md](../findings/route-a.md):152) holds, and it is consistent throughout.

## 3. The two substituted bounds

### 3a. $\gamma_V\le m$, the bootstrap

**Is $V$ a unit Weyl operator?** Yes. $V=(W^*-\cos\varphi\,u)/\sin\varphi$ with $W^*,u\in\mathrm{Weyl}_n$ and $\mathrm{Weyl}_n$ a linear subspace, so $V\in\mathrm{Weyl}_n$; $\lVert V\rVert=1$ by the Pythagoras computation of §2. Hence $P(V)\le\max\{P(W):\lVert W\rVert=1\}$ **by the definition of the maximum**, and $\gamma_V=\sqrt{2/3}P(V)\le m$.

**Does it close rather than loop?** It closes. $m$ is a *number* (a finite attained maximum), not a bound being assumed. The chain is

$$m=\cos^3\varphi+3\cos\varphi\sin^2\varphi\,\alpha+\sin^3\varphi\,\gamma_V\ \le\ \cos^3\varphi+\cos\varphi\sin^2\varphi+m\sin^3\varphi=\cos\varphi+m\sin^3\varphi,$$

using $\alpha\le\tfrac13$ against the nonnegative coefficient $3\cos\varphi\sin^2\varphi$ and $\gamma_V\le m$ against the nonnegative $\sin^3\varphi$. Rearranging, $m(1-\sin^3\varphi)\le\cos\varphi$; since $\varphi<\pi/2$ gives $1-\sin^3\varphi>0$, this is $m\le\psi(\varphi)$ with the sense preserved. **A quantity bounded by a strictly increasing affine function of itself with slope $\sin^3\varphi<1$ yields a genuine bound; that is the whole mechanism, and it is sound.**

*The contrast the block draws is also right, and I checked it in the source.* Nienhaus's Theorem 4.17 ([nienhaus-2311.02404.txt](https://arxiv.org/abs/2311.02404):4698) estimates $\gamma$ from *"the fact that $f(\varphi)\le1$ on $[0,\pi]$"*, the a priori cap $P\le\theta^*$, available only where $u$ is already the global maximizer. Replacing that cap by $m$ is exactly what makes the argument survive past $n=11$.

**Verdict: CORRECT and non-circular.**

### 3b. $\alpha\le\tfrac13$, the input that is not proved

**The line.** *"The largest eigenvalue of $F_u$ on $u^\perp\cap T_u(SO(n).u)^\perp$ is $\tfrac13\theta^*$, so $\alpha\le1/3$; this is Nienhaus Theorem 4.14(c), valid for $n\ge9$ and reverified here from scratch."*

The arithmetic of the last clause is right: $\lambda_{\max}\le\tfrac13\theta^*$ gives $\alpha=\sqrt{2/3}\langle F_uV,V\rangle\le\sqrt{2/3}\cdot\tfrac13\sqrt{3/2}=\tfrac13$. The attribution is not.

**Discrepancy, located.** [route-a.md](../findings/route-a.md):115, the sentence quoted above.

**Discrepancy, exhibited, at the named source.** Nienhaus Theorem 4.14 ([nienhaus-2311.02404.txt](https://arxiv.org/abs/2311.02404):4365) reads *"For $n\ge9$ the eigenvalues of the map $F_{W_{\mathbb{CP}^2}}$ are given as follows"*, and clause **(c)** says only that a named subspace *"is an eigenvector of eigenvalue $\tfrac13\sqrt{\tfrac32}$"*. It is one eigenvalue on one subspace. Clause **(b)** carries the **larger** eigenvalue $\tfrac12\sqrt{3/2}$ on $\mathrm{Weyl}_4^{-,1}\oplus X_4^{-,2}\otimes\mathbb R^{n-4}$, and clause **(a)** carries $\sqrt{3/2}$ on $\langle u\rangle$. So the block's sentence needs two further things that 4.14(c) does not supply:

1. that (a)–(g) are **exhaustive**, so no larger eigenvalue hides outside the list; and
2. that **(b)'s eigenspace is exactly $T_u(SO(n).u)$**, so that intersecting with $T_u(SO(n).u)^\perp$ removes it.

Neither is in the block. **Nienhaus makes the same inference himself** at Theorem 4.17, *"Proposition 4.14 tells us that $\alpha\le\tfrac13$"*, for $W$ perpendicular to $\mathbb RW_{\mathbb{CP}^2}\oplus T_{W_{\mathbb{CP}^2}}(SO(n).W_{\mathbb{CP}^2})$, so the step is imported wholesale rather than invented here, and the missing clauses are missing in the source too.

**Discrepancy, the opposite argued.** The most charitable reading is that *"this is Nienhaus 4.14(c)"* names where the number $\tfrac13\theta^*$ comes from, not where the maximality claim comes from, and that the maximality is what *"reverified here from scratch"* refers to. That reading is available and I think it is what was meant. It does not rescue the block, for two reasons.

- **The reverification is [Lemma L21](../findings/route-a.md), which the block never names.** [results.md](../results.md):677 records this as a live defect in its own margin: *"the block cites Nienhaus 4.14(c) for a statement that is L21's verbatim, so citation is not dependency"*, and [route-a.md](../findings/route-a.md):93 says the omission *"is the root cause of four wrong descriptions in the canon, two of them written this session"*. A consumer reading the proof alone is sent to a source that does not carry the claim.
- **L21 does not close it either.** L21 supplies the missing clause 2 in the right form, *"the $\tfrac12$-eigenspace is the orbit tangent space, block by block"*, with $\dim T_u(SO(n).u)=2+4(n-4)=4n-14$ ([route-a.md](../findings/route-a.md):152), and its exhaustion gap is closed by the branching of [L21.lean](../lean/HamiltonsCubic/Results/L21.lean). **But the four $F_\lambda$ spectra that carry every nonzero eigenvalue are measurements.** [route-a.md](../findings/route-a.md):95 records them as *"verified in floating point at $n=12,14$ and exactly only at $n=6,8,10$"*, and [LEDGER.md](../findings/LEDGER.md) still lists as **Owed** *"the exact diagonalisation of the four rational $F_\lambda$ matrices, which retires L20's last unproved input under either reading"*. Both Lean rows for L20 close with **Owed**: *"the cubic expansion and $\alpha\le1/3$"*.

**Verdict: `HYPOTHESIS-DEBT`.** What would have to be shown, exactly: *the four rational matrices $F_\lambda$ of [Lemma L21](../findings/route-a.md)'s table have the stated spectra, by rank certificates $\dim\ker(F_\lambda-r\theta^*)$ over $\mathbb Q$ rather than by eigenvalue computation, together with a proof that their entries do not depend on $m=n-4$.* Until then $\alpha\le\tfrac13$ is an unproved hypothesis of L20 at every $n$ in L20's own range, and the words *"unconditional"* at [results.md](../results.md):48 and :232 overstate what is on file.

## 4. What is $d$?, pre-registered question 2

**The block writes $\varphi:=d(W^*,SO(n).W_{\mathbb{CP}^2})\le0.5748$ and never says what $d$ is, and [conventions.md](../findings/conventions.md) has no row for it.** I read the file's convention table end to end; the symbols $\theta_0(n)$, $\Theta_n$, $M(n)$, $\mathcal D_n$, $\mathfrak m$, $K$, $t$ all have rows, and no row fixes a metric on the unit sphere of $\mathrm{Weyl}_n$.

**What the proof's own expansion commits it to.** The block writes $W^*=\cos\varphi\,u+\sin\varphi\,V$ with $\lVert W^*\rVert=\lVert u\rVert=\lVert V\rVert=1$ and $V\perp u$. Taking the inner product with $u$ gives $\langle W^*,u\rangle=\cos\varphi$, so $\varphi=\arccos\langle W^*,u\rangle$, **the geodesic angular distance on the unit sphere of $\mathrm{Weyl}_n$ in the Frobenius inner product, minimised over the orbit.** There is no other reading under which the *same symbol* $\varphi$ can be both the distance and the expansion parameter. The commitment is forced, and it is nowhere written in the proof.

**Where it is stated on the record, and where it is not.**

| Site | What it says about the metric |
| --- | --- |
| [route-a.md](../findings/route-a.md):111, the canonical proof | nothing, bare $d$ |
| [route-a.md](../findings/route-a.md):101, the margin note above it | *"The geodesic reading is the one the proof establishes and is what this block means"* |
| [results.md](../results.md):673, the canonical statement | *"within angular distance $0.5748$"*, angular, not explicitly geodesic |
| [results.md](../results.md):232, the landscape one-liner | nothing, *"within $0.5748$ of the rival maximizer's orbit"* |
| [results.md](../results.md):48 | nothing |
| [conventions.md](../findings/conventions.md) | no row |
| [report/sections/90-appendix.tex](../report/sections/90-appendix.tex):295 | *"within angular distance $0.5748$"*; the proof at :299 uses bare $d$ |

**How the radius changes under a different reasonable reading.** The record works in Frobenius norms throughout, so the chord $\lVert W^*-g\cdot u\rVert$ is the reading a consumer is most likely to take. A chord of $0.5748$ is the angle $\varphi=2\arcsin(0.2874)$. By hand, with $x=0.2874$ and $x^2=0.08259876$:

$$\arcsin x=x+\tfrac{x^3}6+\tfrac{3x^5}{40}+\tfrac{15x^7}{336}+\tfrac{105x^9}{3456}+\cdots=0.2874+0.00395648+0.00014706+0.00000723+0.00000040=0.29151117,$$

so $\varphi=0.58302234$. At that angle $\cos\varphi=1-2x^2=0.83480248$ and $\sin\varphi=2x\sqrt{1-x^2}=0.5748\times0.95781053=0.55055$, so $\sin^3\varphi=0.16687$ and

$$\psi(\varphi)=\frac{0.83480248}{1-0.16687}=\frac{0.83480248}{0.83313}=1.002012>1 .$$

**Under the chord reading the proof draws no contradiction at its own stated radius, so the statement it proves is strictly weaker than the statement it makes.** The chord radius the geodesic result actually supports is $2\sin(\varphi_c/2)=0.56694$.

**The opposite argued.** Charitably, *"angular distance"* at [results.md](../results.md):673 is the canonical statement and it does say angular; the ambiguity is only in the proof block and in the two shorter citations. This is the best reading and it still leaves a real defect: [results.md](../results.md):232 is the line that gets cited, it carries no metric, and the difference between the two readings is the difference between a true statement and a false one. **Repair, one clause: write *"geodesic angular distance"* into [route-a.md](../findings/route-a.md):111 and add a $d$ row to [conventions.md](../findings/conventions.md).** [LEDGER.md](../findings/LEDGER.md) records this as validated on 2026-09-04 and says *"the block now says so"*; three days later [route-a.md](../findings/route-a.md):111 still reads bare $d$, and the sentence that says geodesic is a margin note two paragraphs above the proof.

**Non-vacuity depends on the same choice.** Geodesic diameter of the sphere is $\pi$, so $0.5748$ is $18.3\%$ of it; the tube is a genuine neighbourhood containing the orbit. That is the reading under which the lemma has content.

## 5. Quantifier order, scope, and the edge of every range

**Quantifier order, no finding, the logic is sound.** The block reads *"$m$ is attained, at some $W^*$. Suppose $\varphi:=d(W^*,\ldots)\le0.5748$"*, which selects one maximizer where the statement quantifies over all. It still proves the statement, because the contradiction it derives ($\max P\le\theta^*$ against a witness with $P>\theta^*$), **does not mention $W^*$**. So the hypothesis *"this maximizer is inside the tube"* is refuted for every maximizer alike. *A reader could mistake the existential for a scope restriction; nothing in the mathematics is wrong.*

**$n=12$ exactly.** $\theta_0(12)^2=2\cdot11\cdot10/144=220/144=55/36$ against $\theta^{*2}=3/2=54/36$: the margin is exactly $1/36$ in the square, and $\theta_0(12)>\theta^*$ holds. The stated threshold $n>6+2\sqrt7$ is the root of $n^2-12n+8>0$: $2(n-1)(n-2)/n^2>3/2\iff4(n^2-3n+2)>3n^2\iff n^2-12n+8>0$, roots $6\pm2\sqrt7$ with $2\sqrt7\in(5.29,5.30)$ since $5.29^2=27.98$ and $5.30^2=28.09$. So the threshold is $11.29\ldots$ and the least integer clearing it is $12$. **Correct, and the endpoint is in range.**

**$n=11$, the excluded endpoint.** $\theta_0(11)^2=180/121=1.4876<1.5$, so no contradiction is available and the lemma correctly does not claim $n=11$.

**$\varphi=0$.** The dispatched text ends at *"Therefore $\varphi>0.5748$. $\square$"* and **within that text the case $\varphi=0$ is uncovered**, the expansion has no $V$ there, and the first-variation step of §2 needs $\sin\varphi\ne0$. *The source file covers it one line past the quoted range*, at [route-a.md](../findings/route-a.md):121: *"there $W^*$ lies on the orbit, $\max P=\sqrt{3/2}$, and the same contradiction applies"*, which is correct, $P(u)=\theta^*$ by definition, so $\max P=\theta^*<\Theta_n$. **No finding against the record; a finding against the excerpt, which stops one line short of its own edge case.**

**$\varphi$ at the upper endpoint $0.5748$.** The interval is closed and $\psi(0.5748)<1$ strictly (§6), so the strict conclusion $\varphi>0.5748$ follows. **Correct.**

**Odd $n$.** §7.

## 6. The $\psi$ analysis, re-derived by hand

**The claim to check:** $\psi(\varphi)=\cos\varphi/(1-\sin^3\varphi)\le1$ on $[0,0.5748]$.

**Reduction to a cubic.** For $\varphi\in[0,\pi/2)$ put $s=\sin\varphi\in[0,1)$, $c=\cos\varphi=\sqrt{1-s^2}\ge0$. Since $1-s^3>0$,

$$\psi(\varphi)\le1\iff c\le1-s^3\iff c^2\le(1-s^3)^2\iff1-s^2\le1-2s^3+s^6\iff s^2\big(s^4-2s+1\big)\ge0\iff s^4-2s+1\ge0,$$

the squaring being an equivalence because both sides are nonnegative. And $s^4-2s+1=(s-1)(s^3+s^2+s-1)$, expand: $s^4+s^3+s^2-s-s^3-s^2-s+1=s^4-2s+1$. For $s\in[0,1)$ the factor $s-1$ is negative, so

$$\psi(\varphi)\le1\iff g(s):=s^3+s^2+s\le1 .$$

$g$ is strictly increasing on $[0,1)$, so $\psi\le1$ on $[0,\varphi]$ **iff** $\sin\varphi\le s^*$, the unique root of $g(s)=1$ there.

**Bracketing $s^*$ by hand.** $g(0.5436)=0.5436+0.29550096+0.16063432=0.99973528<1$ and $g(0.5437)=0.5437+0.29560969+0.16072299=1.00003268>1$, so $s^*\in(0.5436,0.5437)$. *This agrees with [TubeRadius.lean](../lean/HamiltonsCubic/Results/TubeRadius.lean)'s bracket $(0.5436890,0.5436891)$, which I did not need.*

**Is $0.5748$ inside?** By the Taylor series, with $x=0.5748$, $x^2=0.33039504$, $x^3=0.18991110$, $x^5=0.06274492$, $x^7=0.02073079$:

$$\sin x=x-\tfrac{x^3}6+\tfrac{x^5}{120}-\tfrac{x^7}{5040}+\cdots=0.5748-0.03165185+0.00052287-0.00000411+0.00000002=0.54366693 .$$

Then $g(0.54367)=0.54367+0.29557707+0.16069639=0.99994346<1$, and $g$ is increasing with $0.54366693<0.54367$, so $g(\sin0.5748)<1$. **Hence $\psi\le1$ on all of $[0,0.5748]$, and $\psi(0.5748)<1$ strictly.** Evaluating: $\sin^3(0.5748)=0.16069373$, $\cos(0.5748)=\sqrt{1-0.29557381}=0.8393010$, so

$$\psi(0.5748)=\frac{0.8393010}{1-0.16069373}=\frac{0.8393010}{0.83930627}=0.9999937 .$$

**The load-bearing conclusion is correct.** The radius is the root of $\sin^3\varphi=1-\cos\varphi$ truncated downwards, so the interval sits strictly inside the safe region, conservative in the right direction.

### Discrepancy 1, the block's own sentence contradicts itself

**Located.** [route-a.md](../findings/route-a.md):119: *"On $[0,0.5748]$ one has $\psi\le\psi(0)=1$: $\psi$ falls to $0.9787$ near $\varphi=0.3927$ and rises again, **first exceeding $1$ at $\varphi=0.5748$**."*

**Exhibited.** At $\varphi=0.5748$ the two halves of the sentence disagree. The first says $\psi\le1$ on the closed interval whose right endpoint is $0.5748$; the second says $\psi>1$ there. The computation above settles it: $\psi(0.5748)=0.9999937<1$, and the crossing is at $\varphi_c=\arcsin s^*$, which exceeds $0.5748$ by $(s^*-\sin0.5748)/\cos0.5748\approx2.2\times10^{-5}/0.83930\approx2.6\times10^{-5}$, i.e. $\varphi_c\approx0.5748263$.

**The opposite argued.** *"First exceeding $1$ at $0.5748$"* can be read as *"first exceeding $1$ at about $0.5748$"*, which is true to four places, and the block's constant is deliberately the truncation. That reading is available and is plainly what was meant. **The candidate survives anyway**, because the number $0.5748$ is not an approximation here, it is the statement's radius, quoted fifteen times across the record, and the sentence asserts a strict inequality *at* it that is false. The right sentence is *"$\psi\le1$ on $[0,\varphi_c]$ with $\varphi_c=0.5748263$, and $0.5748$ is $\varphi_c$ truncated"*. **Impact: none on the conclusion**, since truncation errs safely.

### Discrepancy 2, the minimiser is misidentified

**Located.** The same line: *"$\psi$ falls to $0.9787$ near $\varphi=0.3927$"*.

**Exhibited.** $0.3927$ is $\pi/8$. Differentiating, $\psi'$ has numerator $-s+s^4+3s^2c^2=-s+s^4+3s^2(1-s^2)=s(-1+s^3+3s-3s^3)=-s(2s^3-3s+1)=-s(s-1)(2s^2+2s-1)$, so the interior critical point is at $2s^2+2s-1=0$, i.e. $s=\tfrac{\sqrt3-1}2=0.3660254$, not $\sin(\pi/8)=0.3826834$. There $c=\sqrt{1-0.1339746}=0.9306049$ and $s^3=0.04903810$, giving $\psi=0.9306049/0.95096190=0.978595$, against $\psi(\pi/8)=0.9238795/(1-0.05603553)=0.978721$. The minimiser is $\arcsin\tfrac{\sqrt3-1}2=0.374734$.

**The opposite argued.** The word is *"near"*, and $0.9787$ is indeed the value at $0.3927$ to four places. The sentence is defensible if *"falls to $0.9787$ near $\varphi=0.3927$"* is read as *"takes the value $0.9787$ near $0.3927$"* rather than *"attains its minimum $0.9787$ at $0.3927$"*. **The candidate is downgraded to cosmetic on that reading, and I record it as cosmetic**, the minimum is a datum nothing consumes, and the exact minimiser $\arcsin\tfrac{\sqrt3-1}2$ is a closed form the block could carry instead of a decimal.

## 7. Does the final step hold at odd $n$?, pre-registered question 3

**The last inequality is $m\le1$, i.e. $\max P\le\theta^*=\sqrt{3/2}$. The object it needs is a unit Weyl operator with $P>\sqrt{3/2}$ at the dimension in question.** The block names one: *"the balanced sphere product … with $P=\theta_0(n)$"*.

**Discrepancy 3, that object does not exist at odd $n$.**

**Located.** [route-a.md](../findings/route-a.md):119, and identically at [results.md](../results.md):673 (*"contradicting the value $\theta_0(n)>\theta^*$ the sphere product attains"*) and [report/sections/90-appendix.tex](../report/sections/90-appendix.tex):308.

**Exhibited, at $n=13$, against a source on file.** Nienhaus Proposition 2.25 ([nienhaus-2311.02404.txt](https://arxiv.org/abs/2311.02404):1483) gives, for $S^k\times S^l$ with $k+l=n$,

$$P(W_{S_{k,l}})=\theta_{k,l}=\sqrt2\sqrt{\tfrac{k-1}k\cdot\tfrac{l-1}l\cdot\tfrac{n-1}{n-2}} .$$

At even $n$ with $k=l=n/2$ this is $\tfrac{\sqrt2}n\sqrt{(n-1)(n-2)}=\theta_0(n)$, so the block's witness is right there. At odd $n$ there is **no** balanced split; the best is $k=\tfrac{n-1}2$, $l=\tfrac{n+1}2$, giving

$$\theta_{k,l}^2=2\cdot\frac{n-3}{n-1}\cdot\frac{n-1}{n+1}\cdot\frac{n-1}{n-2}=\frac{2(n-1)(n-3)}{(n+1)(n-2)}=\Theta_n^2,$$

exactly [conventions.md](../findings/conventions.md):19's odd-$n$ $\Theta_n$. At $n=13$: $\Theta_{13}^2=2\cdot12\cdot10/(14\cdot11)=240/154=120/77=1.5584416$, so $\Theta_{13}=1.2483756$, while $\theta_0(13)^2=2\cdot12\cdot11/169=264/169=1.5621302$ and $\theta_0(13)=1.2498520$. **The two differ, and it is $\Theta_{13}$ that is attained.** Nienhaus's own text corroborates at $n=11$: he records $P(W^{\mathrm{crit}}_{\mathrm{sym},11})=2\sqrt{30}/9=1.217161239$, and $\Theta_{11}^2=2\cdot10\cdot8/(12\cdot9)=160/108=40/27$ gives $\Theta_{11}=\sqrt{40/27}=1.2171612$, against $\theta_0(11)=\sqrt{180}/11=1.2196729$. **So at odd $n$ the block's final sentence names a value no Weyl operator has.**

**The opposite argued.** The most charitable reading is that *"the balanced sphere product"* means *"the most nearly balanced sphere product"* and $\theta_0(n)$ is a slip for its value. That reading rescues the *conclusion* and not the *sentence*, and it cannot be reached from the block alone, because the block's own opening line defines $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ explicitly. **The candidate stands.**

**Does the conclusion survive?** Yes, and by an argument that is on the record though not in this block. $\Theta_n^2>3/2$ reads $2(n-1)(n-3)/((n+1)(n-2))>3/2$, i.e. $4(n^2-4n+3)>3(n^2-n-2)$, i.e. $n^2-13n+18>0$, with roots $(13\pm\sqrt{97})/2$ and $\sqrt{97}\in(9.84,9.85)$ since $9.84^2=96.8256$ and $9.85^2=97.0225$, so the upper root is $11.42\ldots$ and every integer $n\ge12$ clears it. At $n=11$ the polynomial is $121-143+18=-4<0$; at $n=13$ it is $169-169+18=18>0$. **So a witness exists at odd $n\ge13$ and the lemma's stated range is correct.** This is [problem.md](../findings/problem.md):469 and [OddWitness.lean](../lean/HamiltonsCubic/Results/OddWitness.lean); it is **absent from [route-a.md](../findings/route-a.md), which is the canonical proof, and from [results.md](../results.md):673, which is the canonical statement.**

*Note the threshold is reached by a different polynomial.* $n^2-13n+18$ against the block's $n^2-12n+8$, differing by $10-n$, discriminants $97$ against $112$. The block's *"exactly when $n>6+2\sqrt7$"* is the $\theta_0$ threshold and does not govern the odd-$n$ case; the two happen to give the same integer cut.

## 8. Comparing the forms

| Site | Form | What it says, and what it omits |
| --- | --- | --- |
| [route-a.md](../findings/route-a.md):89, heading | *"no maximizer lies near the rival maximizer's orbit, for every $n\ge12$"* | **no radius, no metric.** The block is headed *canonical statement and proof* and carries a notation line plus the proof; $0.5748$ appears only inside the supposition *"Suppose $\varphi\le0.5748$"*, so the file that owns the proof never states the theorem |
| [route-a.md](../findings/route-a.md):109–121, proof | full argument | bare $d$; $\theta_0(n)$ witness; covers $\varphi=0$ |
| [results.md](../results.md):232, landscape one-liner | *"No maximizer lies within $0.5748$ of the rival maximizer's orbit, for every $n\ge12$. Proven unconditionally by bootstrap"* | **no metric**, and *"unconditionally"* unqualified. This is the citable line |
| [results.md](../results.md):48 | *"Lemma L20 closes the tube itself unconditionally for $n\ge12$"* | no radius, no metric, *"unconditionally"* unqualified |
| [results.md](../results.md):673, canonical statement | *"within angular distance $0.5748$"*, with the $\theta_0(n)$ witness | **the only site carrying a metric word**; carries the odd-$n$ defect |
| [problem.md](../findings/problem.md):469, second copy | compressed proof | **carries the odd-$n$ repair inline**, with $n^2-13n+18>0$ and a pointer to [OddWitness.lean](../lean/HamiltonsCubic/Results/OddWitness.lean) |
| [report/sections/90-appendix.tex](../report/sections/90-appendix.tex):295–308 | *"For every $n\ge12$, with no parity restriction,"*, then the $\theta_0(n)$ witness | **states the parity claim and then proves it with the object that does not exist at odd $n$**; the sharpest form of the defect |
| [L20.lean](../lean/HamiltonsCubic/Results/L20.lean), [lean/INDEX.md](../lean/INDEX.md):227 | **proved** | the radius as $\arcsin$ of the root of $s^3+s^2+s=1$, and the odd-$n$ witness under $\Theta_n$. **Owed**: *"the cubic expansion and $\alpha\le1/3$"* |
| [OddWitness.lean](../lean/HamiltonsCubic/Results/OddWitness.lean), [lean/INDEX.md](../lean/INDEX.md):228 | **proved** | $n^2-13n+18>0$ at $n\ge12$. **Owed**: the same two |
| [TubeRadius.lean](../lean/HamiltonsCubic/Results/TubeRadius.lean), [lean/INDEX.md](../lean/INDEX.md):98 | **partial** | the cubic, its unique root, its irrationality. **Owed**: that $\varphi=\arcsin s^*$, and the expansion |
| [TubeInputs.lean](../lean/HamiltonsCubic/Results/TubeInputs.lean), [lean/INDEX.md](../lean/INDEX.md):50 | **proved** | that $9<12$, so Nienhaus's $n\ge9$ never binds. **Not claimed**: L21's argument, or Nienhaus's theorem |

**A Lean row does exist**, three of them, and together they cover the radius and the odd-$n$ threshold. **What no Lean row claims is the analytic core**: the cubic expansion and $\alpha\le\tfrac13$ are marked *Owed* in both L20 rows, which is the honest placement. *A row that closed L20 would have to claim the exact spectra of the four $F_\lambda$ matrices, and none does.*

**Two forms disagree with each other.** [results.md](../results.md):673 says *"angular distance"*; [results.md](../results.md):232 and :48, the two shorter and more-cited forms, say nothing. And [report/sections/90-appendix.tex](../report/sections/90-appendix.tex):295 asserts *"with no parity restriction"* thirteen lines above a proof step that has one.

## 9. The named trap, reading each citable claim alone

**This record's signature failure is a correction landing beside the statement it corrects. I read each citable form with nothing else in view.** Three inherit a defect.

**Trap 1, [route-a.md](../findings/route-a.md):35 announces the repair and the repair is not there.** The file's own corrections list reads: *"4. **The parity restriction is unnecessary.** Odd $n\ge13$ also clears $\sqrt{3/2}$ … so Lemma L20 holds for **all** $n\ge12$, using $\max_p P(S^p\times S^{n-p})$ in place of $\theta_0(n)$. Applied throughout."* At line 119 of the same file the proof still reads $\theta_0(n)$. **The correction was recorded as applied and was not applied**, and the audit of 2026-09-04 said so ([REVIEW_r484.md](../reviews/REVIEW_r484.md):165 names the three files); three days later all three still carry it. A reader who trusts *"Applied throughout"* will not check.

**Trap 2, [results.md](../results.md):232 says *"Proven unconditionally"* and the qualification is 443 lines away.** The margin at [results.md](../results.md):675 does record *"NOT INPUT-COMPLETE … $\alpha\le\tfrac13$ rests on four $F_\lambda$ spectra tabulated at $n=10,12,14$ and asserted stable beyond"*. A consumer citing the landscape line at :232 (which is where the record's own summary of the programme lives), sees *"Proven unconditionally by bootstrap"* and nothing else. **The same at :48.**

**Trap 3, the metric.** [LEDGER.md](../findings/LEDGER.md)'s L20 entry says *"The geodesic reading is what the proof establishes, and the block now says so."* The block does not say so; a margin note above the block says so. **The correction landed beside the proof, in the register that a citation does not carry.**

**No finding on one thing the trap would predict.** The block's claim *"does not rest on Lemma L22"* ([results.md](../results.md):48) is **true**: I read the proof line by line and it invokes no L22, no [Observation L102](../findings/route-a.md), and no a priori cap $P\le\theta^*$. *That negative is the one this record has repeatedly got wrong in the other direction, and the current form has it right.*

## 10. What would break the statement, and what I did to look for it

**The object that would falsify Lemma L20 is a unit Weyl operator $W$ with $P(W)=\max P$ and $\arccos\max_{g}\langle W,g\cdot u\rangle\le0.5748$**, a global maximizer inside the geodesic tube. By §6 such an object forces $\max P\le\theta^*$, so equivalently: **a dimension $n\ge12$ at which $\max P=\theta^*$, i.e. at which the padded $W_{\mathbb{CP}^2}$ is still globally maximal.** That is refuted at even $n$ by the balanced sphere product and at odd $n$ by the near-balanced one, both attaining $\Theta_n>\theta^*$, the arithmetic of §7.

**Where I looked.** Along the one edge where the chain is not robust: $\alpha\le\tfrac13$ is sharp, and [route-a.md](../findings/route-a.md):99 records that the radius degenerates to zero at $\alpha=\tfrac12$. So a falsifier of the *radius* (not of the lemma), is **a unit $V\perp u$, $V\perp T_u(SO(n).u)$, with $\sqrt{2/3}\langle F_uV,V\rangle>\tfrac13$**. Nienhaus Theorem 4.14's clauses (a)–(g) as printed leave the eigenvalue $\tfrac12\theta^*$ on clause (b)'s space $\mathrm{Weyl}_4^{-,1}\oplus X_4^{-,2}\otimes\mathbb R^{n-4}$, so **any vector of that space lying outside $T_u(SO(n).u)$ would be exactly such a falsifier.** I checked the two spaces against each other by the record's own dimension count, $\dim T_u(SO(n).u)=\binom n2-\binom{n-4}2-4=4n-14$ and $\dim\big(\mathrm{Weyl}_4^{-,1}\oplus X_4^{-,2}\otimes\mathbb R^{n-4}\big)=2+4(n-4)=4n-14$, and they agree at every $n$. **No falsifier there**, and this is the step the record supplies at [route-a.md](../findings/route-a.md):152.

**Where a falsifier could still be.** Not in the geometry but in the arithmetic that has never been done exactly: **an entry of one of the four $F_\lambda$ matrices that depends on $m=n-4$**, which would let $\lambda_{\max}$ drift above $\tfrac13\theta^*$ at some $n$ beyond the two floating-point checks. **Finding it, or ruling it out, is a computation, and this brief is analysis-only**, the run would be an exact rational diagonalisation of four fixed matrices with rank certificates per claimed eigenvalue, and a degree bound in $m$. *If the spectra hold, $\alpha\le\tfrac13$ is proved and L20 becomes unconditional in the full sense; if any entry moves with $m$, the radius $0.5748$ is wrong at large $n$ while the lemma's qualitative content survives for any $\alpha$-bound below $\tfrac12$.* **I opened no such run and state its two outcomes rather than guessing between them.**

## Verdict

**`HYPOTHESIS-DEBT`.**

**What is proved.** Compactness, the first-variation orthogonality, the exactness of the cubic expansion and the vanishing of its linear term, the bootstrap $\gamma_V\le m$ and its non-circularity, the reduction $m\le\psi(\varphi)$, and $\psi\le1$ on $[0,0.5748]$, all re-derived here from the definitions, with the radius identified as the root of $s^3+s^2+s=1$ under $\arcsin$.

**What is owed, named exactly.** *That the four rational matrices $F_\lambda$ of [Lemma L21](../findings/route-a.md)'s table have the tabulated spectra, by rank certificates over $\mathbb Q$, and that their entries do not depend on $m=n-4$.* Until that is on file, $\alpha\le\tfrac13$ is a hypothesis of Lemma L20, the citation to Nienhaus 4.14(c) does not discharge it, and *"unconditional"* at [results.md](../results.md):48 and :232 claims more than the record holds.

**Three repairs, each one clause.**

1. **[route-a.md](../findings/route-a.md):119 and [results.md](../results.md):673**, replace *"the balanced sphere product … with $P=\theta_0(n)$"* by *"the most nearly balanced sphere product, with $P=\Theta_n$"*, and note $n^2-13n+18>0$ for $n\ge12$. [report/sections/90-appendix.tex](../report/sections/90-appendix.tex):308 needs it too. *The corrections list at [route-a.md](../findings/route-a.md):35 already says this was done.*
2. **[route-a.md](../findings/route-a.md):111**, write *"geodesic angular distance"* for $d$, and give $d$ a row in [conventions.md](../findings/conventions.md). Under the chord reading the stated radius is false, with $\psi=1.002012$ there.
3. **[results.md](../results.md):232 and :48**, qualify *"unconditional"* as *"free of circular inputs"*, which is what [results.md](../results.md):675 already says in the margin and what the two citable lines do not.

**And one sentence to fix in place:** [route-a.md](../findings/route-a.md):119's *"first exceeding $1$ at $\varphi=0.5748$"* contradicts the same sentence's *"$\psi\le1$ on $[0,0.5748]$"*; the crossing is at $0.5748263$, and $0.5748$ is that truncated.
