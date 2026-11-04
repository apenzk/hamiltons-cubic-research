# REVIEW r498, Lemma L1 ("the granted diagonal case, repaired at the threshold dimensions")

**Target:** `findings/problem.md`, block beginning `#### Lemma L1` (~line 398) to the next heading.
**Reviewer:** r498, cold, independent. A second reviewer (r497) audits the same block in parallel; their log and report were not read.
**Footing:** analysis only. No searches, sweeps, censuses or falsifier hunts were run. L1's root isolation and interval arithmetic were NOT re-run by design; this audit is of the *reduction* to them and of the honesty of the block's claims.

## Phase plan

1. Read `findings/conventions.md`, `references/` notes for Jäger.
2. Read L1 verbatim.
3. Audit: what exactly is claimed, at which n, theorem vs proof.
4. Audit the n=14 half, endpoint evaluation and the missing interior argument.
5. Audit the n=12 half, S, its constraints, the tr S^3 floor / flat spectrum implication, relaxation vs true feasible set.
6. Audit the duality step, convexity of the right object, strong duality, constraint qualification.
7. Audit label (Lemma vs Observation) against the record's own convention.
8. Audit inputs L18, L20, used as their own statements permit?
9. Cross-check the record: other statements of the threshold, plan.md, results.md.

VERDICT: **PLAUSIBLE**

**The headline (Jäger's Theorem A extends to even $n=12$ and $n=14$), is likely true, and every step I could check independently checked out.** The mathematics is real: the transcription of Lemma 3.5.6 is faithful, the convexity that licenses endpoint evaluation is Jäger's own and I verified its numbers, the moment relaxation runs in the safe direction, the $\mathop{\mathrm{tr}}S^3$ floor genuinely forces the flat spectrum as an exact Hölder equality case, the duality step needs only weak duality and so needs no constraint qualification, and the exact quartic certificate holds on $(0,1]$.

**Three named gaps stop it short of CONFIRMED:**

| # | gap | where |
| --- | --- | --- |
| 1 | *"Every dimension constraint in Jäger's Theorem A flows from one lemma"* is **false**. Assumption 1 ($m\ge8$, i.e. $n\ge16$) stands over all of Chapter 3, and §3.6 uses it again genuinely. The closure depends on the record's Result 5b replacing that step, **never named in the block**, whose census sentence asserts the opposite of what the census found | F3 |
| 2 | The $n=14$ half is evaluated at a **single corner** $(v,y)=(E(14),1/14)$. $y$ at its floor is Jäger's monotonicity; $v$ at its ceiling is **not**, once the record sharpens the $2$ to a $v$-dependent coefficient. The interval script that covers the $v$-range is hard-coded `N = 12` | F7 |
| 3 | The moment problem **as printed is false**, it omits $S\succeq0$ and $\lambda\le1$, and the quartic's nearest root sits at $\lambda=1.000191$ | F6 |

Gap 1 refutes the block's opening sentence outright; gaps 2 and 3 are repairable in place. **REFUTED is not the verdict** because none of the three shows the conclusion false.

## Findings

(appended as found)

### F1 (context, not a defect). The record itself says L1 is unaudited and load-bearing on nothing

The section immediately above the canonical block, [problem.md](../findings/problem.md) line 378 `## Lemma L1: the diagonal case at $n=12$ and $n=14$`, opens: *"**NEVER AUDITED, and OUT OF SCOPE.** ... **So nothing in this project depends on Lemma L1**: what it depends on is the grant."* So the record's own position is that L1 is a courtesy correction to the setter. Anything below must be read against the brief's statement that L1 is cited 16 times, checked in Phase 9.

### F2 (verified, favourable). The endpoint-in-$t$ reduction is legitimate, and I checked it independently

Brief item 2 asks what rules out an interior maximum in $t$. The $t$-dependence of Jäger's RHS is the cubic
$f(t)=A t^3-Bt^2-Ct+\text{(t-free)}$ with $B=\tfrac{263}{144}\tfrac{n-3}{n^2(n-2)}>0$ and $A=B/(n\hat\theta_0)>0$,
so $f''(t)=6At-2B$ vanishes at $t=n\hat\theta_0/3$ and $f$ is convex above it. A convex function on a compact interval attains its max at an endpoint, so endpoint evaluation is sound **provided the whole $t$-interval $[\hat\theta_0/v,\ (n-3)\tilde\theta_0]$ lies above $n\hat\theta_0/3$.** I evaluated this:

| $n$ | $\tilde\theta_0$ | $\hat\theta_0$ | inflection $n\hat\theta_0/3$ | $t$ range |
| --- | --- | --- | --- | --- |
| 12 | 1.23413 | 1.37126 | 5.485 | [9.05, 11.11] |
| 14 | 1.26051 | 1.37510 | 6.417 | [10.44, 13.87] |

Both ranges sit strictly above the inflection. Endpoint evaluation is therefore valid at both dimensions. (Also: $v=(n-2)/(n-3)^2$ is exactly where $\hat\theta_0/v=(n-3)\tilde\theta_0$, i.e. where the interval degenerates, the script's `VMIN` is that point, consistently.)

**But the canonical block never says any of this.** The sentence *"Evaluating his own expression exactly, at his own case endpoints, already reaches $n=14$"* gives a reader no reason why endpoints suffice. The justification lives only in the closing `print` of [run_jaeger_threshold.py](../scripts/lib/run_jaeger_threshold.py) (*"convex in t (his RHS''>=0)"*) as an unproved attribution to Jäger. A proof block that omits the one hypothesis making its evaluation valid is not checkable as written.

### F3 (DEFECT, material). "Every dimension constraint in Jäger's Theorem A flows from one lemma" is false, and the block's census sentence conceals a second constraint plus an undeclared dependency

The canonical block opens: *"Every dimension constraint in Jäger's Theorem A flows from one lemma"*, and closes the scope paragraph with *"A census of every dimension hypothesis in his Chapter 3 confirms nothing else binds above $n=12$."* Both are contradicted by the thesis and by the record's own script.

- **Assumption 1 (thesis line 1705, p. 33) is $m\ge8$, standing for the whole of Chapters 3.1–3.6**, *"The following will be supposed to be true for the rest of the present work. Assumption 1. Let $m\ge8$ be an integer, and let $n=2m$."* Theorem 3.0.2 (line 1668) carries the same hypothesis. So $m\ge8$, i.e. $n\ge16$, is not downstream of Lemma 3.5.6; it is upstream of everything.
- **There is a second, genuine use of $m\ge8$ in §3.6**, thesis p. 86, the ideal-induction step: *"choose $l\in A_k$ with $l\notin\{a,b,c,d\}$ which is possible because $m\ge8$ and $\#A=m(m-1)$ by lemma 3.6.7."* This is a combinatorial index-count, wholly unrelated to Lemma 3.5.6's rounding chain.
- **The record knows this.** [run_jaeger_threshold.py](../scripts/lib/run_jaeger_threshold.py)'s header says the census returns *"m>=8 three times -- twice as the statement of Theorem 3.0.2 and Assumption 1, and once as a genuine use, the ideal-induction step in 3.6, which is precisely the step the six-line graph argument in findings/INDEX.md ('Reading Jaeger's diagonal-case proof', Result 5b) already replaces."*

So the $n=12,14$ closure has a **third input that the canonical block never names**: the record's own replacement of Jäger's §3.6 ideal step. L1 as written is not self-contained, and its census sentence asserts the opposite of what the census found.

A further weakening: the script describes the census as covering every *numeric* dimension hypothesis. A standing Assumption-1 hypothesis can be used without ever being written as an inequality (an index-count, a sign that happens to hold for large $n$). A census of written inequalities cannot certify "nothing else binds"; only a step-by-step re-derivation under $m\ge6$ can.

### F4 (verified, favourable). The transcription of Jäger's Lemma 3.5.6 is faithful, and two of the three monotonicity facts are Jäger's own

I read Lemma 3.5.6 in the record's own extraction, [diss_jaeger_florian.txt](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf) lines 4178–4330 (thesis pp. 72–73). The statement is *"Let assumption 1 hold. Then $\mathop{\mathrm{scal}}\ge(n+1)\tilde\theta_0(n)$"*, proved by contradiction from Assumption 2, $\mathop{\mathrm{scal}}\le(n-3)\tilde\theta_0(n)$.

- The RHS coded in [run_jaeger_threshold.py](../scripts/lib/run_jaeger_threshold.py) matches the thesis term for term: the $-\tfrac{263}{144}\tfrac{n-3}{n^2(n-2)}[t^2-t^3/(n\hat\theta_0)]$ head, the $-2\tilde\theta_0[\tfrac{2n-9}{4n^3}+\tfrac{3x}{8n^2}]t$ linear term with $x=n\mathop{\mathrm{tr}}S^4-1$, and the tail $2[\mathop{\mathrm{tr}}S^4+\sqrt{((\mathop{\mathrm{tr}}S^4)^2-(\mathop{\mathrm{tr}}S^3)^4)/(1-(\mathop{\mathrm{tr}}S^3)^2)}]$, which is exactly the script's `coeff*(v + sqrt((v**2-y**2)/(1-y)))` under $v=\mathop{\mathrm{tr}}S^4$, $y=(\mathop{\mathrm{tr}}S^3)^2$.
- **Convexity in $t$ is Jäger's**: he computes $\mathrm{RHS}''(t)=-\tfrac{263}{72}\tfrac{n-3}{n^2(n-2)}[1-\tfrac{3t}{n\hat\theta_0}]\ge0$ and concludes *"Thus, RHS is convex, and hence, it attains its maximum on the boundary."* His justification uses **his** left endpoint $\tfrac{8n+9}{16}\hat\theta_0$; the record's sharpening moves that endpoint **up** to $\hat\theta_0/E(n)$, so convexity survives a fortiori. F2's table is the same fact checked independently.
- **Monotonicity in $y$ is Jäger's**: $f(y)=((\mathop{\mathrm{tr}}S^4)^2-y^2)/(1-y)$ has $f'(y)=(y^2-2y+(\mathop{\mathrm{tr}}S^4)^2)/(1-y)^2\le0$ by his (3.16). So driving $y$ to its floor is conservative, and the record's replacement of the floor $1/n$ by $\varphi(v)^2\ge1/n$ is a legitimate tightening in the safe direction.

### F5 (verified, favourable). The moment argument is correct, and the duality worry dissolves, but for a different reason than the block gives

Brief items 3 and 4.

- **$S$ is $\mathrm{Ric}(\lvert W\rvert)/\lVert\mathrm{Ric}(\lvert W\rvert)\rVert$**, named only in the scripts. $\lvert W\rvert\succeq0$ forces $\mathrm{Ric}(\lvert W\rvert)\succeq0$, so $\lambda_i\ge0$; $\lVert S\rVert_F=1$ forces $\lambda_i\le1$; and $S$ is $n\times n$, so at most $n$ eigenvalues are nonzero.
- **The floor genuinely forces the flat spectrum, and it is an exact equality case, not an approximate one.** With $\mu=\sum\lambda_i^2\delta_{\lambda_i}$ a probability measure, $\mathbb E[\lambda^{-2}]=\#\{i:\lambda_i\ne0\}\le n$, and Hölder gives $1=\mathbb E[\lambda^{2/3}\lambda^{-2/3}]\le\mathbb E[\lambda]^{2/3}\mathbb E[\lambda^{-2}]^{1/3}\le\mathbb E[\lambda]^{2/3}n^{1/3}$, hence $\mathop{\mathrm{tr}}S^3=\mathbb E[\lambda]\ge n^{-1/2}$, i.e. $y\ge1/n$, **exactly Jäger's floor**. Equality in Hölder forces $\lambda$ constant, and equality in $\mathbb E[\lambda^{-2}]\le n$ forces exactly $n$ nonzero eigenvalues, so $\lambda_i\equiv n^{-1/2}$ and $v=\mathop{\mathrm{tr}}S^4=1/n$, the ceiling collapses to the floor. The block's sentence is right.
- **"Floor over a relaxation, not the true feasible set", and that is the safe direction.** $F(v)$ minimises over all probability measures meeting two linear constraints, a strict superset of the actual spectra (it drops integrality of the eigenvalue count and any further constraint the true $S$ carries). A min over a superset is $\le$ the true min, so $\varphi\le F\le\mathop{\mathrm{tr}}S^3$ still holds. The relaxation loses sharpness, never validity.
- **The duality step needs no constraint qualification, because validity never used duality.** The certificate is: $h(\lambda)=\lambda-\alpha\lambda^2+\beta\lambda^{-2}\ge\gamma$ pointwise on $(0,1]$ with $\beta\ge0$; take $\mathbb E$; use $\mathbb E[\lambda^{-2}]\le n$; get $\mathop{\mathrm{tr}}S^3\ge\gamma+\alpha v-n\beta$. That is **weak duality**, which is an inequality, not a theorem needing a CQ. The block's *"That moment problem is convex, so its Lagrangian dual gives a supporting line valid at every value at once"* names convexity and strong duality as the reason; **they are not the reason**. Convexity of $F$ and strong duality bear only on whether $\varphi$ is *tight*, which nothing here needs. So brief item 4's worry resolves benignly, the block's stated justification is superfluous rather than wrong.
- **Screen of the exact quartic** (seconds of `sympy`, on the polynomial I wrote out myself; reported as a screen). $q(\lambda)=-\tfrac7{10}\lambda^4+\lambda^3-\tfrac{613}{2000}\lambda^2+\tfrac1{152}$ has real roots $-0.12237$ and $1.000191$ only; none in $(0,1]$, and $q(1)=3/38000>0$. And $\gamma-n\beta=\tfrac{613}{2000}-\tfrac{3}{38}=\tfrac{8647}{38000}$, matching the block's intercept. **So the certificate is valid, with the nearest root at $\lambda=1.000191$.**

### F6 (DEFECT). The block omits the two hypotheses that make its own certificate true, and one of them holds by $2\times10^{-4}$

$\varphi(v)=\tfrac7{10}v+\tfrac{8647}{38000}\le\mathop{\mathrm{tr}}S^3$ is **false** without $S\succeq0$ and $\lambda\le1$, and the block states neither:

- Drop positivity: the measure $\delta_{-1}$ is feasible for the block's stated constraints ($\mathbb E[\lambda^2]=1$, $\mathbb E[\lambda^{-2}]=1\le n$) and gives $\mathop{\mathrm{tr}}S^3=-1$ against $\varphi(1)=0.9275$.
- Drop $\lambda\le1$: F5's screen puts the quartic's root at $\lambda=1.000191$. The domain bound is load-bearing to the fourth decimal.

The block's moment problem is written as $F(v)=\min\{\mathbb E[\lambda]:\mathbb E[\lambda^2]=v,\ \mathbb E[\lambda^{-2}]\le n\}$ with no domain and no sign condition. **As printed in [problem.md](../findings/problem.md), the statement is false; it becomes true only with the domain restriction that lives in the scripts.**

### F7 (DEFECT, the sharpest gap). Nothing covers the $v$-direction at $n=14$

The block's $n=14$ half is *"Evaluating his own expression exactly, at his own case endpoints"*. In [run_jaeger_threshold.py](../scripts/lib/run_jaeger_threshold.py), `certify` evaluates at the two $t$ endpoints with $v$ **fixed at the ceiling $E(n)$** and $y$ **fixed at the floor $1/n$**. That is one corner of a two-dimensional feasible region.

- $y$ at its floor is licensed by Jäger's $f'(y)\le0$ (F4). ✓
- $v$ at its ceiling is licensed by Jäger's own argument **only with his coefficient $2$**, where the $v$-dependence collapses to a monotone $x$-term. The record's sharpening (2) replaces $2$ by $(2\sqrt2/\hat\theta_0)\sqrt{1-v}$, which is *decreasing* in $v$, and the left endpoint $t=\hat\theta_0/v$ is also $v$-dependent. **Jäger's monotonicity in $v$ therefore does not transfer to the sharpened expression, and the record never re-derives it.**
- At $n=12$ this is repaired: [run_jaeger_e5a_interval.py](../scripts/runs/run_jaeger_e5a_interval.py) encloses the whole range $v\in[10/81,\,709/4680]$ by adaptive interval arithmetic. **That script is hard-coded `N = 12`.** No interval run, and no monotonicity proof, covers $v$ at $n=14$ anywhere in the record.
- The record knows the step is missing at $n=12$ and says so, [run_jaeger_e5_certificate.py](../scripts/runs/run_jaeger_e5_certificate.py) closes with *"REMAINING for a fully machine-checked proof: replace that last one-dimensional monotonicity/Lipschitz step by interval arithmetic"*, and then supplies it only at $n=12$.

I spot-checked the direction by hand at $n=14$ (derivative of the sharpened RHS in $v$ at the upper $t$ endpoint $\approx+3.1$), so the corner is probably the right one. **That is my arithmetic, not the record's proof.** Closing this is a one-line change to E5a, `N = 14`, with $E(14)=1043/7920$, $v_{\min}=(n-2)/(n-3)^2=12/121$, and the $\varphi$ certificate recomputed at $n=14$ (the intercept $\gamma-n\beta$ is $n$-dependent, so the $n=12$ line cannot be reused). **That run would decide whether the $n=14$ claim is proved or merely evaluated at a corner; I have not run it, per the analysis-only rule.**

### F8. What is actually claimed, and the theorem/proof interchange (brief item 1)

L1 does not prove "Theorem A holds for $n\ge12$". It proves, at most: *Jäger's Lemma 3.5.6 holds at $n=12$ and $n=14$*, plus a census. Converting that into Theorem A at $n=12,14$ requires re-running the whole of §§3.1–3.6 with **Assumption 1's $m\ge8$ weakened to $m\ge6$**, which F3 shows is not done, the §3.6 step is *replaced* by other work of the record's, not re-derived.

The record then states the stronger form in several places: [results.md](../results.md) line 12 *"The diagonal case … **Proven**"*, [findings/INDEX.md](../findings/INDEX.md) line 19 *"$n=12,14$ are closed by Lemma L1"*, [findings/LEDGER.md](../findings/LEDGER.md) line 19 *"$n=12,14$ are closed by **Lemma L1**"*. **The interchange the brief asks about is real and is in the record.**

### F9. The brief's premise about inputs is not borne out (brief item 6)

**L1's canonical block cites no numbered result, not L18, not L20, nothing.** Its inputs are Jäger's thesis, [run_jaeger_threshold.py](../scripts/lib/run_jaeger_threshold.py), [run_jaeger_e5_certificate.py](../scripts/runs/run_jaeger_e5_certificate.py), [run_jaeger_e5a_interval.py](../scripts/runs/run_jaeger_e5a_interval.py), plus the undeclared Result 5b of F3. So there is no L18/L20 strengthening to check; L1 is a leaf. (L18 sits at [problem.md:262](../findings/problem.md) and belongs to the record's *own* diagonal theorem track, L57, which is a different argument that does not pass through L1.)

### F10. Label, and what it should be (brief item 5)

[INDEX-results.md](../findings/INDEX-results.md)'s own rule: *"**Lemma** is proven, Gate 1 and Gate 2 passed."* Row 1 carries no Gate 2 marker, and [problem.md:380](../findings/problem.md) and [LEDGER.md:52](../findings/LEDGER.md) both say **NEVER AUDITED**. By the record's own rule the label is unearned today, and [ELIM-canon.md](ELIM-canon.md) Stale-5 already said so.

**The interval arithmetic is not the problem.** Validated enclosures with a proven negative upper bound on each subinterval are a proof, not a numerical verification, so "ten subintervals" is no argument for demoting to `Observation`. What blocks `Lemma` is F3 (a second dimension constraint, discharged by an uncited input), F6 (a statement that is false as printed), and F7 (an uncovered direction at $n=14$).

**Recommended label:** keep the number, but state it as *conditional*, `Lemma L1 (conditional on the §3.6 replacement, Result 5b)`, with the $n=14$ half marked as evaluated at Jäger's corner pending the E5a run at $N=14$, and $S\succeq0$, $\lambda\in(0,1]$ written into the moment problem.

### F11 (bookkeeping). Five stale pointers and one live contradiction

- **Stale location.** [findings/INDEX.md:19](../findings/INDEX.md), [findings/LEDGER.md:19](../findings/LEDGER.md), [findings/diagonality.md:77](../findings/diagonality.md) and [results.md:765](../results.md) all locate L1's proof in [results.md](../results.md). The block's own italic header says it *"Moved here from results.md on 2026-08-31"*. Four pointers to a proof that is no longer there.
- **Live contradiction.** [findings/INDEX.md:45](../findings/INDEX.md) reads *"Lemma L1, the diagonal case at $n=12,14$, never audited **and load-bearing**"*, against [problem.md:380](../findings/problem.md) and [LEDGER.md:52](../findings/LEDGER.md)'s *"nothing in this project depends on Lemma L1"*. Already found by [ROUND_L00.md](../verification/ROUND_L00.md) and acted on in [plan-verification.md:140](../plan-verification.md); INDEX.md line 45 is still unfixed.
- **Provenance hazard.** [references/jaeger-2016-diagonal-case/notes.md](../references/jaeger-2016-diagonal-case/notes.md)'s section *"Where the dimension threshold actually comes from"* is the record's **own** L1 conclusion written into the reference notes in the same words, with no marker that it is not a note on the source. A reader checking L1 against the notes finds L1 again. That section should be moved under an explicit "this record's claim about the source" heading.

### On the brief's framing of stakes

The brief says *"If L1 fails, the programme's starting hypothesis is not established at its own threshold."* **The record disagrees, and the record is right on this point:** [results.md:12,35,47](../results.md) carry the diagonal case at every $n\ge4$, both parities, by **Lemma L57**, an independent argument that does not route through Jäger. L1's failure would cost the correction offered to the setter, not the programme's starting hypothesis. (This says nothing about whether L57 itself holds, outside this brief.)
