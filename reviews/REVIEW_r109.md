# Reviewer 109, fence post F25, the $g$-weighted collapse

**Verdict: the algebra is CONFIRMED and the consequence is REFUTED.** Every step of the claimed chain reproduces to $10^{-14}$ in an independent implementation, and the identity it lands on is correct. What fails is the sentence the post exists for, *"exploiting the internal structure of $g$ cannot sharpen"* the recorded bound. That is refuted three ways: the recorded bound does not have the stated form, the record already contained a counterexample when the post was written, and a new bound built from **exactly the substitution the post calls circular** cuts the recorded bound by $8$–$15\%$ at random Weyl tensors while leaving it exact at every symmetric-space point.

Scripts: [r109_collapse.py](../scripts/reviewers/r109/r109_collapse.py), [r109_anchor.py](../scripts/reviewers/r109/r109_anchor.py), [r109_consequence.py](../scripts/reviewers/r109/r109_consequence.py), [r109_validate.py](../scripts/reviewers/r109/r109_validate.py), [r109_isolate.py](../scripts/reviewers/r109/r109_isolate.py). Own construction throughout: random algebraic Weyl tensors by Bianchi projection plus Kulkarni–Nomizu trace removal, $\Lambda^2\cong\mathfrak{so}(n)$ through $e_i\wedge e_j\mapsto\phi_{ij}=E_{ij}-E_{ji}$ with $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$.

## The pipeline is anchored, so the numbers below are the record's numbers

Convention-independence was settled before anything else was measured: the pipeline returns $\theta(S^3\times S^3)=1.054092553389=\sqrt{10/9}$ and $\theta(S^4\times S^4)=1.145643923739=\sqrt{2-3/4+1/16}$, matching the record's $\theta_0(2k)^2=2-3/k+1/k^2$ exactly.

## Part 1, the algebra, CONFIRMED

| step | check | residual, $n=5,6,7$ |
|---|---|---|
| $T$ totally symmetric | all three transpositions | $\le2.8\times10^{-16}$ |
| row marginal | $\rho_\gamma=2(n-2)$ | $\le2.8\times10^{-14}$ |
| Prop 1.7 | $\lVert[\mathrm{ad}(v_\gamma),W]\rVert^2$ against $\sum(\lambda_\alpha-\lambda_\beta)^2T_{\gamma\alpha\beta}$ | $\le3.8\times10^{-15}$ |
| second moment | $\sum_\gamma g_\gamma=4(n-1)$ | $\le1.4\times10^{-14}$ |
| per-row identity | $\sum_\beta\lambda_\beta R_{\alpha\beta}=-2\lambda_\alpha$, every $\alpha$ | $\le2.1\times10^{-15}$ |
| the expansion | $2\,\mathrm{term}_1-2\,\mathrm{term}_2$ against $\sum_\gamma\lambda_\gamma g_\gamma$ | $\le1.1\times10^{-14}$ |
| first term | $\sum_{\gamma\alpha}\lambda_\gamma\lambda_\alpha^2R_{\gamma\alpha}=-2p_3(\lambda)$ | $\le9.0\times10^{-16}$ |
| landing | $\sum_\gamma\lambda_\gamma g_\gamma=-4\theta$ | $\le1.6\times10^{-15}$ |

Three points of detail the brief asked for.

- **The factor of $2$ is right, and it needs less symmetry than claimed.** Combining $\sum\lambda_\gamma\lambda_\alpha^2T_{\gamma\alpha\beta}$ with $\sum\lambda_\gamma\lambda_\beta^2T_{\gamma\alpha\beta}$ uses only $T_{\gamma\alpha\beta}=T_{\gamma\beta\alpha}$, which is automatic from $[v_\alpha,v_\beta]=-[v_\beta,v_\alpha]$ under the square. Total symmetry is needed one step later, not here.
- **The per-row substitution is legitimate and the index roles are sound.** It is applied as $\sum_\gamma\lambda_\gamma R_{\gamma\alpha}$ with $\gamma$ summed; the stated identity has the summed index second. The two agree because $R$ inherits symmetry from $T$'s $\gamma\leftrightarrow\alpha$ transposition, which is where total symmetry is actually load-bearing. Confirmed at $9\times10^{-16}$.
- **Two of the three ingredients are definitional in the eigenframe, not inputs.** Writing $[\mathrm{ad}(v_\gamma),W]$ in the eigenbasis gives $(\lambda_\beta-\lambda_\alpha)\langle[v_\gamma,v_\beta],v_\alpha\rangle$ entrywise, so Prop 1.7 *is* the Frobenius norm of that, one line. And $\sum\lambda_\gamma\lambda_\alpha\lambda_\beta T_{\gamma\alpha\beta}=2\langle W^\#,W\rangle$ is Hamilton's $\#$ written in the eigenframe, my implementation reproduces it at residual **exactly $0$**, because there is nothing to reproduce. The only substantive input to the whole chain is the per-row identity.

So the chain is: *the per-row identity implies $\sum\lambda_\gamma g_\gamma=-4\theta$.* It is a re-derivation of a recorded identity from a strictly stronger recorded identity. That a re-derivation returns the thing it re-derives is not a discovery about the route.

## Part 2, the consequence, REFUTED

### (a) The premise is false: the recorded bound does not use "only $g\ge0$ and $\sum g=4(n-1)$"

$\Delta=\sum_{\gamma\in\mathfrak p}g_\gamma$ and $G_0=\sum_{\gamma\in\ker W}g_\gamma$ are **distributional facts about $g$**, how its mass splits across the sign strata of the spectrum. The recorded bound is built on them. So the post's own premise sentence concedes that $g$'s internal structure is already being exploited, one clause before concluding that it cannot be.

### (b) The record already held a counterexample when the post was written

The [sharpened bound](../findings/target.md) $\theta\le(|\lambda_{\min}|M-\lambda_{\mathfrak p}^{\min}\Delta)/4$ keeps the discarded $\mathfrak p$ term through $B\ge\lambda_{\mathfrak p}^{\min}\Delta$ (more of $g$'s stratification, nothing else) and recovers **all** the slack at the $C_5$ blow-up, $0.894427\to0.670820=\theta$. That is a strict sharpening of the recorded bound by exploiting $g$'s internal structure, and it predates fence post F25 in the tree.

### (c) A constructive counterexample built from the very substitution called circular

Substitute Prop 1.7 into a **single** $g_\gamma$ rather than into the full $\lambda$-weighted sum:

$$g_\gamma=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{\gamma\alpha\beta}\ \le\ (\lambda_{\max}-\lambda_{\min})^2\rho_\gamma=2(n-2)(\lambda_{\max}-\lambda_{\min})^2=:c .$$

No collapse occurs, because the collapsing contraction was the sum over $\gamma$ against $\lambda_\gamma$, and this is not that. The cap then feeds a water-filling step: $\sum_{\gamma\in\mathfrak m}g_\gamma=4(n-1)-\Delta-G_0=:m$ exactly, so $\sum_{\mathfrak m}\lambda_\gamma g_\gamma$ is minimised by pouring $m$ onto the most negative eigenvalues subject to $g_\gamma\le c$, which is a linear programme in one variable per direction and solved by the greedy fill. Where a single $\lambda_{\min}$ direction cannot absorb $m$ (and it generically cannot, since $c\le4(n-2)<4(n-1)$ under $\lVert M\rVert_F=1$), mass is forced upward and the bound drops.

Isolating the cap's own effect, with the $\lambda_{\mathfrak p}^{\min}$ term of (b) switched off so the improvement is attributable to Prop 1.7 alone:

| point | $n$ | $\theta$ | recorded bound | with the cap | cut |
|---|---|---|---|---|---|
| $S^3\times S^3$ | 6 | $1.054093$ | $1.054093$ | $1.054093$ | $0\%$ |
| $S^4\times S^4$ | 8 | $1.145644$ | $1.145644$ | $1.145644$ | $0\%$ |
| max over 40 random | 5 | $0.446524$ | $1.366556$ | $1.218498$ | $10.8\%$ |
| max over 40 random | 6 | $0.235472$ | $1.385531$ | $1.276733$ | $7.9\%$ |
| max over 40 random | 7 | $0.133019$ | $1.432221$ | $1.216591$ | $15.1\%$ |
| max over 40 random | 8 | $0.088898$ | $1.431324$ | $1.284644$ | $10.2\%$ |

Stacked with (b) the cut is larger, over $240$ random Weyl tensors the maxima run $1.391\to1.124$, $1.387\to1.131$, $1.411\to1.204$, $1.381\to1.194$ at $n=5,6,7,8$, every one of them **below $\sqrt{3/2}=1.224745$**, which is precisely the deficiency [target.md](../findings/target.md) records as what the $\lambda$-weighted bound "does not yet give". Validity was checked rather than assumed: the cap is never violated (worst margin $-1.0$), and no bound ever fell below $\theta$ (worst margin $+0.43$).

*The honest limits of this witness.* Random Weyl tensors are not the live band, so this is not a claim that the band closes; and at $\Delta=0$ the cap is slack, so the sharpening buys nothing exactly where the recorded bound is already equality. What it does establish is the negation of a universal statement, and one witness suffices for that.

### (d) The inference is about the wrong category

The collapse is a statement about **equalities**: substituting Prop 1.7 into the identity $\sum\lambda_\gamma g_\gamma=-4\theta$ returns that identity. Of course it does, every rearrangement of an identity is equivalent to it, which is what "rearrangement" means, and $\theta=-(n-1)\mathbb E_g[\lambda]$ was labelled a rearrangement in the post's own opening sentence. Bounds, however, are made of **inequalities**, and the collapse computation contains none. The recorded bound is itself derived from that "inert" identity and is not inert, which settles the matter internally: an identity can carry no new equality and still be a productive source of inequalities, depending entirely on which relaxations one applies to which sub-sums. To support its conclusion the post would need to show that *every* inequality derivable from $g$'s definition yields a bound no better than the recorded one. It does not address inequalities at all.

### (e) The post's own closing paragraph contradicts its conclusion

It leaves open "the per-row identity used *directly* rather than as a collapsing step". But the per-row identity is a statement about $R_{\alpha\beta}=\sum_\gamma T_{\alpha\beta\gamma}$, and $g$ is a function of $\lambda$ and $T$. So the same object is fenced off in one paragraph and recommended in the next.

## Part 3, is the claim even new?

No. [bounds.md](../findings/bounds.md) already records "any contraction of Prop 1.7 against a $\gamma$-independent weight recovers only Lemma L30/31, and the very next weight returns $\theta$ itself", and records the analogous collapse for Petersen–Wink Prop 1.3 ("Combining it with $\theta=\sum\lambda^3+3\sum T\lambda\lambda\lambda$ yields nothing"). Fence post F25's computation is a third derivation of a fact already closed twice. Its only new content is the universal consequence, and that is the part that fails.

## Recommendation

Demote the post to a scoped remark and keep only what survives:

> **The $\lambda$-weighted contraction of Prop 1.7 returns $-4\theta$, so no new *equality* comes from that contraction.** Verified to $10^{-14}$ at $n=5,6,7$. It says nothing about inequalities: capping individual $g_\gamma$ by Prop 1.7 and water-filling the $\mathfrak m$-mass sharpens the recorded bound by $8$–$15\%$ at random Weyl tensors while preserving equality at every symmetric-space point.

And strike the sentence "exploiting the internal structure of $g$ cannot sharpen it" outright. The live question the post should have asked is the one its own counterexample raises: **what is the sharpest per-direction upper bound on $g_\gamma$ available on $\mathrm{Weyl}_n$**, since the crude $2(n-2)(\lambda_{\max}-\lambda_{\min})^2$ already moves the random-point maximum below $\sqrt{3/2}$, and the per-row identity is a second, unused source of exactly that kind of cap.
