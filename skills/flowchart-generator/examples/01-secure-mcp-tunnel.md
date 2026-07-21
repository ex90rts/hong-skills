# Example 1: Secure MCP Tunnel（复刻参考图）

> 用户直接输入："画一个 OpenAI 安全 MCP Tunnel 生命周期：OpenAI 产品 → endpoint → Tunnel Service → customer client → Private MCP server，响应沿同一隧道返回。"

## Mermaid 代码

```mermaid
%%{init: {'flowchart': {'defaultRenderer': 'elk', 'padding': 30, 'nodeSpacing': 60}}}%%
flowchart LR
    classDef oaNode fill:#ffffff,stroke:#3B82F6,stroke-width:2px,color:#111827,rx:18,ry:18
    classDef cuNode fill:#ffffff,stroke:#10B981,stroke-width:2px,color:#111827,rx:18,ry:18

    subgraph OpenAI["<b>OpenAI products</b>"]
        direction TB
        P1["ChatGPT"]:::oaNode
        P2["Codex"]:::oaNode
        P3["Responses API"]:::oaNode
    end
    style OpenAI fill:#F0F7FF,stroke:#DBEAFE,stroke-width:1px,color:#1D4ED8

    E["OpenAI-hosted<br/>tunnel endpoint"]:::oaNode
    TS["Tunnel Service<br/>queues MCP work"]:::oaNode

    subgraph Customer["<b>Customer Secure Environment</b>"]
        direction TB
        C["customer-run<br/>tunnel client"]:::cuNode
        D["Private<br/>MCP server"]:::cuNode
    end
    style Customer fill:#F0FDF4,stroke:#D1FAE5,stroke-width:1px,color:#047857

    OpenAI ~~~ E ~~~ TS ~~~ Customer

    P1 & P2 & P3 -->|"<span class='badge'>1</span> MCP request"| E
    E -->|"<span class='badge'>2</span> Queue MCP work"| TS
    TS <-->|"<span class='badge'>3</span> queued JSON-RPC"| C
    C -->|"<span class='badge'>4</span> local MCP call"| D

    D -. "<span class='return-text'>response returns through same tunnel</span>" .-> C
    C -.-> TS
    TS -.-> E
    E -.-> OpenAI
```

## 渲染命令

```bash
bash ~/.workbuddy/skills/flowchart-generator/scripts/render.sh \
  --input secure-mcp-tunnel.mmd \
  --output secure-mcp-tunnel.png \
  --width 2600
```

## 设计要点

- **ELK 布局器**：保证 OpenAI 组、中间节点、Customer 组水平排列
- **白底节点 + 彩色边框**：OpenAI 蓝 / 客户绿，符合参考图
- **浅色分组背景**：OpenAI `#F0F7FF`，Customer `#F0FDF4`
- **圆形数字徽章**：`<span class='badge'>` 由 CSS 渲染为蓝底白字圆
- **虚线返回路径**：绿色文字 + 绿色虚线
