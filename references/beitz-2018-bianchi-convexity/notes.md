# Beitz 2018, what the thesis actually contains

Transcribed 2026-08-26, on the cycle that closed the symmetric class. **The thesis had been stored since 2026-08-21 with no notes**, and the record's one-line summary of it ("its own contribution is a local Hessian computation near one boundary point") undersold the part that matters: it carries the conjecture's original statement *and* the mechanism its proof is supposed to run through.

## The conjecture, as Böhm and Wilking state it (Remark 6.3.15, p. 100)

> An unpublished conjecture of Christoph Böhm and Burkhard Wilking is that for $n\ge12$ the cones $\Omega_a$ are invariant under the ordinary differential equation (2.4) for $a\in[0,\tfrac n4]$.

with, from the introduction (p. 3),

$$\Omega_a:=\Big\{R\in\mathcal A_n\ \Big|\ \Big(\tfrac{n-2}4+a\Big)\lVert R\rVert^2\le\lVert\mathrm{ric}(R)\rVert^2\ \text{ and }\ \mathrm{scal}(R)>0\Big\},$$

and (2.4) the Hamilton ODE $\dot R=\Phi(R)$, $\Phi(R)=R^2+R^\#$. The dimension threshold $n\ge12$ is **stated with the conjecture**, not derived in the thesis.

## The mechanism, and the bridge to this project's cubic form

**Lemma 2.3.4 is a BICONDITIONAL and this note paraphrased it one-directionally, which misled a consumer.** At source it reads: *"If the sublevel sets of $F$ are invariant under (2.2), then for all $v\in C$ we have that $dF_v(\Phi(v))\le0$"* (**that first clause is invariance $\Rightarrow G\le0$**), *"Conversely, if $F$ satisfies (2.3) for all $v\in C$, then …"*, the second clause giving invariance of the sublevel sets when $C$ is additionally invariant. **Its hypotheses: $V$ a vector space, $\Phi$ locally Lipschitz, $C\subseteq V$ OPEN, $F$ smooth on $C$.** *The openness matters: it is what makes the lemma available on $\Omega_0$, whose $\mathop{\mathrm{scal}}>0$ clause is open, where Xu's Proposition 2.2 would need $C$ closed convex.* For $\Omega_a$ the function is $F(R)=\lVert R\rVert^2/\lVert\mathrm{ric}(R)\rVert^2$, and $\Omega_a=F^{-1}\big((-\infty,\tfrac4{n-2+4a}]\big)$. Writing $G(R):=dF_R(\Phi(R))$ and expanding the quotient rule,

$$G(R)\le0\iff\underbrace{\langle R,\Phi(R)\rangle}_{=\ P(R)}\ \le\ F(R)\,\big\langle\mathrm{ric}(R),\mathrm{ric}(\Phi(R))\big\rangle,$$

so **this project's cubic form $P$ is exactly the left-hand side of Böhm–Wilking's invariance criterion**, and on $\partial\Omega_a$ the coefficient $F(R)$ is the constant $\tfrac4{n-2+4a}$. A Weyl tensor has $\mathrm{ric}=0$, which is where $F$ blows up: **Weyl tensors are the extremal directions of the cone family**, which is why the $P(W)$-maximisation form is the hard direction of the cone conjecture rather than a separate problem.

## What the thesis proves toward it (Lemma 6.3.16, pp. 99–101; the cone endpoints are Remark 6.3.10, p. 98)

Invariance for $a\in[\tfrac n4-\varepsilon,\tfrac n4]$ only, a neighbourhood of the **endpoint**, by showing $I$ is a local maximum of $G$:

$$G(I)=0,\qquad dG_I=0,\qquad \mathrm{Hess}_IG(R,R)=-\frac8{(n-1)^3}\lVert R_{\mathrm{ric}_0}\rVert^2-\frac{16}{n(n-1)}\lVert R_W\rVert^2\le0 .$$

The Hessian is negative definite on $I^\perp$ **for every $n$**, so $n\ge12$ does not enter here. Whatever forces $n\ge12$ lives elsewhere, in the global behaviour of $G$ away from $I$, which is exactly the open part.

## Identities worth carrying

| | |
|---|---|
| $I^2+I^\#=(n-1)I$ | [BW08] Lemma 2.1 |
| $\mathrm{scal}(R^2+R^\#)=2\lVert\mathrm{ric}(R)\rVert^2$ | via Hamilton [Ham86], thesis Example 2.3.5, p. 29, gives $\mathrm{scal}(Q(W))=0$ for Weyl $W$ |
| $\tfrac d{ds}\big|_0\Phi(I+sR)=2(n-1)R_I+(n-2)R_{\mathrm{ric}_0}$ | (6.29), **the Weyl part drops out** of the linearisation at $I$ |
| $\mathrm{Hess}_IF(R_W,R_W)=\tfrac8{n(n-1)^2}\lVert R_W\rVert^2$ | (6.30) |
| $\mathrm{Hess}_IF(R_{\mathrm{ric}_0},R_{\mathrm{ric}_0})=\tfrac4{(n-1)^3}\lVert R_{\mathrm{ric}_0}\rVert^2$ | (6.31) |

## Results conditional on the conjecture

Theorems D and 6.3.17 (shrinking gradient Ricci solitons in $\Omega\cap\mathcal B_n$ are locally symmetric, $n\ge12$) and Theorem F / 6.3.19 (the Einstein version). The thesis also shows Theorem D is sharp: the Bryant soliton satisfies $\Omega_a$ for some $a>\tfrac12$ in $n\ge5$ and is not locally symmetric, so "shrinking" cannot be dropped.

## Correction to the record

[findings/problem.md](../../findings/problem.md) says the thesis states the conjecture "not [in] the $P(W)$-maximization formulation". That is right about the *wording*, and the content is closer than it reads:  $P(R)=\langle R,\Phi(R)\rangle$ is the left side of the invariance criterion and Weyl tensors are the family's extremal directions. **They are not the same statement**, the cone conjecture leaves $R_{\mathrm{ric}_0}$ unconstrained at $a=0$ and is strictly stronger; Conjecture A is its $R_{\mathrm{ric}_0}=0$ slice. The bridge above is the missing derivation.
