# Verifier v173, Lemma L31, the bracket cap characterised, and the $r=4$ clause it was reassigned

Cold read of [Lemma L31](../findings/stratum-two-negative.md) from the definitions in [conventions.md](../findings/conventions.md), against the verbatim brief [BRIEF_L31.md](BRIEF_L31.md). **No numerical work was done. Every value below is exact and derived by hand**; the one object I built (a closed-form orthonormal pair in $\mathfrak{so}(4)$ attaining the cap), is a witness constructed and multiplied out in the record's own $\varphi_{ab}$ basis, not a search. Log: [agent_logs/verify-L31-v173.log](../agent_logs/verify-L31-v173.log).

## The claim table

| # | claim | verdict |
| --- | --- | --- |
| 1 | Root-system identity $\max_{\lVert Y\rVert=1}\lVert[X,Y]\rVert^2=(s_1+s_2)^2$ | **CORRECT** at every $n\ge3$; exact, maximiser admissible and choosable $\perp X$ |
| 1a | The eigenvalue list as written, "$i(\pm s_i\pm s_j)$ and $i(\pm s_i)$" | **IMPRECISE, IMMATERIAL**, the short-root family exists at odd $n$ only, and cannot beat $s_1+s_2$ either way |
| 2 | Cauchy–Schwarz: $\sum_is_i^2=1\Rightarrow(s_1+s_2)^2\le2$, equality only at $s_1=s_2=1/\sqrt2$ | **CORRECT**, and $\sum_is_i^2=1$ **is** what $\lVert X\rVert=1$ means here |
| 3 | The two-step Frobenius chain is tight, and all three equality conclusions follow | **CORRECT**, I derive each of the three separately |
| 3a | The chain mixes $\lVert\cdot\rVert$, $\lVert\cdot\rVert_F$, $\lVert\cdot\rVert_{\rm op}$ with no conversion stated | **HARMLESS**, the inequality is homogeneous of degree one in the Frobenius-type norm, so the factor $\sqrt2$ cancels and both readings give the same equality |
| 4 | "and symmetrically" delivers $\mathrm{im}\,X\subseteq\mathrm{im}\,Y$ | **CORRECT**, and it consumes $Y$'s rank-$4$ clause, which lives in the Statement's aside rather than in the proof |
| 5 | The converse: $X^2=Y^2=-P_V/2$, $[X,Y]=2XY$, $\lVert[X,Y]\rVert^2=\operatorname{tr}(Y^{\mathsf T}Y)=2$ | **CORRECT** in the record's normalisation, every step, including $\operatorname{tr}(Y^{\mathsf T}Y)=2\lVert Y\rVert^2=2$ |
| 5a | The stated right-hand side implies orthonormality outright | **STRENGTHENING**, norm and orthogonality both fall out of the RHS |
| 6 | The recorded correction, and its counterexample $s^2=(0.5,0.3,0.2)$ at rank $6$ | **CORRECT**, and the replacement genuinely avoids the flaw: that spectrum gives $(s_1+s_2)^2=0.8+2\sqrt{0.15}<1.6<2$ |
| 7 | [results.md](../results.md)'s clause, L31 delivers "equality forces the support to have $r=4$" in three lines | **DELIVERED**, all four steps check |
| 7a | The three-line chain's labels | **SYMBOL COLLISION**, the one sentence writes $v_{N-1},v_N$ then $v_2,v_3$ for the same pair |
| 8 | [results.md:451](../results.md)'s cross-reference `#lemma-l31--the-pair-cap` | **BROKEN LINK**, no heading on the record yields that anchor |
| 9 | Non-vacuity of the biconditional | **WITNESSED**, closed form at $n=4$ below, and the record already carries the family at [stratum-two-negative.md](../findings/stratum-two-negative.md) line 35 |
| 10 | Every downstream use of L31 stays inside what is proved | **CORRECT**, five consumers checked |

**Verdict in one line: the lemma is PROVEN, both directions close, the equality case is complete, and the only defects found are one broken anchor, one label collision and two imprecisions, none of them load-bearing.**

## 0. Conventions, fixed once

Quoted, not restated. From [conventions.md](../findings/conventions.md), the bullet that settles the normalisation:

> **A skew matrix's norm**, in the form the stratum arguments use: $\langle X,X\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}X)$, singular values in pairs $s_1,s_1,s_2,s_2,\dots$ with $\sum_i s_i^2=1$. Equivalent to $\operatorname{tr}(v^2)=-2$ above.

and the bullet that fixes the identification of $\Lambda^2$ with $\mathfrak{so}(n)$:

> **A bivector's norm**, and the record runs in the first of these: $\lVert\varphi_{ab}\rVert^2=1$ under the half-trace pairing of the bullet above, which is the one every result uses and which makes $\{\varphi_{ab}\}_{a<b}$ orthonormal; $\lVert\varphi_{ab}\rVert^2=2$ under **plain Frobenius**, $\operatorname{tr}(X^{\mathsf T}X)$, for $\varphi_{ab}=E_{ab}-E_{ba}$.

and, for what L31 is to the record:

> The pair cap $\sum_\gamma T_{\alpha\beta\gamma}=\lVert[v_\alpha,v_\beta]\rVert^2\le2$ is **[Lemma L31](stratum-two-negative.md)**, proved with its equality case characterised.

**Three norms appear in the one proof and this section fixes all three before section 1.**

- $\lVert\cdot\rVert$ on $\mathfrak{so}(n)$ is the half-trace of the first quoted bullet: $\lVert A\rVert^2=\tfrac12\operatorname{tr}(A^{\mathsf T}A)$. Every displayed constant in the Statement (the $2$, the $1/\sqrt2$), is in this norm.
- $\lVert\cdot\rVert_F$ is plain Frobenius, $\lVert A\rVert_F^2=\operatorname{tr}(A^{\mathsf T}A)=2\lVert A\rVert^2$. It appears only inside the chain.
- $\lVert\cdot\rVert_{\rm op}$ is the genuine operator norm, carrying no factor at all, so $\lVert X\rVert_{\rm op}=s_1$ under either of the other two.

**The constant $2$ is entirely a creature of the half-trace convention.** Under plain Frobenius, $\lVert X\rVert_F=1$ would read $\sum_is_i^2=\tfrac12$ and the cap would be $1$. That the record means the half-trace one is pinned twice over: by the quoted bullet, and independently by [Lemma L29](../findings/stratum-two-negative.md), whose chain $\langle W,W^\#\rangle\le6\lambda_1ab$ is the pair cap $\le2$ substituted once, and which at the spectrum $(2,-1,-1)/\sqrt6$ returns $\operatorname{tr}W^3+\langle W,W^\#\rangle=6^{-1/2}+2\cdot6^{-1/2}=3/\sqrt6=\sqrt{3/2}$, the record's own attained value. Halving the cap would return $\sqrt{2/3}$ and break that anchor.

## 1. The hypothesis inventory

**A pass with no inventory is not a pass, so here is the inventory, and then which hypotheses the written proof actually uses.**

| hypothesis, as written | reading fixed | used in the forward proof? |
| --- | --- | --- |
| $X,Y\in\mathfrak{so}(n)$ | real skew $n\times n$ | yes, throughout, skewness gives $\mathrm{im}\,X=(\ker X)^\perp$ and $\mathrm{im}\,X^{\mathsf T}=\mathrm{im}\,X$, both load-bearing at step 3 |
| $\lVert X\rVert=\lVert Y\rVert=1$ | half-trace, i.e. $\sum_is_i^2=1$ | yes, at the Cauchy–Schwarz step and at the chain's right-hand side |
| $\langle X,Y\rangle=0$ (the other half of "orthonormal") | half-trace pairing $\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ | **no, never used**, see §5a |
| $s_1,s_2$ | the two largest angles, ordering assumed and never stated | yes; the identity is false without the ordering |
| "rank $4$ with all singular values $1/\sqrt2$" | rank $4$, and all **nonzero** singular values $1/\sqrt2$ |, (conclusion) |
| $\mathrm{im}\,X=\mathrm{im}\,Y$ | equality of $4$-dimensional subspaces of $\mathbb R^n$ |, (conclusion) |
| an $n$-restriction | **none is stated and none is needed** |, |
| $P_V$, $V$ (converse only) | orthogonal projection onto the common image $V$; **neither symbol is defined in the block nor tabled in [conventions.md](../findings/conventions.md)** | yes, in the converse |

Two entries deserve their own line.

- **"all singular values $1/\sqrt2$" is literally false at every $n\ge5$**, where $X$ of rank $4$ has $n-4$ singular values equal to $0$. The rank clause standing beside it makes the intended reading (all *nonzero* singular values), unambiguous, so this is an imprecision, not a defect. Under the discrepancy protocol it is **withdrawn as a defect** at clause 3: the charitable reading is forced by the adjacent word "rank".
- **$s_1\ge s_2\ge\cdots$ is assumed and nowhere stated.** [conventions.md](../findings/conventions.md) writes "singular values in pairs $s_1,s_1,s_2,s_2,\dots$" without an ordering. Without it the identity is simply false, relabel $s=(0.1,0.6,\ldots)$ and $(s_1+s_2)^2$ names no maximum. Also **withdrawn as a defect** at clause 3, the ordering being the universal convention for singular values, but it is a notational debt.

## 2. The root-system identity, derived

**What has to be shown.** For $X\in\mathfrak{so}(n)$ with angles $s_1\ge s_2\ge\cdots\ge s_p\ge0$, $p=\lfloor n/2\rfloor$, that $\max_{\lVert Y\rVert=1}\lVert[X,Y]\rVert^2=(s_1+s_2)^2$.

**Step (i), $X$ may be taken in a Cartan subalgebra.** Every $X\in\mathfrak{so}(n)$ has a block normal form under $SO(n)$-conjugation: $\lfloor n/2\rfloor$ blocks $\begin{pmatrix}0&-s_i\\ s_i&0\end{pmatrix}$, plus one zero row and column at odd $n$. The pairing $\tfrac12\operatorname{tr}(X^{\mathsf T}Y)=-\tfrac12\operatorname{tr}(XY)$ is $\mathrm{Ad}$-invariant, so both $\lVert\cdot\rVert$ and the bracket are carried along and the reduction is without loss. **The block never says this**; it is the one unstated step of the identity, and it is standard.

**Step (ii), $\mathrm{ad}_X$ is skew-adjoint, hence normal.** Ad-invariance of the pairing is $\langle[X,Y],Z\rangle+\langle Y,[X,Z]\rangle=0$. So $\mathrm{ad}_X$ is a real skew operator on $\mathfrak{so}(n)$ and $\max_{\lVert Y\rVert=1}\lVert[X,Y]\rVert=\lVert\mathrm{ad}_X\rVert_{\rm op}$ is the largest modulus in its spectrum, the maximum attained. **So the identity is exact and not merely an upper bound** (the brief's question) and the maximum is attained on the real two-dimensional root space of a maximising root, which is a genuine element of $\mathfrak{so}(n)$: **the maximiser is admissible.**

**Step (iii), the spectrum.** With $X$ in the Cartan, the eigenvalues of $\mathrm{ad}_X$ on $\mathfrak{so}(n)\otimes\mathbb C$ are $\alpha(X)$ over the roots $\alpha$, together with $0$ on the Cartan itself (multiplicity $p$, an eigenvalue the block omits and which is harmless to a maximum of moduli).

- $n=2p$ even: the root system is $D_p$, roots $\pm e_i\pm e_j$ for $i<j$, giving exactly the family $i(\pm s_i\pm s_j)$, **and nothing else**.
- $n=2p+1$ odd: the root system is $B_p$, roots $\pm e_i\pm e_j$ and the short roots $\pm e_i$, giving the extra family $i(\pm s_i)$.

Dimension count confirms the split. At even $n$: $\lvert D_p\rvert+p=2p(p-1)+p=2p^2-p=\dim\mathfrak{so}(2p)$. At odd $n$: $\lvert B_p\rvert+p=\big(2p(p-1)+2p\big)+p=2p^2+p=\dim\mathfrak{so}(2p+1)$. **So the short-root family is present exactly at odd $n$**, which is the brief's question, answered.

**Step (iv), the maximum.** For $p\ge2$, $\max_{i<j}\lvert\pm s_i\pm s_j\rvert=s_1+s_2$, and the short roots contribute at most $s_1$. Since $s_2\ge0$, $s_1\le s_1+s_2$: **the short roots cannot beat $(s_1+s_2)^2$**, the brief's second question, answered. Hence $\lVert\mathrm{ad}_X\rVert_{\rm op}=s_1+s_2$ and the identity holds. $\square$

### 2a. The eigenvalue list as written, imprecise, immaterial

The block writes the two families together with no parity qualifier, so read literally it asserts $i(\pm s_i)$ at even $n$ too. **Located**: the first clause of the proof. **Exhibited**: at $n=6$ take $X$ with angles proportional to $(4,2,1)$; the pair family is $\{\pm 6,\pm 2,\pm 5,\pm 3,\pm 3,\pm 1\}$ times $i$, together with $0$, and $4i$ (the value the short-root family would supply), is **not** in it. **Argued the opposite**: "the roots of $\mathfrak{so}(n)$" with $n$ left as a family reads naturally as the union over the two parities, which is what the sentence means and which is true of the family. The candidate is therefore **withdrawn as a defect** at clause 3 and recorded as an imprecision. It changes nothing downstream, by step (iv).

### 2b. The edge of the range

- **$n=2$**: $\mathfrak{so}(2)$ is abelian, so $\mathrm{ad}_X=0$ and the maximum is $0$, while $(s_1+s_2)^2=1$ with the padding convention $s_2=0$. The identity is **false** here in isolation. It is out of scope for the lemma: $\dim\mathfrak{so}(2)=1$ admits no orthonormal *pair*, so the hypothesis is unsatisfiable and the biconditional is vacuous. **Withdrawn** at clause 3.
- **$n=3$**: $p=1$, roots $\pm e_1$ only, maximum $s_1=1$. With the padding convention $s_2=0$ the identity reads $1$ and is correct. The cap $2$ is unreachable, and correspondingly no rank-$4$ element exists in $\mathfrak{so}(3)$, so **both sides of the biconditional are empty at $n=3$** and it holds.
- **The smallest $n$ at which rank-$4$ orthonormal pairs exist, and at which the cap is attained, is $n=4$**, §6 exhibits the witness.
- **$n=5$**, the smallest odd case with content: the $n=4$ witness padded by a zero row and column satisfies every clause, so the short roots cause no trouble where the lemma has content.

## 3. Cauchy–Schwarz, and the rank

$(s_1+s_2)^2\le2(s_1^2+s_2^2)\le2\sum_{i}s_i^2=2$, the first step Cauchy–Schwarz on $(1,1)\cdot(s_1,s_2)$ and the second because the remaining $s_i^2$ are nonnegative. Equality in the first needs $s_1=s_2$; equality in the second needs $s_i=0$ for $i\ge3$. Together with $\sum_is_i^2=1$ this gives $s_1=s_2=1/\sqrt2$ and the rest zero. Each nonzero angle contributes a $2\times2$ block, so $\operatorname{rank}X=4$ with the four nonzero singular values all $1/\sqrt2$. **Correct**, and $\sum_is_i^2=1$ is exactly $\lVert X\rVert=1$ in this record's convention, per §0.

**This is where the low-rank trap is disposed of**, the brief's $\ker W\ne0$ item, here $X$ or $Y$ of low rank. Rank $2$ means $s_1=1$ and the rest zero, so $(s_1+s_2)^2=1<2$: no equality. Rank $2k$ with $k\ge3$ has some $s_i\ne0$ for $i\ge3$, so the second inequality is strict: no equality. **Rank $4$ is forced, and the generic-at-large-$n$ low-rank case is excluded rather than assumed away.**

## 4. The two-step Frobenius chain, and its three conclusions

**First, the chain is tight, which the block asserts and never checks.** By §3, $\lVert X\rVert_{\rm op}=s_1=1/\sqrt2$; by §0, $\lVert Y\rVert_F=\sqrt2\lVert Y\rVert=\sqrt2$ and $\lVert[X,Y]\rVert_F=\sqrt2\cdot\sqrt2=2$. So

$$\lVert[X,Y]\rVert_F=2,\qquad 2\lVert X\rVert_{\rm op}\lVert Y\rVert_F=2\cdot\tfrac1{\sqrt2}\cdot\sqrt2=2 .$$

**Equality holds exactly, so both inequalities are equalities simultaneously**, the brief's question, answered affirmatively and by construction rather than by hope.

### 4a. The norm mismatch does not bite

The block moves from $\lVert\cdot\rVert$ to $\lVert\cdot\rVert_F$ without saying so. **It is harmless, and here is why.** Replace $\lVert\cdot\rVert_F$ by $c\lVert\cdot\rVert_F$ for any $c>0$: the left side of the chain scales by $c$, $\lVert XY\rVert_F+\lVert YX\rVert_F$ scales by $c$, and $2\lVert X\rVert_{\rm op}\lVert Y\rVert_F$ scales by $c$ because only the $Y$ factor carries the norm. The chain is **homogeneous of degree one in the Frobenius-type norm**, so a reader taking $\lVert\cdot\rVert_F=\lVert\cdot\rVert$ gets $\sqrt2=2\cdot\tfrac1{\sqrt2}\cdot1=\sqrt2$ and reaches the same equality. The factor of two the brief warns about lands entirely on §3's $\sum_is_i^2=1$, where it is fixed by [conventions.md](../findings/conventions.md), and not here.

### 4b. The three conclusions, each derived separately

**(i) Both halves of the second inequality are individually tight.** $\lVert XY\rVert_F\le\lVert X\rVert_{\rm op}\lVert Y\rVert_F$ and $\lVert YX\rVert_F\le\lVert Y\rVert_F\lVert X\rVert_{\rm op}$ hold separately, so a sum equal to $2\lVert X\rVert_{\rm op}\lVert Y\rVert_F$ forces both to be equalities. (The block's parenthetical $\lVert XY\rVert_F=\lVert YX\rVert_F$ is in fact automatic for skew $X,Y$: $(XY)^{\mathsf T}=Y^{\mathsf T}X^{\mathsf T}=(-Y)(-X)=YX$. True, and carrying no content.)

**(ii) $\mathrm{im}\,Y\subseteq\mathrm{im}\,X$.** Writing $Y$ by columns $y_j$, $\lVert XY\rVert_F^2=\sum_j\lVert Xy_j\rVert^2\le s_1^2\sum_j\lVert y_j\rVert^2=\lVert X\rVert_{\rm op}^2\lVert Y\rVert_F^2$, with equality iff every $y_j$ lies in the top right-singular subspace of $X$, i.e. the $s_1^2$-eigenspace of $X^{\mathsf T}X$. **Here is the step where the block's own hedge earns its keep**: since the only nonzero singular values are $s_1=s_2=1/\sqrt2$, that eigenspace is exactly $(\ker X)^\perp$, which for skew $X$ is $\mathrm{im}\,X$. So every column of $Y$ lies in $\mathrm{im}\,X$, and the columns span $\mathrm{im}\,Y$. **Correct**, and note this is precisely the place a general $X$ with $\ker X\ne0$ would break the argument, the top singular subspace then being a proper subspace of the image; the block says "which is all of $\mathrm{im}\,X$ since the nonzero singular values coincide", and that clause is doing real work.

**(iii) $XY=-YX$.** Equality in the triangle step $\lVert XY-YX\rVert_F\le\lVert XY\rVert_F+\lVert{-}YX\rVert_F$ in the Frobenius inner-product space forces $XY$ and $-YX$ to be nonnegative multiples of one another. Both have norm $\lVert X\rVert_{\rm op}\lVert Y\rVert_F=1\ne0$, so the multiplier is $1$ and $XY=-YX$. **Correct.**

**All three conclusions the block draws from one equality do follow**, which was the brief's question.

## 5. The symmetrisation, what "and symmetrically" needs

**It needs $Y$'s rank-$4$, equal-singular-value structure, and it gets it.** Run §2 and §3 with the roles swapped: $\lVert[Y,X]\rVert^2=\lVert[X,Y]\rVert^2=2$ and $\lVert Y\rVert=1$, so $Y$ has angles $\sigma_1=\sigma_2=1/\sqrt2$ and the rest zero. Then $\lVert Y\rVert_{\rm op}=1/\sqrt2$, $\lVert X\rVert_F=\sqrt2$, the chain $\lVert[X,Y]\rVert_F\le\lVert YX\rVert_F+\lVert XY\rVert_F\le2\lVert Y\rVert_{\rm op}\lVert X\rVert_F$ is again tight at $2=2$, and §4b(ii) with the roles swapped gives $\mathrm{im}\,X\subseteq\mathrm{im}\,Y$. With (ii) this is $\mathrm{im}\,X=\mathrm{im}\,Y$. $\square$

**One placement flaw, and it is only that.** The *proof paragraph* derives rank $4$ for $X$ alone ("the rest zero, rank exactly $4$"); the $Y$ half lives in the **Statement**'s italic aside, "*The rank is derived for $X$ and follows for $Y$ by the symmetry of the bracket in its two arguments*". The symmetrisation step consumes that aside. **Located, exhibited, and then argued the opposite**: the aside is explicit, on the record, in the same block, and states exactly the right reason. **Withdrawn as a defect** at clause 3; recorded as a step that reads out of order.

### 5a. A hypothesis stated and never used, and it is redundant

**The forward proof never uses $\langle X,Y\rangle=0$.** §2 uses skewness and the Cartan reduction; §3 uses $\lVert X\rVert=1$; §4 uses $\lVert X\rVert_{\rm op}$, $\lVert Y\rVert_F$ and skewness. Orthogonality appears nowhere.

**And it is not merely unused, it is implied.** From $XY=-YX$, $\operatorname{tr}(XY)=\operatorname{tr}(-YX)=-\operatorname{tr}(XY)$, so $\operatorname{tr}(XY)=0$ and $\langle X,Y\rangle=-\tfrac12\operatorname{tr}(XY)=0$. Likewise rank $4$ with all nonzero singular values $1/\sqrt2$ gives $\lVert X\rVert^2=\sum_is_i^2=\tfrac12+\tfrac12=1$.

So **the right-hand side of the biconditional implies "orthonormal" outright**, and L31 is true under the weaker hypothesis $\lVert X\rVert=\lVert Y\rVert=1$. This is a strengthening rather than a fault, and it is free for the record's consumers, who all take $v_\alpha,v_\beta$ from an orthonormal eigenframe where orthogonality holds anyway.

## 6. The converse, every step

**Hypotheses actually available.** From the right-hand side: $X$ has rank $4$ with nonzero singular values all $1/\sqrt2$, so $X^{\mathsf T}X$ is the symmetric positive-semidefinite operator with eigenvalue $\tfrac12$ on $\mathrm{im}\,X=:V$ and $0$ on $V^\perp$, i.e. $X^{\mathsf T}X=\tfrac12P_V$. For skew $X$, $X^{\mathsf T}X=-X^2$, so $X^2=-P_V/2$. The same for $Y$, with the same $V$ because $\mathrm{im}\,X=\mathrm{im}\,Y$. **So the block's $X^2=Y^2=-P_V/2$ is derived, not assumed.**

**$[X,Y]=2XY$ from anticommuting.** $[X,Y]=XY-YX=XY-(-XY)=2XY$. **Correct**, and it is exactly the anticommuting clause that supplies it.

**The trace.** In the record's normalisation,

$$\lVert[X,Y]\rVert^2=\tfrac12\operatorname{tr}\big((2XY)^{\mathsf T}(2XY)\big)=2\operatorname{tr}\big(Y^{\mathsf T}X^{\mathsf T}XY\big)=2\operatorname{tr}\big(Y^{\mathsf T}\tfrac12P_VY\big)=\operatorname{tr}\big(Y^{\mathsf T}P_VY\big)=\operatorname{tr}(Y^{\mathsf T}Y),$$

the last step because $\mathrm{im}\,Y=V$ gives $P_VY=Y$. And $\operatorname{tr}(Y^{\mathsf T}Y)=2\lVert Y\rVert^2=2$. **So the block's display $\lVert[X,Y]\rVert^2=\operatorname{tr}(Y^{\mathsf T}Y)=2$ is correct, and correct only because the left side is half-trace and the right side full trace**, the two factors of $2$ that cancel are exactly the ones §0 fixes. Under plain Frobenius throughout, the chain would read $\lVert[X,Y]\rVert_F^2=2\operatorname{tr}(Y^{\mathsf T}Y)=4$, still consistent, but the *stated constant* $2$ requires the record's convention. **The brief's question (whether the trace evaluates to $2$ in the record's normalisation), is answered yes.**

### 6a. The converse is not checked at one object, but a witness is owed and I supply it

The converse above is a derivation valid for every admissible $(X,Y)$, so it does not fall to the "biconditional checked at one object" trap. **It does leave the biconditional potentially vacuous**, since the block exhibits nothing. Here is a closed-form attaining pair at the smallest admissible dimension, in the record's own $\varphi_{ab}=E_{ab}-E_{ba}$ basis, all arithmetic by hand:

$$X=\tfrac1{\sqrt2}(\varphi_{12}+\varphi_{34}),\qquad Y=\tfrac1{\sqrt2}(\varphi_{13}-\varphi_{24})\ \in\ \mathfrak{so}(4).$$

- $\lVert X\rVert^2=\tfrac12(1+1)=1$ and $\lVert Y\rVert^2=1$, since $\{\varphi_{ab}\}_{a<b}$ is orthonormal in this pairing; $\langle X,Y\rangle=0$ on disjoint basis elements. **Orthonormal.**
- $\varphi_{12}^2=-(E_{11}+E_{22})$, $\varphi_{34}^2=-(E_{33}+E_{44})$, $\varphi_{12}\varphi_{34}=\varphi_{34}\varphi_{12}=0$, so $X^2=-\tfrac12I_4$; likewise $Y^2=-\tfrac12I_4$. **Rank $4$, all singular values $1/\sqrt2$, $\mathrm{im}\,X=\mathrm{im}\,Y=\mathbb R^4$.**
- $\varphi_{12}\varphi_{13}=-E_{23}$, $\varphi_{12}\varphi_{24}=E_{14}$, $\varphi_{34}\varphi_{13}=E_{41}$, $\varphi_{34}\varphi_{24}=-E_{32}$, whence $XY=\tfrac12(-E_{23}+E_{32}-E_{14}+E_{41})=-\tfrac12(\varphi_{23}+\varphi_{14})$.
- With the bracket relation $[\varphi_{ab},\varphi_{cd}]=\delta_{bc}\varphi_{ad}-\delta_{ac}\varphi_{bd}-\delta_{bd}\varphi_{ac}+\delta_{ad}\varphi_{bc}$: $[\varphi_{12},\varphi_{13}]=-\varphi_{23}$, $[\varphi_{12},\varphi_{24}]=\varphi_{14}$, $[\varphi_{34},\varphi_{13}]=-\varphi_{14}$, $[\varphi_{34},\varphi_{24}]=\varphi_{23}$, so $[X,Y]=\tfrac12(-\varphi_{23}-\varphi_{14}-\varphi_{14}-\varphi_{23})=-(\varphi_{23}+\varphi_{14})$.
- Hence $[X,Y]=2XY$, so $XY=-YX$; and $\lVert[X,Y]\rVert^2=1+1=2$. **Every clause of the biconditional holds, in both directions, at this pair.**

Padding by zero rows and columns carries it to every $n\ge4$, so **$n=5$ and every odd $n$ carry content too**. The record already holds this family independently: [stratum-two-negative.md](../findings/stratum-two-negative.md) line 35 records that at $r=4$ the negative eigenvectors are "an orthonormal pair in $\Lambda^+\cong\mathfrak{su}(2)$, and **every** orthonormal pair there brackets to norm-squared $2$", which is the same object. **The biconditional is not vacuous.**

## 7. The correction the block records

**The old step.** From $\lVert[X,Y]\rVert^2\le4s_1^2$ and $\lVert[X,Y]\rVert^2=2$ one gets $s_1^2\ge\tfrac12$, and the refuted inference was that this forces rank $4$.

**The bound itself is true**: $\lVert\mathrm{ad}_X\rVert_{\rm op}=s_1+s_2\le2s_1$, so $\lVert[X,Y]\rVert^2\le4s_1^2$. It is simply not sharp.

**The counterexample checks.** $s^2=(0.5,0.3,0.2)$ has $\sum_is_i^2=1$, so it is an admissible unit $X$ at any $n\ge6$; three nonzero angles give rank $6$; and $s_1^2=0.5\ge\tfrac12$. So the hypothesis of the old inference is met at rank $6$ and its conclusion fails. **The step is invalid, exactly as the block says**, and the block's wording is careful: it says the *step* is invalid, not that some rank-$6$ pair attains the cap, which by L31 none does.

**The replacement genuinely avoids the flaw.** At that same spectrum the root-system identity gives, exactly,

$$(s_1+s_2)^2=\tfrac12+\tfrac3{10}+2\sqrt{\tfrac12\cdot\tfrac3{10}}=\tfrac45+2\sqrt{0.15}<\tfrac45+2\cdot\tfrac25=\tfrac85<2,$$

using $0.15<0.16$. So the sharp identity excludes the very configuration that defeated the old argument, and it does so at every rank $\ge6$ by §3's equality analysis rather than at one spectrum. **The replacement is a repair, not a restatement.**

## 8. The clause L31 was reassigned, "equality forces the support to have $r=4$"

The three lines are at [stratum-two-negative.md](../findings/stratum-two-negative.md) line 82: *equality forces $T_{1,N-1,N}=2$, hence $\lVert[v_{N-1},v_N]\rVert^2=2$, hence $\operatorname{im}v_2=\operatorname{im}v_3$ of dimension $4$, hence $r=4$ through Ricci-flatness.* **All four steps check.**

1. **$T_{1,N-1,N}=2$.** [Lemma L29](../findings/stratum-two-negative.md)'s proof reduces $\langle W,W^\#\rangle$ to the single surviving block $3T_{1,N-1,N}\lambda_1ab$ and bounds it by $6\lambda_1ab$. Equality in $\theta=\sqrt{3/2}$ forces equality at every step, and $\lambda_1ab\ne0$ since exactly one positive and two negative eigenvalues means $\lambda_1,a,b>0$. So $T_{1,N-1,N}=2$.
2. **$\lVert[v_{N-1},v_N]\rVert^2=2$.** $T$ is totally symmetric, [conventions.md](../findings/conventions.md): "*Structure constants $c_{abc}=\langle[v_a,v_b],v_c\rangle$ are **totally antisymmetric** … so $T_{abc}=c_{abc}^2$ is totally symmetric*", so the cap may be read off **any** of the three pairs, and the chain reads it off $(N-1,N)$: $2=T_{N-1,N,1}\le\sum_\gamma T_{N-1,N,\gamma}=\lVert[v_{N-1},v_N]\rVert^2\le2$. Both inequalities collapse. **The pair the cap is applied to is not the pair the block's $\lambda_1$-factor suggests, and total symmetry is what licenses the switch**, it is stated in [conventions.md](../findings/conventions.md) and correctly used.
3. **L31 applies.** $v_{N-1},v_N$ are members of an orthonormal eigenframe of $W$ on $\Lambda^2\mathbb R^n$, identified isometrically with $\mathfrak{so}(n)$ by [conventions.md](../findings/conventions.md)'s bivector bullet, so they are an orthonormal pair in $\mathfrak{so}(n)$ and the lemma's hypothesis is met exactly. L31 returns $\mathrm{im}\,v_{N-1}=\mathrm{im}\,v_N$ of dimension $4$.
4. **$r=4$.** Ricci-flatness on this stratum reads $\lambda_1v_1v_1^{\mathsf T}=a\,v_{N-1}v_{N-1}^{\mathsf T}+b\,v_Nv_N^{\mathsf T}$ with all three terms positive semidefinite. The image of a sum of positive-semidefinite operators is the sum of their images, so $\mathrm{im}\,v_1=\mathrm{im}\,v_{N-1}+\mathrm{im}\,v_N$, which by step 3 is a single $4$-dimensional space. The support is $\mathrm{im}\,v_1$ by the same file's line 35, so $r=4$. $\square$

**So L31 does deliver the clause [results.md](../results.md) line 451 credits it with, in the three lines claimed.** The reassignment away from [L72](../findings/stratum-two-negative.md) is sound on this side too: L72 quantifies over critical points, and nothing in the chain above needs criticality, it needs equality in L29's bound and Ricci-flatness.

### 8a. A symbol collision inside the three-line chain

**Located**: the one sentence at [stratum-two-negative.md](../findings/stratum-two-negative.md) line 82–83 writes the pair as $v_{N-1},v_N$ and then, four words later, as $v_2,v_3$.

**Exhibited**: $W$ here has rank $3$ in $\mathcal W_n$, where $N=\binom n2\ge6$ at every $n\ge4$. In the descending eigenvalue order the sentence's own $\lambda_1>0>-a\ge-b$ presumes, the spectrum is $\lambda_1>0=\lambda_2=\cdots=\lambda_{N-2}>-a\ge-b$, so $v_2$ and $v_3$ are **kernel** eigenvectors. L31 says nothing about them, and "$\mathrm{im}\,v_2=\mathrm{im}\,v_3$ of dimension $4$" is not implied for them, indeed $v_2,v_3$ may be chosen as any orthonormal pair of the $(N-3)$-dimensional kernel, including $\varphi_{12}$ and $\varphi_{13}$, whose images are $2$-dimensional and unequal.

**Argued the opposite**: line 35 of the same file writes Ricci-flatness as "$\lambda_1v_1v_1^{\mathsf T}=a\,v_2v_2^{\mathsf T}+b\,v_3v_3^{\mathsf T}$", labelling the three *nonzero* eigenvectors $1,2,3$. Under that support-labelling $v_2,v_3$ **are** the two negative eigenvectors and the sentence is correct.

**All three clauses clear.** This is therefore recorded as a live symbol collision of the kind [conventions.md](../findings/conventions.md) already tables for $q$, $r$, $N_v$, $\mathring R$ and $x$ **inside this same file**, two eigenvector labellings, support order and descending order, used within one sentence. It does not break the derivation; it is one label away from doing so.

### 8b. A broken cross-reference, the one hard defect

**Located**: [results.md](../results.md) line 451 links the clause to `[Lemma L31](../findings/fence-posts.md#post-f31-the-sharp-target-is-not-freely-described-and-n-cannot-be-smuggled-in-as-a-trace)`.

**Exhibited**: no heading on the record produces the anchor `#lemma-l31--the-pair-cap`. The two L31 headings are [results.md](../results.md) line 461, "Lemma L31, the bracket cap, characterised", yielding `#lemma-l31--the-bracket-cap-characterised`, and [stratum-two-negative.md](../findings/stratum-two-negative.md) line 417, yielding `#lemma-l31--the-bracket-cap-characterised--canonical-statement-and-proof`. The five in-file citations at [stratum-two-negative.md](../findings/stratum-two-negative.md) lines 82, 167, 208, 269 and 477 all use the second, correct form. **The dead anchor is unique to results.md line 451**, the very sentence that performed the reassignment.

**Argued the opposite**: there is no charitable reading, the link simply does not resolve, and "the pair cap" is [conventions.md](../findings/conventions.md)'s name for the *statement*, not a heading. **Confirmed.** Editorial severity, but it sits in the sentence a reader follows to check the reassignment.

## 9. The remaining traps, answered by name

- **$\ker W\ne0$, here $X$ or $Y$ of low rank, the generic case at large $n$.** Answered in §3 (low rank cannot attain the cap) and §4b(ii) (the top singular subspace is all of $\mathrm{im}\,X$ *because* equality already collapsed the singular values, which is the block's own hedge). **The trap is anticipated and closed.**
- **The boundary of every stated range, the smallest admissible dimension, odd $n$.** §2b and §6a. Smallest admissible dimension is $4$; $n=2,3$ vacuous; $n=5$ and every odd $n\ge5$ carry the padded witness; the short-root family is an odd-$n$ phenomenon and is dominated. **No $n$-restriction is stated and none is needed.**
- **A claim proven on a subfamily and used in general.** The only sub-case reduction is $X$ into a Cartan subalgebra, which is without loss by $\mathrm{Ad}$-invariance (§2 step (i)), but **the block never states it**, so the reduction is a silent step rather than a false one. Nothing else is proved on a subfamily.
- **A hypothesis stated but never used.** Found: $\langle X,Y\rangle=0$, §5a, and it is provably redundant, so the lemma is stronger than stated.
- **A step using a hypothesis never stated.** Found, two: the ordering $s_1\ge s_2\ge\cdots$ (§1), and the Cartan reduction (§2). Both standard, neither written.
- **A universal claim with no witness, and a biconditional whose converse is checked at one object.** The converse is a general derivation, not a spot-check, so the second half does not apply. The first half does: **the block exhibits no attaining pair.** §6a supplies one in closed form and finds the record's own witness family thirty-eight lines earlier in the same file.
- **An imported theorem whose hypotheses were never checked against the object.** The only import is the root system of $\mathfrak{so}(n)$, and its hypothesis, $X$ in a Cartan subalgebra, with an $\mathrm{Ad}$-invariant pairing so $\mathrm{ad}_X$ is normal, is met (§2, steps (i)–(ii)). **The unital-algebra failure mode the brief warns of has no analogue here**: nothing is cited that presumes a unit, and $\mathfrak{so}(n)$ enters as a Lie algebra with an invariant form, which is exactly what the root-space decomposition needs.
- **Symbol collisions.** Three found. $P_V$ against [conventions.md](../findings/conventions.md)'s cubic form $P(W)$ and against $\Pi$, the record's own letter for an orthogonal projection, and $P_V$ and $V$ are defined nowhere, in the block or in the table. $v_2,v_3$ against $v_{N-1},v_N$ (§8a). $X,Y$ here are elements of $\mathfrak{so}(n)$, where [conventions.md](../findings/conventions.md)'s trilinear form $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ takes the same letters for elements of $\mathcal W_n$; and $s$ is the angle vector here against $S(W)$, $S_{XYZ}$ elsewhere. **The two norms** the brief singles out are handled in §0 and §4a: the mismatch is real, it is unstated, and it is neutralised by homogeneity.
- **The gap between what is proven and what is used.** Five consumers checked and **all five stay inside the lemma**: [conventions.md](../findings/conventions.md) line 109's pair cap $\le2$ is the forward inequality alone; [stratum-two-negative.md](../findings/stratum-two-negative.md) line 82's three-line chain is §8; line 208's "the sum has rank exactly $4$" follows since $\mathrm{im}(X^{\mathsf T}X+Y^{\mathsf T}Y)=\mathrm{im}\,X+\mathrm{im}\,Y=V$ of dimension $4$; line 269's "the common kernel would be $4$-dimensional at $n=8$" follows since equal images and skewness give $\ker X=\ker Y=V^\perp$; and the assembly table's $\delta=0$ row, "$\ker X=\ker Y$ of dimension $n-4$", is the same identity. **Nothing downstream consumes more than is proved.**
- **The landscape entry overstates by one clause.** [results.md](../results.md) line 148 says "the root system gives $\max_Y\lVert[X,Y]\rVert^2=(s_1+s_2)^2$, and Cauchy–Schwarz forces the rest." Cauchy–Schwarz forces the rank and the singular values; the image and anticommuting clauses come from the Frobenius chain, which the entry does not mention. **Withdrawn as a defect** (a landscape entry is a summary and the canonical block carries the argument) but recorded, since it is the sentence a reader meets first.

## 10. What would falsify it, and what I did to look for it

**In the forward direction**, a falsifier is an orthonormal pair $X,Y\in\mathfrak{so}(n)$ with $\lVert[X,Y]\rVert^2=2$ failing any one of the three conclusions: a pair at rank $\ne4$, a pair with $\mathrm{im}\,X\ne\mathrm{im}\,Y$, or a commuting-side pair with $XY\ne-YX$. **In the converse direction**, a falsifier is a pair satisfying all three clauses with $\lVert[X,Y]\rVert^2\ne2$.

**What I did.** For the forward direction I attacked the three places the argument could leak. (i) The rank clause rests on $(s_1+s_2)^2\le2$; I checked the equality case of that Cauchy–Schwarz directly and at the block's own refuted spectrum $s^2=(0.5,0.3,0.2)$, where the identity returns $\tfrac45+2\sqrt{0.15}<\tfrac85$ exactly and no rank-$6$ falsifier survives. (ii) The image clause rests on the top singular subspace being all of $\mathrm{im}\,X$; I checked that this is false for a general $X$ and true here only because §3 has already collapsed the singular values, the low-rank falsifier the brief names is therefore excluded before that step rather than assumed away. (iii) The anticommuting clause rests on triangle-equality in an inner-product space, where the equality case is exact and admits no slack. **For the converse I did not spot-check**: §6 derives it for every admissible pair from $X^{\mathsf T}X=\tfrac12P_V$, so a converse falsifier would have to violate an identity, not an estimate.

**For non-vacuity (the failure mode where a biconditional is true because both sides are empty), I built §6a's pair by hand at $n=4$**, multiplied out $XY$, $X^2$, $Y^2$ and $[X,Y]$ in the $\varphi_{ab}$ basis, and confirmed all five clauses and both directions on it. **No falsifier was found in either direction**, and the search was analytic throughout: no script, no Sage, no numeric evaluation.

## Verdict

**PROVEN.**

Both directions close. The equality case (which is the whole content), is complete: the root-system identity is exact, the Cauchy–Schwarz equality case forces rank $4$ and the singular values, the Frobenius chain is *tight* rather than merely valid and its three conclusions each follow, the symmetrisation delivers the reverse inclusion, and the converse is an identity in the record's normalisation. The reassigned clause "equality forces the support to have $r=4$" is delivered in the three lines claimed.

**What is owed, none of it load-bearing:**

| item | where | severity |
| --- | --- | --- |
| Dead anchor `#lemma-l31--the-pair-cap` | [results.md](../results.md) line 451 | editorial, but in the reassignment sentence itself |
| $v_2,v_3$ against $v_{N-1},v_N$ in one sentence | [stratum-two-negative.md](../findings/stratum-two-negative.md) lines 82–83 | symbol collision; one label from a break |
| Short-root family asserted without the odd-$n$ qualifier | the proof's first clause | imprecision |
| "all singular values $1/\sqrt2$" at $n\ge5$ | the Statement | imprecision; reads "all nonzero" |
| $P_V$ and $V$ undefined in block and untabled | the converse | notational debt |
| $s_1\ge s_2\ge\cdots$ and the Cartan reduction both unstated | the proof | notational debt |
| No attaining pair on the block | the whole block | non-vacuity witnessed elsewhere and supplied in §6a |
| Landscape entry says Cauchy–Schwarz "forces the rest" | [results.md](../results.md) line 148 | overstatement in a summary |
