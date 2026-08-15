# Feedback Diagnosis And Return Routing

Use this protocol to decide why learning evidence fell short and where to restart. Route to the earliest stage that can repair the cause, not automatically to more practice.

## Diagnostic Protocol

1. Restate the intended result and acceptance criterion.
2. Record the observed result without interpretation.
3. Locate where the learner's recall, explanation, prediction, decision, or action first diverged.
4. Generate one or more candidate causes.
5. Select the earliest plausible stage for each cause.
6. If diagnoses compete, run the smallest probe that distinguishes them.
7. Report the diagnosis, evidence, confidence, return stage, corrective action, and retest.

## Routing Matrix

| Observed signal | Likely cause | Return stage | Useful probe |
|---|---|---|---|
| The learned material does not help with the intended task | Goal, scope, or acceptance mismatch | Prepare | Ask what real task must improve and whether the current test represents it |
| Sources conflict, omit prerequisites, or are obsolete | Source-quality or coverage gap | Prepare | Compare source authority, date, prerequisites, and target coverage |
| The learner cannot define or distinguish core concepts | Missing or shallow information | Input | Ask for a plain-language explanation and a contrast case |
| A conclusion is recalled but its mechanism or conditions are not | Shallow understanding | Input | Change one condition and ask for a prediction with reasoning |
| The learner can follow the source but cannot rebuild the model | Knowledge was not reorganized or integrated | Reflect | Close the source and reconstruct the structure from a blank page |
| The learner's explanation is coherent but based on a wrong assumption | Faulty mental model | Reflect | Identify premises, counterexamples, and where the model contradicts evidence |
| The learner explains well but cannot recognize an applicable situation | Context-feature recognition gap | Transfer | Compare one fitting and one non-fitting scenario by underlying features |
| The learner applies the idea to a superficially similar but structurally different case | False transfer | Transfer | List required conditions and test each against the new situation |
| The learner chooses the right approach but cannot execute independently | Procedural fluency gap | Output and practice | Remove the worked example and run a bounded independent task |
| Execution works only in a rehearsed case | Brittle practice or narrow variation | Output and practice | Change constraints, inputs, or failure conditions while preserving the core task |
| Performance was correct but the explanation is confused | Tacit success without explicit model | Reflect, then output | Ask the learner to explain decisions and predict a variation |
| Performance was once correct but later recall is weak | Retrieval weakness | Retrieval sidecar | Use a no-notes recall prompt and inspect whether the model remains accurate |
| Feedback is only "good," "bad," or a score without error detail | Insufficient evidence | Feedback | Request examples, criteria, error locations, or an annotated comparison |

## Handle Ambiguity

Do not force certainty when evidence is weak. Use labels such as:

- `High confidence`: the first divergence and its cause are directly observed.
- `Medium confidence`: evidence supports one cause but alternatives remain.
- `Low confidence`: the result is known but the process is mostly hidden.

When confidence is low, prefer a reversible probe over a large remediation plan. Examples:

- Ask for a two-minute closed-source explanation.
- Ask for one prediction after changing a condition.
- Present one fitting and one deceptive transfer case.
- Request a short independent task without reference material.
- Compare the learner's result with one explicit rubric criterion.

## Produce The Diagnosis

Use this format:

```text
Target and criterion:
Observed evidence:
First divergence:
Likely cause:
Confidence:
Return stage:
Smallest corrective action:
Retest:
```

If more than one gap exists, prioritize the earliest blocking cause. Keep later gaps visible, but do not prescribe simultaneous repairs that obscure whether the first correction worked.

## Reject Misleading Feedback

- Do not treat confidence, familiarity, time spent, completion percentage, or notes volume as mastery evidence.
- Do not treat praise, criticism, or a score as diagnostic without criteria or examples.
- Do not assume the latest stage is the cause merely because the failure appeared there.
- Do not overreact to one noisy result; repeat or triangulate when stakes justify it.
- Do not dismiss a result because it conflicts with the learner's preferred explanation.
