document.addEventListener('input', function(event) {
  const element = event.target;
  const computedElementStyle = window.getComputedStyle(element);
  const enteredText = element.value;
  const fontInComputedElementStyle = computedElementStyle.getPropertyValue('font');
  const emptyCanvasElement = document.createElement('canvas');
  const blank2dContext = emptyCanvasElement.getContext('2d');
  blank2dContext.font = fontInComputedElementStyle;

  // クラス属性値が｢adjust-entered-text-width｣であるフォームの幅を､入力した文字列の幅､に合わせて伸縮させる
  if (element.matches('.adjust-entered-text-width')) {
    const enteredTextWidth = blank2dContext.measureText(enteredText).width;
    const elementSidePadding = parseInt(computedElementStyle.getPropertyValue('padding-left')) + parseInt(computedElementStyle.getPropertyValue('padding-right'));
    const adjustedEnteredTextWidth = enteredTextWidth + elementSidePadding;
    element.style.width = adjustedEnteredTextWidth + 'px';
  }
});
