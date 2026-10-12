# Step 9 sweep, 2026-09-28m: P, questioning the approach

*Position file: [2026-09-28m-step8-position.md](2026-09-28m-step8-position.md).*

## Batch 1: the three questions against the record (derived)

- **Question 2, separating the halves, closes.** $P=\operatorname{tr}W^3+\langle W^\#,W\rangle$. Statement H caps the second half at $\tfrac{2m-3}{\sqrt{(m-1)(2m-1)}}$, $\tfrac9{\sqrt{55}}=1.214$ at $n=12$, attained at the balanced product; the first half reaches $\tfrac6{6^{3/2}}=0.408$ at padded $W_{\mathbb{CP}^2}$. The two maxima sit at different tensors and sum to $1.62>\theta_0(12)=1.236$, so bounding the halves separately cannot give P. *[Post F26](../findings/INDEX-traps.md) is the same fact for the second-kind form ($\tfrac32\max p_3(\mu)=1.4657>\theta_0(12)$).* **H is a component of a proof of P only inside a coupling that uses both halves at one tensor.**
- **Question 1, a comparison exact on the products without diagonality.** The record's comparisons with the product are the diagonal theorem (through diagonality), R17's lifted Jäger chain ($P\le\theta_0+\kappa_n\delta^2$, $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$ the Bianchi defect of the negative part, which vanishes on the diagonal locus, where the chain reduces to the diagonal theorem), and (MG) (through the diagonal part in a maximal frame). **Each reads the value through a diagonality quantity.** No comparison on record, and none from the literature in [2026-09-28i](2026-09-28i-LIT-step8-sweep.md), is exact on the products by another mechanism.
- **Question 3, what the programme owns.** The diagonal theorem at every $n$ (in Lean), the second-kind bound on $E$ (in Lean), the frame inequalities of a maximal frame ([L284](../findings/second-order.md)'s variance identity, the finite-angle and double-rotation inequalities), the $\#$-idempotent reduction of H ([L260](../findings/second-order.md), [L264](../findings/second-order.md), [L270](../findings/second-order.md)), and the torus families. *None of them is a global comparison off the diagonal locus.*

## Phase 3b

| route | closes | attackable | margin | analytic | value | how close to P |
|---|---|---|---|---|---|---|
| H by R48 and R49 ([I117](../plan.md)) | 2 | 1 | 1 | 1 | **2** | the $\#$ half, a component of P only inside a coupling |
| a coupling of both halves at one tensor, exact on the products | 3 | 1 | 1 | 1 | **3** | P, but no mechanism is named on record or in the literature |
| diagonality at the maximiser in any of its three forms (I36, I73, I121) | 3 | 0 | 1 | 1 | **0** | P with L57, blocked by the two requirements |

**Outcome: P's remaining content is one statement, that a global maximiser is diagonal in some frame, and the two requirements say how a proof of it must look**: exact on the unbalanced products to a relative $n^{-3}$, and global, since padded $W_{\mathbb{CP}^2}$ satisfies every local condition below $\theta_0$. *No route meeting both is named.* **The coupling row outranks I117 on the rubric but names no mechanism, so it is the invention the three sweeps of the day could not make; by the manager's decision of 2026-09-28k the cycle keeps I117 meanwhile**, the one item with concrete open sub-steps ($\mathfrak{sp}(k)$'s torus system, $\mathfrak g_2$'s generic type, $n=12,13$, R49), with the caveat that H feeds P only inside a coupling.
