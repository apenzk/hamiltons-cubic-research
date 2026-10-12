# structure-check

A compliance check over the record's folders. Invoke it with `/structure-check`; the spec and the checks live in [SKILL.md](SKILL.md).

**Four checks in one straight line, then a report.** It reads and never repairs, a failing check names the file, the line and the rule, and the fix is somebody's decision.

## The line

```mermaid
flowchart TD
    S["<b>the spec</b><br/>SKILL.md defines the required shape<br/>of findings/, references/, reviews/,<br/>verification/ and scripts/"]
    A["<b>A · numbered</b><br/>every lemma and theorem in findings/<br/>carries #### Lemma N, …<br/><i>a result with no number cannot be cited</i>"]
    B["<b>B · indexed</b><br/>every number is a row in INDEX-results.md,<br/>every row is a heading in findings/,<br/>no number appears twice"]
    C["<b>C · folders indexed</b><br/>references, reviews, scripts, verification<br/>listed both ways, orphans and ghosts"]
    D["<b>D · reference format</b><br/>each references/&lt;slug&gt;/ holds<br/>README.md · notes.md · .pdf · .txt"]
    R{"<b>all four clean?</b>"}
    P["<b>PASS</b><br/>A n/n · B n/n · C n/n · D n/n"]
    F["<b>the report</b><br/>one table per check: file, line,<br/>and what the spec requires"]
    H(["handed on, numbering to the research loop,<br/>a wrong statement to the verification loop,<br/>a missing source to a fetch"])
    I["<b>improve the spec</b><br/>what would have caught this sooner,<br/>shown verbatim with THE CHANGED<br/>WORDS IN CAPITALS, proposed, not applied"]

    S --> A --> B --> C --> D --> R
    R -- "yes" --> P
    R -- "no" --> F --> H
    P --> I
    F --> I
    I -.->|"if the user accepts"| S

    classDef work fill:#1f6f8b,stroke:#0d3d4d,color:#fff
    classDef gate fill:#8b5a1f,stroke:#4d310d,color:#fff
    classDef decide fill:#5a1f8b,stroke:#310d4d,color:#fff
    class A,B,C,D,I work
    class S,F gate
    class R decide
    class P,H gate
```

## What each check is for

| check | catches | why it matters |
|---|---|---|
| **A · numbered** | a result stated under a narrative heading only | nothing can cite it, so it gets restated instead, and restatements drift |
| **B · indexed** | a number missing from the index, an index row with no result, or **one number on two headings** | the third is worst: two statements sharing one address, and a citation that means either |
| **C · folders indexed** | orphans and ghosts | a ghost is a broken citation; an orphan is work nobody can find |
| **D · reference format** | a source with no PDF, no notes, no extraction or no index card | a hypothesis check that cannot point at a line in the source is an opinion |

## The one exception in the spec

**A source that could not be obtained passes without a PDF**, provided its `README.md` carries a `Not obtained` section naming what was tried. A record that says "this source is not on file" is correct. A folder holding a substitute paper, or a summary standing in for one, is not, this project has had a summarization layer fabricate a reference once, which is why the rule reads that way.

## The last step

**Every run ends by proposing what would improve the spec**, shown verbatim with the changed words in CAPITALS so the reader sees the edit rather than a description of it. **Proposed, never applied**, the spec is what the record is checked against, and a skill that edits its own spec after a failing run can define its failures away.

The case that earns one: a check demanding one form of indexing while the index legitimately uses another, which reports most of the corpus as broken.

## What it does not do

**It does not repair**, because a missing heading, a stale index row and an unfetched PDF each have a right fix that depends on why they happened, and a check that quietly fixes things stops being a check.

**It does not judge mathematics.** Whether a `Lemma` deserves the label is Gate 2's question; this skill checks the label is present, unique and indexed.
