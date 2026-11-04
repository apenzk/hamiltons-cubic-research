# Gate 2 brief, the grading and tracelessness determine the saturating operator

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

- $\mathcal W_n$: symmetric operators on $\Lambda^2\mathbb R^n$ satisfying first Bianchi and Ricci-flat. $N=\binom n2$.
- $\lambda_{\max},\lambda_{\min}$ are the extreme eigenvalues of $W$ **as an operator on $\Lambda^2\mathbb R^n$**, $E_{\max},E_{\min}$ their eigenspaces.
- $\theta(W)=P(W)/\lVert W\rVert^3$ with $P(W)=\langle W,W^2+W^\#\rangle$; $\theta_0(n)^2=\tfrac{2(n-1)(n-2)}{n^2}$.
- On the record: for a subalgebra $\mathfrak h\subseteq\mathfrak{so}(n)$ with $r=\dim\mathfrak h$, the Casimir family's member is the unit multiple of $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$, with $\theta=\tfrac2n\sqrt{\tfrac{rN}{N-r}}$ when it is critical; the balanced sphere product $S^{n/2}\times S^{n/2}$ is the member at $\mathfrak h=\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$, $r=\tfrac{n(n-2)}4$, and its isotropy is that $\mathfrak h$ at that dimension.

## The statement under review

> Let $n$ be even, $W\in\mathcal W_n$ with $\lVert W\rVert=1$, **exactly two eigenvalues** $\lambda_{\max}>0>\lambda_{\min}$, and $E_{\max}$ $SO(n)$-conjugate to $\mathfrak h=\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$. Then $W$ is $SO(n)$-conjugate to the Weyl tensor of $S^{n/2}\times S^{n/2}$ at unit norm, and $\theta=\theta_0(n)$. **Neither criticality nor saturation is used.**

## The proof as written

> Conjugate so that $E_{\max}=\mathfrak h$ exactly. Two eigenvalues and $E_{\min}=E_{\max}^\perp$ give $W=\lambda_{\max}\Pi_{\mathfrak h}+\lambda_{\min}(\mathrm{Id}-\Pi_{\mathfrak h})$, so $W$ lies on the plane spanned by $\Pi_{\mathfrak h}$ and $\mathrm{Id}$. **Ricci-flatness makes $W$ traceless on $\Lambda^2$**, and with $r=\tfrac{n(n-2)}4$, $N-r=\tfrac{n^2}4$, that reads
> $$\lambda_{\max}r+\lambda_{\min}(N-r)=0\iff\frac{\lvert\lambda_{\min}\rvert}{\lambda_{\max}}=\frac r{N-r}=\frac{n-2}n\iff(n-2)\lambda_{\max}=n\lvert\lambda_{\min}\rvert,$$
> which is the ratio the source lemma records, so it and tracelessness are the same equation read in two directions. This puts $W$ on the line $\mathbb R(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$; $\lVert W\rVert=1$ fixes the scale up to sign and $\lambda_{\max}>0$ the sign.
>
> The balanced Casimir member is the unit positive multiple of the same operator, with $E_{\max}=\mathfrak h$ since $1-\tfrac rN>0>-\tfrac rN$, and it is the sphere product's Weyl tensor. Two unit positive multiples of one operator coincide. Its $\theta$ follows from the closed form: $\tfrac2n\sqrt{\tfrac{rN}{N-r}}=\tfrac2n\sqrt{\tfrac{(n-1)(n-2)}2}=\theta_0(n)$. $\square$
>
> Also claimed: at odd $n$ the hypothesis is unsatisfiable, $\tfrac{n^2}4\notin\mathbb Z$; and at $n=4$ the conclusion would be false but the hypothesis does not apply, $W_{\mathbb{CP}^2}$ having a $3$-dimensional kernel and so three eigenvalues.

## What to attack

1. **"Ricci-flatness makes $W$ traceless on $\Lambda^2$".** Derive it, and say in which normalisation, this record has a live factor-of-two hazard between the $\Lambda^2$ and $n\times n$ pairings. Is $\mathop{\mathrm{tr}}_{\Lambda^2}W=0$ equivalent to Ricci-flatness, or only implied by it? **If only implied, does the argument still close?**
2. **The dimension count.** $r=\tfrac{n(n-2)}4$ for $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ and $N-r=\tfrac{n^2}4$; then $\tfrac r{N-r}=\tfrac{n-2}n$. Check each.
3. **"Exactly two eigenvalues" and $E_{\min}=E_{\max}^\perp$.** Does the hypothesis as stated force the complement to be a single eigenspace, or could $W$ have a kernel? **A zero eigenvalue is this record's recurring obstruction**, say whether "exactly two eigenvalues" excludes it and what happens if it does not.
4. **The identification.** The proof says two unit positive multiples of one operator coincide. Is the Casimir member really the *positive* multiple, and is its $E_{\max}$ really $\mathfrak h$ rather than the complement? Check the sign of $\theta$ under the two choices.
5. **The $\theta$ evaluation.** Is the closed form $\theta=\tfrac2n\sqrt{rN/(N-r)}$ applicable here, the record attaches it to *critical* members, and this proof claims criticality is unused. **Does the lemma import a criticality hypothesis through that formula while claiming not to?** This is the sharpest question in the brief.
6. **The redundancy claims.** The block asserts that neither criticality nor saturation is consumed, and that the ratio hypothesis is not independent of tracelessness. Check both by tracking exactly which hypotheses each step uses.
7. **The conjugation.** "Conjugate so that $E_{\max}=\mathfrak h$ exactly", is $SO(n)$-conjugacy of the eigenspace enough, and does conjugating back at the end preserve everything claimed?
8. **Hypothesis inventory**, including the imported facts about the Casimir family and the sphere product's isotropy, checked against the object.
9. **The edges.** $n=4$ and the kernel claim; odd $n$; $n=6$, the smallest even case where $\mathcal W_n\ne0$ and $\tfrac{n^2}4$ is an integer, **does the statement actually hold at $n=6$, or does something degenerate?**; and whether $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ is a subalgebra of the right dimension at small $n$.
10. **Name what would break it**, the $W$ that, if it existed, would satisfy the hypotheses and fail the conclusion, and what you did to look for it.
