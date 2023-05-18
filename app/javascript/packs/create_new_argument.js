// フォームの入力欄の幅を､入力した文字の幅に合わせて､伸縮させる
document.addEventListener('input', function(event) {
  const element = event.target;
  if (element.matches('.adjust-entered-text-width')) {
    const computed_element_style = window.getComputedStyle(element);
    const entered_text = element.value;
    const font_in_computed_element_style = computed_element_style.getPropertyValue('font');
    const empty_canvas_element = document.createElement('canvas');
    const blank_2d_context = empty_canvas_element.getContext('2d');
    blank_2d_context.font = font_in_computed_element_style;
    const entered_text_width = blank_2d_context.measureText(entered_text).width;
    const element_side_padding = parseInt(computed_element_style.getPropertyValue('padding-left')) + parseInt(computed_element_style.getPropertyValue('padding-right'));
    const adjusted_entered_text_width = entered_text_width + element_side_padding;
    element.style.width = adjusted_entered_text_width + 'px';
  }
});
