# Step 8 position file, 2026-09-03

*Written at the head of the sweep, per [Phase 2](../.claude/skills/research-loop/SKILL.md). It names what is open, what fences it, and what the previous sweep already covered.*

## 1. The goal, and what stands between

[Conjecture A](../README.md) at $n\ge12$, granting the diagonal case, which [Lemma L57](../findings/problem.md) proves at every $n\ge4$, both parities. **The whole remaining problem is the non-diagonal half**: $\sup\{\theta:Q(W)=\theta W,\ S=0,\ W\text{ non-diagonal}\}\le\sqrt{3/2}$.

## 2. The two open statements a sweep should carry

Phrased in their own objects, not this record's vocabulary, *the last sweep searched route names and plan items and found nothing.*

> **(A) Positivity of one pairing in the $\#$-calculus.** For $A=W_+\#W_-\succeq0$ and $B=\mathrm{Ric}^*(\mathrm{Ric}(|W|))\succeq0$ on $\Lambda^2\mathbb R^n$, when is $\langle 2A-\theta W_--W_-^2,\ B\rangle\ge0$ at a critical point of $\langle W,W^2+W^\#\rangle$? *Known*: it holds whenever $[B,W]=0$, which isotropy gives at every named point; the operator form $2A\succeq\theta W_-+W_-^2$ is **false** at an $n=5$ critical point; a gap-commutator certificate covers every non-commuting point found but two.
>
> **(B) A two-regime comparison.** [Conjecture L16](../findings/problem.md): $P(W)\le\theta_0(n)+\kappa_n\delta^2$ with $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$. Granting (A), every critical point clearing the threshold has scalar curvature $\ge(n+1)\tilde\theta_0(n)$ **or** defect $\ge10^{-3}$ at $n=12$; comparing the two regimes' values is the closure, in a window of width $0.011$. *Nothing lossy will finish it and no mechanism is sketched.*

## 3. Live items and grades

| item | grade | state |
|---|---|---|
| [I1](../plan.md) | $3\times0\times1\times1=0$ | the problem itself; no route |
| [L16](../plan.md), the lifted chain, [R17](../routes.md) | $3\times1\times1\times1=3$ | the one route no fence closes; owes (A) and (B) |
| [I18](../plan.md) | $2\times2\times1\times1=4$ | three clauses, all fenced or blocked below |
| I5, I7 | 3, 0 | wait on I18; I7 is I1 restated |

Section 2 carries eight build items, section 3 two disprove items, BLOCKED five.

## 4. What the fence posts close

Fifty-four posts. Grouped by mechanism: reaching $P$ through $\mathop{\mathrm{tr}}W^3$ alone (F1); **separate** caps on the two cubic terms (F2 item 2e, F34, F35); Cauchy–Schwarz on the sharp term (F34); $\Pi/4$-shaped bounds (F28); fixed-frame eigenvalue bounds (F29); LPs on the pinned set (F17, F42); per-row conditions at $d\ge3$ (F43, F45); third/fourth-variation calculus on the orbit tangent (F37); the half-flat four-set family (F46); **the entire pair-clause apparatus** (F47–F52); the $\Lambda^2$ spectral gap (F53); and re-bounding $H$ by trace data (F54).

**Unfenced:** the *joint* treatment of $\mathop{\mathrm{tr}}W^3$ and $\langle W,W^\#\rangle$ (which is F1's own prescription) and the lifted chain.

## 5. What the previous sweep covered, so it is not repeated

[2026-09-02](2026-09-02-LIT-step8-sweep.md): **thirty-one searches, six abstracts read, nothing filed as a new source.** Batches: ODE fixed points; equivariant bifurcation; sharp cubic constants; the Kronecker-square reading; the Peirce second moment; gradedness; I9 dual certificates; the problem itself in 2025–26; R15 follow-ups; Michel-type maximisers; Morse–Bott at symmetric orbits; the Plücker/isotropic-Grassmannian angle; the certificate node; the frame-diagonal characterisation; the residual bound. **It confirmed [DGK](../references/deninger-grundhoefer-kramer-2023-srg-quadratic/notes.md) has no follow-up through 2026-09.** What it did supply was three names, *pure curvature* among them.

*Its two derivation batches reproduced L41, F18, F28 and the lifted chain's Result 1, confirmations, no new identity.*

## 6. What changed since it

Lemmas [128](../findings/second-order.md), [129](../findings/diagonal-half.md), [130](../findings/diagonal-half.md); posts F47–F54; [R15](../routes.md) closed analytically, **no SRG lies in the band but the balanced product**, so that family holds no falsifier; [I20](../plan.md) closed before it opened; and the report rebuilt.

## 7. Sources already held

[references/](../references/) carries 49 sources. The ones bearing on (A) and (B): Böhm–Wilking, Jäger's thesis, Petersen–Wink, Krasnov–Tkachev, Nienhaus, DGK, Lauret–Will, Payne. **A sweep that returns any of these has found nothing.**
