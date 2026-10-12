# Review r98, four claims about cubic invariants of algebraic Weyl tensors

Independent audit. Every number below comes from my own implementation in [scripts/reviewers/r98/lib98.py](../scripts/reviewers/r98/lib98.py), [kron.py](../scripts/reviewers/r98/kron.py) and [claimD.py](../scripts/reviewers/r98/claimD.py), written from the brief's definitions alone. No project code was imported.

## Verdicts

| Claim | Verdict |
|---|---|
| A, $\alpha=8\operatorname{tr}(M^3)$, $\beta=2\langle M^\#,M\rangle$ | **CONFIRMED**, and true on a strictly larger space than claimed |
| B, bi-spectral identity, Li's convention | **CONFIRMED**, sign included; the $s=0$ specialisation is legitimate |
| C, $\beta=\tfrac12\alpha$ exactly for $n\le5$, with constant $-64$ | **CONFIRMED** in every part, including "only for $n\le5$" |
| D, fence-posts post F2g is wrong at $n=5$ | **CONFIRMED**; the gap is a quantifier inversion, and the conclusion is unrepairable |

## Sampler: is it spanning?

Samples are built as `weyl_part(proj_bianchi(proj_S2Lam2(gaussian)))`, with the Weyl part taken by the Kulkarni–Nomizu subtraction $W=R-\frac{1}{n-2}(\mathrm{Ric}_0\owedge g)-\frac{s}{2n(n-1)}(g\owedge g)$. All five defining constraints hold to $<5\times10^{-16}$ at $n=4,\dots,7$.

Rank of the sample set against $\dim\mathcal W_n$, with $\dim+30$ samples:

| $n$ | 4 | 5 | 6 | 7 |
|---|---|---|---|---|
| $\dim\mathcal W_n$ | 10 | 35 | 84 | 168 |
| rank | 10 | 35 | 84 | 168 |

Spanning at every $n$ tested. No identity below is riding on a deficient sample.

## Claim A, CONFIRMED, and stronger than stated

On unit-norm samples, $\max|\alpha-8\operatorname{tr}M^3|$ and $\max|\beta-2\langle M^\#,M\rangle|$ are $\le8\times10^{-16}$ at $n=4,\dots,8$, against invariant scales of order $10^{-1}$ to $2$.

Two remarks that sharpen the claim.

- $\alpha=8\operatorname{tr}(M^3)$ is combinatorics, not geometry: the all-index sum runs over three antisymmetric pairs, each contributing a factor 2 relative to the $i<j$ sum.
- Neither identity uses the first Bianchi identity or trace-freeness. I re-tested on a general algebraic curvature tensor with nonzero Ricci (residuals $0$ and $4\times10^{-14}$) and on a general element of $S^2(\Lambda^2)$ with no Bianchi symmetry at all (residuals $1.6\times10^{-14}$ and $1.8\times10^{-15}$, at invariant scales $1.3$ and $15.1$). **Claim A holds on all of $S^2(\Lambda^2\mathbb R^n)$.** Stating it only on $\mathcal W_n$ understates it.

Hamilton's sharp was implemented with the structure constants of the *unnormalised* basis $\phi_{ij}=E_{ij}-E_{ji}$, exactly as the brief specifies. That convention is the one Claim A validates; the orthonormal basis $\phi_{ij}/\sqrt2$ would halve $M^\#$ and break $\beta=2\langle M^\#,M\rangle$. Worth keeping explicit, since it is a factor-of-2 trap. In the pair-orthonormal indexing $c$ is totally antisymmetric (checked: deviation exactly $0$), so $T_{abc}=c_{abc}^2$ is totally symmetric, used in the Claim D analysis below.

## Claim B, CONFIRMED

With $(\mathring Wh)_{ij}=\sum_{kl}W_{iklj}h_{kl}$ and $\|M\|_F=1$:

- $\operatorname{tr}(\mathring W^2)=3.000000$ at $n=4,\dots,8$, on random samples and at every named point.
- $\theta-\big(\tfrac32\operatorname{tr}M^3-\tfrac12\operatorname{tr}\mathring W^3\big)$ is $\le4\times10^{-16}$ throughout.

I computed $\operatorname{tr}(\mathring W^{m})$ two ways, over an orthonormal basis of the whole of $S^2$, and over an explicit orthonormal basis of $S^2_0$, and they agree to machine precision. That is expected and worth recording as a convenience: for trace-free $W$, $\mathring W(g)_{ij}=\sum_kW_{ikkj}=-\mathrm{Ric}_{ij}=0$, so $g$ lies in the kernel and the $S^2$ and $S^2_0$ traces of every positive power coincide.

**The sign is right, and it is load-bearing.** At $n=6$ on one sample, $\operatorname{tr}(\mathring W^3)=+0.124916$ with the order $iklj$ and $-0.124916$ with $ikjl$ or $kilj$; only $iklj$ reproduces $\theta=-0.166863$. The order $ijkl$ gives $\operatorname{tr}(\mathring W^2)=0$ and is not the operator at all. Li's (2.2) as quoted in the brief is the correct reading.

### Is the $s=0$ specialisation of Dai–Fu Lemma 3.3 legitimate?

Yes, and I tested it rather than assuming it. I built Einstein algebraic curvature tensors $R=W+\frac{s}{2n(n-1)}(g\owedge g)$ at $s=0,\,1,\,-2.3$ for $n=4,5,6$ and evaluated both halves of the lemma with $\mathring R$ restricted to $S^2_0$:

$$\operatorname{tr}\mathring R^3=-\beta+\tfrac18\alpha+\tfrac{s^3}{n^3},\qquad \operatorname{tr}\mathring R^2=\tfrac34|R|^2-\tfrac{s^2}{n^2}.$$

All 18 checks pass with residuals $\le2.8\times10^{-14}$ against invariant scales of order $1$ to $70$. **The lemma is a pointwise algebraic identity on Einstein algebraic curvature tensors; the differential hypothesis in Dai–Fu's statement is packaging, not content.** Setting $s=0$ and taking $W$ purely algebraic is legitimate.

Chaining: with $s=0$ and Claim A, $\operatorname{tr}\mathring W^3=-2\langle M^\#,M\rangle+\operatorname{tr}M^3$, so $\tfrac32\operatorname{tr}M^3-\tfrac12\operatorname{tr}\mathring W^3=\operatorname{tr}M^3+\langle M^\#,M\rangle=\theta$. Claim B is exactly Claim A plus Lemma 3.3, as advertised.

### Named points

Built from the vertex matrix: $W$ coordinate-diagonal, $W_{ijij}=\Lambda_{ij}$, $\Lambda$ hollow symmetric with zero row sums. I generated $\Lambda$ by taking the Weyl part of the genuine $S^p\times S^q$ curvature tensor and confirmed it is coordinate-diagonal, hollow, and row-sum-zero.

| point | $n$ | $\theta$ | $\theta_0(n)=\frac{\sqrt{2(n-1)(n-2)}}{n}$ | Claim B residual |
|---|---|---|---|---|
| $S^2\times S^2$ | 4 | 0.86602540 | 0.86602540 | 0 |
| $S^3\times S^3$ | 6 | 1.05409255 | 1.05409255 | $2\times10^{-16}$ |
| $S^4\times S^4$ | 8 | 1.14564392 | 1.14564392 | 0 |
| $S^2\times S^3$ | 5 | 0.94280904 | 0.97979590 | $2\times10^{-16}$ |
| $S^2\times S^4$ | 6 | 0.96824584 | 1.05409255 | 0 |
| $S^3\times S^4$ | 7 | 1.09544512 | 1.10656667 | $2\times10^{-16}$ |
| $S^2\times S^5$ | 7 | 0.97979590 | 1.10656667 | $2\times10^{-16}$ |
| $\mathbb{CP}^2$ | 4 | 1.22474487 | $\sqrt{3/2}=1.22474487$ | $2\times10^{-16}$ |

The balanced products hit $\theta_0(n)$ exactly; the unbalanced ones fall below it, consistent with balance being the maximiser within the family. $\mathbb{CP}^2$ was built as $M=\lambda(2\omega_1\omega_1^{\mathsf T}-\omega_2\omega_2^{\mathsf T}-\omega_3\omega_3^{\mathsf T})$ on the self-dual $\Lambda^+$ frame with $\lambda=1/\sqrt6$; all five Weyl constraints came out at exactly $0$, the $\Lambda^2$-spectrum is $(0.816497,0,0,0,-0.408248,-0.408248)$, i.e. $(2,-1,-1,0,0,0)/\sqrt6$, and the anti-self-dual variant gives the same $\theta$.

$\operatorname{tr}(\mathring W^2)=3$ at every one of these points.

## Claim C, CONFIRMED in all three parts

**Diagonal.** $\max|\beta-\tfrac12\alpha|$ over 12 unit-norm samples:

| $n$ | 4 | 5 | 6 | 7 | 8 |
|---|---|---|---|---|---|
| $\max|\beta-\alpha/2|$ | $1.6\times10^{-15}$ | $6.0\times10^{-16}$ | $2.6\times10^{-1}$ | $1.6\times10^{-1}$ | $1.1\times10^{-1}$ |
| $\max|\theta-3\operatorname{tr}M^3|$ | $3.3\times10^{-16}$ | $2.5\times10^{-16}$ | $1.3\times10^{-1}$ | $7.9\times10^{-2}$ | $5.3\times10^{-2}$ |

Holds at $n=4,5$; fails at $n=6,7,8$ by margins fourteen orders of magnitude above the noise floor, on samples of full rank $84$ at $n=6$ and $168$ at $n=7$. Both halves of "and ONLY for $n\le5$" are verified.

**Trilinear.** Evaluated on three independent unit-norm arguments $A,B,C$: the symmetrised forms give $\beta_s-\tfrac12\alpha_s$ equal to $5.6\times10^{-17}$ at $n=4$, $1.4\times10^{-17}$ at $n=5$, and $3.9\times10^{-3}$ / $5.0\times10^{-2}$ at $n=6,7$. **One observation the brief's framing obscures: the raw contractions $\alpha(A,B,C)$ and $\beta(A,B,C)$ are already fully symmetric** (raw and symmetrised values agree to $10^{-16}$ at every $n$) so no symmetrisation is actually needed to state Claim C as a trilinear identity. And in characteristic zero a cubic form determines its polarisation uniquely, so "as an identity of symmetric trilinear forms, not merely on the diagonal" carries no extra content beyond the diagonal statement. The test passes; the emphasis is unnecessary.

**The constant $-64$.** I implemented $\delta^{a_1\cdots a_6}_{b_1\cdots b_6}$ as $\sum_{\sigma\in S_6}\mathrm{sgn}(\sigma)\prod\delta$, i.e. 720 signed six-index contractions, with no reference to any project code.

| $n$ | GKD | $\beta-\alpha/2$ | ratio |
|---|---|---|---|
| 4 | $-5.6\times10^{-15}$ | $7.2\times10^{-16}$ | (both zero) |
| 5 | $-4.3\times10^{-15}$ | $-1.1\times10^{-16}$ | (both zero) |
| 6 | $-1.24535405$ | $+0.019458657$ | $-64.000000$ |
| 7 | $-6.04173277$ | $+0.094402075$ | $-64.000000$ |

The constant is $-64$ to all printed digits at both dimensions where the quantity is nonzero, and the identity also holds in trilinear form ($\mathrm{GKD}_s+64\,(\beta-\alpha/2)_s$ is $4\times10^{-16}$ at $n=6$, $4\times10^{-15}$ at $n=7$). Vanishing for $n\le5$ is immediate: the symbol is antisymmetric in six upper indices ranging over $n$ values.

The claimed mechanism therefore stands as a complete proof of Claim C. The fence-post is $n\le5$ / $n\ge6$, and its source is the rank of $\mathbb R^n$ against a degree-6 antisymmetriser.

## Claim D, CONFIRMED: post F2g is false at $n=5$, and the gap is a quantifier inversion

[findings/fence-posts.md](../findings/fence-posts.md) post F2g concludes: *"for $n\ge5$ the collapse space contains nothing $\mathfrak{so}(n)$ can realise, and the cubic is never spectral"*, with the stated driver being that $\mathrm{Weyl}_n$ is $O(n)$-irreducible for $n\ge5$ (one trace condition) versus reducible at $n=4$ (two).

**Direct refutation.** At $n=5$, on random spanning samples, $\langle M^\#,M\rangle/\operatorname{tr}(M^3)=2.000000$ and $\theta=3\operatorname{tr}(M^3)$ to $2.5\times10^{-16}$. The cubic *is* a function of the $\Lambda^2$-spectrum alone at $n=5$. For contrast, the same ratio at $n=6$ is $2.763441$ and varies from sample to sample.

**The mechanism 2g names is falsified, not merely the conclusion.** I computed $T_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle^2$ in the actual $M$-eigenframe at $n=5$ ($N=10$, so 120 triples). It is emphatically non-constant: values run from $1\times10^{-6}$ to $0.747$ with standard deviation $0.131$. Yet $\sum_{\alpha<\beta<\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma=2e_3(\lambda)$ holds to $6\times10^{-16}$. So a non-constant, genuinely $\mathfrak{so}(5)$-realised $T$ collapses the cubic. 2g's "constant $T$ is never realised" is true and irrelevant.

**Where exactly the argument goes wrong.** Two of 2g's three ingredients survive scrutiny:

- Its $\lambda$-space assumption is correct at $n=5$. I computed the Jacobian of the spectrum map $\mathcal W_5\to\mathbb R^{10}$ at a generic point over all 35 basis directions: **rank 9**. Realisable spectra fill an open subset of the full traceless hyperplane, so "one global trace condition" is exactly right.
- Its collapse-space computation is correct as linear algebra. Fixing $T_1$ from one $W\in\mathcal W_5$ and feeding it the spectrum $\lambda_2$ of a *different* $W$ gives $\sum T_1\lambda_2\lambda_2\lambda_2=-0.004531$ against $2e_3(\lambda_2)=0.059474$, a deviation of $6.4\times10^{-2}$. Against a freely chosen traceless $\lambda$ the deviation is $5.9\times10^{-1}$. So indeed no fixed non-constant $T$ satisfies the identity for all traceless $\lambda$.

What fails is the step joining them. 2g solves

$$\exists\,T\ \ \forall\lambda\ \text{traceless}:\ \textstyle\sum T\lambda\lambda\lambda=\kappa\,e_3(\lambda),$$

finds the solution set one-dimensional, and concludes no collapse. But the collapse of $\theta$ requires only

$$\forall W\in\mathcal W_n:\ \textstyle\sum T(W)\,\lambda(W)\lambda(W)\lambda(W)=\kappa\,e_3(\lambda(W)),$$

a condition on the *graph* of the map $W\mapsto(\lambda(W),T(W))$. $T$ is the bracket tensor read in the eigenframe of $W$, so it co-varies with $\lambda$; the two quantifiers cannot be exchanged. The brief's suggested reading is right in spirit but slightly misplaced: the realisable $\lambda$ are *not* a proper subvariety at $n=5$, they are open in the hyperplane. The proper subvariety is in the $(\lambda,T)$ product, and it is $T$'s dependence on the frame that supplies the slack.

**Repairable, or false?** The conclusion is false and cannot be repaired, since Claim C proves collapse at $n=5$ by an independent route. Three specific corrections:

1. The table in 2g lists $N=6,7,9$. The dimensions in play are $N=\binom n2$: $6$ at $n=4$, $\mathbf{10}$ at $n=5$, $15$ at $n=6$. **No row of the table corresponds to $n=5$ at all**, the case the conclusion turns on was never computed. The "at every $N\ge4$" extrapolation is from three points that skip it.
2. The proposed driver (the number of irreducible $O(n)$ summands of $\mathrm{Weyl}_n$), is refuted as a criterion. $\mathrm{Weyl}_5$ is irreducible and collapses anyway. The $\mathfrak{so}(4)$ chirality splitting is a sufficient mechanism at $n=4$, not the reason.
3. The correct statement replacing 2g's headline: **the collapse holds exactly for $n\le5$, and the mechanism is the vanishing of $\delta^{a_1\cdots a_6}_{b_1\cdots b_6}$ below rank 6**, via $\mathrm{GKD}(W,W,W)=-64(\beta-\tfrac\alpha2)$. This is dimension-of-the-underlying-space, not representation theory of $\mathrm{Weyl}_n$, and it explains both dimensions at once instead of special-casing $n=4$.

The salvageable content of 2g is narrow: it is a correct computation of $\{T:\sum T\lambda\lambda\lambda\equiv\kappa e_3\}$ for fixed $T$, and it correctly observes that constant $T$ is unrealisable. Neither fact bears on whether $\theta$ is spectral.

## Corrections to carry forward

1. Claim A should be stated on $S^2(\Lambda^2\mathbb R^n)$, not on $\mathcal W_n$. Bianchi and trace-freeness are unused.
2. Claim A is convention-sensitive: $M^\#$ must use $c$ from the unnormalised $\phi_{ij}=E_{ij}-E_{ji}$. The orthonormal basis halves $M^\#$.
3. Dai–Fu Lemma 3.3 is algebraic at every $s$, verified at $s=0,1,-2.3$ for $n=4,5,6$. The $s=0$ reduction needs no defence.
4. Claim C's "as an identity of symmetric trilinear forms, not merely on the diagonal" is redundant, polarisation over $\mathbb Q$ is determined by the diagonal, and $\alpha,\beta$ are symmetric before any symmetrisation.
5. Post F2g needs replacing, not patching. Its table omits $n=5$ entirely, and its irreducibility driver is falsified there.
6. The fence-post for the spectral collapse is $n\le5$ versus $n\ge6$, sourced to $\delta^{a_1\cdots a_6}_{b_1\cdots b_6}=0$ for $n\le5$.


---

## Synthesis carried in REVIEW.md

### Reviewer 98: the same four claims, on an identical brief

Full report: [reviews/REVIEW_r98.md](reviews/REVIEW_r98.md). Own projector, all five constraint residuals below $5\times10^{-16}$; sampler spans $\mathcal W_n$ exactly at $n=4$–$7$. **All four claims CONFIRMED**, agreeing with 97 on every verdict.

**Four things 98 added.** *(i)* The dictionary is **convention-sensitive**: $M^\#$ must use the unnormalised $\phi_{ij}=E_{ij}-E_{ji}$, since an orthonormal basis halves it. *(ii)* Dai–Fu Lemma 3.3 verified as a pointwise algebraic identity at $s=0,1,-2.3$ for $n=4,5,6$, eighteen cases, residuals $\le2.8\times10^{-14}$, the Einstein hypothesis is algebraic and Schur's constancy of $s$ is an output of the differential setting rather than an input. *(iii)* The brief's emphasis on trilinearity is **redundant**: $\alpha$ and $\beta$ are already fully symmetric as raw contractions. *(iv)* Two corrections to the *explanation* of 2g's failure that the cycle had written down: the realisable $\lambda$ at $n=5$ are **not** a proper subvariety, the spectrum map's Jacobian has rank $9$ and fills the traceless hyperplane, so the slack lives in the $(\lambda,T)$ *product*, not in $\lambda$; and 2g's table lists $N=6,7,9$, so **it never computed $n=5$ ($N=10$) at all**. Its stated driver is refuted outright: $\mathrm{Weyl}_5$ is $O(5)$-irreducible and collapses regardless, so irreducibility is not what separates the dimensions.

**The replacement both reviewers converge on:** the collapse holds exactly for $n\le5$, by the vanishing of $\delta^{a_1\cdots a_6}_{b_1\cdots b_6}$ below rank six, one mechanism covering $n=4$ and $n=5$ uniformly, in place of special-casing $\mathfrak{so}(4)$ chirality.
