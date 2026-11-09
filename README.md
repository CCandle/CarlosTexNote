# CarlosTexNote

面向中文学习笔记的 XeLaTeX 文档类：紧凑版式、彩色定理盒子、markdown 风格的 callout 提示块。

视觉沿袭 [CarlosTexRpt](https://github.com/CCandle/CarlosTexRpt)，定理类盒子的组织参考 `carlosreport` 与 Obsidian callout。固定使用 XeLaTeX。

## 特性

- 基于 `ctexrep`：`chapter` 为顶层、每章另起页、双面排版（`twoside, openany`）
- 标题层级：`\paragraph` 是带编号的 run-in 小标题；`\subparagraph` 是"行首关键词"
  （run-in、无额外段前距，行距与正文一致，笔记里用 UltiSnips 的 `spara` 触发）
- 内置数学笔记环境：定义、定理、性质、推论、引理、命题、注、例题、解答、证明，按章编号，支持 `\autoref`
- 四个非编号 callout：`keybox`、`warningbox`、`methodbox`、`summarybox`
- 图片默认从 `img/`、`fig/`、`pic/` 三个目录查找
- 宏契约：`\d`（直立微分 d）、`\R \N \Z \Q \C \O`
- 可选 `[circuit]` 类选项加载 circuitikz（矩形电阻、线圈电感）

## 快速开始

`CarlosTexNote.cls` 有两种用法，任选其一：

1. 复制到笔记工程目录（与 `main.tex` 同级）；
2. 安装到 TEXMFHOME：`bash tools/install.sh`。

最小示例：

```latex
\documentclass{CarlosTexNote}

\title{高等数学笔记}
\author{Carlos QU}
\date{\today}

\begin{document}
\maketitle
\tableofcontents

\chapter{函数与极限}
\begin{theorem}[夹逼定理]
  ...
\end{theorem}
\begin{proof}
  ...
\end{proof}
\begin{example}[2024 数一 T3]
  ...
\end{example}
\begin{solution}
  ...
\end{solution}
\begin{keybox}
  ...
\end{keybox}

\end{document}
```

编译：

```bash
latexmk -xelatex -synctex=1 -interaction=nonstopmode -file-line-error -outdir=build main.tex
```

## 环境

| 中文 | 环境名 | 编号 | UltiSnips 触发词 |
| --- | --- | --- | --- |
| 定义 | `definition` | 按章，独立计数器 | `def` |
| 定理 | `theorem` | 按章，独立计数器 | `thm` |
| 性质 | `property` | 按章，独立计数器 | `prp` |
| 推论 | `corollary` | 按章，独立计数器 | `cor` |
| 引理 | `lemma` | 按章，独立计数器 | `lem` |
| 命题 | `proposition` | 按章，独立计数器 | `pro` |
| 注 | `remark` | 不编号 | `rem` |
| 例题 | `example` | 按章，独立计数器 | `eg` |
| 解答 | `solution` | 不编号，紧贴例题 | `sol` |
| 例题 + 解答 | 两个环境连排 | — | `egs` |
| 证明 | `proof` | 不编号 | `pf` |
| 重点 | `keybox` | 不编号 | `key` |
| 易错 | `warningbox` | 不编号 | `warn` |
| 方法 | `methodbox` | 不编号 | `mthd` |
| 小结 | `summarybox` | 不编号 | `smry` |

带标题参数的写法：`\begin{theorem}[洛必达法则] ... \end{theorem}`，编号会自动变成“定理 1.1 洛必达法则”。标题留空时只显示编号。

示例引用：

```latex
\begin{theorem}[介值定理]\label{thm:ivt}
  ...
\end{theorem}

由\autoref{thm:ivt}可知，...
```

## 常用宏

| 宏 | 含义 |
| --- | --- |
| `\d` | 直立微分 d，例如 `\frac{\d u}{\d x}`；文本模式仍保留原来的重音命令 |
| `\R \N \Z \Q \C \O` | 实数集、自然数集、整数集、有理数集、复数集、空集 |
| `\rank` `\diag` | 秩、对角矩阵算子（amsmath 的 `\operatorname`） |
| `\cnoteheader` | 标题块左上角文字，默认“学习笔记”，可用 `\renewcommand` 修改 |
| `\qedsymbol` | 证明结束符号，默认实心方块 |

课程专用宏（例如电分笔记的 `\Uph`、`\phas`）建议写在笔记工程的 `macro.tex` 里，不要放进类文件。

## 图片路径

类文件已经设置：

```latex
\graphicspath{{img/}{fig/}{pic/}}
```

因此图片放进 `img/`、`fig/` 或 `pic/` 后，`\includegraphics` 直接写文件名即可。注意浮动体不能放进盒子内部；盒子里的图直接写 `tikzpicture`，需要编号时把图放在盒子外的 `figure` 环境中。

## 目录结构

```text
CarlosTexNote/
├── CarlosTexNote.cls
├── main.tex              # 最小示例
├── README.md
├── LICENSE
├── tools/install.sh      # 安装到 TEXMFHOME
└── .vscode/settings.json # VS Code + LaTeX Workshop
```

## 与 CarlosTexRpt / CarlosTexArt 的关系

- `CarlosTexRpt`：紧凑工程报告，视觉来源；
- `CarlosTexArt`：科技论文模板，`autoref` 中文名、按章编号等约定来源；
- `CarlosTexNote` 是独立自包含的类，不加载上面两个类，互不影响。

## 版本

v0.1.0（MVP）：环境、盒子、编号、图片路径、宏契约。后续按实际使用再补复习类功能。

## License

MIT。视觉与部分设置来自同作者的 CarlosTexRpt / CarlosTexArt。
