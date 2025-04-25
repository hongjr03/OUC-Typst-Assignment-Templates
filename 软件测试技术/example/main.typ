#import "../template.typ": *

#let title = "实验 4：黑盒测试 1"
#let author = "张三"
#let members = (
  (name: "张三", id: "22010002034"),
  (name: "李四", id: "22560078090"),
)
#let pairMembers = none
#let date = datetime(
  year: 2024,
  month: 11,
  day: 5,
)

#show: assign_class.with(title, author, members, pairMembers, date)

= 实验目的

能熟练应用黑盒测试技术进行测试用例设计，能对测试用例进行优化设计。

= 实验内容

格莱美奖（Grammy Awards），是由美国国家科学院录音艺术与科学学院于1958年主办的音乐类奖项。格莱美奖与电影类的奥斯卡金像奖、电视类的艾美奖、戏剧类的托尼奖共称为美国年度四大娱乐奖项。格莱美奖涵盖流行、摇滚、R&B、说唱、乡村、福音、爵士、拉丁、古典等音乐类型，由专业人士投票决定奖项获得者。格莱美奖最重要的奖项为四大通类（综合类）奖项：年度专辑奖、年度制作奖、年度歌曲奖和最佳新人奖。


= 实验要求

- 根据题目要求分析原因和结果，并绘制因果图，表明约束关系，最终形成判定表。
- 根据写出的判定表设计该问题的测试用例，并检验测试结果。


= 实验过程及重点内容

=== 程序代码

#[
  #set text(size: 9pt)
  #raw(block: true, lang: "py", read("main.py"))
]

=== 流程图

#figure(image("flowchart.png", width: 59%))

== 测试用例设计

根据题目要求，我们设计了如下的因果图判定表：

#[
  #show table.cell: it => {

    if it.y == 0 or it.x < 2 {
      strong(it)
    } else {
      it
    }

  }

  // 如需合并单元格，可使用以下代码，并在 csv 文件中使用 "<spanned>" 标记
  #let cellinfo = (
    // (row, col, rowspan, colspan)
    (0, 0, 1, 2),
    (1, 0, 7, 1),
    (8, 0, 4, 1),
  )

  #let dat = csv("table.csv")

  #let prepdat(csvdat, cellinfo) = {

    for (r, c, rs, cs) in cellinfo {
      csvdat.at(r).at(c) = table.cell(csvdat.at(r).at(c), colspan: cs, rowspan: rs)
    }
    csvdat.at(1).insert(0, table.hline(stroke: 0.5pt))
    csvdat.at(7).insert(0, table.hline(stroke: 0.5pt))
    csvdat.at(8).insert(0, table.hline(stroke: 0.5pt))
    csvdat.at(1).insert(2, table.vline(stroke: 0.5pt, start: 1))
    csvdat.at(0).insert(1, table.vline(stroke: 0.5pt))
    // csvdat.at(0).insert(2, table.vline(stroke: 0.5pt))

    let filter_func(item) = {
      item != "<spanned>"
    }

    let csvflat = csvdat.flatten()
    csvflat = csvflat.filter(filter_func)
    return csvflat.flatten()
  }
  // #header_parse(dat)
  #figure(
    [
      #set text(size: 8pt)
      #table(
        columns: (2em, 3em) + (3em,) * 5,
        rows: (2em),
        stroke: none,
        align: center + horizon,
        table.hline(),
        ..prepdat(dat, cellinfo),
        table.hline(),
      )
    ],
    caption: "判定表",
  )
  // #prepdat(dat, cellinfo)
]

据此，可以设计测试用例：

#test_case_table(
  title: title,
  id: "20241101-1",
  developer: "kaifazhe",
  module_name: "/",
  use_case_author: "me",
  reference: "课堂讲义",
  test_type: "黑盒测试",
  design_date: datetime(year: 2024, month: 11, day: 1),
  test_method: "因果图",
  test_date: datetime(year: 2024, month: 11, day: 5),
  test_object: "饮料自动售货机程序",
  precondition: "/",
  columns_width: (2fr, 1.1fr, 1.1fr, 0.8fr),
  [CE1], [投入 5 角硬币，按下啤酒按钮，无零钱指示灯亮], [送出啤酒], [送出啤酒], [],
  [...], [...], [...], [...], [],
)


= 实验结果

对结对小组程序进行测试，测试过程如下。

== 初始化

结对小组的程序使用了 GUI 界面，首先是初始化过程，输入初始化零钱（即 5 角钱）的数量。如果没有输入初始化零钱或尝试跳过初始化，则会直接抛出错误。




== 根据因果图测试

由于初始状态下售货机有零钱，所以先使用“无零钱指示灯灭”的几组测试用例 CE2、CE4、CE5 进行测试。

经过以上3个用例的测试，此时售货机零钱恰被消耗完，可以测试剩下的两个用例 CE1、CE3。

== 程序评估

在结对小组的程序通过了所有的根据因果图设计的测试用例，说明对于输入条件的各种组合情况程序均能很好地执行并给出正确的结果。

= 实验中遇到的问题、难点及解决方案

+ *程序设计*\
  虽然要实现的程序并不复杂，但仍然在自测过程中发现了许多程序设计没有考虑好的逻辑问题。
= 感想和收获

通过本次实验，我们对黑盒测试技术有了更深入的了解，掌握了因果图的绘制方法，学会了如何根据因果图设计测试用例。

= 小组分工情况
- 张三：负责程序设计、测试用例设计、实验报告撰写
- 李四：负责程序设计、测试用例设计、实验报告撰写
