# REVIEW r1065: the circularity in Nienhaus's great-circle estimate, measured

Reviewer `r1065`, Gate 2, adversarial. Target: [2026-09-22-circularity-derivation.md](2026-09-22-circularity-derivation.md) and [I73Circularity.lean](../lean/HamiltonsCubic/Results/I73Circularity.lean). Source: [nienhaus-2311.02404.pdf](https://arxiv.org/abs/2311.02404).

Log: [agent_logs/r1065-circularity.log](../agent_logs/r1065-circularity.log)

**Verdict in one line: the analysis is sound and the closed form is right, but one table row is wrong by 11 percent, the headline row assumes the very thing the note set out to remove, and the note's reading of how hard the remaining job is inverts the comparison with Nienhaus's own unfinished version of it.**

## Verdicts

| claim | verdict | what moved |
|---|---|---|
| E1, the bound and the stationary condition | CONFIRMED | derivative identity reproduced by hand and reconciled with Nienhaus's own quartic form |
| E2, the root is the minimum | CONFIRMED, proof supplied | the note shows stationarity only, F1 fills it |
| E3, the factorisation and $g_1(\alpha)=(1+\alpha)\sqrt{1-2\alpha}$ | CONFIRMED | PDF settles it as a `pdftotext` artefact, the source is correct, F2 |
| E4, $f'(\pi/6)$ and the threshold | SPLIT: formula CONFIRMED, justification REFUTED | the bracket is not increasing for $\gamma<0$, F3 |
| E5, exactness of the criterion | PLAUSIBLE, correction needed | the inequality is non-strict, F4 |
| E6, equality at $\alpha=\tfrac13$ | arithmetic CONFIRMED, gloss REFUTED | Remark 4.18 is about a different condition, and the estimate does not fail at $\alpha=\tfrac13$, F4 and F5 |
| E7, the shell widths | SPLIT: structure CONFIRMED, $\sqrt2$ row REFUTED | $\alpha^*(\sqrt2)=0.11517$, width $0.21816$, F6 |
| E8, the shell is a neighbourhood of the $\tfrac13$-eigenspace | localisation CONFIRMED, difficulty claim REFUTED | F7, F8, F9 |
| E9, Theorem 4.19's far part rests on Conjecture A | CONFIRMED | the phrase is literal in the proof, F10 |
| Lean | compiles clean, statements faithful, coverage overstated | F11 |

## F1. E2 is true, and here is the argument the note omits

Write $h(x)=(1-\alpha)x^2-Cx+\alpha$ with $x=\cos\varphi$. The note's own identity rearranges to $g'(\varphi)\sin^4\varphi=3h(\cos\varphi)$, so on $(0,\pi)$ the sign of $g'$ is the sign of $h(\cos\varphi)$. Three facts then decide everything:

- $h(1)=1-C\le0$ and $h(-1)=1+C>0$, so $h$ has exactly one root in $(-1,1)$, and it is the smaller root $x_-$ of the quadratic.
- $\cos\varphi$ decreases from $1$ to $-1$, so $h(\cos\varphi)<0$ for $\varphi<\varphi_0$ and $h(\cos\varphi)>0$ for $\varphi>\varphi_0$. The stationary point is therefore a strict interior minimum, and it is global on $(0,\pi)$.
- Both endpoints blow up. At $\varphi\to\pi^-$ the numerator tends to $C+1>0$ over $\sin^3\varphi\to0^+$. At $\varphi\to0^+$ it is $C-1>0$ over $0^+$ when $C>1$, and for $C=1$ the numerator is $\varphi^2(\tfrac32-3\alpha)+O(\varphi^4)$ against $\varphi^3$, so $g\sim(\tfrac32-3\alpha)/\varphi\to+\infty$ for $\alpha<\tfrac12$.

The other root does not matter: for $C>1$ it sits above $1$, and for $C=1$ it is $x=1$ itself, which is the excluded endpoint. The discriminant is never negative, because $4\alpha(1-\alpha)\le1\le C^2$. So the note takes the right root and the minimum exists. I verified the closed form against a direct minimisation of $g$ over a grid in $\varphi$ at three $(C,\alpha)$ pairs, agreeing to eight digits.

**Correction owed:** Lemma 1's proof should carry the sign argument, not only the stationary equation. As written it proves less than it states.

## F2. E3 is right, and the PDF settles which kind of finding it is

Page 74 of the PDF reads $\gamma\leqslant\sqrt{1-2\alpha}\,(1+\alpha)$, with the radical covering $1-2\alpha$ alone. The string $\sqrt{1-2\alpha(1+\alpha)}$ in the text dump is a `pdftotext` artefact of the vinculum, **not an error in Nienhaus**. The note's wording ("the expression the extraction garbles as") is already correct on this point and should stay as it is. I reproduced the algebra independently: the numerator at $x=\alpha/(1-\alpha)$ is $(1-2\alpha)^2(1+\alpha)/(1-\alpha)^3$ and the denominator is $(1-2\alpha)^{3/2}/(1-\alpha)^3$, giving $(1+\alpha)\sqrt{1-2\alpha}$.

**A collision the note does not flag.** Nienhaus already uses the symbol $g_1(\alpha)$, for a different function: his $g_1(\alpha)=\tfrac34(3\alpha-1)+\tfrac{\sqrt3}{4}\sqrt{1-2\alpha}(1+\alpha)-\alpha$, which is $\tilde f(\pi/6)$ and is plotted in Figure 4.1. The note's $g_1$ is the bound on $\gamma$. A reader holding both open sees "$g_1(\tfrac13)=\tfrac{4}{3\sqrt3}$" in the note against "$g_1(\tfrac13)=0.0$" on the paper's own graph. Rename the note's function, or say in one line that the symbol is reused.

## F3. E4's formula is right and its stated reason is wrong

$f'(\pi/6)=\tfrac38(5\alpha-3+\sqrt3\gamma)$ is confirmed, and so is the bracket identity $f'(\varphi)=3\sin\varphi\big[(2\alpha-1)\cos^2\varphi-\alpha\sin^2\varphi+\sin\varphi\cos\varphi\,\gamma\big]$, which matches the PDF line for line.

The monotonicity attribution does not survive. With $B(\varphi)=(3\alpha-1)\cos^2\varphi+\tfrac12\sin2\varphi\,\gamma-\alpha$ we get
$$B'(\varphi)=(1-3\alpha)\sin2\varphi+\gamma\cos2\varphi.$$
On $(0,\pi/6)$ both $\sin2\varphi$ and $\cos2\varphi$ are positive and $1-3\alpha\ge0$, so $B'>0$ **requires $\gamma$ to be nonnegative**. At $\alpha=\tfrac13$ exactly, $B'=\gamma\cos2\varphi$, which is negative whenever $\gamma<0$. Nienhaus does not have this problem, because the function he calls increasing is $\tilde f$, in which $\gamma$ has already been replaced by the bound $\sqrt{1-2\alpha}(1+\alpha)\ge0$. The note's Lemma 2 keeps a free $\gamma$ and cites him for a statement he did not make about that object.

**The conclusion survives on a different argument.** For $\gamma\le0$ and $\alpha\le\tfrac13$, use $\cos^2\varphi\ge\tfrac34$ on $[0,\pi/6]$ against the non-positive coefficient $3\alpha-1$ to get $B\le\tfrac34(3\alpha-1)-\alpha+\tfrac{\gamma}{2}\sin2\varphi\le\tfrac54\alpha-\tfrac34\le-\tfrac13$, so the bracket is negative throughout with no monotonicity needed. Lemma 2 should split into the two cases rather than cite a monotonicity that fails in one of them.

## F4. E5's inequality is non-strict, and this is exactly where E6 lives

The criterion should read $g_C(\alpha)\le\dfrac{3-5\alpha}{\sqrt3}$. At equality, $f'(\pi/6)=0$ while $f'<0$ on the whole open interval, so $f$ is still strictly decreasing on $(0,\pi/6]$, which is what Theorem 4.17 asserts. Concretely at $\alpha=\tfrac13$ and $\gamma=\tfrac{4}{3\sqrt3}$: $B(\varphi)=0.3849\sin2\varphi-0.3333$, negative for every $\varphi<\pi/6$ and zero at $\pi/6$.

This makes the note internally inconsistent. Its prose says the estimate "holds for every $\alpha<\tfrac13$" at $C=1$, implying failure at $\alpha=\tfrac13$, while its own table gives the $C=1$ row a shell of width $0$, which implies the opposite. **The table is right and the prose is wrong: at $C=1$ the estimate runs for every $\alpha\le\tfrac13$, endpoint included.** No number in the $C>1$ rows moves, because $g_C$ is strictly increasing in $C$ at fixed $\alpha$, so $g_C(\tfrac13)>g_1(\tfrac13)$ strictly for every $C>1$ and the shell is non-empty for every $C>1$.

## F5. E6's citation of Remark 4.18 points at the wrong condition

The equality itself is exact and I confirm it to thirty digits, $g_1(\tfrac13)=\tfrac{4}{3\sqrt3}=0.7698003589195010$, and Figure 4.1 marks it visually at $x=0.33333333,\ y=0.0$.

The gloss is another matter. The note writes that this is "why Remark 4.18 says the case $\alpha\approx\tfrac13$ is what the estimates do not provide". Remark 4.18 says something narrower: Theorem 4.17's **monotonicity** extends to $n\le9$ without trouble, and it is the second condition $f(\varphi)<\sqrt{2/3}P(W^{crit}_{sym})$ that fails there. Nienhaus's $\alpha\approx\tfrac13$ difficulty is about the $g_2$ threshold at $n\le9$, not about the monotonicity that E4 to E6 analyse. The two coincide in being shells near $\tfrac13$ and they are not the same shell.

## F6. E7's structure holds, four rows drift, and the $\sqrt2$ row is refuted

Reproduced from E1's closed form by bisection at 30 digits, cross-checked against direct minimisation of $g$ over $\varphi$.

| $C$ | note $\alpha^*$ | r1065 $\alpha^*$ | note width | r1065 width |
|---|---|---|---|---|
| $1.0092$ | $0.32223$ | $0.32229$ | $0.0111$ | $0.01104$ |
| $1.05$ | $0.28703$ | $0.28712$ | $0.0463$ | $0.04621$ |
| $1.10$ | $0.25523$ | $0.25532$ | $0.0781$ | $0.07801$ |
| $1.20$ | $0.20432$ | $0.20437$ | $0.1290$ | $0.12897$ |
| $\sqrt2$ | about $0.13$ | $\mathbf{0.11517}$ | about $0.20$ | $\mathbf{0.21816}$ |

The first four carry a systematic drift of roughly $+6$ to $+9\times10^{-5}$ in $\alpha^*$, consistent with a solver stopped early. Harmless to the argument, worth fixing so the digits mean what they print.

The last row is a real error. At the note's $\alpha=0.13$ the quantity $g_{\sqrt2}(\alpha)-\frac{3-5\alpha}{\sqrt3}$ equals $+0.0387$, so $0.13$ is inside the failure region rather than on its boundary. The shell at $C=\sqrt2$ is $(0.11517,\tfrac13]$ of width $0.21816$, **9 percent wider than stated**.

The structural claims are confirmed. Sampling $\alpha$ from $-0.5$ to $\tfrac13$ at $C=1.0092$, $1.10$ and $\sqrt2$, the sign of $g_C-\frac{3-5\alpha}{\sqrt3}$ changes once and only once, so the failure set is a single interval abutting $\tfrac13$ and the estimate does hold below it.

## F7. E8's localisation claim is correct, and it is sharper than the note says

The brief doubts whether $\alpha$ near $\tfrac13$ forces $W$ near an eigenspace. It does, and the proof is short. Nienhaus's own computation in the proof of Theorem 4.14(b) gives $\langle F(W),W\rangle=\langle Q(W),W_{\mathbb{CP}^2}\rangle$, so $\alpha$ is exactly the Rayleigh quotient of $\sqrt{2/3}F_{W_{\mathbb{CP}^2}}$ at unit $W$. Theorem 4.14's spectrum, rescaled by $\sqrt{2/3}$, is $\{1,\tfrac12,\tfrac13,0,-\tfrac16,-\tfrac12,-1\}$. The hypothesis $W\perp\mathbb RW_{\mathbb{CP}^2}\oplus T_{W_{\mathbb{CP}^2}}(SO(n)\cdot W_{\mathbb{CP}^2})$ removes the first two, because the source identifies the orbit tangent space as $\mathrm{Weyl}_4^{-,1}\oplus X_4^{-,2}\otimes\mathbb R^{n-4}$, which is precisely the $\tfrac12$-eigenspace of case (b). That is where $\alpha\le\tfrac13$ comes from, and the next eigenvalue below $\tfrac13$ is $0$.

Decomposing $W=\sum_\lambda W_\lambda$ and using that every surviving eigenvalue other than $\tfrac13$ is at most $0$,
$$\tfrac13-\varepsilon=\alpha=\sum_\lambda\lambda\|W_\lambda\|^2\le\tfrac13\|W_{1/3}\|^2\quad\Longrightarrow\quad\|W-W_{1/3}\|^2\le3\varepsilon.$$

So the note's sentence is right, with a constant attached. **The check that this reconstruction is the intended one:** Remark 4.18 states that $\alpha>0.317$ at $n=9$ forces $\beta<0.223$. My formula gives $\sin\beta\le\sqrt{3(\tfrac13-0.317)}=0.2214$, hence $\beta\le0.2232$. That is Nienhaus's number to three decimals.

## F8. The same arithmetic refutes the note's reading of how small the remaining job is

The note closes on "at the true $C$ the shell is $0.011$ wide", which invites the reading that the job left over is a small one. In the coordinate that actually measures how close $W$ is to the eigenspace, it is not.

| $C$ | shell width $\varepsilon$ | $\|W-W_{1/3}\|\le$ | $\beta\le$ |
|---|---|---|---|
| $1.0092$ | $0.01104$ | $0.182$ | $0.183$ rad, $10.5^\circ$ |
| $1.05$ | $0.04621$ | $0.372$ | $0.382$ rad, $21.9^\circ$ |
| $1.10$ | $0.07801$ | $0.484$ | $0.505$ rad, $28.9^\circ$ |
| $1.20$ | $0.12897$ | $0.622$ | $0.671$ rad, $38.5^\circ$ |
| $\sqrt2$ | $0.21816$ | $0.809$ | $0.943$ rad, $54.0^\circ$ |

The square root is what governs, so a shell of width $0.011$ is a cone of half-angle $10.5^\circ$. Set that beside Remark 4.18: Nienhaus's $n=9$ version of the identical job is $\beta<0.223$ rad, and he records "Unfortunately, we were not able to do this yet". **The $n=12$ job at $\beta\le0.1830$ is tighter than the one he failed to do by a factor of $1.22$, not by the factor of thirty that "$0.011$ wide" suggests.** In $\alpha$ the two shells are $0.0110$ and $0.0163$, a factor of $1.5$. The note's contribution here is the closed form and the table, which are genuinely new, and not a reduction in the difficulty of the residual problem.

At $C=\sqrt2$ the localisation is weak enough to be worth naming: $\beta\le54^\circ$ means only $\cos54^\circ=0.59$ of the norm of $W$ need lie in the eigenspace. Calling that "close to a specific isotypic subspace" overstates it.

## F9. Two further defects in "what this settles" and "what is owed"

**The comparand is wrong.** The note writes: "If that maximum sits below $g_C(\tfrac13)$ by enough, the shell closes." The quantity that closes the shell is the threshold $\frac{3-5\alpha}{\sqrt3}$, whose binding value at $\alpha=\tfrac13$ is $0.76980$. $g_C(\tfrac13)$ is the upper bound that is too weak, and at $C=1.0092$ it equals $0.78378$, which is **above** the threshold by $0.01398$. That is what creates the shell in the first place. Sitting below $g_C(\tfrac13)$ buys nothing. The correct statement is that the shell closes for a given $C$ if $\gamma<\frac{3-5\alpha}{\sqrt3}$ throughout $\alpha\in(\alpha^*(C),\tfrac13]$, and the tightest demand is $\gamma<0.76980$.

**The problem in "what is owed", item 1, is the wrong problem.** It asks for "the maximum of $\gamma$ on the $\tfrac13$-eigenspace". The eigenspace is where $\alpha=\tfrac13$ exactly, a slice of measure zero inside the shell. What closes the shell is the maximum of $\gamma$ over the cone of half-angle $\beta(C)$ around that eigenspace, which is Remark 4.18's split $W=\cos\beta W_1+\sin\beta W_2$ in full. Since $P$ is cubic and Lipschitz on the unit sphere, the cone version costs $O(\beta)$ more than the eigenspace version, and $\beta=0.183$ is not small next to the margin of $0.014$ that has to be recovered. Item 1 should be restated as the cone problem, which is also exactly the problem Nienhaus states and reports open.

Separately, the note describes the eigenspace as "a KNOWN space whose maximum is a definite number". The space is $S_1^2\oplus(S_1^2\otimes\mathbb R^{n-4})\oplus(\Lambda^2_{-,1}(\mathbb R^4)\otimes\Lambda^2(\mathbb R^{n-4}))$ from Theorem 4.14(c), whose dimension grows with $n$ through the $\Lambda^2(\mathbb R^{n-4})$ factor. Maximising a cubic form on the unit sphere of that space is a smaller instance of the same species of problem as Conjecture A, so "a definite number" describes its existence rather than its accessibility.

## F10. E9 is confirmed verbatim

Theorem 4.19's proof, at line 4838 of the extraction, reduces to $d\le\pi/6$ by running the gradient flow of $P$ to a critical point $W(t_0)$ and splitting. The second case reads, word for word: "$W(t_0)\notin SO(n).W_{\mathbb{CP}^2}$: Then we find that $P(W)\le P(W(t_0))\le P(W^{crit}_{sym})$ by Conjecture A." So **"Conjecture A by name" is fair, it is literally the phrase in the proof**, and the note's summary of the consequence is accurate.

Worth adding to the note, because it strengthens its own thesis: the preamble to section 4.5 says outright "Here we frequently use Conjecture A. More explicitely, we use the statement that $\max\{P(W)\}=\sqrt{3/2}$ and that this maximum is only achieved by $W_{\mathbb{CP}^2}$ in dimensions between 8 and 12." So the circularity the note measures is one Nienhaus declares. The note relaxes the first half of that statement, the value of the maximum, and leaves the uniqueness half untouched. That is the right scoping and it should be said, since the uniqueness half is what the first case of 4.19's proof consumes.

## F11. Lean: clean, faithful, and narrower than the coverage table implies

`lake env lean HamiltonsCubic/Results/I73Circularity.lean` exits 0 with no output. No `sorry`, no `axiom`, no `native_decide`.

- `g1_stationary_factors`, `one_sub_sq_at_root`, `numerator_at_root`, `g1_closed_form` are faithful to E3. `g1_closed_form` states $N=(1+\alpha)\sqrt{1-2\alpha}\cdot(1-x^2)\sqrt{1-x^2}$ under $0\le\alpha<\tfrac12$, which is $g_1(\alpha)=(1+\alpha)\sqrt{1-2\alpha}$ with `rpow` avoided. Correct.
- `tight_at_top` is E6 exactly.
- **`fderiv` being a definition matters, in one specific way.** The identity $f'(\varphi)=3\sin\varphi[\cdots]$ is the content of Lemma 2's first half, and declaring it as a definition means Lean checks nothing about it. I verified it by hand and against the PDF, so there is no error, but the coverage table should not read as though the derivative step is machine-checked. It is asserted.
- **A naming hazard.** The file opens with `import Mathlib` and then defines `fderiv` inside its namespace, shadowing Mathlib's Fréchet derivative for the rest of the file. A reader is invited to believe the two are connected. Rename to something like `fPrimeExpr`.
- **`monotone_threshold` does not state monotonicity.** It states $f'(\pi/6)<0\iff\gamma<\frac{3-5\alpha}{\sqrt3}$, a condition at one point. E4's actual content, that the sign at $\pi/6$ decides the sign on all of $(0,\pi/6)$, is untyped, and F3 shows that is the part with the defect. The coverage table's "E4 | fderiv_at_pi_div_six, monotone_threshold" should say the endpoint formula only.
- F4's non-strictness shows up here too: `monotone_threshold` uses strict `<` on both sides, which is the correct statement about $f'(\pi/6)<0$ and the wrong statement about Theorem 4.17's conclusion. If the prose is repaired to $\le$, the Lean needs a companion for the equality case.

## Reach

**What these findings are about.** The scalar analysis of $f(\varphi)=\cos^3\varphi+3\cos\varphi\sin^2\varphi\,\alpha+\sin^3\varphi\,\gamma$ under the hypothesis $f\le C$ on $[0,\pi]$, taking G1 to G4 as given, together with what Nienhaus's Theorems 4.14, 4.17 and 4.19 and Remark 4.18 say on the page. The numbers are from the closed form in E1, cross-checked against direct minimisation, on objects already in hand.

**What they are NOT about.** They say nothing about whether any $C>1$ is provable, and in particular nothing about $M(n)\le\sqrt3$. They do not establish the maximum of $\gamma$ on the $\tfrac13$-eigenspace or on the cone around it, and F9 argues that problem is open rather than solving it. They do not touch Conjecture A, and following E9 they do not touch [I73](../plan.md). F7's spectral argument assumes the identification of the orbit tangent space with Theorem 4.14(b), which I read off line 4675 of the extraction rather than re-deriving.

**One thing the note should say and does not.** The row it leans on hardest, $C=\sqrt{2/3}\,\theta_0(12)=1.0092$, is labelled "the TRUE maximum at $n=12$". It is not a theorem that $\theta_0(12)$ is the maximum at $n=12$. That is the $n=12$ analogue of Conjecture A, so the headline "at the true $C$ the shell is $0.011$ wide" is conditional on the answer the exercise set out to stop assuming. The note applies exactly the right caveat to the $\sqrt2$ row and should apply it to the $1.0092$ row as well. **The only rows that could ever become unconditional are the wide ones, and at $C=\sqrt2$ the shell is $0.218$ and the cone is $54^\circ$.**
