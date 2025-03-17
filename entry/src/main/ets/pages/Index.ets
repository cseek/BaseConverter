@Entry
@Component
struct Index {
  @State inputValue: string = '';
  @State fromBase: number = 10;
  @State toBase: number = 2;
  @State result: string = '';
  @State errorMessage: string = '';

  private baseOptions: string[] = ['二进制 (2)', '八进制 (8)', '十进制 (10)', '十六进制 (16)'];
  private baseValues: number[] = [2, 8, 10, 16];

  build() {
    Column() {
      // 上部内容区域（占屏幕3/4）
      Column({ space: 10 }) {
        Text('进制转换器')
          .fontSize(40)
          .margin({ bottom: 10, top: 30 })
        // 输入框
        TextInput({ placeholder: '请输入数值（如255）' })
          .width('90%')
          .height(50)
          .fontSize(18)
          .margin({ bottom: 40, top: 40})
          .backgroundColor(Color.White)
          .borderRadius(8)
          .onChange((value: string) => {
            this.inputValue = value;
            this.errorMessage = '';
          })

        // 进制选择器行
        Row() {
          Column() {
            Text('原进制:')
              .fontSize(16)
              .margin({ bottom: 40 })

            TextPicker({ range: this.baseOptions })
              .width('100%')
              .selectedIndex(this.baseValues.indexOf(this.fromBase))
              .onChange((value: string | string[], index: number | number[]) => {
                const selectedIndex = Array.isArray(index) ? index[0] : index;
                this.fromBase = this.baseValues[selectedIndex];
              })
          }
          .width('45%')
          .margin({ right: '5%' })

          Column() {
            Text('目标进制:')
              .fontSize(16)
              .margin({ bottom: 40 })

            TextPicker({ range: this.baseOptions })
              .width('100%')
              .selectedIndex(this.baseValues.indexOf(this.toBase))
              .onChange((value: string | string[], index: number | number[]) => {
                const selectedIndex = Array.isArray(index) ? index[0] : index;
                this.toBase = this.baseValues[selectedIndex];
              })
          }
          .width('45%')
        }
        .width('90%')
        .height(200)
      }
      .width('100%')
      .height('65%') // 占据屏幕3/4高度
      .justifyContent(FlexAlign.Start)

      // 下部操作区域（占屏幕1/4）
      Column() {
        Button('转换')
          .width('70%')
          .height(50)
          .fontSize(20)
          .backgroundColor('#007AFF')
          .fontColor(Color.White)
          .margin({ bottom: 10, top: 15 })
          .onClick(() => this.convert())

        Text(this.result)
          .fontSize(24)
          .fontColor(Color.Blue)
          .margin({ bottom: 5 })

        Text(this.errorMessage)
          .fontSize(16)
          .fontColor(Color.Red)
      }
      .width('100%')
      .height('25%') // 精确控制为屏幕1/4高度
      .justifyContent(FlexAlign.Center)

      Text('＿_＿_＿_＿_＿_＿_＿_＿_＿_＿_＿_＿_＿_＿_')
        .height('3%')
        .fontSize(10)
        .margin({ bottom: 0, top: 30 })

      Text('熊仔, https://www.cseek.github.io')
        .height('7%')
        .fontSize(13)
        .margin({ bottom: 3, top: 0})

    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#F5F5F5')
  }

  convert() {
    if (!this.inputValue) {
      this.errorMessage = '请输入数值';
      return;
    }

    try {
      const decimalValue = parseInt(this.inputValue, this.fromBase);
      if (isNaN(decimalValue)) throw new Error();
      this.result = decimalValue.toString(this.toBase).toUpperCase();
      this.errorMessage = '';
    } catch {
      this.errorMessage = '输入值不合法';
      this.result = '';
    }
  }
}