# Lean loop, at a glance

**The machine checks the record. [SKILL.md](SKILL.md) is the authority; this file is the shape of it.**

One numbered result per **round**. A round ends with that id carrying one of [lean-layer.md](../lean-layer.md)'s four states in [lean/INDEX.md](../../../lean/INDEX.md), and the next id opened in the same turn.

## The round

```mermaid
flowchart TD
    S0["<b>Phase S · Scan</b> (optional)<br/>only when the queue is empty, results have landed,<br/>or the user asks — never mid-round<br/><i>classify by what the ARGUMENT needs,<br/>not by what the statement mentions</i>"]
    P0["<b>Phase 0 · Read the machinery</b><br/>the verifying script and the stored data<br/>BEFORE the findings block<br/><i>a block drifts; a script is executable</i>"]
    P1["<b>Phase 1 · Split the claim</b><br/>the half the record holds data for,<br/>and the half it does not<br/><i>the structural half is cheaper, stronger,<br/>and is where the record's errors are not</i>"]
    P2["<b>Phase 2 · Formalise the checkable half</b><br/>generate from the data, never retype;<br/>check the packing convention;<br/>grep the library for the name"]
    P3["<b>Phase 3 · State the rest</b><br/>prose where the objects do not exist<br/><i>NEVER a trivially true proposition<br/>under a real-sounding name</i>"]
    P4["<b>Phase 4 · Record, then triage</b><br/>the row in lean/INDEX.md,<br/>then regenerate plan-lean.md"]
    P5["<b>Phase 5 · Commit, take the next id</b>"]
    AX{"<b>#print axioms</b><br/>walks the whole tree"}
    S0 --> P0 --> P1 --> P2 --> P3 --> P4 --> P5
    P2 --> AX
    AX -- "standard three" --> P4
    AX -- "native_decide<br/>or sorryAx" --> P3
    P5 -- "next id, same turn" --> P0
    classDef work fill:#1f6f8b,stroke:#0d3d4d,color:#fff
    classDef gate fill:#8b5a1f,stroke:#4d310d,color:#fff
    class S0,P0,P1,P2,P3,P4,P5 work
    class AX gate
```

## What makes this loop different

**It spawns no agents. The kernel is the adversary.** Every other loop here fans out because a reader can be wrong and independent readers are the only correction. A proof that type-checks needs no corroboration, and one that does not is not improved by a second opinion.

**What that trades away**: a kernel checks the proof it was given, never whether the statement is the one the record meant. **Statement fidelity is this loop's whole exposure**, which is why a round quotes the source rather than paraphrasing it.

```mermaid
flowchart LR
    B["<b>lake build</b><br/>succeeds with `sorry` in the tree<br/>and with `native_decide` in it"] --> NO["settles nothing"]
    A["<b>#print axioms</b><br/>on the round's theorem"] --> Q{"which axioms?"}
    Q -- "propext, Classical.choice, Quot.sound" --> PR["<b>proved</b>"]
    Q -- "sorryAx" --> PA["<b>partial</b>, gap visible"]
    Q -- "native_decide" --> PA2["<b>partial</b>, the COMPILER<br/>is in the trust base"]
    classDef bad fill:#6f1f1f,stroke:#3d0d0d,color:#fff
    classDef good fill:#1f6f3f,stroke:#0d3d20,color:#fff
    classDef warn fill:#8b5a1f,stroke:#4d310d,color:#fff
    class B,NO bad
    class A,PR good
    class PA,PA2 warn
```

**A row's state is settled by [axiom_audit.py](../../../scripts/misc/axiom_audit.py), never by the build succeeding.**

## What the loop does not do

**It does not repair the record.** A defect it finds is queued, and the repair belongs to whichever loop owns the mathematics.

**It does not compute to fill a gap.** Where a proof needs data the record does not hold, that is the finding.
