# Gate 2 brief: does `isWeyl_toTensor` bridge the two layers, or only appear to?

**You are a cold reviewer.** You have not seen the work that produced this and are not told what its author concluded.

**Your subject is whether the map is the right map, not whether the proof is right.** It is kernel-checked on the standard three axioms, so a manipulation error is not available to you. **A bridge can type-check and carry nothing**: if `toTensor` is not the tensor the record means by a curvature operator's components, if the class `IsWeylOp` is empty or trivial, or if the conventions on the two sides differ by a factor or an index order that the statement never notices.

Read [reviews/_g2-standing.md](_g2-standing.md) and follow it. **Analysis only**: computation needs the user's approval for a specific task and it has not been given. The one allowance is screening a claim you are about to record, seconds of compute on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim. A run of a few minutes on objects already in hand is permitted. Name any sweep, census or unbounded search and stop.

**Log** to `agent_logs/r1003.log`.

## What to read

- [TensorBridge.lean](../lean/HamiltonsCubic/Results/TensorBridge.lean), the file under review.
- [L94Statement.lean](../lean/HamiltonsCubic/Results/L94Statement.lean) for `Tensor4`, `IsAlgCurv`, `IsWeyl`, `normM2`, `frobK`.
- [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) for `inner2`, `phi`, `IsWeyl`, `bianchi`, `Ric`, and [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean) for `IsLinOp` and `IsWeylOp`.
- The record's own conventions: [findings/conventions.md](../findings/conventions.md), and [findings/INDEX.md](../findings/INDEX.md) for what it says a curvature operator's components are.

## Attack items

Answer every one in writing, including where you find nothing.

1. **Is `toTensor R a b c d = ⟨R φ_ab, φ_cd⟩` the record's own component convention**, including its factor? [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean)'s `inner2` carries a `1/2`. Say whether the record's $W_{abcd}$ is this, twice this, or half it, and whether any statement in the new file depends on which.
2. **Is `IsWeylOp` inhabited by anything with content?** Exhibit a member whose `toTensor` is nonzero, or show the class is trivial. The record's own `diagOp w` at a weight is the obvious candidate: say whether it qualifies and what its tensor is.
3. **Does `toTensor` LOSE information?** A curvature operator acts on all of $\Lambda^2$, and the tensor records it on the $\varphi$ basis. Say whether the map is injective on the class, and whether anything in the file needs it to be.
4. **Check the four clauses individually against their sources.** In particular the claim that the operator layer's `bianchi` clause is the tensor layer's Bianchi identity *term for term*, and that `Ric = 0` gives tracelessness. Are the index orders the same, or does one of them need a permutation the proof supplies silently?
5. **Is linearity genuinely needed, or is it an artefact?** The file says antisymmetry in the first pair needs $R(-X) = -RX$. Say whether a weaker hypothesis suffices, and whether `RealLayer.IsWeyl` alone already implies it.
6. **What does this NOT give [I36](../plan.md)?** The file claims the reverse map and the transport of $\theta$ and local-maximality are still owed. Confirm or correct that, and say precisely what would have to exist before I36's shape claim could be stated in Lean.

## Verdict

Per item, one of `confirmed`, `refuted`, `withdrawn`, or `no argument on file`. **Silence is not a verdict.** File `reviews/REVIEW_r1003.md` and add your row to [reviews/INDEX.md](INDEX.md), committing only those two paths.
