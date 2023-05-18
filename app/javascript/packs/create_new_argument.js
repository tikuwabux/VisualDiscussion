document.addEventListener('input', function(event) {
  const element = event.target;
  const computed_element_style = window.getComputedStyle(element);
  const entered_text = element.value;
  const font_in_computed_element_style = computed_element_style.getPropertyValue('font');
  const empty_canvas_element = document.createElement('canvas');
  const blank_2d_context = empty_canvas_element.getContext('2d');
  blank_2d_context.font = font_in_computed_element_style;

  // 改行不可能なフォームの場合､その幅を､入力した文字列の幅､に合わせて伸縮させる
  if (element.matches('.adjust-entered-text-width')) {
    const entered_text_width = blank_2d_context.measureText(entered_text).width;
    const element_side_padding = parseInt(computed_element_style.getPropertyValue('padding-left')) + parseInt(computed_element_style.getPropertyValue('padding-right'));
    const adjusted_entered_text_width = entered_text_width + element_side_padding;
    element.style.width = adjusted_entered_text_width + 'px';
  }

  // 改行可能なフォームの場合､その幅を､最大幅の文字列を含む行の幅､に合わせて伸縮させる
  // (3行目以降､最終行に謎の空行が出現する不具合あり)
  if (element.matches('.adjust-max-line-width')) {
    const lines = entered_text.split('\n');
    let max_line_width = 0;
    lines.forEach(function(line) {
      const line_width = blank_2d_context.measureText(line).width;
      if (line_width > max_line_width) {
        max_line_width = line_width;
      }
    });
    const element_side_padding = parseInt(computed_element_style.getPropertyValue('padding-left')) + parseInt(computed_element_style.getPropertyValue('padding-right'));
    const adjusted_entered_text_width = max_line_width + element_side_padding;
    element.style.width = adjusted_entered_text_width + 'px';
  }
});
