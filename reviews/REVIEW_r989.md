# REVIEW r989: L35's owed one-negative case, and whether theta <= 0 there

Gate 2, independent adversarial review of the derivation quoted in [BRIEF_I48_one_negative.md](BRIEF_I48_one_negative.md). Cold read: the findings files, the working notes, the screen and the Lean file under review were left unopened, and every verdict below is argued from the brief's definitions alone.

Log: [agent_logs/r989-one-negative.log](../agent_logs/r989-one-negative.log)

## Verdicts

| # | claim | verdict |
|---|---|---|
| 1 | one negative eigenvalue is exactly $bc=0$, hence exactly $s^2=1-u$ | CONFIRMED |
| 2 | with $c=0$, $-b^3-c^3+6Abc$ equals $-s^3$ | CONFIRMED |
| 3 | $s^2-u\ge0$ always | CONFIRMED |
| 4 | $A\le s$ | CONFIRMED, conditional on $\{-b,-c\}$ exhausting the negatives |
| 5 | the collapse identity $A^3+Ad+A(s^2-u)-s^3=s^2(A-s)$ | CONFIRMED |
| 6 | bounding both $\min$ factors by $A$ is legitimate | CONFIRMED |
| 7 | equality forces $A=s$, one positive eigenvalue | CONFIRMED, with a correction of emphasis |
| 8 | therefore $\theta\le0$ on the one-negative stratum | PLAUSIBLE, and the direct route retires the risk |
| 9 | the result is not vacuous | CONFIRMED, with a cheaper route that supersedes the derivation |
| 10 | the $c\to0$ line genuinely fails | CONFIRMED, with the reason relocated |

## Claim 9: the stratum is nonempty, and the bound on it is sharp

**Nonempty, by an explicit algebraic Weyl tensor.** In $m=4$ the Singer-Thorpe splitting makes $\mathrm{Weyl}_4=S^2_0(\Lambda^2_+)\oplus S^2_0(\Lambda^2_-)$, so any pair of trace-free symmetric $3\times3$ blocks is a genuine Weyl tensor. Take $W_+=\mathrm{diag}(1,1,-2)/\sqrt6$ and $W_-=0$. Its spectrum on $\Lambda^2\mathbb R^4$ is $(1,1,-2)/\sqrt6$ together with three zeros, which is **exactly one negative eigenvalue**. So the owed case is a real case and the finding is not vacuous.

**What vacuity would have looked like.** Trace-freeness forces the single negative to balance every positive, so a reader might expect the stratum to be cut out entirely by the Bianchi identity, exactly as the $m=4$ two-block count nearly does: a nonzero trace-free block carries at least one negative eigenvalue, so **both blocks nonzero forces at least two negatives**. The stratum survives only on the (anti-)self-dual locus $W_-=0$ or $W_+=0$. That is positive codimension and nonempty, which is the distinction between a thin case and an empty one.

**The bound is attained.** $W_+=\mathrm{diag}(1,-1,0)/\sqrt2$, $W_-=0$ is a Weyl tensor with spectrum $(1,-1)/\sqrt2$ plus four zeros, $A=s=1/\sqrt2$, and $\theta=0$: no triple has three nonzero eigenvalues, so the $T$ term vanishes and $\Sigma\lambda^3=0$. The equality case of claim 7 is therefore realised rather than merely permitted, and $\theta\le0$ cannot be improved to a strict inequality on the stratum.

**Screen** (constructed objects, seconds of compute, reported as a screen). Building $\mathfrak{so}(4)=\Lambda^2\mathbb R^4$ with $\langle X,Y\rangle=\tfrac12\mathrm{tr}(X^\top Y)$ and the self-dual/anti-self-dual basis, then computing $T_{\alpha\beta\gamma}$ and $\theta$ from the definition: for $(1,1,-2)/\sqrt6$, $\theta=-1.2247$ against the derivation's bound $s^2(A-s)=-0.2722$; for $(1,-1,0)/\sqrt2$, $\theta=0$ against bound $0$; for $(3,2,-5)/\sqrt{38}$, $\theta=-1.1526$ against $-0.2134$. Controls asserted rather than printed: the basis is orthonormal, $T$ is totally symmetric, $\max_{\alpha\beta}\sum_\gamma T_{\alpha\beta\gamma}\le2$, each spectrum is trace-free and unit-norm with exactly one negative entry, and $\theta\le s^2(A-s)$ in each case. The pair cap is attained at exactly $2$, so the constant in the $6Abc$ step is the sharp one.

### The cheaper route the brief asked about, and it exists

**$\theta\le0$ on the one-negative stratum follows in three lines from the two ingredients the chain is built out of, without $G$, $M$, $h$, $K_0$, or the unit norm.** Write the single negative as $-s$, the positives as $\lambda_P$ with top $A$ and $u=\sum_P\lambda_P^2$, so trace-freeness gives $\sum_P\lambda_P=s$.

1. $\sum_\alpha\lambda_\alpha^3=\sum_P\lambda_P^3-s^3\le A\sum_P\lambda_P^2-s^3=Au-s^3$, since each positive is at most $A$.
2. Every triple containing the negative index has product $-s\lambda_a\lambda_b\le0$, and $T\ge0$, so those triples are dropped. No triple carries two negative indices, there being one.
3. For the all-positive triples, total symmetry gives $3\sum_{a<b<c}T_{abc}\lambda_a\lambda_b\lambda_c=\sum_{a<b}\lambda_a\lambda_b\sum_{c\notin\{a,b\}}T_{abc}\lambda_c\le2A\sum_{a<b}\lambda_a\lambda_b=A(s^2-u)$, using $\lambda_c\le A$, $T\ge0$ and the pair cap.

Adding: $\theta\le Au-s^3+A(s^2-u)=As^2-s^3=s^2(A-s)\le0$. **The $u$ cancellation and the final expression are identical to the derivation's**, which says the recorded chain is a longer path to the same crude bound in this case.

**Why this matters for the finding rather than against it.** The stratum is nonempty, so the case is worth closing, and the derivation closes it correctly. What it buys is smaller than it looks: the same conclusion is available without invoking $G$ or $R$ at all, and the direct route is strictly preferable because it **inherits none of the recorded chain's hypotheses**, which is precisely the exposure claim 8 asks about. Recommendation: record the three-line argument as the proof of the one-negative case and keep the $R$-route as a consistency check.

**Sharper still in $m=4$.** There the one-negative stratum lives in a $3\times3$ block, so it has at most two positive eigenvalues, no all-positive triple exists, step 3 is empty, and $\theta\le Au-s^3=-3A^2p-2Ap^2-p^3<0$ for positives $A\ge p>0$. The triangle-packing machinery is vacuous on the whole $m=4$ stratum.

## Claims 3 to 7: the algebra core

**Claim 3, $s^2-u\ge0$. CONFIRMED.** Trace-freeness makes $s$ the sum of the positives, so $s^2=\left(\sum_P\lambda_P\right)^2=u+2\sum_{a<b}\lambda_a\lambda_b$, giving $s^2-u=2\sum_{a<b}\lambda_a\lambda_b\ge0$ as a sum of products of nonnegative numbers. Equality holds exactly when at most one positive is nonzero. It cannot go negative, so the step that multiplies by it never inverts. Note the Lean status: `hsu` is a hypothesis binder, so Lean assumes this rather than proving it, and the discharge above lives outside the formalisation.

**Claim 4, $A\le s$. CONFIRMED, and it carries one condition worth naming.** $A$ is one summand of $\sum_P\lambda_P=s$ and the others are nonnegative, so $A\le s$. The positive set is nonempty: trace-freeness with $\lVert W\rVert=1$ forbids an all-nonpositive spectrum, so $A>0$ and $s>0$. **$A>s$ requires $s$ to stop being the sum of the positives, and the one way that happens is a negative eigenvalue outside $\{-b,-c\}$**: with a third negative $-e$, trace-freeness gives $\sum_P\lambda_P=b+c+e>s$, and $A\le s$ can then fail. So claim 4 is exactly as strong as the standing hypothesis that the negatives are exhausted by $-b,-c$, which in the case at issue means $-b$ is the only negative eigenvalue. Everything downstream inherits that condition, `hAs` included.

**Claim 5, the collapse. CONFIRMED.** Substituting $d=u-A^2$: $A^3+A(u-A^2)+A(s^2-u)-s^3=A^3+Au-A^3+As^2-Au-s^3=As^2-s^3=s^2(A-s)$. The $A^3$ terms cancel against the $-A^3$ from $Ad$, and $u$ cancels between $Ad$ and $A(s^2-u)$, so $u$ genuinely drops out. The surviving factor is $(A-s)$ and not $(s-A)$, which is the orientation that makes the sign argument work. Screen: symbolic expansion of the difference against $s^2(A-s)$ returns identically zero.

**Claim 6, replacing both minima by $A$. CONFIRMED, and the direction is right.** $\min(A,\sqrt d)\le A$ and $\min(A,K_0\sqrt d)\le A$ hold by definition of a minimum. They are applied to the coefficients of $d$ and of $s^2-u$, and **raising a coefficient raises the term only when the multiplier is nonnegative**, which is exactly what $d\ge0$ and $s^2-u\ge0$ supply. $d\ge0$ because $u=\sum_P\lambda_P^2$ includes $A^2$ as a summand of nonnegative terms. So $G\le R\le A^3+Ad+A(s^2-u)-b^3-c^3+6Abc$, and this last quantity is what claim 5 collapses. A multiplier of either sign would invert the step, so the brief's instinct to check them is the right one, and both survive. With $c=0$ the collapse gives $s^2(A-s)\le0$ by claim 4.

**Claim 7, the equality case. CONFIRMED, with a correction of emphasis.** $s^2(A-s)=0$ forces $s=0$ or $A=s$, and $s=0$ is excluded by claim 4's $s>0$, so $A=s$. Then the remaining positives are nonnegative and sum to zero, hence vanish, so exactly one positive eigenvalue is nonzero and the spectrum is $(1,-1)/\sqrt2$ **padded by zeros**, the padding being obligatory for $m\ge3$ since $\dim\Lambda^2\ge3$. Two corrections:

- **Equality in the bound is not equality in $\theta$.** The chain is $\theta\le G\le R\le s^2(A-s)$, so $s^2(A-s)=0$ says only that the bound stops being negative, and $\theta=0$ there needs its own check. It does hold: at that spectrum no triple has three nonzero eigenvalues, so the $T$ term vanishes and $\sum\lambda^3=0$. Claim 9's second witness realises it as an actual Weyl tensor, so the equality case is inhabited rather than merely permitted.
- **As pure algebra over $(A,s,u,d)$ the $s=0$ branch is not excluded**, and there $A=s=0$ holds while "one positive eigenvalue" is false. Any Lean statement of `equality_iff_single_positive` that reads the conclusion spectrally therefore needs $0<s$, which the unit norm supplies, among its hypotheses.

## Claim 8: does the chain $\theta\le G\le R$ reach the one-negative case

**PLAUSIBLE.** Every ingredient the brief quotes survives $c=0$, and each one degenerates to an equality or to a vacuous bound rather than inverting. What cannot be settled from a cold read is whether the unquoted derivation of those ingredients is written in a form that presumes a genuine pair of negatives, and that is the residual risk.

**Ingredient by ingredient at $c=0$.**

- **Nonnegativity, used to drop the $(+,+,-)$ triples.** The dropped terms have product $\lambda_a\lambda_b\cdot(-b)\le0$ with $T\ge0$. At $c=0$ the triples through the index labelled $-c$ have product exactly $0$, so they are dropped at equality. Survives.
- **The pair cap $\sum_\gamma T_{\alpha\beta\gamma}\le2$ and total symmetry.** Both are statements about $T$ alone, with no reference to eigenvalue signs or counts. Survive untouched.
- **The $6Abc$ term.** It bounds the $(-b,-c,\gamma)$ triples, whose true contribution at $c=0$ is $0$, against a bound of $0$. Survives at equality, and it is the only term in $G$ that mentions both negatives.
- **$\sum_P\lambda^3\le A^3+\min(A,\sqrt d)d$, $3M\le h(s^2-u)$ and $h\le\min(A,K_0\sqrt d)$.** All three quantify over the positives only. Nothing in them reads the negative block, so the number of negatives is invisible to them. With fewer than three positives the packing $M$ is empty and the bound is nonnegative, so it still holds.
- **$bc=(s^2-1+u)/2$.** From $b^2+c^2+u=1$ and $s=b+c$, an identity in $b,c\ge0$ that is as valid at $c=0$ as anywhere else.

**So the relaxation is continuous at $c=0$ and is attained there**, which is why putting $c=0$ in directly is sound in a way the limit argument of claim 10 is not: the objection to the limit was never about $R$ being discontinuous.

**The residual risk, stated precisely.** The parameterisation "the negative eigenvalues written $-b,-c$" is the only place two-negativity could hide. Two things would break the reach and neither is visible from the brief: a derivation of the $6Abc$ step that divides by $bc$ or that selects $A$ as the top eigenvalue using the presence of the second negative, and a branch condition upstream establishing "at most two negatives" that is itself conditional on there being two. **Both are unreadable on a cold brief by construction, so the verdict stays PLAUSIBLE rather than CONFIRMED.** The fix is not more reading: the three-line argument recorded under claim 9 proves $\theta\le0$ on the stratum without $G$ or $R$ at all, so adopting it makes the question moot.

**A bookkeeping trap that is real rather than hypothetical.** At $c=0$ the index labelled $-c$ carries a zero eigenvalue, and the $m=4$ witness has **three** zeros, only one of which can take that label. The other two sit in the positive set $P$ with value zero. They contribute nothing to $s$, $u$, $d$ or $M$, so the relaxation is unaffected, but **any statement whose hypotheses require the members of $P$ to be strictly positive fails to cover the witness**. Whichever form the Lean binders take, $P$ must be the nonnegative part rather than the strictly positive part.

**One correction to the derivation's own summary.** "The bound uses neither the unit norm nor the one-negative locus" is true of the final algebraic step, which needs only $A\le s$, $d\ge0$ and $s^2-u\ge0$. It is not true of the conclusion $\theta\le0$: the identity defining $\theta$ is stated as requiring $\lVert W\rVert=1$, and $s>0$ in the equality analysis comes from the same place. The honest statement is that the **collapse** is free of both, while the chain feeding it is not.

## Claims 1, 2 and 10: the locus, the collapse of the negative block, and the failed limit

**Claim 1. CONFIRMED.** From the given $bc=(s^2-1+u)/2$, the equivalence $bc=0\iff s^2=1-u$ is immediate. That $bc=0$ is *exactly* one negative eigenvalue rather than at most one needs the excluded branch: $b=c=0$ means no negative eigenvalues at all, trace-freeness then forces every eigenvalue to zero, and that contradicts $\lVert W\rVert=1$. So $bc=0$ picks out exactly one negative, conditional as ever on $\{-b,-c\}$ exhausting the negatives.

**Claim 2. CONFIRMED.** At $c=0$, $s=b+c=b$, so $-b^3-c^3+6Abc=-b^3=-s^3$. Nothing else in the negative block survives, which is what makes the collapse of claim 5 available.

**Claim 10. CONFIRMED, with the reason relocated.** The two loci are as the brief says. The one-negative locus is $s^2=1-u$, the face the two-negative endgame maximises over is $b=c$, which is $s^2=2-2u$, and $1-u<2-2u$ exactly when $u<1$. On the stratum $u=1-b^2-c^2$ with $b>0$, so $u<1$ holds and **the one-negative locus is strictly interior to $\{s^2<2-2u\}$, never on the face**. A maximisation carried out on the face therefore constrains nothing at $bc=0$, and letting $c\to0$ leaves the face at once instead of sliding along it.

**The reason is the endgame, not $R$.** $R$ is a polynomial in $(A,s,u,b,c)$ and is perfectly continuous at $c=0$, so $\lim_{c\to0}R=R|_{c=0}$ and the failure cannot be a discontinuity. What fails is the *route*: the recorded endgame reaches its conclusion by a monotonicity step onto $b=c$, and the limit point is not in the region that step controls. **This is what makes the derivation under review a different argument rather than the same one restated.** It replaces the monotonicity step with a direct substitution and a crude bound.

**A control, asserted.** The crude bound is available only at $bc=0$, so it cannot be a disguised rerun of the two-negative endgame. Writing $R'$ for $R$ with both minima replaced by $A$, expansion gives $R'=s^2(A-s)+3bc(s+2A)$ identically. The second term is strictly positive whenever $bc>0$, and at $A=s$ it is all that remains, so $R'>0$ there and the min-to-$A$ step provably fails to close any two-negative case. Screen: symbolic expansion returns the two forms equal, and $R'=9/4$ at $b=c=1/2$, $A=s=1$.

## Summary and what to change

The derivation is **correct and it closes a real case**. The one-negative stratum is nonempty, the bound on it is attained, and every algebraic step checks out. Five things should change in the record:

1. **Adopt the three-line direct proof** of claim 9 as the proof of the one-negative case, and demote the $R$-route to a consistency check. It reaches the identical $s^2(A-s)$ from $T\ge0$, the pair cap, $\lambda\le A$ and $A\le s$, and it inherits none of the recorded chain's hypotheses.
2. **State the exhaustion hypothesis wherever $A\le s$ is used.** A negative eigenvalue outside $\{-b,-c\}$ makes $s$ smaller than the sum of the positives and the conclusion reverses.
3. **Let $P$ be the nonnegative part**, not the strictly positive part. The $m=4$ witness has three zero eigenvalues and only one of them can wear the label $-c$.
4. **Give `equality_iff_single_positive` the hypothesis $0<s$** if its conclusion is read spectrally, since the $s=0$ branch satisfies $A=s$ while having no positive eigenvalue.
5. **Narrow the claim that the argument needs neither the unit norm nor the locus** to the collapse itself. The identity defining $\theta$ needs $\lVert W\rVert=1$, and so does $s>0$.
