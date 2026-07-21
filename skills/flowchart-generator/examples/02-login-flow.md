# Example 2: 自然语言 → 登录流程

> 用户输入："画一个用户登录流程：用户输入用户名密码 → 提交到后端 → 后端查数据库 → 校验成功就生成 JWT 返回前端，失败就返回 401 + 错误提示。"

## LLM 翻译后的 Mermaid

```mermaid
%%{init: {'flowchart': {'defaultRenderer': 'elk', 'padding': 30, 'nodeSpacing': 60}}}%%
flowchart LR
    classDef sysNode fill:#ffffff,stroke:#3B82F6,stroke-width:2px,color:#111827,rx:18,ry:18
    classDef okNode fill:#ffffff,stroke:#10B981,stroke-width:2px,color:#111827,rx:18,ry:18
    classDef errNode fill:#ffffff,stroke:#EF4444,stroke-width:2px,color:#111827,rx:18,ry:18
    classDef storeNode fill:#ffffff,stroke:#8B5CF6,stroke-width:2px,color:#111827,rx:18,ry:18

    U(["用户"]):::sysNode
    FE["前端登录页"]:::sysNode
    API["后端 API"]:::sysNode
    DB[("数据库")]:::storeNode
    D{"校验通过?"}:::sysNode
    OK["返回 JWT"]:::okNode
    ERR["返回 401"]:::errNode

    U -->|"<span class='badge'>1</span> 输入账号"| FE
    FE -->|"<span class='badge'>2</span> 提交表单"| API
    API -->|"<span class='badge'>3</span> 查询数据库"| DB
    DB -->|"<span class='badge'>4</span> 返回结果"| API
    API -->|"<span class='badge'>5</span> 判断结果"| D
    D -->|"<span class='badge'>6</span> yes"| OK
    D -->|"<span class='badge'>7</span> no"| ERR
```

## 渲染命令

```bash
bash ~/.workbuddy/skills/flowchart-generator/scripts/render.sh \
  --input login-flow.mmd \
  --output login-flow.png \
  --width 2200
```

## 设计要点

- 蓝色：系统组件
- 绿色：成功分支
- 红色：失败分支
- 紫色：数据存储（数据库）
- 数字 1-7 标记主流程
- 菱形节点表示判断
