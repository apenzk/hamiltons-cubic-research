# Verifier v340, L111 step D7: only the off-diagonal entries of M can bring the Jacobi identity into a bound on D

Cold brief ([ADJ_L111_D7.md](ADJ_L111_D7.md)). No numerical work was done and no scripts were written. Every value below is exact and every step is a hand argument. Log: [agent_logs/verify-L111-v340.log](../agent_logs/verify-L111-v340.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | $M_{kl}=-\sum_{ab}\lambda_a\lambda_b c_{kab}c_{lab}=-2(W^\#)_{kl}$, so the diagonal entries of $M$ depend on the bracket data only through $T=c^2$ | CONFIRMED AS ALGEBRA |
| 2 | With $v$ a member of the eigenbasis, $D(v)$ depends on the bracket data only through $T$, and at a critical point it equals $\lambda_{\min}(\theta-\lambda_{\min})-(n-2)\lambda_{\min}\lambda_{\max}$ | CONFIRMED AS ALGEBRA |
| 3 | The off-diagonal entries of $M$ are the only entries of $M$ that change under a sign flip of individual structure constants | CONFIRMED |
| 4 | A bound on $D$ derived from the diagonal entries, sign-blind relations and the Jacobi identity holds under the weaker hypothesis that $T$ lies in the shadow $T(\mathcal J)$ of the Jacobi set, so only the off-diagonal entries can couple to the sign-sensitive content of Jacobi | CONFIRMED |
| 5 | The Jacobi identity shares no degree-two monomial with any entry of $M$, off-diagonal ones included | CONFIRMED |
| 6 | Unqualified reading: no consequence of the Jacobi identity can reach a bound on $D$ built on the diagonal entries | REFUTED AS STATED |
| 7 | Step D7 under hypotheses H1, H2, H3 | VALID |

**Summary: the step is valid as a statement about the sign-sensitive content of the Jacobi identity, which only the off-diagonal entries of $M$ can see, and it overreaches if read as saying the diagonal entries are closed to every consequence of Jacobi, because Jacobi has sign-blind consequences for $T=c^2$ that a diagonal-only bound may use.**

## 0. Conventions, fixed once

- $\{\varphi_k\}$ is an orthonormal eigenbasis of $W$ on $\Lambda^2\cong\mathfrak{so}(n)$, $W\varphi_k=\lambda_k\varphi_k$, $N=\binom n2$.
- $c_{abc}=\langle[\varphi_a,\varphi_b],\varphi_c\rangle$ is totally antisymmetric, $T_{abc}=c_{abc}^2$ is totally symmetric and vanishes on a repeated index (Passage B, conventions line 61).
- $(\mathrm{ad}\,\varphi_k)_{ba}=\langle[\varphi_k,\varphi_a],\varphi_b\rangle=c_{kab}$.
- $(W^\#)_{ab}=\tfrac12\sum c_{acd}c_{bef}W_{ce}W_{df}$, with the $\tfrac12$ (conventions line 77). In the eigenbasis $(W^\#)_{kl}=\tfrac12\sum_{ab}\lambda_a\lambda_b c_{kab}c_{lab}$.
- Critical point: $Q(W)=W^2+W^\#=\theta W$ (conventions line 151).
- Per-index relations (A), (B), (C) as in Passage B, sums over ordered pairs.
- $D(v)=\tfrac12\sum_{a,b}(\lambda_a\lambda_b-\lambda_{\min}\lambda_{\max})c_{vab}^2$ (L70, bounds line 216).
- The sign-flip group $G=\{\pm1\}^{\binom N3}$ acts on antisymmetric tensors by $(\varepsilon\cdot c)_{abc}=\varepsilon_{\{abc\}}c_{abc}$, one sign per unordered triple. It is an abstract symmetry of polynomial relations in the variables $c$, and is realised by no change of basis in general.
- $\mathcal J$ is the set of totally antisymmetric $c$ satisfying the Jacobi identity, and $T(\mathcal J)=\{c^2:c\in\mathcal J\}$ its shadow.

## Hypothesis inventory

- **H1 (what "the Jacobi identity enters" means).** Jacobi enters through the off-diagonal entries in the sense of its sign-sensitive content, the part of $\mathcal J$ that is lost on passing to $G\cdot\mathcal J$. Its sign-blind consequences, the conditions defining $T(\mathcal J)$, are counted as $T$-level relations beside (A), (B), (C), not as an entry of $M$. The words "same variables $c_{k\alpha\beta}$" and the contrast with the sign-blind diagonal entries support this reading. Without H1 the step fails (Section 5).
- **H2 ($v$ is a basis vector).** $v$ is a unit $\lambda_{\min}$-eigenvector chosen as a member of the eigenbasis, which the boxed L70 formula requires. For $v=\sum_k v_k\varphi_k$ spread over a degenerate $\lambda_{\min}$-eigenspace, $c_{vab}^2$ carries cross terms $v_kv_lc_{kab}c_{lab}$ and $D(v)$ itself touches off-diagonal entries.
- **H3 (scope of "only").** "Only" ranges over the entries of $M$, as the brief's statement of the step says. Other sign-sensitive relations exist outside $M$, for instance the off-diagonal Killing relations $\sum_{ab}c_{kab}c_{lab}=0$ for $k\ne l$, and the step makes no claim about them. The bound is derived in the variables $(\lambda,\theta,c)$.
- **"Can" is read as possibility.** The step asserts that the off-diagonal entries are not closed to Jacobi, and it asserts no strict improvement of any bound. The same standard is applied to the diagonal channel in Section 5.

## 1. The entries of $M$ in bracket coordinates

$M_{kl}=\operatorname{tr}(\mathrm{ad}\varphi_k\,W\,\mathrm{ad}\varphi_l\,W)=\sum_{a,b}(\mathrm{ad}\varphi_k)_{ab}\lambda_b(\mathrm{ad}\varphi_l)_{ba}\lambda_a=\sum_{a,b}c_{kba}c_{lab}\lambda_a\lambda_b=-\sum_{a,b}\lambda_a\lambda_b c_{kab}c_{lab}$.

By Section 0 this is $-2(W^\#)_{kl}$, matching Mmat in [L111Statement.lean](../lean/HamiltonsCubic/Results/L111Statement.lean) as quoted in the brief. Criticality gives $(W^\#)_{kl}=\lambda_k(\theta-\lambda_k)\delta_{kl}$, so $M_{kl}=2\lambda_k(\lambda_k-\theta)\delta_{kl}$.

- Diagonal: $M_{kk}=-\sum_{ab}\lambda_a\lambda_bT_{kab}$, a function of $T$ alone. It is relation (C).
- Off-diagonal: $M_{kl}=-\sum_{ab}\lambda_a\lambda_bc_{kab}c_{lab}$ with $k\ne l$. The triples $\{k,a,b\}$ and $\{l,a,b\}$ are distinct, so each monomial is a product of two different variables and is not a function of $T$.

Claim 1 holds.

## 2. $D$ in the same currency

Under H2, $c_{vab}^2=T_{vab}$ and $D(v)=\tfrac12\sum_{ab}\lambda_a\lambda_bT_{vab}-\tfrac12\lambda_{\min}\lambda_{\max}\sum_{ab}T_{vab}$.

By (C) at $k=v$ the first sum is $\lambda_{\min}(\theta-\lambda_{\min})$, and by (A) the second is $(n-2)\lambda_{\min}\lambda_{\max}$. So $D(v)=\lambda_{\min}(\theta-\lambda_{\min})-(n-2)\lambda_{\min}\lambda_{\max}$, and dividing by $\lambda_{\min}<0$ returns the boxed L70 formula. A bound on $D$ at a critical point is therefore a bound on $\theta$ in terms of the spectrum. Claim 2 holds.

If H2 is dropped, $c_{vab}=\sum_kv_kc_{kab}$ and $D(v)$ contains $\sum_{k\ne l}v_kv_l\sum_{ab}(\lambda_a\lambda_b-\lambda_{\min}\lambda_{\max})c_{kab}c_{lab}$, which is sign-sensitive. That is why H2 is named.

## 3. Sign-flip invariance separates the entries

For $\varepsilon\in G$, $(\varepsilon\cdot c)^2=c^2$. Hence $D(v)$ (under H2), (A), (B) and every diagonal entry of $M$ are $G$-invariant.

An off-diagonal relation $\sum_{ab}\lambda_a\lambda_bc_{kab}c_{lab}=0$ is not $G$-invariant whenever it has a nonzero term: flipping the sign of the single triple $\{k,a_0,b_0\}$ negates exactly the terms $(a,b)=(a_0,b_0),(b_0,a_0)$ and changes the sum by $-4\lambda_{a_0}\lambda_{b_0}c_{ka_0b_0}c_{la_0b_0}$. Claim 3 holds.

## 4. The invariance lemma

**Lemma.** Let $R$ be any set of $G$-invariant relations in $(\lambda,\theta,c)$, containing the diagonal entries of $M$. Let $\Phi(\lambda,\theta,T)$ be any statement, for instance a bound on $D$. If $\Phi$ holds on $R\cap\mathcal J$, then $\Phi$ holds on $R\cap G\cdot\mathcal J$, and $G\cdot\mathcal J=\{c:c^2\in T(\mathcal J)\}$.

**Proof.** Two antisymmetric tensors have the same square exactly when they agree up to one sign per triple, so $G\cdot\mathcal J=\{c:c^2\in T(\mathcal J)\}$. Take $c\in R\cap G\cdot\mathcal J$ and write $c=\varepsilon\cdot c'$ with $c'\in\mathcal J$. Every relation in $R$ is invariant, so $c'\in R\cap\mathcal J$ and $\Phi$ holds at $c'$. $\Phi$ reads only $T$, and $c^2=c'^2$, so $\Phi$ holds at $c$. $\square$

So a bound on $D$ that uses the diagonal entries of $M$ with the Jacobi identity uses Jacobi only through the sign-blind condition $c^2\in T(\mathcal J)$.

**The off-diagonal entries escape the lemma.** With the set $O$ of off-diagonal relations added, the conclusion transfers only to $G\cdot(O\cap\mathcal J)$, and $G\cdot(O\cap\mathcal J)\subseteq G\cdot O\cap G\cdot\mathcal J$ requires one and the same $\varepsilon$ to carry a tensor into both sets. That joint requirement is sign-sensitive information that no $G$-invariant relation records. Among the entries of $M$ only the off-diagonal ones supply it (Section 3). This is Claim 4 and it is the step under H1 and H3.

**Argued the opposite.** Could a diagonal-only derivation still exploit the signs through some other route? Only through a relation that is not $G$-invariant. Under H3 the derivation lives in $(\lambda,\theta,c)$, the non-invariant members of $M$ are its off-diagonal entries, and $D$ is invariant under H2. A route through the embedding of the $\varphi_k$ in $\Lambda^2\mathbb R^n$ (the first Bianchi identity written with the 2-forms themselves) leaves these variables and is outside the step.

## 5. What the step does not deliver

**5.1 Direct contraction.** The Jacobi identity for a metric Lie algebra with totally antisymmetric $c$ is the vanishing, for distinct $x,y,z,w$, of

$$J_{xyzw}=\sum_e\big(c_{xye}c_{zwe}+c_{yze}c_{xwe}+c_{zxe}c_{ywe}\big),$$

since $\langle[[x,y],z],w\rangle=\langle[x,y],[z,w]\rangle$ by invariance. With a repeated index the expression vanishes identically: for $w=x$, $\langle[[x,y],z],x\rangle+\langle[[z,x],y],x\rangle=\langle[x,y],[z,x]\rangle-\langle[z,x],[x,y]\rangle=0$, and the other coincidences follow by antisymmetry in $x,y,z$. A nonzero monomial $c_{xye}c_{zwe}$ needs $e\notin\{x,y,z,w\}$, so its two triples share exactly one index. The monomials of $M_{kl}$ pair triples sharing two indices ($k\ne l$) or three ($k=l$). The supports are disjoint, so no linear combination of the relations of $M$ with Jacobi instances cancels anything at degree two. The off-diagonal entries meet Jacobi only after multiplication to degree four or higher. Claim 5 holds, and the step's "place" is the sign-sensitivity of Section 4, not a shared contraction.

**5.2 The unqualified reading fails.** Read without H1, the step says the diagonal entries admit no consequence of the Jacobi identity. That needs $T(\mathcal J)$ to impose nothing, and it does impose something.

- **Exact witness that the shadow is proper.** Take $n=5$, $N=10$. Put $T_{123}=3$, and on labels $4,\dots,10$ put $T=1$ on the seven lines of a Fano plane, zero elsewhere. The tensor $c$ with $c_{123}=\sqrt3$ and $c=\pm1$ on Fano lines with octonion signs is totally antisymmetric and satisfies the full Killing relation $\sum_{ab}c_{kab}c_{lab}=6\delta_{kl}=2(n-2)\delta_{kl}$. Each Fano point lies on three lines, two distinct lines share one point, and no triple mixes the blocks.
- **No sign choice satisfies Jacobi.** Label the Fano lines $\{1,2,4\},\{2,3,5\},\{3,4,6\},\{4,5,7\},\{5,6,1\},\{6,7,2\},\{7,1,3\}$ within the block. For $(x,y,z,w)=(1,2,3,6)$ the three families contribute exactly one nonzero term each: $e=4$ via lines $\{1,2,4\},\{3,4,6\}$, $e=5$ via $\{2,3,5\},\{5,6,1\}$, $e=7$ via $\{7,1,3\},\{6,7,2\}$. Each term is $\pm1$, and a sum of three numbers $\pm1$ is odd, so $J_{1236}\ne0$ for every choice of signs. Hence this $T$ lies in the shadow of the Killing-normalised antisymmetric tensors and outside $T(\mathcal J)$.
- **Consequence.** "$c^2\in T(\mathcal J)$" is a genuine sign-blind consequence of Jacobi, absent from the record's list (A), (B), (C), which Passage B credits only to the Killing form, Ricci-flatness and criticality. A bound on $D$ may conjoin it with the diagonal entries and no off-diagonal entry. Under the possibility standard applied to the off-diagonal entries, Jacobi can therefore enter through the diagonal channel. Claim 6 is REFUTED AS STATED.

**5.3 Whether the diagonal channel changes a bound needs computation.** The witness above fails (B) for every nonzero spectrum: on the $\mathfrak{so}(3)$ block (B) forces $\lambda_1+\lambda_2+\lambda_3=0$ and then $\lambda_1=0$, and on the Fano block it forces $\lambda_k=-\sigma$ for all seven points with $\sigma=7\lambda_k$, so $\lambda=0$. It shows $T(\mathcal J)$ is proper, not that it is proper inside the (A), (B), (C) system. At $n=4$ it is not: for $\lambda=a(2,-1,-1,0,0,0)$, $\theta=3a$ (a critical self-dual spectrum, (C) checked at every $k$), rows $k=1,2,3$ of (A), (B), (C) force $t_{123}=2$ and every mixed triple to vanish, and row $k=4$ of (A) then forces $t_{456}=2$, which is the realisable $T$. The question that decides the literal reading in effect is exact: for a fixed spectrum $\lambda$, compare $\theta_{\mathrm{rel}}^{\min}(\lambda)$, the least $\theta$ for which some $T\ge0$, totally symmetric and zero on repeats, satisfies (A), (B), (C) at every $k$, with $\theta_{\mathcal J}^{\min}(\lambda)$, the same infimum over $T\in T(\mathcal J)$. Since $D$ is decreasing in $\theta$ (Section 2, $\lambda_{\min}<0$), a strict gap at some $n\ge5$ means the diagonal channel alone carries Jacobi into an upper bound on $D$, and equality for all $\lambda$ means the shadow is redundant there. The step's VALID reading does not depend on the answer.

## 6. Verdict

**VALID**, under the reading that the off-diagonal entries are the only entries of $M$ through which the sign-sensitive content of the Jacobi identity can reach a bound on $D$. The reading needs:

- **H1:** Jacobi's sign-blind shadow $c^2\in T(\mathcal J)$ is counted with the $T$-level relations and not as Jacobi entering through an entry of $M$.
- **H2:** $v$ is a member of the eigenbasis, so $D(v)$ is a function of $T$.
- **H3:** "only" ranges over the entries of $M$, with the bound derived in the variables $(\lambda,\theta,c)$.

The proof is the sign-flip lemma of Section 4 with Sections 1 to 3. Two limits stand beside the verdict. The unqualified reading fails because $T(\mathcal J)$ is a proper, sign-blind consequence of Jacobi (Section 5.2). The off-diagonal entries share no degree-two monomial with the Jacobi identity, so they are a place Jacobi can enter by sign-sensitivity and not by direct contraction (Section 5.1).
