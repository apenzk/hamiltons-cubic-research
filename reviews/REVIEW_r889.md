# REVIEW r889: the claim that the simplex bound is this record's per-index relation, and the two claims attached to it about equality and multiplicity

Reviewer r889, working from a cold brief: no findings file, plan, route or other review was read, only the brief and the primary source in [references/tight-fusion-frames-packing/](../references/tight-fusion-frames-packing/). Everything below is closed form and every value is exact: the specialisation $\frac{2(2M-n)}{n(M-1)}$, the full-basis value $\frac4{n+1}$, the icosahedral $\sigma^2=\frac15$ and its $\Lambda^2$ inner product $\frac15$, and the new equality case at $n=4$ with every overlap exactly $\frac45$. One numerical run appears, a seconds-long screen of the $n=4$ construction against the closed-form derivation that precedes it, reported as a screen. Log: [review-r889-simplex.log](../agent_logs/review-r889-simplex.log).

## Claim table

| # | Claim under audit | Verdict | Reason |
|---|---|---|---|
| C1 | At $c=2$, $d=n$ the simplex bound reads $\max_{\alpha\ne\beta}S_{\alpha\beta}\ge\frac{2(2M-n)}{n(M-1)}$, and the per-index mean of (G1) with (G2) is the same expression, symbolic difference zero | **CONFIRMED AS ALGEBRA** | both sides reduce to $\frac{2(2M-n)}{n(M-1)}$ identically in $M$ and $n$, and (G4) matches the two quantities termwise |
| C2 | "the two are one statement" | **REFUTED AS STATED** | (G3) holds for every family, (G1) needs $\sum\Pi_\alpha=\kappa\,\mathrm{Id}$, and on the isotropic class (G1) is strictly stronger than the bound, giving $M$ row bounds plus an upper bound on each row's minimum |
| C3 | "Equality in the simplex bound is exactly isotropy" | **REFUTED AS STATED** | equality needs isotropy **and** equal overlaps, and the coordinate family at every $n\ge4$ is isotropic with $\max S=1>\frac4{n+1}$ |
| C4 | The literature's optimal-packing criterion and the record's Ricci-flatness condition on a decomposable eigenbasis are the same equation | **HYPOTHESIS-DEBT** | the brief defines no Ricci-flatness condition, so the identification cannot be checked here, and if the condition is isotropy it is automatic at $M=\binom n2$ (Section 5) and therefore carries no information |
| C5 | The identification "is worth knowing and is not new information" | **CONFIRMED** | Theorem 5.1 of [Casazza and Fickus](https://arxiv.org/abs/1708.08879) states the bound with its equality case, read at first hand, and it subsumes the isotropic case of (G1) |
| C6 | The bound is a lower bound on the largest overlap, so it caps no multiplicity | **CONFIRMED** | $S\le1$ with the bound gives only $M(4-n)\le n$, vacuous for every $n\ge4$, and the mean is increasing in $M$, so every threshold hypothesis yields a lower bound on $M$ (Section 4) |
| C7 | "$S_{\alpha\beta}\le1$ is too weak to bite at any $n>4$" | **CONFIRMED, UNDERSTATED** | the bound at $n=4$ is $\frac{M-2}{M-1}<1$ for every $M$, so $S\le1$ is equally toothless at $n=4$ and the exclusion of that case is unnecessary |
| C8 | At a full basis, $M=\binom n2$, the bound gives only $\max S\ge\frac4{n+1}$, "far below 1" | **CONFIRMED AS ARITHMETIC, REFUTED AS APPRAISAL** | $\frac4{n+1}$ is exact, and at $n=4$ the value $\frac45$ is **attained** by a $\Lambda^2$-orthonormal decomposable basis constructed in Section 6, so the bound is sharp inside the record's own class and the constant admits no improvement there |
| C9 | Six icosahedral lines in $\mathbb C^3=\mathbb R^6$ are an equi-isoclinic tight fusion frame with $\sum\Pi_\alpha=2\,\mathrm{Id}_6$, every pair at $\cos^2=\frac15$, failing $\Lambda^2$-orthonormality | **CONFIRMED** | $\frac{Mc-d}{d(M-1)}=\frac{12-6}{30}=\frac15$ and $\alpha=\frac{Mc}{d}=2$ both match, and each $\Lambda^2$ inner product is exactly $\frac15$ (Section 7) |
| C10 | (G3)'s addendum, that an equi-isoclinic family is "necessarily equi-chordal, with $\alpha=\frac{Mc}d$ and $\sigma^2=\frac{Mc-d}{d(M-1)}$" | **REFUTED AS STATED** (imported given, not the record's claim) | equi-isoclinic does force equi-chordal, but the two **values** additionally require tightness, which Theorem 5.2 lists as a separate hypothesis. Witness: three coplanar lines at $60^\circ$ in $\mathbb R^3$ are equi-isoclinic with $\sigma^2=\frac14$ while the formula predicts $0$ |

**One-line summary the cycle can act on:** the identification is exact algebra on the isotropic class and nothing wider, the two claims attached to it about equality and about "far below 1" are both wrong as stated (the coordinate family refutes the first, an equality case at $n=4$ with all overlaps $\frac45$ refutes the second), and the multiplicity verdict survives every attack, for the structural reason that the mean overlap increases in $M$.

## 0. Conventions, fixed once

Quoted from the brief.

- $\mathbb R^n$ with its standard inner product, and $\Lambda^2\mathbb R^n$ with $\langle\cdot,\cdot\rangle$ normalised so that the $\varphi_{ij}=e_i\wedge e_j$ for $i<j$ are orthonormal. $N:=\binom n2=\dim\Lambda^2\mathbb R^n$.
- A **decomposable** $2$-form is $\omega=u\wedge v$. A unit decomposable $\omega$ determines a $2$-plane $P_\omega=\mathrm{span}(u,v)\subset\mathbb R^n$ and $\Pi_\omega$ is the orthogonal projection of $\mathbb R^n$ onto it.
- For two unit decomposable forms write $S_{\alpha\beta}:=\mathop{\mathrm{tr}}(\Pi_\alpha\Pi_\beta)$. **Given:** $S_{\alpha\beta}=\lVert[\omega_\alpha,\omega_\beta]\rVert^2$ under the identification $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, $S_{\alpha\beta}\in[0,1]$ for distinct planes, $S_{\alpha\beta}=1$ exactly when the two planes share a line, and $S_{\alpha\beta}=0$ exactly when they are orthogonal.
- A family $\{\omega_\alpha\}_{\alpha=1}^M$ of unit decomposable forms is **$\Lambda^2$-orthonormal** when $\langle\omega_\alpha,\omega_\beta\rangle=\delta_{\alpha\beta}$.

## Hypothesis inventory

Every hypothesis of every claim and of everything imported, checked against the object it applies to, with a column for whether the argument actually uses it.

| Hypothesis | Where it enters | Object it applies to | Status | Used? |
|---|---|---|---|---|
| $\Pi_\alpha$ is a rank-$2$ orthogonal projection | (G1), via $\mathop{\mathrm{tr}}\Pi_\alpha^2=\mathop{\mathrm{tr}}\Pi_\alpha=2$ | every family here | holds wherever the $\omega_\alpha$ are unit decomposable | **Yes, load-bearing.** This is the whole of $c=2$ |
| $\sum_\alpha\Pi_\alpha=\kappa\,\mathrm{Id}_n$ (isotropy, tightness) | (G1) and (G3)(i) | holds for the coordinate family ($\kappa=n-1$), the icosahedral family ($\kappa=2$), the $n=4$ family of Section 6 ($\kappa=3$). **Fails** for six planes through a common line in $\mathbb R^4$ | automatic at $M=\binom n2$ (Section 5), a genuine restriction otherwise | **Yes for (G1). No for the simplex bound itself**, which is the asymmetry C2 misses |
| $\kappa=2M/n$ | (G2), the trace of the previous row | wherever isotropy holds | derived, not independent | Yes |
| $\Lambda^2$-orthonormality | stated in (G1) | holds for the coordinate family and for Section 6's family, **fails** for the icosahedral family with inner products $\frac15$ | a genuine restriction | **Inert in (G1)'s identity.** The two-line derivation never touches $\langle\omega_\alpha,\omega_\beta\rangle$. It is used only to force the planes distinct, to give $S_{\alpha\beta}\le1$, and to give $M\le\binom n2$ |
| planes pairwise distinct | needed for $S_{\alpha\beta}\in[0,1]$ and for $\max_{j\ne j'}$ to be over a nonempty set | supplied by $\Lambda^2$-orthonormality | holds | Yes |
| $c=2$ and $d=n$ | the specialisation of (G3) | the record's setting | holds by construction | Yes |
| $\mathbb F=\mathbb R$ | (G3) is stated over $\mathbb F$, so $\mathbb R$ is admissible | all families here. Item 7 starts over $\mathbb C$ with $d=3$, $c=1$ and realifies to $d=6$, $c=2$ | holds under both readings, with matching numbers (Section 7) | Yes |
| $M\ge2$ | the denominator $M-1$ of (G3) | every use | holds in the record's uses | Yes |
| $2M\ge n$ | forced by isotropy, since $\mathop{\mathrm{rank}}\sum_\alpha\Pi_\alpha\le2M$ | every isotropic family | holds, and shows (G1)'s class is **empty** when $2M<n$ | Yes, in Section 8 |
| equi-chordality, all $S_{\alpha\beta}$ equal | (G3)(ii), required for equality | holds for Section 6's family and the icosahedral family, **fails** for the coordinate family at $n\ge4$ | a genuine extra restriction beyond isotropy | **Omitted by C3**, which is exactly why C3 fails |
| equi-isoclinic, $\Pi_\beta\Pi_\alpha\Pi_\beta=\sigma^2\Pi_\beta$ | (G3)'s addendum and item 7 | holds for the icosahedral family at $\sigma^2=\frac15$ | strictly stronger than equi-chordal at $c=2$ | Yes, and incompatible with $\Lambda^2$-orthonormality unless $\sigma^2=0$ (Section 3) |
| tightness, for the **values** $\alpha=\frac{Mc}d$ and $\sigma^2=\frac{Mc-d}{d(M-1)}$ | Theorem 5.2 of the source, suppressed in (G3)'s addendum | supplied independently in item 7 | needed, see C10 | Yes, and the brief's given is loose about it |
| Ricci-flatness on a decomposable eigenbasis | the record's C4 | undefined in this brief | unverifiable here | Cannot be used, hence C4's HYPOTHESIS-DEBT |

## 1. The specialisation, derived independently

Put $c=2$ and $d=n$ in (G3). The right-hand side is

$$\frac{c(Mc-d)}{d(M-1)}=\frac{2(2M-n)}{n(M-1)}.$$

By (G4) the left-hand side is $\max_{\alpha\ne\beta}\mathop{\mathrm{tr}}(\Pi_\alpha\Pi_\beta)=\max_{\alpha\ne\beta}S_{\alpha\beta}$, so the specialisation is exactly $\max_{\alpha\ne\beta}S_{\alpha\beta}\ge\frac{2(2M-n)}{n(M-1)}$ as the record states.

Now (G1) with (G2). For a fixed $\alpha$,

$$\sum_{\beta\ne\alpha}S_{\alpha\beta}=\mathop{\mathrm{tr}}\!\Big(\Pi_\alpha\sum_\beta\Pi_\beta\Big)-\mathop{\mathrm{tr}}(\Pi_\alpha^2)=\kappa\mathop{\mathrm{tr}}(\Pi_\alpha)-\mathop{\mathrm{tr}}(\Pi_\alpha)=2(\kappa-1),$$

using $\mathop{\mathrm{tr}}(\Pi_\alpha^2)=\mathop{\mathrm{tr}}(\Pi_\alpha)=2$ for a rank-$2$ orthogonal projection. With $\kappa=2M/n$ from (G2) this is $2\big(\tfrac{2M}n-1\big)=\frac{2(2M-n)}n$, and the mean over the $M-1$ partners of $\alpha$ is

$$\frac1{M-1}\cdot\frac{2(2M-n)}{n}=\frac{2(2M-n)}{n(M-1)}.$$

**The two expressions are equal, and the equality is an identity in $M$ and $n$**, valid for all $M\ge2$ and $n\ge2$ with no numerical coincidence anywhere. It holds because both sides are the same rational function, not because they agree at particular values. C1 stands.

Two remarks that matter later. First, the derivation of (G1) uses only that the $\Pi_\alpha$ are rank-$2$ orthogonal projections summing to $\kappa\,\mathrm{Id}$, so $\Lambda^2$-orthonormality is inert in it, and (G1) applies verbatim to the icosahedral family of Section 7, which is not $\Lambda^2$-orthonormal. Second, a consistency check on (G1) and (G2) together: summing over $\alpha$ gives $\sum_{\alpha,\beta}S_{\alpha\beta}=2M(\kappa-1)+2M=2M\kappa$, while directly $\sum_{\alpha,\beta}S_{\alpha\beta}=\mathop{\mathrm{tr}}\big((\sum_\alpha\Pi_\alpha)^2\big)=\kappa^2n$. The two agree exactly when $2M=\kappa n$, which is (G2). The system is consistent and carries no information beyond (G1) and (G2).

## 2. Quantifiers: which side says more

The two statements control different quantifiers, and the record's "read as max at least mean" hides the difference in both directions.

**(G3) is unconditional, (G1) is not.** Theorem 5.1 assumes nothing about the family beyond each $U_j$ having dimension $c$. (G1) assumes isotropy. So the simplex bound covers families the record's relation says nothing about, and the identification cannot run from (G1) to (G3). A witness in closed form: in $\mathbb R^4$ take six distinct $2$-planes all containing $e_1$, that is $P_\alpha=\mathrm{span}(e_1,w_\alpha)$ for six distinct unit $w_\alpha\in e_1^\perp$. Every pair shares a line, so every $S_{\alpha\beta}=1$, and $\sum_\alpha\Pi_\alpha$ has $(1,1)$ entry $6$ while its trace $12$ would force $\kappa=3$, so isotropy fails. The simplex bound is non-vacuous there, giving $\max S\ge\frac{2(12-4)}{4\cdot5}=\frac45$, and (G1) is silent. **The bound is strictly more general.**

**On the isotropic class, (G1) says strictly more than the bound.** (G3) asserts one thing about one pair: there exists a pair with $S_{\alpha\beta}\ge B$, where $B:=\frac{2(2M-n)}{n(M-1)}$. (G1) gives an exact row sum for **every** $\alpha$, from which three statements follow, of which the record's reading keeps only the weakest.

1. For every $\alpha$: $\max_{\beta\ne\alpha}S_{\alpha\beta}\ge B$. This is $M$ statements, one per index, and each has its own witness. The global bound is the disjunction of them.
2. For every $\alpha$: $\min_{\beta\ne\alpha}S_{\alpha\beta}\le B$. This is an **upper** bound, and it is the only upper-bound information anywhere in the system. At a full basis it reads: every plane of the basis has a partner with $S\le\frac4{n+1}$, hence nearly orthogonal for large $n$.
3. The row sum is an equality, not an inequality, so nothing about the distribution within a row is lost.

So the answer to the brief's sub-question is: the per-$\alpha$ bound is **not** numerically stronger, since isotropy makes the row sum the same $2(\kappa-1)$ for every $\alpha$ and the per-row bound is the same number $B$, but it **is** logically stronger, because it is universally quantified over $\alpha$ and it carries the min-side companion. The record's "max at least mean" loses items 1 and 2 and keeps a single existential. That is a loss of information, and item 2 is the half that points in the direction the route would need.

## 3. The equality cases are not the same condition

(G3)'s equality requires (i) isotropy **and** (ii) all off-diagonal $\mathop{\mathrm{tr}}(P_jP_{j'})$ equal. (G1) requires only (i). These are different conditions, and (i) does not imply (ii) even inside the record's class.

**Witness, closed form.** The coordinate family $\{e_i\wedge e_j\}_{i<j}$ at any $n\ge4$. It is $\Lambda^2$-orthonormal, and $\sum_{i<j}\Pi_{ij}=(n-1)\mathrm{Id}_n$ because each index $i$ occurs in exactly $n-1$ pairs, so isotropy holds with $\kappa=n-1$. But $S_{(ij),(kl)}=\lvert\{i,j\}\cap\{k,l\}\rvert\in\{0,1\}$, and at $n\ge4$ both values occur, so (ii) fails and the inequality is strict: $\max S=1$ against $B=\frac4{n+1}<1$.

Hence **"equality in the simplex bound is exactly isotropy" is wrong as stated.** Isotropy is necessary and not sufficient. The correct statement is that equality holds if and only if isotropy holds and all pairwise overlaps are equal, and under isotropy alone the equality case is forced as follows: if every row has mean $B$ and the global maximum equals $B$, then every $S_{\alpha\beta}\le B$ while every row averages $B$, so every $S_{\alpha\beta}=B$. So under isotropy, equality in the max-at-least-mean reading is equivalent to equi-chordality, which is the missing half of the condition rather than a consequence of the first half.

One reading might rescue the sentence: if "isotropy" in the record means "all overlaps equal" rather than $\sum\Pi_\alpha=\kappa\,\mathrm{Id}$, the claim becomes correct, but then it is no longer (G1)'s hypothesis, and the record must say which of the two conditions its Ricci-flatness statement is. Under the brief's own reading, which item 3 fixes as $\sum\Pi_\alpha=\kappa\,\mathrm{Id}$, the claim is refuted.

**A related structural fact, for the route.** At $c=2$, $\Lambda^2$-orthonormality and equi-isoclinity are almost exclusive. For unit decomposables with principal angles $\theta_1,\theta_2$ between the planes, $\langle\omega_\alpha,\omega_\beta\rangle=\pm\cos\theta_1\cos\theta_2$ and $S_{\alpha\beta}=\cos^2\theta_1+\cos^2\theta_2$. So $\Lambda^2$-orthogonality of a pair says exactly that one principal angle is $\frac\pi2$, which is also why $S_{\alpha\beta}\le1$ holds in this setting, confirming a given. Equi-isoclinity says both $\cos^2\theta_i$ equal $\sigma^2$. Together they force $\sigma^2=0$, that is mutually orthogonal planes, hence $M\le\lfloor n/2\rfloor$. **The literature's equi-isoclinic optimal packings are therefore unavailable to a $\Lambda^2$-orthonormal family except in the trivial orthogonal case.** Equi-chordal ones are available, as Section 6 shows.

## 4. The multiplicity claim, checked and then attacked

The record's reasoning is correct as far as it goes. (G3) bounds $\max_{\alpha\ne\beta}S_{\alpha\beta}$ from below, so it is satisfied by making overlaps larger and can never obstruct a large family. To cap $M$ one needs a statement that large $M$ forces something impossible, and a lower bound on a quantity already bounded above by $1$ can only do that if the lower bound exceeds $1$.

**Attack 1, the bound against $S\le1$.** Consistency requires $\frac{2(2M-n)}{n(M-1)}\le1$, that is $4M-2n\le nM-n$, that is $M(4-n)\le n$. For $n\ge4$ the left side is at most $0$ and the inequality is unconditional, so no bound on $M$ appears. For $n=3$ it gives $M\le3=\binom32$ and for $n=2$ it gives $M\le1=\binom22$, in both cases exactly the dimension bound and nothing more. **No upper bound on $M$ for any $n\ge4$.** This also corrects C7: the threshold is $n\ge4$, not $n>4$.

**Attack 2, $\Lambda^2$-orthonormality as the missing hypothesis.** It does supply an upper bound, $M\le\dim\Lambda^2\mathbb R^n=\binom n2$, but from the dimension count alone, with no help from (G3) and no reference to overlaps. The combination produces nothing the dimension count does not.

**Attack 3, isotropy and a rank count.** $\mathop{\mathrm{rank}}\sum_\alpha\Pi_\alpha\le2M$, and isotropy needs rank $n$, so $2M\ge n$. That is a lower bound.

**Attack 4, the min side of (G1), which is the only upper-bound direction available.** Write $f(M):=\frac{2(2M-n)}{n(M-1)}$. Then $\min_{\beta\ne\alpha}S_{\alpha\beta}\le f(M)$ for every $\alpha$. Suppose the route needed every overlap to be at least some $t>0$. Then $t\le f(M)$. Now

$$\frac{d}{dM}\,\frac{2M-n}{M-1}=\frac{2(M-1)-(2M-n)}{(M-1)^2}=\frac{n-2}{(M-1)^2}>0\qquad(n>2),$$

so $f$ is **increasing** in $M$. Solving $t\le f(M)$ with $tn<4$, which holds because $t\le f(\binom n2)=\frac4{n+1}<\frac4n$, gives $M(tn-4)\le tn-2n$ and hence $M\ge\frac{n(t-2)}{tn-4}$. **A threshold hypothesis on the overlaps yields a lower bound on $M$, never an upper one**, and it does so for a structural reason: more planes in a fixed $\mathbb R^n$ means a larger $\kappa$, hence a larger total overlap per index, hence a larger mean.

**Conclusion on C6.** The record's verdict is right, and the reason is stronger than the one the record gives. It is not merely that the bound points the wrong way. Every consequence of (G1) and (G3) that bounds anything above bounds a **minimum** above, and since the mean is monotonically increasing in $M$, each such consequence converts a requirement on overlaps into a lower bound on multiplicity. Capping a multiplicity from this relation is impossible in principle, not merely unachieved.

**A corollary worth recording.** Since $M\le\binom n2$ and $f$ is increasing,

$$\frac{2(\kappa-1)}{M-1}=f(M)\le f\!\left(\binom n2\right)=\frac4{n+1}$$

for every isotropic $\Lambda^2$-orthonormal decomposable family, with equality exactly at a full basis. The mean pairwise overlap in this class never exceeds $\frac4{n+1}$.

## 5. The full-basis evaluation, and why isotropy is free there

At $M=\binom n2=\frac{n(n-1)}2$, $c=2$, $d=n$: $Mc-d=n(n-1)-n=n(n-2)$ and $M-1=\frac{n^2-n-2}2=\frac{(n-2)(n+1)}2$, so

$$\frac{c(Mc-d)}{d(M-1)}=\frac{2n(n-2)}{n\cdot\frac{(n-2)(n+1)}2}=\frac{4(n-2)}{(n-2)(n+1)}=\frac4{n+1}.$$

**Verified, with the cancellation $n^2-n-2=(n-2)(n+1)$ carrying it.** Note the cancellation is legitimate for $n>2$ and that $n=2$ is the degenerate $M=1$ case of Section 8.

**Does $M=\binom n2$ with $\Lambda^2$-orthonormality force $\kappa=n-1$? Yes, and it forces isotropy itself, which is a strengthening of (G1) rather than a consistency check.** Under $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ send $\omega=u\wedge v$ to $A_\omega=uv^{\mathsf T}-vu^{\mathsf T}$, with $\langle A,B\rangle=\frac12\mathop{\mathrm{tr}}(A^{\mathsf T}B)$, which matches the brief's normalisation since $\frac12\mathop{\mathrm{tr}}(A_{\varphi_{ij}}^{\mathsf T}A_{\varphi_{ij}})=1$. For $u,v$ orthonormal, $A_\omega^{\mathsf T}A_\omega=-A_\omega^2=uu^{\mathsf T}+vv^{\mathsf T}=\Pi_\omega$. The map $Q:\omega\mapsto A_\omega^{\mathsf T}A_\omega$ is a quadratic form on $\Lambda^2\mathbb R^n$ with values in the symmetric matrices, so $\sum_\alpha Q(\omega_\alpha)$ over an orthonormal **basis** equals the trace of $Q$'s polarisation with respect to the inner product and is therefore independent of which orthonormal basis is used. Evaluating on the coordinate basis gives $(n-1)\mathrm{Id}_n$. Hence **every $\Lambda^2$-orthonormal family of $\binom n2$ unit decomposables satisfies $\sum_\alpha\Pi_\alpha=(n-1)\mathrm{Id}_n$ automatically**, and $\kappa=n-1=\frac{2M}n$ agrees with (G2). Consistent, and the consistency is a theorem rather than an assumption.

The same invariance gives a second derivation of (G1) at a full basis that never mentions isotropy: for fixed $\alpha$, $\omega\mapsto\lVert[\omega_\alpha,\omega]\rVert^2$ is a quadratic form, so $\sum_\beta\lVert[\omega_\alpha,\omega_\beta]\rVert^2$ is basis-independent and equals its coordinate-basis value $2(n-2)$, which with $S_{\alpha\alpha}=0$ and the brief's given $S_{\alpha\beta}=\lVert[\omega_\alpha,\omega_\beta]\rVert^2$ is exactly $\sum_{\beta\ne\alpha}S_{\alpha\beta}=2(\kappa-1)$ at $\kappa=n-1$.

**Consequence for C4.** If the record's Ricci-flatness condition on a decomposable eigenbasis is the isotropy relation $\sum_\alpha\Pi_\alpha=\kappa\,\mathrm{Id}$, then at $M=\binom n2$ it holds for every such eigenbasis and constrains nothing. The condition with content at a full basis is equi-chordality, the half C3 omits.

## 6. Does the bound bind? Yes, and it is attained inside the record's class

**The coordinate family.** At $M=\binom n2$, $\{e_i\wedge e_j\}_{i<j}$ gives $S_{(ij),(kl)}=\lvert\{i,j\}\cap\{k,l\}\rvert$, so each $\Pi_{ij}$ has $2(n-2)$ partners sharing exactly one index and $\binom{n-2}2$ orthogonal ones. Row sum $2(n-2)=2(\kappa-1)$ at $\kappa=n-1$, confirming (G1). Mean $\frac{2(n-2)}{\binom n2-1}=\frac{4(n-2)}{(n-2)(n+1)}=\frac4{n+1}$, confirming the identification of Section 1 on an explicit object. Maximum $1$. **The gap is maximal asymptotically**, the bound giving $\frac4{n+1}\to0$ against an actual maximum of $1$. At $n=3$, however, $M=3$, all three pairs share a line, $\max S=1=\frac4{3+1}$, and the coordinate family **attains** equality, so the bound is sharp at $n=3$.

**The brief's premise that $S_{\alpha\beta}\in\{0,1\}$ holds for the coordinate family, not for $\Lambda^2$-orthonormal families in general.** As Section 3 records, $\Lambda^2$-orthogonality of a pair forces one principal angle to be $\frac\pi2$ and leaves the other free, so $S_{\alpha\beta}=\cos^2\theta_1$ takes every value in $[0,1]$. Concretely in $\mathbb R^4$, $\omega_1=e_1\wedge e_2$ and $\omega_2=e_3\wedge(\cos t\,e_1+\sin t\,e_4)$ are $\Lambda^2$-orthogonal unit decomposables with $S_{12}=\cos^2t$.

**An equality case with $0<B<1$, entirely inside the record's class.** Fix $n=4$ and $\Lambda^2\mathbb R^4=\Lambda^+\oplus\Lambda^-$, the $\pm1$ eigenspaces of the Hodge star, each of dimension $3$, with orthonormal bases $f_1^\pm=\frac1{\sqrt2}(e_{12}\pm e_{34})$, $f_2^\pm=\frac1{\sqrt2}(e_{13}\mp e_{24})$, $f_3^\pm=\frac1{\sqrt2}(e_{14}\pm e_{23})$.

*Lemma A.* A unit $\omega\in\Lambda^2\mathbb R^4$ is decomposable if and only if $\lVert\omega^+\rVert^2=\lVert\omega^-\rVert^2=\frac12$, since $\omega\wedge\omega$ is a nonzero multiple of $(\lVert\omega^+\rVert^2-\lVert\omega^-\rVert^2)\,e_{1234}$.

*Lemma B.* For unit decomposables $\omega_\alpha,\omega_\beta$ write $p=\langle\hat\omega_\alpha^+,\hat\omega_\beta^+\rangle$ and $q=\langle\hat\omega_\alpha^-,\hat\omega_\beta^-\rangle$ for the correlations of the normalised self-dual and anti-self-dual parts. Then $\langle\omega_\alpha,\omega_\beta\rangle=\frac{p+q}2$ and $S_{\alpha\beta}=1+pq$. *Proof.* With $c_i=\cos^2\theta_i$ for the principal angles, $a:=\langle\omega_\alpha,\omega_\beta\rangle=\pm\cos\theta_1\cos\theta_2$ and $b:=\langle{*\omega_\alpha},\omega_\beta\rangle=\pm\sin\theta_1\sin\theta_2$, while $\lVert\omega^\pm\rVert^2=\frac12$ gives $\langle\omega_\alpha^+,\omega_\beta^+\rangle=\frac p2$ and $\langle\omega_\alpha^-,\omega_\beta^-\rangle=\frac q2$, so $a=\frac{p+q}2$ and $b=\frac{p-q}2$ because $*$ acts as $\pm1$ on $\Lambda^\pm$. Hence $pq=a^2-b^2=c_1c_2-(1-c_1)(1-c_2)=c_1+c_2-1=S_{\alpha\beta}-1$. $\square$

*Construction.* Let $u_1,\dots,u_6\in\mathbb R^3$ be unit vectors along the six icosahedral diameters, for instance the normalisations of $(0,1,\varphi)$, $(0,1,-\varphi)$, $(1,\varphi,0)$, $(1,-\varphi,0)$, $(\varphi,0,1)$, $(-\varphi,0,1)$ with $\varphi=\frac{1+\sqrt5}2$. Their Gram matrix is $G_u=I_6+\frac1{\sqrt5}\Sigma$ with $\Sigma$ symmetric, zero diagonal and entries $\pm1$, and the six lines form an equiangular tight frame with frame operator $\sum_\alpha u_\alpha u_\alpha^{\mathsf T}=2I_3$, so $G_u$ is positive semidefinite of rank $3$ with spectrum $\{2^{(3)},0^{(3)}\}$ and $\Sigma$ has spectrum $\{\sqrt5^{(3)},(-\sqrt5)^{(3)}\}$. Set $G_v:=2I_6-G_u=I_6-\frac1{\sqrt5}\Sigma$, whose spectrum is $\{0^{(3)},2^{(3)}\}$, so $G_v$ is positive semidefinite of rank $3$ with unit diagonal and is therefore the Gram matrix of six unit vectors $v_1,\dots,v_6\in\mathbb R^3$ with $\langle v_\alpha,v_\beta\rangle=-\langle u_\alpha,u_\beta\rangle$ for $\alpha\ne\beta$. Define

$$\omega_\alpha:=\frac1{\sqrt2}\Big(\sum_{i=1}^3u_{\alpha i}f_i^++\sum_{i=1}^3v_{\alpha i}f_i^-\Big),\qquad\alpha=1,\dots,6.$$

Each $\omega_\alpha$ is unit with $\lVert\omega_\alpha^\pm\rVert^2=\frac12$, hence decomposable by Lemma A. For $\alpha\ne\beta$, $\langle\omega_\alpha,\omega_\beta\rangle=\frac12(\langle u_\alpha,u_\beta\rangle+\langle v_\alpha,v_\beta\rangle)=0$, so the family is $\Lambda^2$-orthonormal and, having six members, an orthonormal basis of $\Lambda^2\mathbb R^4$. By Lemma B with $q=-p$ and $p^2=\frac15$,

$$S_{\alpha\beta}=1+pq=1-p^2=\frac45\qquad\text{for every }\alpha\ne\beta.$$

By Section 5 the basis is isotropic with $\kappa=3$ at no extra cost, row sums are $5\cdot\frac45=4=2(\kappa-1)$, and the simplex bound at $M=6$, $c=2$, $d=4$ is $\frac{2(12-4)}{4\cdot5}=\frac45$. **Equality holds.** The family is equi-chordal and not equi-isoclinic, the second principal angle of every pair being $\frac\pi2$ and the first having $\cos^2\theta_1=\frac45$, exactly as Section 3 requires of any $\Lambda^2$-orthonormal family.

*Screen.* The construction above is closed form. As insurance against an algebra slip I evaluated it numerically in a few seconds: the $\omega$ Gram matrix is $I_6$ to $10^{-15}$, all six Pfaffians vanish, every $\Pi_\alpha$ is idempotent of trace $2$, the off-diagonal $S$ matrix is uniformly $0.8$, and $\sum_\alpha\Pi_\alpha=3I_4$. Reported as a screen, with the derivation above carrying the claim.

**So the answer to item 6 is that the bound binds, and binds exactly, at $n=3$ with $B=1$, at $2M=n$ with $B=0$ and mutually orthogonal planes, and at $n=4$, $M=6$ with $B=\frac45$.** The last of these is the interesting one, and it refutes the appraisal in C8: at $n=4$ the value $\frac4{n+1}$ is not "far below" anything, it is attained by a $\Lambda^2$-orthonormal decomposable basis, so the constant cannot be improved in that class.

## 7. The equi-isoclinic refinement, checked against the formula

With $M=6$, $c=2$, $d=6$,

$$\sigma^2=\frac{Mc-d}{d(M-1)}=\frac{12-6}{6\cdot5}=\frac6{30}=\frac15,\qquad\alpha=\frac{Mc}d=\frac{12}6=2,\qquad\beta=c\sigma^2=\frac25.$$

**The formula predicts exactly $\frac15$, so the record's identification is right, and the tightness constant $2$ matches $\sum\Pi_\alpha=2\,\mathrm{Id}_6$ as claimed.** The configuration itself is closed form: the six icosahedral lines in $\mathbb R^3$ span, over $\mathbb C$, six complex lines $L_\alpha=\mathbb Cv_\alpha\subset\mathbb C^3$ with $\lvert\langle v_\alpha,v_\beta\rangle\rvert^2=\frac15$, which is the Welch bound $\frac{M-d}{d(M-1)}=\frac3{15}=\frac15$ at $M=6$, $d=3$, so they form an equiangular tight frame. Realifying, $P_\alpha=\Pi_\alpha$ is the orthogonal projection of $\mathbb R^6$ onto $\mathrm{span}_{\mathbb R}(v_\alpha,iv_\alpha)$, $\sum_\alpha\Pi_\alpha$ is the realification of $2I_3$, namely $2\,\mathrm{Id}_6$, and complex linearity makes each pair isoclinic with both $\cos^2\theta_i=\lvert\langle v_\alpha,v_\beta\rangle\rvert^2=\frac15$. Then $S_{\alpha\beta}=\frac15+\frac15=\frac25=\beta$, and (G1) checks out: $5\cdot\frac25=2=2(\kappa-1)$ at $\kappa=2$.

**$\Lambda^2$-orthonormality fails, with an exact value.** By the principal-angle formula, $\langle\omega_\alpha,\omega_\beta\rangle=\pm\cos\theta_1\cos\theta_2=\pm\frac15$, and a direct computation on the real basis $(v,iv)$ of a complex line gives the determinant of the cross-Gramian as $\lvert\langle v_\alpha,v_\beta\rangle\rvert^2=\frac15$ with a consistent sign, so the $\Lambda^2$ Gram matrix of the family is $\frac45I_6+\frac15J_6$, positive definite and far from $I_6$. **Confirmed, and the failure is the one Section 3 predicts**: a $\Lambda^2$-orthonormal family cannot be equi-isoclinic with $\sigma^2>0$.

A remark on the given rather than the record. (G3)'s addendum, that an equi-isoclinic family is "necessarily equi-chordal, with $\alpha=\frac{Mc}d$ and $\sigma^2=\frac{Mc-d}{d(M-1)}$", overstates its source. Theorem 5.2 lists tightness and equi-isoclinity as two separate conditions and says the two values are forced only when both hold. Equi-isoclinity alone forces equi-chordality, since $\mathop{\mathrm{tr}}(P_jP_{j'})=c\sigma^2$ is then constant, and it does not force the values. Witness: three coplanar lines at $60^\circ$ in $\mathbb R^3$ are equi-isoclinic with $\sigma^2=\frac14$, while $\frac{Mc-d}{d(M-1)}=\frac{3-3}{3\cdot2}=0$ and $\sum_jP_j$ is $\frac32$ times the projection onto a plane rather than a multiple of $I_3$. Item 7's configuration supplies its own tightness, so the check above is unaffected, but a later use of the addendum without checking tightness would be unsound.

## 8. Boundary and degenerate cases

| Case | Simplex bound | (G1) and the record's use |
|---|---|---|
| $M=1$ | undefined: the denominator $M-1$ vanishes and $\max_{j\ne j'}$ is over the empty set | (G1) reads $0=2(\kappa-1)$, so $\kappa=1$, and (G2) then forces $n=2$, a single plane filling $\mathbb R^2$. Consistent, and carrying no content |
| $2M<n$, that is $Mc-d<0$ | strictly negative, hence vacuous against $S\ge0$ and unattainable | (G1)'s class is **empty**: $\mathop{\mathrm{rank}}\sum_\alpha\Pi_\alpha\le2M<n$ contradicts $\kappa\,\mathrm{Id}_n$. So no equi-chordal tight fusion frame exists in this range at all |
| $2M=n$ | bound is $0$ | attained exactly by $M$ mutually orthogonal planes, $\kappa=1$, every $S_{\alpha\beta}=0$, equi-isoclinic with $\sigma^2=0$. The one equality case available to a $\Lambda^2$-orthonormal family that is also equi-isoclinic |
| $n=4$ | $\frac{2(2M-4)}{4(M-1)}=\frac{M-2}{M-1}<1$ for every $M$, so vacuous against $S\le1$ throughout | the record's "$n>4$" excludes this case unnecessarily, see C7. At $M=6$ the bound is $\frac45$ and is attained, see Section 6 |
| odd $n$ | nothing degenerates. $\kappa=\frac{2M}n$ is rational and no integrality is used anywhere | at $M=\binom n2$, $\kappa=n-1$ is an integer for every $n$. At $n=3$, $M=3$ the bound equals $1$ exactly and is attained by the coordinate family |

**Is the bound vacuous in some range, and does the record stray there?** It is vacuous for $2M\le n$ against $S\ge0$, and vacuous against $S\le1$ for every $n\ge4$. The record's uses sit at $M=\binom n2$ with $n\ge3$, where $2M=n(n-1)>n$, so it stays clear of the first degeneracy, and its own conclusion in C6 is precisely a statement of the second. **No straying found.**

## 9. What would break the identification, and what I did to look

| Object or fact that would falsify something | Searched how | Outcome |
|---|---|---|
| A family where the simplex bound has content and isotropy fails, breaking "the two are one statement" | constructed directly, six planes through a common line in $\mathbb R^4$ | **Found** (Section 2). C2 falls |
| An isotropic family with strict inequality, breaking "equality is exactly isotropy" | evaluated the coordinate family, the record's own example | **Found** at every $n\ge4$ (Section 3). C3 falls |
| An equi-chordal $\Lambda^2$-orthonormal decomposable family with $0<B<1$, breaking the appraisal that $\frac4{n+1}$ is unreachably low | derived Lemmas A and B on the $\Lambda^\pm$ splitting, then built the family from the icosahedral Gram matrix and its Seidel switching | **Found and exact** at $n=4$, $M=6$, all overlaps $\frac45$ (Section 6). The appraisal in C8 falls, the arithmetic stands |
| An isotropic family of rank-$2$ projections violating (G1) | inspected the derivation, which uses only $\mathop{\mathrm{tr}}\Pi_\alpha^2=\mathop{\mathrm{tr}}\Pi_\alpha=2$ and linearity | **Impossible.** (G1) is unassailable, and it does not need $\Lambda^2$-orthonormality |
| An algebraic route from (G3) plus $S\le1$ plus $\Lambda^2$-orthonormality to an upper bound on $M$ | four attacks in Section 4, including the monotonicity of $f$ | **None exists.** Every upper-bound consequence bounds a minimum, and $f$ increasing turns each into a lower bound on $M$ |
| A definition of the record's Ricci-flatness condition against which to test C4 | the brief carries none, and reading the record is outside this brief | **Not reached.** C4 is recorded as HYPOTHESIS-DEBT, with the warning that isotropy is automatic at a full basis |

**Named and left open, blocked by the analysis-only rule.** Whether an equi-chordal $\Lambda^2$-orthonormal decomposable **basis** of $\Lambda^2\mathbb R^n$, all overlaps equal to $\frac4{n+1}$, exists for $n\ge5$. My $n=4$ construction is special to the three-dimensional $\Lambda^\pm$ splitting and does not generalise as written. Deciding it is a census over a family with no bound on where it looks, so I did not open it. What each outcome would mean: existence would make the simplex bound sharp throughout the record's class at every $n$, so the constant $\frac4{n+1}$ could never be improved there, and non-existence would mean the record can strengthen the constant for decomposable bases, which would sharpen the per-index relation while still, by Section 4, capping no multiplicity.

## Verdict

**CONFIRMED AS ALGEBRA, with two attached claims REFUTED AS STATED and one imported given corrected.**

- The identification in C1 is exact and is an identity in $M$ and $n$, not a coincidence. The simplex bound at $c=2$, $d=n$ and the per-index mean of (G1) with (G2) are the same rational function of $M$ and $n$, and (G4) matches the quantities.
- The identification is one-directional. The simplex bound needs no isotropy and (G1) does, so C2's "one statement" is wrong, and on the isotropic class (G1) is strictly stronger, giving a bound for every index plus an upper bound on every row's minimum that the record's max-at-least-mean reading discards.
- C3 is wrong as stated. Equality needs isotropy and equal overlaps, and the coordinate family at every $n\ge4$ is isotropic with the inequality strict. At a full basis isotropy is automatic, so if the record's Ricci-flatness condition is isotropy it constrains nothing there, and the condition with content is equi-chordality.
- C6, the multiplicity verdict, survives and can be strengthened: no combination of these relations can cap a multiplicity, because the only upper bounds available are on minima and the mean overlap increases in $M$.
- C8's arithmetic is right and its appraisal is wrong. The bound is attained by a $\Lambda^2$-orthonormal decomposable basis at $n=4$ with every overlap $\frac45$, so it is sharp inside the record's own class.
- C9 checks out exactly, at $\sigma^2=\frac15$, $\alpha=2$ and $\Lambda^2$ inner products $\frac15$, and the failure of $\Lambda^2$-orthonormality there is structural rather than accidental: at $c=2$, $\Lambda^2$-orthonormality and equi-isoclinity coexist only when all the planes are mutually orthogonal.
