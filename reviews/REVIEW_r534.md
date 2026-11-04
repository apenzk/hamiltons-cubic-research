# REVIEW r534, Lemma L126

**Target.** Lemma L126, "the four-set 1/2-threshold, met in the two-factor family only at $S^3\times S^3$", `findings/second-order.md`, `#### Lemma L126`.

**Reviewer.** r534, independent adversarial audit, cold. Analysis-only footing inherited: no searches, sweeps, censuses or falsifier hunts; screening only, and labelled as screening.

**Phase plan.**

1. Fix conventions against the record's anchors.
2. Read L126 verbatim; read inputs L24, L27, L120, L121.
3. Derive $DF(M)=\theta(2L_e-\mathrm{Id})$; check $\ker DF(M)$ vs the $\tfrac12$-eigenspace, incl. $\mathbb R M$ and the tangent space.
4. Derive both Diophantine equivalences; check boundary cases.
5. Scope: two-factor family, $p,q\ge3$, and the L27 exclusion of $(3,3)$.
6. Withdrawn-reading dependency check.
7. The 9 citations; cross-file restatements.
8. Verdict.

VERDICT: CONFIRMED, see the closing section.

## Findings

### F1, $DF(M)=\theta(2L_e-\mathrm{Id})$ is correct, and the "on the tangent space" qualifier is load-bearing and present

Derived cold. $Q$ is quadratic and $P(W)=\langle W,Q(W)\rangle$ is cubic ([conventions.md](../findings/conventions.md)), so with $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$ and $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ fully symmetric ([Lemma L24](../findings/second-order.md)):

$$DF(M)h \;=\; 2M\circ h \;-\; P(M)h \;-\; DP(M)[h]\,M \;=\; 2M\circ h-\theta h-3\theta\langle h,M\rangle M .$$

Using $DP(M)[h]=3\langle h,Q(M)\rangle=3\theta\langle h,M\rangle$ and $M\circ h=\theta L_eh$. The third term vanishes **exactly** on $M^\perp$, which is the tangent space to $\{\lVert W\rVert=1\}$ at $M$, and a critical point is unit-norm by the record's own definition of the term, so $P(M)=\theta$ needs no extra hypothesis. The block writes *"On the tangent space the criticality map ... has $DF(M)=\theta(2L_e-\mathrm{Id})$"*. **The qualifier is there and it is exactly the one the formula needs.** No omission of the kind the [Lemma L120](../findings/second-order.md) audit found.

Two further checks the block does not make and does not need:

- $M^\perp$ is $DF(M)$-invariant: $\langle M\circ h,M\rangle=\langle h,M\circ M\rangle=\theta\langle h,M\rangle=0$ for $h\perp M$. So the restriction is a genuine operator, not a compression.
- $\mathbb RM$ is **not** in the kernel: $DF(M)M=\theta(2-1)M-3\theta M=-2\theta M\ne0$ since $\theta>0$.

### F2, the kernel identification is right, and is in fact stronger than stated

The block says $\ker DF(M)$ *"is the $\tfrac12$-eigenspace of $L_e$"*. On the full space, splitting $h=cM+h'$ with $h'\perp M$,
$$DF(M)h=-2c\theta M+\theta(2L_e-\mathrm{Id})h',$$
and $(2L_e-\mathrm{Id})h'\in M^\perp$, so the two components vanish independently: $c=0$ and $L_eh'=\tfrac12h'$. The $\tfrac12$-eigenspace is automatically inside $M^\perp$ because $L_e$ is self-adjoint with $L_eM=M$. **So the identification holds on the ambient space too, and no cut of $\langle M\rangle$ is owed here**, unlike [Lemma L120](../findings/second-order.md), where the cut is owed because $e\in\mathcal D_n$ sits inside a *block* and $L_ee=e$ would make the block criterion vacuous. The two situations are genuinely different and the block is right not to repeat L120's caveat.

### F3, the L121 link, $\Sigma_{ijkl}=\theta^2$, is exact

[Lemma L121](../findings/second-order.md) gives the four-set block of $L_M$ as $\tfrac12G$ with spectrum $\pm\tfrac12\sqrt\Sigma$ on the Bianchi subspace $\mathbf1^\perp$. Since $L_e=L_M/\theta$, the block's $L_e$-spectrum is $\pm\dfrac{\sqrt\Sigma}{2\theta}$. With $\theta>0$ the negative root is $\le0<\tfrac12$, so the block meets $\tfrac12$ iff $\sqrt\Sigma=\theta$ iff $\Sigma=\theta^2$. **Correct, and the $L_M$-to-$L_e$ unit conversion (which L121 itself flags as a live trap in its closing paragraph), is done right here.**

### F4, orbit-freeness of the four-set blocks: confirmed by direct computation

The block asserts *"the orbit tangent for the $(j,k)$ generator lies in the $\{j,k\}$ pair block, so the orbit's tangent space lies in the span of the pair blocks."* Derived independently: $\rho(\varphi_{jk})$ on $\Lambda^2$ joins $\varphi_{ji}\leftrightarrow\varphi_{ki}$ for $i\notin\{j,k\}$ and annihilates every other basis bivector. For pair-diagonal $M$, $([\rho(X),M])_{\alpha\beta}=\rho(X)_{\alpha\beta}(m_\beta-m_\alpha)$, so the commutator is supported on $\{(ji),(ki)\}_i$, which is precisely [Lemma L122](../findings/second-order.md)'s basis $f_i=e_{ji}\odot e_{ki}$ of $V_{jk}$. Linearity over $\mathfrak{so}(n)$ puts $T_M\mathcal O\subseteq\bigoplus_{\{j,k\}}V_{jk}$. **Confirmed.** It agrees with [Lemma L128](../findings/second-order.md)(i), which proves the same thing and cites this block as one of its three prior statements.

### F5, $\mu_{p,q}=\dfrac{n-2}{2(p-1)(q-1)}$: derived from scratch, confirmed

Neither L126 nor [Lemma L121](../findings/second-order.md) proves this closed form in place; both quote it. I derived it cold. Normalise $S^p\times S^q$ to $\mathrm{Ric}=(n-1)g$. The Weyl sectional matrix is
$$w_1=\frac q{p-1}\ \text{(within }S^p),\qquad w_2=\frac p{q-1}\ \text{(within }S^q),\qquad w_{12}=-1 ,$$
whose row sums vanish, confirming Ricci-flatness. Calibrating $\#$ against the record's two anchors ($\mathrm{Id}^\#=(n-2)\mathrm{Id}$ and $\mathop{\mathrm{tr}}W^\#=-1$ at unit norm), fixes $(W^\#)_{(ab)}=\sum_{c\ne a,b}w_{ac}w_{bc}=(K^2)_{ab}$ on a pair-diagonal operator. Then entrywise

$$Q(W)_{(ab)}=w_{ab}^2+(K^2)_{ab}=(n-1)\,w_{ab}\quad\text{for every }a\ne b ,$$

checked separately on the within-$S^p$, within-$S^q$ and cross entries. Hence $Q(W)=(n-1)W$ and, since $Q(W)=\theta\lVert W\rVert W$ for the unnormalised representative, $\theta\lVert W\rVert=n-1$.

For a $4$-subset the three opposite-pair sums are $A=w_1+w_2$, $B=C=-2$ on a $(2,2)$-split, giving $\Sigma=(A+2)^2$ and
$$\sqrt\Sigma=w_1+w_2+2=\frac{(n-1)(n-2)}{(p-1)(q-1)} .$$
Therefore
$$\mu_{p,q}=\frac{\sqrt\Sigma}{2\theta\lVert W\rVert}=\frac{(n-1)(n-2)}{2(n-1)(p-1)(q-1)}=\frac{n-2}{2(p-1)(q-1)} . \qquad\checkmark$$

The other splits give $A=B=C$ ($(4,0)$: all equal $2w_1$; $(3,1)$: all equal $w_1-1$), hence $\Sigma=0$. **So "the nonzero four-set blocks are the $(2,2)$-splits" is confirmed, not merely quoted.** Their count is $\binom p2\binom q2$, which is $9$ at $(3,3)$, matching [Lemma L121](../findings/second-order.md)'s nine.

*Screen (permitted; seconds, on matrices I built for the purpose; reported as a screen and not as evidence).* The above closed forms reproduce at $(p,q)=(2,2),(2,4),(2,6),(3,3),(3,5),(4,4),(5,7),(6,6)$: row sums $0$, $Q(W)=(n-1)W$ with a single eigenvalue, $\Sigma\ne0$ only on $(2,2)$-splits, and $\mu$ matching to nine places.

### F6, the Diophantine step: both equivalences confirmed, and the boundary cases are handled

Put $u=p-1$, $v=q-1$. Then $n-2=u+v$ and
$$\mu_{p,q}=\frac{u+v}{2uv}=\tfrac12\Big(\tfrac1u+\tfrac1v\Big),$$
so **the first equivalence is a rearrangement**, requiring only $u,v\ne0$. For the second, $\tfrac1u+\tfrac1v=1\iff u+v=uv\iff(u-1)(v-1)=1$, whose only solution over the positive integers is $u=v=2$, i.e. $(p,q)=(3,3)$. **Correct.**

Two remarks on how the block argues it:

- The stated reason (*"since $u=1$ forces $\tfrac1v=0$ and $u=v=2$ is the only integer solution"*), disposes of $u=1$ but then offers the conclusion as its own justification. The factorisation $(u-1)(v-1)=1$ is the one-line proof and is absent. **Presentational thinness, not an error**; and the identical content *is* proved elsewhere in the record, at [nondegeneracy.md:485](../findings/nondegeneracy.md) as $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$, which is literally the same equation, since $(p-2)(q-2)=(u-1)(v-1)$.
- **Boundary cases.** $p=2$ is *not* silently excluded: the block's second callout uses it explicitly, $\mu_{2,q}=\frac q{2(q-1)}>\tfrac12$, which my formula reproduces and which is consistent with $(p-2)(q-2)=0<1$. $p=1$ is excluded by the expression itself ($u=0$) and, geometrically, because $S^1$ is Ricci-flat so no Einstein two-factor product has a circle factor. **The one gap worth naming is that the block never states its index range.** "The two-factor family" is nowhere defined in the block; the derivation is valid for $p,q\ge2$ and it should say so. Minor.

### F7, scope against [Lemma L27](../findings/nondegeneracy.md): a coherent division of labour, and the brief's suspicion of a clash is unfounded

[Lemma L27](../findings/nondegeneracy.md) is stated at $p,q\ge3$, $(p,q)\ne(3,3)$, and its own text says why: *"At $(3,3)$, $\mu=\tfrac12$ exactly and $\dim E(\tfrac12)=18$ against orbit dimension $9$."* **L126's content is exactly the boundary L27 declines**, and it also reaches $p=2$, which L27's representation-theoretic route cannot. So the two are complementary, not competing. Recording that as a positive finding, as the brief invites.

The two routes also cross-check on the identification of the extra nine directions at $(3,3)$: L27 puts them on the summand $\Lambda^2(\mathbb R^3)\otimes\Lambda^2(\mathbb R^3)$, dimension $3\times3=9$; L126/L121/L127 put them on the nine $(2,2)$-split four-set blocks, $\binom32^2=9$. Same count, two independent decompositions.

**The $86$-against-$84$ over-count is correct.** I checked it by hand rather than inheriting it. Summing L27's ten summands at $(p,q)=(2,4)$: $1+\dim\mathrm{Weyl}_2+\dim\mathrm{Weyl}_4+pq+2+9+18+6+0+32$. The polynomial $\frac{m(m-3)(m+1)(m+2)}{12}$ returns $-2$ at $m=2$ while $\dim\mathrm{Weyl}_2=0$; using the true value gives $86$, against $\dim\mathcal W_6=\frac{6\cdot3\cdot7\cdot8}{12}=84$. **The over-count is exactly the $2$ by which the dimension polynomial undershoots at $m=2$**, a sharper statement of the defect than the record gives, and it confirms the record's number.

### F8, the withdrawn branch reading: nothing in the block still leans on it

Checked clause by clause. The main bold paragraph asserts only that $\ker DF(M)=E_{1/2}(L_e)$ and that four-set blocks are orbit-free; **neither is a branch claim**. The first callout states the disclaimer positively (*"$\ker DF(M)\ne0$ eliminates one obstruction and establishes nothing positive"*) and the second callout's payload is the *exclusion* $\mu_{2,q}>\tfrac12\Rightarrow$ no local maximum, which runs through [Lemma L24](../findings/second-order.md) alone and is untouched by the withdrawal. **No residue.**

The one live dependence outside the block is *"At $S^3\times S^3$ no branch emanates, by [nondegeneracy.md](../findings/nondegeneracy.md)'s third-order obstruction $\Psi_1=-0.5929271$, constant on the zero cone."* The cited object exists ([nondegeneracy.md:411](../findings/nondegeneracy.md), [:572](../findings/nondegeneracy.md)). It is a **numerical** input carrying a positive claim, and I did not verify it, verifying it would need a computation, and under the analysis-only footing I stop and name it rather than run it. **What a run would decide**: whether $\Psi_1$ is nonzero and constant on the zero cone at $S^3\times S^3$; if nonzero, the no-branch conclusion stands as stated; if zero anywhere on the cone, the sentence loses its warrant while nothing else in L126 moves.

### F9, the citations: what each one takes

Nine citation sites, all consistent with what the block proves.

| site | what it takes | sound? |
| --- | --- | --- |
| [second-order.md:734](../findings/second-order.md), [Lemma L127](../findings/second-order.md)'s block table | the Diophantine conclusion, as the "reaches $\tfrac12$?" entry for the four-set family | yes, with the wording caveat in F10 |
| [second-order.md:773](../findings/second-order.md), [Lemma L128](../findings/second-order.md) proof of (i) | orbit-freeness, as a prior statement of (i)'s negative half | yes, F4 |
| [second-order.md:781](../findings/second-order.md), L128 "assembly and new" | the same, as an attribution | yes |
| [second-order.md:787](../findings/second-order.md), [Corollary L128.1](../findings/second-order.md), first use | the $86$-vs-$84$ over-count box | yes, F7 |
| [second-order.md:787](../findings/second-order.md), L128.1, second use | the threshold **and** the Diophantine conclusion: four-set blocks meet $\tfrac12$ iff $\Sigma=\theta^2$ iff $\tfrac1{p-1}+\tfrac1{q-1}=1$, hence never at $n\ge12$ | yes; L128.1 assumes $p,q\ge3$, inside L126's valid range |
| [second-order.md:908](../findings/second-order.md), [Lemma L133](../findings/second-order.md) consistency check | the $(3,3)$ coincidence: $\mu=\tfrac12$ at $n=6$, nine of the eighteen in four-set blocks | yes |
| [second-order.md:970](../findings/second-order.md), post F50 | a **strengthening**: $\Sigma=\tfrac32(A^2+B^2+C^2)-\tfrac12\sigma^2$ "reproves L126 in three lines" | the identity is real, I verified it: $\sigma^2=\sum A^2+2\sum AB$ gives it immediately |
| [ATTEMPTS.md:3409](../ATTEMPTS.md) | the same strengthening claim | as above |
| [LEDGER.md:170](../findings/LEDGER.md) | the Gate 2 landing and the withdrawal of the branch reading | matches the block's own italic header |

**No citation takes the withdrawn branch reading.** The two that come closest (L128's box and L127's withdrawn clause), both cite the $(3,3)$ degeneracy in the *negative* direction ("(ii) fails and (iii) says nothing"), which is what L126 actually supports.

### F10, one wording hazard, already guarded elsewhere, worth naming

[Lemma L127](../findings/second-order.md)'s table column reads *"reaches $\tfrac12$?"* with the four-set answer *"only at $(3,3)$"*. Read as "attains the value $\tfrac12$" this is right and is the reading [Lemma L128](../findings/second-order.md)(ii) needs. Read as "$\ge\tfrac12$" it is **false at $p=2$**, where $\mu_{2,4}=\tfrac23$ and $\mu_{2,6}=\tfrac35$ sit above the threshold. The same hazard sits in L126's own heading, *"met in the two-factor family only at $S^3\times S^3$"*.

**The record already guards this in the right place**, and forcefully: L128's box says *"THE INEQUALITIES IN (ii) ARE EXCLUSIONS OF $\tfrac12$, NOT STRICT BOUNDS, AND THE DIFFERENCE HAS A WITNESS ON THE RECORD"*, naming $S^2\times S^4$ at $\mu_{2,4}=\tfrac23$. And L126's own second callout states $\mu_{2,q}>\tfrac12$ explicitly. So this is an ambiguity a reader resolves within the block, not a defect. Recording it because a citation two files away could take the loose reading.

### F11, no cross-file contradiction; the one sentence that looks like one is scoped

Swept `findings/` for restatements of the threshold. Four forms appear and **all four are the same equation**:

| location | form |
| --- | --- |
| [second-order.md:717](../findings/second-order.md) (L126) | $\tfrac1{p-1}+\tfrac1{q-1}=1$ |
| [nondegeneracy.md:88](../findings/nondegeneracy.md) ([Lemma L26](../findings/nondegeneracy.md)) | $\mu\ge\tfrac12\iff(p-2)(q-2)\le1$ |
| [nondegeneracy.md:485](../findings/nondegeneracy.md) ([Lemma L27](../findings/nondegeneracy.md)) | $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$ |
| [nondegeneracy.md:694](../findings/nondegeneracy.md) | $\mu\ge\tfrac12\iff(p-1)+(q-1)\ge(p-1)(q-1)$ |

Dividing the last by $(p-1)(q-1)$ returns L126's form exactly. **No disagreement anywhere.**

The one candidate contradiction later in `second-order.md` is [line 896](../findings/second-order.md): *"**Every block has $L_e<\tfrac12$ strictly off the orbit, and this is unconditional.**"* Taken alone this contradicts both $\mu_{3,3}=\tfrac12$ and $\mu_{2,4}=\tfrac23$. **It does not contradict L126**: the sentence's own continuation scopes it to L27's range, *"at every $S^p\times S^q$ with $p,q\ge3$ and $(p,q)\ne(3,3)$, which covers every $n=2m\ge12$"*, and its host [Lemma L133](../findings/second-order.md) is about the balanced orbit at $n\ge12$, where $\mu=\tfrac2{n-2}\le\tfrac15$. "Unconditional" there means "not conditional on the granted diagonal case", which the same sentence goes on to say. **Reported as a wording hazard, not a defect**: the bolded claim carries no scope inside the bold.

I also confirm [line 892](../findings/second-order.md)'s independent statement that the $(3,1)$ and $(4,0)$ four-sets have $L_e=0$ "since $A=B=C$ there", that is exactly the computation in F5.

## Attack points that came to nothing, stated as findings

- **The $\ker DF(M)$ / tangent-space cut the brief expected to find omitted is not omitted.** The block writes "On the tangent space", and F2 shows the kernel identification survives even without it. The brief's suspicion is mistaken here.
- **No boundary case is silently excluded.** $p=2$ is handled explicitly and correctly; $p=1$ is excluded by the formula and by Einstein geometry.
- **$(3,3)$ is inside L126's hypothesis and outside [Lemma L27](../findings/nondegeneracy.md)'s.** That is the division of labour, not a gap.

## Verdict

**Every load-bearing step of L126 is correct as written**, and the three I could not take on trust (the derivative formula, the closed form $\mu_{p,q}$, and the $86$-vs-$84$ over-count), I derived or counted from the definitions rather than from the record. What is owed is presentational: the block states no index range for "the two-factor family", and its Diophantine justification omits the $(u-1)(v-1)=1$ line that makes it a proof. Neither touches the conclusion.

VERDICT: CONFIRMED
