# Verifier v382, whether the three "further hypotheses" of Lemma L20's proof are hypotheses beyond its setting

Cold brief ([ADJ_L20r2_G4.md](ADJ_L20r2_G4.md)), no numerical work, no scripts written, every value exact. Log: [agent_logs/verify-L20-v382.log](../agent_logs/verify-L20-v382.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | $d$ is $SO(n)$-invariant, a hypothesis beyond the setting | REFUTED AS STATED (it is a theorem of the setting) |
| 2 | The orbit is a compact embedded submanifold with a nearest point obeying the first-variation condition, a hypothesis beyond the setting | REFUTED AS STATED (each part is a theorem of the setting) |
| 3 | $\varphi>0$, a hypothesis beyond the setting | REFUTED AS STATED (it is a case split, and the complementary case is closed) |
| 4 | The three facts are true in the setting and are what the proof uses | CONFIRMED |
| 5 | Removing the three from the hypothesis list changes nothing in the conclusion of Lemma L20 | CONFIRMED |

**Summary: the step FAILS as written, harmlessly. None of the three is a hypothesis the lemma needs beyond its setting, since two are standard theorems about an orthogonal action of a compact group and the third is a case distinction the proof closes, so Lemma L20 is unconditional in these three respects and its canonical statement is right to omit them.**

## 0. Conventions, fixed once

- $\mathcal W_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$, viewed as symmetric endomorphisms of $\Lambda^2(\mathbb R^n)$, with the Frobenius inner product $\langle W,Z\rangle=\mathrm{tr}(WZ)$. $S$ is its unit sphere.
- $g\in SO(n)$ acts by $g.W=(\Lambda^2g)\,W\,(\Lambda^2g)^{-1}$, the conjugation action of Passage A. $\Lambda^2g$ is orthogonal on $\Lambda^2(\mathbb R^n)$ with its induced inner product, so $(\Lambda^2g)^{-1}=(\Lambda^2g)^T$.
- $d(X,Y)=\arccos\langle X,Y\rangle\in[0,\pi]$ for $X,Y\in S$, as fixed in Passage A.
- $u=W_{\mathbb{CP}^2}$ padded, $u\in S$. $\mathcal O=SO(n).u$. For $\xi\in\mathfrak{so}(n)$, $\xi.u=\frac{d}{dt}\big|_{t=0}\exp(t\xi).u$, and $\mathfrak{so}(n).u=\{\xi.u\}$.
- $\varphi=d(W^*,\mathcal O)=\inf_{v\in\mathcal O}d(W^*,v)$.
- "The setting" is everything above together with the existence of the maximizer $W^*$, which the proof derives from compactness of $S$.

## 1. Hypothesis inventory

What the proof needs at the sentence under review, and where each comes from.

- (S1) The action preserves $\mathcal W_n$. Standard: the Bianchi identity and the Ricci contraction are $O(n)$-equivariant, so the conjugate of a Weyl tensor is a Weyl tensor.
- (S2) The action is orthogonal for the Frobenius product. Standard, shown in section 2.
- (S3) $SO(n)$ is a compact Lie group acting smoothly (linearly) on $\mathcal W_n$. Standard.
- (C) The case split $\varphi=0$ versus $\varphi>0$. A proof device, closed in section 4.

The step under review asserts that three items are hypotheses beyond this list. Sections 2 to 4 derive each from (S1) to (S3) and (C).

## 2. Invariance of $d$ follows from the setting

For $g\in SO(n)$ write $A=\Lambda^2g$, orthogonal. Then for $X,Y\in\mathcal W_n$,

$$\langle g.X,g.Y\rangle=\mathrm{tr}(AXA^TAYA^T)=\mathrm{tr}(AXYA^T)=\mathrm{tr}(XY)=\langle X,Y\rangle.$$

So $g$ maps $S$ to $S$ and $\cos d(g.X,g.Y)=\cos d(X,Y)$. Since $\arccos$ is injective on $[-1,1]$, $d(g.X,g.Y)=d(X,Y)$. Because $\mathcal O$ is $SO(n)$-stable, $d(g.W^*,\mathcal O)=d(W^*,\mathcal O)$ as well.

This is exactly what the rotation step uses: if $v=h.u$ is a nearest orbit point to $W^*$, then $h^{-1}.W^*$ is a unit Weyl tensor with $P(h^{-1}.W^*)=P(W^*)$ (by the invariance of $P$, which the passage states separately), and $d(h^{-1}.W^*,u)=d(W^*,v)=\varphi=d(h^{-1}.W^*,\mathcal O)$. So $u$ is a nearest orbit point to the rotated maximizer.

The reading under which invariance could be a genuine hypothesis is a choice of $d$ not built from the inner product. Passage A fixes $d$ as $\arccos\langle\cdot,\cdot\rangle$, and the chord reading it rejects, $\|X-Y\|=\sqrt{2-2\langle X,Y\rangle}$, is invariant by the same computation. No reading the passage allows makes item 1 an extra assumption.

## 3. The orbit, the nearest point and the first-variation condition follow from the setting

**Compactness and existence.** $\mathcal O$ is the image of the compact group $SO(n)$ under the continuous map $g\mapsto g.u$, so it is compact. It lies in $S$ by section 2. The function $v\mapsto d(W^*,v)=\arccos\langle W^*,v\rangle$ is continuous on $\mathcal O$, so it attains its infimum at some $v\in\mathcal O$. A nearest point exists.

**Embedded submanifold.** The orbit map descends to $SO(n)/SO(n)_u\to\mathcal W_n$, an injective immersion (a standard fact for smooth actions of Lie groups). Its domain is compact, so it is a homeomorphism onto its image and $\mathcal O$ is an embedded submanifold with $T_u\mathcal O=\mathfrak{so}(n).u$. This identification is the one place embeddedness enters, and it matters only so that $T_u(SO(n).u)$ in Lemma L21 (Passage B) means the same space as the $\mathfrak{so}(n).u$ the variation below produces. Both are the image of the differential of the orbit map, so they agree.

**First variation.** After the rotation of section 2 the nearest point is $u$. For $\xi\in\mathfrak{so}(n)$ the function $f(t)=\langle W^*,\exp(t\xi).u\rangle$ is smooth (the action is linear), and since $\arccos$ is decreasing, minimality of $d(W^*,\cdot)$ at $u$ over $\mathcal O$ makes $t=0$ a global maximum of $f$. Hence $f'(0)=\langle W^*,\xi.u\rangle=0$, so $W^*\perp\mathfrak{so}(n).u=T_u\mathcal O$. This argument uses only smooth curves through $u$ in $\mathcal O$ and needs no manifold structure.

**Orthogonality of $u$ to its own tangent space.** Differentiating $\langle\exp(t\xi).u,\exp(t\xi).u\rangle=1$ at $t=0$ gives $2\langle u,\xi.u\rangle=0$. So $u\perp T_u\mathcal O$.

**The decomposition.** Let $0<\varphi\le0.5748$, so $\sin\varphi>0$. Put $V=(W^*-\cos\varphi\,u)/\sin\varphi$. Then $\langle V,u\rangle=(\cos\varphi-\cos\varphi)/\sin\varphi=0$, and $\|V\|^2=(1-2\cos^2\varphi+\cos^2\varphi)/\sin^2\varphi=1$. For $\tau\in T_u\mathcal O$, $\langle V,\tau\rangle=(\langle W^*,\tau\rangle-\cos\varphi\langle u,\tau\rangle)/\sin\varphi=0$. So $V$ is a unit vector in $u^\perp\cap T_u\mathcal O^\perp$, exactly the hypothesis of Lemma L21, and $W^*=\cos\varphi\,u+\sin\varphi\,V$ as the proof writes.

Every part of item 2 is therefore a consequence of (S2) and (S3). Nothing in it is assumed.

## 4. $\varphi>0$ is a case split, and the other case is closed

$\varphi\in[0,\pi]$ by definition, and $\varphi\le0.5748<\pi$ under the supposition. The only use of $\varphi>0$ is to divide by $\sin\varphi$ in section 3.

**The case $\varphi=0$.** Then $d(W^*,v)=0$ for the nearest $v$, so $\langle W^*,v\rangle=1$ with both unit, hence $W^*=v=h.u$. By invariance of $P$, $\max P=P(W^*)=P(u)=\sqrt{3/2}$, that is $m=1$. The witness of Passage A (for $n\ge12$ a unit Weyl tensor with $P>\sqrt{3/2}$, by the even and odd threshold polynomials $n^2-12n+8$ and $n^2-13n+18$, both positive from $n=12$) gives $\max P>\sqrt{3/2}$, a contradiction. This is the "degenerate branch" paragraph of Passage A, and it is correct.

A second route closes the same case without the split: at $\varphi=0$ the expansion reads $m=\cos^30=1$ for any unit $V\in u^\perp\cap T_u\mathcal O^\perp$ (this space is nonzero, since otherwise Lemma L21's statement would be empty, and in any case $\sin\varphi=0$ removes every term containing $V$), and $m=1$ already satisfies $m\le\psi(0)=1$. So the bound $m\le1$ holds on the whole closed interval $[0,0.5748]$ and the contradiction is uniform.

Either way, $\varphi>0$ is a branch of a proof by cases, not a restriction on the lemma. The phrase "for that condition to be non-vacuous" is slightly off as well: the first-variation condition $W^*\perp T_u\mathcal O$ holds at $\varphi=0$ too (it reads $u\perp T_u\mathcal O$, true by section 3). What fails at $\varphi=0$ is the definition of $V$.

## 5. Arguing the opposite

The step would be valid as written if some admissible reading of the setting left one of the three open. Each candidate fails.

- A non-orthogonal action. The action is conjugation by $\Lambda^2g$, orthogonal, so (S2) holds. An $O(n)$ or $GL(n)$ action is not the one named.
- A distance not invariant. Passage A fixes $d$, and both angle and chord are functions of $\langle X,Y\rangle$ alone.
- An orbit that is not closed, so no nearest point. Orbits of a compact group are compact.
- A nearest point where the orbit is not smooth. Orbit curves $t\mapsto\exp(t\xi).u$ are real-analytic, and the variation uses nothing else.
- A reading in which "the lemma" means the Lean theorem. In [L20Statement.lean](../lean/HamiltonsCubic/Results/L20Statement.lean), tube_exclusion takes the expansion hexp as a hypothesis, so there the three facts enter as an assumption. That is a scope boundary of the formalisation, which models only the real-variable chain. It is not a hypothesis of the mathematical Lemma L20, whose statement in Passage C lists none of the three.

No reading makes any of the three a hypothesis beyond the setting.

## 6. Consequence for the record

- The mathematics of the passage is sound on these points: all three facts hold and are used where Passage A uses them.
- The framing is wrong. Calling them hypotheses "stated here rather than assumed" presents Lemma L20 as conditional on them, which would contradict Passage C's statement, where they do not appear. The consistent reading is that Passage C is right and the sentence misclassifies standard facts.
- The repair is wording only: "Three standard facts are used: $d$ is $SO(n)$-invariant because the action is orthogonal, the orbit is compact so a nearest point exists and the first variation gives $W^*\perp T_u\mathcal O$, and the case $\varphi=0$ is treated separately below." The only conditional input of Lemma L20 remains the eigenvalue bound $\alpha\le\frac13$ of Lemma L21, as Passage C already says.

## 7. Verdict

**FAILS, as written, with no effect on the lemma.** The quoted line, "Three further hypotheses are used and are stated here rather than assumed", classifies as hypotheses three items that are consequences of the setting: invariance of $d$ follows from (S2), the compact orbit, nearest point and first-variation condition follow from (S2) and (S3), and $\varphi>0$ is one branch of a case split (C) whose other branch Passage A closes. The strongest reading, "three facts are used and made explicit", is VALID and needs only (S1), (S2), (S3), which are standard properties of the conjugation action of $SO(n)$ on $\mathcal W_n$.
