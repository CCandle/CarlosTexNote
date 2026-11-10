# CarlosTexNote

面向中文学习笔记的 XeLaTeX 文档类。当前版本采用紧凑、复习导向的页面节奏，并提供五套可在 `main.tex` 中切换的语义配色主题。

- **XeLaTeX only**；基于 `ctexrep`，A4 双面排版。
- 单文件、自包含：只需 `CarlosTexNote.cls`，不依赖额外的主题 `.sty` 文件。
- 保留原有数学环境、交叉引用宏、图片路径和可选 `circuitikz` 支持。

## 快速开始

在 `main.tex` 中选择主题：

```latex
\documentclass[circuit,theme=ocean]{CarlosTexNote}
```

`circuit` 是可选项；`theme` 可选值如下：

| 参数 | 风格 | 主色 | 辅色 | 暖色 |
|---|---|---|---|---|
| `classic` | 经典、均衡 | 学术蓝 | 蓝绿色 | 琥珀金 |
| `ocean` | 清爽、对比鲜明 | 钴蓝 | 海洋青 | 琥珀金 |
| `forest` | 自然、柔和 | 森林绿 | 翡翠绿 | 暖金 |
| `sunset` | 温暖、有个性 | 珊瑚酒红 | 深青绿 | 琥珀金 |
| `violet` | 鲜明、辨识度高 | 紫罗兰 | 蓝绿色 | 古金 |

不写 `theme` 时默认为 `classic`。只需修改 `\documentclass` 选项，章节文件和 Snippet 无需改动。

```latex
\documentclass[circuit,theme=classic]{CarlosTexNote}
\documentclass[circuit,theme=ocean]{CarlosTexNote}
\documentclass[circuit,theme=forest]{CarlosTexNote}
\documentclass[circuit,theme=sunset]{CarlosTexNote}
\documentclass[circuit,theme=violet]{CarlosTexNote}
```

未知主题会产生明确的 LaTeX 错误，并列出可用主题。

## 安装

### 安装到 TEXMFHOME（推荐）

```bash
git pull
bash tools/install.sh
kpsewhich CarlosTexNote.cls
```

安装脚本会将唯一需要的类文件复制到：

```text
$(kpsewhich -var-value=TEXMFHOME)/tex/latex/carlostexnote/CarlosTexNote.cls
```

如果使用 macOS 默认 TeX Live，通常位于 `~/Library/texmf/tex/latex/carlostexnote/`。TEXMFHOME 无需运行 `texhash`。

### 项目内使用

也可以只把 `CarlosTexNote.cls` 复制到 `main.tex` 同级目录。没有 companion `.sty` 文件需要复制。

## 排版设计

- 正文字号保持小四（12 pt）；行距调整为 1.18 倍，段落采用紧凑节奏。
- A4 双面版心：内边距 24.5 mm、外边距 20.5 mm；上下边距约 19 mm。
- 不再全局强制行内公式使用 `\displaystyle`，避免分式、积分等撑高正文行距；展示公式仍由 `\[...\]`、`equation`、`align` 等环境控制。
- 标题层级：`\paragraph` 是编号的块级知识点标题；`\subparagraph` 是行内提示词/知识线索，适配现有 `para` 与 `spara` Snippet。
- 定义、定理采用轻量左侧色条；性质、推论使用紧凑标题；例题、解答和提示块采用不同语义色，不再把每个知识点都包成完整圆角卡片。
- 主题只改变语义色板，不改变颜色的含义：深色用于章标题/定理，主色用于节标题/定义，青色用于关键词/性质，暖色用于例题/总结/闭卷提取，红色用于易错警示。
- 浅色背景和正文墨色在所有主题中保持克制，兼顾屏幕阅读与普通打印。

## 标题页与目录

原有写法继续有效：

```latex
\maketitle
\tableofcontents
```

也提供可选的紧凑前置页命令 `\notefrontmatter`，将标题块与目录放在同一页：

```latex
\begin{document}
\notefrontmatter
\chapter{函数与极限}
...
\end{document}
```

## 内置数学环境与提示块

| 中文 | 环境 | 编号 | 现有 UltiSnips |
|---|---|---|---|
| 定义 | `definition` | 按章独立编号 | `def` |
| 定理 | `theorem` | 按章独立编号 | `thm` |
| 性质 | `property` | 按章独立编号 | `prp` |
| 推论 | `corollary` | 按章独立编号 | `cor` |
| 引理 | `lemma` | 按章独立编号 | `lem` |
| 命题 | `proposition` | 按章独立编号 | `pro` |
| 例题 | `example` | 按章独立编号 | `eg` |
| 解答 | `solution` | 不编号 | `sol` |
| 注 | `remark` | 不编号 | `rem` |
| 证明 | `proof` | 不编号 | `pf` |
| 重点 | `keybox` | 不编号 | `key` |
| 易错 | `warningbox` | 不编号 | `warn` / `mist` |
| 方法 | `methodbox` | 不编号 | `mthd` |
| 小结 | `summarybox` | 不编号 | `smry` |
| 闭卷提取 | `recallbox` | 不编号 | `recall` |

提示块均支持可选标题：

```latex
\begin{recallbox}[闭卷提取]
不看笔记，能否复述定理的条件、结论和适用边界？
\end{recallbox}
```

## 常用宏

| 宏 | 含义 |
|---|---|
| `\keyword{...}` | 行内强调关键词，继承当前主题的 Teal 色 |
| `\cue{...}` | 灰色无衬线知识线索 |
| `\d` | 数学模式下输出直立微分 d；文本模式保留原重音命令 |
| `\R \N \Z \Q \C \O` | 实数集、自然数集、整数集、有理数集、复数集、空集 |
| `\rank`、`\diag` | 秩、对角矩阵算子 |
| `\cnoteheader` | 标题块左上角文字，默认“学习笔记” |
| `\qedsymbol` | 证明结束符号，默认实心方块 |

课程专用宏（例如电力电子笔记中的 `\Uph`、`\phas`）仍建议放在笔记工程自己的 `macro.tex`，不要写进类文件。

## 图片路径

默认搜索 `img/`、`fig/`、`pic/`：

```latex
\includegraphics[width=0.8\textwidth]{example.pdf}
```

浮动体不要放进 `tcolorbox` 内部；盒子内直接使用 `tikzpicture`。需要图号时，把 `figure` 放在盒子外。

## 配色样张

统一内容的主题预览源文件位于 `demo/theme-showcase.tex`。在仓库根目录执行：

```bash
bash tools/build-theme-showcase.sh
```

脚本会分别编译五套主题，输出到 `build/theme-showcase/<theme>/main.pdf`。需要 TeX Live、XeLaTeX 和 latexmk。

## 目录结构

```text
CarlosTexNote/
├── CarlosTexNote.cls
├── main.tex
├── README.md
├── LICENSE
├── demo/
│   └── theme-showcase.tex
└── tools/
    ├── install.sh
    └── build-theme-showcase.sh
```

## 与 CarlosTexRpt / CarlosTexArt 的关系

`CarlosTexNote` 是独立、自包含的笔记类，不加载 `CarlosTexRpt` 或 `CarlosTexArt`，互不影响。视觉延续原有 Carlos 系列的学术蓝色基调，但将盒子、版心、段落节奏和主题切换针对学习/复习场景重新整理。

## 版本

- **v0.2.0**：紧凑复习版式、五套可切换语义配色、闭卷提取块；保留原数学宏、定理环境、交叉引用与 `circuit` 选项。
- **v0.1.0**：初始 MVP，提供数学环境、盒子、编号、图片路径与宏契约。

## License

MIT。视觉与部分设置来自同作者的 CarlosTexRpt / CarlosTexArt.
