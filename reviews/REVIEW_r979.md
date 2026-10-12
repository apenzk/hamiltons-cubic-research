# r979: does R28's rung hand down exactly on the commuting stratum?

Reviewer r979, Gate 2, brief [BRIEF_R28_commuting.md](BRIEF_R28_commuting.md). Log: [agent_logs/r979-commuting.log](../agent_logs/r979-commuting.log).

**Headline.** The block's algebra is right and its consequence is wrong. Claims 2 and 3 are correct and I can prove claim 5 outright, replacing the $k=3,4$ screen with a theorem that holds at every $k$ and at every critical point. But the equivalence is an equivalence for VERTEX-optimality, and the rung consumes `Splits`, which is the record's own two-sided block condition and is strictly weaker than being a permutation matrix. Off the commuting stratum there is no vertex maximiser and there can still be a SPLITTING one, so the rung's real obligation is not the node's target and the coupled hull is still the right object.

## Verdicts

| # | claim | kind | verdict |
|---|---|---|---|
| 1 | The value is $\langle R,A_1\rangle+\langle S,A_2\rangle$, linear in the coupled pair jointly | mathematics | CONFIRMED |
| 2 | Signed permutations are the ONLY orthogonal matrices whose entrywise square is a permutation matrix | mathematics | CONFIRMED, and orthogonality is not used |
| 3 | $R$ and $S$ can be simultaneously permutation matrices only when $G$ is a signed permutation | mathematics | CONFIRMED for vertices, and FALSE for splittings |
| 4 | $G$ is a signed permutation iff $\hat U$ and $C$ share an eigenframe, iff $[\hat U,C]=0$ | mathematics | REFUTED as an iff at fixed frames, CONFIRMED under simple spectra |
| 5 | The maximum is attained at a splitting frame exactly when $[\hat U,C]=0$ | mathematics | REFUTED as stated, CONFIRMED and PROVED in the vertex reading |
| 6 | Hence once $[\hat U,C]=0$ the rung needs only Birkhoff, with no face, tangency or second-order input | a reduction | CONFIRMED, with four hypotheses named below |
| 7 | Hence R28 owes nothing separate at general $\lvert J\rvert$, and work on the coupled hull is misdirected | about a route | REFUTED |

## Notation, fixed once

$\hat U$ and $C$ are real symmetric $k\times k$, $P\in O(k)$ has columns $p_1,\dots,p_k$, and $\tilde U=P^{\mathsf T}\hat UP$, $\tilde C=P^{\mathsf T}CP$. Write $a_j=\beta\nu_j^2$, $b_j=\nu_j$, $D_a=\operatorname{diag}(a)$, $D_b=\operatorname{diag}(b)$, so that the quoted frame dependence is $f(P)=\operatorname{tr}(D_a\tilde U)+\operatorname{tr}(D_b\tilde C)$. $E$ and $F$ are the fixed eigenframes, $\hat U=E\Lambda E^{\mathsf T}$ with $\Lambda=\operatorname{diag}(\lambda)$ and $C=FMF^{\mathsf T}$ with $M=\operatorname{diag}(\mu)$, and $G=E^{\mathsf T}F$.

## Claim 1: CONFIRMED

$p_j^{\mathsf T}\hat Up_j=\sum_i\lambda_iR_{ij}$ with $R=(E^{\mathsf T}P)^{\circ2}$, and likewise for $C$ with $S$, so $f(P)=\langle R,A_1\rangle+\langle S,A_2\rangle$ with $(A_1)_{ij}=\lambda_i\beta\nu_j^2$ and $(A_2)_{ij}=\mu_i\nu_j$. Two remarks the block does not make and that matter later.

- **Both cost matrices are rank one**, being $\lambda a^{\mathsf T}$ and $\mu b^{\mathsf T}$. Under commuting the collapsed cost is $\lambda a^{\mathsf T}+\mu b^{\mathsf T}$, of rank at most two, so the rearrangement inequality does not close the collapsed problem and Birkhoff really is the tool claim 6 needs.
- **The functional is linear on the pair, and the pair is not free.** $S=(G^{\mathsf T}E^{\mathsf T}P)^{\circ2}$ is determined by the same $P$, so the image is a $\dim O(k)$-dimensional set inside $B_k\times B_k$ and "linear in the coupled pair jointly" is a statement about the functional, never about the feasible set. This is the exact point at which a convex-hull argument on the pair loses information, and the block is right to flag it.

The single-matrix cost in [I106bFace.lean](../lean/HamiltonsCubic/Results/I106bFace.lean), $A_{ik}=\beta\nu_k^2u_i+\nu_kc_i$, is precisely $A_1+A_2$ under $E=F$, which is a useful consistency check on the collapse claim 6 asserts.

## Claim 2: CONFIRMED, and the orthogonality hypothesis is dead weight

If $Q^{\circ2}$ is a permutation matrix then every entry satisfies $Q_{ij}^2\in\{0,1\}$, so $Q_{ij}\in\{0,\pm1\}$, and the support of $Q$ is the support of a permutation matrix. Hence $Q$ is a signed permutation. The converse is immediate. **Orthogonality is never used**, and since signed permutations are orthogonal, the block's sentence is true but states a strictly weaker fact than the one available. The honest form is: a real matrix whose entrywise square is a permutation matrix is a signed permutation.

**It is one line, and I confirm it, so per the brief it becomes an obligation.** The mathematical content is $x^2=1\Rightarrow x=\pm1$ together with $x^2=0\Rightarrow x=0$ over $\mathbb R$, both single Mathlib rewrites (`mul_self_eq_one_iff` after `sq`, and `pow_eq_zero_iff`, which [I106bFace.lean](../lean/HamiltonsCubic/Results/I106bFace.lean) already uses in `trace_image_eq_zero_iff`). The real cost in Lean is the DEFINITION of a signed permutation matrix, which the base layer does not carry, not the proof. Budget it as a definition plus a short proof, rather than as one line.

## Claim 3: CONFIRMED for vertices, and the splitting analogue is FALSE

For vertices the block is right and the proof is two lines. $R$ a permutation matrix forces $Q_1=E^{\mathsf T}P$ to be a signed permutation by claim 2, $S$ a permutation matrix forces $Q_2=F^{\mathsf T}P$ likewise, and then $G=E^{\mathsf T}P\,P^{\mathsf T}F=Q_1Q_2^{\mathsf T}$ is a signed permutation. **There is no second mechanism to look for**, which is what the brief asked me to probe: claim 2 has no hypothesis to evade, so each factor's vertex-ness independently pins its own matrix, and the coupling is then forced by cancellation of $P$. The converse also holds: if $G$ is a signed permutation, $P=E\Sigma$ makes both vertices at once.

**What is false is the same statement with "splitting" in place of "permutation matrix"**, and that is the statement the rung consumes. See claim 5.

## Claim 4: REFUTED as an iff at fixed frames, CONFIRMED under simple spectra

- Forward, always true: $G$ a signed permutation gives $F=EG$ and $C=E(GMG^{\mathsf T})E^{\mathsf T}$ with $GMG^{\mathsf T}$ diagonal, so $E$ diagonalises both and $[\hat U,C]=0$.
- Backward, false at fixed frames. $E$ and $F$ are determined only up to the stabiliser of the spectrum, so when either spectrum is degenerate, $G$ depends on a choice that $[\hat U,C]=0$ does not fix. Take $\hat U=I_2$ and $C=\operatorname{diag}(1,2)$, $F=I$ and $E$ the rotation by $30^\circ$. Then $[\hat U,C]=0$ and $G=E^{\mathsf T}$ is not a signed permutation.

**Correction to adopt.** State it as "$[\hat U,C]=0$ iff $G=E^{\mathsf T}F$ is a signed permutation for SOME choice of eigenframes", or add simple spectra as a hypothesis, under which eigenvectors are pinned up to sign and ordering and the iff holds for every choice. This does not damage the reduction, because claim 6 only needs the existential direction, but the block states the universal one.

## Claim 5: REFUTED as stated, and PROVED in the vertex reading

The claim needs "splitting frame" pinned down, and the two available readings give opposite answers. [I106bFace.lean](../lean/HamiltonsCubic/Results/I106bFace.lean) defines `Splits` as a two-sided block condition, a proper nonempty row set and an equinumerous column set with the matrix vanishing on $\mathcal R\times\mathcal C^{\mathsf c}$ and on $\mathcal R^{\mathsf c}\times\mathcal C$. **Every permutation matrix splits and the converse fails badly**, so vertex-optimality is strictly stronger than splitting-optimality.

### The vertex reading is a theorem, not four data points

**Lemma (r979).** On $O(k)$, $P$ is a critical point of $f$ iff $[D_a,\tilde U]+[D_b,\tilde C]=0$, entrywise $(a_i-a_j)\tilde U_{ij}+(b_i-b_j)\tilde C_{ij}=0$ for $i\neq j$. If in addition the $\nu_i$ are pairwise distinct and $\tilde U$ is diagonal, then $\tilde C$ is diagonal and $[\hat U,C]=0$.

*Proof.* Vary $P\mapsto Pe^{tX}$ with $X$ antisymmetric. Then $\frac{d}{dt}\operatorname{tr}(D_ae^{-tX}\tilde Ue^{tX})\big|_{0}=\operatorname{tr}([D_a,\tilde U]X)$, and the same for the second term, and both commutators are antisymmetric, so criticality is the displayed identity. If $\tilde U$ is diagonal, every off-diagonal entry gives $(b_i-b_j)\tilde C_{ij}=0$ with $b_i-b_j=\nu_i-\nu_j\neq0$, so $\tilde C$ is diagonal. Then $P$ diagonalises both matrices and they commute. $\square$

This settles the vertex reading of claim 5 in both directions and improves on the block in four ways. It holds at **every** $k$, not $k=3$ and $k=4$. It holds at **every critical point**, so a fortiori at every local maximum, not only at the global one. It needs **no numerics**. And it isolates the hypothesis the block never states, namely that $\nu$ is pairwise distinct. The forward direction is the block's own Birkhoff argument and is sound: $[\hat U,C]=0$ lets $E=F$ be chosen, so $R=S$ and $f$ is linear in a single orthostochastic matrix, whose maximum over $X_k$ equals its maximum over $\operatorname{conv}(X_k)=B_k$, attained at a permutation matrix, which lies in $X_k$ by the given inclusion $\Pi_k\subseteq X_k$.

**The distinctness hypothesis is necessary, not decorative.** With $\nu_1=\nu_2$ the value is invariant under rotations of the $(p_1,p_2)$ plane and the converse fails. Take $k=3$, $\hat U=\operatorname{diag}(A,10)$ and $C=\operatorname{diag}(B,0)$ with $A=\operatorname{diag}(1,-1)$ and $B$ the $2\times2$ swap, $\beta=1$ and $\nu=(1,1,2)$. The value collapses to $\text{const}+(a_3-a_1)p_3^{\mathsf T}\hat Up_3+(b_3-b_1)p_3^{\mathsf T}Cp_3$, maximised at the top eigenvector of $3\hat U+C$, which is $e_3$, and $p_1,p_2$ are then free in $e_3^{\perp}$. Choosing them to be eigenvectors of $\hat U$ makes $R$ the identity, a vertex, at a global maximum of value $40$, while $\lVert[\hat U,C]\rVert=2.83$.

### The record's own reading is refuted, with $\nu$ pairwise distinct

Run the lemma's computation with $\tilde U$ merely BLOCK diagonal rather than diagonal, which is what `Splits` gives. For $i$ and $j$ in different blocks, $\tilde U_{ij}=0$ forces $\tilde C_{ij}=0$, so $\tilde C$ is block diagonal with the same blocks. That is simultaneous BLOCK diagonalisation, and it does not imply commuting.

**Counterexample.** $k=3$, $\hat U=\operatorname{diag}(A,10)$ and $C=\operatorname{diag}(B,0)$ as above, $\beta=1$, and $\nu=(0.5,1.3,2.0)$, pairwise distinct. The global maximum over $O(3)$ is $41.64730082$ and is attained at $P=\operatorname{diag}(P_2,1)$. There $R$ splits with row set $\{3\}$ and column set $\{3\}$, $S$ splits with row set $\{2\}$ and column set $\{3\}$, **neither is a permutation matrix**, $G$ is not a signed permutation, and $\lVert[\hat U,C]\rVert=2.83$. Both members of the coupled pair split simultaneously, off the commuting stratum, which also refutes the splitting analogue of claim 3.

So the "exactly when" of claim 5 is true for vertex-optimality and false for the property the rung actually consumes.

## Claim 6: CONFIRMED, with four hypotheses the block does not state

Granting claims 1 to 5, once $[\hat U,C]=0$ the pair collapses to a single orthostochastic matrix and Birkhoff alone delivers a vertex maximiser, which splits. No face, no tangency, no second-order condition. The reduction is sound in this direction, and it is **not vacuous**: the target sentence is open on the record, so this is a reduction to something unproved rather than to something already known. What it quietly assumes:

- **$\hat U$ and $C$ symmetric.** The value sees only symmetric parts, so the commutator that must vanish is $[\operatorname{sym}\hat U,\operatorname{sym}C]$. For non-symmetric data $[\hat U,C]=0$ does not deliver the collapse.
- **Neither matrix depends on $P$.** The target is phrased "at every global maximum", which implies the data varies over whatever space the maximum is taken in. If that dependence is on $\nu$ alone, the collapse still runs at the maximiser's $\nu$. If $\hat U$ or $C$ depends on the frame, $f$ stops being linear in $R$ and Birkhoff does not apply at all.
- **A common eigenframe must be CHOSEN.** $R$ and $S$ are defined with the register's fixed $E$ and $F$, and by claim 4 commuting does not make that particular $G$ a signed permutation when a spectrum is degenerate. The collapse is available, but only after re-choosing the frames.
- **Existence, not universality.** Birkhoff gives that SOME maximiser is a vertex. When the collapsed rank-two cost $\lambda a^{\mathsf T}+\mu b^{\mathsf T}$ has ties, non-splitting maximisers coexist, and in the extreme case $A_1+A_2=0$ every frame is a maximiser. The node's target quantifies over EVERY global maximum, so the two statements meet only in the existential form.

One further transfer the block does not discharge: the rung's conclusion lands the maximiser on the split locus, and the previous rung's hypothesis then has to be available there. That is inherited from the rung structure rather than created by this block, but "the rung needs no face argument" is not the same as "the rung is complete".

## Claim 7: REFUTED

"R28 owes nothing separate at general $\lvert J\rvert$" holds only if the rung's obligation is vertex-optimality. It is not. [I106bFace.lean](../lean/HamiltonsCubic/Results/I106bFace.lean) states the obligation as `face_hands_down`, that a maximum attained at a zero-diagonal $Q$ is also attained at a splitting one, and the file is explicit that the weaker splitting statement is the one the induction consumes. My counterexample under claim 5 exhibits a non-commuting pair with $\nu$ pairwise distinct whose global maximiser splits on both members of the coupled pair. **On the complement of the commuting stratum the rung's obligation is live and can be satisfied**, so the coupled hull and the face are exactly the right objects there, and that complement is where the node's difficulty sits.

The block's own strongest correct statement is the reverse of what it draws. By claim 3, off the commuting stratum no frame makes the pair simultaneously vertex, so any argument aiming at a VERTEX maximiser has an empty target there and cannot be repaired by convexity. That is a real result and it should be recorded: it tells the programme to stop chasing vertex-optimality off the commuting stratum. It does not tell the programme to stop working the face, because splitting is available where vertex-ness is not.

**Net effect on the route.** R28 is subsumed on the commuting stratum, where it becomes a corollary of the node's target rather than a route to it, and it is untouched off that stratum. Batch 21 and the face work should be judged on whether they reach `Splits`, never on whether they reach a vertex.

## Lean obligations this round creates

| item | status |
|---|---|
| A real matrix whose entrywise square is a permutation matrix is a signed permutation | confirmed by r979, typeable, and now owed. Needs a signed-permutation definition the base layer lacks |
| $G$ a signed permutation implies $[\hat U,C]=0$ | one line via `Matrix.commute` once eigenframes are typed, as the brief says |
| The criticality identity $[D_a,\tilde U]+[D_b,\tilde C]=0$ | typeable only once $O(k)$ and differentiation on it exist in the layer, which they do not. State it, do not attempt it |
| The block-diagonal strengthening, that criticality plus block-diagonal $\tilde U$ plus distinct $\nu$ gives block-diagonal $\tilde C$ | the algebraic half is typeable as a statement about matrices with no manifold content, and it is the useful half |

## Screens

Seconds of compute on objects constructed for the purpose, reported as screens and never as evidence for a positive claim. Every control is an assertion. The positive claims above rest on the Lemma and on the two counterexamples, both of which are exact by construction and were only checked numerically.

- **A**, $k=3,4$, generic data: the criticality residual at a numerical maximiser is at most $2.9\times10^{-7}$, which asserts my derivation of the first-order condition.
- **B**, $k=3,4$, six trials, $\nu$ pairwise distinct and non-commuting data: no maximiser diagonalises either matrix, consistent with the Lemma.
- **C**: the $\nu_1=\nu_2$ counterexample reaches the global maximum $40$ at a vertex frame with $\lVert[\hat U,C]\rVert=2.83$.
- **D**: the same data with $\nu=(1,1.3,2.0)$ beats that frame, $39.31$ against $40.75$, which asserts that the distinctness hypothesis is what does the work.
- **E**, commuting pair, $\nu$ distinct, $k=4$: the maximiser diagonalises both to $1.9\times10^{-6}$, the forward direction of claim 5.
- **F**: the splitting counterexample, global maximum $41.64730082$ at the block frame, with a general `Splits` checker over all equinumerous row and column set pairs, controlled by asserting that a permutation matrix splits and a generic orthostochastic matrix does not.
