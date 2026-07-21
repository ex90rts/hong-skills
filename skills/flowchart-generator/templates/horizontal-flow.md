# Template: 水平流程图

适合有明确顺序的步骤流程（A → B → C → D）。

```mermaid
%%{init: {'flowchart': {'defaultRenderer': 'elk', 'padding': 30, 'nodeSpacing': 60}}}%%
flowchart LR
    classDef sysNode fill:#ffffff,stroke:#3B82F6,stroke-width:2px,color:#111827,rx:18,ry:18
    classDef okNode fill:#ffffff,stroke:#10B981,stroke-width:2px,color:#111827,rx:18,ry:18
    classDef errNode fill:#ffffff,stroke:#EF4444,stroke-width:2px,color:#111827,rx:18,ry:18

    A["开始"]:::sysNode -->|"<span class='badge'>1</span> 输入"| B["处理"]:::sysNode
    B -->|"<span class='badge'>2</span> 判断"| C{"通过?"}:::sysNode
    C -->|"<span class='badge'>3</span> yes"| D["成功"]:::okNode
    C -->|"<span class='badge'>4</span> no"| E["重试"]:::errNode
    E -. "<span class='return-text'>重新校验</span>" .-> B
```

**渲染**：

```bash
bash ~/.workbuddy/skills/flowchart-generator/scripts/render.sh \
  --input horizontal-flow.mmd \
  --output horizontal-flow.png \
  --width 1800
```

**调整**：
- 增加步骤：复制一行 `-->|"<span class='badge'>N</span> ..."|-->`
- 改变方向：`flowchart LR` → `flowchart TB`
- 增加分支：在菱形节点后加多个箭头
