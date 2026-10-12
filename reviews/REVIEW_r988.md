# REVIEW r988: L35's owed one-negative case, and whether theta <= 0 there

Gate 2, cold read from [BRIEF_I48_one_negative.md](BRIEF_I48_one_negative.md) alone. Log: [agent_logs/r988-one-negative.log](../agent_logs/r988-one-negative.log).

**Headline.** The algebra is right and every sign goes the way the derivation says. Two things are owed. Claim 8's substitution $c=0$ is not an instance of a chain derived for exactly two negatives, and needs the one-negative re-derivation supplied in [section 8](#8-therefore-thetale0-on-the-one-negative-stratum) below, which goes through and lands on exactly $R|_{c=0}$. Claim 9's stratum is nonempty, with a witness, but the derivation is **provably content-free wherever the negative eigenform has rank 4**, and the record has no example where it has rank 6 or more, which is the only place the argument can buy anything.

## Verdicts

| # | claim | verdict |
|---|---|---|
| 1 | one negative eigenvalue is exactly $bc=0$, hence exactly $s^2=1-u$ | CONFIRMED, sharpened |
| 2 | with $c=0$, $-b^3-c^3+6Abc = -s^3$ | CONFIRMED |
| 3 | $s^2-u\ge0$ always | CONFIRMED |
| 4 | $A\le s$ | CONFIRMED |
| 5 | the identity $A^3+Ad+A(s^2-u)-s^3=s^2(A-s)$ | CONFIRMED |
| 6 | bounding both $\min$ factors by $A$ is legitimate and gives $\le s^2(A-s)\le0$ | CONFIRMED |
| 7 | equality forces $A=s$, one positive eigenvalue | CONFIRMED for the bound, misstated for $\theta$ |
| 8 | therefore $\theta\le0$ on the one-negative stratum | PLAUSIBLE, one step is owed |
| 9 | the result is NOT VACUOUS | PLAUSIBLE, nonempty but content confined to rank $\ge6$ |
| 10 | the $c\to0$ line genuinely fails | CONFIRMED, one correction |

## 9. Is the one-negative stratum nonempty, and is $\theta\le0$ cheap there

**The stratum is nonempty.** Witness in $m=4$: an algebraic Weyl tensor in dimension 4 is exactly a pair of traceless symmetric operators $(W^+,W^-)$ on $\Lambda^\pm$. Take $W^+=\mathrm{diag}(1,1,-2)/\sqrt6$ and $W^-=0$. Its $\Lambda^2$ spectrum is $(1,1,-2,0,0,0)/\sqrt6$: unit norm, trace free, exactly one negative entry. This is the sign-reversal of the Fubini-Study $W^+$, and $\mathrm{Weyl}_m$ is a linear space, so the reversal is again a Weyl tensor. Screened: Ricci contraction and the first Bianchi identity both vanish on it, as assertions.

**One negative is the extreme stratum.** $\mathrm{Ric}$ of the operator $\sum_\alpha\lambda_\alpha\,\omega_\alpha\otimes\omega_\alpha$ is $\sum_\alpha\lambda_\alpha\,\Omega_\alpha\Omega_\alpha^{\mathsf T}$, a sum of positive semidefinite matrices weighted by the eigenvalues (screened as an assertion). With no negative eigenvalue every term is positive semidefinite, so $\mathrm{Ric}=0$ forces every $\lambda_\alpha=0$. A unit-norm Weyl tensor therefore has at least one negative eigenvalue, and the stratum under review is the smallest possible one.

**A support lemma, which is where the content question is decided.** Write the negative eigenvalue $-b$ with eigenform $\omega_0$, $b>0$. Ricci-flatness reads
$$b\,\Omega_0\Omega_0^{\mathsf T}=\sum_{k}\lambda_k\,\Omega_k\Omega_k^{\mathsf T},\qquad \lambda_k\ge0 .$$
Both sides are positive semidefinite, so the range of every $\Omega_k$ with $\lambda_k>0$ lies in $V:=\mathrm{range}\,\Omega_0$. Every eigenform carrying a nonzero eigenvalue is supported in $\Lambda^2V$, and $W$ restricted there is a Weyl tensor of $V$ with the same nonzero spectrum. So $r:=\dim V=\mathrm{rank}\,\Omega_0$ is even, and $\omega_0$ is nondegenerate on $V$.

- $r=2$ makes $\Lambda^2V$ one dimensional, and trace-freeness then forces $W=0$.
- $r=4$ reduces to the dimension-4 classification. Exactly one negative eigenvalue forces one of $W^\pm$ to vanish, since a nonzero traceless symmetric $3\times3$ matrix has a negative eigenvalue. The surviving block is traceless with one negative entry, so it has **at most two strictly positive eigenvalues**.

**Consequence, and this is the vacuity finding.** When $r=4$ there is no triple of indices all carrying strictly positive eigenvalues, so every triple with a nonzero eigenvalue product contains the unique negative index and contributes $T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta(-b)\le0$. Meanwhile $\sum_\alpha\lambda^3_\alpha=\sum_P\lambda^3-b^3\le Au-s^3\le s^3-s^3=0$. Hence $\theta\le0$ in three lines, using nonnegativity of $T$ and $A\le s$ and nothing else. The relaxation, the packing $M$, the constant $K_0$ and the whole chain are unnecessary there. Screened on the witness: it has exactly one triple with $T>0$ and a nonzero eigenvalue product, and that product is negative.

**What would make the finding vacuous, stated as the brief asks.** It is vacuous if every one-negative Weyl tensor has $r=4$, because then the cheap argument above covers the entire stratum. It is not vacuous exactly when a one-negative Weyl tensor exists whose negative eigenform has rank $\ge6$, since only there can three strictly positive eigenvalues coexist with the single negative and make the all-positive triple term genuinely positive.

**Partial closure at $r=6$.** Pair the Bianchi identity $\sum_\alpha\lambda_\alpha\,\omega_\alpha\wedge\omega_\alpha=0$ with $\omega_0$ and divide by the volume form. Putting $\omega_0=a_1e_{12}+a_2e_{34}+a_3e_{56}$ in an orthogonal normal form, $a_i>0$, $\sum a_i^2=1$, this reads $\sum_k\lambda_kS_a(\omega_k)=b\,S_a(\omega_0)=3a_1a_2a_3\,b$, where $S_a(\omega)=a_1\mathrm{Pf}_{3456}+a_2\mathrm{Pf}_{1256}+a_3\mathrm{Pf}_{1234}$. Since $\sum_k\lambda_k=b$ and each $\omega_k\perp\omega_0$ is a unit vector, the identity is impossible whenever $\sigma(a):=\max\{S_a(\omega):|\omega|=1,\ \omega\perp\omega_0\}<3a_1a_2a_3$. The form splits into a $3\times3$ block on $(\omega_{12},\omega_{34},\omega_{56})$ and three $4\times4$ blocks with eigenvalues $\pm a_i/2$. For a balanced $\omega_0$ this gives $\sigma=\tfrac12\cdot3a_1a_2a_3$, so **$r=6$ with a balanced negative eigenform is impossible**. A skewed $\omega_0$ escapes, because $\sigma(a)\ge a_{\max}/2$ while $3a_1a_2a_3\to0$: screened at $a\propto(1,0.3,0.3)$, where $\sigma=0.460$ against $3a_1a_2a_3=0.211$.

**Verdict PLAUSIBLE.** Nonemptiness is settled. Informativeness is not, and it is not a matter of taste: the derivation earns its keep only on a set the record has never exhibited, namely one-negative Weyl tensors of rank $\ge6$ with a skewed negative eigenform. Deciding it is an existence question over $\mathrm{Weyl}_6$ and up, which is an open-ended search that I am not opening here. It should be recorded against the finding as its outstanding condition rather than left implicit.

## 8. Therefore $\theta\le0$ on the one-negative stratum

This is where the brief expected a gap, and there is one, of exactly the shape it anticipated.

The chain $\theta\le G$ is recorded for **exactly two** negative eigenvalues: the group $\{-b,-c\}$ is the set of negative eigenvalues, and the term $6Abc$ comes from the triples with one positive and two negative indices. Setting $c=0$ is therefore not an instance of that statement. It is a point outside its hypothesis class, unless the spectrum happens to have a zero eigenvalue available to be relabelled as $-c$, which is not guaranteed. Writing "put $c=0$ into the relaxation DIRECTLY rather than as a limit" replaces a limit that does not exist with a substitution that is not licensed. The defect is in the justification, so the conclusion survives, but as written the step is the one that quietly assumes two negatives.

**The repair, which should be written into the finding.** Re-derive with one negative index. Partition into $N=\{0\}$ and $P=\{\lambda\ge0\}$. Then
$$\theta=\sum_\alpha\lambda_\alpha^3+3\!\!\sum_{P<P<P}\!\!T\lambda\lambda\lambda+3\!\!\sum_{P<P,\,N}\!\!T\lambda\lambda(-b),$$
there being no triple with two negative indices at all. The last group is nonpositive and is dropped, giving $\theta\le\sum_P\lambda^3-b^3+3M$ with the same all-positive packing $M$. That is literally $G|_{c=0}$, and the missing $6Abc$ term is accounted for by the absence of the triples that produced it rather than by a substitution. The three given bounds ($3M\le h(s^2-u)$, $h\le\min(A,K_0\sqrt d)$, $\sum_P\lambda^3\le A^3+\min(A,\sqrt d)d$) all range over the positives only, and the only place the negatives enter them is through $\sum_P\lambda_P=s$, which trace-freeness gives in the one-negative case as well. So no step of the chain needs two negatives.

**A sharper statement that contains the claim and shows what it is worth.** Since $-b^3-c^3=-s^3+3bc\,s$,
$$-b^3-c^3+6Abc=-s^3+3bc(s+2A),\qquad\text{hence}\qquad R\le s^2(A-s)+3bc(s+2A)$$
everywhere on the feasible region, with no case split. The one-negative case is exactly the locus where the obstruction term $3bc(s+2A)$ vanishes, and the two-negative endgame is hard precisely because that term is positive and can exceed $|s^2(A-s)|$. Recording the bound in this form makes the owed case a corollary rather than a separate argument.

**A simplification worth taking.** The $A^3+\min(A,\sqrt d)d$ machinery is not needed for this case. Bounding $\min$ by $A$ turns it into $A^3+Ad=Au$, which is just $\sum_P\lambda^3\le A\sum_P\lambda^2$, one line from $\lambda_P^3\le A\lambda_P^2$. The derivation is $\theta\le Au+A(s^2-u)-s^3=s^2(A-s)\le0$, and $d$, $\sqrt d$ and $K_0$ never appear.

**Verdict PLAUSIBLE.** Correct conclusion, one step owed.

## 1, 10. The two loci

$b^2+c^2+u=1$ from unit norm, and $s^2=(b+c)^2=b^2+c^2+2bc$, give $bc=(s^2-1+u)/2$, so $bc=0$ is $s^2=1-u$. **Sharpening**: $bc=0$ alone says at most one strictly negative eigenvalue, and the branch $b=c=0$ is excluded because trace-freeness with $\sum\lambda^2=1$ forces a negative eigenvalue to exist. So for a unit-norm $W$, $bc=0$ is exactly one negative eigenvalue. Claim 1 CONFIRMED with that branch closed.

The feasible region in $(s,u)$ is $1-u\le s^2\le2-2u$, the upper bound being $bc\le s^2/4$ and the lower $bc\ge0$. So $b=c$ is the face $s^2=2-2u$ and $bc=0$ is the **opposite face** $s^2=1-u$. **Correction to the brief's wording**: $bc=0$ is not "strictly inside" the region, it is the other boundary face. What the brief says is nonetheless true and is the point that matters, namely that $s^2=1-u$ satisfies $s^2<2-2u$ strictly whenever $s>0$, since $2-2u=2s^2$ there. A maximisation carried out on the face $s^2=2-2u$ bounds nothing at $bc=0$, and no limit recovers it because the two faces meet only at $s=u=0$, which is not a spectrum. Claim 10 CONFIRMED.

## 3, 4, 5, 6, 7. The algebra and the signs

**3, $s^2-u\ge0$. CONFIRMED.** Trace-freeness gives $\sum_P\lambda_P=b+c=s$ in both the two-negative and the one-negative case, so $s^2-u=(\sum_P\lambda_P)^2-\sum_P\lambda_P^2=2\sum_{P<Q}\lambda_P\lambda_Q\ge0$, every term being a product of nonnegatives. It cannot be negative. Note the fact needed is that $s$ is the sum of the positives, which is trace-freeness and not the definition of $s$, so the hypothesis binder `hsu` is discharged only alongside the trace-free hypothesis.

**4, $A\le s$. CONFIRMED.** $A=\max_P\lambda_P$ and $\sum_P\lambda_P=s$ with all terms nonnegative. $A>s$ would require some positive eigenvalue to be negative, or $s$ to be something other than the sum of the positives. Both fail. Also $A>0$, since a spectrum with no strictly positive eigenvalue and zero trace is identically zero and violates unit norm, so the maximum is over a nonempty set.

**5, the collapse. CONFIRMED, expanded independently.** With $d=u-A^2$,
$$A^3+A(u-A^2)+A(s^2-u)-s^3=A^3+Au-A^3+As^2-Au-s^3=As^2-s^3=s^2(A-s).$$
$A^3$ cancels against $-A\cdot A^2$ and $u$ cancels between $Ad$ and $-Au$. The surviving factor is $A-s$ and not $s-A$, so the expression is nonpositive, which is the direction claimed. The identity is unconditional in $u$, confirming the derivation's remark that $u$ drops out.

**6, the two $\min$ relaxations. CONFIRMED, and the direction is right.** $\min(A,\sqrt d)\le A$ and $\min(A,K_0\sqrt d)\le A$. Multiplying by $d\ge0$ and by $s^2-u\ge0$ preserves the inequality, so each term increases and an upper bound on $G$ stays an upper bound. Both nonnegativity facts are load bearing and both hold: $d=u-A^2=\sum_{P\ne\text{top}}\lambda_P^2\ge0$ as a sum of squares, and $s^2-u\ge0$ by claim 3. A negative multiplier would invert either step, so the checks are the right ones.

**7, the equality case. CONFIRMED for the bound, misstated for $\theta$.** $s^2(A-s)=0$ with $s>0$ gives $A=s$, and $A=s$ with the positives nonnegative and summing to $s$ forces every other positive to vanish, hence exactly one strictly positive eigenvalue and the spectrum $(1,-1)/\sqrt2$. That spectrum is realised by a genuine Weyl tensor, for instance $W^+=\mathrm{diag}(1,-1,0)/\sqrt2$ with $W^-=0$ in $m=4$, and $\theta=0$ there because the cubic trace vanishes and no triple has three nonzero eigenvalues. **Correction**: equality in $s^2(A-s)\le0$ characterises equality in the final bound, not in $\theta\le0$. $\theta=0$ implies $A=s$ only if every step of $\theta\le G\le R$ is simultaneously tight, which is not shown. The finding should say "the bound is attained only at $A=s$", not "equality forces $A=s$".

**2. CONFIRMED.** $c=0$ gives $b=s$, so $-b^3-c^3+6Abc=-s^3$.

## What to change in the finding

1. Replace the substitution argument in claim 8 with the one-negative re-derivation, so the $6Abc$ term is absent because its triples are absent.
2. Record $R\le s^2(A-s)+3bc(s+2A)$ as the unconditional bound and the one-negative case as its $bc=0$ corollary.
3. Restate claim 7 as a statement about the bound rather than about $\theta$.
4. Attach the outstanding condition to claim 9: the result has content only if a one-negative Weyl tensor exists whose negative eigenform has rank $\ge6$. Rank 4 is covered by a three-line argument, and rank 6 with a balanced negative eigenform is impossible.
5. Fix the wording that puts $bc=0$ strictly inside the region. It is the opposite face.
