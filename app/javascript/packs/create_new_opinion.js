document.addEventListener('input', function(event) {
  const element = event.target;
  const computedElementStyle = window.getComputedStyle(element);
  const enteredText = element.value;
  const fontInComputedElementStyle = computedElementStyle.getPropertyValue('font');
  const emptyCanvasElement = document.createElement('canvas');
  const blank2dContext = emptyCanvasElement.getContext('2d');
  blank2dContext.font = fontInComputedElementStyle;

  // 改行不可能なフォームの場合､その幅を､入力した文字列の幅､に合わせて伸縮させる
  if (element.matches('.adjust-entered-text-width')) {
    const enteredTextWidth = blank2dContext.measureText(enteredText).width;
    const elementSidePadding = parseInt(computedElementStyle.getPropertyValue('padding-left')) + parseInt(computedElementStyle.getPropertyValue('padding-right'));
    const adjustedEnteredTextWidth = enteredTextWidth + elementSidePadding;
    element.style.width = adjustedEnteredTextWidth + 'px';
  }

  // 改行可能なフォームの場合､その幅を､最大幅の文字列を含む行の幅に､その高さを全行の高さに合わせて伸縮させる｡
  // (3行目以降､最終行に謎の空行が出現する不具合あり)
  if (element.matches('.adjust-entered-text-size')) {
    const lines = enteredText.split('\n');
    let maxLineWidth = 0;
    lines.forEach(function(line) {
      const lineWidth = blank2dContext.measureText(line).width;
      if (lineWidth > maxLineWidth) {
        maxLineWidth = lineWidth;
      }
    });
    const elementSidePadding = parseInt(computedElementStyle.getPropertyValue('padding-left')) + parseInt(computedElementStyle.getPropertyValue('padding-right'));
    const adjustedEnteredTextWidth = maxLineWidth + elementSidePadding;
    element.style.width = adjustedEnteredTextWidth + 'px';
    element.style.height = "auto"; // この一行が無いと､文字を入力するたびに､入力があったtextareaの高さが不要に伸びる
    element.style.height = `${element.scrollHeight}px`;
  }
});
