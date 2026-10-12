# Step 9 position, 2026-09-22: the GLOBAL-maximality gap, and nothing else

**Written at the head of a step 9 search the user opened on one question, after asking whether the programme has a route to P that covers the non-diagonal case. It does not, and this file says exactly where it stops.** *Written on Fable at the user's switch, so it is short and was put on disk before anything else was read.*

## The one open node this search is about

**[I73](../plan.md): a global maximiser of $P$ has an $\mathrm{L}^2$-spectrum taking exactly two values.** [L105](../findings/bounds-relaxations.md) finishes from there. It is graded `closes` $3$, `attackable` $0$ after nine sweeps, and it is the destination of the whole programme.

**Why every local tool is blind to it.** [routes.md](../routes.md) R25's closing clause: *padded $W_{\mathbb{CP}^2}$ meets criticality and local maximality without being diagonal.* Its spectrum is $(2,-1,-1,0,\ldots,0)$, three values, at $\theta=\sqrt{3/2}=1.2247$ against $\theta_0(12)=1.2360$. So it passes $Q(W)=\theta W$ and passes [L24](../findings/second-order.md)'s $\lambda_{\max}(L_e|_{W^\perp})\le\tfrac12$, and it is sub-maximal. **Whatever forces two values must consume GLOBAL maximality**, which the [2026-09-14 sweep](2026-09-14-LIT-step8-sweep.md) already recorded as I73 being *"refuted by the screening question unless it consumes H1 or H4"*.

## What global maximality gives, and where it has been spent

**The one global tool on the record is the great-circle inequality.** For unit $V\perp W$, criticality kills the linear term and cubic forms have no fourth derivative, so the expansion is EXACT and finite: $\theta\cos^3t+3a\cos t\sin^2t+b\sin^3t\le\theta$ for ALL $t$, with $a=\langle L_WV,V\rangle$ and $b=P(V)$. Its second-order shadow is L24; its full envelope is R25's $\psi_\gamma$, spent on the tubes, and the far region is where it loses.

**So "a consequence of global maximality beyond L24" has a precise meaning here: information not contained in one-parameter great circles through $W$.** Two-dimensional slices, or the whole sublevel set, or a comparison that does not pass through $W$ at all.

## Fence posts bearing on it

- [F67](../findings/fence-posts.md), four times: a decoupled bound of $P(b)$ against the coupling fails.
- [F43](../findings/bounds-relaxations.md): the per-row family is closed at three or more eigenvalues.
- [F15–F18, F28](../findings/bounds-relaxations.md): every LP, marginal relaxation and transportation argument is closed.
- The [2026-09-13c sweep](2026-09-13c-LIT-step8-sweep.md): *equivariant Morse theory and the Conley index, unscreened, and Morse inequalities bound counts from BELOW, the wrong direction for a localisation.* **That verdict was about localisation.** The question here is exclusion of one sub-maximal local maximiser, which is a different use of the same theory and has not been screened.

## What previous sweeps covered, so this one does not repeat them

Nine sweeps; I73 "unchanged from six sweeps" at the seventh and `attackable` $0$ at the ninth. They searched: Łojasiewicz and gradient flow (2026-09-03), spectral and isotype censuses (R12, stalled), the frame split (R24), tubes (R25), reflection induction (R26, abandoned), Jin's $L^4$ route (R27, its rung I106b closed by [r1058](REVIEW_r1058.md)), tight fusion frames and extremal cubics (2026-09-21). **None asked the optimisation-theoretic question directly**: what distinguishes the global maximiser of a homogeneous cubic on a sphere from a non-global local maximiser.

## The question for the sweep, stripped of this programme's names

*$P$ is a homogeneous cubic form on $\mathbb R^N$, $W$ its global maximiser on the unit sphere, $\theta=P(W)$. Beyond $\nabla P(W)=3\theta W$ and the projected Hessian being $\le\tfrac12$ of the identity in units of $\theta$, what does global maximality force on $W$?* Fields: Z-eigenvalues of symmetric tensors and best rank-one approximation, nonnegativity of $\theta^2\lVert X\rVert^6-P(X)^2$ and the structure of its zero set, Morse theory on the sphere for the whole critical set, sums of squares only for what they imply STRUCTURALLY about the maximiser, never as an endgame.

## Live items, for the record

Section 1 tops at I110 (grade 6), which is R25's far region and does not touch I73. I36 and I73 at 3, both destination-shaped. Six items zeroed on `closes`.

---

# ADDENDUM, the gap has a NAME in the literature, and the obstruction is a CIRCULARITY

**Written on Opus after the sweep, before handing the invention to Fable. This is reading, not invention.**

**[Nienhaus](../references/nienhaus-2023-second-best-einstein/README.md)'s Theorem 4.19 is exactly the statement the programme is missing, one dimension range below.** *For $10\le n\le11$, every $W$ outside an explicit tube around $SO(n)\cdot W_{\mathbb{CP}^2}$ satisfies $P(W)\le\theta_n$, with $\gamma_{11}=0.13$ and $\gamma_{10}=0.26$.* **That is the localisation R25 wants, and R25's far region is precisely its complement.**

**WHY IT STOPS AT $n=11$, AND THIS IS THE WHOLE OBSTRUCTION.** *This project's own [README](../references/nienhaus-2023-second-best-einstein/README.md) records it: Theorem 4.17's proof caps $\gamma$ with numerator $c=1$, justified by "$f\le1$ on $[0,\pi]$", which is available only because $W_{\mathbb{CP}^2}$ IS the global maximiser for $n\le11$. At $n\ge12$ the balanced sphere product overtakes it, the justification is gone, and the closing estimate FLIPS SIGN.*

**SO THE MISSING GLOBAL INPUT IS A CIRCULARITY, NOT AN ABSENCE.** *The method needs an a-priori bound on $P$ to prove the bound on $P$. At $n\le11$ that input is free because the competitor is the maximiser. At $n\ge12$ it is the thing being proved.* **And the author says so**: *"a strategy on proving the estimate is to estimate $\gamma=\sqrt{2/3}P(W)$ for $W$ as above. Unfortunately, we were not able to do this yet."*

## The question to invent against, and it is quantitative

**How weak an a-priori bound on $P$ suffices to run Theorem 4.17's estimate at $n\ge12$?** *The proof uses $f\le1$, i.e. $P\le P(W_{\mathbb{CP}^2})$. If the estimate closes under some $P\le c$ with $c>\theta_0(n)$, the circularity breaks, because a weaker bound can be proved independently.*

**What the record already holds to feed it.** $M(n)\le\sqrt3$ is the standing target and is NOT proved: [post F11](../findings/fence-posts.md) closes the split of $P$ into its two terms, and flatness alone misses by about $20\%$ at $n=12$. *A measured supremum of the low-rank bound sits near $1.545$ independently of $n$ ([second-order.md](../findings/second-order.md)), against $\theta_0(12)=1.236033$ and $\sqrt{3/2}=1.224745$.* **So the gap to fill is between an unproved $\sqrt3=1.732$ and whatever $c$ Theorem 4.17 actually needs, and nobody has computed that $c$.**

**THAT COMPUTATION IS THE TARGET.** *It is a definite question with a number for an answer, it has never been asked, and either outcome is informative: a $c$ above $\theta_0(12)$ opens the route, and a $c$ at or below it proves the circularity is essential and closes the method for good.*
