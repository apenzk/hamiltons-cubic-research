# Verifier v362, L115 step F3: whether $\sup_W\lambda_{\max}(M)\le\theta_0$ is strictly stronger than Conjecture A

*Cold brief ([ADJ_L115_F3.md](ADJ_L115_F3.md)). No numerical work was done and no scripts were written. Every value below is exact, or is a decimal quoted from the brief and compared against a rational bound by hand. Log: [agent_logs/verify-L115-v362.log](../agent_logs/verify-L115-v362.log).*

| Claim | Verdict |
|---|---|
| C1. For every unit $W\in\mathcal W_n$, $P(W)\le\lambda_{\max}(M(W))$, so $\sup_W\lambda_{\max}(M)\ge M(n)$ | CONFIRMED |
| C2. $\sup_W\lambda_{\max}(M)\le\theta_0(n)$ implies Conjecture A, at even $n\ge12$ | CONFIRMED |
| C3. $\sup_W\lambda_{\max}(M)\le\theta_0(n)$ implies Conjecture A, at odd $n\ge13$ | REFUTED |
| C4. The Rayleigh bound is slack somewhere: at the $C_5$ blow-up $\lambda_{\max}(M)>\theta$ | CONFIRMED AS ALGEBRA (on the quoted catalogue values) |
| C5. The $C_5$ blow-up witnesses that Conjecture A does not imply $\sup_W\lambda_{\max}(M)\le\theta_0$ | REFUTED |
| C6. The step as written: the target is strictly stronger than Conjecture A, with the $C_5$ blow-up as witness | REFUTED AS STATED |

**Summary: the implication half holds at even $n\ge12$ by the Rayleigh bound, but the witness cannot show strictness because its $\lambda_{\max}(M)=0.809017$ lies below $\theta_0(n)$ at every $n\ge4$, and at odd $n$ the implication half itself fails since Conjecture A's constant is $\Theta_n<\theta_0(n)$. Verdict FAILS.**

## 0. Conventions, fixed once

- $\mathcal W_n$, $Q$, $P$, $\theta$, $M(n)$, $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$, $\lambda$, $c'$ are as in the brief's definitions. $\lVert W\rVert^2=\sum_\alpha\lambda_\alpha^2$, the normalisation under which Passage B writes $\lVert\lambda\rVert=1$ for a unit $W$.
- $M(\lambda)_{\alpha\beta}=\delta_{\alpha\beta}\lambda_\alpha+\tfrac12\sum_\gamma c'^2_{\alpha\beta\gamma}\lambda_\gamma$, formed at any unit $W$ in any orthonormal eigenbasis of $W$ (Passage B, [second-order.md](../findings/second-order.md) lines 532-548).
- "Conjecture A" is read from [results.md](../results.md), which the brief links. Its $n\ge12$ clause (results.md lines 11 and 1377) is $\sup\{P(W):\lVert W\rVert=1\}=\Theta_n$, with $\Theta_n=\theta_0(n)$ at even $n$ and $\theta_0(n)^2-\Theta_n^2=\tfrac{8(n-1)}{n^2(n+1)(n-2)}>0$ at odd $n\ge13$ (results.md lines 46 and 1377). Passage B uses the $\theta_0$ form ("$M(n)\le\ldots=\theta_0(n)$, which is Conjecture A"). Both readings are treated below.
- "The target" is $T_n$: $\sup_{W}\lambda_{\max}(M(W))\le\theta_0(n)$, the supremum over unit $W\in\mathcal W_n$ and over the choice of eigenbasis. "Strictly stronger" is read in its logical sense: $T_n\Rightarrow A_n$ and $A_n\not\Rightarrow T_n$, where $A_n$ is Conjecture A at $n$.

## 1. Hypothesis inventory

- H1. The identity $P(W)=\langle\lambda,M(\lambda)\lambda\rangle$ holds at every unit $W$, critical or not. Passage B states it before criticality enters, and it is a direct expansion of $\sum_\alpha\lambda_\alpha^3+\tfrac12\sum c'^2_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$ once $\langle W,W^\#\rangle=\tfrac12\sum c'^2_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$ is granted, which the passage asserts and this step takes as given.
- H2. $\lVert W\rVert=1$ gives $\sum_\alpha\lambda_\alpha^2=1$ (convention of Section 0).
- H3. $M$ is symmetric (Passage B: $c'^2$ symmetric in its first two indices).
- H4. The supremum in $T_n$ ranges over eigenbasis choices as well as over $W$, or over any fixed selection of basis. The argument of Section 2 holds for every choice, so the ambiguity at repeated eigenvalues is harmless.
- H5. The dimension range. The sentence names none. Passage B places the comparison at $n\ge12$, and Section 3 shows $T_n$ is false below that.
- H6. The constant. $A_n$ at $\theta_0(n)$ agrees with the record's Conjecture A only at even $n$.
- H7. The quoted catalogue values at the $C_5$ blow-up, $\lambda_{\max}(M)=0.809017$ and $\theta=0.670820$, are taken as data. Their provenance is numerical and is outside this step.

## 2. The implication half at even $n$

By H1 to H3, for every unit $W$ and every eigenbasis, $P(W)=\langle\lambda,M\lambda\rangle\le\lambda_{\max}(M)\langle\lambda,\lambda\rangle=\lambda_{\max}(M)$, the Rayleigh inequality for a symmetric matrix. Taking suprema, $M(n)=\sup_W P(W)\le\sup_W\lambda_{\max}(M(W))$. This is C1.

If $T_n$ holds then $M(n)\le\theta_0(n)$. At even $n\ge12$ the balanced product $S^{n/2}\times S^{n/2}$ attains $\theta_0(n)$ (Passage B, "with equality at the balanced sphere product", and results.md line 1377 on the lower half), so $M(n)=\theta_0(n)=\Theta_n$, which is $A_n$. This is C2, valid under H1 to H5.

## 3. Below $n=12$ the target is false, so the sentence cannot be about those dimensions

Padded $W_{\mathbb{CP}^2}$ gives $M(n)\ge\sqrt{3/2}$ at every $n\ge4$. $\theta_0(n)^2\ge\tfrac32$ is $4(n-1)(n-2)\ge3n^2$, that is $n^2-12n+8\ge0$, whose positive root is $6+2\sqrt7$, strictly between $11$ and $12$ since $(2\sqrt7)^2=28$ lies between $25$ and $36$. So for $4\le n\le11$, $\sup_W\lambda_{\max}(M)\ge M(n)\ge\sqrt{3/2}>\theta_0(n)$ and $T_n$ is false. There the record's Conjecture A is not asserted in the $\theta_0$ form, so the comparison is empty and H5 is forced: $n\ge12$.

## 4. The implication half fails at odd $n\ge13$

Quoted line (Passage A): "So $\sup_W\lambda_{\max}(M)\le\theta_0$ (B3's target as posed), is **strictly stronger than Conjecture A**".

At odd $n\ge13$, $T_n$ yields through Section 2 only $M(n)\le\theta_0(n)$. Conjecture A there is $M(n)=\Theta_n$ with $\Theta_n<\theta_0(n)$ by the closed form $\theta_0^2-\Theta_n^2=8(n-1)/(n^2(n+1)(n-2))$, positive at every $n\ge13$. So $T_n$ is compatible with $\Theta_n<M(n)\le\theta_0(n)$, which negates $A_n$. $T_n$ does not imply $A_n$. This is C3.

**The opposite argued.** If "Conjecture A" is read as the $\theta_0$ inequality $M(n)\le\theta_0(n)$, as Passage B writes it, then Section 2 gives $T_n\Rightarrow A_n$ at every $n\ge12$. That reading is available from Passage B alone, but results.md line 1377 records it as refuted at odd $n$, where the $\theta_0$ form "asserted Conjecture A's own negation". The step survives at odd $n$ only against a superseded statement of the conjecture, or with $\theta_0$ replaced by $\Theta_n$ in the target.

## 5. The witness does not witness strictness

Quoted line (Passage A): "the $C_5$ blow-up carries ratio $1.206$ while its $\theta$ sits far below $\theta_0$".

**What strictness requires.** $A_n\not\Rightarrow T_n$ between two fixed propositions can only be shown by exhibiting $T_n$ false while $A_n$ is not refuted, that is a unit $W\in\mathcal W_n$, $n\ge12$, with $\lambda_{\max}(M(W))>\theta_0(n)$. A point where $\lambda_{\max}(M)$ exceeds $P$ but stays below $\theta_0$ is consistent with $T_n$ and says nothing against it.

**Where the $C_5$ blow-up sits.** Its quoted value is $\lambda_{\max}(M)=0.809017$ (Passage B). At every $n\ge4$ this is below $\theta_0(n)$:

- $n=4$: $\theta_0(4)^2=\tfrac{12}{16}=\tfrac34$, and $0.809017^2<0.81^2=0.6561<0.75$.
- $n=5$: $\theta_0(5)^2=\tfrac{24}{25}>\tfrac34$.
- $n\ge6$: $\theta_0(n)^2>1$ iff $n^2-6n+4>0$ iff $n>3+\sqrt5$, true at $n\ge6$, and $0.809017<1$.

So $\lambda_{\max}(M)<\theta_0(n)$ at the $C_5$ blow-up at whatever dimension $n\ge4$ it was measured, and in particular it is below $\sqrt{3/2}<\theta_0(n)$ at every $n\ge12$. The witness satisfies $T_n$'s inequality. This is C5.

**The ratio is the wrong comparison.** $1.206$ is consistent with the quotient $0.809017/0.670820$, a comparison of $\lambda_{\max}(M)$ against the point's own $\theta$. What it establishes is C4, that the Rayleigh bound of Section 2 is not an equality at every critical point. A pointwise gap $\lambda_{\max}(M)-P>0$ at a point far below the maximum leaves $\sup\lambda_{\max}(M)$ and $\sup P$ free to coincide, and the heading the sentence sits under says exactly that: "tight where it matters and slack elsewhere".

**The record's own data point the other way.** Passage B's ascent reports $\sup\lambda_{\max}(M)=\max(\sqrt{3/2},\theta_0(n))$ at $n=6,8,10$ and proposes it in general. At $n\ge12$ that value is $\theta_0(n)$, which would make $T_n$ true at even $n\ge12$. If $A_n$ is also true there, $T_n$ and $A_n$ have the same truth value and neither is strictly stronger in the logical sense. Nothing on the brief's record exhibits a point with $\lambda_{\max}(M)>\theta_0(n)$ at $n\ge12$.

**The Lean files.** Neither quoted file formalises this step. The declaration closest in subject, c5_exceeds_nonWeyl_cap, proves $1/\sqrt2<0.809017$, a comparison with a different constant.

## 6. The opposite argued, the strongest reading

**Reading R.** "Strictly stronger" means that $T_n$ bounds a function $\lambda_{\max}(M(W))$ that dominates $P(W)$ everywhere (C1) and strictly exceeds it somewhere (C4), so a proof of $T_n$ would have to control more than $P$, and $T_n$ is a priori harder than the pointwise statement at maximisers.

Under R, with H1 to H7 and with Conjecture A read at even $n\ge12$ (or with $\Theta_n$ in place of $\theta_0$ at odd $n$), every ingredient holds: the implication is Section 2 and the slack is C4. R is a statement about the difficulty of a proof route, and the words support it as a motivation. It does not support the word "strictly" in its logical sense, nor the colon that presents the $C_5$ blow-up as the reason, because domination with a strict gap somewhere does not make the supremum strictly larger (Section 5). R is the most the sentence can carry, and it is weaker than what the sentence says.

## 7. Verdict

**FAILS.** The step fails at the quoted clause "is **strictly stronger than Conjecture A**: the $C_5$ blow-up carries ratio $1.206$ while its $\theta$ sits far below $\theta_0$", in two places.

- The strictness half: the $C_5$ blow-up has $\lambda_{\max}(M)=0.809017<\theta_0(n)$ at every $n\ge4$ (Section 5), so it satisfies the target and cannot separate it from Conjecture A. A separating witness would be a unit $W\in\mathcal W_n$, $n\ge12$, with $\lambda_{\max}(M(W))>\theta_0(n)$, and none is on the record.
- The implication half at odd $n\ge13$: the target gives $M(n)\le\theta_0(n)$ only, while Conjecture A's constant is $\Theta_n<\theta_0(n)$ (Section 4).

**What is valid, and what it needs.** "$\sup_W\lambda_{\max}(M)\le\Theta_n$ implies Conjecture A at every $n\ge12$, and the Rayleigh bound behind it is slack at the $C_5$ blow-up, so the target is a priori a stronger demand than the conjecture" is VALID under H1 (the identity $P=\langle\lambda,M\lambda\rangle$ at every unit $W$, resting on $\langle W,W^\#\rangle=\tfrac12\sum c'^2\lambda\lambda\lambda$), H2 (the normalisation $\sum\lambda_\alpha^2=1$), H3 (symmetry of $M$), H4 (the supremum over basis choices), H5 ($n\ge12$), the balanced-product lower bound for the equality form, and H7 (the quoted catalogue values). Whether the target is strictly stronger in the logical sense is open, and would be decided by the value of $\sup_W\lambda_{\max}(M(W))$ against $\Theta_n$ at some $n\ge12$, which is a computation this brief excludes.
