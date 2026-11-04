# REVIEW r479, Lemma L52, "the two spectra do not couple usefully through a shared frame"

**Verdict: REFUTED as headed and as canonised; the inequality inside it is CONFIRMED and is redundant with [Lemma L54](../results.md).**

Reviewer r479, adversarial audit, analysis only (no computation run; two hand screens are marked as such). Target: [findings/bispectral.md](../findings/bispectral.md) `#### Lemma L52`, and its canon copy at [results.md](../results.md) `##### Lemma L52`.

## Summary of findings

| # | finding | severity |
| --- | --- | --- |
| 1 | The block **does** contain a displayed inequality and an argument, it is not one of today's heading-without-proof cases. But the heading states a universal negative that the argument never addresses. | context |
| 2 | **The heading is refuted on its own page.** The boxed cap $\mu\le\sqrt{2(n-2)/(n-1)}$, four screens below in the same file, *is* a coupling of the two spectra through a shared frame, it is proved, and the record calls it "the deliverable" and the proof of the second-kind projection estimate. | **fatal to the heading** |
| 3 | The equality case is already [Lemma L54](../results.md), by a two-line argument, and L54 additionally identifies the condition with $t_F=2$. L52's contribution over L54 is the displayed bound alone. | duplication |
| 4 | L52's equality condition is stated as a **conjunction** of two diagonalities. Each half **separately** forces $t_F=2$ and hence the other, so it is one condition, not two. | statement defect |
| 5 | The canon entry ([results.md](../results.md)) carries the negative **title** over a body that proves only a positive. Every word supporting the title (the comparisons it loses to), is dropped there. | **canon defect** |
| 6 | By the record's own taxonomy ([routes.md](../routes.md), line 3: a fence post is "a proven negative"), the heading is a fence post and the body is a lemma. It is filed as a Lemma with no clearance criterion; the criterion exists only in [routes.md](../routes.md)'s R9 row. | label |
| 7 | Inputs are clean: L50 (audited), Schur, Karamata/HLP, NPW Prop 3.10, $t\le2$. Nothing rests on an Observation or a Conjecture. The one-line rival bound $\tfrac32(M_++m)$ is **provable in two lines** (re-derived here) so the "beaten by" half needs no numerics at all. | confirms |

---

## 1. What is actually proved, against what the heading promises

Unlike the results withdrawn today, this block is not empty: it carries a displayed inequality

$$\theta\ \le\ \tfrac32\big[p_3(K)+3M_+(1-p_2(K))\big]-\tfrac12\big[p_3(K')+3m(p_2(K')-3)\big]$$

and a real argument for it. **I checked the derivation and it is correct.** $f(t)=t^3+3mt^2$ has $f''=6(t+m)\ge0$ on $[-m,\infty)$; $K'\prec\omega$ and every $K'_i\ge\lambda_{\min}(\mathring W)\ge-m$, so Karamata gives $\sum f(K')\le\sum f(\omega)$, i.e. $p_3(\omega)\ge p_3(K')+3m(p_2(K')-3)$ using $p_2(\omega)=3$. Symmetrically $g(t)=t^3-3M_+t^2$ has $g''=6(t-M_+)\le0$ on $(-\infty,M_+]$, and $K\prec\mu$ with $K_i\le\lambda_{\max}(M)\le M_+$ gives $p_3(\mu)\le p_3(K)+3M_+(1-p_2(K))$. Substituting into [L50](../findings/bispectral.md)'s $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ gives the display. The domain hypotheses Karamata needs are met on both sides, and the majorizations are between equal-length vectors ($\binom n2$ and $\dim S^2_0$).

**So the block proves: one inequality, and its equality case.** The heading promises: *no* shared-frame coupling of the two spectra is useful. That is a completeness claim over a class, and the class is never enumerated. What the block enumerates is one member of it, Schur majorization of the shared diagonal, convexified so that $p_3$ transfers.

The gap is not rhetorical. The block itself names members of the class it leaves untouched: *"only **Schur's** half of Schur–Horn is used, not Horn's"*, and *"it loses exactly the off-diagonal mass"*. A coupling that discards the off-diagonal entries of both operators in the shared frame has not shown that the shared frame is barren; it has shown that its own diagonal is.

## 2. The heading is refuted by a result on the same page, and that result is load-bearing

A negative of this shape is refuted by one coupling. There is one, and it did not have to be constructed: it is [findings/bispectral.md](../findings/bispectral.md)'s own boxed result, under "Both-sided Schur–Horn and the vertex-matrix budget are the SAME wall".

Let $h$ be the unit bottom eigenvector of $\mathring W$ on $S^2_0$. Every traceless symmetric $h$ is diagonal in **its own** eigenframe $F$, so $h=\mathop{\mathrm{diag}}(v)$ there, and

$$\langle\mathring Wh,h\rangle=-v^{\mathsf T}K^Fv,\qquad\text{whence}\qquad -\omega_{\min}=v^{\mathsf T}K^Fv\le\mu_1(K^F)\le\sqrt{\tfrac{t_F(n-2)}{n-1}}\le\sqrt{\tfrac{2(n-2)}{n-1}}=\frac{n\,\theta_0(n)}{n-1}.$$

Read what that chain is made of. $K^F$ is *exactly the object L52 couples through*, [Lemma L54](../results.md) proves $K$ is simultaneously the $\varphi$-diagonal of $M$ on $\Lambda^2$ and the $\varphi$-diagonal of $\mathring W$ on $S^2_0$. The cap $t_F\le2$ is the $\Lambda^2$-side normalisation $\sum\mu^2=1$ pushed through Cauchy–Schwarz. So the chain runs **$\mu$-side budget $\to$ shared frame $\to$ $\omega$-spectrum**, which is the definition of a shared-frame coupling of the two spectra, and it delivers a bound that is *exactly the target value at even $n$*. The file says so itself, in bold: *"So the vertex matrix is not a dead end here (it **PROVES** the projection estimate"*), the half of the dichotomy chain [target.md](../findings/target.md) leans on.

**A shared frame therefore couples the two spectra usefully enough to prove one of the programme's two standing estimates.** The heading, as a statement about shared frames, is false. What is true is narrower and must be written: *the shared-frame diagonal does not transfer $p_3$ usefully*. The difference is the difference between a route and one bound on that route, and it matters for the reason the file already gives about post F33, a later cycle told the shared frame is barren will not look here, and the thing it will not find is a proof the programme uses.

The same error propagates one level up. [routes.md](../routes.md) marks route **R9**, *"couple $\mu$ and $\omega$ through a shared frame (Schur–Horn)"*, **closed**, with L52 as the whole of the "what happened" cell. R9's mechanism produced the projection-estimate proof; a route register that reports it as closed with nothing recovered is wrong about its own history.

## 3. The equality case is L54's, by a shorter argument, and the record says so

[Lemma L54](../results.md) (*"the two diagonals, and rigidity at $t=2$"*, canonised, one entry below L52), states: $\sum d_\varphi^2=t/2$ and $\sum d^2=\tfrac32t$ for the full $S^2_0$ diagonal; $t\le2$ with equality iff $W$ is coordinate-diagonal in some frame; so at $t=2$ majorization has equal sums **and** equal norms on both sides, forcing $\mu=d_\varphi$ and $\omega=d$ outright. Its closing clause is, verbatim, *"the shared-frame coupling of Lemma L52 is an identity exactly on the diagonal family."*

That is L52's equality case, obtained without Karamata, without strict convexity, and without the support constants $m$ and $M_+$, and it locates the condition in the record's own sweep coordinate $t$. It is also the equality case of [Lemma L94](../findings/bispectral.md) ($\kappa^2\le2\lVert M\rVert_F^2$, equality iff coordinate-diagonal in some frame) seen from the other side.

**What L52 owns over L54 is the displayed bound and nothing else.** Its "exact if and only if" clause is a third copy of one fact.

## 4. The equality condition is one condition, written as two

L52 says the bound is exact *"if and only if **both** operators are diagonal in one shared frame"*. Each half forces the other, by L54's algebra plus $t\le2$:

- **$\omega$-side alone.** Karamata equality for the strictly convex $f$ forces $K'=\omega$ as multisets, so $\sum(K')^2=\sum\omega^2=3$. But $\sum(K')^2\le\tfrac32t$ identically (L54: $t/2$ from the $\varphi$-block, at most $t$ from the $\psi$-block, which is $-K|_{\mathbf 1^\perp}$). Hence $t\ge2$, so $t=2$, so $W$ is coordinate-diagonal, and then $K=\mu$ automatically.
- **$\mu$-side alone.** $K=\mu$ as multisets gives $\sum K^2=\sum\mu^2=1$, i.e. $t/2=1$, so again $t=2$.

*(Screen: this is hand algebra on the record's own identities, no computation run.)*

So the condition is $t_F=2$, full stop. Writing it as a conjunction of two diagonalities suggests a reader must check two independent things and that the two could come apart. They cannot.

**A second, smaller defect in the same sentence.** $K'$ is introduced as *"the full $\mathring W$ diagonal"* in the frame, but the frame of $\mathbb R^n$ does not determine it. The $\psi$-block basis is a further $O(n-1)$ of choice, worth $0.61$ at padded $W_{\mathbb{CP}^2}$ by the file's own measurement, and the earlier discussion in [bispectral.md](../findings/bispectral.md) says so and says the diagonalising choice is the optimal one. The canonical block, which announces that it *"stands alone"*, drops that. As written, $K'$ is undefined; under the reading "any $\psi$-basis" the "iff" is false, and only under "the $\psi$-basis diagonalising $K$" is it true.

## 5. The canon carries the title over a body that proves the opposite kind of thing

[results.md](../results.md)'s L52 entry is headed *"the two spectra do not couple usefully through a shared frame"* and its body is: the two diagonal identities, Schur, the convexification, the display, and the equality case. **Nothing in it argues the title.** Every sentence that does argue it, the identity-on-the-diagonal-family cost, the $3.9804$ against the one-line $2.4495$ and post F33's $2.3779$, the $5.5901$ with constants an argument may use, lives only in [findings/bispectral.md](../findings/bispectral.md).

A reader of the canon meets a lemma titled "do not couple" whose proof establishes a coupling. That is the same defect as the withdrawn heading-promises-a-bound cases, with the polarity reversed.

## 6. Is it vacuous? No, but it is a route verdict wearing a Lemma's number

The "would this be vacuous?" test passes. Route R9 was genuinely attempted; the bound is a real inequality; the exactness is a real rigidity. And the "beaten by" half is not a soft numerical impression, it is a witness argument, which one point suffices for.

**I re-derived the rival bound analytically and it holds**, so this half needs no numerics: from $\mu_i\le M_+$, $\mu_i^3\le M_+\mu_i^2$, so $p_3(\mu)\le M_+$; from $\omega_i\ge-m$, $-\omega_i^3\le m\omega_i^2$, so $-p_3(\omega)\le 3m$; hence $\theta\le\tfrac32(M_++m)$. L52's elaborate bound consumes **the same two constants** and returns a worse number at the record's witness. That is a clean, checkable refutation of usefulness *for this bound*.

But that is what a fence post is. [routes.md](../routes.md) defines the taxonomy itself: *"a **fence post** (a proven negative)"*, distinct from a route and from an attempt. The negative here is proven only about one bound, and it should be filed as such, with the clearance criterion that currently exists nowhere in [findings/](../findings/), only in [routes.md](../routes.md)'s R9 row (*"couple the two spectra by something that is not sharp exactly where the conjecture is granted"*).

## 7. Inputs, and one stale supporting line

**The bound's inputs are clean.** [L50](../findings/bispectral.md) (audited, confirmed); Schur's theorem; Karamata/Hardy–Littlewood–Pólya with its equality case; [NPW Prop 3.10](../references/nienhaus-petersen-wink-2022-betti-second-kind/notes.md) for $\langle\mathring W\varphi_{ij},\varphi_{ij}\rangle=W_{ijij}$; $t\le2$ from [conventions.md](../findings/conventions.md). No Observation and no Conjecture in the chain, the Lemma is a Lemma on that count.

**One supporting line in the same file is stale and cuts against L52's "cost" argument.** Under "The joint relaxation: what survives Gate 2", bispectral.md asserts *"the 'granted case' is not granted at the dimensions in play. Jäger's theorem covers even $n\ge16$. At $n=12,14$ the $t=2$ end reduces to the **open** diagonal problem."* That is superseded: [Lemma L57](../results.md) settles the diagonal case *"at every $n\ge4$, both parities, with its equality case"*, on the record's own proof rather than on Jäger. So L52's *"precisely where the conjecture is already granted"* is correct, but it is correct via L57, and the file simultaneously denies it. **This is a live internal contradiction in [findings/bispectral.md](../findings/bispectral.md), independent of L52's fate.**

## 8. Uses, and whether they stay inside the hypotheses

| citation | use | inside hypotheses? |
| --- | --- | --- |
| [results.md](../results.md) L52 (canon) | the bound and its equality case | yes for the body; **the title is not supported by it** |
| [results.md](../results.md) summary line | "identity on the diagonal family, off it loses to a one-line estimate" | yes |
| [routes.md](../routes.md) R9 | closes the whole shared-frame route | **no**, see §2 |
| [reviews/ELIM-canon.md](ELIM-canon.md) | "the **obvious** coupling to it is inert" | yes, the qualifier is exactly right |
| [reviews/ELIM-stratum.md](ELIM-stratum.md) | quotes it as corrected, "inert rather than absent" | yes |
| [reviews/2026-09-02-step8-position.md](2026-09-02-step8-position.md) | R9 closure line | inherits R9's overreach |
| [findings/INDEX-results.md](../findings/INDEX-results.md) row 52 | "Lemma, (the two spectra do not couple usefully…)" | carries the unsupported title into the index |

The two ELIM files are the only citations that state it correctly, and both do it by adding a qualifier the lemma's own title lacks.

## What I would have the record do

1. **Retitle.** *"The shared-frame diagonal does not transfer $p_3$ usefully"*, or *"Post F5x, the shared-frame majorization transfer of $p_3$ is inert"*. Any title asserting the shared frame is barren is false while §2's boxed cap stands.
2. **Split the label.** The displayed inequality plus its equality case is the Lemma. The verdict that it loses to $\tfrac32(M_++m)$ and to post F33 is a fence post, and needs a clearance line in [findings/](../findings/), not only in [routes.md](../routes.md).
3. **Cut the equality case to a citation of [L54](../results.md)**, stating the condition as $t_F=2$ (one condition) and defining $K'$ with its $\psi$-basis.
4. **Reopen or annotate R9** in [routes.md](../routes.md): the route produced the projection-estimate proof, and the register says it produced nothing.
5. **Repair the stale "not granted at $n=12,14$" line** in [findings/bispectral.md](../findings/bispectral.md) against [Lemma L57](../results.md).
6. **Carry the "beaten by" comparison into [results.md](../results.md)**, or drop the negative from the canon title. As it stands the canon asserts a negative it does not argue.

## What I did not do

No computation was run. The two derivations marked as screens (§4's $t_F=2$ collapse, §6's $\tfrac32(M_++m)$) are hand algebra on identities already in the record, and are offered as arguments a reader can check rather than as measurements. I did not read [reviews/REVIEW_r480.md](REVIEW_r480.md), nor anything in [references/](../references/) beyond `notes.md` files.
