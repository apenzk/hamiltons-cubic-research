# Review r802, L187, and the census it is said to close

*Reviewer r802, cold brief, 2026-09-09. **Analysis only**: the one compute performed is a Lean build, reported below as a screen.*

**Verdicts.** **Claim A (L187), REFUTED as proved, and withdrawn under the protocol.** **Claim B (the census collapses to one case), PLAUSIBLE, inheriting Claim A's gap.** *One sub-claim inside Claim B (that at $\dim V=4$ all three image forms are non-decomposable), is CONFIRMED and is the only part of this round that survives intact.*

---

## 1. What is right, and it is most of the algebra

Every step of Claim A except one is correct, and I checked each by hand rather than by reading.

**The Hodge signs on $\mathbb R^6$ are right.** With $\alpha\wedge\star\beta=\langle\alpha,\beta\rangle\mathrm{vol}$ and $\mathrm{vol}=e_{123456}$: $\star e_{1234}=e_{56}$, $\star e_{1256}=e_{34}$ and $\star e_{3456}=e_{12}$, each with coefficient $+1$, the two index transpositions needed in the middle case are four in number, hence even. For $\omega=s_1e_{12}+s_2e_{34}+s_3e_{56}$ one has $\omega\wedge\omega=2(s_1s_2e_{1234}+s_1s_3e_{1256}+s_2s_3e_{3456})$, so

$$\sigma(\omega)=\tfrac12\star(\omega\wedge\omega)=s_2s_3\,e_{12}+s_1s_3\,e_{34}+s_1s_2\,e_{56},$$

which is the adjugate on pair spectra exactly as the block says. **The identity $\sigma\circ\sigma=\mathrm{Pf}\cdot\mathrm{id}$ survives the signs**, since $(t_2t_3,t_1t_3,t_1t_2)=s_1s_2s_3\,(s_1,s_2,s_3)$ identically.

**$\sigma$ is frame-independent.** $\omega\mapsto\star(\omega\wedge\omega)/2$ is built from the metric and an orientation alone; the adapted frame is used to compute it, never to define it. Orientation reversal sends $\sigma\mapsto-\sigma$ and $\mathrm{Pf}\mapsto-\mathrm{Pf}$, and since $\sigma$ is even the identity $\sigma\circ\sigma=\mathrm{Pf}\cdot\mathrm{id}$ flips consistently on both sides. *A positively oriented adapted frame is always available at the cost of a sign in one $s_i$, which the identity tolerates.* **This attack point clears.**

**The independence step clears.** $\omega_1,\omega_2$ orthonormal in $\Lambda^2$ are linearly independent, so $a\,\omega_1=b\,\omega_2$ gives $a=b=0$; $c\ne0$ then gives $\mathrm{Pf}(\omega_2)=0$ as well. *Only $c\ne0$ is needed, not $c>0$.*

**The sign hypothesis is not owed.** [L180](../findings/diagonal-half.md)(3) puts $V$ at the minority-sign form's support, and a decomposable minority form would make $V$ a plane against $\dim V\ge4$, so the decomposable $\omega_3$ carries a majority sign, the minority form is one of the two non-decomposable ones, and $\lambda_1,\lambda_2$ are opposite-signed as a **consequence**. *So L187's closing note that "what remains owed is the sign hypothesis L186 assumes" is stale: L186's block already records that hypothesis as a theorem twice over, and L186's proof as now written assumes no sign at all.*

## 2. The one step that fails: $\dim V\le6$ is the conclusion assumed

**The block's whole justification is the parenthesis "$\mathop{\mathrm{supp}}\omega_1=\mathop{\mathrm{supp}}\omega_2+P_3$ and a plane adds two".** That gives

$$\dim V=\dim\mathop{\mathrm{supp}}\omega_1\ \le\ \mathop{\mathrm{rank}}\omega_2+2,$$

and $\mathop{\mathrm{rank}}\omega_2\ge4$ is all that non-decomposability supplies. **So "$\dim V\le6$" is precisely "$\mathop{\mathrm{rank}}\omega_2\le4$", which is half of what the lemma sets out to prove.** *The bound is not a standing fact of the setting either: [L180](../findings/diagonal-half.md)'s own closing note states "$\dim V\ge6$ is the whole of what remains", i.e. $\dim V$ is a priori unbounded above, and [plan.md](../plan.md)'s I38 entry says in as many words that "nothing above reaches $\dim V\ge8$".*

**The gap is fatal to the method, not merely to a bound.** For $\dim V>6$ the map $\sigma$ is not defined at all: $\star(\omega\wedge\omega)$ is an $(n-4)$-form, so $\sigma:\Lambda^2\to\Lambda^2$ exists only in six dimensions. *The premise is what makes the operator exist, and it is assumed.*

**A second, smaller defect in the same sentence.** $\mathop{\mathrm{supp}}\omega_1=\mathop{\mathrm{supp}}\omega_2+P_3$ holds only after a relabelling that puts the minority weight on $\omega_1$; the sign pattern also permits $\mathop{\mathrm{supp}}\omega_2=\mathop{\mathrm{supp}}\omega_1+P_3$. *The relabelling is harmless (both forms are non-decomposable and $c\ne0$ either way) but it is unstated, and the block reads as though one containment were forced.*

## 3. What the $\sigma$ computation actually proves, and it is not what is claimed

Granting the algebra and reading it at $\dim V=6$: $V=\mathop{\mathrm{supp}}\omega_1$ has dimension six, so $\mathrm{Pf}(\omega_1)\ne0$, while the computation returns $\mathrm{Pf}(\omega_1)=0$. **So the content is $\dim V\ne6$, not $\dim V=4$.** *Stated as "$\dim V=4$" the lemma describes a surviving configuration; what the argument yields is the exclusion of a dimension.*

**And the residue at $\dim V=4$ is empty**, by the import Claim B itself makes: at $\dim V=4$ rank $\le3$ forces one of $W^\pm$ to vanish, all three eigenforms lie in the surviving $\Lambda^\pm$, and a nonzero (anti-)self-dual $2$-form on $\mathbb R^4$ has $\omega\wedge\omega=\pm\lVert\omega\rVert^2\mathrm{vol}\ne0$, hence rank four. **So at $\dim V=4$ all three forms are non-decomposable and the two-non-decomposable configuration cannot sit there.**

> **THIS IS THE THIRD CONSECUTIVE LEMMA OF THE LINE THAT IS ABOUT NOTHING.** *[L185](../findings/diagonal-half.md) was empty by Ricci alone, [L186](../findings/diagonal-half.md) by Bianchi alone, and L187's own conclusion (granted its premise), combines with [L178](../findings/diagonal-half.md)'s step 1 to empty its own hypothesis.* **A lemma whose conclusion contradicts its hypothesis is an emptiness theorem written as a structure theorem**, and the block presents it as the latter: "the survivor is this lemma", "every branch lands inside L178's hypothesis". *The survivor does not exist.*

## 4. The repair, and how far it reaches

The $\sigma$ route generalises, and the generalisation says exactly which dimensions the record has closed.

**On $V=\mathbb R^{2m}$ put $\tau(\omega)=\star\!\big(\omega^{m-1}/(m-1)!\big)\in\Lambda^2V$.** In an adapted frame $\omega=\sum_i s_ie_{2i-1,2i}$ one has $\omega^{m-1}/(m-1)!=\sum_i\big(\prod_{j\ne i}s_j\big)\hat E_i$ with $\hat E_i$ the product of all pairs but the $i$-th, and $\star\hat E_i=+e_{2i-1,2i}$ because $2$-forms commute. **So $\tau$ has pair spectrum $t_i=\prod_{j\ne i}s_j$, is homogeneous of degree $m-1$, and satisfies**

$$\tau\circ\tau=\mathrm{Pf}^{\,m-2}\cdot\mathrm{id}.$$

*Checks: $m=2$ gives $\tau=\star$ and $\tau\circ\tau=\mathrm{id}$, which is $\star\star=\mathrm{id}$ on $\Lambda^2\mathbb R^4$; $m=3$ gives $\tau=\sigma$ and the record's identity.*

**For $m$ ODD the record's argument runs verbatim.** $m-1$ is then even, so first Bianchi's $\omega_1\wedge\omega_1=c\,\omega_2\wedge\omega_2$ raises to $\omega_1^{m-1}=c^{(m-1)/2}\omega_2^{m-1}$, hence $\tau(\omega_1)=c^{(m-1)/2}\tau(\omega_2)$, hence $\mathrm{Pf}(\omega_1)^{m-2}\omega_1=c^{(m-1)^2/2}\mathrm{Pf}(\omega_2)^{m-2}\omega_2$, and independence forces $\mathrm{Pf}(\omega_1)=0$ against $\mathop{\mathrm{rank}}\omega_1=\dim V$. **So the branch is empty at $\dim V\in\{6,10,14,\dots\}$, and at $\dim V=4$ by §3.**

**For $m$ EVEN the route stops.** $\omega^{m-1}$ is an odd power and is not a function of $\omega\wedge\omega$; the only relation the top power gives is $\mathrm{Pf}(\omega_1)=c^{m/2}\mathrm{Pf}(\omega_2)$, which is consistent, it says both forms have full rank $2m$ and nothing more. **So the honest state of the two-non-decomposable branch is: empty except possibly at $\dim V\in\{8,12,16,\dots\}$.** *That is a real advance on the block as written, and it is still not the block's claim.*

## 5. Claim B, item by item

| Component | Status |
| --- | --- |
| Zero non-decomposable empty ([L185](../findings/diagonal-half.md)) | **CONFIRMED.** I re-derived the squaring: $\{\Pi_2,\Pi_3\}=\Pi_2+\Pi_3$, so $(\Pi_2+\Pi_3)^2=2(\Pi_2+\Pi_3)$ with a two-dimensional $2$-eigenspace $P_2\cap P_3$, forcing $P_2=P_3=P_1$ and three orthonormal vectors into a line. |
| One non-decomposable empty ([L186](../findings/diagonal-half.md)) | **CONFIRMED.** Bianchi collapses to $\lambda_1\,\omega_1\wedge\omega_1=0$. |
| "$\dim V=4$ makes all three non-decomposable" | **CONFIRMED**, and the import from [L178](../findings/diagonal-half.md)'s step 1 is faithful: $W$ restricted to $\Lambda^2V$ is Ricci-flat and Bianchi on $V$, so it splits as $W^+\oplus W^-$; each summand is trace-free on a three-space, hence of rank $0,2,3$; total rank $\le3$ kills one summand; the image forms then all lie in the survivor. |
| Circularity of that import | **NOT circular.** L178's step 1 is applied *under* the hypothesis $\dim V=4$ to derive a contradiction with "exactly two non-decomposable", a conditional, not an assumption of what is proved. Claim A supplies $\dim V=4$ from elsewhere. *The circularity in this round is in Claim A's own premise, not here.* |
| "Two is empty" | **NOT established.** It rests entirely on Claim A. With §4's repair it holds for $\dim V\in\{4,6,10,14,\dots\}$ and is open for $\dim V\in\{8,12,\dots\}$. |
| "Three is the only remaining case" | **NOT established**, for the same reason. The correct present statement is that **two and three both remain**, with two confined to $\dim V\equiv0\pmod4$, $\dim V\ge8$. |
| Census exhaustive? | **Yes, structurally.** Counting non-decomposable forms among three gives $0,1,2,3$ and nothing else; no configuration is unmentioned this time. *The earlier failure was in the emptiness verdicts, not in the enumeration, and that is where it recurs.* |

## 6. Is Claim A's configuration inhabited?

**I did not exhibit one and I did not exclude one.** What I can state:

- **$\dim V=4$: empty**, by §3, the decomposable $\omega_3$ cannot live there.
- **$\dim V=6$: empty**, by the record's own $\sigma$ computation, read correctly.
- **$\dim V\in\{10,14,\dots\}$: empty**, by §4.
- **$\dim V\in\{8,12,\dots\}$: open.** At $\dim V=8$ both $\omega_1,\omega_2$ would have full rank eight with $\mathrm{Pf}(\omega_1)=c^2\mathrm{Pf}(\omega_2)$, $P_3\subseteq V$, and Ricci-flatness $\lambda_1A_1=\lvert\lambda_2\rvert A_2+\lvert\lambda_3\rvert\Pi_3$ whose trace is an identity rather than a constraint. *Nothing in the record touches it, and [plan.md](../plan.md) says so.*

**One negative datum, argued rather than screened.** The obvious candidate, $\omega_1,\omega_2$ a pair of orthonormal self-dual forms on a common $\mathbb R^4$, which does satisfy $\omega_1\wedge\omega_1=\omega_2\wedge\omega_2$, fails Ricci-flatness immediately: there $A_1=A_2=\tfrac12\mathrm{Id}_4$, so $(\lambda_1+\lambda_2)\tfrac12\mathrm{Id}_4+\lambda_3\Pi_3=0$ needs a rank-two $\Pi_3$ to be a multiple of $\mathrm{Id}_4$. *Consistent with §3's exclusion, and it is the reason the branch has no cheap witness.*

## 7. Three places the record contradicts itself

- **[L186](../findings/diagonal-half.md)'s block disagrees with itself.** One paragraph says "AND THE TWO-CASE IS EMPTY TOO, BY L178'S OWN STEP 1"; a later paragraph in the same block says "**two is open** and is what L187 attacks". Both cannot stand.
- **[L187](../findings/diagonal-half.md)'s block disagrees with [L186](../findings/diagonal-half.md)'s.** L187 says "the survivor is this lemma" and "every branch lands inside L178's hypothesis"; L186 says the two-case is empty and three is the only case left.
- **[L187](../findings/diagonal-half.md)'s block disagrees with its own proof.** Its closing note says "the TWO-non-decomposable case, where $\mathop{\mathrm{supp}}\omega_1=\mathop{\mathrm{supp}}\omega_2+P_3$ can have dimension six and nothing here rules it out", while the proof above it asserts $\dim V\le6$ and concludes $\dim V=4$. *It also still says the sign hypothesis is owed, which L186's block records as discharged.*

*[plan.md](../plan.md)'s I38 row, by contrast, reads L187 correctly as emptying the two-case. **The plan and the finding say different things about the same lemma.***

## 8. The Lean layer

**Screen: `lake build HamiltonsCubic.Results.L187Statement` completes successfully, 8709 jobs, warnings only (unused binders in [L186Statement.lean](../lean/HamiltonsCubic/Results/L186Statement.lean)).** *A screen, not evidence for any positive claim.*

**What compiles is true and is not the lemma.** `sigma_sigma`, `sigma_smul` and `pf_eq_zero_of_indep` are correct; `block_det`'s determinant $-ab\sin^2\theta$ is right. **`dim_V_eq_four_survivor` takes `r₁ ≤ 4` and `dimV = r₁` as hypotheses and closes by `omega`**, it types the arithmetic and assumes the two facts under review, which the module docstring says. *The docstring's own framing is stale in the same way as the finding: it says L186 "put the one-non-decomposable branch at `dim V = 4`", where L186 now says that branch is **empty**, and it devotes a section to deriving a sign hypothesis L186 no longer carries.* **The file changed on disk during this review; I report what I read and touched nothing.**

## 9. Falsifiers, and what was done to look for them

| Claim | What would falsify it | What I did |
| --- | --- | --- |
| **A**, the configuration has both ranks four and $\dim V=4$ | (i) an instance with $\dim V\ge6$; (ii) a demonstration that the premise $\dim V\le6$ is unavailable | (ii) succeeded: traced the premise to $\mathop{\mathrm{rank}}\omega_2\le4$, the conclusion's own content, and confirmed against [L180](../findings/diagonal-half.md)'s and [plan.md](../plan.md)'s statements that $\dim V$ is a priori unbounded. For (i) I derived the $\tau$ generalisation, which closes every odd $m$ and leaves $\dim V\in\{8,12,\dots\}$ un-excluded; I built no witness there. |
| **A**'s $\sigma$ identity | a wrong Hodge sign, or frame dependence | Computed $\star e_{1234},\star e_{1256},\star e_{3456}$ from $\alpha\wedge\star\beta=\langle\alpha,\beta\rangle\mathrm{vol}$; checked orientation-reversal consistency of $\sigma\circ\sigma=\mathrm{Pf}\cdot\mathrm{id}$; validated the general $\tau$ formula against $m=2$ and $m=3$. **No defect.** |
| **A**'s independence step | a case where $a\omega_1=b\omega_2$ with $a,b$ not both zero | Orthonormality gives independence outright; $c\ne0$ suffices. **No defect.** |
| **B**, the census collapses to three non-decomposable | a two-non-decomposable instance, or a broken deduction | The deduction is sound but conditional on Claim A; with Claim A withdrawn, the two-case is open at $\dim V\equiv0\pmod4,\ \ge8$. Enumeration re-checked as exhaustive. |
| **B**'s L178 import | L178's step 1 not saying what B uses, or circularity | Re-derived step 1 from the $W^\pm$ splitting of the restricted tensor and the self-dual rank fact. **Faithful, and not circular.** |

## 10. What the record should say instead

**Stated positively, the surviving theorem is:** *a rank-three Weyl tensor with exactly two non-decomposable image forms has $\dim V\equiv0\pmod4$ and $\dim V\ge8$.* **And the census is: zero and one are empty; two survives only at $\dim V\in\{8,12,\dots\}$; three is open at every $\dim V\ge4$.** *[I38](../plan.md) is then two questions, not one.*
