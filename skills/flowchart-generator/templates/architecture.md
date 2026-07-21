# Template: 架构图 / 信任边界

适合「两侧/两环境对比」的图，比如 OpenAI 平台侧 vs 客户环境、DMZ vs 内网等。

```mermaid
%%{init: {'flowchart': {'defaultRenderer': 'elk', 'padding': 30, 'nodeSpacing': 60}}}%%
flowchart LR
    classDef oaNode fill:#ffffff,stroke:#3B82F6,stroke-width:2px,color:#111827,rx:18,ry:18
    classDef cuNode fill:#ffffff,stroke:#10B981,stroke-width:2px,color:#111827,rx:18,ry:18

    subgraph OA["<b>OpenAI-managed side</b>"]
        direction TB
        EP["OpenAI-hosted<br/>tunnel endpoint"]:::oaNode
        TS["Tunnel service"]:::oaNode
    end
    style OA fill:#F0F7FF,stroke:#DBEAFE,stroke-width:1px,color:#1D4ED8

    subgraph CU["<b>Customer environment</b>"]
        direction TB
        TC["Customer-run<br/>tunnel client"]:::cuNode
        PS["Private MCP server"]:::cuNode
    end
    style CU fill:#F0FDF4,stroke:#D1FAE5,stroke-width:1px,color:#047857

    OA ~~~ EP ~~~ TS ~~~ CU

    EP -->|"<span class='badge'>1</span> request"| TS
    TS ==>|"<span class='badge'>2</span><span style='display:inline-block;padding-right:40px;background:rgb(255,255,255);'>client-initiated outbound HTTPS</span>"| TC
    TC <--> PS

    PS -. "<span class='return-text'>private MCP traffic</span>" .-> TC
```

**渲染**：

```bash
bash ~/.workbuddy/skills/flowchart-generator/scripts/render.sh \
  --input architecture.mmd \
  --output architecture.png \
  --width 2000
```

**调整**：
- 改分组标题：改 `subgraph` 的 title 字符串
- 改分组方向：`direction TB` / `direction LR`
- 中间加节点：在 `OA ~~~` 链里插入
