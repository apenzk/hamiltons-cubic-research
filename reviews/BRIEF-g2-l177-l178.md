# Gate 2 brief, L177's incidence characterisation and L178's rank-three bound

**Cold brief. Work from the definitions and statements below and nothing else.** Do not read [findings/](../findings/) for the answer.

## The standing rule you inherit

**This programme is on an ANALYSIS-ONLY footing.** Computation requires the user's approval for a specific task and you do not have it. **Permitted without asking: screening a claim you are about to record, seconds of compute, on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim.** Reserved and forbidden: searches, sweeps, optimisations, censuses, falsifier hunts. **A refutation must be exhibited in closed form or it is not a refutation.**

## Conventions, fixed once, every constant this brief's checklist names is here

- $\mathcal W_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$: the Riemann symmetries, the first Bianchi identity $W_{abcd}+W_{acdb}+W_{adbc}=0$, and total trace-freeness $\sum_bW_{abcb}=0$. **It is a linear subspace, so $0\in\mathcal W_n$.**
- $W$ acts self-adjointly on $\Lambda^2\mathbb R^n$, where $\{f_a\wedge f_b\}_{a<b}$ is orthonormal. **The norm is $\lVert W\rVert^2=\mathop{\mathrm{tr}}(W^2)=\sum_\alpha\lambda_\alpha^2$**, the sum over the $\Lambda^2$ spectrum.
- $P(W)=\langle W,Q(W)\rangle$ with $Q(W)=W^2+W^\#$, and $\theta=P/\lVert W\rVert^3$. **$\langle A,B\rangle=\mathop{\mathrm{tr}}(AB)$.**
- **The $\#$ index formula is $(W^\#)_{ab}=\tfrac12\sum c_{acd}c_{bef}W_{ce}W_{df}$**, the $c$ being structure constants of $\mathfrak{so}(n)\cong\Lambda^2$ in an orthonormal basis. **Its anchor, which the record proves and uses to pin the normalisation, is $\mathrm{id}^\#=(n-2)\,\mathrm{id}$.**
- **Coordinate-diagonal** in an orthonormal frame $\{f_a\}$: $W_{abcd}=0$ unless $\{a,b\}=\{c,d\}$. **Sectional matrix** $K_{ab}=W_{abab}$. *An earlier audit established, and you may take as given, that this locus is exactly the hollow symmetric $K$ with $\sum_bK_{ab}=0$, that $W(f_a\wedge f_b)=K_{ab}f_a\wedge f_b$ there, and that a nonzero such $W$ has at least four nonzero $K_{ab}$.*
- **The conjecture's range is $n\ge12$**, its threshold constant is $\sqrt{3/2}=1.224745$, and $\theta_0(12)=1.236033$. **The crossover the record watches is $n=6+2\sqrt7$.**

## Claim 1, L177, the support graph

For a graph $G=(V,E)$ let $N\in\{0,1\}^{V\times E}$ be the **unsigned** incidence matrix, $N_{ve}=1$ exactly when $v\in e$, and let $b(G)$ count the bipartite connected components.

1. **The coordinate-diagonal Weyl tensors supported inside $G$ are exactly $\ker N$**, of dimension $\lvert E\rvert-\lvert V\rvert+b(G)$.
2. **$G$ carries one with support exactly $G$** iff $\ker N$ has a full-support vector.
3. **At $G=K_n$, $n\ge3$, the locus has dimension $\binom n2-n$.**

**Proof as written.** Vanishing row sums say $\sum_{e\ni v}x_e=0$, which is $Nx=0$; the dimension is rank–nullity with $\mathop{\mathrm{rank}}N=\lvert V\rvert-b(G)$. That rank: on a connected bipartite component the $\pm1$ sign vector $\epsilon$ satisfies $\epsilon^{\mathsf T}N=0$ since each edge crosses the parts; on a connected non-bipartite component an odd closed walk forces any left null vector to satisfy $\epsilon_v=-\epsilon_v$. $K_n$ is connected and non-bipartite for $n\ge3$, so $b=0$.

**And the block claims this explains the four**: a support needs $\lvert E\rvert\ge\lvert V\rvert-b+1$; all-bipartite that is an independent cycle, and a bipartite cycle has length $\ge4$; otherwise a non-bipartite component needs $\lvert E_i\rvert\ge\lvert V_i\rvert+1$ and **the smallest such graph containing an odd cycle has five edges**.

## Claim 2, L178, the rank-three bound

**Statement.** Let $W\in\mathcal W_n$ be nonzero, supported on $\Lambda^2V$ for a four-dimensional $V\subseteq\mathbb R^n$, with $\mathop{\mathrm{rank}}(W:\Lambda^2\to\Lambda^2)\le3$. Then $\theta(W)\le\sqrt{3/2}$, with equality exactly when $W$ is $W_{\mathbb{CP}^2}$ up to scale, sign and frame.

**Proof as written, in five steps.**

1. On $\Lambda^2V$ the operator splits as $W^+\oplus W^-$, each self-adjoint and **trace-free on a three-dimensional space**, so each has rank $0$, $2$ or $3$, never $1$. Rank $\le3$ therefore forces one summand to vanish. The rank-two case has a zero eigenvalue, so $e_3=0$ and step 4 gives $\theta=0$.
2. Write $\Lambda^\pm\cong\mathfrak{su}(2)$ with structure constants $c_{ijk}=\gamma\epsilon_{ijk}$. The index formula at $W=\mathrm{id}$ gives $(\mathrm{id}^\#)_{ab}=\tfrac12\gamma^2\sum_{c,d}\epsilon_{acd}\epsilon_{bcd}=\gamma^2\delta_{ab}$, and the anchor $\mathrm{id}^\#=(n-2)\mathrm{id}$ reads $2\,\mathrm{id}$ at $n=4$, so $\gamma^2=2$. Then $W^\#=2\mathop{\mathrm{cof}}(W)$ on the diagonalising basis and $\langle W,W^\#\rangle=6e_3$.
3. $\mathfrak{so}(V)$ is a subalgebra of $\mathfrak{so}(n)$, so a $\#$-term needs all four structure-constant slots inside it; $W^\#$ stays supported on $\Lambda^2V$ and is computed by $\mathfrak{so}(4)$'s own constants. **$\theta$ is an invariant of the four-dimensional piece**, which is why step 2 reads the anchor at $n=4$.
4. $\lVert W\rVert^2=p_2=1$ and $W$ trace-free give $e_1=0$, so Newton gives $\mathop{\mathrm{tr}}W^3=p_3=3e_3$; with step 2, $\theta=3e_3+6e_3=9e_3$.
5. $e_1=0$ and $p_2=1$ give $e_2=-\tfrac12$, so the eigenvalues are the roots of $x^3-\tfrac12x-e_3$. Three real roots is a nonnegative discriminant, $-4(-\tfrac12)^3-27e_3^2=\tfrac12-27e_3^2\ge0$, so $\lvert e_3\rvert\le\tfrac1{3\sqrt6}$ and $\theta=9e_3\le\tfrac3{\sqrt6}=\sqrt{3/2}$. Equality forces a repeated root, and $x^3-\tfrac12x-\tfrac1{3\sqrt6}$ has roots $\tfrac1{\sqrt6}(2,-1,-1)$, which is $\mathbb{CP}^2$'s self-dual spectrum.

## What to attack, and answer every item in writing

**Silence is not a verdict.** Answer each explicitly, including where you find nothing.

1. **Every hypothesis**, of both statements and of everything imported, checked against the object. Used, stated-and-unused, used-and-unstated.
2. **L177's rank identity $\mathop{\mathrm{rank}}N=\lvert V\rvert-b$.** Is it true as stated, over $\mathbb R$, for graphs with isolated vertices, for disconnected graphs, for a single edge, for a graph with no edges? *Read it at a source rather than recalling it, and fetch that source into [references/](../references/) with a `notes.md`.*
3. **L177's claim (2).** Is "$\ker N$ has a full-support vector" really equivalent to carrying a tensor of support exactly $G$, and is a full-support vector guaranteed whenever $\ker N\ne0$? **This is the likeliest place claim (2) overreaches.**
4. **L177's minimum-edge argument.** Is the smallest non-bipartite graph with $\lvert E\rvert\ge\lvert V\rvert+1$ containing an odd cycle really five edges? Exhibit or refute.
5. **L178 step 1.** Is "trace-free on a three-space, hence never rank one" right, and does rank $\le3$ really force a summand to vanish rather than allowing rank $2+1$ or $3+0$ only? **Check the arithmetic of every split.**
6. **L178 step 2, the constant.** Derive $\gamma^2$ independently. Is $\Lambda^\pm\cong\mathfrak{su}(2)$ with $c=\gamma\epsilon$ the right normalisation in an **orthonormal** $\Lambda^2$ basis, and does the anchor evaluation use the right $n$? **A factor of two here changes the answer, and this record has admitted such a factor twice.**
7. **L178 step 2, the adjugate.** Is $W^\#=\gamma^2\mathop{\mathrm{cof}}(W)$ on $\mathfrak{su}(2)$, and does $\langle W,W^\#\rangle=6e_3$ follow?
8. **L178 step 3, the padding.** Does $\#$ really commute with the zero-embedding, and is $\theta$ unchanged? *Note the anchor $\mathrm{id}^\#=(n-2)\mathrm{id}$ is $n$-dependent, check the step is not reading it at the wrong $n$.*
9. **L178 step 4.** Newton's identity, the claim $p_1=e_1=0$, and whether $\lVert W\rVert^2=\mathop{\mathrm{tr}}(W^2)$ is the norm $\theta$ is defined against.
10. **L178 step 5.** The discriminant sign convention, the equality case, and whether "up to scale, sign and frame" is the right uniqueness statement, in particular whether $-W$ and the anti-self-dual mirror are covered.
11. **The kernel.** $\ker W\ne0$ is this record's recurring obstruction and every object here is almost all kernel. Does any step assume otherwise?
12. **The boundary.** $n=4$ exactly, $n=5$, odd $n$, $n=6+2\sqrt7$, and $n$ below the conjecture's range $n\ge12$.
13. **Scope.** L178 assumes four-dimensional support and does not prove that rank $\le3$ implies it. Is that assumption load-bearing, and does the block claim anything it does not reach?

**Name what would break it.** End by naming the object that, if it existed, would falsify each claim, and say what you did to look for it.

**Do not supply a missing argument.** Where a claim has no proof on file the finding is *"this claim has no argument on file"*, verdict `HYPOTHESIS-DEBT`.

## Output

`reviews/REVIEW_r<N>.md`: title; standfirst saying the brief was cold and **no numerical work was done, every value exact**, with your log path; **the claim table before any prose**, verdicts in caps; a one-line actionable summary; `## 0. Conventions, fixed once`; the hypothesis inventory; numbered sections with derivations in full; the overall verdict. **Use your own verdict vocabulary and state it plainly, the fold records your word, not a kinder one.**

Log to `agent_logs/g2-l178-r<N>.log` with PID, a line per phase, live state at every tool round, and a closing `DONE <verdict>`. Commit your report alone, `review(L178): r<N> <verdict>`.
