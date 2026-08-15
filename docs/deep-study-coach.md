# deep-study-coach

`deep-study-coach` is an interactive learning-method skill that moves a learner from exposure to independent application. It uses observable evidence, stage gates, and feedback routing instead of treating reading time, completed materials, polished notes, or confidence as proof of mastery.

Use it to plan and execute substantial learning, focus on one part of an existing learning process, or diagnose why knowledge is not transferring into performance. Here, "deep study" describes a general learning method; it does not refer to neural-network deep learning or machine learning.

## Best For

- Turning a broad learning intention into a bounded goal, application, and acceptance task.
- Building a learning plan whose units produce evidence rather than only consume content.
- Replacing passive reading or watching with explanation, prediction, reflection, and practice.
- Testing whether the learner can reconstruct an idea without the source.
- Transferring principles into near, medium, and far application scenarios.
- Verifying conceptual understanding through output and operational ability through practice.
- Diagnosing whether a failure comes from the goal, source material, understanding, mental model, context recognition, execution, feedback quality, or retrieval.
- Maintaining a learning record across multiple sessions.

## Operating Modes

| Mode | Use it when |
| --- | --- |
| Full cycle | Starting an important, difficult, or multi-session learning goal. |
| Stage focus | The learner has already progressed and wants to work on preparation, input, reflection, transfer, practice, or feedback. |
| Diagnosis | The learner is stuck, failed an assessment, or has performance evidence that needs explanation. |
| Lightweight | The topic is small or low stakes, but active recall and one application check are still useful. |

## Workflow

1. **Prepare**: define the learning object, real application, mastery target, acceptance evidence, scope, sequence, and a small credible source set.
2. **Input**: identify concepts, relationships, conditions, examples, counterexamples, boundaries, prior-knowledge links, and unresolved questions.
3. **Reflect**: close the sources and reconstruct the model in the learner's own organization, including changed assumptions and remaining uncertainty.
4. **Transfer**: test where the model applies through near, medium, and—when justified—far scenarios, including mismatches, risks, and success checks.
5. **Output and practice**: produce an explanation, artifact, simulation, exercise, or real result that matches the intended mastery level.
6. **Feedback and iteration**: compare expected and observed performance, diagnose the first divergence, and return to the earliest stage that can repair it.
7. **Retrieval sidecar**: revisit high-value knowledge through recall, explanation, prediction, and fresh application instead of passive rereading.

The coach normally advances one bounded question or task at a time. A stage passes only when the available evidence satisfies its exit condition; a plan written entirely by the coach does not count as learner evidence.

## Example Invocations

Start a full learning cycle:

```text
Use $deep-study-coach to help me learn SQL in three weeks. My goal is to analyze our e-commerce order data independently, and I know Excel but have no database background.
```

Focus on one stage:

```text
Use $deep-study-coach to take me through closed-book reflection on Bayes' theorem. I have finished the material and can follow the examples.
```

Diagnose a learning failure:

```text
Use $deep-study-coach to diagnose this: I can recite the definition of JavaScript closures, but I cannot recognize or intentionally use them in real code.
```

Chinese is also fine:

```text
使用 $deep-study-coach 帮我制定并执行一个三周的 SQL 学习闭环，目标是独立分析公司电商订单数据。
```

```text
使用 $deep-study-coach 帮我诊断：我能背出闭包定义，但在真实代码中不会识别，也不知道何时应该主动使用。
```

## Learning Records

For a multi-session goal, ask the skill to create or maintain a learning record from its bundled template. The record tracks:

- The learning contract and acceptance criteria.
- Sources, units, expected outputs, and progress.
- Input evidence and unresolved questions.
- Closed-source reflection and model changes.
- Transfer hypotheses and boundary cases.
- Practice results, feedback diagnosis, and return-stage decisions.
- Retrieval prompts and next review points.

The record makes progress portable across conversations; the skill does not claim to remember state across unrelated sessions without such an artifact.

## Key Resources

- `skills/deep-study-coach/SKILL.md`: operating modes, learning cycle, interaction protocol, and guardrails.
- `skills/deep-study-coach/references/stage-checklists.md`: evidence checks, exit signals, and common failure patterns for every stage.
- `skills/deep-study-coach/references/feedback-diagnosis.md`: diagnostic protocol, return-stage matrix, confidence handling, and corrective probes.
- `skills/deep-study-coach/assets/learning-session-template.md`: reusable record for multi-session learning.

## Notes

- The workflow improves learning discipline but cannot guarantee mastery.
- It should not force the complete cycle onto quick fact lookup or casual exploration.
- Reflection, transfer, and practice are separate stages: rebuilding a model is not the same as recognizing a new application, and imagining an application is not proof that it works.
- Teaching or writing can validate conceptual organization, but operational, physical, or production skills also require representative practice.
- When source accuracy is time-sensitive or high stakes, current authoritative material should be verified separately.
