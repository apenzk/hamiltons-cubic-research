# Verifier v381, the three "further hypotheses" of Lemma L20's proof (step G4, round L20-r2)

*Cold brief ([ADJ_L20r2_G4.md](ADJ_L20r2_G4.md)). No numerical work was done and no scripts were written. Every value below is exact. Log: [agent_logs/verify-L20-v381.log](../agent_logs/verify-L20-v381.log).*

| # | Claim | Verdict |
|---|---|---|
| 1 | $d$ is $SO(n)$-invariant | CONFIRMED, as a theorem of the setting |
| 2 | The orbit $SO(n).u$ is a compact embedded submanifold | CONFIRMED, as a theorem of the setting |
| 3 | A nearest orbit point exists | CONFIRMED, compactness of $SO(n)$ alone gives it |
| 4 | The first-variation condition $V\perp T_u(SO(n).u)$ holds at a nearest point | CONFIRMED, from one-parameter curves $e^{tZ}.u$ in the orbit |
| 5 | $\varphi>0$ is needed "for that condition to be non-vacuous" | REFUTED AS STATED: the condition holds at $\varphi=0$ as well, and what $\varphi>0$ buys is that $V$ is defined |
| 6 | The three are hypotheses the lemma needs **beyond its setting** | REFUTED AS STATED: the first two are theorems of the setting, and the third is one side of a case split whose other side line 135 closes |
| 7 | The step read as "the proof uses three facts, and states them explicitly" | CONFIRMED |

**Summary: the step is VALID read as naming three facts the proof uses, each of which holds in the setting, so Lemma L20 carries no hypothesis beyond its setting from this sentence, and the sentence's wording "hypotheses" overstates the debt.**

## 0. Conventions, fixed once

- $\mathcal W_n\subset\operatorname{End}(\Lambda^2\mathbb R^n)$ is the space of algebraic Weyl operators with the Frobenius inner product, as in the brief's definitions.
- $SO(n)$ acts by $g.W=\rho(g)\,W\,\rho(g)^{-1}$ with $\rho(g)=\Lambda^2g$. Its derivative at the identity along $Z\in\mathfrak{so}(n)$ is $Z.W:=\tfrac{d}{dt}\big|_{t=0}e^{tZ}.W=[\rho_*(Z),W]$.
- $d(X,Y)=\arccos\langle X,Y\rangle$ on the unit sphere, and $d(X,\mathcal O)=\min_{Y\in\mathcal O}d(X,Y)$, as fixed in [conventions.md](../findings/conventions.md) line 81.
- $u=W_{\mathbb{CP}^2}$ padded, $\lVert u\rVert=1$, $\mathcal O=SO(n).u$, $T_u\mathcal O$ its tangent space at $u$.
- $\arccos$ is strictly decreasing on $[-1,1]$, so minimising $d(X,\cdot)$ over a set of unit vectors is maximising $\langle X,\cdot\rangle$ over it.

## 1. Hypothesis inventory

Setting facts, which the lemma's statement and proof take as its setting:

- **S1.** $\mathcal W_n$ is an $SO(n)$-invariant subspace of $\operatorname{End}(\Lambda^2)$. Standard: $\mathcal W_n$ is the joint kernel of the Ricci contraction and the first Bianchi map, and both are $O(n)$-equivariant.
- **S2.** The inner product on $\mathcal W_n$ is $SO(n)$-invariant. Standard, see Section 2.
- **S3.** $P(g.W)=P(W)$. Stated in the proof (line 125) as a property of the setting, since $Q$ is built from the $O(n)$-equivariant product on $\mathfrak{so}(n)$.
- **S4.** Some unit Weyl operator has $P=\Theta_n>\sqrt{3/2}$ at every $n\ge12$. Supplied by the passage's witness and its Lean thresholds, and not under adjudication here.
- **S5.** Lemma L21 (Passage B), a given.

The three items under adjudication:

- **H1.** $d$ is $SO(n)$-invariant.
- **H2.** $\mathcal O$ is a compact embedded submanifold, a nearest point exists, and the first-variation condition holds there.
- **H3.** $\varphi>0$.

## 2. H1 follows from S2, so it is a theorem of the setting

For an orthogonal operator $R$ on a finite-dimensional inner product space $E$, conjugation $X\mapsto RXR^{-1}=RXR^{\mathsf T}$ preserves the Frobenius pairing on $\operatorname{End}(E)$: $\operatorname{tr}\big((RXR^{\mathsf T})^{\mathsf T}RYR^{\mathsf T}\big)=\operatorname{tr}(RX^{\mathsf T}YR^{\mathsf T})=\operatorname{tr}(X^{\mathsf T}Y)$.

$\rho(g)=\Lambda^2g$ is orthogonal on $\Lambda^2$ for either normalisation of the bivector pairing in [conventions.md](../findings/conventions.md), since each is a constant multiple of the other and $\Lambda^2g$ sends an orthonormal basis $\{e_a\wedge e_b\}$ to an orthonormal set. Rescaling the operator-level pairing by a constant also preserves invariance, so the conclusion is independent of the factor $2$ the conventions table discusses.

Hence $\langle g.X,g.Y\rangle=\langle X,Y\rangle$ on $\mathcal W_n$ (S1 keeps $g.X$ inside $\mathcal W_n$), the unit sphere is preserved, and $d(g.X,g.Y)=\arccos\langle g.X,g.Y\rangle=d(X,Y)$. Since $g$ permutes $\mathcal O$, also $d(g.X,\mathcal O)=d(X,\mathcal O)$.

**What the proof uses H1 for**, the rotation at line 125. Let $h.u$ be a nearest orbit point to $W^*$ and put $W'=h^{-1}.W^*$. Then $\lVert W'\rVert=1$, $P(W')=P(W^*)$ by S3 so $W'$ is again a maximizer, $d(W',\mathcal O)=\varphi$ by H1, and $\langle W',u\rangle=\langle W^*,h.u\rangle=\cos\varphi$, so $u$ is a nearest orbit point to $W'$. Renaming $W'$ as $W^*$ is exactly "rotate so that the nearest orbit point is $u$ itself". Nothing beyond S1–S3 enters.

## 3. H2 is a theorem of the setting, and the step needs less of it than it states

**Compactness and existence.** $\mathcal O$ is the image of the compact group $SO(n)$ under the continuous map $g\mapsto g.u$, so it is compact. $Y\mapsto\langle W^*,Y\rangle$ is continuous on $\mathcal O$, so it attains its maximum, which is a nearest point by the monotonicity of $\arccos$. Existence therefore uses compactness alone.

**Embeddedness.** The orbit map descends to $SO(n)/SO(n)_u\to\mathcal W_n$, an injective immersion (its differential at the coset of $e$ has kernel $\mathfrak{so}(n)_u/\mathfrak{so}(n)_u=0$, and equivariance moves this to every point). An injective continuous map from a compact space to a Hausdorff space is a homeomorphism onto its image, so the immersion is an embedding, and $T_u\mathcal O=\{Z.u:Z\in\mathfrak{so}(n)\}$. This is the standard fact that orbits of a compact Lie group acting smoothly are compact embedded submanifolds.

**First variation.** For $Z\in\mathfrak{so}(n)$ the curve $c(t)=e^{tZ}.u$ lies in $\mathcal O$, is smooth (the action is polynomial in the entries of $e^{tZ}$), and has $c(0)=u$, $c'(0)=Z.u$. The function $f(t)=\langle W^*,c(t)\rangle$ has a maximum at $t=0$, so $f'(0)=\langle W^*,Z.u\rangle=0$. Also $\lVert c(t)\rVert=1$ by Section 2, so $\langle u,Z.u\rangle=0$. Hence, for every $\xi\in T_u\mathcal O$,
$$\langle W^*,\xi\rangle=0,\qquad\langle u,\xi\rangle=0.$$
The only use of embeddedness is the identification of $\{Z.u\}$ with $T_u\mathcal O$, which is the subspace Lemma L21 names. The first-variation condition itself needs only the curves.

**Deriving the decomposition the proof writes.** Suppose $0<\varphi\le0.5748$. Then $0<\sin\varphi$ and
$$V:=\frac{W^*-\cos\varphi\,u}{\sin\varphi}$$
satisfies $\langle V,u\rangle=(\cos\varphi-\cos\varphi)/\sin\varphi=0$, $\lVert V\rVert^2=(1-2\cos^2\varphi+\cos^2\varphi)/\sin^2\varphi=1$, and $\langle V,\xi\rangle=(\langle W^*,\xi\rangle-\cos\varphi\langle u,\xi\rangle)/\sin\varphi=0$ for $\xi\in T_u\mathcal O$. So $W^*=\cos\varphi\,u+\sin\varphi\,V$ with $V$ a unit vector in $u^\perp\cap T_u\mathcal O^\perp$, precisely the hypothesis of Lemma L21. The line 125 claim "orthogonal also to $T_u(SO(n).u)$ by the first-variation condition" is confirmed.

## 4. H3 is a case split, and its stated reason is inexact

**Locating the wording.** Line 125: "and that $\varphi>0$ for that condition to be non-vacuous, the degenerate branch is treated separately below."

**Arguing that the wording is right.** One might read "that condition" as the orthogonality of $V$ to $T_u\mathcal O$, which is a statement about $V$, and $V$ has no meaning at $\varphi=0$. Under that reading the phrase is a loose way of saying "for $V$ to be defined".

**Exhibiting where it is inexact.** The first-variation condition as derived in Section 3 is $\langle W^*,\xi\rangle=0$ for $\xi\in T_u\mathcal O$. At $\varphi=0$ one has $W^*=u$ (below), and $\langle u,\xi\rangle=0$ holds, so the condition is true and not vacuous there. What fails at $\varphi=0$ is the division by $\sin\varphi$ defining $V$, which then leaves $V$ free rather than forced. The correct reason for $\varphi>0$ is that it determines $V$.

**The degenerate branch closes the other side** (line 135). If $\varphi=0$ then $\langle W^*,h.u\rangle=1$ for some $h$, with both vectors of unit norm, so equality in Cauchy–Schwarz gives $W^*=h.u$. By S3, $\max P=P(u)=\sqrt{3/2}$, i.e. $m=1$, and S4 supplies a unit Weyl operator with $P>\sqrt{3/2}$ at $n\ge12$, a contradiction. The expansion is not even needed: $m=\cos^30=1$ directly. The Lean [tube_exclusion](../lean/HamiltonsCubic/Results/L20Statement.lean) takes $0\le\varphi$ and so already covers $\varphi=0$ on the algebraic side, with any $\alpha$ and $\gamma$ meeting its hypotheses.

So $\varphi>0$ restricts nothing. The cases $\varphi=0$ and $0<\varphi\le0.5748$ exhaust the supposition $\varphi\le0.5748$, since $\varphi\ge0$ holds for any angle.

## 5. The sentence as a whole

**Literal reading, REFUTED AS STATED.** "Three further hypotheses are used and are stated here rather than assumed", read as "the lemma is conditional on three hypotheses beyond its setting", is false: H1 follows from S1 and S2 (Section 2), H2 follows from the compactness of $SO(n)$ and the smoothness of a linear action (Section 3), and H3 is half of an exhaustive case split whose other half is closed (Section 4). A reader who took them as open hypotheses would wrongly count Lemma L20 as carrying three debts beyond the eigenvalue input of L21.

**Strongest reading, CONFIRMED.** "The proof uses three facts, stated explicitly here rather than used silently" is what the phrase "stated here rather than assumed" supports. Under it every item is correct, every item is discharged by standard mathematics in the setting, and the proof's use of each (rotation, nearest point and orthogonality of $V$, definition of $V$) is sound as shown.

**Suggested wording**, for whoever repairs the passage: "The proof uses three facts of the setting: $d$ is $SO(n)$-invariant, because the conjugation action is orthogonal; a nearest orbit point exists and satisfies the first-variation condition, because $SO(n)$ is compact and $t\mapsto e^{tZ}.u$ lies in the orbit; and for $\varphi>0$ the vector $V$ below is defined, the case $\varphi=0$ being closed separately."

## 6. Verdict

**VALID.** Read as naming three facts the proof uses, the step is correct, and a VALID reading needs no hypothesis beyond the setting facts S1 ($\mathcal W_n$ is $SO(n)$-invariant), S2 (the inner product is $SO(n)$-invariant) and S3 ($P$ is $SO(n)$-invariant), together with the case split $\varphi=0$ closed by S4 at line 135. The literal presentation of the three as hypotheses "beyond its setting" is REFUTED AS STATED, and the stated reason for $\varphi>0$ ("non-vacuous") should read "so that $V$ is defined".
