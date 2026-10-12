# Verifier v375, the witness sentence of Lemma L20 (step G1, round L20-r2)

Cold brief [ADJ_L20r2_G1.md](ADJ_L20r2_G1.md). No numerical work was done and no scripts were written. Every value below is an exact rational or an exact polynomial identity checked by hand. Log: [agent_logs/verify-L20-v375.log](../agent_logs/verify-L20-v375.log).

| Claim | Verdict |
|---|---|
| G1 at even $n\ge12$: the balanced sphere product is a unit Weyl operator with $P=\theta_0(n)>\theta^*$ | CONFIRMED (given the brief's definition of $\Theta_n$) |
| G1 at odd $n\ge13$: the balanced sphere product is a unit Weyl operator with $P=\theta_0(n)$ | REFUTED AS STATED |
| At odd $n$, $\theta_0(n)^2-\Theta_n^2=\dfrac{8(n-1)}{n^2(n-2)(n+1)}>0$, equal to $48/13013$ at $n=13$ | CONFIRMED AS ALGEBRA |
| Repaired witness: a two-factor sphere product with $P=\Theta_n>\theta^*$ exists at every $n\ge12$ | CONFIRMED (given the brief's definition of $\Theta_n$) |
| Lemma L20's conclusion, conditional on L21, survives the repair | CONFIRMED |

**Summary: the step FAILS as written at every odd $n\ge13$, because no two-factor sphere product attains $\theta_0(n)$ there, but Passage A's own witness $\Theta_n$ repairs it and the lemma's conclusion is untouched.**

## 0. Conventions, fixed once

- $\theta^*=\sqrt{3/2}$, $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$, both positive.
- $\Theta_n$ is the value of $P$ on the best two-factor sphere product, normalised to a unit Weyl operator: $\Theta_n=\theta_0(n)$ at even $n$, and $\Theta_n^2=\frac{2(n-1)(n-3)}{(n-2)(n+1)}$ at odd $n$, with $\Theta_n>0$. This is the brief's definition, taken as given.
- "Best" means that every two-factor sphere product on $\mathbb R^n$, normalised to unit norm, has $P\le\Theta_n$. This is the content of the word in the definition.
- The balanced sphere product is $S^k\times S^k$ with $n=2k$. It exists as a product of two equal-dimensional spheres only at even $n$.
- $P$ is a cubic form, so $P(W/\lvert W\rvert)=P(W)/\lvert W\rvert^3$ for $W\ne0$. Every comparison of positive values is made on their squares.

## 1. Hypothesis inventory

- H1. The brief's formula for $\Theta_n$ at both parities, including that at even $n$ the best split is the balanced one with value $\theta_0(n)$.
- H2. The sphere product's Weyl tensor is nonzero, so it normalises to a unit Weyl operator. This holds for $S^p\times S^q$ with $p,q\ge2$, which covers every split in question at $n\ge12$.
- H3. "Best" in H1 is a maximum over all two-factor sphere products at that $n$, so nothing in that family exceeds $\Theta_n$.
- H4 (repair only). The witness the contradiction uses is any unit Weyl operator with $P>\theta^*$, as Passage A's proof line 133 states.

## 2. The step, located

Passage C, detail entry, [results.md](../results.md) line 1065: "forces $\max P\le\theta^*$, contradicting the value $\theta_0(n)>\theta^*$ the sphere product attains." The sentence governs "For every $n\ge12$" in the same entry. Passage C's landscape line 321 says only "the sphere product's larger value" and carries no formula.

Passage A, [findings/route-a.md](../findings/route-a.md) line 133, already disagrees with it: "at odd $n$ the balanced sphere product is not one, it does not exist. The witness is the best split: $\Theta_n^2=\frac{2(n-1)(n-3)}{(n-2)(n+1)}$ at odd $n$."

## 3. Even $n\ge12$: the step holds

By H1 and H2 the balanced product $S^{n/2}\times S^{n/2}$ normalises to a unit Weyl operator with $P=\theta_0(n)$. Then $\theta_0(n)^2>3/2$ is $4(n-1)(n-2)>3n^2$, that is $n^2-12n+8>0$. At $n=12$ the left side is $8$, and for $n\ge6$ it increases since its derivative is $2n-12\ge0$. So $\theta_0(n)>\theta^*$ at every even $n\ge12$. This matches `even_threshold` and `thresholds_positive` in [L20Statement.lean](../lean/HamiltonsCubic/Results/L20Statement.lean) as the brief quotes them.

## 4. Odd $n$: the step fails, in closed form

**The balanced product does not exist.** At odd $n$ there is no $k$ with $n=2k$, so "the balanced sphere product" names no object. Passage A says the same.

**No reading of "sphere product" attains $\theta_0(n)$.** The strongest reading takes "balanced" to mean the best split available at odd $n$. By H1 its value is $\Theta_n$, and by H3 no two-factor sphere product exceeds it. The difference of squares is

$$\theta_0(n)^2-\Theta_n^2=2(n-1)\left[\frac{n-2}{n^2}-\frac{n-3}{(n-2)(n+1)}\right]=\frac{2(n-1)\left[(n-2)^2(n+1)-n^2(n-3)\right]}{n^2(n-2)(n+1)}.$$

Expanding, $(n-2)^2(n+1)=(n^2-4n+4)(n+1)=n^3-3n^2+4$ and $n^2(n-3)=n^3-3n^2$, so the bracket is exactly $4$ and

$$\theta_0(n)^2-\Theta_n^2=\frac{8(n-1)}{n^2(n-2)(n+1)}>0\quad\text{for every }n\ge3.$$

So at every odd $n$ the value the step assigns strictly exceeds the largest value any two-factor sphere product attains, and $P=\theta_0(n)$ is false for every member of the family.

**The object at $n=13$.** $\theta_0(13)^2=\frac{2\cdot12\cdot11}{169}=\frac{264}{169}$ and $\Theta_{13}^2=\frac{2\cdot12\cdot10}{11\cdot14}=\frac{120}{77}$. Over the common denominator $169\cdot77=13013$ these are $\frac{20328}{13013}$ and $\frac{20280}{13013}$, a gap of $\frac{48}{13013}$. The general formula gives $\frac{8\cdot12}{169\cdot11\cdot14}=\frac{96}{26026}=\frac{48}{13013}$, which agrees. The kernel-checked `thirteen_witness` in [OddWitness.lean](../lean/HamiltonsCubic/Results/OddWitness.lean) fixes $\Theta_{13}^2=120/77$, the value the step overstates.

## 5. The opposite argued

- **A different operator could attain $\theta_0(n)$.** The unit sphere of $\mathcal W_n$ is connected and $P$ is continuous, so every value in $[\min P,\max P]$ is attained. A unit Weyl operator with $P=\theta_0(13)$ therefore exists exactly when $\max P\ge\theta_0(13)$. The passages do not decide that inequality, and such an operator would in any case be something other than the sphere product the sentence names. This reading supplies no witness the record can point to.
- **Padding the even product from $n-1$.** A Weyl tensor on $\mathbb R^{n-1}$ extended by zero is Ricci-free on $\mathbb R^n$ and keeps $\lvert W\rvert$, $\langle W,W^2\rangle$ and $\langle W,W^\#\rangle$, since its image lies in the subalgebra $\mathfrak{so}(n-1)$. It yields $P=\theta_0(n-1)$. Since $\theta_0(n)^2=2(1-\frac1n)(1-\frac2n)$ increases strictly in $n$, this is strictly less than $\theta_0(n)$ and does not rescue the stated value.
- **The step as a harmless typo.** The contradiction in Passage A needs only some unit Weyl operator with $P>\theta^*$, so the wrong value does not break the lemma. It does make the sentence false at every odd $n\ge13$, which is what the brief asks about.

## 6. The repair, and what survives

Replace the sentence's witness with $\Theta_n$: "contradicting the value $\Theta_n>\theta^*$ the best two-factor sphere product attains." By H1 to H3:

- Even $n\ge12$: $\Theta_n=\theta_0(n)>\theta^*$ by Section 3.
- Odd $n\ge13$: $\Theta_n^2>3/2$ is $4(n-1)(n-3)>3(n-2)(n+1)$, that is $4n^2-16n+12>3n^2-3n-6$, that is $n^2-13n+18>0$. At $n=13$ the left side is $18$, and it increases for $n\ge7$ since its derivative is $2n-13>0$. So $\Theta_n>\theta^*$ at every odd $n\ge13$.

Every $n\ge12$ is covered. The bootstrap in Passage A then gives $\max P\ge\Theta_n>\theta^*$ against $\max P\le\theta^*$ inside the tube, so Lemma L20's conclusion stands under the same condition as before, the eigenvalue input of Lemma L21. The first sentence of the detail entry, $\theta_0(n)>\theta^*$ exactly when $n>6+2\sqrt7$, is correct as a statement about $\theta_0$ and needs no change.

## 7. Verdict

**FAILS.** The step "at every $n\ge12$ the balanced sphere product is a unit Weyl operator with $P=\theta_0(n)>\theta^*$" is true at even $n$ under H1 and H2, and false at every odd $n\ge13$: the balanced product does not exist, and every two-factor sphere product has $P\le\Theta_n$ with $\theta_0(n)^2-\Theta_n^2=\frac{8(n-1)}{n^2(n-2)(n+1)}>0$, the gap being $\frac{48}{13013}$ at $n=13$. The defect is confined to the witness's stated value in [results.md](../results.md) line 1065. Substituting $\Theta_n$, as Passage A already does, gives a valid step at every $n\ge12$ under H1 to H4, and Lemma L20's conclusion is unaffected.
