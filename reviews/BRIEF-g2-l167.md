# Gate 2 brief, the competitor's stabiliser and the orbit dimension

**You are one of two reviewers working from identical briefs, cold and independently.** Work from what is below and from sources you fetch yourself. Do not read the findings file this came from until you have formed your own verdict on every claim.

## Standing rules for this brief

**Analysis only.** Computation requires the user's approval for a specific task and it has not been given here. The one allowance is **screening a claim you are about to record**, seconds of compute, on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim. Everything else waits: searches, sweeps, optimisations, censuses, falsifier hunts. **All arithmetic exact**, rational or symbolic.

**Log** to the path your dispatch names: PID and phase plan on the first line, a line at every tool round carrying live state, and a closing `DONE <verdict>`. Say in the log before a long reasoning stretch what you are about to derive.

**Committing, under a shared index.** Other reviewers are committing concurrently to the same working tree. **Name your paths on the commit itself**, `git commit -- reviews/REVIEW_r<N>.md reviews/INDEX.md -m "..."`, so a sibling's staged file cannot ride into your commit; staging by path alone does not prevent it. Leave nothing staged. Your scope is your own report, your index row, and any `references/` folder you create. If your index row conflicts, re-read `reviews/INDEX.md` and re-apply it.

**Before you write a discrepancy down**, clear all three or report it `withdrawn` with the reason: **locate it exactly** (step, line, the hypothesis it lacks); **exhibit the failure concretely** in closed form; **argue the opposite**, the strongest reading the words support.

**Silence is not a verdict.** Answer every attack item in writing, including where you find nothing.

## Report format

`reviews/REVIEW_r<N>.md`: title naming the claims; a standfirst saying the brief was cold, that no numerical work was done and every value is exact, and the log path; **the claim table before any prose**, one row per claim with a verdict in caps; a one-line actionable summary; `## 0. Conventions, fixed once`; the hypothesis inventory; numbered sections carrying each derivation in full; the overall verdict from `PROVEN`, `PROVEN (hypotheses corrected`, `GAP`, `BROKEN`, `HYPOTHESIS-DEBT`, `UNRESOLVED), needs computation`.

**You check the written proof; you do not build your own.** Where a claim has no argument on file the finding is *"this claim has no argument on file"*, full stop, and the verdict is `HYPOTHESIS-DEBT` naming what would have to be proved.

## Definitions

- $\mathcal W_N$: symmetric operators on $\Lambda^2\mathbb R^N$ satisfying first Bianchi and Ricci-flat.
- $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ on skew matrices, so $\lVert e_i\wedge e_j\rVert=1$; $x\wedge y$ is the operator $z\mapsto\langle x,z\rangle y-\langle y,z\rangle x$.
- $W_{\mathbb{CP}^2}\in\mathcal W_4$ is supported on one of $\Lambda^\pm\subset\Lambda^2\mathbb R^4$ with eigenvalues proportional to $(2,-1,-1)$ there and zero on the other summand.
- $u$ is $W_{\mathbb{CP}^2}$ padded by zero from $\mathbb R^4$ into $\mathbb R^n$, $n=4+m$. $\rho(A)$ is the derivation of $\Lambda^2\mathbb R^n$ induced by $A\in\mathfrak{so}(n)$, and $\mathfrak{stab}(u)=\{A:[\rho(A),u]=0\}$.

## The statement under review

> Split $\mathfrak{so}(n)=\mathfrak{so}(4)\oplus(\mathbb R^4\otimes\mathbb R^m)\oplus\mathfrak{so}(m)$. Then
> $$\mathfrak{stab}(u)\cap(\mathbb R^4\otimes\mathbb R^m)=0,\qquad \mathfrak{stab}(u)=\mathfrak u(2)\oplus\mathfrak{so}(m),\qquad \dim\big(SO(n)\cdot u\big)=4n-14 .$$

## The proof as written

> Write $A=\sum_jv_j\wedge f_j$ with $v_j\in\mathbb R^4$ and $\{f_j\}\subset\mathbb R^m$ orthonormal. **On $\Lambda^2\mathbb R^4$ the commutator has one term**: for $\xi\in\Lambda^2\mathbb R^4$, $\rho(A)\xi$ lies in $\mathbb R^4\wedge\mathbb R^m$, which $u$ annihilates by the padding, so $[\rho(A),u]\xi=\rho(A)(u\xi)$.
>
> **And $\rho(A)$ reads off $A$'s vectors.** For $\omega\in\Lambda^2\mathbb R^4$ regarded as a skew operator on $\mathbb R^4$, expanding $\rho(A)$ on decomposables gives $\rho(A)\omega=-\sum_j(\omega v_j)\wedge f_j$, and the $f_j$ are independent, so $\rho(A)\omega=0$ forces $\omega v_j=0$ for every $j$.
>
> **One element of the image finishes it.** $W_{\mathbb{CP}^2}$'s image is the whole $3$-space $\Lambda^\pm$ it is supported on; and every nonzero $\omega\in\Lambda^\pm$ satisfies $\omega^2=-\lVert\omega\rVert^2\mathrm{Id}$ and is therefore invertible. Taking any nonzero $\omega$ in the image gives $v_j=0$ for every $j$, hence $A=0$. $\square$
>
> **The dimension follows by addition.** $\mathfrak{so}(m)$ stabilises $u$ entirely; inside $\mathfrak{so}(4)=\Lambda^+\oplus\Lambda^-$ the summand complementary to $u$'s support commutes with it, contributing $3$, and the summand carrying it acts as $\mathfrak{so}(3)$ on $\mathbb R^3$, whose stabiliser of $\mathrm{diag}(2,-1,-1)$ is $\mathfrak{so}(2)$, contributing $1$, a total of $4=\dim\mathfrak u(2)$. Hence $\dim(SO(n)\cdot u)=\binom n2-\binom{n-4}2-4=4n-14$.

## What to attack

1. **The one-term reduction.** Does $\rho(A)$ really carry $\Lambda^2\mathbb R^4$ into $\mathbb R^4\wedge\mathbb R^m$ for $A$ in the mixed block, and does the padding annihilate exactly that? Check what $\rho(A)$ does to the other two blocks of $\Lambda^2\mathbb R^n$, and whether ignoring them is legitimate, the proof uses only a *necessary* condition, so say whether that is enough for the conclusion it draws.
2. **The expansion $\rho(A)\omega=-\sum_j(\omega v_j)\wedge f_j$.** Derive it from $\rho(A)(x\wedge y)=Ax\wedge y+x\wedge Ay$, tracking every sign against the stated wedge convention. **A sign error here is invisible to the conclusion**, so say so if you find one.
3. **Independence of the $f_j$.** The decomposition $A=\sum v_j\wedge f_j$ with $\{f_j\}$ orthonormal, is it always available, and does it lose generality? What if some $v_j$ coincide or vanish?
4. **Invertibility of $\Lambda^\pm$ elements.** Is $\omega^2=-\lVert\omega\rVert^2\mathrm{Id}$ right in the stated normalisation, or off by a factor? Verify on a concrete $\omega$ and on a general one.
5. **$\operatorname{im}u=\Lambda^\pm$.** Does the eigenvalue pattern $(2,-1,-1)$ give a full image on that summand, and is $W_{\mathbb{CP}^2}$ really supported on one summand rather than both? What if it is supported on both, does the argument survive?
6. **The stabiliser addition.** Check each of the three contributions: that $\mathfrak{so}(m)$ acts trivially on $u$; that the complementary $\Lambda^\mp$ commutes with an operator supported on $\Lambda^\pm$; and that the stabiliser of $\mathrm{diag}(2,-1,-1)$ under $\mathfrak{so}(3)$ is one-dimensional, **is that eigenvalue pattern's stabiliser really $\mathfrak{so}(2)$, or larger?** Then check $\binom n2-\binom{n-4}2-4=4n-14$.
7. **$\mathfrak{stab}(u)=\mathfrak u(2)\oplus\mathfrak{so}(m)$** is stated as an equality of Lie algebras, while the proof computes a dimension. Is the identification with $\mathfrak u(2)$ argued anywhere, or only its dimension?
8. **Hypothesis inventory**, and which hypotheses go unused.
9. **The edges.** $m=0$ and $m=1$, where the mixed block is small or empty; $n=4$ itself; and whether the claim needs $n\ge$ anything.
10. **Name what would break it**, the $A$ that, if it existed, would falsify the first display, and what you did to look for it.
