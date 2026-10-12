# Gate 2 brief: the $\Lambda^4$ obstructions, and whether I75 is a finite list

You are an adversarial reviewer. **TWO reviewers on identical briefs**, because this is an argument being made rather than text compared against something fixed. *Your independence comes from your implementation, not from your instructions.*

**Work from the definitions below and from the mathematics alone.** Do not read [findings/diagonal-half.md](../findings/diagonal-half.md), the other findings files, or the screens behind them. You may read the Lean files named in the table.

## The definitions, quoted so you can work from them alone

$W$ is an **algebraic Weyl tensor** on $\mathbb R^n$: a $4$-tensor with the Riemann symmetries, the first Bianchi identity, and all traces zero. It is read equivalently as a symmetric operator on $\Lambda^2\mathbb R^n$.

For a symmetric operator $R$ on $\Lambda^2\mathbb R^n$, write $\mathrm{comp}(R)$ for its $4$-index form and

$$\mathrm{Alt}(R)_{ijkl}=\tfrac1{4!}\sum_{\sigma\in S_4}\mathrm{sgn}(\sigma)\,\mathrm{comp}(R)_{\sigma(i)\sigma(j)\sigma(k)\sigma(l)}\ \in\ \Lambda^4\mathbb R^n .$$

**First Bianchi for $W$ is exactly $\mathrm{Alt}(W)=0$.** The layer types this as [alt4](../lean/HamiltonsCubic/Base/AltPart.lean) and [altCoeff](../lean/HamiltonsCubic/Base/AltPart.lean).

Let $W$ have distinct eigenvalues $\mu_1,\dots,\mu_s$ with spectral projectors $P_{\mu_1},\dots,P_{\mu_s}$ on $\Lambda^2\mathbb R^n$, so $\sum_\mu P_\mu=\mathrm{Id}$ and $W^k=\sum_\mu\mu^kP_\mu$ for every $k\ge0$. **Define the obstruction at each eigenvalue as $\mathfrak b(P_\mu):=6\,\mathrm{Alt}(P_\mu)\in\Lambda^4$.**

**[I75](../plan.md)'s requirement**, as the record states it: at a critical point above $\sqrt{3/2}$, $\mathrm{Alt}(W^k)=0$ **for every $k$**.

## The claims to attack, one row per claim, with the Lean declaration

| # | claim | Lean |
|---|---|---|
| 1 | $\mathrm{Alt}(W^k)=\tfrac16\sum_\mu\mu^k\,\mathfrak b(P_\mu)$ at every $k$ | [altCoeff](../lean/HamiltonsCubic/Base/AltPart.lean), [alt4](../lean/HamiltonsCubic/Base/AltPart.lean); **no declaration states the spectral expansion, which is row 1's content** |
| 2 | $\sum_\mu\mathfrak b(P_\mu)=\mathfrak b(\mathrm{Id})=0$, **a free relation** | **none: the record carries $\mathrm{Alt}(\mathrm{Id})=0$ as a SCREEN to machine zero, never as a theorem, which is why the row is here** |
| 3 | $\sum_\mu\mu\,\mathfrak b(P_\mu)=6\,\mathrm{Alt}(W)=0$, **a free relation, and it IS first Bianchi** | [altCoeff](../lean/HamiltonsCubic/Base/AltPart.lean); the Bianchi hypothesis is [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean)'s |
| 4 | hence the $\mathfrak b(P_\mu)$ lie in the kernel of a $2\times s$ Vandermonde | **none: a rank statement about a matrix the layer does not build** |
| 5 | at $s=2$ every $\mathfrak b(P_\mu)=0$, so $\mathrm{Alt}(W^k)=0$ for all $k$ **with no further hypothesis** | none, same reason |
| 6 | at $s=3$ the whole family reduces to the single condition $\mathrm{Alt}(W^2)=0$ | none, same reason |
| 7 | at $s=3$, $\mathrm{Alt}(W^3)=\big(\sum_\mu\mu\big)\mathrm{Alt}(W^2)$, the sum over DISTINCT values | none, same reason |
| 8 | in general I75 is **exactly $s-2$ conditions**, $\mathrm{Alt}(W^k)=0$ for $k=2,\dots,s-1$, not an infinite family | none, same reason |
| 9 | the reduction is **sharp at the obstruction**: $W_{\mathbb{CP}^2}$ has spectrum $\{2c,-c,0\}$, so $s=3$ is the first case row 5 does not cover and is exactly where the link is known to fail | none: a property of a constructed tensor |
| 10 | **what it does NOT give**: any bound on $s$ at a maximiser | none, deliberately |

## What to do

1. **Row 2 is the one this brief most doubts, and the doubt is about STATUS rather than truth.** $\mathrm{Alt}(\mathrm{Id})=0$ is carried as a screen to machine zero and never derived. **Derive it or refute it.** *The identity operator on $\Lambda^2$ has a $4$-index form that is not obviously totally antisymmetric-free, so say exactly which symmetry kills it and at which $n$.* If it is false at some $n$, rows 4 to 8 fall with it.
2. **Row 1 carries the whole reduction and is stated in one line.** Check that $\mathrm{Alt}$ is **linear in the operator**, that $\mathrm{comp}$ is, and that the spectral decomposition may be pushed through $\mathrm{Alt}$ term by term. **Check the constant $\tfrac16$**, and say what it is if it is not $\tfrac16$.
3. **Rows 4 and 8 are a rank count, so count it.** The kernel of a $2\times s$ Vandermonde on DISTINCT nodes has dimension $s-2$. **Confirm the nodes are distinct by construction**, and that adding the rows $k=2,\dots,s-1$ completes a square Vandermonde rather than a singular one.
4. **Row 7 is the most checkable and the easiest to get wrong.** Derive $\mathrm{Alt}(W^3)$ at $s=3$ yourself and say whether the coefficient is $\sum_\mu\mu$ over the distinct values, over the spectrum with multiplicity, or neither.
5. **Row 9 is a sharpness claim and sharpness claims overreach.** Confirm $W_{\mathbb{CP}^2}$'s spectrum has exactly three distinct values, and say whether "the first case not covered is exactly where the link fails" is a fact or a coincidence of $s=3$.
6. **Row 10 is the scope, and the record depends on it being honest.** Say whether anything in rows 1 to 9 secretly bounds $s$.
7. **State what each claim would look like if it were VACUOUS**, and check that it is not. *Row 5 in particular: if no critical point above $\sqrt{3/2}$ has two distinct eigenvalues, the row excludes nothing.*
8. Return **CONFIRMED**, **PLAUSIBLE** or **REFUTED** per claim, with corrections.

## Standing rules

**Analysis only.** A LONG or OPEN-ENDED run needs the user's approval for the specific task. **Permitted without asking**: screening a claim you are about to record, seconds of compute on objects you construct for that purpose, and any run finishing in a few minutes on objects already in hand. **The deliverable is a derivation, and a number is a screen.**

**A control is an assertion, never a printed expectation.**

**Report.** Write your own `reviews/REVIEW_rN.md` at the number you are given, skeleton committed in your FIRST phase with every verdict `NOT REACHED`. **Commit with an explicit PATHSPEC**, `git commit -m "<msg>" -- reviews/REVIEW_rN.md`. Never `git add -A`, never `git commit -a`, never amend. **Do not write to reviews/INDEX.md**, and do not read the other reviewer's report.

**Two traps in the commit gate.** [cycle_deliverable.py](../.claude/hooks/cycle_deliverable.py) reads the first physical line of the bash command for `refut\w+`, so a subject line containing "refutes" trips its opens-an-item tripwire while the parent has `plan.md` staged. Its `SEARCHED` regex anchors on `$` under `re.M`, so a trailer works only when the closing shell quote sits on the next line.

**Log** to the path you are given: PID and phase plan on the first line, a line per phase, a heartbeat carrying live state at least every 3 minutes, and a closing line OPENING with `DONE ` or `FAILED `.
