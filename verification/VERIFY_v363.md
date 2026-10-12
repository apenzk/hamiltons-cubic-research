# Verifier v363, L115 step F3: whether $\sup_W\lambda_{\max}(M)\le\theta_0$ is strictly stronger than Conjecture A

*Cold brief ([ADJ_L115_F3.md](ADJ_L115_F3.md)). No numerical work, no scripts written, every value exact or quoted from the passages. Log: [agent_logs/verify-L115-v363.log](../agent_logs/verify-L115-v363.log).*

| Claim | Verdict |
|---|---|
| C1. $\sup_W\lambda_{\max}(M)\le\theta_0(n)$ implies $M(n)\le\theta_0(n)$ | CONFIRMED |
| C2. $\sup_W\lambda_{\max}(M)\le\theta_0(n)$ implies Conjecture A, at even $n\ge12$ | CONFIRMED |
| C3. $\sup_W\lambda_{\max}(M)\le\theta_0(n)$ implies Conjecture A, at odd $n\ge13$ | REFUTED AS STATED |
| C4. The $C_5$ blow-up witnesses that Conjecture A does not imply $\sup_W\lambda_{\max}(M)\le\theta_0(n)$ | REFUTED |
| C5. $\sup_W\lambda_{\max}(M)\le\theta_0$ is strictly stronger than Conjecture A | REFUTED AS STATED (strictness is open, and the record's own conjecture in Passage B makes it false at even $n\ge12$) |

**Summary: the implication half holds at even $n\ge12$, but the witness for strictness has $\lambda_{\max}(M)=0.809017$, below $\sqrt{3/2}\le M(n)$ at every $n\ge4$, so it separates nothing, and the step FAILS.**

## 0. Conventions, fixed once

- $\mathcal W_n$, $Q$, $P$, $\theta$, $M(n)$, $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ and "global maximiser" are as in the brief's Definitions. Weyl tensors are read as symmetric operators on $\Lambda^2\mathbb R^n$ with the Frobenius norm, and $\mathcal W_n=0$ for $n\le3$, so $n\ge4$ throughout.
- For unit $W$ with eigenvalues $\lambda$ in an orthonormal eigenframe, $M(W)=M(\lambda)$ is the matrix of Passage B, computed in that frame. Where eigenvalues repeat the frame is a choice, and $\sup_W\lambda_{\max}(M)$ is read as the supremum over unit $W$ and over admissible frames. Nothing below depends on that choice.
- Conjecture A is read from [results.md](../results.md), the one file the brief links that states its constant: line 1377 gives its $n\ge12$ clause as $\sup\{P(W):\lVert W\rVert=1\}=\Theta_n$, and line 98 gives $\Theta_n^2=2(n-1)(n-2)/n^2$ at even $n$ and $\Theta_n^2=2(n-1)(n-3)/((n+1)(n-2))$ at odd $n$. Passage B calls the $n\ge12$ inequality "Conjecture A", so the dimensions the sentence covers are read as $n\ge12$.
- "Strictly stronger" is read in its only precise sense: $S\Rightarrow A$ holds, and $A\Rightarrow S$ fails, meaning some unit Weyl $W$ has $\lambda_{\max}(M(W))>\theta_0(n)$ while $M(n)$ equals the conjectured constant. Here $S$ is the statement $\sup_W\lambda_{\max}(M)\le\theta_0(n)$ and $A$ is Conjecture A.

## 1. Hypothesis inventory

- **H1 (Passage B's identity).** $P(W)=\langle\lambda,M(\lambda)\lambda\rangle$ with $M$ symmetric and $\lVert\lambda\rVert=\lVert W\rVert=1$. Taken as given from the quoted passage, and not re-derived here.
- **H2 (existence of a maximiser).** The unit sphere of $\mathcal W_n$ is compact and $P$ is a continuous cubic, so $M(n)$ is attained at some $W^*$.
- **H3 (lower witness).** $M(n)\ge\Theta_n$, attained at $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$, as [results.md](../results.md) lines 98 and 1377 record. Needed only to turn the upper bound into the equality form of Conjecture A.
- **H4 (padded $W_{\mathbb{CP}^2}$).** $M(n)\ge\sqrt{3/2}$ at every $n\ge4$, a given of the brief.
- **H5 (the $C_5$ blow-up's values).** $\lambda_{\max}(M)=0.809017$ and $\theta=0.670820$ there, as Passage B quotes. These are the record's values and are used only through the inequality $0.809017<1$.
- **H6 (parity).** The implication to Conjecture A needs $n$ even. This is the hypothesis the author may have meant and did not write.

## 2. The implication half, C1 and C2

Let $W^*$ be a global maximiser (H2) with eigenvalues $\lambda^*$ in any eigenframe. By H1 and the Rayleigh principle for the symmetric matrix $M(\lambda^*)$,

$$M(n)=P(W^*)=\langle\lambda^*,M(\lambda^*)\lambda^*\rangle\le\lambda_{\max}\big(M(\lambda^*)\big)\lVert\lambda^*\rVert^2=\lambda_{\max}\big(M(\lambda^*)\big)\le\sup_W\lambda_{\max}(M).$$

So $S$ gives $M(n)\le\theta_0(n)$. This is C1, and it holds at every $n\ge4$ and for every frame choice, since the Rayleigh bound holds in each frame.

At even $n$, $\Theta_n=\theta_0(n)$ by the two formulas in Section 0, so C1 is the upper half of Conjecture A, and H3 supplies the lower half. This is C2.

At $4\le n\le11$ the statement $S$ is false outright, which is consistent with the sentence's scope being $n\ge12$: by the display above and H4, $\sup_W\lambda_{\max}(M)\ge M(n)\ge\sqrt{3/2}$, while $\theta_0(11)^2=180/121<3/2$ and $\theta_0^2=2(1-\tfrac1n)(1-\tfrac2n)$ increases in $n$. At $n=12$, $\theta_0(12)^2=220/144>3/2$.

## 3. Odd $n\ge13$, C3

At odd $n$ the constants differ. Expanding,

$$\theta_0(n)^2-\Theta_n^2=\frac{2(n-1)\big[(n-2)^2(n+1)-n^2(n-3)\big]}{n^2(n+1)(n-2)}=\frac{2(n-1)\big[(n^3-3n^2+4)-(n^3-3n^2)\big]}{n^2(n+1)(n-2)}=\frac{8(n-1)}{n^2(n+1)(n-2)}>0,$$

which is $48/13013$ at $n=13$, matching [results.md](../results.md) line 46. The only route from $S$ to a bound on $M(n)$ is the display of Section 2, and it delivers $M(n)\le\theta_0(n)$. That leaves $M(n)\in(\Theta_n,\theta_0(n)]$ open, which is the negation of Conjecture A's upper half. So at odd $n$, $S$ as posed with $\theta_0$ does not imply Conjecture A. The repair is to pose $S$ at $\Theta_n$, and then Section 2 goes through verbatim at both parities.

**Arguing the opposite.** Could $S$ at odd $n$ reach $\Theta_n$ by some route other than the Rayleigh bound at a maximiser? $S$ constrains only the single number $\sup\lambda_{\max}(M)$, and its only link to $P$ on the passages is $P\le\lambda_{\max}(M)$. No passage bounds $\lambda_{\max}(M)$ below $\theta_0$, so nothing converts $\le\theta_0$ into $\le\Theta_n$. C3 stands as REFUTED AS STATED, and C2 carries hypothesis H6.

## 4. The witness, C4

**The line.** Passage A, line 294: "the $C_5$ blow-up carries ratio $1.206$ while its $\theta$ sits far below $\theta_0$".

**What strictness needs.** For $A\not\Rightarrow S$ one needs a unit Weyl $W$ with $\lambda_{\max}(M(W))>\theta_0(n)$ (Section 0). The quantity that must exceed $\theta_0$ is $\lambda_{\max}(M)$. The sentence instead reports the ratio $\lambda_{\max}(M)/\theta=0.809017/0.670820$ (the quoted $1.206$) and that $\theta$ is small. Neither is the needed quantity.

**Where it fails, exactly.** By H5, $\lambda_{\max}(M)=0.809017$ at the $C_5$ blow-up. By H4 and Section 2, at every $n\ge4$,

$$\lambda_{\max}\big(M(W_{C_5})\big)=0.809017<1<\sqrt{3/2}\le M(n)\le\sup_W\lambda_{\max}(M).$$

The same point is below $\theta_0$ itself at every $n\ge4$: $\theta_0(n)^2\ge\theta_0(4)^2=3/4$ and $0.809017^2<0.81^2=0.6561<3/4$. So the $C_5$ blow-up satisfies $\lambda_{\max}(M)\le\theta_0(n)$ with room, and it is consistent with $S$ at every dimension. It cannot witness $A\not\Rightarrow S$ at any $n$.

**What the point does witness.** $\lambda_{\max}(M(W))>P(W)$ at one critical point that is not a maximiser, that is, the pointwise Rayleigh bound $\theta\le\lambda_{\max}(M)$ is slack there. A large ratio at a point with small $\theta$ is exactly the configuration that cannot push $\sup\lambda_{\max}(M)$ above $M(n)$, because the slack is measured from a value far below the maximum. The heading "slack elsewhere" is correct, and the inference from slack elsewhere to strictness is what fails.

**Arguing the opposite.** A reading that saves C4 would need the ratio $1.206$ to transport: if some point with $\theta$ near $M(n)$ carried the same ratio, $\lambda_{\max}(M)$ there would exceed $\theta_0$. Nothing on the passages gives such a transport. $\lambda_{\max}(M)/P$ is scale-free but it is evaluated at a fixed unit $W$, and at a global maximiser Passage B and Passage A both give $\lambda_{\max}(M)=\theta$ in the cases the record settles (coordinate-diagonal maximisers and $S^m\times S^m$, $m\ge4$), so the ratio there is $1$. C4 is REFUTED.

## 5. Strictness itself, C5

With the witness gone, "strictly stronger" has no support on the passages, and two passages point the other way.

- Passage B conjectures $\sup\lambda_{\max}(M)=\max(\sqrt{3/2},\theta_0(n))$ in general. At even $n\ge12$ that is $\theta_0(n)=M(n)$ under Conjecture A, so under the record's own conjecture $S$ and $A$ are **equivalent** there, the opposite of strict.
- Passage A's next sentence says the equivalent target is the pointwise statement at maximisers. That is a different statement from $S$, so it does not by itself contradict the strictness claim, but it gives no evidence for it.

**The strongest reading the words support** is "a priori stronger": $S\Rightarrow A$ at even $n\ge12$ (Section 2), and the converse is not known, because $\lambda_{\max}(M)$ is a pointwise majorant of $P$ that is slack at some critical points. That reading is correct. It is not what "strictly stronger" asserts, and the $C_5$ blow-up does not upgrade it.

**What would settle strictness, named and not computed.** The exact quantity is $\sup\{\lambda_{\max}(M(W)):W\in\mathcal W_n,\lVert W\rVert=1\}$ against $\theta_0(n)$ at even $n\ge12$. $S$ is strictly stronger than $A$ there iff some unit $W$ has $\lambda_{\max}(M(W))>\theta_0(n)$. One closed-form candidate costs no search: in a fixed eigenframe $M$ is linear in $\lambda$, so $M(-W)=-M(W)$ and $\lambda_{\max}(M(-W))=-\lambda_{\min}(M(W))$. Hence **if $\lambda_{\min}(M(W_0))<-\theta_0(n)$ at the balanced product $W_0=S^{n/2}\times S^{n/2}$, strictness holds**, and if $\lambda_{\min}(M(W_0))\ge-\theta_0(n)$ this candidate decides nothing and the question stays with the supremum. That spectrum is a finite exact object, and this report does not evaluate it.

## 6. The Lean files, Passage D

Neither file touches the step. [L115Statement.lean](../lean/HamiltonsCubic/Results/L115Statement.lean) proves the by-product $\theta\ge\max_\alpha\lambda_\alpha$ from a Rayleigh hypothesis (theta_ge_diag) and a margin under $\theta\ge\sqrt{3/2}$. Its c5_exceeds_nonWeyl_cap compares $0.809017$ with $1/\sqrt2$, not with $\theta_0$. [L115.lean](../lean/HamiltonsCubic/Results/L115.lean) carries dimension counts and two schematic logic facts. No declaration states $S\Rightarrow A$ or $A\not\Rightarrow S$.

## 7. Verdict

**FAILS.** The step asserts two things, and the second fails at the witness named for it.

- **VALID part, with its hypotheses.** $\sup_W\lambda_{\max}(M)\le\theta_0(n)$ implies Conjecture A at **even** $n\ge12$, needing H1 (Passage B's identity $P=\langle\lambda,M\lambda\rangle$ with $\lVert\lambda\rVert=1$), H2 (a global maximiser exists), H3 (the balanced product attains $\Theta_n$) and H6 (even $n$). At odd $n\ge13$ it gives only $M(n)\le\theta_0(n)$, short of $\Theta_n$ by $\theta_0^2-\Theta_n^2=8(n-1)/(n^2(n+1)(n-2))$. Posing the target at $\Theta_n$ repairs both parities.
- **FAILING part.** "Strictly stronger ... the $C_5$ blow-up carries ratio $1.206$ while its $\theta$ sits far below $\theta_0$" (Passage A, line 294). The witness has $\lambda_{\max}(M)=0.809017<1<\sqrt{3/2}\le M(n)$ at every $n\ge4$, so it satisfies the stronger statement and separates nothing. Strictness is open, it would be decided by whether some unit Weyl $W$ has $\lambda_{\max}(M(W))>\theta_0(n)$ at even $n\ge12$ (Section 5 names a closed-form candidate), and Passage B's own conjecture predicts equivalence instead.
