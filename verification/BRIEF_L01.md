# Brief for round L01

**Verbatim extracts. Nothing here is paraphrased. THE RECORD STATES THIS ROW'S STATUS THREE INCOMPATIBLE WAYS AND ALL THREE ARE GIVEN, UNLABELLED.**

## A. The section's own framing, findings/problem.md lines 448-464

```markdown
## Lemma L1: the diagonal case at $n=12$ and $n=14$

**NEVER AUDITED, and OUT OF SCOPE.** The problem statement **grants** the diagonal case, and the setter knows Jäger's thesis covers only even $n\ge16$, the grant is meant to cover $n=12,14$ anyway. **So nothing in this project depends on Lemma L1**: what it depends on is the grant. Lemma L1 is a *correction offered to the setter* (the observation that the granted fact is unproven in print at exactly the threshold dimensions) and it is worth reporting for that reason alone. It is not a dependency, and it is not worth reviewer time.

**What it closes.** [Jäger's Theorem A](../references/jaeger-2016-diagonal-case/README.md) proves the diagonal case for **even $n\ge16$**, and the sentence following it leaves $n=12,14$ open. The problem statement grants the diagonal case, so at exactly the two dimensions where the conjecture first bites, the grant is not covered by the literature. Lemma L1 supplies them.

**The argument, in three steps.**

1. **The threshold is rounding slack in one lemma.** *One of those roundings is quantified: the report's Step 3 records $\operatorname{tr}S^4\le E(n)=(8n^2-41n+49)/(4(n+1)(n-2)(n-3))$ rounded to $16/(8n+9)$, valid at every $n\ge2$ since the cleared inequality is $41n-57\ge0$, and costing $(41n-57)$ over a quartic, $0.000885$ at $n=12$, about a sixty-fourth of Step 2's residual there. So no single rounding carries the threshold; the slack is cumulative ([JaegerRounding.lean](../lean/HamiltonsCubic/Results/JaegerRounding.lean)).* Every dimension constraint in Theorem A flows from Lemma 3.5.6, which needs a single quantity negative and bounds it through a chain of rational roundings, enough accumulated slack to cost four dimensions. Evaluating Jäger's own expression *exactly*, at his own case endpoints, already reaches $n=14$, with the signs certified symbolically rather than numerically ([run_jaeger_threshold.py](../scripts/lib/run_jaeger_threshold.py)).

2. **$n=12$ needs the true moment body, not the box.** Jäger bounds $\operatorname{tr}S^3$ and $\operatorname{tr}S^4$ separately, and the worst case puts one at its floor while the other sits at its ceiling. **That corner does not exist**: they are moments of a single operator, and the floor forces the flat spectrum, which drags the ceiling down with it. Pushing forward to $\mu=\sum\lambda_i^2\delta_{\lambda_i}$ (a probability measure since $\lVert S\rVert=1$), turns the requirement into $F(v)=\min\{\mathbb E[\lambda]:\mathbb E[\lambda^2]=v,\ \mathbb E[\lambda^{-2}]\le n\}$. That problem is convex, so its Lagrangian dual gives a supporting line valid at every value at once; rationalised, it reduces to a quartic nonnegativity statement settled by exact root isolation, yielding the certified line $\varphi(v)=\tfrac7{10}v+\tfrac{8647}{38000}\le\operatorname{tr}S^3$ ([run_jaeger_e5_certificate.py](../scripts/runs/run_jaeger_e5_certificate.py)).

3. **The one-dimensional remainder is discharged by validated interval arithmetic**, ten subintervals, each with a proven negative bound ([run_jaeger_e5a_interval.py](../scripts/runs/run_jaeger_e5a_interval.py)). So both dimensions are machine-checked rather than swept.

**Scope.** A census of every dimension hypothesis in Jäger's Chapter 3 confirms nothing else binds above $n=12$. Odd $n$ is untouched.

**Do not confuse this with [ATTEMPTS.md](../ATTEMPTS.md)'s Result 2**, which is an earlier and weaker thing. Result 2's own quartics have largest real roots $14.811$ and $14.963$, giving $n\ge15$ and hence even $n\ge16$, *exactly Jäger's threshold*. What Result 2 offers at $n=12,14$ is numerical global maximisation, together with the observation that the analytical route there would need one dominant term strengthened by $6.8\%$ and $28.4\%$ respectively. Its headline claimed more than its body, and has been corrected in place.
```

## B. The block, findings/problem.md lines 468-483

```markdown
#### Lemma L1, the granted diagonal case, repaired at the threshold dimensions, canonical statement and proof

*Moved here from [results.md](../results.md) on 2026-08-31. **The claim once made here, that results.md held the only copy, is false against the commit before the move**: this file already carried a block for this result.*

**Two** dimension constraints carry Theorem A. One is a lemma needing a single quantity to be negative, which it bounds through a chain of rational roundings, enough accumulated slack to cost four dimensions. Evaluating his own expression exactly, at his own case endpoints, already reaches $n=14$; **the endpoint evaluation is licensed by the source's own convexity, $\mathrm{RHS}''\ge0$, rather than by anything this record adds**, and the licence survives at $n=12,14$. The other is **Assumption 1, $m\ge8$, a standing hypothesis of his whole Chapter 3**, used again and genuinely at its §3.6 ideal-induction step, so the closure below rests on this record's own replacement for that step, the six-line graph argument recorded here as **Result 5b**.

> **THE FIRST VERSION READ "every dimension constraint flows from one lemma", AND THE CENSUS BELOW READ "nothing else binds above $n=12$", BOTH FALSE, AND THE CENSUS REPORTED THE OPPOSITE OF WHAT IT FOUND.**  **Result 5b is unnumbered, unindexed and has never been through Gate 2**, so L1 is conditional on it until it is.

$n=12$ needs one further observation. He bounds $\operatorname{tr}S^3$ and $\operatorname{tr}S^4$ separately, and the worst case puts one at its floor while the other sits at its ceiling, but they are moments of a single operator, and that corner does not exist: the floor forces the flat spectrum, which drags the ceiling down with it. Replacing the box by the true moment body closes the gap, **and the corner elimination is a genuine equality case rather than an estimate**: $S\succeq0$ with $\operatorname{tr}S^2=1$, and two Cauchy–Schwarz equalities bind only at the flat spectrum, where $\operatorname{tr}S^4$ sits at its floor. **The edge itself is $(\operatorname{tr}S^3)^2\le\operatorname{tr}S^4$**, with $1\le(\operatorname{tr}S)(\operatorname{tr}S^3)$ beside it; a box bounding the two traces separately admits $(\tfrac12,\tfrac15)$, which the edge excludes. Kernel-checked in [L1.lean](../lean/HamiltonsCubic/Results/L1.lean).

**The moment problem carries two hypotheses, and both are load-bearing.** $S=\mathrm{Ric}(\lvert W\rvert)/\lVert\mathrm{Ric}(\lvert W\rvert)\rVert$ is positive semidefinite of unit norm, so the measure is supported in $(0,1]$.

> **WITHOUT THAT SUPPORT CONSTRAINT THE MOMENT PROBLEM IS FALSE AS PRINTED.** Stated as $F(v)=\min\{\mathbb E[\lambda]:\mathbb E[\lambda^2]=v,\ \mathbb E[\lambda^{-2}]\le n\}$ alone, an atom at large $\lambda$ buys the $\mathbb E[\lambda^2]$ budget while relieving the $\mathbb E[\lambda^{-2}]$ constraint, pinning the value near $1/\sqrt{12}$ for every $v\ge1/12$, so the certified line exceeds it across most of the range the argument uses; and $\delta_{-1}$ is feasible, giving $\operatorname{tr}S^3=-1$. **The hypotheses lived in the scripts' docstrings and in no statement.** 

That moment problem's dual gives a supporting line valid at every value at once, and **weak duality alone licenses it**, so no constraint qualification is owed and the convexity appealed to here is surplus; rationalised, it reduces to a quartic nonnegativity statement settled by exact root isolation. The one-dimensional remainder is then discharged by validated interval arithmetic, ten subintervals, each with a proven negative bound. So both dimensions are machine-checked rather than swept.

```

## C. The index's status row, findings/INDEX.md line 19

```markdown
| The diagonal case, granted by the problem statement | **Proved outright at every $n\ge4$, odd included** (*by this record's own diagonal theorem, not by the grant*), see the row for odd $n$, so the grant is no longer load-bearing. Published at even $n\ge16$ (Jäger Theorem A). **$n=12,14$ are closed by Lemma L1**, exact evaluation at Jäger's own endpoints, a convex-duality step for $n=12$, and validated interval arithmetic. **But that proof lives only in [results.md](../results.md), not in [findings/](findings/), and has no ledger row, so its Gate 2 status is unrecorded.** Odd $n$ open |
```

## D. The index's file row, findings/INDEX.md line 45

```markdown
| [problem.md](problem.md) | **Lemma L1, the diagonal case at $n=12,14$, audited, and conditional on Result 5b.** The conjecture's identity, what the granted diagonal case covers in print, the $n\ge12$ threshold, the named families, the literature's actual scope |
```
