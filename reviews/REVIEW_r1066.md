# Gate 2 review r1066: the circularity in Nienhaus's great-circle estimate, measured

Reviewer `r1066`, adversarial. Target: [the circularity derivation](2026-09-22-circularity-derivation.md) and [I73Circularity.lean](../lean/HamiltonsCubic/Results/I73Circularity.lean). Source: [Nienhaus 2311.02404](../references/nienhaus-2023-second-best-einstein/), read both as the `pdftotext` dump and as a 200 dpi render of the PDF page itself.

Log: [agent_logs/r1066-circularity.log](../agent_logs/r1066-circularity.log). Analysis only: every number below is either exact or a 50-digit bisection on the note's own closed form, on objects already in hand.

## Verdicts

| claim | verdict |
|---|---|
| E1 stationary condition and the form of $g_C$ | **CONFIRMED** |
| E2 the taken root is the global minimum of $g$ | **CONFIRMED as a fact, the note's proof of it is INCOMPLETE** |
| E3 $C=1$ factorisation and $g_1(\alpha)=(1+\alpha)\sqrt{1-2\alpha}$ | **CONFIRMED**, and the garble is a `pdftotext` artefact, the source is right |
| E4 $f'(\pi/6)$ and the bracket increasing in $\varphi$ | **CONFIRMED**, with one silent hypothesis and one false "iff" |
| E5 the exact-$\alpha$ criterion | **PLAUSIBLE**, the quantifier is misattributed |
| E6 equality at $\alpha=\tfrac13$, $C=1$ | **CONFIRMED** |
| E7 the shell table | **REFUTED as printed**: four rows wrong in the fifth decimal, the $\sqrt2$ row wrong in the second |
| E8 the shell as a neighbourhood of the $\tfrac13$-eigenspace | **CONFIRMED and strengthened**, its consequence **REFUTED** |
| E9 4.19's far part and Conjecture A | **CONFIRMED**, and the circularity reaches further than the note says |
| the Lean statements against the prose | **statements sound, the module docstring OVERCLAIMS** |

## E1, confirmed by symbolic differentiation

Writing $x=\cos\varphi$, $s=\sin\varphi$ and $N(\varphi)=C+(3\alpha-1)x^3-3\alpha x$, the quotient rule gives $g'=(N's-3Nx)/s^4$, and collecting powers of $x$ against $s^2+x^2=1$ leaves

$$g'(\varphi)\,\sin^4\varphi=3\big[(1-\alpha)x^2-Cx+\alpha\big]=-3\big(C\cos\varphi-\cos^2\varphi-\alpha\sin^2\varphi\big).$$

At $C=1$ this reduces to Nienhaus's own quartic stationary equation $0=3\alpha s^4+3(1+\alpha)x^2s^2+3x^4-3x$, which collapses to $\alpha(1-x^2)+x^2-x=0$. The note's quadratic and the source's quartic are the same equation.

## E2, the claim is right and the note has not proved it

The note shows stationarity and stops, which is the one gap it flags itself. It is fillable in three lines, and the filling also disposes of the other root.

- **The sign of $g'$ is the sign of $q(x):=(1-\alpha)x^2-Cx+\alpha$**, by E1, since $\sin^4\varphi>0$ on $(0,\pi)$.
- **$q$ is an upward parabola and $x=1$ is never below its larger root**: $q(1)=1-C\le0$ for every $C\ge1$, so $x_-\le 1\le x_+$, with $x_+=1$ exactly at $C=1$. Also $q(-1)=1+C>0$, so $x_->-1$. The root the note takes therefore lies in $(-1,1)$ for every $\alpha<\tfrac12$ and every $C\ge1$, and the other root corresponds to no interior $\varphi$ at all. At $C=1$ the other root IS the endpoint $\varphi=0$.
- **The endpoints blow up.** As $\varphi\to0^+$, $N\to C-1$ and $s^3\to0^+$, so $g\to+\infty$ for $C>1$. At $C=1$ the numerator is $3(\tfrac12-\alpha)\varphi^2+O(\varphi^4)$ against $\varphi^3$, so $g\to+\infty$ whenever $\alpha<\tfrac12$. As $\varphi\to\pi^-$, $N\to C+1>0$ and again $g\to+\infty$.

So $g$ falls then rises, with one interior critical point, which is its global minimum. A brute-force minimum over $400{,}000$ points of $(0,\pi)$ agrees with the closed form to ten digits at every $(\alpha,C)$ in $\{-0.4,0,0.15,0.3,\tfrac13\}\times\{1,1.0092,1.2,\sqrt2\}$, and $x_+\ge1$ in all twenty cases.

**Correction owed to the note.** Lemma 1 should carry the sign argument, because "the minimiser has $x=\cos\varphi_0$ solving" is asserted where only "a stationary point solves" is shown.

## E3, the source is correct and the extraction is the garble

This is the one place where the finding changes depending on which artefact you read, so I read both.

- **The PDF, printed page 74, PDF page 78, reads "Hence we obtain $\gamma\le\sqrt{1-2\alpha}(1+\alpha)$"**, and carries the same expression three more times on that page, inside $f'$, inside $\tilde f$ and inside $g_2$. The radicand is $1-2\alpha$ and the factor $(1+\alpha)$ sits outside the radical. `pdftotext` drops the overline, which is what produces "$1 − 2α(1 + α)$" under a stray radical sign in the dump.
- **The source's own arithmetic settles it independently of the render.** Nienhaus computes $f(\pi/6)\le g_2(1/3)=\tfrac{5\sqrt3}9\approx0.9622504486$. With $\Gamma=(1+\alpha)\sqrt{1-2\alpha}$, $g_2(1/3)=\tfrac{\sqrt3}2+\tfrac1{8}\cdot\tfrac4{3\sqrt3}=0.9622504486$, reproducing all ten printed digits. With the garbled $\Gamma=\sqrt{1-2\alpha(1+\alpha)}$ the same expression is $0.9077$, which matches nothing in the paper.

**So the note's parenthetical is right and should say `pdftotext` rather than leaving "the extraction garbles" open to being read as an error in the source.** The Lean docstring's "the extraction of the source garbles this expression" is already the correct wording and should stay.

**A notation collision the note introduces.** In the source, $g(\varphi)$ is the bound on $\gamma$ and $g_1(\alpha)$ is $\tilde f(\pi/6)$, a different function. The note uses $g_1(\alpha)$ for the bound on $\gamma$ at $C=1$, and the Lean names `g1_closed_form` and `g1_stationary_factors` inherit that. A reader holding both documents will read $g_1$ two ways. E6's equality is exactly the source's $g_1(\tfrac13)=0$.

## E4, confirmed, with a silent hypothesis and a false "iff"

$f'(\varphi)=3\sin\varphi\big[(2\alpha-1)\cos^2\varphi-\alpha\sin^2\varphi+\gamma\sin\varphi\cos\varphi\big]$ by direct differentiation, and at $\varphi=\pi/6$ the bracket is $\tfrac14(3(2\alpha-1)-\alpha+\sqrt3\gamma)$, giving $f'(\pi/6)=\tfrac38(5\alpha-3+\sqrt3\gamma)$. Confirmed.

**The monotonicity in $\varphi$, which the brief asked me to verify rather than assume, is elementary.** With $\tilde f(\varphi)=(3\alpha-1)\cos^2\varphi-\alpha+\tfrac{\Gamma}2\sin2\varphi$,

$$\tilde f'(\varphi)=(1-3\alpha)\sin2\varphi+\Gamma\cos2\varphi,$$

and on $(0,\pi/6)$ both $\sin2\varphi$ and $\cos2\varphi$ are positive, so $\tilde f'>0$ as soon as $\alpha\le\tfrac13$ and $\Gamma\ge0$. **The hypothesis $\Gamma\ge0$ is silent in the source and in the note.** It holds throughout the range in play, since $g_C(\alpha)\ge g_1(\alpha)=(1+\alpha)\sqrt{1-2\alpha}>0$ for $-1<\alpha<\tfrac12$, and Theorem 4.14 puts $\alpha\ge-\tfrac12$, but it is a hypothesis and belongs in Lemma 2's statement.

**The "iff" in Lemma 2 fails on the boundary the note cares about most.** At $\alpha=\tfrac13$, $C=1$, $\gamma=g_1(\tfrac13)$ the bracket is zero at $\pi/6$ and strictly negative before it, so $f$ IS strictly decreasing on the open $(0,\pi/6)$ while $\gamma<\tfrac{3-5\alpha}{\sqrt3}$ is false. The correct pair of statements:

- $f'(\pi/6)<0$ iff $\gamma<\tfrac{3-5\alpha}{\sqrt3}$.
- $f$ is strictly decreasing on $(0,\pi/6]$ iff $\gamma\le\tfrac{3-5\alpha}{\sqrt3}$.

Theorem 4.17's conclusion is the second, on the closed interval, so the shell is correctly written half-open as $(\alpha^*(C),\tfrac13]$ only for $C>1$, and is empty at $C=1$, which is what the note's table says.

## E5, the criterion is right and the quantifier is misattributed

The note's THEOREM reads "Theorem 4.17's monotonicity on $(0,\pi/6)$ holds for exactly those $\alpha\le\tfrac13$ with $g_C(\alpha)<\tfrac{3-5\alpha}{\sqrt3}$". **Monotonicity is a property of $(\alpha,\gamma)$, not of $\alpha$.** For $\alpha$ inside the shell, a $W$ with small $\gamma$ still has $f$ decreasing. What is true is the statement about the ROUTE:

> Given the input $f\le C$ and the value of $\alpha$, and nothing else, the estimate closes exactly on $\{\alpha:g_C(\alpha)<\tfrac{3-5\alpha}{\sqrt3}\}$.

The "exactly" survives because the extremal case is admissible: $\gamma=g_C(\alpha)$ makes $f\le C$ with equality at $\varphi_0$, so it is consistent with the hypothesis and no sharper bound on $\gamma$ follows from it. **That is the sentence to write.** As printed, the claim asserts that monotonicity FAILS on the shell, which the input does not support.

## E6, confirmed

$g_1(\tfrac13)=\tfrac43\sqrt{\tfrac13}=\tfrac4{3\sqrt3}=0.7698003589$ and $\tfrac{3-5/3}{\sqrt3}=\tfrac{4/3}{\sqrt3}$, the same number. My 50-digit evaluation of the general closed form at $(\alpha,C)=(\tfrac13,1)$ returns the threshold to $10^{-41}$. It is also the source's $g_1(\tfrac13)=0$, which is why Nienhaus writes "negative for $\alpha<\tfrac13$" strictly.

## E7, refuted as printed

The structure is right: a single crossing, the estimate closing below $\alpha^*$ and failing on $(\alpha^*,\tfrac13]$, and $\alpha^*$ strictly decreasing in $C$. I checked the single crossing on a grid from $\alpha=-0.5$ to $\tfrac13$ at $C=1.0092$ and $C=\sqrt2$: $g_C(\alpha)-\tfrac{3-5\alpha}{\sqrt3}$ is increasing throughout and changes sign once.

**The numbers are wrong.** Bisection at 50 digits on the note's own closed form:

| $C$ | note's $\alpha^*$ | correct $\alpha^*$ | note's width | correct width |
|---|---|---|---|---|
| $1.0092$ | $0.32223$ | $0.3222896$ | $0.0111$ | $0.0110437$ |
| $1.05$ | $0.28703$ | $0.2871249$ | $0.0463$ | $0.0462084$ |
| $1.10$ | $0.25523$ | $0.2553211$ | $0.0781$ | $0.0780122$ |
| $1.20$ | $0.20432$ | $0.2043667$ | $0.1290$ | $0.1289667$ |
| $\sqrt2$ | about $0.13$ | $0.1151708$ | about $0.20$ | $0.2181626$ |

Every printed $\alpha^*$ is low, by $4.7\times10^{-5}$ to $9.5\times10^{-5}$, so the fifth decimal is wrong in all four numeric rows and each printed value sits strictly inside the region where the estimate still closes. The widths inherit the error in the other direction.

**The $\sqrt2$ row is wrong at the second decimal and wrong in kind.** At $\alpha=0.13$ and $C=\sqrt2$ the criterion evaluates to $+0.0387$, so $0.13$ lies INSIDE the shell rather than at its edge. The shell at $C=\sqrt2$ runs from $0.1151708$ and is $0.2182$ wide, not $0.20$. The coincidence with Theorem 4.19's $\gamma_{11}=0.13$ is worth noting as the likely source of the slip.

**One label is an overclaim.** The row "$1.0092$, $\sqrt{2/3}\,\theta_0(12)$, the TRUE maximum at $n=12$" is not a true maximum. $\theta_0(12)=\sqrt{55}/6$ is the value of $P$ at the Weyl tensor of $S^6\times S^6$, a known critical value and therefore a LOWER bound on the maximum. Calling it the maximum is Conjecture A at $n=12$, which is what the exercise is trying not to assume. The note's own owed-item 2 says as much, so the table contradicts its own closing section. The honest label is "the conjectured maximum at $n=12$".

## E8, the geometry is right, the consequence is not

**The first half is right, and the brief's worry is answerable.** By the symmetry of $\mathrm{tri}$, which Nienhaus invokes on the first line of 4.17's proof, $\langle Q(W),W_{\mathbb{CP}^2}\rangle=\langle F_{W_{\mathbb{CP}^2}}(W),W\rangle$, so $\alpha$ IS a Rayleigh quotient of $F_{W_{\mathbb{CP}^2}}$ and not merely a pairing. Theorem 4.14 lists the eigenvalues, Remark 4.16 identifies $T_{W_{\mathbb{CP}^2}}(SO(n)\cdot W_{\mathbb{CP}^2})$ with case (b), and on the complement of $\mathbb RW_{\mathbb{CP}^2}\oplus T_{W_{\mathbb{CP}^2}}(SO(n)\cdot W_{\mathbb{CP}^2})$ the spectrum of $\sqrt{2/3}F$ is $\tfrac13$ from case (c), then $0$, $-\tfrac16$ and $-\tfrac12$. The gap from $\tfrac13$ to $0$ converts $\alpha$ near $\tfrac13$ into $W$ near the case-(c) eigenspace:

$$\sin^2\beta\le1-3\alpha,\qquad W=\cos\beta\,W_1+\sin\beta\,W_2,\ W_1\ \text{in the}\ \tfrac13\text{-eigenspace}.$$

This reproduces Remark 4.18 exactly: at $\alpha>0.317$ it gives $\beta<0.2234$, and the source writes $\beta<0.223$. So the note's "the shell is a neighbourhood of the $\tfrac13$-eigenspace" is correct, and the note should carry this inequality, which makes the claim checkable instead of asserted.

**The second half is wrong twice.**

- **The number to beat is the threshold, not $g_C(\tfrac13)$.** The note writes "if that maximum sits below $g_C(\tfrac13)$ by enough, the shell closes". $g_C$ is the UPPER bound on $\gamma$ that the circular input supplies, so being below it is no achievement at all. What closes the shell is $\gamma<\tfrac{3-5\alpha}{\sqrt3}$, and since the threshold decreases in $\alpha$ the binding requirement over the shell is $\gamma<\tfrac4{3\sqrt3}=0.76980$. At $C=1.0092$, $g_C(\tfrac13)=0.78378$ and at $C=\sqrt2$ it is $1.28179$, so the note's target is weaker than the one that works, by $0.014$ and by $0.512$ respectively. Only at $C=1$ do the two coincide, which is E6, and that is presumably how the substitution slipped in.
- **A bound on the eigenspace does not bound $\gamma$ on the shell.** $W$ is within $\beta$ of the eigenspace, not in it, and $P$ is cubic, so the first-order term in $\beta$ is uncontrolled by $\max P$ on the eigenspace. The angle is not small: $\beta\le0.1835$ at $C=1.0092$, $\beta\le0.3819$ at $C=1.05$, and at the corrected $\alpha^*(\sqrt2)=0.11517$ it is $\beta\le0.9395$, which is more than half a right angle and no neighbourhood of anything. **So "the shell is $0.20$ wide at $C=\sqrt2$, so the eigenspace bound would have to carry a fifth of the range" understates the job twice over**: the range is $0.218$ in $\alpha$, and in the geometry that the eigenspace argument actually has to cover it is nearly the whole sphere transverse to the eigenspace.

The corrected owed-item is a bound on $\gamma$ over a $\beta$-tube around the case-(c) eigenspace, with $\sin^2\beta\le1-3\alpha$, beating $\tfrac{3-5\alpha}{\sqrt3}$ pointwise in $\alpha$. That is a strictly larger problem than the one the note books.

## E9, confirmed, and the circularity is wider than the note says

"Conjecture A by name" is fair, literally. The proof of Theorem 4.19 at line 4838 reduces to $d\le\pi/6$ by running the gradient flow to a critical point $W(t_0)$ and splitting, and the second case reads "Then we find that $P(W)\le P(W(t_0))\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$ **by Conjecture A**". The note's sentence is accurate.

**Two things the note leaves out.**

- **Theorem 4.17 is itself conditional on Conjecture A, and says so.** Section 4.5 opens "Here we frequently use Conjecture A. More explicitely, we use the statement that $\max P=\sqrt{3/2}$ and that this maximum is only achieved by $W_{\mathbb{CP}^2}$ in dimensions between 8 and 12." That IS the input $f\le1$. So the circularity is not a feature of 4.19's far part that 4.17 escapes. It is the same assumption entering twice, once as the a-priori bound and once at the far critical point, and the note's measurement covers only the first entry.
- **At $n\ge12$ the tube is around the wrong point.** Theorem 4.17 localises around $W_{\mathbb{CP}^2}$, whose value is $f=1$, while at $n=12$ the conjectured maximum is $1.0092$ and is attained elsewhere. A de-circularised 4.17 at $n\ge12$ would give a tube around a NON-maximal critical point, which locates nothing about the maximiser at any $C$. This strengthens the note's own closing verdict and it is the reason the verdict holds independently of how the shell turns out.

**A conflict to route, not a defect in the note.** [plan.md](../plan.md) line 141 names this very question as I73's "one named target": "how weak an a-priori $P\le c$ runs that estimate at $n\ge12$". The note answers it and then concludes the answer "would not touch I73". Both cannot stand. On the reading above the note is right and the plan line is the thing to correct, because Theorem 4.17 is a statement about a neighbourhood of $W_{\mathbb{CP}^2}$ and I73 is a statement about the spectrum of a maximiser. The owning loop is armed in this session, so this is a repair here rather than a handoff.

## The second conclusion of Theorem 4.17, which the note does not measure

Theorem 4.17 asserts two things, that $f$ decreases on $(0,\pi/6]$ and that $f(\pi/6)<\sqrt{2/3}\,\Theta$. The note measures only the first. The second consumes the same input, through $f(\pi/6)\le\tfrac{3\sqrt3}8(1+\alpha)+\tfrac18g_C(\alpha)$.

**Screened, not evidence**: that bound is maximised at $\alpha=\tfrac13$ for every $C$ I tried, and at $C=1$ it returns $\tfrac{5\sqrt3}9=0.9622504486$, the source's own value to ten digits. At $C=1.0092$ it returns $0.9640$, against $\sqrt{2/3}\,\theta_0(12)=1.0092$, so the second conclusion has about $0.045$ of slack at the conjectured $C$ and is not what breaks first. At $C=\sqrt2$ it returns $1.0262$ and the slack is gone. **The note should say which of the two conclusions it is measuring**, because "Theorem 4.17's estimate" as written reads as both.

## Lean

The file compiles clean. The four identities are sound and I verified each by hand: `g1_stationary_factors` is the factorisation, `one_sub_sq_at_root` and `numerator_at_root` are correct at $x=\alpha/(1-\alpha)$, and `tight_at_top` is E6.

**The docstring claims more than the file proves, and it turns on `fderiv` being a definition.**

- **There is no `f` in the module.** `fderiv a g φ` is introduced by `noncomputable def` as the expression $3\sin\varphi[(2\alpha-1)\cos^2\varphi-\alpha\sin^2\varphi+\gamma\sin\varphi\cos\varphi]$, with no `deriv`, no `HasDerivAt`, and nothing connecting it to the potential along the circle. So `fderiv_at_pi_div_six` and `monotone_threshold` are facts about a named expression. The docstring's "`monotone_threshold`: `f'(π/6) < 0 ⟺ γ < (3 - 5α)/√3`, with `f'` written out" asserts the identification, and the identification is the ONE step in E4 where a calculus slip could hide. Everything the file checks is `ring` and `field_simp` arithmetic that was never the risk. **I verified the identification by hand and it is correct**, so the mathematics is sound and the module's advertised guarantee is not what it delivers.
- **Two names oversell.** `monotone_threshold` proves no monotonicity: it is a sign condition at the single point $\pi/6$, and the increasing-bracket step of E4 is untyped. `fderiv` collides with Mathlib's Fréchet derivative, which is resolvable inside the namespace and a trap for any file that opens it.
- **The "What is NOT stated" list omits the load-bearing omission.** It names the great circle, Theorem 4.14 and Weyl tensors, and leaves out that `fderiv` is not proved to be the derivative of anything.

**The repair is to the docstring, not to the proofs.** State that `fderiv` is the expression asserted elsewhere to be $f'$, and either rename `monotone_threshold` to a sign-at-$\pi/6$ name or add the increasing-bracket lemma that earns the current one. E2, E5, E7, E8 and E9 remain untyped, correctly so, since E7 and E8 are not statements Lean would carry usefully at this stage.

## Reach

**What these findings ARE about.** The internal correctness of the note's closed form and its numbers, the fidelity of the note and the Lean module to Nienhaus's text, and the size of the job the note books for the shell. E1, E2, E3, E4, E6 and E9 stand, E5 needs its quantifier rewritten, E7's table needs replacing, and E8's consequence needs both a corrected target and an enlarged problem statement.

**What they are NOT about.** Whether any $C>1$ is provable. I take $C$ as a hypothesis throughout, exactly as the note does, and the corrected $\alpha^*$ values inherit whatever status that hypothesis has, which at $n=12$ is conjectural. They are also not about whether the shell can be closed, and not about the value of $\max\gamma$ on the case-(c) eigenspace, which I did not compute and which the note books as owed-item 1.

**What was screened rather than established.** The single-crossing check on a grid, the brute-force minimum over $\varphi$, and the $g_2$ slack at $C=1.0092$. Each is a screen on objects already in hand. The bisected $\alpha^*$ values are 50-digit evaluations of the note's own closed form, so they are as exact as that form is, and E1 and E2 establish that form.
