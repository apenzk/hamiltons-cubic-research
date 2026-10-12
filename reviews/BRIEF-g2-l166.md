# Gate 2 brief, Ricci-flatness and first Bianchi for the Kähler family

**You are one of two reviewers working from identical briefs, cold and independently.** Work from what is below and from sources you fetch yourself. Do not read the findings file this came from until you have formed your own verdict on every claim.

## Standing rules

**Analysis only.** Computation requires the user's approval for a specific task and it has not been given here. The one allowance is **screening a claim you are about to record**, seconds of compute, on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim. Everything else waits: searches, sweeps, optimisations, censuses, falsifier hunts. **All arithmetic exact**, rational or symbolic.

**Log** to `agent_logs/g2-l166-r<N>.log`: PID and phase plan on the first line, a line at every tool round carrying live state, and a closing `DONE <verdict>`. Say in the log before a long reasoning stretch what you are about to derive.

**Write** `reviews/REVIEW_r<N>.md`, **index it in `reviews/INDEX.md` in the same commit**, and commit both as `review(l166): r<N> <verdict>`. **Stage by path; never `git add -A`; leave nothing staged.**

## Definitions, fixed before anything else

- $\mathcal W_N$ is the space of algebraic Weyl tensors on $\mathbb R^N$: symmetric operators on $\Lambda^2\mathbb R^N$ satisfying first Bianchi and Ricci-flat.
- **Inner product**: the $\tfrac12$ goes at the $\Lambda^2$ level, $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ on skew matrices, so $\lVert\varphi_{ab}\rVert=1$ for $\varphi_{ab}=E_{ab}-E_{ba}$ and $\operatorname{tr}(v^2)=-2$ for a unit bivector. Write $x\wedge y$ for the operator $z\mapsto\langle x,z\rangle y-\langle y,z\rangle x$.
- $\mathrm{Ric}$ is the adjoint of $\cdot\wedge\mathrm{id}$; in spectral form, $\mathrm{Ric}(W)=\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha$ over an eigenbasis $\{v_\alpha\}$ of $W$ read as skew matrices.
- $\mathbb R^{2m}=\mathbb C^m$ with $J$; $A=\langle e_1,\dots,e_m\rangle$ real, $B=iA=\langle f_1,\dots,f_m\rangle$. Inside $\mathfrak{so}(2m)$, $\mathfrak{su}(m)=\mathfrak k\oplus\mathfrak m$ with $\mathfrak k=\mathfrak{so}(m)$ (real skew) and $\mathfrak m=i\,\mathrm{Sym}_0(m)$; $p=\dim\mathfrak k=\binom m2$, $q=\dim\mathfrak m=\binom{m+1}2-1$.
- $\Pi_{\mathfrak h}$ is the orthogonal projection of $\Lambda^2\mathbb R^{2m}$ onto $\mathfrak h$, read as a symmetric operator and extended by zero.

## The statement under review

> **Statement.** For $m\ge2$ and $W_{a,b}=a\Pi_{\mathfrak k}+b\Pi_{\mathfrak m}$,
> $$W_{a,b}\ \text{is Ricci-flat}\iff W_{a,b}\ \text{satisfies first Bianchi}\iff am+b(m+2)=0,$$
> so $W_{a,b}\in\mathcal W_{2m}$ exactly on the line $(a,b)\propto(m+2,-m)$ and nowhere else on the plane.

## The proof as written

> **Ricci-flatness is tracelessness, because both Casimirs are scalar.** $\mathrm{Ric}(W)=aC_{\mathfrak k}+bC_{\mathfrak m}$ with $C_{\mathfrak h}=-\sum_{v\in\mathfrak h}v^2$ on $\mathbb R^{2m}$. $C_{\mathfrak{su}(m)}$ is scalar by Schur, $\mathbb C^m$ being irreducible and $\mathfrak{su}(m)$ acting complex-linearly; $C_{\mathfrak k}$ is scalar because $\mathbb C^m|_{\mathfrak{so}(m)}=\mathbb R^m\oplus i\mathbb R^m$ is two copies of one real irreducible on which $C$ acts identically; and $C_{\mathfrak m}=C_{\mathfrak{su}(m)}-C_{\mathfrak k}$ is then scalar. One trace each: $\operatorname{tr}C_{\mathfrak h}=-\sum\operatorname{tr}(v^2)=2\dim\mathfrak h$, so $C_{\mathfrak k}=\tfrac pm\mathrm{Id}$ and $C_{\mathfrak m}=\tfrac qm\mathrm{Id}$. Hence $\mathrm{Ric}(W_{a,b})=0\iff ap+bq=0\iff(m-1)[am+b(m+2)]=0$.
>
> **First Bianchi is one equation too.** For $\mathfrak h\subseteq\mathfrak{so}(N)$ with orthonormal basis $\{v_\alpha\}$, the Bianchi sum of $\Pi_{\mathfrak h}=\sum_\alpha v_\alpha v_\alpha^{\mathsf T}$ is
> $$\Omega_{\mathfrak h}(x,y,z,w)=\sum_\alpha\big[\langle v_\alpha x,y\rangle\langle v_\alpha z,w\rangle+\langle v_\alpha y,z\rangle\langle v_\alpha x,w\rangle+\langle v_\alpha z,x\rangle\langle v_\alpha y,w\rangle\big],$$
> a $4$-form invariant under the normaliser of $\mathfrak h$. Both $\Omega_{\mathfrak k}$ and $\Omega_{\mathfrak m}$ are $SO(m)$-invariant, and
> $$\Lambda^4(A\oplus B)=\Lambda^4A\oplus(\Lambda^3A\otimes B)\oplus(\Lambda^2A\otimes\Lambda^2B)\oplus(A\otimes\Lambda^3B)\oplus\Lambda^4B,$$
> whose $SO(m)$-invariants sit in the middle summand alone once $m\ne4$, giving a line. **Both forms vanish identically on the four outer summands at every $m$**: every term of $\Omega$ carries a factor $\langle ve,e'\rangle$ or $\langle vf,f'\rangle$, which $\mathfrak m$ kills since it exchanges $A$ and $B$, or a factor $\langle ve,f\rangle$, which $\mathfrak k$ kills since it preserves each.
>
> **The two evaluations.** With $\mathfrak k$ spanned by $\tfrac1{\sqrt2}(e_i\wedge e_j+f_i\wedge f_j)$ and $\mathfrak m$ by $\tfrac1{\sqrt2}(e_k\wedge f_l+e_l\wedge f_k)$ together with the traceless span of $\{e_k\wedge f_k\}$:
> $$\Omega_{\mathfrak k}(e_1,e_2,f_1,f_2)=\tfrac12,\quad \Omega_{\mathfrak m}(e_1,e_2,f_1,f_2)=\tfrac12+\tfrac1m,\quad \Omega_{\mathfrak k}(e_1,e_2,f_3,f_4)=\Omega_{\mathfrak m}(e_1,e_2,f_3,f_4)=0 .$$
> The $\tfrac1m$ is where the trace condition on $\mathfrak m$ enters: the diagonal projector reads $\delta_{kl}-\tfrac1m$, and $-(\delta_{12}-\tfrac1m)=\tfrac1m$ is the third cyclic term. The second evaluation separates $\mathrm{Id}$ from $*$ at $m=4$ and both forms have zero $*$-component, so $m=4$ takes the same equation. Bianchi is therefore $\tfrac a2+b(\tfrac12+\tfrac1m)=0$, that is $am+b(m+2)=0$. $\square$

## What to attack, answering every item in writing

**Silence is not a verdict.** Answer each item, including where you find nothing.

1. **The identification of $\mathfrak k$ and $\mathfrak m$.** Is $\mathfrak{su}(m)=\{X+iY:X$ real skew, $Y$ real symmetric traceless$\}$, and are the bivector spanning sets given for $\mathfrak k$ and $\mathfrak m$ correct, including the normalising $\tfrac1{\sqrt2}$ and the count $p+q=m^2-1$? Derive each spanning element from the operator it names.
2. **The spectral form of $\mathrm{Ric}$**, and whether $\mathrm{Ric}(W)=\sum\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha$ is the right normalisation here, a constant factor is harmless to a vanishing statement, so say explicitly whether anything downstream reads a value.
3. **The three scalarity claims.** Schur on $\mathbb C^m$ for $\mathfrak{su}(m)$ requires $C$ to be complex-linear, check it. $C_{\mathfrak{so}(m)}$ scalar on $\mathbb C^m$ requires that $\mathbb R^m$ is irreducible over $\mathbb R$ for $\mathfrak{so}(m)$ **and** that no mixing between the two copies occurs; **check both, and check $m=2$ separately**, where $\mathfrak{so}(2)$ is abelian and $\mathbb R^2$ is not irreducible over $\mathbb R$.
4. **The trace evaluation.** $\operatorname{tr}C_{\mathfrak h}=2\dim\mathfrak h$ under $\operatorname{tr}(v^2)=-2$, then division by $2m$. Check that the basis used is orthonormal for the pairing stated, and that $C_{\mathfrak k}=\tfrac pm$, $C_{\mathfrak m}=\tfrac qm$ follow.
5. **The Bianchi sum.** Derive $\Omega_{\mathfrak h}$ yourself from $\langle R(x\wedge y),z\wedge w\rangle$ and $\Pi_{\mathfrak h}=\sum v_\alpha v_\alpha^{\mathsf T}$, tracking the sign of $\langle v,x\wedge y\rangle$ against the stated convention for $x\wedge y$. Is $\Omega_{\mathfrak h}$ really totally antisymmetric? Is "first Bianchi $\iff\Omega=0$" exactly the identity, in the cyclic form used?
6. **The vanishing on the outer summands.** The proof gives one reason per summand. **Check all four explicitly**, including the mixed-index cases such as $(e_1,e_2,e_3,f_1)$ and $(e_1,f_2,f_3,f_4)$, and say whether the reason as stated covers every term of every summand or only the ones the proof names.
7. **The invariant count.** Is $\dim(\Lambda^4\mathbb R^{2m})^{SO(m)}=1$ for $m\ne4$ and $2$ in the middle summand at $m=4$? Check $m=2$ and $m=3$ separately, where some summands vanish outright, and check whether $\Lambda^2\mathbb R^m$ is irreducible at the small $m$ the argument needs.
8. **The two evaluations.** Recompute both, term by term, including the traceless projector giving $\tfrac1m$ and the claim that the two $4$-tuples separate $\mathrm{Id}$ from $*$ at $m=4$. **A sign error in $\Omega_{\mathfrak m}$'s third term flips the conclusion**, so derive it rather than reading it.
9. **The two conditions coinciding.** This is the whole content: each is one equation on a plane, and the theorem is that they cut the same line. Check the algebra $ap+bq=(m-1)[am+b(m+2)]/2$ and whether any $m$ makes the two conditions differ.
10. **Hypothesis inventory.** Every hypothesis, then every imported fact's hypotheses (Schur, irreducibility, the $\Lambda^\pm$ splitting at $m=2$), each checked against the object. Which stated hypotheses go unused?
11. **The edges.** $m=2$, where $\mathcal W_4=S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$ and Bianchi should be automatic on a $\Lambda^\pm$ summand, **is that consistent with the general equation, and does the general argument actually reproduce it?** Then $m=3$, $m=4$, and $a=b=0$.
12. **Name what would break it.** End by naming the $(m,a,b)$ that, if it existed, would falsify the statement, and say what you did to look for it.

## Before you write a discrepancy down

Clear all three or report it `withdrawn` with the reason: **locate it exactly**; **exhibit the failure concretely** in closed form; **argue the opposite**.

## Report format

Title naming the claims; a standfirst saying the brief was cold, that no numerical work was done and every value is exact, and the log path; **the claim table before any prose**; a one-line actionable summary; `## 0. Conventions, fixed once`; the hypothesis inventory; numbered sections with each derivation in full; the overall verdict from `PROVEN`, `PROVEN (hypotheses corrected`, `GAP`, `BROKEN`, `HYPOTHESIS-DEBT`, `UNRESOLVED), needs computation`.

**You check the written proof; you do not build your own.** Where a claim has no argument on file the finding is *"this claim has no argument on file"*, full stop, and the verdict is `HYPOTHESIS-DEBT` naming what would have to be proved.
