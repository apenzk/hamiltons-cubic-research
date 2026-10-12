# Brief for round L13

**Verbatim extracts. Nothing here is paraphrased. Where the record states the same thing twice, both are given unlabelled.**

## A. The canonical entry, results.md lines 577-579

```markdown
##### Lemma L13, spectral-moment method

**Proof:** [curvature-invariants.md](findings/curvature-invariants.md)
```

## B. The landscape statement, results.md line 186

```markdown
- **Lemma L13 (direct). Spectral-moment method.** Proven to be the wrong invariant for this problem: the method has a hard ceiling that no refinement of it escapes, landing $58.9\times$ short at $n=12$.
```

## C. The block, findings/curvature-invariants.md lines 62-79

```markdown
#### Lemma L13, the spectral-moment ceiling, and what it does and does not close


> **THE PROVENANCE NOTE WAS FALSE IN BOTH CLAUSES, AND THE MOVE WAS A COPY.** It read *"moved here from results.md, where the argument was the only copy; that file now carries the statement and points here."* [results.md](../results.md) carries this paragraph **verbatim** and then points back here (*a circular pointer*) and [ATTEMPTS.md](../ATTEMPTS.md) already held a fuller derivation at the move commit's parent, so `results.md` was never the only copy. **The record bars [ATTEMPTS.md](../ATTEMPTS.md) from carrying a numbered result's proof**, so the repair is transcription rather than striking, and it is owed.

> **"THE WRONG INVARIANTS" IS BACKWARDS.** $L_WW=\theta W$ and the Peirce cap puts every other eigenvalue at $\le\theta/2$, so $\theta=\lambda_{\max}(L_W)$ at any local maximum; the moment sequence determines the characteristic polynomial and hence $\theta$ **exactly**. *The moments are complete invariants for $\theta$.* What is genuinely proven concerns the **second moment alone**, $\operatorname{tr}(L_W^2)$ is constant in $W$, so that one moment carries nothing beyond the norm. The route stays closed; the reason recorded for closing it was a stronger claim than the evidence, and [second-order.md](second-order.md) already records **this diagnosis stands as a heuristic** while the theorem-grade version sits unlinked in the same file.

> **THE LABEL IS WRONG IN BOTH DIRECTIONS, SO THE BLOCK SPLITS THREE WAYS.** The ceiling $\theta\le2-o(1)$ against a true value $<\sqrt2$ is a **Lemma**, derived at every $n$ by compression from criticality, needing no cap. The constant $\kappa_n=(n-1)(2n-1)/4$ is proven at **even $n\ge6$ only** and remains a fit at odd $n$ (*which the $n\ge12$ range contains*) so it is an **Observation** at the dimensions named; closing it is one analytic lemma, $\kappa_n\dim\mathcal W_n=\lVert T\rVert^2$ for the symmetric trilinear form, one contraction and no run. The margins are **measured at $n=12,14,20,100$** by grid search on a level-3 bound this block never displays.

> **THE EXCESS AT $n=12$ IS $58.9\times$, AND THE DISPUTED READING IS OUT OF RANGE.** *Settled by exact rational bracketing in [L13.lean](../lean/HamiltonsCubic/Results/L13.lean); no root is taken anywhere in it.* **Both reviewers were partly right.** a prior audit's denominator is the block's: read as $(\text{bound}-\theta_0)/(\theta_0-\sqrt{3/2})$, the asymptotic figure comes out strictly between $3.09$ and $3.10$, matching what the block prints. **Applied at $n=12$ that same formula gives strictly between $58$ and $59$**, a prior audit's figure, derived from the block's own inequality. And $58.9$ is not a competing reading but an unreachable one: $\lambda^2(1+\tfrac{k_0}4)\le\tfrac{(n-1)(2n-1)}4$ with the admissible maximum $k_0=\binom{12}2=66$ gives $\lambda^2\le\tfrac{253}{70}$, and larger $k_0$ only lowers $\lambda$, so reaching $58.9$ needs $k_0\ge74>66=\dim\mathfrak{so}(12)$. **The figure is now $58.9\times$ throughout the record.**

> **ONE CLAUSE IS REFUTED OUTRIGHT AND IS HARMLESS.** *"Attained on a subspace of dimension exactly $\dim(O(n)\cdot u)$"* is false, [second-order.md](second-order.md) gives $18$ against $9$ at $S^3\times S^3$ and $60$ against $21$ at $S^2\times S^3\times S^3$. Only *"at least"* is used downstream. The Peirce cap also needs **local maximality**, not criticality alone; the chain survives because it uses only the orbit-tangent equality.

*Symbols this block leaves undefined: $B$, $u$, $\lambda$ and $k_0$. Its $B$ is a fourth sense of a letter [conventions.md](conventions.md) already flags as live, and its $\lambda$ is the record's $\theta$ while the record's $\lambda$ is a $\Lambda^2$ eigenvalue.*

The result here is a proof about the method rather than about the bound: spectral moments of $L_u$ are the wrong invariants for this problem, so the whole approach is closed with a measured margin rather than left as a maybe. Studying the multiplication operator $L_u\colon H\mapsto B(u,H)$ gives $\operatorname{tr}(L_W)=0$, $\operatorname{tr}(L_W^2)=\tfrac{(n-1)(2n-1)}4\|W\|^2$, and a Peirce cap at $\lambda/2$ on $u^\perp$ attained on a subspace of dimension exactly $\dim(O(n)\cdot u)$, together yielding $\lambda^2(1+\tfrac{k_0}4)\leq\tfrac{(n-1)(2n-1)}4$ from criticality alone. Since $k_0\leq\binom n2$, the method's ceiling is $\lambda\leq2-o(1)$ against a true $\sqrt2$: an excess of $58.9\times$ at $n=12$ and $3.09\times$ asymptotically, and the fourth moment reaches only $14\times$ even granting an oracle. The diagnosis is structural, $\operatorname{tr}(L_W^2)$ is constant in $W$, so it carries no information beyond the norm, and spectral moments of $L_u$ are simply the wrong invariants for this problem.

```
