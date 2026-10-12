# Verifier v175, Lemma L31, the bracket cap characterised, both directions and the equality case

Read cold from [BRIEF_L31.md](BRIEF_L31.md), [conventions.md](../findings/conventions.md) and the canonical block at [stratum-two-negative.md:417-438](../findings/stratum-two-negative.md). **No numerical work was done: every value in this report is exact, every witness is exhibited in closed form and its bracket computed by hand from $E_{ij}E_{kl}=\delta_{jk}E_{il}$.** Log: [agent_logs/verify-L31-v175.log](../agent_logs/verify-L31-v175.log).

## The claim table

| # | claim | verdict |
| --- | --- | --- |
| 1 | Normalisation: $\lVert X\rVert=1$ means $\sum_is_i^2=1$, and the block's $\lVert\cdot\rVert_F$ steps convert by $\lVert Z\rVert_F^2=2\lVert Z\rVert^2$ | CORRECT, AND LOAD-BEARING, AND UNWRITTEN |
| 2 | Root-system identity $\max_{\lVert Y\rVert=1}\lVert[X,Y]\rVert^2=(s_1+s_2)^2$, exact, maximiser admissible | CORRECT for $n\ge3$; FALSE as displayed at $n=2$ |
| 3 | Short roots $i(\pm s_i)$ present exactly at odd $n$, and cannot beat $(s_1+s_2)^2$ | CORRECT; the block's list omits the $n$-parity rider and the Cartan zeros, harmlessly |
| 4 | Cauchy–Schwarz: $(s_1+s_2)^2\le2$ with equality only at $s_1=s_2=1/\sqrt2$, rest zero, rank exactly $4$ | CORRECT |
| 5 | The two-step chain is an equality at the equality point | CORRECT, both halves are tight, at exactly $2$ |
| 6 | Equality forces $\operatorname{im}Y\subseteq\operatorname{im}X$ | CORRECT |
| 7 | "and symmetrically" gives the reverse inclusion | CORRECT, and terse: it re-runs the whole argument, not just the last step |
| 8 | Equality forces $XY=-YX$ | CORRECT |
| 9 | Converse: $X^2=Y^2=-P_V/2$, $[X,Y]=2XY$ give $\lVert[X,Y]\rVert^2=\operatorname{tr}(Y^{\mathsf T}Y)=2$ | CORRECT, every step, in the record's normalisation |
| 10 | The RHS conditions are exactly $X^2=Y^2=-P_V/2$ plus anticommuting | CORRECT, the silent translation is an equivalence |
| 11 | The three RHS conditions are independent | CONFIRMED, three closed-form near-misses below, one per dropped condition |
| 12 | The recorded counterexample $s^2=(0.5,0.3,0.2)$ refutes the old $\lVert[X,Y]\rVert^2\le4s_1^2$ route | CORRECT, and it is a counterexample to the *step* only |
| 13 | The replacement avoids the flaw | CORRECT, the identity is exact where $4s_1^2$ was slack |
| 14 | L31 delivers L29's clause "equality forces the support to have $r=4$" in three lines | DELIVERED, with one line of the three being L31's and the other two L29's own |
| 15 | Hypothesis "orthonormal" | ORTHOGONALITY STATED AND NEVER USED, the lemma holds for unit $X,Y$ |
| 16 | The statement consumers cite, the inequality $\lVert[X,Y]\rVert^2\le2$ | NOT IN THE CANONICAL STATEMENT, though proved inside the proof |
| 17 | [results.md:451](../results.md)'s pointer `#lemma-l31--the-pair-cap` | DEAD ANCHOR, a third instance of a defect twice repaired elsewhere |

**One line: the biconditional is true and its written proof is correct at every step in the record's half-trace normalisation; what it owes is scope and bookkeeping, the identity as displayed fails at $n=2$, the orthogonality hypothesis is never used, the inequality seven consumers cite L31 for is absent from L31's statement, and the pointer that carries the newly assigned L29 clause is dead.**

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md):

> **A skew matrix's norm**, in the form the stratum arguments use: $\langle X,X\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}X)$, singular values in pairs $s_1,s_1,s_2,s_2,\dots$ with $\sum_i s_i^2=1$.

> **A bivector's norm**, and the record runs in the first of these: $\lVert\varphi_{ab}\rVert^2=1$ under the half-trace pairing of the bullet above, which is the one every result uses and which makes $\{\varphi_{ab}\}_{a<b}$ orthonormal; $\lVert\varphi_{ab}\rVert^2=2$ under **plain Frobenius**, $\operatorname{tr}(X^{\mathsf T}X)$, for $\varphi_{ab}=E_{ab}-E_{ba}$.

> **The $\tfrac12$ goes at the $\Lambda^2$ level, not the operator level.** The inner product is $\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ at the $\Lambda^2$ level and plain Frobenius on the pair matrix.

**Consequence, and the one conversion the whole proof turns on.** For $Z\in\mathfrak{so}(n)$, $\lVert Z\rVert^2=\tfrac12\lVert Z\rVert_F^2$, i.e. $\lVert Z\rVert_F^2=2\lVert Z\rVert^2$. And $\lVert X\rVert^2=\tfrac12\operatorname{tr}(X^{\mathsf T}X)=\tfrac12\cdot2\sum_is_i^2=\sum_is_i^2$, so **$\lVert X\rVert=1$ is exactly $\sum_is_i^2=1$**, the normalisation the Cauchy–Schwarz step assumes is the record's, with no factor to reconcile. $\lVert\cdot\rVert_{\rm op}$ is the ordinary largest singular value, $=s_1$, unnormalised.

**Three norms appear in the block's one sentence and the block quotes none of them.** Section 1 shows the conversion is load-bearing: read in plain Frobenius, the block's own chain contradicts its own hypothesis.

## The hypothesis inventory

| hypothesis | where stated | used where, and how |
| --- | --- | --- |
| $X,Y\in\mathfrak{so}(n)$, real skew | statement | throughout: normal form, $\operatorname{im}X^{\mathsf T}=\operatorname{im}X$, $X^{\mathsf T}X=-X^2$ |
| $\lVert X\rVert=1$, i.e. $\sum_is_i^2=1$ | statement, via "orthonormal" | the Cauchy–Schwarz step (§2) |
| $\lVert Y\rVert=1$ | statement, via "orthonormal" | the chain's right-hand side, and the symmetrisation (§4) |
| $\langle X,Y\rangle=0$ | statement, via "orthonormal" | **nowhere**, see §8 |
| $s_1\ge s_2\ge\dots\ge0$, the angles of $X$ | implicit in "the angles $s_i$" | §1, §2 |
| $n$ large enough for two angles | **nowhere** | §1: the display is false at $n=2$ |
| $V:=\operatorname{im}X=\operatorname{im}Y$, $P_V$ its orthogonal projection | converse only; $V$ and $P_V$ are untabled in [conventions.md](../findings/conventions.md) | §5 |
| $\dim V=4$, all singular values $1/\sqrt2$ | RHS of the statement | §5, through the equivalent $X^2=Y^2=-P_V/2$ |
| $XY=-YX$ | RHS of the statement | §5, through $[X,Y]=2XY$ |

**Rank $4$ and "all singular values $1/\sqrt2$" together.** Rank $4$ means two nonzero angles, each appearing twice among the singular values; "all singular values $1/\sqrt2$" then means the four nonzero ones are $1/\sqrt2$, i.e. $s_1=s_2=1/\sqrt2$, consistent with $\sum s_i^2=\tfrac12+\tfrac12=1$. The two clauses are compatible in the record's normalisation and in no other: under plain Frobenius, unit norm with four equal singular values would force $1/2$, not $1/\sqrt2$.

**$n$-restriction.** None is stated. The conclusion forces $n\ge4$; the displayed identity needs $n\ge3$; the hypothesis is satisfiable from $n=3$ up ($\dim\mathfrak{so}(3)=3$) and vacuous at $n\le2$.

## 1. The root-system identity, derived

$\mathrm{ad}_X$ is skew-adjoint for the record's pairing: with $\langle A,B\rangle=-\tfrac12\operatorname{tr}(AB)$ on skew matrices,

$$\operatorname{tr}([X,Y]Z)+\operatorname{tr}(Y[X,Z])=\operatorname{tr}(XYZ-YXZ+YXZ-YZX)=\operatorname{tr}(XYZ)-\operatorname{tr}(YZX)=0 .$$

So $\mathrm{ad}_X$ is normal, $(\mathrm{ad}_X)^{\mathsf T}\mathrm{ad}_X=-(\mathrm{ad}_X)^2$, and the eigenvalues of that symmetric positive operator are the squares of the moduli of the eigenvalues of $\mathrm{ad}_X$ on the complexification. Hence

$$\max_{\lVert Y\rVert=1}\lVert[X,Y]\rVert^2=\lVert\mathrm{ad}_X\rVert_{\rm op}^2=\max\{\lvert\mu\rvert^2:\ i\mu\in\operatorname{spec}(\mathrm{ad}_X)\},$$

an **identity, not a bound**. Every real skew $X$ is $O(n)$-conjugate to a member of a maximal torus, and both the bracket and the pairing are $O(n)$-equivariant, so the angles $s_i$ may be taken to be the Cartan coordinates. On $\mathfrak{so}(n)_{\mathbb C}$ the eigenvalues of $\mathrm{ad}_X$ are $i\alpha(X)$ over the roots $\alpha$, together with $0$ on the $p=\lfloor n/2\rfloor$-dimensional Cartan:

- $D_p$ ($n=2p$): roots $\pm e_j\pm e_k$, $j<k$, giving $i(\pm s_j\pm s_k)$;
- $B_p$ ($n=2p+1$): the same, **plus** the short roots $\pm e_j$, giving $i(\pm s_j)$.

**So the short-root family is present exactly at odd $n$**, and the block's list (which prints both families unconditionally), over-states at even $n$. It cannot damage the maximum: with $s_j\ge0$ and $s_1\ge s_2$, $\ \lvert s_1\rvert\le s_1+s_2$ and $\lvert\pm s_j\pm s_k\rvert\le s_j+s_k\le s_1+s_2$, so the largest modulus is $s_1+s_2$ whatever the parity, and the spuriously-listed short roots never win. The omitted Cartan zeros likewise cannot raise a maximum. **The maximiser is admissible**: the $\pm i(s_1+s_2)$ eigenvalues sit on a *real* $2$-plane of $\mathfrak{so}(n)$, for $X=s_1\varphi_{12}+s_2\varphi_{34}$ it is $\operatorname{span}\{\varphi_{13}-\varphi_{24},\ \varphi_{14}+\varphi_{23}\}$, on which $\mathrm{ad}_X$ acts as $(s_1+s_2)$ times a rotation; any unit $Y$ there attains the maximum and is a genuine element of $\mathfrak{so}(n)$. It is also automatically orthogonal to $X$, being in a root space and $X$ in the Cartan.

### 1.1 The edge: the display is false at $n=2$

**Located.** The identity as written at [stratum-two-negative.md:35](../findings/stratum-two-negative.md) carries no $n$-restriction and names $s_1,s_2$ unconditionally, while $X$ has only $p=\lfloor n/2\rfloor$ angles.

**Exhibited.** At $n=2$, take $X=\varphi_{12}$: $\lVert X\rVert^2=1$, its single angle is $s_1=1$. $\mathfrak{so}(2)$ is one-dimensional and abelian, so $\mathrm{ad}_X\equiv0$ and $\max_{\lVert Y\rVert=1}\lVert[X,Y]\rVert^2=0$, against the display's $(s_1+s_2)^2=1$ read with $s_2:=0$.

**The opposite.** The most charitable reading is that "$s_1,s_2$" presupposes two angles, hence $n\ge4$, where the display is exactly right; and at $n=3$ ($p=1$) it is rescued by the short root, since $\max=s_1^2=(s_1+0)^2$. Since $\mathfrak{so}(2)$ holds no orthonormal pair, L31's hypothesis is vacuous exactly where the display fails, so **nothing downstream is touched**, this is a scope line owed to the display, not a defect in the lemma. Recorded as such.

## 2. Cauchy–Schwarz, and the normalisation

$(s_1+s_2)^2\le2(s_1^2+s_2^2)\le2\sum_is_i^2=2$, using $\sum_is_i^2=1$, which §0 shows **is** $\lVert X\rVert=1$ in the record's convention. Equality in the first needs $s_1=s_2$; equality in the second needs $s_i=0$ for $i\ge3$; together $s_1=s_2=1/\sqrt2$ and the rest zero, so $\operatorname{rank}X=4$ with the four nonzero singular values all $1/\sqrt2$. **This is exactly the claim, and there is no factor to reconcile.** Chaining §1 and §2, $\lVert[X,Y]\rVert^2\le(s_1+s_2)^2\le2$, and $\lVert[X,Y]\rVert^2=2$ forces equality in both, so the rank conclusion for $X$ is sound.

Two edges. If $\operatorname{rank}X=2$ then $s_2=0$, $s_1=1$ and the maximum is $1$; if $p\le1$ ($n\le3$) the maximum is at most $s_1^2=1$. **So the cap $2$ is unreachable below $n=4$**, and at $n=3$ the honest value is $1$, which agrees with the record's own $[\varphi_{12},\varphi_{13}]=-\varphi_{23}$, of norm $1$.

## 3. The two-step chain, and whether both inequalities can be equalities at once

They can, and at the equality point they are. After §2, $\lVert X\rVert_{\rm op}=s_1=1/\sqrt2$ and $\lVert Y\rVert_F=\sqrt2\lVert Y\rVert=\sqrt2$, while $\lVert[X,Y]\rVert_F=\sqrt2\cdot\sqrt{2}=2$. The chain reads

$$2=\lVert[X,Y]\rVert_F\ \le\ \lVert XY\rVert_F+\lVert YX\rVert_F\ \le\ 2\lVert X\rVert_{\rm op}\lVert Y\rVert_F=2\cdot\tfrac1{\sqrt2}\cdot\sqrt2=2 ,$$

so **both** inequalities are equalities and $\lVert XY\rVert_F=\lVert YX\rVert_F=1$. The block asserts "Equality in ... then forces" without this one line; the line is mechanical, but it is the line where the normalisation bites, and it is missing.

**The conversion is load-bearing, and this is the check that pins it.** Read the same chain in plain Frobenius, $\lVert X\rVert_F=\lVert Y\rVert_F=1$, so $\lVert X\rVert_{\rm op}=1/2$ at rank $4$ with equal singular values, and the chain gives $\lVert[X,Y]\rVert_F\le2\cdot\tfrac12\cdot1=1$, while the hypothesis would demand $\lVert[X,Y]\rVert_F=\sqrt2$. The equality set would be **empty**. So the block's mixed-norm sentence is consistent in the half-trace convention and self-contradictory in the other, which is the strongest available evidence that [conventions.md:72](../findings/conventions.md) is the one the block commits to. It quotes it nowhere.

Now each of the three conclusions the block draws:

1. **$\lVert XY\rVert_F=\lVert X\rVert_{\rm op}\lVert Y\rVert_F$ forces the columns of $Y$ into $X$'s top singular subspace.** True: $\lVert XY\rVert_F^2=\sum_j\lVert Xy_j\rVert^2\le\lVert X\rVert_{\rm op}^2\sum_j\lVert y_j\rVert^2$ over the columns $y_j$, with equality iff every $y_j$ lies in the top eigenspace of $X^{\mathsf T}X$.
2. **That subspace is all of $\operatorname{im}X$, so $\operatorname{im}Y\subseteq\operatorname{im}X$.** True *because of §2*: $X^{\mathsf T}X=-X^2=\tfrac12P_{\operatorname{im}X}$, all nonzero singular values coinciding, so the top eigenspace is exactly $\operatorname{im}X$. The block states this reason. The order of the proof matters here and is correct, §2 runs first.
3. **$XY=-YX$.** True, and the block's route is the right one. In the Frobenius inner product, $\lVert A+B\rVert_F=\lVert A\rVert_F+\lVert B\rVert_F$ with $A,B\ne0$ holds iff $B$ is a positive multiple of $A$. Here $A=XY$, $B=-YX$, both of norm $1\ne0$, so the multiple is $1$ and $XY=-YX$. The block's parenthetical "with $\lVert XY\rVert_F=\lVert YX\rVert_F$" is exactly what pins the multiple to $1$, and that equality is available from step 3 above.

**One redundancy worth naming.** The second half of the chain is two inequalities, $\lVert XY\rVert_F\le\lVert X\rVert_{\rm op}\lVert Y\rVert_F$ and $\lVert YX\rVert_F\le\lVert Y\rVert_F\lVert X\rVert_{\rm op}$. Equality in the second says the columns of $Y^{\mathsf T}$ lie in the top singular subspace of $X^{\mathsf T}$; since $X$ is normal that subspace is again $\operatorname{im}X$, and since $Y$ is skew $\operatorname{im}Y^{\mathsf T}=\operatorname{im}Y$, so it repeats conclusion 2 and yields **no** reverse inclusion. Anyone reading "and symmetrically" as *the other half of the same chain* gets nothing. §4 is what the phrase must mean.

## 4. The symmetrisation

**What "and symmetrically" needs, and has.** The hypothesis set $\{X,Y\ \text{unit},\ \lVert[X,Y]\rVert^2=2\}$ is invariant under $X\leftrightarrow Y$, because $[Y,X]=-[X,Y]$ has the same norm. So §1–§3 re-run verbatim with the roles exchanged and give: $Y$ has rank $4$ with all singular values $1/\sqrt2$, and $\operatorname{im}X\subseteq\operatorname{im}Y$. With §3's inclusion this gives $\operatorname{im}X=\operatorname{im}Y$; equivalently, the two inclusions are redundant with each other once both ranks are known to be $4$.

**Verdict: valid, and terse to the point of being misleading.** The phrase sits at the end of the sentence that ran the chain, where the natural reading is the redundant one refuted just above; the work it actually does is a second pass through the root-system and Cauchy–Schwarz steps. The Statement paragraph names this correctly, *"The rank is derived for $X$ and follows for $Y$ by the symmetry of the bracket in its two arguments"*, so the block records the right justification, in the wrong place.

## 5. The converse, every step

Hypotheses: $\operatorname{rank}X=\operatorname{rank}Y=4$, all singular values $1/\sqrt2$, $V:=\operatorname{im}X=\operatorname{im}Y$, $XY=-YX$.

**The translation to $X^2=Y^2=-P_V/2$ is an equivalence, not a weakening.** $X$ skew gives $X^{\mathsf T}X=-X^2$ symmetric positive semidefinite with the same image as $X$; its eigenvalues are the squared singular values, all $\tfrac12$ on $V$ and $0$ on $V^\perp$; hence $-X^2=\tfrac12P_V$. Conversely $X^2=-P_V/2$ returns rank $4$ and singular values $1/\sqrt2$. Same for $Y$.

**$[X,Y]=2XY$** is immediate from $YX=-XY$.

**The trace.** In the record's pairing,

$$\lVert[X,Y]\rVert^2=\tfrac12\operatorname{tr}\big([X,Y]^{\mathsf T}[X,Y]\big)=\tfrac12\cdot4\operatorname{tr}\big(Y^{\mathsf T}X^{\mathsf T}XY\big)=2\operatorname{tr}\big(Y^{\mathsf T}\tfrac12P_VY\big)=\operatorname{tr}\big(Y^{\mathsf T}P_VY\big)=\operatorname{tr}(Y^{\mathsf T}Y),$$

the last step because $\operatorname{im}Y=V$ gives $P_VY=Y$. And $\operatorname{tr}(Y^{\mathsf T}Y)=2\lVert Y\rVert^2=2$. **So the block's displayed chain $\lVert[X,Y]\rVert^2=\operatorname{tr}(Y^{\mathsf T}Y)=2$ is right term for term, intermediate included.** The final $=2$ is again a normalisation statement: in plain Frobenius $\operatorname{tr}(Y^{\mathsf T}Y)$ would be $1$. Both ends of the block therefore commit to the half-trace convention, consistently.

**A hypothesis the converse does not need.** Orthogonality of $X,Y$ is not used; it is a *consequence*, since $XY=-YX$ gives $\operatorname{tr}(XY)=\operatorname{tr}(YX)=-\operatorname{tr}(XY)=0$, i.e. $\langle X,Y\rangle=-\tfrac12\operatorname{tr}(XY)=0$. So the RHS of the biconditional implies the standing hypothesis, and the statement is internally consistent.

**The witness, at the smallest admissible dimension.** At $n=4$ put $I_1=\varphi_{12}+\varphi_{34}$, $I_2=\varphi_{13}-\varphi_{24}$, $I_3=\varphi_{14}+\varphi_{23}$. Since $\varphi_{12}\varphi_{34}=\varphi_{34}\varphi_{12}=0$, $I_1^2=\varphi_{12}^2+\varphi_{34}^2=-\mathrm{Id}_4$, and likewise for $I_2,I_3$. By hand, $\varphi_{12}\varphi_{13}=-E_{23}$, $\varphi_{12}(-\varphi_{24})=-E_{14}$, $\varphi_{34}\varphi_{13}=E_{41}$, $\varphi_{34}(-\varphi_{24})=E_{32}$, so $I_1I_2=(E_{32}-E_{23})+(E_{41}-E_{14})=\varphi_{23}\cdot(-1)+\varphi_{14}\cdot(-1)=-I_3$. Take $X=I_1/\sqrt2$, $Y=I_2/\sqrt2$: $\lVert X\rVert^2=\tfrac12\cdot\tfrac12\operatorname{tr}(\mathrm{Id}_4)=1$, rank $4$, all singular values $1/\sqrt2$, $\operatorname{im}X=\operatorname{im}Y=\mathbb R^4$, $XY=-YX$, and $[X,Y]=2XY=I_1I_2=-I_3$, whence $\lVert[X,Y]\rVert^2=\tfrac12\operatorname{tr}(\mathrm{Id}_4)=2$. **The equality set is nonempty at $n=4$**, and padding by zeros carries the same pair into every $n\ge4$, odd $n$ included, so $n=5$ is populated and nothing about the short roots obstructs it ($X$'s root values there are $\pm\sqrt2,0,\pm1/\sqrt2$, maximum $\sqrt2$, as §1 predicts).

**The converse is checked as a theorem, not at one object**, so the "biconditional verified at one witness" trap does not apply. The $n=4$ computation above is an independent confirmation, not the argument.

## 6. The three conditions are independent, three closed-form near-misses

Each meets exactly two of the three RHS conditions and fails the cap, so none of the three may be dropped from the statement.

| dropped condition | witness | bracket |
| --- | --- | --- |
| $XY=-YX$ | $n=4$: $X=I_1/\sqrt2$, $Y=J_1/\sqrt2$ with $J_1=\varphi_{12}-\varphi_{34}$. $J_1^2=-\mathrm{Id}_4$, so $Y$ is rank $4$ with singular values $1/\sqrt2$ and $\operatorname{im}Y=\mathbb R^4=\operatorname{im}X$; $\operatorname{tr}(I_1J_1)=\operatorname{tr}(\varphi_{12}^2-\varphi_{34}^2)=0$ so they are orthonormal | $[\varphi_{12},\varphi_{34}]=0$, so $[X,Y]=0$ and $\lVert[X,Y]\rVert^2=0$ |
| $\operatorname{im}X=\operatorname{im}Y$ | $n=8$: $X$ the $n=4$ witness on $\operatorname{span}(e_1,\dots,e_4)$, $Y$ the same on $\operatorname{span}(e_5,\dots,e_8)$. Both rank $4$, singular values $1/\sqrt2$, orthonormal, and $XY=YX=0$ so they anticommute | $\lVert[X,Y]\rVert^2=0$ |
| rank $4$ with singular values $1/\sqrt2$ | $n=8=4+4$: $X=J/2$, $Y=J'/2$ with $J=I_1\oplus I_1$ and $J'=I_2\oplus I_2$ block-diagonal. Each block squares to $-\mathrm{Id}_4$ and the blocks anticommute, so $J^2=J'^2=-\mathrm{Id}_8$ and $JJ'=-J'J$. $\lVert X\rVert^2=\tfrac12\cdot\tfrac14\cdot8=1$, images both $\mathbb R^8$, $XY=-YX$ | $[X,Y]=2XY=\tfrac12JJ'$ and $(JJ')^{\mathsf T}JJ'=\mathrm{Id}_8$, so $\lVert[X,Y]\rVert^2=\tfrac14\cdot\tfrac12\cdot8=1$ |

**And the whole $\Lambda^+$ family saturates**, confirming the record's line at [stratum-two-negative.md:33](../findings/stratum-two-negative.md). For $X=\sum_ja_jI_j/\sqrt2$, $Y=\sum_jb_jI_j/\sqrt2$ with $\lvert a\rvert=\lvert b\rvert=1$, $a\cdot b=0$: the $I_j$ pairwise anticommute and square to $-\mathrm{Id}_4$, so $X^2=-\lvert a\rvert^2\mathrm{Id}_4/2=-P_V/2$ and $XY=-YX$, and $[X,Y]=-(a\times b)\cdot I$ has $\lVert\cdot\rVert^2=2$. Every such pair satisfies L31's RHS, as it must.

## 7. The correction the block records

**The counterexample checks.** $s^2=(0.5,0.3,0.2)$ has $\sum_is_i^2=1$, so it is a legitimate unit $X$, of rank $2\cdot3=6$ (needing $n\ge6$), with $s_1^2=\tfrac12$, so $4s_1^2=2$ and the old bound $\lVert[X,Y]\rVert^2\le4s_1^2\le2$ is saturated at rank $6$. **The inference "the cap forces rank $4$" therefore does not follow from that bound**, exactly as recorded. Note the bound itself is sound and is the §3 chain squared: $\lVert[X,Y]\rVert_F^2\le4\lVert X\rVert_{\rm op}^2\lVert Y\rVert_F^2$ reads $2\lVert[X,Y]\rVert^2\le4s_1^2\cdot2$ in the record's convention.

**It refutes the step and not the lemma.** For that $X$ the true maximum is $(s_1+s_2)^2=0.8+2\sqrt{0.15}$, and $2\sqrt{0.15}<1.2\iff0.15<0.36$, so the maximum is strictly below $2$. No L31 violation is implied, and none exists.

**The replacement genuinely avoids the flaw.** $4s_1^2$ is an over-estimate of $(s_1+s_2)^2$ whenever $s_1>s_2$, and its equality condition $s_1^2=\tfrac12$ says nothing about $s_3,s_4,\dots$. The root-system value is an *identity* (§1), so its equality condition under $\sum_is_i^2=1$ is $s_1=s_2$ **and** the rest zero, which is precisely rank $4$. The old chain survives in the proof, but only downstream of §2, used for its equality conditions and never again for the rank. **The flawed inference is not reused.**

## 8. Hypotheses stated and not used, and used and not stated

**Stated, never used: orthogonality.** No step of either direction uses $\langle X,Y\rangle=0$. The forward direction uses $\lVert X\rVert=\lVert Y\rVert=1$ only; the converse uses none of it and re-derives orthogonality (§5). **So L31 is true as stated with "orthonormal" weakened to "of unit norm"**, a strictly stronger lemma with the same proof. Nothing downstream is harmed, since every consumer feeds it eigenvectors of a symmetric operator, which are orthonormal anyway; the finding is that the statement is weaker than its proof in a second, harmless way.

**Used, never stated: the $n$-restriction on the display** (§1.1), and the norm conversion (§0, §3).

**Symbols.** $s$ (angles of $X$ here; $s=\sum\lambda$ in [L42](../results.md)), $V$, $P_V$ (against the tabled $P(W)$, the cubic form) and $X,Y$ are all load-bearing in this block and **none is in [conventions.md](../findings/conventions.md)'s tables**. $P_V$ against $P$ is a live collision in a file that already tables two senses of $\mathring R$ and two of $N$.

## 9. The clause L31 is now credited with

L29's three lines, at [stratum-two-negative.md:82-84](../findings/stratum-two-negative.md): *"equality forces $T_{1,N-1,N}=2$, hence $\lVert[v_{N-1},v_N]\rVert^2=2$, hence $\operatorname{im}v_2=\operatorname{im}v_3$ of dimension $4$, hence $r=4$ through Ricci-flatness."* Checked line by line:

1. **$T_{1,N-1,N}=2$.** L29's chain is $\theta\le\ \cdot\ \le f(t)\le f(1)=\sqrt{3/2}$, whose only inequality below the last is the pair cap applied to $3T_{1,N-1,N}\lambda_1ab$. At equality $a=b=\lambda_1/2>0$, so the coefficient is nonzero and $T_{1,N-1,N}=2$ is forced. **Correct, and it is L29's own step, not L31's.**
2. **$\lVert[v_{N-1},v_N]\rVert^2=2$.** By total symmetry of $T$ and the identity $\sum_\gamma T_{N-1,N,\gamma}=\lVert[v_{N-1},v_N]\rVert^2$ with $T\ge0$: the single term $T_{N-1,N,1}=2$ forces the sum to be $\ge2$, and the cap gives $\le2$. **Correct.**
3. **$\operatorname{im}v_2=\operatorname{im}v_3$ of dimension $4$.** This is L31, applied to the orthonormal pair $v_{N-1},v_N\in\Lambda^2\cong\mathfrak{so}(n)$, orthonormal in the half-trace pairing, which is L31's own. **This is the one line L31 supplies, and it supplies it.**
4. **$r=4$.** Ricci-flatness reads $\lambda_1v_1v_1^{\mathsf T}=a\,v_2v_2^{\mathsf T}+b\,v_3v_3^{\mathsf T}$; the image of a sum of positive semidefinite matrices is the sum of their images, so $\operatorname{im}v_1=\operatorname{im}v_2+\operatorname{im}v_3=\operatorname{im}v_2$, of dimension $4$, and the support is $\operatorname{im}v_1$. **Correct, and it is L29's own machinery.**

**Verdict on the credit: the clause does close, in three lines, with L31 as the essential input.** [results.md:451](../results.md)'s phrasing (*"equality forces the support to have $r=4$ is Lemma L31's, in three"*), over-assigns slightly: L31 owns line 3, while lines 1 and 4 are L29's chain and Ricci-flatness. The stratum file's own phrasing, *"is closed in three lines by Lemma L31"*, is the accurate one. Recorded as a phrasing note, since the mathematics is right either way.

**Two bookkeeping defects on the same sentence.**

- **The pointer is dead.** [results.md:451](../results.md) links `#lemma-l31--the-pair-cap`. The heading is `##### Lemma L31, the bracket cap, characterised`, so the live anchor is `#lemma-l31--the-bracket-cap-characterised`, and no heading anywhere in [results.md](../results.md) contains the words "pair cap". **This is a third instance of a defect [r543](../reviews/REVIEW_r543.md) and [r544](../reviews/REVIEW_r544.md) already found and had repaired twice**, they fixed the two copies inside [stratum-two-negative.md](../findings/stratum-two-negative.md) (`#lemma-l31--the-bracket-cap-and-what-saturates-it`) and this one, in a different file with a different wrong title, survived. It sits on the load-bearing sentence that carries the reassigned clause.
- **The index collides inside the chain.** The sentence says "$\lVert[v_{N-1},v_N]\rVert^2$" and then "$\operatorname{im}v_2=\operatorname{im}v_3$" for the same two vectors, the $\Lambda^2$-sorted labelling and the three-nonzero-eigenvalues labelling in consecutive clauses. Unambiguous against the Ricci-flatness display four lines below, which fixes $v_1,v_2,v_3$ as the three nonzero eigenvectors, but it is one more unrecorded collision.

## 10. The gap between what is proven and what is used

**The canonical statement does not contain the inequality that seven consumers cite L31 for.** [results.md:461-465](../results.md) states only the biconditional about $\lVert[X,Y]\rVert^2=2$. Meanwhile [conventions.md:109](../findings/conventions.md) reads

> The pair cap $\sum_\gamma T_{\alpha\beta\gamma}=\lVert[v_\alpha,v_\beta]\rVert^2\le2$ is **[Lemma L31](stratum-two-negative.md)**, proved with its equality case characterised

and [L29](../findings/stratum-two-negative.md), [L35](../findings/stratum-two-negative.md), [L42](../results.md), [L143](../findings/bounds.md), [bounds.md:226](../findings/bounds.md), [bounds.md:375](../findings/bounds.md) and [diagonality.md](../findings/INDEX.md) all consume the **inequality** $\lVert[v_\alpha,v_\beta]\rVert^2\le2$ under L31's number. [bounds.md:375](../findings/bounds.md) is explicit that "what L35 needs is L31".

**The bound is genuinely proved** (it is §1 followed by §2, and it needs no equality analysis) so this is a statement defect, not a mathematical one, and the repair is one clause. **But as the canonical statement stands, every one of those consumers cites a result whose stated content it does not assert**, and a reader who checks L31 against [results.md](../results.md) alone finds only the equality case.

Discrepancy protocol: (1) located at [results.md:461-465](../results.md) and the block's **Statement** paragraph, both of which give only the biconditional; (2) exhibited, L35's chain needs $T_{\alpha\beta\gamma}\le2$ at points where $\lVert[v_\alpha,v_\beta]\rVert^2$ is *not* $2$, which the biconditional says nothing about; (3) the opposite, the title "the bracket **cap**, characterised" and the phrase in [conventions.md](../findings/conventions.md), "proved with its equality case characterised", both read the result as cap-plus-characterisation, and the proof delivers exactly that. So the charitable reading is available and is presumably the intended one; what is missing is the half-line of statement that would make it survive a cold read.

### 10.1 A candidate withdrawn

**Withdrawn: "the max is taken over all unit $Y$, including $Y$ not orthogonal to $X$, so the identity is applied outside the lemma's hypothesis."** Located at the block's $\max_{\lVert Y\rVert=1}$. But it fails step 2: the forward direction needs only an *upper* bound on $\lVert[X,Y]\rVert^2$ for the particular admissible $Y$ at hand, and enlarging the feasible set of a maximum can only enlarge it, the direction is safe. And step 3 answers itself: at the equality point the maximiser *is* orthogonal to $X$, by §5's $\operatorname{tr}(XY)=0$, and in general the root-space maximiser lies orthogonal to the Cartan. Withdrawn as no defect.

### 10.2 A candidate withdrawn

**Withdrawn: "'and symmetrically' is unsupported, since the second half of the chain gives no reverse inclusion."** Located at [stratum-two-negative.md:39](../findings/stratum-two-negative.md), and the failure is exhibited in §3's redundancy note, the $\lVert YX\rVert_F$ equality genuinely repeats the first inclusion. But step 3 defeats it: the hypothesis set is symmetric under $X\leftrightarrow Y$, the Statement paragraph says so in as many words, and re-running §1–§3 with the roles swapped closes it. Withdrawn as a clarity defect rather than a gap.

## What would falsify this, and what was done to look for it

**In the forward direction**: an orthonormal (indeed a merely unit) pair $X,Y\in\mathfrak{so}(n)$ with $\lVert[X,Y]\rVert^2=2$ but $X$ of rank other than $4$, or with unequal singular values, or with $\operatorname{im}X\ne\operatorname{im}Y$, or commuting somewhere. **No such object can exist**, and §1–§2 is the reason rather than a search: for any unit $X$ the *maximum over all* unit $Y$ is exactly $(s_1+s_2)^2\le2(s_1^2+s_2^2)\le2$, so any $X$ with a third nonzero angle or with $s_1\ne s_2$ is strictly below the cap for every $Y$ whatsoever. I checked the record's own near-miss candidate, $s^2=(0.5,0.3,0.2)$ at rank $6$: its maximum is $0.8+2\sqrt{0.15}<2$ exactly, so the rank-$6$ family the old argument could not exclude is excluded by the new one.

**In the converse direction**: a pair meeting all three RHS conditions with $\lVert[X,Y]\rVert^2\ne2$. §5 computes the bracket norm from the three conditions alone, with no choice left open, so none exists. I looked in the place such a thing would hide (pairs meeting *most* of the conditions) and built the three near-misses of §6 in closed form: the self-dual/anti-self-dual pair $(I_1,J_1)/\sqrt2$ at $n=4$, which meets everything but anticommuting and brackets to $0$; the two disjoint $4$-blocks at $n=8$, which meet everything but equal images and bracket to $0$; and the pair of scaled complex structures on $\mathbb R^8$, which meet everything but the rank and bracket to $1$. Each fails the cap, in the direction the lemma requires, so **no condition is droppable and the characterisation is tight**.

**In the record rather than the mathematics**: a consumer citing L31 for something the biconditional does not say. That one exists (§10) and it is the finding with the widest reach.

## Verdict

`PROVEN, hypotheses corrected`

The biconditional is true and every step of the written proof is correct in the record's half-trace normalisation, in both directions, including the converse's trace evaluation term for term and the recorded correction with its counterexample. What is owed is scope and statement:

1. **The displayed root-system identity needs $n\ge3$** (at $n=2$ it reads $0=1$) and its short-root family belongs to odd $n$ only. Both are harmless downstream, since L31's hypothesis is vacuous at $n\le2$ and the short roots never beat $(s_1+s_2)^2$.
2. **The statement should carry the cap $\lVert[X,Y]\rVert^2\le2$**, which the proof establishes and which seven consumers cite L31 for while the canonical statement asserts only the equality case.
3. **"Orthonormal" may be weakened to "unit"**, the orthogonality half is never used, and is implied by the RHS.
4. **The norm conversion $\lVert Z\rVert_F^2=2\lVert Z\rVert^2$ is load-bearing and unwritten**; the block quotes none of the three norms it uses in one sentence, and the mixed-norm chain is self-contradictory in the other convention.
5. **[results.md:451](../results.md)'s anchor `#lemma-l31--the-pair-cap` is dead**, the third instance of a defect [r543](../reviews/REVIEW_r543.md) and [r544](../reviews/REVIEW_r544.md) repaired in the other file, sitting on the sentence that carries the reassigned L29 clause.
6. **The clause credited to L31 does close**, in three lines, with L31 supplying the middle one and L29's own chain and Ricci-flatness the other two.
