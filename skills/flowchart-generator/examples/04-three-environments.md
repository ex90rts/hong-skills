# Example 4: Same loop in three environments

> 用户直接输入："画一个三列环境对比图：Laptop、Kubernetes、VM / private network，每个环境里都有 Private MCP server 和 tunnel-client，三者都连到 OpenAI products。底部还有一个 Codex plugin 说明节点。"

## Mermaid 代码

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

## 渲染命令

```bash
bash ~/.workbuddy/skills/flowchart-generator/scripts/render.sh \
  --input three-environments.mmd \
  --output three-environments.png \
  --width 2400
```

## 设计要点

- **三列环境**：每个环境一个 `subgraph`，方向 `TB`
- **不可见边保持水平顺序**：`C1 ~~~ C2 ~~~ C3`
- **统一顶部说明节点**：用浅蓝背景节点放在底部说明文案
