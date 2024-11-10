# 非官方 OUC 计算机实验报告 typst 模板

**本仓库非官方，使用者需自行承担风险。** 本仓库提供了一些自制的适用于中国海洋大学计算机学院实验报告的 typst 模板。

> [!IMPORTANT]  
> 对于不熟悉 typst 的用户，建议通过 [typst 中文社区导航](https://typst-doc-cn.github.io/guide/) 和 [小蓝书 Web 版](https://typst-doc-cn.github.io/tutorial/) 了解 typst 的基本使用方法。
> 一言以蔽之，使用 typst，你可以像写 Markdown 一样写 LaTeX 风格的文档。

## 使用方法

- 下载模板文件 `template.typ`，将其放置在你的实验报告文件夹中。
    > [!TIP]
    > 建议对于一门课程的实验报告，只使用一个文件夹，将模板放在根目录、实验报告放在子目录中以便管理。
- 在实验报告的开头使用 `#import "../template.typ": *` 导入模板。
- 见各个实验报告的 `example.typ` 文件以了解如何填入需要的参数。

## 快速跳转

`template.typ` 文件和 `example.pdf` 文件均位于各个文件夹中。

- 数据库系统：[template.typ](数据库系统/template.typ) | [example.pdf](数据库系统/example.pdf)

    | 预览 |
    |--|
    | ![example](assets/数据库系统.png) |

- 软件测试技术：[template.typ](软件测试技术/template.typ) | [example.pdf](软件测试技术/example.pdf) | [其余页面预览](assets/软件测试技术)

    | 封面 | 目录 | 正文 |
    |--|--|--|
    | ![example_cover](assets/软件测试技术/1.png) | ![example_toc](assets/软件测试技术/2.png) | ![example_body](assets/软件测试技术/3.png) |