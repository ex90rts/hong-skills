# Template: 三列并排

适合展示「同一份逻辑在 3 个环境同时运行」的图（参考 OpenAI 的 "Same local loop, anywhere"）。

```mermaid
%%{init: {'flowchart': {'defaultRenderer': 'elk', 'padding': 30, 'nodeSpacing': 60}}}%%
flowchart LR
    classDef envNode fill:#ffffff,stroke:#6B7280,stroke-width:1.5px,color:#111827,rx:18,ry:18
    classDef targetNode fill:#ffffff,stroke:#3B82F6,stroke-width:2px,color:#1D4ED8,rx:18,ry:18
    classDef topBar fill:#F0F7FF,stroke:#DBEAFE,stroke-width:1px,color:#1D4ED8,rx:18,ry:18

    subgraph C1["<b>Laptop</b>"]
        direction TB
        S1["Private MCP server"]:::envNode
        CL1["tunnel-client"]:::envNode
        S1 <--> CL1
    end
    style C1 fill:#F9FAFB,stroke:#E5E7EB,stroke-width:1px,color:#374151

    subgraph C2["<b>Kubernetes</b>"]
        direction TB
        S2["Private MCP server"]:::envNode
        CL2["tunnel-client"]:::envNode
        S2 <--> CL2
    end
    style C2 fill:#F9FAFB,stroke:#E5E7EB,stroke-width:1px,color:#374151

    subgraph C3["<b>VM / private network</b>"]
        direction TB
        S3["Private MCP server"]:::envNode
        CL3["tunnel-client"]:::envNode
        S3 <--> CL3
    end
    style C3 fill:#F9FAFB,stroke:#E5E7EB,stroke-width:1px,color:#374151

    TOP["<b>Codex plugin</b> generates reusable tunnel-client config"]:::topBar
    T([OpenAI products]):::targetNode

    C1 ~~~ C2 ~~~ C3
    CL1 & CL2 & CL3 --> T
```

**渲染**：

```bash
bash ~/.workbuddy/skills/flowchart-generator/scripts/render.sh \
  --input three-columns.mmd \
  --output three-columns.png \
  --width 2200
```

**调整**：
- 增减列：复制/删除整个 `subgraph` 块
- 顶部/底部说明：改 `TOP` 节点的文字
