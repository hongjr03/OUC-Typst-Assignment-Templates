#import "@preview/numbly:0.1.0": numbly


#let font = (main: "IBM Plex Serif", mono: "IBM Plex Mono", cjk: "Noto Serif CJK SC")
#let cjk-markers = regex("[“”‘’．，。、？！：；（）｛｝［］〔〕〖〗《》〈〉「」【】『』─—＿·…\u{30FC}]+")

// 标题，(小组成员), (结对小组成员), 日期
#let assign_cover(title, members, pairMembers, date) = {
  align(
    center,
    text(size: 36pt, weight: "bold")[
      #v(4em)
      软件测试技术实验报告
    ],
  )

  align(
    left,
    text(size: 20pt, weight: "medium")[
      #v(2em)
      #title
    ],
  )
  v(1fr)
  align(
    center,
    grid(
      columns: 2,
      align(right, text(size: 14pt)[小组成员：#box()]),
      align(
        left,
        (
          for member in members {
            text(size: 14pt)[
              #member.name（学号：#member.id）

            ]
          }
        ),
      ),
    ),
  )
  linebreak()
  if pairMembers == none { } else {
    align(
      center,
      grid(
        columns: 2,
        align(right, text(size: 14pt)[结对小组成员：#box()]),
        align(
          left,
          (
            for member in pairMembers {
              text(size: 14pt)[
                #member.name（学号：#member.id）

              ]
            }
          ),
        ),
      ),
    )
  }
  linebreak()
  align(
    center,
    text(size: 14pt)[
      完成日期：#date.display("[year]年[month padding:none]月[day padding:none]日")
    ],
  )

  pagebreak(weak: true)
}

#let assign_outline(title) = {
  set page(paper: "a4")

  show outline.entry.where(level: 1): it => {
    v(14pt, weak: true)
    text(size: 14pt)[#it]
  }

  align(center, text(28pt, weight: "bold")[实验目录])
  v(15pt)

  outline(title: none, depth: 1, indent: auto)
}

#let assign_class(title, author, members, pairMembers, date, body) = {
  set page(paper: "a4", margin: auto)
  set text(font: (font.main, font.cjk), lang: "zh", region: "cn")
  show cjk-markers: set text(font: font.cjk)

  set heading(
    numbering: numbly(
      "{1:一}、", // use {level:format} to specify the format
      "{2:1}.", // if format is not specified, arabic numbers will be used
      "({3:1})", // here, we only want the 3rd level
    ),
  )

  set document(title: title, author: author)
  set par(justify: true)
  show math.equation.where(block: true): it => block(width: 100%, align(center, it))

  set raw(tab-size: 4)
  show raw: set text(font: (font.mono, font.cjk))
  // Display inline code in a small box
  // that retains the correct baseline.
  show raw.where(block: false): box.with(fill: luma(240), inset: (x: 3pt, y: 0pt), outset: (y: 3pt), radius: 2pt)

  // Display block code in a larger block
  // with more padding.
  // and with line numbers.
  // Thank you @Andrew15-5 for the idea and the code!
  // https://github.com/typst/typst/issues/344#issuecomment-2041231063
  let style-number(number) = text(gray)[#number]
  show raw.where(block: true): it => {
    set par(justify: false)
    block(
      fill: luma(240),
      inset: 5pt,
      outset: 5pt,
      radius: 4pt,
      width: 100%,
      it,
    )
  }

  show link: it => {
    set text(fill: blue)
    underline(it)
  }

  set list(indent: 6pt)
  set enum(indent: 6pt)
  set enum(
    numbering: numbly(
      "{1:1}.",
      "{2:a})",
    ),
    full: true,
  )

  assign_cover(title, members, pairMembers, date)
  assign_outline(title)

  set page(
    paper: "a4",
    margin: auto,
    footer: [
      #set align(center)
      #set text(9pt)
      #context {
        counter(page).display("1")
      }
    ],
  )
  counter(page).update(1)
  // align(center, text(size: 21pt, weight: "bold", title))
  [
    #show heading: it => {
      set align(center)
      set text(size: 21pt, weight: "bold")
      it
    }
    #heading(numbering: none, depth: 1, title)
  ]
  show heading: set block(spacing: 1.2em)
  show heading.where(depth: 1): it => {
    show h.where(amount: 0.3em): none
    it
  }
  set text(size: 12pt)
  set par(first-line-indent: 2em)
  let fakepar = context {
    box()
    v(-measure(block() + block()).height)
  }
  show math.equation.where(block: true): it => it + fakepar // 公式后缩进
  show heading: it => it + fakepar // 标题后缩进
  show figure: it => it + fakepar // 图表后缩进
  show enum: it => it + fakepar
  show list: it => it + fakepar // 列表后缩进
  show grid: it => it + fakepar // 列表后缩进
  show raw.where(block: true): it => it + fakepar
  body
}

#let list(body) = {
  let fakepar = context {
    box()
    v(-measure(block() + block()).height)
  }
  grid(columns: (2em, 1fr))[][
    #body
  ]
  fakepar
}


// 实验名称，实验编号，开发者，模块名称，用例作者，参考信息，测试类型，设计日期，测试方法，测试日期，测试对象，前置条件
#let test_case_table(
  title: none,
  id: none,
  developer: none,
  module_name: none,
  use_case_author: none,
  reference: none,
  test_type: none,
  design_date: none,
  test_method: none,
  test_date: none,
  test_object: none,
  precondition: none,
  columns_width: (1.2fr, 1.2fr, 1.2fr, 1.4fr),
  is_operation: none,
  ..body,
) = (
  context {
    set text(size: 10.5pt)
    set table(
      align: center + horizon,
      // rows: 2em,
      inset: 6pt,
    )
    show figure: set block(breakable: true)

    figure(

      [
        #block(breakable: false, sticky: true)[
          #set text(number-width: "proportional")
          #show table.cell: it => {
            if it.x == 0 or it.x == 2 {
              strong(it)
            } else {
              it
            }
          }
          #table(
            columns: (1fr, 2fr, 1fr, 2fr),
            [实验名称], [#title], [实验编号], [#id],
            [开发人员], [#developer], [模块名称], [#module_name],
            [用例作者], [#use_case_author], [参考信息], [#reference],
            [测试类型], [#test_type], [设计日期], [#design_date.display("[year]年[month]月[day]日")],
            [测试方法], [#test_method], [测试日期], [#test_date.display("[year]年[month]月[day]日")],
            [测试对象], table.cell(colspan: 3)[#test_object],
            [前置条件], table.cell(colspan: 3)[#precondition],

          )]
        #v(0em, weak: true)
        #[
          #set text(number-width: "proportional", spacing: 150%)
          #show table.cell: it => {
            if it.y == 0 {
              strong(it)
            } else {
              it
            }
          }
          #table(
            columns: (1fr, ..columns_width),
            [用例编号], [
              #if is_operation == true {
                "操作"
              } else {
                "输入数据"
              }
            ], [预期结果], [实际结果], [备注],
            ..body,
          )]
      ],
      caption: test_method + "测试用例表",
    )

  }
)