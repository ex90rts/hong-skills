# Example 3: Trust Boundary（信任边界）

> 用户直接输入："画一个 OpenAI 安全隧道信任边界：OpenAI 管理侧包含 endpoint 和 tunnel service，客户环境包含 tunnel client 和 private MCP server。连接是 client-initiated outbound HTTPS，底部说明没有入站防火墙规则。"

## Mermaid 代码

```mermaid
%%{init: {'flowchart': {'defaultRenderer': 'elk', 'padding': 30, 'nodeSpacing': 60}}}%%
flowchart LR
    classDef oaNode fill:#ffffff,stroke:#3B82F6,stroke-width:2px,color:#111827,rx:18,ry:18
    classDef cuNode fill:#ffffff,stroke:#10B981,stroke-width:2px,color:#111827,rx:18,ry:18
    classDef noteNode fill:#F9FAFB,stroke:#E5E7EB,stroke-width:1px,color:#374151,rx:18,ry:18

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

    EP -->|"<span class='badge'>1</span>"| TS
    TS ==>|"<span class='badge'>2</span><span style='display:inline-block;padding-right:40px;background:rgb(255,255,255);'>client-initiated outbound HTTPS</span>"| TC
    TC <--> PS

    NOTE["No inbound firewall rule or public listener for the MCP server"]:::noteNode
    OA ~~~ NOTE
    NOTE ~~~ CU
```

## 渲染命令

```bash
bash ~/.workbuddy/skills/flowchart-generator/scripts/render.sh \
  --input trust-boundary.mmd \
  --output trust-boundary.png \
  --width 2200
```

## 设计要点

- **容器合理 padding**：`padding: 30, nodeSpacing: 60`，让分组标题和节点都不贴边，同时不过度撑大空白
- **长边标签远离容器**：用 `<span style='display:inline-block;padding-right:40px;...'>` 把文字往左侧推，避免贴到右侧容器
- **底部说明**：用普通节点 + 不可见边固定在两组中间下方
